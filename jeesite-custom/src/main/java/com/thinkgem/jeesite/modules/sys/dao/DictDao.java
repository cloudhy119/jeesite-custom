/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Dict;

/**
 * 字典DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
	/**
	 * 通过"类型"和"描述"获取字典值
	 * @param type
	 * @param label
	 * @return
	 */
	public String getDicValue_ByTypeAndLabel(Dict dict);
	
	/**
	 * 通过"类型"字典值
	 * @param type
	 * @return
	 */
	public List<Map<String, String>> findDictByType(Dict dict);
	
}
