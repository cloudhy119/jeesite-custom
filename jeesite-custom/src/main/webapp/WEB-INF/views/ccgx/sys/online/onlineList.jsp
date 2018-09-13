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
    <script type="text/javascript">
        $(function () {
            //datatables
            var datatable = $('#table-report').DataTable( {
                paging: true,
                dom: '<"top">t<"bottom"p><"clear">',
                order: [[ 5, 'desc' ]]
                //columnDefs: [{ "orderable": false, "targets": [0] }] //指定不排序的列
            } );
            $('#datatableSearch').on( 'keyup', function () {
                datatable.search( this.value ).draw();
            } );

            //tableExport
            $("#btn-excel").click(function(){
                $('#table-report').tableExport({type:'excel'});
            });

            $("#btnSubmit").click(function() {
                $("#searchForm").submit();
            });
        })
    </script>
</head>
<body>
    <div class="formWrap">
        <form action="${ctx}/ol/list" id="searchForm" role="form" class="form-inline">
        	<div class="form-top clearfix">
	            <h1 class="form-title">在线用户</h1>
	            <div class="form-bottomBar">
	                <button id="btn-excel" type="button" class="btn btn-success">生成Excel</button>
	            </div>
            </div>
            
            <div class="form-main">
            <table width="100%" class="table table-bordered-none">
                <tbody>
                <tr>
                    <td width="220px"><label>过滤：</label><input id="datatableSearch" type="text" class="input-medium"/></td>
                </tr>
                </tbody>
            </table>
            <table id="table-report" width="100%" border="1" class="table table-bordered hover stripe compact">
                <thead>
                    <th align="center" valign="middle" width="10px"></th>
                    <th align="center" valign="middle" width="250px">SessionID</th>
                    <th align="center" valign="middle">用户名</th>
                    <th align="center" valign="middle">账号名</th>
                    <th align="center" valign="middle">IP地址</th>
                    <th align="center" valign="middle" width="150px">上次活跃时间</th>
                </thead>
                <c:if test="${not empty sessions}">
                <tbody>
                    <c:forEach items="${sessions}" var="session" varStatus="status">
                        <tr>
                            <td align="center" valign="middle" style="text-align:center;">${status.index + 1}</td>
                            <td align="center" valign="middle">${session.id}</td>
                            <td align="center" valign="middle">${session.attributes['userInfo'].name}</td>
                            <td align="center" valign="middle">${session.attributes['userInfo'].loginName}</td>
                            <td align="center" valign="middle">${session.host}</td>
                            <td align="center" valign="middle"><fmt:formatDate value="${session.lastAccessTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
                </c:if>
            </table>
            </div>
        </form>
    </div>
</body>
</html>
