<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>栏目列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			var setting = {view:{selectedMulti:false},data:{simpleData:{enable:true}}};
			var zNodes=[
		            <c:forEach items="${categoryList}" var="tpl">{id:'${tpl.id}', pId:'${not empty tpl.parent?tpl.parent.id:0}', name:"${tpl.name}", url:"${ctx}/cms/${not empty tpl.module?tpl.module:'none'}/?category.id=${tpl.id}", target:"cmsMainFrame"},
		            </c:forEach>];
			for(var i=0; i<zNodes.length; i++) {
				// 移除父节点
				if (zNodes[i] && zNodes[i].id == 1){
					zNodes.splice(i, 1);
				}<%--
				// 并将没有关联关系的父节点，改为父节点
				var isExistParent = false;
				for(var j=0; j<zNodes.length; j++) {
					if (zNodes[i].pId == zNodes[j].id){
						isExistParent = true;
						break;
					}
				}
				if (!isExistParent){
					zNodes[i].pId = 1;
				}--%>
			}
			// 初始化树结构
			var tree = $.fn.zTree.init($("#tree"), setting, zNodes);
			// 展开第一级节点
			var nodes = tree.getNodesByParam("level", 0);
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, true, false);
			}
			// 展开第二级节点
			nodes = tree.getNodesByParam("level", 1);
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, true, false);
			}
			wSize();
		});
		$(window).resize(function(){
			wSize();
		});
		function wSize(){
			$(".ztree").width($(window).width()-10).height($(window).height()-60);
			$(".ztree").css({"overflow":"auto","overflow-x":"auto","overflow-y":"auto"});
			$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
		}
	</script>
</head>
<body>
  	<a class="sidetitle">栏目列表</a>
	<div id="tree" class="ztree"></div>
</body>
</html>