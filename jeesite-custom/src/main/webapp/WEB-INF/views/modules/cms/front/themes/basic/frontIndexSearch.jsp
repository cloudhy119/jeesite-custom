<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/front/quote.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<title>内容中心</title>
	</head>
	<script type="text/javascript">
	$(document).ready(function() {
		if("${countryCode}" != ""){
			getCountry("${countryCode}");
		}
		$("#searchBtn").click(function (){
			getArticle("${countryCode}");
		});
		
	});
	
		function getCountry(code){
			var list = $("[name='country']");
			$("[name='country']").attr("class","");
			for(i=0; i<list.size(); i++){
				if("country"+code == list[i].getAttribute("id")){
					$("#country"+code).attr("class","active");
					$("#countryCode").val(code);
				}else{
					$("#country"+list[i].getAttribute("id")).attr("class");
				} 
			}
		}
		function getArticle(countryCode){
			var keywords = $("#searchAll").val();
			window.location.href = "${ctxf}/fulltext/stdFulltext/list?"
			+"queryWord="+keywords
			;
		}
	</script>
	
	<body class="dmbz-bg">
		<div class="dmbz-wrap">
			<%@include file="/WEB-INF/views/include/front/newsHeader.jsp"%>
			
			<div class="container">
				<div class="top-bar clearfix">
					<div class="logo" style="margin-left: 10%;margin-top: 2%">
						<img src="${ctxStatic}/img/logo8.png" alt="中国-东盟标准计量质量特检认证认可信息服务平台" />
					</div>
					<div class="top-bar-btn" style="margin-right:15%;margin-top: 2%">
						<a href="javascript:;" class="headicon"></a>
						<a href="javascript:;" class="englishicon"></a>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="side-top clearfix">
					<div class="now fl" style="margin-left:10%;">
						当前位置：<a href="${ctxf }">平台首页</a>
					</div>
					<div class="side-search fr" style="margin-right:15%;">
						<input id="searchAll" name="keywords" value="" placeholder="请输入搜索关键字" class="form-control" />
						<button id="searchBtn" type="button">搜索</button>
					</div>
				</div>
			</div>
			<!--/*位置-->
			<div class="container clearfix">
				<!-- 国家  -->
				<c:if test="${countryCode != '' && countryCode != null}">
				<div class="market-top clearfix">
					<ul>
						<input id="countryCode" value="" type="hidden" />
						<c:forEach items="${fns:getDictList('country')}" var="dict">
						<li>
							<a id="country${dict.value}" class="" name="country" href="javascript:getArticle('${dict.value}');">
								<p><img src="${ctxStatic}/img/pic${dict.value}.jpg" /><p>
								<p>${dict.label}</p>
							</a>
						</li>
						</c:forEach>
					</ul>
				</div>
				</c:if>
				<div class="clearfix">
					<c:choose>
						<c:when test="${hasMenu eq 'yes'}">
							<div class="sidemenu">
								<h2>${category.parent.name}</h2>
								<ul class="clearfix">
								<cms:frontCategoryList2 headType="${headType}" countryCode="${countryCode}"
										hasMenu="${hasMenu}" categoryList="${categoryList}"/>
								</ul>
							</div>
							<div class="news-list" >
						</c:when>
						<c:otherwise>
							<div class="news-list" style="margin-right:15%;width: 75%;">
						</c:otherwise>
					</c:choose>
					<ul class="news-ul">
					<c:forEach items="${page.list}" var="article">
						<li>
							<span class="pull-right">
								<fmt:formatDate value="${article.publishTime}" pattern="yyyy.MM.dd"/>
							</span>
							<a href="${ctxf}/${article.formUrl}" style="">[${article.typeName}]${fns:abbr(article.title,86)}</a>
						</li>
					</c:forEach>
					</ul>
				</div>
				<div class="pagination" style="margin-left:10%;width: 80%;">${page}</div>
					<script type="text/javascript">
					function page(n,s){
						location="${ctxf}/fulltext/stdFulltext/list?pageNo="+n+"&pageSize="+s;
					}
					</script>
				</div>
			</div>
			<!--/*内容-->
			<%@include file="/WEB-INF/views/include/front/bottom.jsp"%>
		</div>
	</body>


</html>