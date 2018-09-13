package com.ccgx.sys.index;

import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 后台系统首页
 * @author huangyun
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/index")
public class AdminIndexController {

    @Autowired
    private OfficeService officeService;
	
	@RequestMapping(value = {""})
	public String list(Model model) {
//		model.addAttribute("list", areaService.findAll());
		return "ccgx/index/adminIndex";
	}

}
