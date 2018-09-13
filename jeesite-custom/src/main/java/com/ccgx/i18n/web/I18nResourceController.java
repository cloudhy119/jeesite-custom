/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.ccgx.i18n.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ccgx.i18n.MessageResource;
import com.ccgx.i18n.entity.I18nPage;
import com.ccgx.i18n.entity.I18nResource;
import com.ccgx.i18n.service.I18nPageService;
import com.ccgx.i18n.service.I18nResourceService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 国际化资源Controller
 * @author huangyun
 * @version 2017-12-28
 */
@Controller
@RequestMapping(value = "${adminPath}/i18n/i18nResource")
public class I18nResourceController extends BaseController {

	@Autowired
	private I18nResourceService i18nResourceService;
	@Autowired
	private I18nPageService i18nPageService;
	@Autowired
	private MessageResource messageSource;
	
	@ModelAttribute
	public I18nResource get(@RequestParam(required=false) String id) {
		I18nResource entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = i18nResourceService.get(id);
		}
		if (entity == null){
			entity = new I18nResource();
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<I18nPage> list = i18nPageService.findList(new I18nPage());
		Map<String, Object> mapParent = Maps.newHashMap();
		mapParent.put("id", "0");
		mapParent.put("pId", "0");
		mapParent.put("name", "归属页面");
		mapList.add(mapParent);
		for (I18nPage page : list){
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", page.getId());
			map.put("pId", "0");
			map.put("name", page.getPageName());
			mapList.add(map);
		}
		return mapList;
	}
	
	@RequiresPermissions("i18n:i18nResource:view")
	@RequestMapping(value = {"list", ""})
	public String list(I18nResource i18nResource, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(i18nResource.getLang())) {
			i18nResource.setLang("zh_CN");
		}
		Page<I18nResource> page = i18nResourceService.findPage(new Page<I18nResource>(request, response), i18nResource); 
		List<I18nPage> pageList = i18nPageService.findList(new I18nPage());
		model.addAttribute("page", page);
		model.addAttribute("pageList", pageList);
		return "ccgx/i18n/i18nResourceList";
	}

	@RequiresPermissions("i18n:i18nResource:view")
	@RequestMapping(value = "form")
	public String form(I18nResource i18nResource, Model model) {
		model.addAttribute("i18nResource", i18nResource);
		Map<String, Object> langMap = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(i18nResource.getName())) {
			I18nResource query = new I18nResource();
			query.setName(i18nResource.getName());
			List<I18nResource> langList = i18nResourceService.findByNameAndLang(query);
			for(I18nResource resource : langList) {
				langMap.put(resource.getLang(), resource.getText());
			}
		}
		model.addAttribute("langMap", langMap);
		return "ccgx/i18n/i18nResourceForm";
	}

	@RequiresPermissions("i18n:i18nResource:edit")
	@RequestMapping(value = "save")
	public String save(I18nResource i18nResource, String[] langType, String[] langVal, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, i18nResource)){
			return form(i18nResource, model);
		}
		if(StringUtils.isBlank(i18nResource.getId())) { //要新增，先判断资源的键是否重复
			I18nResource query = new I18nResource();
			query.setName(i18nResource.getName());
			List<I18nResource> resouceList = i18nResourceService.findByNameAndLang(query);
			if(resouceList != null && !resouceList.isEmpty()) {
				addMessage(redirectAttributes, "国际化资源的键已存在：" + i18nResource.getName() + "，请重新命名");
				return "redirect:"+Global.getAdminPath()+"/i18n/i18nResource/?repage";
			}
		}
		
		//如果是已有数据，先删除指定键的所有资源，然后全部insert
		if(StringUtils.isNotBlank(i18nResource.getId())) {
			I18nResource oldRes = i18nResourceService.get(i18nResource.getId());
			if(oldRes != null) {
				//删除
				I18nResource del = new I18nResource();
				del.setName(oldRes.getName());
				i18nResourceService.deleteByCondition(del);
			}
		}
		//新增
		for(int i = 0; i < langType.length; i++) {
			String lang = langType[i];
			String text = langVal[i];
			if(StringUtils.isNotBlank(text)) {
				i18nResource.setId(IdGen.uuid());
				i18nResource.setLang(lang);
				i18nResource.setText(text);
				i18nResource.setIsNewRecord(true);
				i18nResourceService.save(i18nResource);
				//直接更新到MessageSource中，使实时生效
				ConcurrentMap<String, String> properties = messageSource.getCachedProperties().get(lang); 
				properties.put(i18nResource.getName(), text);
			}
		}
		addMessage(redirectAttributes, "保存国际化资源成功");
		return "redirect:"+Global.getAdminPath()+"/i18n/i18nResource/form?id=" + i18nResource.getId();
	}
	
	@RequiresPermissions("i18n:i18nResource:edit")
	@RequestMapping(value = "delete")
	public String delete(I18nResource i18nResource, RedirectAttributes redirectAttributes) {
		i18nResourceService.delete(i18nResource);
		//直接从MessageSource中移除，使实时生效
		ConcurrentMap<String, String> properties = messageSource.getCachedProperties().get(i18nResource.getLang());
		properties.remove(i18nResource.getName());
		addMessage(redirectAttributes, "删除国际化资源成功");
		return "redirect:"+Global.getAdminPath()+"/i18n/i18nResource/?repage";
	}

}