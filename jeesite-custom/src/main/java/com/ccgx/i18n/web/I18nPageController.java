/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.ccgx.i18n.entity.I18nPage;
import com.ccgx.i18n.service.I18nPageService;

/**
 * 国际化页面Controller
 * @author huangyun
 * @version 2017-12-28
 */
@Controller
@RequestMapping(value = "${adminPath}/i18n/i18nPage")
public class I18nPageController extends BaseController {

	@Autowired
	private I18nPageService i18nPageService;

	@ModelAttribute
	public I18nPage get(@RequestParam(required=false) String id) {
		I18nPage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = i18nPageService.get(id);
		}
		if (entity == null){
			entity = new I18nPage();
		}
		return entity;
	}
	
	@RequiresPermissions("i18n:i18nPage:view")
	@RequestMapping(value = {"list", ""})
	public String list(I18nPage i18nPage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<I18nPage> page = i18nPageService.findPage(new Page<I18nPage>(request, response), i18nPage); 
		model.addAttribute("page", page);
		return "ccgx/i18n/i18nPageList";
	}

	@RequiresPermissions("i18n:i18nPage:view")
	@RequestMapping(value = "form")
	public String form(I18nPage i18nPage, Model model) {
		model.addAttribute("i18nPage", i18nPage);
		return "ccgx/i18n/i18nPageForm";
	}

	@RequiresPermissions("i18n:i18nPage:edit")
	@RequestMapping(value = "save")
	public String save(I18nPage i18nPage, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, i18nPage)){
			return form(i18nPage, model);
		}
		i18nPageService.save(i18nPage);
		addMessage(redirectAttributes, "保存国际化页面成功");
		return "redirect:"+Global.getAdminPath()+"/i18n/i18nPage/?repage";
	}
	
	@RequiresPermissions("i18n:i18nPage:edit")
	@RequestMapping(value = "delete")
	public String delete(I18nPage i18nPage, RedirectAttributes redirectAttributes) {
		i18nPageService.delete(i18nPage);
		addMessage(redirectAttributes, "删除国际化页面成功");
		return "redirect:"+Global.getAdminPath()+"/i18n/i18nPage/?repage";
	}

}