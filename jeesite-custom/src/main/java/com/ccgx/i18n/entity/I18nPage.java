/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.entity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 国际化页面Entity
 * @author huangyun
 * @version 2017-12-28
 */
public class I18nPage extends DataEntity<I18nPage> {
	
	private static final long serialVersionUID = 1L;
	private String pageName;		// 页面名称描述
	private String pageUrl;		// 页面相对url路径
	private Office office;		// 所属单位ID。用于权限控制
	private String roleId;		// 所属角色ID。用于权限控制
	
	public I18nPage() {
		super();
	}

	public I18nPage(String id){
		super(id);
	}

	@Length(min=0, max=255, message="页面名称描述长度必须介于 0 和 255 之间")
	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	
	@Length(min=0, max=255, message="页面相对url路径长度必须介于 0 和 255 之间")
	public String getPageUrl() {
		return pageUrl;
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=0, max=32, message="所属角色ID。用于权限控制长度必须介于 0 和 32 之间")
	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	
}