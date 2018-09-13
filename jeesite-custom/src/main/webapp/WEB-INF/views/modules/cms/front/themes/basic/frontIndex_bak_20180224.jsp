<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/front/quote.jsp"%>
<html>

	<head>
		<meta charset="utf-8" />
		<title>总平台首页</title>
		<script src="${ctxStatic}/js/linksscroll.js"></script>
		<script type="text/javascript">
			function AutoScroll(obj) {
				$(obj).find("ul:first").animate({
					marginTop: "-30px"
				}, 500, function() {
					$(this).css({
						marginTop: "0px"
					}).find("li:first").appendTo(this);
				});
			}
			$(document).ready(function() {
				setInterval('AutoScroll("#scrollDiv")', 2000)
			});
		</script>		
		<script>
			$(function() {
				$(".fixed_qr_close").click(function() {
					$(".mod_qr").hide();
				})
			})
			function seniorSearch(){
				$("#inputForm").attr("action","${ctxf}/info/stdStandard/searchList");
				$("#searchType").attr("name","allContent");
				$("#inputForm").submit();
			}
			function showData(){
				location = "${ctxf}/show";
			} 
		</script>
	</head>

	<body class="default-bg">
		<div class="default-wrap">
			<header>
				<div class="header-bar">
					<c:choose>
						<c:when test="${empty fns:getUser().name}">
							<a href="${ctxf}/register"><spring:message code="default.top.register"/></a>
							<a href="${ctx}/login?loginType=f"><spring:message code="default.top.login"/></a>
						</c:when>
						<c:otherwise>
							<spring:message code="default.top.hello"/>, ${fns:getUser().name}
						</c:otherwise>
					</c:choose>
					<a href="${ctxf}/usercenter/index"><i><img src="${ctxStatic}/img/member.png" align="absmiddle" ></i><spring:message code="default.top.membercenter"/></a>
					<a href="#" onclick="switchLocale('zh_CN')" style="margin:0px"><i><img src="${ctxStatic}/img/lang_zh_CN.png" title="简体中文" align="absmiddle" style="margin:0px"></i></a>
					<a href="#" onclick="switchLocale('en_US')" style="margin:0px"><i><img src="${ctxStatic}/img/lang_en_US.png" title="English" align="absmiddle" style="margin:0px"></i></a>
					<c:if test="${not empty fns:getUser().name}">
						<shiro:lacksRole name="front">
							<a href="${ctx }" target="_blank" ><spring:message code="default.admin.login"/></a>
						</shiro:lacksRole>
					</c:if>
					<c:if test="${not empty fns:getUser().name}"><a href="${ctx}/logout" title="退出登录">退出</a></c:if>
				</div>
			</header>
			<!--/*头部-->
			<div class="container">
				<!-- <h1 class="mt50">中国-东盟标准计量质量特检认证认可信息服务平台</h1> -->
				<h1 class="mt50"><spring:message code="default.station.name" /></h1>
			</div>
			<div class="container clearfix">
				<div class="search mt40">
					<div id="tab1">
						<div class="menubox clearfix">
							<ul>
								<li onclick="setTab('one',1,7)" id="one1" class="hover"><i class="qbicon"></i><spring:message code="default.search.condition.total" /></li>
								<li onclick="setTab('one',2,7)" id="one2" class=""><i class="bzicon"></i><spring:message code="default.search.condition.std" /></li>
								<li onclick="setTab('one',3,7)" id="one3" class=""><i class="bmicon"></i><spring:message code="default.search.condition.barcode" /></li>
								<li onclick="setTab('one',4,7)" id="one4" class=""><i class="tbicon"></i><spring:message code="default.search.condition.tbt" /></li>
								<li onclick="setTab('one',5,7)" id="one5" class=""><i class="jlicon"></i><spring:message code="default.search.condition.measurement" /></li>
								<li onclick="setTab('one',6,7)" id="one6" class=""><i class="tjicon"></i><spring:message code="default.search.condition.special" /></li>
								<li onclick="setTab('one',7,7)" id="one7" class=""><i class="zjicon"></i><spring:message code="default.search.condition.quality" /></li>
							</ul>
						</div>
						<div class="contentbox">
							<div id="con_one_1">
								<select>
									<option><spring:message code="default.search.condition.total" /></option>
								</select>
							</div>
							<div id="con_one_2" class="none">
								<select>
									<option>标准号</option>
									<option>标准名</option>
									<option>标准全文</option>
								</select>
							</div>
							<div id="con_one_3" class="none">
								<select>
									<option>全部</option>
									<option>产品信息</option>
									<option>产商识别代码</option>
									<option>厂商名称</option>
									<option>厂商地址</option>
								</select>
							</div>
							<div id="con_one_4" class="none">
								<select>
									<option>全文</option>
									<option>类别</option>
									<option>TBT标题</option>
									<option>生效日期</option>
								</select>
							</div>
							<div id="con_one_5" class="none">
								<select>
									<option>新闻动态</option>
									<option>法律法规</option>
									<option>校准测量能力</option>
								</select>
							</div>
							<div id="con_one_6" class="none">
								<select>
									<option>标准号</option>
									<option>标准名</option>
									<option>标准全文</option>
									<option>新闻动态</option>
								</select>
							</div>
							<div id="con_one_7" class="none">
								<select>
									<option>新闻动态</option>
									<option>质检认证</option>
									<option>机构信息</option>
								</select>
							</div>
						</div>
					</div>
					<div class="search-box">
					<form id="inputForm" action="${ctxf}/fulltext/stdFulltext/list" method="post">
						<input id="searchType" class="searchType" type="text" name="queryWord" value="" />
						<input id="languageType" type="hidden" name="languageType" value="ZH" />
						<input id="standardType" type="hidden" name="standardType" value="2" />
						
						<button type="submit" class="search-btn"><spring:message code="default.search.btn.search" /></button>
						<a href="javascript:seniorSearch();" class="major-btn"><spring:message code="default.search.btn.professional" /></a>
						<button type="button" onclick="javascript:showData();" class="show-btn"><spring:message code="default.search.btn.data" /></button>
					</form>
					</div>
				</div>
			</div>
			<!--/*检索-->
			<div class="container mt40 clearfix">
				<div class="news">
					<h2><img src="${ctxStatic}/img/icon13.png"/><spring:message code="default.news" />：</h2>
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
								<li><a href="${ctxf}/news/view-${article.category.id}-${article.id}.html?headType=${headType}&hasMenu=yes">• ${article.title}</a>
									<span><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<!--/*滚动资讯-->
			<div class="container clearfix">
				<div class="entrance">
					<ul>
						<li>
							<a href="${ctxf }/info/stdStandard/frontAseanList" target="_blank" style="background: #6696e8;"><i><img src="${ctxStatic}/img/icon2.png" /></i>
								<p><spring:message code="default.subentry.std" /></p>
							</a>
						</li>
						<li>
							<a href="${ctxf }/jiliang/std_Jl_Measure/frontIndex" target="_blank" style="background: #f25e5e;"><i><img src="${ctxStatic}/img/icon3.png" /></i>
								<p><spring:message code="default.subentry.measurement" /></p>
							</a>
						</li>
						<li>
							<a href="${ctxf }/tejian/stdTjStandard/frontIndex" target="_blank" style="background: #54a0d8;"><i><img src="${ctxStatic}/img/icon4.png" /></i>
								<p><spring:message code="default.subentry.special" /></p>
							</a>
						</li>
						<li>
							<a href="${ctxf }/goodscode/front/index" target="_blank" style="background: #fbc048;"><i><img src="${ctxStatic}/img/icon5.png" /></i>
								<p><spring:message code="default.subentry.barcode" /></p>
							</a>
						</li>
						<li>
							<a href="${ctxf}/zj/zjportals/index" target="_blank" style="background: #45aee2;"><i><img src="${ctxStatic}/img/icon6.png" /></i>
								<p><spring:message code="default.subentry.quality" /></p>
							</a>
						</li>
						<li>
							<a href="javascript:;" target="_blank" style="background: #3dcd87;"><i><img src="${ctxStatic}/img/icon7.png" /></i>
								<p><spring:message code="default.subentry.admittance" /></p>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<!--/*内容-->
			<div class="container">
				<div class="links clearfix">
					<div class="links-title"><spring:message code="default.link" /></div>
					<div class="roll-box">
						<div class="left-button" onmousedown="ISL_GoUp()" onmouseup="ISL_StopUp()" onmouseout="ISL_StopUp()"></div>
						<div class="cont" id="ISL_Cont">
							<div class="scrcont">
								<div id="list1">
									<c:forEach items="${fnc:getLinkList(site.id, '20', 5, '')}" var="link">
										<a href="${link.href}" target="_blank" title="${link.title}"><img src="${link.image}"></a>
									</c:forEach>
								</div>
								<div id="list2"></div>
							</div>
						</div>
						<div class="right-button" onmousedown="ISL_GoDown()" onmouseup="ISL_StopDown()" onmouseout="ISL_StopDown()"></div>
					</div>
				</div>
			</div>
			<!--/*友情链接-->
			<footer>
				<div class="default-footer-bar clearfix">
					<spring:message code="default.copyright"/>
				</div>
			</footer>
			<!--/*底部-->
			<div class="mod_qr">
				<a href="###" class="mod_qr_bd">
					<img src="${ctxStatic }/img/ewm.jpg" alt='<spring:message code="default.app.qrcode"/>'>
					<span class="h"><spring:message code="default.app.qrcode"/></span>
				</a>
				<a href="javascript:void(0);" id="close" class="fixed_qr_close"><s class="qricon s_s_close"></s></a>
			</div>
			<!--手机客户端二维码-->
		</div>
	</body>

</html>
