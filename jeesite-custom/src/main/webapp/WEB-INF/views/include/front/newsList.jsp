<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/front/quote.jsp"%>
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
			window.location.href = "${ctxf}/news/list-${category.id}${urlSuffix}?"
			+"&headType=${headType}&hasMenu=${hasMenu}"
			+"&keywords="+keywords+"&countryCode="+countryCode
			;
		}
	</script>
	
	<body class="dmbz-bg">
		<div class="dmbz-wrap">
			<%@include file="/WEB-INF/views/include/front/newsHeader.jsp"%>
			<div class="container">
				<div class="side-top clearfix">
					<div class="now fl">
						<cms:frontCurrentPosition2 category="${category}"/>
					</div>
					<div class="side-search fr">
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
							<div class="news-list" style="width: 100%;">
						</c:otherwise>
					</c:choose>
					<c:if test="${category.module eq 'article'}">
						<ul class="news-ul">
						<c:forEach items="${page.list}" var="article">
							<li>
								<span class="pull-right">
									<fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/>
								</span>
								<a href="${article.url}?headType=${headType}&countryCode=${countryCode}&hasMenu=${hasMenu}" style="color:${article.color}">${fns:abbr(article.title,96)}</a>
							</li>
						</c:forEach>
						</ul>
					</c:if>					
					<div class="pagination" style="padding:0 15px;">${page}</div>
					<script type="text/javascript">
					function page(n,s){
						location="${ctxf}/news/list-${category.id}${urlSuffix}?pageNo="+n+"&pageSize="+s+"&headType=${headType}&countryCode=${countryCode}&hasMenu=${hasMenu}";
					}
					</script>
				</div>
				</div>
			</div>
			<!--/*内容-->
			<%@include file="/WEB-INF/views/include/front/bottom.jsp"%>
		</div>
	</body>

</html>