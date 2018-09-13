<%@ page contentType="text/html;charset=UTF-8"%>
<!--/*友情链接-->
<div class="container">
	<div class="links clearfix">
		<div class="links-title">友情链接</div>
		<div class="roll-box">
			<div class="left-button" onmousedown="ISL_GoUp()"
				onmouseup="ISL_StopUp()" onmouseout="ISL_StopUp()"></div>
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
			<div class="right-button" onmousedown="ISL_GoDown()"
				onmouseup="ISL_StopDown()" onmouseout="ISL_StopDown()"></div>
		</div>
	</div>
</div>
<script src="${ctxStatic}/js/linksscroll.js" type="text/javascript"></script>
