<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<meta name="decorator" content="blank"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}"/>
	<c:if test="${tabmode eq '1'}"><link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
		<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script></c:if>
	<style type="text/css">
		#main {padding:0;margin:0;}
		#header {position:static;}
		#header li {font-size:14px;_font-size:12px;}
		#header .brand {font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:26px;padding-left:33px;}
		#footer {margin:8px 0 0 0;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
		#footer, #footer a {color:#999;}
		#left{overflow-x:hidden;overflow-y:auto;background:#222d32;}
		#left .collapse{position:static;}
		#userControl>li>a{/*color:#fff;*/text-shadow:none;}
		#userControl>li>a:hover, #user #userControl>li.open>a{background:transparent;}
	</style>
	<script type="text/javascript">
        $(document).ready(function() {
            //by huangyun 20180710 选择收费站ztree弹出框
			$("#select_station").click(function() {
				var url = '/sys/office/treeDataStation';
			    var toUrl = 'iframe:${ctx}/tag/treeselect?url='+encodeURIComponent(url);
                top.$.jBox(
                    toUrl,
					{
                        title: "选择收费站",
                        width: 300,
                        height: 420,
                        buttons:{"确定":"ok"},
						submit: function(v, h, f){
                            if (v=="ok"){
                                var tree = h.find("iframe")[0].contentWindow.tree;
                                var nodes = tree.getSelectedNodes();
                                if (nodes[0].isParent){
                                    top.$.jBox.tip("不能选择父节点（"+nodes[0].name+"）请重新选择。");
                                    return false;
                                }
                                $.ajax({
                                        url: '${ctx}/index/selectStation',
                                        type: 'GET',
                                        dataType: "TEXT",
                                        data: {
                                            'id': nodes[0].id,
                                            'name': nodes[0].name
                                        },
                                        error: function() {
                                            top.$.jBox.error('选择收费站出错');
                                        },
                                        success: function( data ){
                                            $("#selected_station").text(nodes[0].name);
                                        }
								});
                            }
                        },
                        loaded: function(h) { //隐藏滚动条
                            $(".jbox-content", top.document).css( "overflow-y", "hidden");
                        }
					}
				);
            });

            // <c:if test="${tabmode eq '1'}"> 初始化页签
            $.fn.initJerichoTab({
                renderTo: '#right', uniqueId: 'jerichotab',
                contentCss: { 'height': $('#right').height() - tabTitleHeight },
                tabs: [], loadOnce: true, tabWidth: 110, titleHeight: tabTitleHeight
            });//</c:if>
            // 绑定菜单单击事件
            $("#menu a.menu").click(function(){
                // 一级菜单焦点
                $("#menu li.menu").removeClass("active");
                $(this).parent().addClass("active");
                // 左侧区域隐藏
                if ($(this).attr("target") == "mainFrame"){
                    $("#left,#openClose").hide();
                    wSizeWidth();
                    // <c:if test="${tabmode eq '1'}"> 隐藏页签
                    $(".jericho_tab").hide();
                    $("#mainFrame").show();//</c:if>
                    return true;
                }
                // 左侧区域显示
                $("#left,#openClose").show();
                if(!$("#openClose").hasClass("close")){
                    $("#openClose").click();
                }
                // 显示二级菜单
                var menuId = "#menu-" + $(this).attr("data-id");
                if ($(menuId).length > 0){
                    $("#left .accordion").hide();
                    $(menuId).parent().show();
                    // 初始化点击第一个二级菜单
                    if (!$(menuId + " .accordion-body:first").hasClass('in')){
                        $(menuId + " .accordion-heading:first a").click();
                    }
                    if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")){
                        $(menuId + " .accordion-body a:first i").click();
                    }
                    // 初始化点击第一个三级菜单
                    $(menuId + " .accordion-body li:first li:first a:first i").click();
                }else{
                    // 获取二级菜单数据
                    $.get($(this).attr("data-href"), function(data){
                        if (data.indexOf("id=\"loginForm\"") != -1){
                            alert('未登录或登录超时。请重新登录，谢谢！');
                            top.location = "${ctx}";
                            return false;
                        }
                        $("#left .accordion").hide();
                        $("#left").append(data);
                        // 链接去掉虚框
                        $(menuId + " a").bind("focus",function() {
                            if(this.blur) {this.blur()};
                        });
                        // 二级标题
                        $(menuId + " .accordion-heading a").click(function(){
                            $(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
                            $("a.accordion-active").removeClass("accordion-active");
                            if(!$($(this).attr('data-href')).hasClass('in')){
                                $(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
                                $(this).addClass('accordion-active');
                            }
                        });
                        // 二级内容
                        $(menuId + " .accordion-body a").click(function(){
                            //$(menuId + " li").removeClass("active");
                            //$(menuId + " li i").removeClass("icon-white");
                            //$(this).parent().addClass("active");
                            //$(this).children("i").addClass("icon-white");

                            if($(this).hasClass("hasChild")) {
                                if($(this).hasClass("spread")) { //展开状态
                                    $(this).removeClass("spread");
                                    $(this).children("i.icon-chevron").removeClass('icon-chevron-down').addClass('icon-chevron-right');
                                } else { //关闭状态
                                    $(this).addClass("spread");
                                    $(this).children("i.icon-chevron").removeClass('icon-chevron-right').addClass('icon-chevron-down');
                                }
                            }
                            $(menuId + " .accordion-body a.accordion-active").removeClass("accordion-active");
                            $(this).addClass("accordion-active");
                        });
                        // 展现三级
                        $(menuId + " .accordion-inner a").click(function(){
                            var href = $(this).attr("data-href");
                            if($(href).length > 0){
                                $(href).toggle().parent().toggle();
                                return false;
                            }
                            // <c:if test="${tabmode eq '1'}"> 打开显示页签
                            return addTab($(this)); // </c:if>
                        });
                        // 默认选中第一个菜单
                        $(menuId + " .accordion-body a:first i").click();
                        $(menuId + " .accordion-body li:first li:first a:first i").click();
                    });
                }
                // 大小宽度调整
                wSizeWidth();
                return false;
            });
            // 初始化点击第一个一级菜单
            $("#menu a.menu:first span").click();
            // <c:if test="${tabmode eq '1'}"> 下拉菜单以选项卡方式打开
            $("#userInfo .dropdown-menu a").mouseup(function(){
                return addTab($(this), true);
            });// </c:if>
            // 鼠标移动到边界自动弹出左侧菜单
            $("#openClose").mouseover(function(){
                if($(this).hasClass("open")){
                    $(this).click();
                }
            });
            // 获取通知数目  <c:set var="oaNotifyRemindInterval" value="${fns:getConfig('oa.notify.remind.interval')}"/>
            function getNotifyNum(){
                $.get("${ctx}/oa/oaNotify/self/count?updateSession=0&t="+new Date().getTime(),function(data){
                    var num = parseFloat(data);
                    if (num > 0){
                        $("#notifyNum,#notifyNum2").show().html("("+num+")");
                    }else{
                        $("#notifyNum,#notifyNum2").hide()
                    }
                });
            }
            getNotifyNum(); //<c:if test="${oaNotifyRemindInterval ne '' && oaNotifyRemindInterval ne '0'}">
            setInterval(getNotifyNum, ${oaNotifyRemindInterval}); //</c:if>
        });
        // <c:if test="${tabmode eq '1'}"> 添加一个页签
        function addTab($this, refresh){
            $(".jericho_tab").show();
            $("#mainFrame").hide();
            $.fn.jerichoTab.addTab({
                tabFirer: $this,
                title: $this.text(),
                closeable: true,
                data: {
                    dataType: 'iframe',
                    dataLink: $this.attr('href')
                }
            }).loadData(refresh);
            return false;
        }// </c:if>
	</script>
</head>
<body>
<div id="main">
	<div id="header" class="navbar navbar-fixed-top">
		<div class="navbar-inner header">
			<!-- <div class="brand"><span id="productName">${fns:getConfig('productName')}</span></div> -->
			<div class="logo"><img src="static/images/logo.png"></div>
			<div class="headMenu">
				<ul>
					<shiro:hasAnyRoles name="administrator">
					<li>
						<a href="#" id="select_station" title="选择收费站">
							<i class="tollIcon"></i>
							<span id="selected_station">${empty station ? '选择收费站' : station.name}</span>
						</a>
					</li>
					</shiro:hasAnyRoles>
					<li>
						<a href="${ctx}/ol" title="在线人数" target="mainFrame">
							<i class="headI onlineIcon"></i>
							<em class="headnum">${lineCount}</em>
						</a>
					</li>
					<li>
						<a href="javascript:" title="系统消息">
							<i class="headI dopeIcon"></i>
							<em class="unread">5</em>
						</a>
					</li>
					<li id="userInfo" class="dropdown">
						<div class="dropdown-toggle" data-toggle="dropdown" href="#" title="基本信息">
							<i class="nameIcon"><img src="static/images/topba_icon3.png" /></i>
							<span>${fns:getUser().name}</span>
							<em class="headArrow"></em>
						</div>
						<ul class="dropdown-menu">
							<li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
							<li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
						</ul>
					</li>
					<li class="signout" title="安全退出"><a href="${ctx}/logout"><i class="headI signoutIcon"></i></a></li>
				</ul>
			</div>
			<div class="nav-collapse" style="display:none;" >
				<ul id="menu" class="nav" style="*white-space:nowrap;float:none;">
					<c:set var="firstMenu" value="true"/>
					<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
						<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
							<li class="menu ${not empty firstMenu && firstMenu ? ' active' : ''}">
								<c:if test="${empty menu.href}">
									<a class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
								</c:if>
								<c:if test="${not empty menu.href}">
									<a class="menu" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
								</c:if>
							</li>
							<c:if test="${firstMenu}">
								<c:set var="firstMenuId" value="${menu.id}"/>
							</c:if>
							<c:set var="firstMenu" value="false"/>
						</c:if>
					</c:forEach>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div>
	<div class="container-fluid">
		<div id="content" class="row-fluid">
			<div id="left" class="leftTree"></div>
			<div id="openClose" class="close">&nbsp;</div>
			<div id="right" class="rightMain" style="background: #ebeff4;">
				<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%"></iframe>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    var leftWidth = 230; // 左侧窗口大小
    var htmlObj = $("html"), mainObj = $("#main");
    var headerObj = $("#header");
    var frameObj = $("#left, #openClose, #right, #right iframe");
    function wSize(){
        var minHeight = 500, minWidth = 960;
        var strs = getWindowSize().toString().split(",");
        htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
        frameObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height());
        $("#right iframe").height(frameObj.height());
        wSizeWidth();
    }
    function wSizeWidth(){
        if (!$("#openClose").is(":hidden")){
            var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
            $("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
        }else{
            $("#right").width("auto");
        }
    }
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>