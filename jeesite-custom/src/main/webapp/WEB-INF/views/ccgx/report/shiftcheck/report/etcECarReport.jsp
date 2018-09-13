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
                    fileName: 'ETC入口车辆报表' + $("#selectDateStr").val() + '.班次' + $("#shiftturn").val(),
                    title: 'ETC入口车辆报表' + $("#selectDateStr").val() + '.班次' + $("#shiftturn").val(),
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
        <form action="${ctx}/shiftcheck/report/etcECar" id="searchForm" role="form" class="form-inline">
        	<div class="form-top clearfix">
	            <h1 class="form-title">ETC入口车辆报表</h1>
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
                    <th align="center" valign="middle" width="10px"></th>
                    <th align="center" valign="middle">车道</th>
                    <th align="center" valign="middle">合计车辆数</th>
                    <th align="center" valign="middle">线圈合计</th>
                    <th align="center" valign="middle">计数器统计</th>
                </thead>
                <c:if test="${not empty etcECarReport}">
                <tfoot>
                    <tr>
                        <th align="center" valign="middle" style="text-align:center;"><i class="icon-double-angle-up"></i></th>
                        <th align="center" valign="middle">合计</th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                        <th align="center" valign="middle"></th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach items="${etcECarReport}" var="car" varStatus="status">
                        <tr>
                            <input name="dwNumber" value="${car['DW_Number']}" type="hidden"/>
                            <td align="center" valign="middle" style="text-align:center;">${status.index + 1}</td>
                            <td align="center" valign="middle">${car['DW_Number']}</td>
                            <td align="center" valign="middle">${car['ACT_CARS']}</td>
                            <td align="center" valign="middle">${car['COILS']}</td>
                            <td align="center" valign="middle">${car['COUNTER']}</td>
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
