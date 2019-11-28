package com.redxun.sys.util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.ExceptionUtil;

public class ExcelUtil {
	/**
	 * excel读写工具类
	 */
	private static Logger logger = Logger.getLogger(ExcelUtil.class);
	private final static String xls = "xls";
	private final static String xlsx = "xlsx";

	
	
	/**
	 * 获取excel 头。
	 * @param fileName
	 * @param is
	 * @param sheetIdx
	 * @param headStart
	 * @return
	 */
	public static JsonResult getExcelHeader(String fileName,InputStream is,int sheetIdx,int headStart){
		JsonResult result=new JsonResult(true);
		try{
			Workbook wb= getWorkBook( fileName, is);
			Sheet sheet=wb.getSheetAt(sheetIdx);
			Row row= sheet.getRow(headStart);
			short minColIx = row.getFirstCellNum();
			short maxColIx = row.getLastCellNum();
			JSONArray ary=new JSONArray();
			for(short colIx=minColIx; colIx<maxColIx; colIx++) {
			   Cell cell = row.getCell(colIx);
			   if(cell == null) {
			     continue;
			   }
			   String key=cell.getStringCellValue();
			   JSONObject json=new JSONObject();
			   json.put("name", key);
			   json.put("val", colIx);
			   ary.add(json);
			}
			result.setData(ary);
		}
		catch(Exception ex){
			result.setSuccess(false);
			result.setMessage("获取EXCEl头出错");
			result.setData(ExceptionUtil.getExceptionMessage(ex));
		}
		return result;
		
	}

	public static Workbook getWorkBook(String fileName,InputStream is) {
		
		// 创建Workbook工作薄对象，表示整个excel
		Workbook workbook = null;
		try {
			fileName=fileName.toLowerCase();
			// 根据文件后缀名不同(xls和xlsx)获得不同的Workbook实现类对象
			if (fileName.endsWith(xls)) {
				// 2003
				workbook = new HSSFWorkbook(is);
			} else if (fileName.endsWith(xlsx)) {
				// 2007
				workbook = new XSSFWorkbook(is);
			}
		} catch (IOException e) {
			logger.info(e.getMessage());
		}
		return workbook;
	}

	public static String getCellValue(Cell cell) {
		String cellValue = "";
		if (cell == null)
			return cellValue;

		switch (cell.getCellType()) {
			case Cell.CELL_TYPE_NUMERIC: // 数字
				cellValue = String.valueOf(cell.getNumericCellValue());
				break;
			case Cell.CELL_TYPE_STRING: // 字符串
				cellValue = String.valueOf(cell.getStringCellValue());
				break;
			case Cell.CELL_TYPE_BOOLEAN: // Boolean
				cellValue = String.valueOf(cell.getBooleanCellValue());
				break;
			case Cell.CELL_TYPE_FORMULA: // 公式
				cellValue = String.valueOf(cell.getCellFormula());
				break;
			case Cell.CELL_TYPE_BLANK: // 空值
				cellValue = "";
				break;
			case Cell.CELL_TYPE_ERROR: // 故障
				cellValue = "非法字符";
				break;
			default:
				cellValue = "未知类型";
				break;
		}
		return cellValue;
	}
}
