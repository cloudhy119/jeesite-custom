package com.ccgx.common.table2excel;

import com.ccgx.common.table2excel.bean.BodysBean;
import com.ccgx.common.table2excel.bean.FootsBean;
import com.ccgx.common.table2excel.bean.HeadsBean;
import com.ccgx.common.table2excel.bean.HtmlTableBean;
import com.thinkgem.jeesite.common.utils.Encodes;
import com.thinkgem.jeesite.common.utils.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

public class Table2Excel {
	/**
	 * 工作薄对象
	 */
	private SXSSFWorkbook wb;
	
	/**
	 * 工作表对象
	 */
	private Sheet sheet;
	
	private int rowNum = 0;
	private String title;

	/**
	 * html table json bean
	 */
	private HtmlTableBean table;
	
	public Table2Excel(String title, HtmlTableBean table) {
		this.table = table;
		this.title = title;
	}
	
	public Table2Excel export(HttpServletResponse response, String fileName) {
		packageHead();
		packageBody();
		packageFoot();
		
		try {
			write(response, fileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return this;
	}
	
	/**
	 * 处理表头
	 */
	private void packageHead() {
		this.wb = new SXSSFWorkbook(500);
		this.sheet = wb.createSheet("Export");
//		int rowCount = heads.size(); //表头行数
		int colCount = 0; //表头列数
		for(HeadsBean head : table.getHeads().get(0)) {
			if(StringUtils.isNotBlank(head.getColspan())) {
				colCount += Integer.parseInt(head.getColspan());
			} else {
				colCount++;
			}
		}
		
		//处理行列合并
		// Create title
		if (StringUtils.isNotBlank(title)){
			Row titleRow = sheet.createRow(rowNum++);
			titleRow.setHeightInPoints(30);
			Cell titleCell = titleRow.createCell(0);
			CellStyle style = wb.createCellStyle();
			style.setAlignment(CellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			Font titleFont = wb.createFont();
			titleFont.setFontName("Arial");
			titleFont.setFontHeightInPoints((short) 12);
			titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
			style.setFont(titleFont);
			titleCell.setCellStyle(style);
			titleCell.setCellValue(title);
			sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), titleRow.getRowNum(), colCount-1));
		}
		int headline = 0;
		for(List<HeadsBean> headList: table.getHeads()) {
			Row headerRow = sheet.createRow(rowNum);
			headerRow.setHeightInPoints(16);
			int colNum = 0;
			for(HeadsBean head : headList) {
				int toRow = 0; //合并到哪一行
				int toCol = 0; //合并到哪一列
				String rowspan = head.getRowspan();
				String colspan = head.getColspan();
				if(StringUtils.isNotBlank(rowspan) && Integer.parseInt(rowspan) > 1) {
					toRow = rowNum + Integer.parseInt(rowspan) - 1;
					//往此列下面的行填值
					for(int i = 0; i < Integer.parseInt(rowspan) - 1; i++) {
						List<HeadsBean> heads = table.getHeads().get(headline + i + 1);
						heads.add(colNum, new HeadsBean());
					}
				} else {
					toRow = rowNum;
				}
				if(StringUtils.isNotBlank(colspan) && Integer.parseInt(colspan) > 1) {
					toCol = colNum + Integer.parseInt(colspan) - 1;
				} else {
					toCol = colNum;
				}
				Cell cell = headerRow.createCell(colNum);
				CellStyle style = wb.createCellStyle();
				style.setAlignment(CellStyle.ALIGN_CENTER);
				style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
				style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
				style.setFillPattern(CellStyle.SOLID_FOREGROUND);
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
				if(toRow > rowNum || toCol > colNum) {
					CellRangeAddress cra = new CellRangeAddress(rowNum, toRow, colNum, toCol);
					sheet.addMergedRegion(new CellRangeAddress(rowNum, toRow, colNum, toCol)); //行列合并
					setRegionStyle(sheet, cra, style);
				}
				cell.setCellStyle(style);
				cell.setCellValue(head.getText());
				if(StringUtils.isNotBlank(head.getText())) {
					sheet.setColumnWidth(colNum, head.getText().getBytes().length * 256);
				} else {
					sheet.autoSizeColumn(colNum);
				}
				if(StringUtils.isNotBlank(colspan)) {
					colNum += Integer.parseInt(colspan);
				} else {
					colNum++;
				}
			}
			headline++;
			rowNum++;
		}
	}
	/**
	 * 组装body
	 * 目前body和foot不支持行列合并的情况
	 */
	private void packageBody() {
		List<List<BodysBean>> bodys = table.getBodys();
		for(List<BodysBean> beans : bodys) {
			Row row = sheet.createRow(rowNum++);
			int colNum = 0;
			for(BodysBean bean : beans) {
				Cell cell = row.createCell(colNum);
				cell.setCellValue(bean.getText().trim());
				CellStyle style = wb.createCellStyle();
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框    
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框    
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框    
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
				style.setAlignment(CellStyle.ALIGN_LEFT);
				style.setDataFormat(wb.createDataFormat().getFormat("@")); //解决长数字变科学计数法
				cell.setCellStyle(style);
				colNum++;
			}
		}
	}

	/**
	 * 目前body和foot不支持行列合并的情况
	 */
	private void packageFoot() {
		List<List<FootsBean>> foots = table.getFoots();
		for(List<FootsBean> beans : foots) {
			Row row = sheet.createRow(rowNum++);
			int colNum = 0;
			for(FootsBean bean : beans) {
				Cell cell = row.createCell(colNum);
				cell.setCellValue(bean.getText().trim());
				CellStyle style = wb.createCellStyle();
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框    
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框    
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框    
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框 
				cell.setCellStyle(style);
				colNum++;
			}
		}
	}
	/**
	 * 输出到客户端
	 * @param fileName 输出文件名
	 */
	public Table2Excel write(HttpServletResponse response, String fileName) throws IOException{
		response.reset();
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename="+Encodes.urlEncode(fileName));
		write(response.getOutputStream());
		return this;
	}
	/**
	 * 输出数据流
	 * @param os 输出数据流
	 */
	public Table2Excel write(OutputStream os) throws IOException{
		wb.write(os);
		return this;
	}
	/**
	 * 清理临时文件
	 */
	public Table2Excel dispose(){
		wb.dispose();
		return this;
	}

	private void setRegionStyle(Sheet sheet, CellRangeAddress region, CellStyle cs) {
		for (int i = region.getFirstRow(); i <= region.getLastRow(); i++) {
			Row row = sheet.getRow(i);
			if (row == null)
				row = sheet.createRow(i);
			for (int j = region.getFirstColumn(); j <= region.getLastColumn(); j++) {
				Cell cell = row.getCell(j);
				if (cell == null) {
					cell = row.createCell(j);
					cell.setCellValue("");
				}
				cell.setCellStyle(cs);
			}
		}
	}

}
