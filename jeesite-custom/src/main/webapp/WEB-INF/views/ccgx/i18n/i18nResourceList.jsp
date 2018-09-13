<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>国际化资源管理</title>
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
		<li class="active"><a href="${ctx}/i18n/i18nResource/">国际化资源列表</a></li>
		<shiro:hasRole name="administrator"><li><a href="${ctx}/i18n/i18nResource/form">国际化资源添加</a></li></shiro:hasRole>
	</ul>
	<form:form id="searchForm" modelAttribute="i18nResource" action="${ctx}/i18n/i18nResource/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>键名：</label>
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>值：</label>
				<form:input path="text" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>语言：</label>
				<form:select path="lang" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('language_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>页面：</label>
				<form:select path="pageId" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${pageList}" itemLabel="pageName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>键</th>
				<th>值</th>
				<th>语言</th>
				<th>归属页面</th>
				<th>编辑者</th>
				<th>编辑日期</th>
				<shiro:hasPermission name="i18n:i18nResource:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="i18nResource">
			<tr>
				<td><a href="${ctx}/i18n/i18nResource/form?id=${i18nResource.id}">
					${i18nResource.name}
				</a></td>
				<td>
					${i18nResource.text}
				</td>
				<td>
					${fns:getDictLabel(i18nResource.lang, 'language_type', '')}
				</td>
				<td>
					<a href="${pageContext.request.contextPath}${i18nResource.i18nPage.pageUrl}?locale=${i18nResource.lang}" target="_blank">${i18nResource.i18nPage.pageName}</a>
				</td>
				<td>
					${i18nResource.updateBy.name}
				</td>
				<td>
					<fmt:formatDate value="${i18nResource.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="i18n:i18nResource:edit"><td>
    				<a class="btn-operate" href="${ctx}/i18n/i18nResource/form?id=${i18nResource.id}">修改</a>
    				<shiro:hasRole name="administrator">
						<a class="btn-operate" href="${ctx}/i18n/i18nResource/delete?id=${i18nResource.id}" onclick="return confirmx('确认要删除该国际化资源吗？', this.href)">删除</a>
					</shiro:hasRole>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div></div></div>
</body>
</html>