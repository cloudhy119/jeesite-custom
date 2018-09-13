package com.thinkgem.jeesite.modules.sys.security;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.cas.CasFilter;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;

import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 自定义CAS登录处理
 * @author huangyun
 *
 */
public class CustomCasFilter extends CasFilter {
	
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request,
			ServletResponse response) throws Exception {
		String redirectUrl = "/f";
		String reqUri = null;
		SavedRequest savedReq = WebUtils.getAndClearSavedRequest(request);
		if(savedReq != null) {
			reqUri = savedReq.getRequestURI();
			String queryString = savedReq.getQueryString();
			String loginType = getUriQueryNameValPairs(queryString).get("loginType");
			if("f".equals(loginType)) { //在前台点击“登录”发起的登录请求则跳转到前台首页
				redirectUrl = "/f";
			} else if(StringUtils.isNotBlank(reqUri) && !reqUri.endsWith("/login")) { //用户是直接请求一个需要权限验证的链接而发起的登录请求，登录成功后跳转到他之前想要访问的地址
				redirectUrl = reqUri.substring(reqUri.indexOf("/", 1));
			} else { //否则前台用户跳转到前台首页，管理员用户跳转到后台管理首页
				if(isFrontUser()) {
					redirectUrl = "/f";
				} else {
					redirectUrl = "/a";
				}
			}
		}
		WebUtils.redirectToSavedRequest(request, response, redirectUrl);
		return false;
	}
	
	private boolean isFrontUser() {
		boolean isFrontUser = false;
		//TODO 判断是否是前台用户
		return isFrontUser;
	}
	
	private Map<String, String> getUriQueryNameValPairs(String queryString) {
		Map<String,String> queryStringMap = new HashMap<String,String>();
		if(StringUtils.isNoneBlank(queryString)) {
			String[] queryStringSplit = queryString.split("&");
			String[] queryStringParam;
			if(queryStringSplit.length > 0) {
				for (String qs : queryStringSplit) {
					queryStringParam = qs.split("=");
					if(queryStringParam.length == 2) {
						queryStringMap.put(queryStringParam[0], queryStringParam[1]);
					}
				}
			}
		}
        return queryStringMap;
	}

}
