<%@ page contentType="text/html;charset=UTF-8" %><meta http-equiv="Content-Type" content="text/html;charset=utf-8" /><meta name="author" content="http://www.ccgx.cn/"/>
<meta name="renderer" content="webkit"><meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10" />
<meta http-equiv="Expires" content="0"><meta http-equiv="Cache-Control" content="no-cache"><meta http-equiv="Cache-Control" content="no-store">

<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="ctxf" value="${pageContext.request.contextPath}${fns:getFrontPath()}"/>
<c:set var="ctxNews" value="${pageContext.request.contextPath}${fns:getFrontPath()}/news"/>

<!-- css_default css_cerulean-->
<%-- 
<%@ include file="/WEB-INF/views/modules/cms/front/include/head.jsp"%>
 --%>

<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js"></script>
<script src="${ctxStatic}/js/tab.js"></script>
<script src="${ctxStatic}/js/newsscroll.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/newspic.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/picscroll.js" type="text/javascript"></script>
<script src="${ctxStatic}/laydate/laydate.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctxStatic}/css/SimpleTree.css" /> 
<script src="${ctxStatic}/js/SimpleTree.js"></script>
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js"></script>
<link href="${ctxStatic}/common/jeesite.min.css" type="text/css" rel="stylesheet" /> 
<link rel="stylesheet" href="${ctxStatic}/css/pager.css" /> 

<%-- 
<script src="${ctxStatic}/js/linksscroll.js" type="text/javascript"></script>
<c:set var="ctxStaticTheme" value="${ctxStatic}/modules/cms/front/themes/basic"/>
<link href="${ctxStaticTheme}/style.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticTheme}/script.js" type="text/javascript"></script> 
<link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
 --%>
<link rel="stylesheet" href="${ctxStatic}/css/style.css" /> 

<script type="text/javascript">var ctx = '${ctx}', ctxf = '${ctxf}', ctxStatic='${ctxStatic}';</script>
<%@include file="/WEB-INF/views/include/treeview.jsp" %>

<!-- 数据展示页 -->
<link rel="stylesheet" href="${ctxStatic}/css-data/data-style.css" />
<script src="${ctxStatic}/js-data/echarts.min.js"></script>
<script type="text/javascript">
function switchLocale(locale) {
	window.location.href=window.location.pathname + "?locale=" + locale;
}
$(function(){
	var token = "${token}";
	if (token) {
		document.cookie = "token=" + token;
	}	
}); 
</script>




