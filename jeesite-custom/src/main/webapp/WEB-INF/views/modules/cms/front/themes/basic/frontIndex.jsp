<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="ctxf" value="${pageContext.request.contextPath}${fns:getFrontPath()}"/>
<html>
	<head>
		<meta charset="utf-8" />
		<title><spring:message code="default.station.name" /></title>
		<link rel="stylesheet" href="${ctxStatic}/bootstrap/3/bootstrap.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css/frontIndex.css" />
		<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script>
		<script type="text/javascript">
			/**滚动新闻资讯**/
			function AutoScroll(obj) {
				$(obj).find("ul:first").animate({
					marginTop: "-22px"
				}, 500, function() {
					$(this).css({
						marginTop: "0px"
					}).find("li:first").appendTo(this);
				});
			}
			$(document).ready(function() {
				setInterval('AutoScroll("#scrollDiv")', 2000)
			});
			/**浮动二维码**/
			$(function() {
				$(".fixed_qr_close").click(function() {
					$(".mod_qr").hide();
				})
			})
			function switchLocale(locale) {
				window.location.href=window.location.pathname + "?locale=" + locale;
			}
		</script>		
	</head>
	<body>
		<div class="wrapper">
		<section>
			<div class="header clearfix">
				<div class="pull-left otherLinks">
					<c:forEach items="${fnc:getLinkList(site.id, '80ea40820f3e4e329cadba061f4710fc', 5, '')}" var="link" varStatus="status"><c:if test="${status.index > 0}">|</c:if><a href="${link.href}" target="_blank">${link.title}</a></c:forEach>				
				</div>
				<div class="pull-right">
					<c:choose>
						<c:when test="${empty fns:getUser().name}">
							<a href="${ctx}/login?loginType=f" class="loginbtn"><spring:message code="default.top.login"/></a>
							<a href="${ctxf}/register" class="regbtn"><spring:message code="default.top.register"/></a>
						</c:when>
						<c:otherwise>
							<spring:message code="default.top.hello"/>, ${fns:getUser().name}
						</c:otherwise>
					</c:choose>
					<a href="${ctxf}/usercenter/index" class="adminbtn"><spring:message code="default.top.membercenter"/></a>
					<a href="javascript:;" onclick="switchLocale('zh_CN')"><i><img src="${ctxStatic}/img/frontIndex/china.png"/></i></a>
					<a href="javascript:;" onclick="switchLocale('en_US')"><i><img src="${ctxStatic}/img/frontIndex/language.png"/></i></a>
					<c:if test="${not empty fns:getUser().name}">
						<shiro:lacksRole name="front">
							<a href="${ctx }" target="_blank" ><spring:message code="default.admin.login"/></a>
						</shiro:lacksRole>
					</c:if>
					<c:if test="${not empty fns:getUser().name}"><a href="${ctx}/logout" title="退出登录">退出</a></c:if>
				</div>
			</div>
		</section>
		<!--/*头部-->
		<div class="main">
		<section>
			<div class="logo"><spring:message code="default.station.name" /><!-- <img src="${ctxStatic}/img/frontIndex/logo.png"/> --></div>
			<div class="search">
				<form id="inputForm" action="${ctxf}/fulltext/stdFulltext/list" method="post">
					<input type="text" placeholder="<spring:message code="default.search.tip" />" name="queryWord" /><button type="submit"><spring:message code="default.search.btn.search" /></button>
				</form>
				<a href="${ctxf}/show"><spring:message code="default.search.btn.data" /></a>
			</div>
		</section>
		<!--/*搜索-->
		<section>
			<div class="news clearfix">
					<b><img src="${ctxStatic}/img/icon13.png"/>&nbsp;&nbsp;<spring:message code="default.news" />：</b>
					<div id="scrollDiv">
						<ul>
							<c:forEach items="${fnc:getArticleList(site.id, '', 10, 'orderBy: \"a.update_date desc\"')}" var="article" >
								<c:choose>
									<c:when test="${fn:contains(article.category.parentIds, ',2,')}"><%--中国标准 --%>
										<c:set var="headType" value="1"/>
									</c:when>
									<c:when test="${fn:contains(article.category.parentIds, ',9e73c081ccbc4f31860ec62f9d3df82c,')}"><%--东盟标准 --%>
										<c:set var="headType" value="2"/>
									</c:when>
									<c:when test="${fn:contains(article.category.parentIds, ',10,')}"><%--计量 --%>
										<c:set var="headType" value="3"/>
									</c:when>
									<c:when test="${fn:contains(article.category.parentIds, ',6,')}"><%--特检 --%>
										<c:set var="headType" value="4"/>
									</c:when>
									<c:when test="${fn:contains(article.category.parentIds, ',7745a7762e334348831b56e332e7f8ed,')}"><%--TBT --%>
										<c:set var="headType" value="6"/>
									</c:when>
									<c:when test="${fn:contains(article.category.parentIds, ',c2d93005d1a64905aa3b02f23bd35bb4,')}"><%--质检--%>
										<c:set var="headType" value="7"/>
									</c:when>
									<c:when test="${fn:contains(article.category.parentIds, ',96b24bb75ae9432cbe1309645600b531,')}"><%--物品编码 --%>
										<c:set var="headType" value="8"/>
									</c:when>
									<c:otherwise>
										<c:set var="headType" value="1"/>
									</c:otherwise>
								</c:choose>
								<li><a target="_blank" href="${ctxf}/news/view-${article.category.id}-${article.id}.html?headType=${headType}&hasMenu=yes">• ${article.title}</a>
									<span><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span></li>
							</c:forEach>
						</ul>
					</div>
				</div>
		</section>
		<!--/*最新资讯-->
		<section>
			<div class="row inlet">
				<div class="container-fluid">
					<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
						<a href="${ctxf }/info/stdStandard/frontAseanList" target="_blank" >
							<div class="sideminlogin" style="background: #3498db;"><img src="${ctxStatic}/img/frontIndex/minlogin01.png" /></div>
							<p><spring:message code="default.subentry.std" /></p>
						</a>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
						<a href="${ctxf }/jiliang/std_Jl_Measure/frontIndex" target="_blank" >
							<div class="sideminlogin" style="background: #2dcbac;"><img src="${ctxStatic}/img/frontIndex/minlogin02.png" /></div>
							<p><spring:message code="default.subentry.measurement" /></p>
						</a>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
						<a href="${ctxf }/tejian/stdTjStandard/frontIndex" target="_blank" >
							<div class="sideminlogin" style="background: #56b4f4;"><img src="${ctxStatic}/img/frontIndex/minlogin03.png" /></div>
							<p><spring:message code="default.subentry.special" /></p>
						</a>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
						<a href="${ctxf }/goodscode/front/index" target="_blank" >
							<div class="sideminlogin" style="background: #ffb108;"><img src="${ctxStatic}/img/frontIndex/minlogin04.png" /></div>
							<p><spring:message code="default.subentry.barcode" /></p>
						</a>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
						<a href="${ctxf}/zj/zjportals/index" target="_blank" >
							<div class="sideminlogin" style="background: #f25c6d;"><img src="${ctxStatic}/img/frontIndex/minlogin05.png" /></div>
							<p><spring:message code="default.subentry.quality" /></p>
						</a>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
						<a href="javascript:;" target="_blank" >
							<div class="sideminlogin" style="background: #597cc6;"><img src="${ctxStatic}/img/frontIndex/minlogin06.png" /></div>
							<p><spring:message code="default.subentry.admittance" /></p>
						</a>
					</div>
				</div>
			</div>
		</section>
		<!--/*快速路口-->
		</div>
		</div>
		<section>
			<div class="footer">
				<p>
					<c:forEach items="${fnc:getLinkList(site.id, '20', 5, '')}" var="link" varStatus="status">
						<c:if test="${status.index > 0}">|</c:if><a href="${link.href}" target="_blank">${link.title}</a>
					</c:forEach>
				</p>
				<spring:message code="default.copyright"/>
			</div>
		</section>
		<!--/*底部-->
		<div class="mod_qr">
			<a href="###" class="mod_qr_bd">
				<img src="${ctxStatic}/img/frontIndex/ewm.jpg" alt="<spring:message code="default.app.qrcode"/>">
				<span class="h"><spring:message code="default.app.qrcode"/></span>
			</a>
			<a href="javascript:void(0);" id="close" class="fixed_qr_close"><s class="qricon s_s_close"></s></a>
		</div>
		<!--手机客户端二维码-->
	</body>
</html>
