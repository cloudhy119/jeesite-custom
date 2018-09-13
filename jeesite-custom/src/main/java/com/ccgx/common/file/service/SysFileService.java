/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.common.file.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccgx.common.file.dao.SysFileDao;
import com.ccgx.common.file.entity.SysFile;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 电子文件Service
 * @author ljx
 * @version 2017-11-23
 */
@Service
@Transactional(readOnly = true)
public class SysFileService extends CrudService<SysFileDao, SysFile> {
	@Autowired
	private SysFileDao sysFileDao;

	public SysFile get(String id) {
		return super.get(id);
	}
	public void deleteByCondition(SysFile file) {
		sysFileDao.deleteByCondition(file);
	}
	
	public List<SysFile> findList(SysFile sysFile) {
		return super.findList(sysFile);
	}
	public String findListForCkfinder(SysFile sysFile) {
		String files = "";
		List<SysFile> fileList = super.findList(sysFile);
		if(fileList != null && !fileList.isEmpty()) {
			for(SysFile file : fileList) {
				files += "|" + file.getFilePath();
			}
		}
		return files;
	}
	
	public Page<SysFile> findPage(Page<SysFile> page, SysFile sysFile) {
		return super.findPage(page, sysFile);
	}
	
	@Transactional(readOnly = false)
	public void save(SysFile sysFile) {
		super.save(sysFile);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysFile sysFile) {
		super.delete(sysFile);
	}
}