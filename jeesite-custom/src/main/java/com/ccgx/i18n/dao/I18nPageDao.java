/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.dao;

import com.ccgx.i18n.entity.I18nPage;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 国际化页面DAO接口
 * @author huangyun
 * @version 2017-12-28
 */
@MyBatisDao
public interface I18nPageDao extends CrudDao<I18nPage> {
	
}