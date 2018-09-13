<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>ETC出口数据管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<div class="wrapper">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/report/xdutyEtc/">ETC出口数据列表</a></li>
		<shiro:hasPermission name="report:xdutyEtc:edit"><li><a href="${ctx}/report/xdutyEtc/form">ETC出口数据添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="xdutyEtc" action="${ctx}/report/xdutyEtc/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btnQuery" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<shiro:hasPermission name="report:xdutyEtc:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xdutyEtc">
			<tr>
				<shiro:hasPermission name="report:xdutyEtc:edit"><td>
    				<a href="${ctx}/report/xdutyEtc/form?id=${xdutyEtc.id}" class="btn-operate">修改</a>
					<a href="${ctx}/report/xdutyEtc/delete?id=${xdutyEtc.id}" onclick="return confirmx('确认要删除该ETC出口数据吗？', this.href)" class="btn-operate">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>