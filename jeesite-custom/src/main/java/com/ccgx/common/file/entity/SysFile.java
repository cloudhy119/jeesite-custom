/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.common.file.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 电子文件Entity
 * @author ljx
 * @version 2017-11-23
 */
public class SysFile extends DataEntity<SysFile> {
	
	private static final long serialVersionUID = 1L;
	private String fileName;		// 文件名
	private String filePath;		// 文件相对路径
	private String itemId;		// 业务表id
	private String itemCode;		// 业务主体
	private String fileType;		// 文件扩展类型
	private String fileInfo;		// 文件简介
	
	public SysFile() {
		super();
	}

	public SysFile(String id){
		super(id);
	}

	@Length(min=0, max=255, message="文件名长度必须介于 0 和 255 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=0, max=255, message="文件相对路径长度必须介于 0 和 255 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Length(min=0, max=64, message="业务表id长度必须介于 0 和 64 之间")
	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	
	@Length(min=0, max=255, message="业务主体长度必须介于 0 和 255 之间")
	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	
	@Length(min=0, max=255, message="文件扩展类型长度必须介于 0 和 255 之间")
	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	@Length(min=0, max=255, message="文件简介长度必须介于 0 和 255 之间")
	public String getFileInfo() {
		return fileInfo;
	}

	public void setFileInfo(String fileInfo) {
		this.fileInfo = fileInfo;
	}
	
}