/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.modules.sys.dao.DictDao;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends CrudService<DictDao, Dict> {
	
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	/**
	 * 通过"类型"和"描述"获取字典值
	 * @param type
	 * @param label
	 * @return
	 */
	public String getDicValue_ByTypeAndLabel(String type, String label){
		Dict dict = new Dict();
		dict.setType(type);
		dict.setLabel(label);
		return dao.getDicValue_ByTypeAndLabel(dict);
	}
	
	/**
	 * 通过"类型"字典值
	 * @param type
	 * @return
	 */
	public List<Map<String, String>> findDictByType(String type){
		Dict dict = new Dict();
		dict.setType(type);
		return dao.findDictByType(dict);
	}
}
