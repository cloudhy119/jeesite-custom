package com.ccgx.token;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 基于token、cookie防止表单重复提交
 * 默认为form和save方法生成和校验token
 * 其它方法可通过添加@Token(create = true)和@Token(validate = true)注解来生成和校验token达到防止表单重复提交的效果
 * @author huangyun
 *
 */
public class TokenInterceptor extends HandlerInterceptorAdapter {
	
	/**
	 * 管理基础路径
	 */
	@Value("${adminPath}")
	protected String adminPath;
	
	/**
	 * 前端基础路径
	 */
	@Value("${frontPath}")
	protected String frontPath;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean result = true;
		String url = request.getRequestURI();
		/*
		 * 默认为form和save方法增加token防止表单重复提交
		 */
		if(url.endsWith("/form")) {
			String token = IdGen.uuid();
			request.getSession().setAttribute("token", token);
		} else if(url.endsWith("/save")) {
			if(!validateToken(request)) {
				result = false;
			} else {
				request.getSession().removeAttribute("token");
			}
		} else {
			/*
			 * 检查Token注解
			 */
			if(handler instanceof HandlerMethod) {
				HandlerMethod handlerMethod = (HandlerMethod) handler;
				Token annotation = handlerMethod.getMethod().getAnnotation(Token.class);
				if(annotation != null) {
					if(annotation.create()) { //需要生成token
						if(request.getSession() != null) {
							request.getSession().setAttribute("token", IdGen.uuid());
						}
					} else if(annotation.validate()) { //需要校验token
						if(!validateToken(request)) {
							result = false;
						} else {
							if(request.getSession() != null) {
								request.getSession().removeAttribute("token");
							}
						}
					}
				}
			}
		}
		if(!result) { //token校验不通过，返回错误提示
			String index = "";
			String errMsg = null;
			if(url.indexOf(adminPath + "/") != -1) { //跳转后台首页
				index = request.getContextPath() + adminPath;
				errMsg = "已提交成功，请不要频繁点击&nbsp;<a href='#' onclick='window.parent.location.href=\"" + index + "\"'>返回首页</a>";
			} else { //跳转前台首页
				index = request.getContextPath() + frontPath;
				errMsg = "已提交成功，请不要频繁点击&nbsp;<a href='#' onclick='window.location.href=\"" + index + "\"'>返回首页</a>";
			}
			response.setHeader("content-type", "text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
            out.print(errMsg);
            out.close();
		}
		return result;
	}
	private boolean validateToken(HttpServletRequest request) {
		boolean isValid = false;
		String pageToken = null;
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			if("token".equals(cookie.getName())) {
				pageToken = cookie.getValue();
				break;
			}
		}
		String serverToken = (String) request.getSession().getAttribute("token");
		if(StringUtils.isNotBlank(pageToken) && pageToken.equals(serverToken)) {
			isValid = true;
		}
		return isValid;
	}
}
