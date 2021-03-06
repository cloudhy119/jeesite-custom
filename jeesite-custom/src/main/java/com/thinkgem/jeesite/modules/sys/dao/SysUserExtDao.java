/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.SysUserExt;

/**
 * 人员扩展信息DAO接口
 * @author huangyun
 * @version 2018-01-18
 */
@MyBatisDao
public interface SysUserExtDao extends CrudDao<SysUserExt> {
	
}