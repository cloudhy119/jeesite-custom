package com.thinkgem.jeesite.common.utils.word;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.TextAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTP;

/**
 * @description 
 * 用一个docx文档作为模板，然后替换其中的内容，再写入目标文档中。
 * 
 */
public abstract class ImportModuleWord {

	public static void main(String[] args) {
		
	}

	/**
	 * 替换段落里面的变量
	 * 
	 * @param para 要替换的段落
	 * @param params 参数
	 * 
	 * @note
	 * 模板方法   templeReplaceInPara
	 * 单纯的替换变量，不做其他操作
	 */
	public abstract void replaceInPara(XWPFParagraph para, Map<String, Object> params) ;
	
	/**
	 * 用一个docx文档作为模板，然后替换其中的内容，再写入目标文档中。
	 * @param params 
	 * @param filePath 文档路径
	 * @throws Exception
	 */
	public void templateWrite(Map<String, Object> params, String filePath) throws Exception {
		
		InputStream is = new FileInputStream(filePath);
		XWPFDocument doc = new XWPFDocument(is);
		// 替换段落里面的变量
		replaceInPara(doc, params);
		// 替换表格里面的变量
		replaceInTable(doc, params);
		OutputStream os = new FileOutputStream(filePath);
		doc.write(os);
		close(os);
		close(is);
	}

	/**
	 * 用一个docx文档作为模板，然后替换其中的内容，再写入目标文档中，可向表格中动态添加数据。
	 * @param params 替换参数的 map集
	 * @param paramsList 动态添加数据的 list集
	 * @param tableNo 文档中第几个表格需要动态添加数据
	 * @param filePath 文档路径
	 * @throws Exception
	 */
	public void templateWrite(Map<String, Object> params, List<Map<Integer, Object>> paramsList, int tableNo, String filePath) throws Exception {

		InputStream is = new FileInputStream(filePath);
		XWPFDocument doc = new XWPFDocument(is);
		// 替换段落里面的变量
		replaceInPara(doc, params);
		// 替换表格里面的变量
		replaceInTable(doc, params);
		addRowInTable(doc, paramsList, tableNo);
		OutputStream os = new FileOutputStream(filePath);
		doc.write(os);
		close(os);
		close(is);
	}

	/**
	 * 替换段落里面的变量
	 * 
	 * @param doc
	 *            要替换的文档
	 * @param params
	 *            参数
	 * @notes
	 * 从文档中解析出各个段落
	 * 再从各个段落中找到变量进行替换
	 */
	private void replaceInPara(XWPFDocument doc, Map<String, Object> params) {
		Iterator<XWPFParagraph> iterator = doc.getParagraphsIterator();
		XWPFParagraph para;
		while (iterator.hasNext()) {
			para = iterator.next();
			replaceInPara(para, params);
		}
	}
	
	
	/**
	 * 模板方法
	 * @param para
	 * @param params
	 */
	public static void templeReplaceInPara(XWPFParagraph para, Map<String, Object> params) {
		List<XWPFRun> runs;
		Matcher matcher;
		if (matcher(para.getParagraphText()).find()) {
			runs = para.getRuns();
			for (int i = 0; i < runs.size(); i++) {
				XWPFRun run = runs.get(i);
				String runText = run.toString();
				matcher = matcher(runText);
				if (matcher.find()) {
					while ((matcher = matcher(runText)).find()) {
						runText = matcher.replaceFirst(String.valueOf(params.get(matcher.group(1))));
					}
					// 直接调用XWPFRun的setText()方法设置文本时，在底层会重新创建一个XWPFRun，把文本附加在当前文本后面，
					// 所以我们不能直接设值，需要先删除当前run,然后再自己手动插入一个新的run。
					para.removeRun(i);
					para.insertNewRun(i).setText(runText);
				}
			}
		}
	}

	/**
	 * 替换表格里面的变量
	 * 
	 * @param doc
	 *            要替换的文档
	 * @param params
	 *            参数
	 */
	private void replaceInTable(XWPFDocument doc, Map<String, Object> params) {
		Iterator<XWPFTable> iterator = doc.getTablesIterator();
		XWPFTable table;
		List<XWPFTableRow> rows;
		List<XWPFTableCell> cells;
		List<XWPFParagraph> paras;
		while (iterator.hasNext()) {
			table = iterator.next();
			rows = table.getRows();
			for (XWPFTableRow row : rows) {
				cells = row.getTableCells();
				for (XWPFTableCell cell : cells) {
					paras = cell.getParagraphs();
					for (XWPFParagraph para : paras) {
						replaceInPara(para, params);
					}
				}
			}
		}
	}
	
	/**
	 * 表格添加行
	 * @param doc 文档
	 * @param paramsList 参数List
	 * @param tableNo 文档中第几个表格需要添加行
	 */
	public static void addRowInTable(XWPFDocument doc, List<Map<Integer, Object>> paramsList, int tableNo) {
		List<XWPFTable> tables = doc.getTables();
		//选择文档中的第几个表格
		XWPFTable table = tables.get(tableNo);
		CTP ctp = CTP.Factory.newInstance();
		XWPFParagraph p = new XWPFParagraph(ctp, doc);
		p.setAlignment(ParagraphAlignment.LEFT);
		p.setVerticalAlignment(TextAlignment.CENTER);

		XWPFRun r = p.createRun();
		// 设置字体大小
		r.setFontSize(14);
		// 设置使用何种字体
		r.setFontFamily("Courier");
//		// 设置上下两行之间的间距
//		r.setTextPosition(20);
		
		for (Map<Integer, Object> param : paramsList) {
			XWPFTableRow row = table.createRow();
			for (int i = 0; i < param.size(); i++) {
				row.getCell(i).setText(String.valueOf(param.get(i)));
			}
			XWPFTableCell cell = row.getCell(0);
			cell.addParagraph(p);
		}

	}

	/**
	 * 正则匹配字符串
	 * ${}
	 * @param str
	 * @return
	 */
	public static Matcher matcher(String str) {
		Pattern pattern = Pattern.compile("\\$\\{(.+?)\\}", Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(str);
		return matcher;
	}

	/**
	 * 关闭输入流
	 * 
	 * @param is
	 */
	private static void close(InputStream is) {
		if (is != null) {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 关闭输出流
	 * 
	 * @param os
	 */
	private static void close(OutputStream os) {
		if (os != null) {
			try {
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
