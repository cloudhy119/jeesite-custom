<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内容管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<div class="wrapper">
	<div id="content" class="row-fluid">
		<div id="left" class="accordion-group sideztree">
			<iframe id="cmsMenuFrame" name="cmsMenuFrame" src="${ctx}/cms/tree" style="overflow:visible;"
				scrolling="yes" frameborder="no" width="100%"></iframe>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			<iframe id="cmsMainFrame" name="cmsMainFrame" src="${ctx}/cms/none" style="overflow:visible;"
				scrolling="yes" frameborder="no" width="100%"></iframe>
		</div>
	</div>
</div>
	<script type="text/javascript"> 
		var leftWidth = 180; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize(){
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
			mainObj.css("width","auto");
			frameObj.height(strs[0] - 5);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
			$(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
		}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>	
</body>
</html>