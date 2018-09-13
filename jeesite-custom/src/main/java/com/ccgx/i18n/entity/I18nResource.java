/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 国际化资源Entity
 * @author huangyun
 * @version 2017-12-28
 */
public class I18nResource extends DataEntity<I18nResource> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 键名
	private String text;		// 值
	private String lang;		// 语言
	private String pageId;		// 所在页面ID。关联i18n_page表
	
	private I18nPage i18nPage;
	
	public I18nResource() {
		super();
	}

	public I18nResource(String id){
		super(id);
	}

	@Length(min=0, max=255, message="键名长度必须介于 0 和 255 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=255, message="值长度必须介于 0 和 255 之间")
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	@Length(min=0, max=32, message="语言长度必须介于 0 和 32 之间")
	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}
	
	@Length(min=0, max=32, message="所在页面ID。关联i18n_page表长度必须介于 0 和 32 之间")
	public String getPageId() {
		return pageId;
	}

	public void setPageId(String pageId) {
		this.pageId = pageId;
	}

	public I18nPage getI18nPage() {
		return i18nPage;
	}

	public void setI18nPage(I18nPage i18nPage) {
		this.i18nPage = i18nPage;
	}
	
}