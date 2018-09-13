/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.ccgx.i18n.entity.I18nResource;
import com.ccgx.i18n.dao.I18nResourceDao;

/**
 * 国际化资源Service
 * @author huangyun
 * @version 2017-12-28
 */
@Service
@Transactional(readOnly = true)
public class I18nResourceService extends CrudService<I18nResourceDao, I18nResource> {

	@Autowired
	private I18nResourceDao i18nResourceDao;
	
	public I18nResource get(String id) {
		return super.get(id);
	}
	
	public List<I18nResource> findList(I18nResource i18nResource) {
		return super.findList(i18nResource);
	}
	
	public Page<I18nResource> findPage(Page<I18nResource> page, I18nResource i18nResource) {
		return super.findPage(page, i18nResource);
	}
	
	@Transactional(readOnly = false)
	public void save(I18nResource i18nResource) {
		super.save(i18nResource);
	}
	
	@Transactional(readOnly = false)
	public void delete(I18nResource i18nResource) {
		super.delete(i18nResource);
	}

	/**
	 * 根据资源的键（name）和语言代码（lang）判断是否已存在
	 * @param i18nResource
	 */
	public List<I18nResource> findByNameAndLang(I18nResource i18nResource) {
		List<I18nResource> resourceList = i18nResourceDao.findByNameAndLang(i18nResource);
		return resourceList;
	}
	
	public void update(I18nResource i18nResource) {
		i18nResource.preUpdate();
		i18nResourceDao.update(i18nResource);
	}

	public void deleteByCondition(I18nResource del) {
		i18nResourceDao.deleteByCondition(del);
	}
	
}