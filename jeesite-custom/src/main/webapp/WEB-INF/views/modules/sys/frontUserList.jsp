<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/sys/user/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/list");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
<div class="wrapper">
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form>
	</div>
	<ul class="nav nav-tabs mt10">
		<li class="active"><a href="${ctx}/sys/user/listFrontUser">用户列表</a></li>
		<shiro:hasRole name="administrator"><li><a href="${ctx}/sys/user/form">用户添加</a></li></shiro:hasRole>
	</ul>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/listFrontUser" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>登录名：</label><form:input path="loginName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>姓&nbsp;&nbsp;&nbsp;名：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btnQuery" type="submit" value="查询" onclick="return page();"/>
		</ul>
	</form:form>
	<%-- 
	<div class="bottomDiv">
		<input id="btnExport" class="btn-public" type="button" value="导出"/>
		<input id="btnImport" class="btn-public" type="button" value="导入"/>
	</div>--%>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
			<th>姓名</th>
			<th>登录名</th>
			<th>手机</th>
			<th>公司</th>
			<th>职位</th>
			<shiro:hasRole name="administrator"><th width="101px">操作</th></shiro:hasRole>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td><a href="${ctx}/sys/user/form?id=${user.id}">${user.name}</a></td>
				<td>${user.loginName}</td>
				<td>${user.mobile}</td>
				<td>${user.userExt.corpsName}</td>
				<td>${user.userExt.duties}</td>
				<shiro:hasRole name="administrator"><td>
    				<a class="btn-operate" href="${ctx}/sys/user/form?id=${user.id}">修改</a>
					<a class="btn-operate" href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
				</td></shiro:hasRole>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<div class="wrapper">
</body>
</html>