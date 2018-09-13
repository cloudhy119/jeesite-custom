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
                    var excludes = [0,1,2,7,8,9,12,13];
                    $(tfoot).find('th').each(function(index) {
                        if(excludes.indexOf(index) == -1) { //计算数据的合计结果
                            var total = 0;
                            $(data).each(function() {
                                total = basicCalculate.add(total, this[index]);
                            });
                            $(this).html(total);
                        }
                    });
                }
            } );
            $('#datatableSearch').on( 'keyup', function () {
                datatable.search( this.value ).draw();
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
                // $('#table-report').tableExport({type:'excel'});
                //结合后台POI导出正常格式的excel
                ccgx_table2excel.exportExcel({
                    url: '${ctx}/table2excel/export',
                    fileName: '出口票据核销单' + $("#selectDateStr").val() + '.班次' + $("#shiftturn").val(),
                    title: '出口票据核销单' + $("#selectDateStr").val() + '.班次' + $("#shiftturn").val(),
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
        <form action="${ctx}/shiftcheck/report/xTicketCancel" id="searchForm" role="form" class="form-inline">
        	<div class="form-top clearfix">
	            <h1 class="form-title">出口票据核销单</h1>
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
                               value="<fmt:formatDate value="${duty.stTime}" pattern="yyyy-MM-dd"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,maxDate:'%y-%M-%d'});"/>
                        <label>班次：</label>
                        <select id="shiftturn" name="shiftturn">
                            <option value="1" <c:if test="${duty.shiftturn == 1}">selected="selected"</c:if>>1</option>
                            <option value="2" <c:if test="${duty.shiftturn == 2}">selected="selected"</c:if>>2</option>
                            <option value="3" <c:if test="${duty.shiftturn == 3}">selected="selected"</c:if>>3</option>
                            <option value="4" <c:if test="${duty.shiftturn == 4}">selected="selected"</c:if>>4</option>
                        </select>
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
                    </td>
                    <td width="220px"><label>过滤：</label><input id="datatableSearch" type="text" class="input-medium"/></td>
                </tr>
                </tbody>
            </table>
            <table id="table-report" width="100%" border="1" class="table table-bordered hover stripe compact">
                <thead>
                    <tr>
                    <th align="center" valign="middle" rowspan="2" width="10px"></th>
                    <th align="center" valign="middle" rowspan="2">姓名</th>
                    <th align="center" valign="middle" rowspan="2">票据名称</th>
                    <th align="center" valign="middle" colspan="4">通行费</th>
                    <th align="center" valign="middle" rowspan="2">面额</th>
                    <th align="center" valign="middle" rowspan="2">票据起号</th>
                    <th align="center" valign="middle" rowspan="2">票据止号</th>
                    <th align="center" valign="middle" rowspan="2">收据份数</th>
                    <th align="center" valign="middle" rowspan="2">废票数</th>
                    <th align="center" valign="middle" rowspan="2">上下班时间</th>
                    <th align="center" valign="middle" rowspan="2">车道</th>
                    </tr>
                    <tr>
                        <th align="center" valign="middle" width="100px">现金支付</th>
                        <th align="center" valign="middle" width="100px">特微移动支付</th>
                        <th align="center" valign="middle" width="150px">一卡通，千陌移动支付</th>
                        <th align="center" valign="middle" width="100px">合计</th>
                    </tr>
                </thead>
                <c:if test="${not empty xTicketCancelReport}">
                <tfoot>
                    <tr>
                        <th align="center" valign="middle" style="text-align:center;"><i class="icon-double-angle-up"></i></th>
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
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach items="${xTicketCancelReport}" var="car" varStatus="status">
                        <tr>
                            <input name="dwNumber" value="${car['TC_Code']}" type="hidden"/>
                            <td align="center" valign="middle" style="text-align:center;">${status.index + 1}</td>
                            <td align="center" valign="middle">${car['TC_Name']}</td>
                            <td align="center" valign="middle">非定额收据</td>
                            <td align="center" valign="middle">${car['CASH_PAY']}</td>
                            <td align="center" valign="middle">${car['TW_MOBILE_PAY']}</td>
                            <td align="center" valign="middle"></td>
                            <td align="center" valign="middle">${car['CASH_PAY'] + car['TW_MOBILE_PAY']}</td>
                            <td align="center" valign="middle"></td>
                            <td align="center" valign="middle" <c:if test="${car['isSerial'] == 0}">style="background-color: #ffcc00" title="${car['cause']}" </c:if> >${car['LoginTicketNum']}</td>
                            <td align="center" valign="middle">${car['EndTicketNum']}</td>
                            <td align="center" valign="middle">
                                <c:if test="${not empty car['EndTicketNum'] and not empty car['LoginTicketNum']}">
                                    ${car['EndTicketNum'] - car['LoginTicketNum'] + 1}
                                </c:if>
                            </td>
                            <td align="center" valign="middle">${car['CANCEL_TICKET']}</td>
                            <td align="center" valign="middle"><fmt:formatDate value="${car['LoginTime']}" pattern="HH:mm:ss"/>-<fmt:formatDate value="${car['LogoutTime']}" pattern="HH:mm:ss"/></td>
                            <td align="center" valign="middle">${car['DW_Number']}</td>
                        </tr>
                    </c:forEach>
                </tbody>
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
