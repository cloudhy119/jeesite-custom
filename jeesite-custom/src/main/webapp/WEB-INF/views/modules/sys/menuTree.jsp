<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="accordion">
	<a href="${ctx}/index" id="adminIndexMenu" target="mainFrame" class="menutitle">系统首页</a>
	<div id="menu-${param.parentId}">
		<c:set var="menuList" value="${fns:getMenuList()}" />
		<c:set var="firstMenu" value="true" />
		<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
			<c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
				<div class="accordion-group">
					<div class="accordion-heading">
						<a class="accordion-toggle ${not empty firstMenu && firstMenu ? 'accordion-active' : ''}" data-toggle="collapse" data-parent="#menu-${param.parentId}" data-href="#collapse-${menu.id}" href="#collapse-${menu.id}" title="${menu.remarks}">
						<em class="menu-icon-left1 icon-${not empty menu.icon ? menu.icon : 'folder-open'}"></em>&nbsp;${menu.name}&nbsp;<i class="menu-arrow1 icon-chevron icon-chevron-${not empty firstMenu && firstMenu ? 'down' : 'right'}"></i></a>
					</div>
					<div id="collapse-${menu.id}" class="accordion-body collapse ${not empty firstMenu && firstMenu ? 'in' : ''}">
						<div class="accordion-inner">
							<ul class="nav nav-list">
								<c:forEach items="${menuList}" var="menu2">
									<c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
										<li>
											<a data-href=".menu3-${menu2.id}" href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}" target="${not empty menu2.target ? menu2.target : 'mainFrame'}" class="${menu2.isParent eq '1' ? 'hasChild' : ''}"><i class="menu-icon-left2"></i>${menu2.name}
												<c:if test="${menu2.isParent eq '1'}">&nbsp;<i class="menu-arrow2 icon-chevron icon-chevron-right"></i></c:if>
											</a>
											<ul class="nav nav-list hide" style="margin:0;padding-right:0;">
												<c:forEach items="${menuList}" var="menu3">
													<c:if test="${menu3.parent.id eq menu2.id&&menu3.isShow eq '1'}">
														<li class="menu3-li menu3-${menu2.id} hide">
															<a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}" target="${not empty menu3.target ? menu3.target : 'mainFrame'}"><i class="menu-icon-left2"></i>${menu3.name}</a>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</li>
										<c:set var="firstMenu" value="false" /></c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</div>
</div>
<%--
</body>
</html> --%>