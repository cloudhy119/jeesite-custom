<%--
  Created by IntelliJ IDEA.
  User: huangyun
  Date: 2018/05/07
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>Title</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript" src="${ctxStatic}/tableExport/tableExport.js"></script>
    <script src="${ctxStatic}/js/ccgx.js" type="text/javascript"></script>
    <script src="${ctxStatic}/js/ccgx.table2excel.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            //检查是否选择了收费站
            var station = '${station.tsCode}';
            if(!station) {
                top.$.jBox.tip("请先选择收费站！", 'warning');
                return false;
            }
            //datatables
            var datatable = $('#table-report').DataTable( {
                //columnDefs: [{ "orderable": false, "targets": [0] }] //指定不排序的列
                //计算合计值
                "footerCallback": function( tfoot, data, start, end, display ) { //footer回调函数
                    $(tfoot).find('th').each(function(index) {
                        if(index > 1) { //计算第2列往后所有数据的合计结果
                            var total = 0;
                            $(data).each(function() {
                                total = basicCalculate.add(total, this[index]);
                            });
                            if(index == 2) { //车辆数（线圈统计）
                                total = total + "（含ETC：" + basicCalculate.add(total, ${etcXCarTotal[0]['ACT_CARS']}) + "）";
                            }
                            $(this).html(total);
                        }
                    });
                }
            } );
            $('#datatableSearch').on( 'keyup', function () {
                datatable.search( this.value ).draw();
            } );

            $('#table-report tbody').on('click', 'tr', function () {
                var tdCount = $('#table-report thead tr').find('th').length;
                if($('#table-report tbody tr :first').find('td').length != tdCount) { //说明表中无数据，不触发事件
                    return;
                }
                var row = $(this);
                var tcCode = row.find("input[name='tcCode']").val();
                if(tcCode == undefined || tcCode == '') {
                    // top.$.jBox.error('无数据');
                    return;
                }
                var thisDutyData = row.parent().find('tr.duty-data-' + tcCode);
                if(thisDutyData && thisDutyData.length > 0) {
                    thisDutyData.remove();
                } else {
                    $.ajax({
                        url: '${ctx}/shiftcheck/report/mtcXCarAjax',
                        type: 'GET',
                        dataType: "JSON",
                        data: {
                            'tcCode': tcCode,
                            'selectDateStr': $("#selectDateStr").val(),
                            'shiftturn': $("#shiftturn").val()
                        },
                        error: function() {
                            top.$.jBox.error('数据查询出错');
                        },
                        success: function( data ){
                            data = eval(data);
                            var trHtml = "";
                            var dataSize = data.length;
                            if(dataSize > 0) {
                                $(data).each(function() {
                                    var total_money = basicCalculate.add(this['RECEIVABLE_CASH'], this['RECEIVABLE_NOT_CASH']);
                                    total_money = basicCalculate.add(total_money, this['RECEIVABLE_MOBILE_CASH']);
                                    trHtml = trHtml + "<tr class='duty-data-" + tcCode + "' style='font-style:italic;color:gray;background-color: #FFFACD'>";
                                    trHtml = trHtml +
                                        "<td colspan='2'>" +
                                            "[" + new Date(this['LoginTime']).Format('HH:mm:ss') + "-" +
                                            new Date(this['LogoutTime']).Format('HH:mm:ss') + "]&nbsp;车道：" +
                                            this['DW_Number'] +
                                        "</td>" +
                                        "<td>" + this['COILS'] + "</td>" +
                                        "<td>" + this['ACT_CARDS'] + "</td>" +
                                        "<td>" + this['VAT_INVOICE_CARS'] + "</td>" +
                                        "<td>" + this['VAT_INVOICE_CASH'] + "</td>" +
                                        "<td>" + this['RECEIVABLE_CASH'] + "</td>" +
                                        "<td>" + this['RECEIVABLE_NOT_CASH'] + "</td>" +
                                        "<td>" + this['RECEIVABLE_MOBILE_CASH'] + "</td>" +
                                        "<td>" + total_money + "</td>" +
                                        "<td>" + this['NO_TICKET'] + "</td>" +
                                        "<td>" + this['CANCEL_TICKET'] + "</td>";
                                    trHtml = trHtml + "</tr>";
                                });
                                row.after(trHtml);
                            }
                        }
                    });
                }
            } );
            $('#table-report tfoot').on('click', 'th:first', function () {
                var tbody = $('#table-report tbody');
                var aswsome = $(this).find("i");
                if(tbody.is(':hidden')) {
                    aswsome.attr('class', 'icon-double-angle-up');
                } else {
                    aswsome.attr('class', 'icon-double-angle-down');
                }
                tbody.toggle();
            });
            //tableExport
            $("#btn-excel").click(function(){
                // $('#table-report').tableExport({name:'test', type:'excel'}); //使用tableExport导出xml格式的excel文件，缺点是打开文件时会提示格式错误
                //结合后台POI导出正常格式的excel
                ccgx_table2excel.exportExcel({
                    url: '${ctx}/table2excel/export',
                    fileName: 'MTC出口车辆报表' + $("#selectDateStr").val() + '.班次' + $("#shiftturn").val(),
                    title: 'MTC出口车辆报表' + $("#selectDateStr").val() + '.班次' + $("#shiftturn").val(),
                    tableId: 'table-report',
                    excludeFirstCol: true
                });
            });

            $("#btnSubmit").click(function() {
                $("#searchForm").submit();
            });
        })
    </script>
</head>
<body>
    <div class="formWrap">
        <form action="${ctx}/shiftcheck/report/mtcXCar" id="searchForm" role="form" class="form-inline">
            <div class="form-top clearfix">
	            <h1 class="form-title">MTC出口车辆报表</h1>
	            <div class="form-bottomBar">
	                <button id="btn-print" type="button" class="btn btn-info">打印</button>
	                <button id="btn-excel" type="button" class="btn btn-success">生成Excel</button>
	            </div>
            </div>
            <div class="form-main">
            <table width="100%" class="table table-bordered-none">
                <tbody>
                <tr>
                    <td><label>收费站：</label>${fns:getUser().office.isTs eq '1' ? fns:getUser().office.name : station.name}</td>
                    <td><label>班次时间：</label>
                        <input id="selectDateStr" name="selectDateStr" type="text" readonly="readonly" maxlength="20" class="input-small Wdate " style="cursor:pointer"
                               value="<fmt:formatDate value="${xduty.stTime}" pattern="yyyy-MM-dd"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,maxDate:'%y-%M-%d'});"/>
                        <label>班次：</label>
                        <select id="shiftturn" name="shiftturn">
                            <option value="1" <c:if test="${xduty.shiftturn == 1}">selected="selected"</c:if>>1</option>
                            <option value="2" <c:if test="${xduty.shiftturn == 2}">selected="selected"</c:if>>2</option>
                            <option value="3" <c:if test="${xduty.shiftturn == 3}">selected="selected"</c:if>>3</option>
                            <option value="4" <c:if test="${xduty.shiftturn == 4}">selected="selected"</c:if>>4</option>
                        </select>
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
                    </td>
                    <td width="220px"><label>过滤：</label><input id="datatableSearch" type="text" class="input-medium"/></td>
                </tr>
                </tbody>
            </table>
            <table id="table-report" width="100%" border="1" class="table table-bordered hover stripe compact">
                <thead>
                    <th align="center" valign="middle" width="10px"></th>
                    <th align="center" valign="middle" width="150px">收费员</th>
                    <th align="center" valign="middle">车辆数（线圈统计）</th>
                    <th align="center" valign="middle">实收卡数</th>
                    <th align="center" valign="middle">增值税发票车辆</th>
                    <th align="center" valign="middle">增值税发票车辆金额</th>
                    <th align="center" valign="middle">现金支付应收金额</th>
                    <th align="center" valign="middle">非现金支付应收金额</th>
                    <th align="center" valign="middle">移动支付应收金额</th>
                    <th align="center" valign="middle">总应收金额</th>
                    <th align="center" valign="middle">无券卡</th>
                    <th align="center" valign="middle">废票</th>
                </thead>
                <c:if test="${not empty mtcXCarReport}">
                <tbody>
                    <c:forEach items="${mtcXCarReport}" var="xcar" varStatus="status">
                        <tr>
                            <input name="tcCode" value="${xcar['TC_Code']}" type="hidden"/>
                            <td align="center" valign="middle" style="text-align:center;">${status.index + 1}</td>
                            <td align="center" valign="middle">${xcar['TC_Name']}</td>
                            <td align="center" valign="middle">${xcar['COILS']}</td>
                            <td align="center" valign="middle">${xcar['ACT_CARDS']}</td>
                            <td align="center" valign="middle">${xcar['VAT_INVOICE_CARS']}</td>
                            <td align="center" valign="middle">${xcar['VAT_INVOICE_CASH']}</td>
                            <td align="center" valign="middle">${xcar['RECEIVABLE_CASH']}</td>
                            <td align="center" valign="middle">${xcar['RECEIVABLE_NOT_CASH']}</td>
                            <td align="center" valign="middle">${xcar['RECEIVABLE_MOBILE_CASH']}</td>
                            <td align="center" valign="middle">${xcar['RECEIVABLE_CASH'] + xcar['RECEIVABLE_NOT_CASH'] + xcar['RECEIVABLE_MOBILE_CASH']}</td>
                            <td align="center" valign="middle">${xcar['NO_TICKET']}</td>
                            <td align="center" valign="middle">${xcar['CANCEL_TICKET']}</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <th valign="middle" style="text-align:center;"><i class="icon-double-angle-up"></i></th>
                        <th align="center" valign="middle">合计</th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                    </tr>
                </tfoot>
                </c:if>
            </table>
            <table width="100%" class="table table-bordered-none">
                <tbody>
                <tr>
                    <td><label>负责人：</label></td>
                    <td><label>审核人：</label></td>
                    <td><label>制表人：</label></td>
                </tr>
                </tbody>
            </table>
            </div>
        </form>
    </div>
</body>
</html>
