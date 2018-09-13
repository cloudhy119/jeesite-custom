package com.ccgx.common.table2excel;

import javax.servlet.http.HttpServletResponse;

import com.ccgx.common.table2excel.bean.HtmlTableBean;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thinkgem.jeesite.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/table2excel")
public class Table2ExcelController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(Table2ExcelController.class);

	@RequestMapping(value = {"export"}, method = RequestMethod.POST)
	public void export(String json, String fileName, String title, HttpServletResponse response) {
		json = StringEscapeUtils.unescapeHtml4(json);
		fileName = fileName + ".xlsx";
		ObjectMapper mapper = new ObjectMapper();
		HtmlTableBean bean = null;
		try {
			bean = mapper.readValue(json, HtmlTableBean.class);
			new Table2Excel(title, bean).export(response, fileName).dispose();
		} catch (Exception e) {
			logger.error("", e);
		}
	}
}
