<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>国际化页面管理</title>
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
<div class="right-main">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/i18n/i18nPage/">国际化页面列表</a></li>
		<shiro:hasPermission name="i18n:i18nPage:edit"><li><a href="${ctx}/i18n/i18nPage/form">国际化页面添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="i18nPage" action="${ctx}/i18n/i18nPage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>页面名称：</label>
				<form:input path="pageName" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>页面名称</th>
				<th>页面URL</th>
				<th>归属单位</th>
				<th>编辑者</th>
				<th>编辑日期</th>
				<shiro:hasPermission name="i18n:i18nPage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="i18nPage">
			<tr>
				<td><a href="${ctx}/i18n/i18nResource/list?pageId=${i18nPage.id}">
					${i18nPage.pageName}
				</a></td>
				<td>
					${i18nPage.pageUrl}
				</td>
				<td>
					${i18nPage.office.name}
				</td>
				<td>
					${i18nPage.updateBy.name}
				</td>
				<td>
					<fmt:formatDate value="${i18nPage.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="i18n:i18nPage:edit"><td>
    				<a class="btn-operate" href="${ctx}/i18n/i18nPage/form?id=${i18nPage.id}">修改</a>
					<a class="btn-operate" href="${ctx}/i18n/i18nPage/delete?id=${i18nPage.id}" onclick="return confirmx('确认要删除该国际化页面吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div></div></div>
</body>
</html>