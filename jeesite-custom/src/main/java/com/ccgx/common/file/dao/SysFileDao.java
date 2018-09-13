/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.common.file.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.ccgx.common.file.entity.SysFile;

/**
 * 电子文件DAO接口
 * @author ljx
 * @version 2017-11-23
 */
@MyBatisDao
public interface SysFileDao extends CrudDao<SysFile> {
	
	public List<SysFile> getByItemId(String itemId);
	public void deleteByCondition(SysFile file);
	
}