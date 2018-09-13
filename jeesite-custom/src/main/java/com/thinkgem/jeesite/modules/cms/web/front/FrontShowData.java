package com.thinkgem.jeesite.modules.cms.web.front;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "${frontPath}/show")
public class FrontShowData {

	@RequestMapping
	public String indexShowData(Model model) {
		return "modules/cms/front/themes/basic/frontIndexShow";
	}
}
