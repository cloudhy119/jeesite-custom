/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 人员扩展信息Entity
 * @author huangyun
 * @version 2018-01-18
 */
public class SysUserExt extends DataEntity<SysUserExt> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 关联sys_user表
	private String address;		// 地址
	private String corpsName;		// 公司名称
	private String duties;		// 职务
	private String fax;		// 传真
	private String zipCode;		// 邮编
	private String creditCode;		// 企业信用代码
	private String sex;		// 性别
	private String interestSystem; //关注的系统服务
	private String warnSwitch; //是否开启预警提醒 1开 0关
	private String warnType; //warnSwitch为1时才有效。预警提醒方式。1：系统提醒 2：邮件提醒
	
	public SysUserExt() {
		super();
	}

	public SysUserExt(String id){
		super(id);
	}

	@NotNull(message="关联sys_user表不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=1000, message="地址长度必须介于 0 和 1000 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=1000, message="公司名称长度必须介于 0 和 1000 之间")
	public String getCorpsName() {
		return corpsName;
	}

	public void setCorpsName(String corpsName) {
		this.corpsName = corpsName;
	}
	
	@Length(min=0, max=1, message="职务长度必须介于 0 和 1 之间")
	public String getDuties() {
		return duties;
	}

	public void setDuties(String duties) {
		this.duties = duties;
	}
	
	@Length(min=0, max=32, message="传真长度必须介于 0 和 32 之间")
	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}
	
	@Length(min=0, max=32, message="邮编长度必须介于 0 和 32 之间")
	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	
	@Length(min=0, max=64, message="企业信用代码长度必须介于 0 和 64 之间")
	public String getCreditCode() {
		return creditCode;
	}

	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}
	
	@Length(min=0, max=1, message="性别长度必须介于 0 和 1 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getInterestSystem() {
		return interestSystem;
	}

	public void setInterestSystem(String interestSystem) {
		this.interestSystem = interestSystem;
	}

	public String getWarnSwitch() {
		return warnSwitch;
	}

	public void setWarnSwitch(String warnSwitch) {
		this.warnSwitch = warnSwitch;
	}

	public String getWarnType() {
		return warnType;
	}

	public void setWarnType(String warnType) {
		this.warnType = warnType;
	}
	
}