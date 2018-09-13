<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>国际化资源管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
<div class="wrapper">
<div class="right-main">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/i18n/i18nResource/">国际化资源列表</a></li>
		<li class="active"><a href="${ctx}/i18n/i18nResource/form?id=${i18nResource.id}">国际化资源<shiro:hasPermission name="i18n:i18nResource:edit">${not empty i18nResource.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="i18n:i18nResource:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<sys:message content="${message}"/>
	<form:form id="inputForm" modelAttribute="i18nResource" action="${ctx}/i18n/i18nResource/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">归属页面：</label>
			<div class="controls">
				<shiro:hasRole name="administrator">
					<sys:treeselect id="pageId" name="pageId" value="${i18nResource.i18nPage.id}" labelName="i18nPage.pageName" labelValue="${i18nResource.i18nPage.pageName}"
						title="归属页面" url="/i18n/i18nResource/treeData" cssClass="required" notAllowSelectParent="true"/>
				</shiro:hasRole>
				<shiro:lacksRole name="administrator">
					${i18nResource.i18nPage.pageName}
				</shiro:lacksRole>
				<span class="help-inline"><font color="red">*</font></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">键：</label>
			<div class="controls">
				<shiro:hasRole name="administrator">
					<form:input path="name" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				</shiro:hasRole>
				<shiro:lacksRole name="administrator">
					${i18nResource.name}
				</shiro:lacksRole>
				<span class="help-inline"><font color="red">*</font></span>
			</div>
		</div>
		<c:forEach items="${fns:getDictList('language_type')}" var="lang">
			<div class="control-group">
				<label class="control-label">${lang}：</label>
				<div class="controls">
					<input type="hidden" name="langType" value="${lang.value}"/>
					<c:choose>
						<c:when test="${lang.value eq 'zh_CN'}">
							<input type="text" name="langVal" value="${langMap[lang.value]}" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font></span>
						</c:when>
						<c:otherwise>
							<input type="text" name="langVal" value="${langMap[lang.value]}" class="input-xlarge "/>
						</c:otherwise>
					</c:choose>
					<c:if test="${not empty i18nResource.i18nPage.pageUrl}">
						<a class="btn" href="${pageContext.request.contextPath}${i18nResource.i18nPage.pageUrl}?locale=${lang.value}" target="_blank" style="margin-left:20px">预览</a>
					</c:if>
				</div>
			</div>
		</c:forEach>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="i18n:i18nResource:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-default" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form></div></div>
</body>
</html>