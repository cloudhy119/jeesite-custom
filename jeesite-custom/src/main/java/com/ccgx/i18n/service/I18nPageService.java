/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.ccgx.i18n.entity.I18nPage;
import com.ccgx.i18n.dao.I18nPageDao;

/**
 * 国际化页面Service
 * @author huangyun
 * @version 2017-12-28
 */
@Service
@Transactional(readOnly = true)
public class I18nPageService extends CrudService<I18nPageDao, I18nPage> {

	public I18nPage get(String id) {
		return super.get(id);
	}
	
	public List<I18nPage> findList(I18nPage i18nPage) {
		return super.findList(i18nPage);
	}
	
	public Page<I18nPage> findPage(Page<I18nPage> page, I18nPage i18nPage) {
		return super.findPage(page, i18nPage);
	}
	
	@Transactional(readOnly = false)
	public void save(I18nPage i18nPage) {
		super.save(i18nPage);
	}
	
	@Transactional(readOnly = false)
	public void delete(I18nPage i18nPage) {
		super.delete(i18nPage);
	}
	
}