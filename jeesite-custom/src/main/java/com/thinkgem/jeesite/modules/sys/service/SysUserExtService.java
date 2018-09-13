/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.dao.SysUserExtDao;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.SysUserExt;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 人员扩展信息Service
 * @author huangyun
 * @version 2018-01-18
 */
@Service
@Transactional(readOnly = true)
public class SysUserExtService extends CrudService<SysUserExtDao, SysUserExt> {

	@Autowired
	private UserDao userDao;
	
	public SysUserExt get(String id) {
		return super.get(id);
	}
	
	public List<SysUserExt> findList(SysUserExt sysUserExt) {
		return super.findList(sysUserExt);
	}
	
	public Page<SysUserExt> findPage(Page<SysUserExt> page, SysUserExt sysUserExt) {
		return super.findPage(page, sysUserExt);
	}
	
	@Transactional(readOnly = false)
	public void save(SysUserExt sysUserExt) {
		super.save(sysUserExt);
	}
	
	@Transactional(readOnly = false)
	public void updateUserCenterInfo(User user, SysUserExt userExt) {
		User dbUser = userDao.get(user.getId());
		dbUser.setName(user.getName());
		dbUser.setEmail(user.getEmail());
		dbUser.setPhone(user.getPhone());
		dbUser.setMobile(user.getMobile());
		if(StringUtils.isNotBlank(user.getPassword())) {
			dbUser.setPassword(SystemService.entryptPassword(user.getPassword()));
		}
		dbUser.setRemarks(user.getRemarks());
		userDao.update(dbUser);
		UserUtils.clearCache(dbUser);
		
		SysUserExt dbUserExt = new SysUserExt();
		SysUserExt userExtQuery = new SysUserExt();
		userExtQuery.setUser(user);
		List<SysUserExt> extList = this.findList(userExtQuery);
		if(extList != null && !extList.isEmpty()) {
			dbUserExt = extList.get(0);
		}
		dbUserExt.setCorpsName(userExt.getCorpsName());
		dbUserExt.setDuties(userExt.getDuties());
		dbUserExt.setAddress(userExt.getAddress());
		dbUserExt.setZipCode(userExt.getZipCode());
		dbUserExt.setFax(userExt.getFax());
		dbUserExt.setUser(dbUser);
		dbUserExt.setWarnSwitch(userExt.getWarnSwitch());
		dbUserExt.setWarnType(userExt.getWarnType());
		this.save(dbUserExt);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysUserExt sysUserExt) {
		super.delete(sysUserExt);
	}
	
}