<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>国际化页面管理</title>
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
		<li><a href="${ctx}/i18n/i18nPage/">国际化页面列表</a></li>
		<li class="active"><a href="${ctx}/i18n/i18nPage/form?id=${i18nPage.id}">国际化页面<shiro:hasPermission name="i18n:i18nPage:edit">${not empty i18nPage.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="i18n:i18nPage:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="i18nPage" action="${ctx}/i18n/i18nPage/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">页面名称：</label>
			<div class="controls">
				<form:input path="pageName" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">页面URL：</label>
			<div class="controls">
				<form:input path="pageUrl" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所属单位：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${i18nPage.office.id}" labelName="office.name" labelValue="${i18nPage.office.name}"
					title="单位" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="i18n:i18nPage:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-default" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form></div></div>
</body>
</html>