/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.ccgx.i18n.entity.I18nResource;

/**
 * 国际化资源DAO接口
 * @author huangyun
 * @version 2017-12-28
 */
@MyBatisDao
public interface I18nResourceDao extends CrudDao<I18nResource> {

	List<I18nResource> findByNameAndLang(I18nResource i18nResource);

	void deleteByCondition(I18nResource del);
	
}