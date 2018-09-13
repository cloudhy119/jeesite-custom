<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/front/quote.jsp"%>
<html>
	<head>
		<meta charset="utf-8" />
		<title>内容详情</title>
	</head>

	<body class="dmbz-bg">
		<div class="dmbz-wrap">
			<%@include file="/WEB-INF/views/include/front/newsHeader.jsp"%>
			<div class="container">
				<div class="side-top clearfix">
					<div class="now fl">
						<cms:frontCurrentPosition2 category="${category}"/>
					</div>
					<!-- 
					<div class="side-search fr">
						<input placeholder="请输入搜索关键字" class="form-control" /><button type="button">搜索</button>
					</div>
					 -->
				</div>
			</div>
			<!--/*位置-->
			<div class="container clearfix">
				<div class="news-details">
					<h1 class="details-title">${article.title}</h1>
					<div class="base-info">
						<span>发布时间: <fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						<span>来源：${article.articleData.copyfrom}</span>
						<span>浏览：${article.hits}次</span>
						<span><c:if test="${not empty article.keywords}">关键字：${article.keywords}</c:if></span>
					</div>
					<c:if test="${not empty article.image}"><div style="text-align: center;"><img src="${article.image}"/> </div></c:if>
					<c:if test="${not empty article.description}"><div>摘要：${article.description}</div></c:if>
					<div class="details-main">
						<p>&nbsp;&nbsp;${article.articleData.content} </p>
						<br/><p>&nbsp;&nbsp; </p>
						<br/><p>&nbsp;&nbsp;</p>
					</div>
					<div class="other">
					<c:if test="${not empty article.articleData.file}">
						附件：
						</br>
						<%-- 
						<input type="hidden" id="filePath" name="articleData.file.filePath" value="${article.articleData.file.filePath}" />
						<sys:ckfinder input="filePath" type="files" uploadPath="/cms/article" readonly="true" selectMultiple="false"/>
						 --%>
						 <a target="_blank" href="${ctxStatic}/pdfjs/web/viewer.html?file=${article.articleData.file.filePath}">浏览附件</a>
					</c:if>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/views/include/front/bottom.jsp"%>
		</div>
	</body>

</html>