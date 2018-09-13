<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
      body{background:#182125 url(../static/images/login-bg.jpg) no-repeat center top fixed;margin: 0; padding: 0; color: #333;-webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover; font-family: "微软雅黑", arial; }
      .login-logo{padding:20px;width:463px;}
      .login-wrap{position: absolute; top: 50%; left: 50%; margin-left:-210px; margin-top: -210px;}
	  .login-container{width: 320px; height: 370px; padding:50px 50px 0 50px; border-radius: 10px; background: url(../static/images/bg2.png) repeat;-webkit-box-shadow: 0 5px 10px rgba(24, 33, 37, .5);-moz-box-shadow: 0 5px 10px rgba(24, 33, 37, .5); box-shadow: 0 5px 10px rgba(24, 33, 37, .5);}
	  .login-container h1{text-align:center;margin-bottom:45px;}
	  .login-form .form-group{ position: relative;}
	  .login-form .form-group label{position: absolute; left: 15px; top: 9px;}
	  .name-icon,.password-icon{ width: 24px; height: 24px; background-repeat: no-repeat; background-position: center;}
	  .name-icon{background-image: url(../static/images/login-name.png);}
	  .password-icon{background-image: url(../static/images/login-password.png);}
	  .login-form .login-input{width: 100%; box-sizing: border-box; margin-bottom: 30px; padding-left: 49px; font-size: 16px; padding-right: 15px; background: #fff; border: none; border-radius: 20px; height: 42px; line-height: 42px;}
	  .login-submit{background: #408eb9;border:none; color: #fff!important; height: 42px; font-size: 22px; border-radius: 20px; margin-top: 30px;}
      .login-submit:hover{background: #06bfee;}
      .mid{vertical-align:middle;}      
      .alert{position:relative;width:280px;margin:10px auto 0 auto;*padding-bottom:0px;padding: 2px 35px 2px 14px;}
      label.error{background:none;font-weight:normal;color:inherit;margin:0;padding:0;}
      .footer{text-align: center; color: #fff; position: absolute; width: 100%; bottom: 20px;}
      .com-zoom-flash{display: none;}  
      .alert .close{top:3px;}
      @media screen and (max-width: 1367px) {
      	.login-logo{width:400px;}
      	.login-logo img{width:100%;}
		.login-wrap{margin-left:-160px; margin-top: -160px;}
	  	.login-container{width: 240px; height: 290px; padding:30px 40px 0 40px;}
	  	.login-container h1 {margin-bottom:25px;}		
		.login-container h1 img{width:100%;}
		.login-form .form-group label{left: 15px; top: 9px;}
		.name-icon,.password-icon{ width: 20px; height: 20px; background-size: auto 100%;}
		.login-form .login-input{height: 38px; line-height: 38px; padding-left: 40px; margin-bottom:18px;}
		.login-submit{height: 38px; margin-top: 20px;}
		.alert{width:230px;}
      }   
    </style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body>
<div class="login-logo"><img src="../static/images/login-logo.png" /></div>
	<div class="login-wrap">		
		<div class="login-container">	
		<h1><img src="../static/images/login-logo2.png" /></h1>
		<form id="loginForm" action="${ctx}/login" method="post" class="login-form">
			<div class="form-group">
				<label for="name" class="name-icon"></label>
				<input type="text" id="username" name="username" placeholder="请输入账号" class="login-input" value="${username}">
			</div>
			<div class="form-group">
				<label for="password" class="password-icon"></label>
				<input type="password" id="password" name="password" placeholder="请输入密码" class="login-input" style="margin-bottom:20px;">
			</div>
			<div class="form-group" style="color:#fff;padding-left:15px;">			    
			    <input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}  style="zoom:150%;" />记住登录密码
		    </div>
			<div class="form-group"><input class="btn-block login-submit" type="submit" value="登 录"/></div>
			<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
				<label id="loginError" class="error">${message}</label>
			</div>
		</form>
		</div>
	</div>
	<div class="footer">
		Copyright © 2018-2019 All rights Reserved 广西交通投资集团有限公司 版权所有
	</div>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
</body>
</html>