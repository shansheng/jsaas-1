package com.redxun.sys.echarts.manager;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.redxun.saweb.util.IdUtil;
import com.thoughtworks.xstream.XStream;
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.sys.echarts.dao.SysEchartsCustomDao;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.ui.view.model.ExportFieldColumn;
import org.springframework.web.multipart.MultipartFile;

@Service
public class SysEchartsCustomManager extends MybatisBaseManager<SysEchartsCustom> {
	
	@Resource
	private SysEchartsCustomDao sysEchartsCustomDao;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	ContextHandlerFactory contextHandlerFactory;
	@Resource
	FreemarkEngine freemarkEngine;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysEchartsCustomDao;
	}
	
	/**
	 * 通过key查找对象
	 */
	public SysEchartsCustom getByKey(String key) {
		String tenantId = ContextUtil.getCurrentTenantId();
		SysEchartsCustom echartsTemplate = this.sysEchartsCustomDao.getByAlias(key, tenantId);
		if(echartsTemplate == null) {
			echartsTemplate = this.sysEchartsCustomDao.getByAlias(key, ITenant.ADMIN_TENANT_ID);
		}
		return echartsTemplate;
	}
	
	/**
	 * 根据租户ID获取列表。
	 * @param tenantId
	 * @return
	 */
	public List<SysEchartsCustom> getByTenantId(String tenantId){
		return sysEchartsCustomDao.getByTenantId(tenantId);
	}

	public List<SysEchartsCustom> getSysEchartsTemplateByIds(String[] keys) {
		List<SysEchartsCustom> list = new ArrayList<SysEchartsCustom>();
		for (String key : keys) {
			SysEchartsCustom echartsTemplate = getByKey(key);
			if (BeanUtil.isEmpty(echartsTemplate)) {
				continue;
			}
			list.add(echartsTemplate);
		}
		return list;
	}
	
	/**
	 * 判断key值是否存在
	 */
	public SysEchartsCustom getKeyNotCurrent(String id, String key) {
		return sysEchartsCustomDao.getKeyNotCurrent(id, key);
	}
	
	public List<SysEchartsCustom> getByTreeId(String treeId, String name, String key) {
		return sysEchartsCustomDao.getByTreeId(treeId, name, key);
	}
	
	@SuppressWarnings("rawtypes")
	public List testQuery(String sql, QueryFilter queryFilter) {
		return sysEchartsCustomDao.testQuery(sql, queryFilter);
	}
	
	/*********************************
	 * Export Excel File 
	 * *******************************/
	public void downloadExcelFile(String title, List<ExportFieldColumn> headMap, JSONArray ja, String sortField, HttpServletResponse response){
        ByteArrayOutputStream os = new ByteArrayOutputStream();
    	try {
            exportExcelX(title,headMap,ja,null,0,os, sortField);
            byte[] content = os.toByteArray();
            InputStream is = new ByteArrayInputStream(content);
            // 设置response参数，可以打开下载页面
            response.reset();
            String fileName=title + ".xlsx";
            fileName = URLEncoder.encode(fileName,"UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename="+ fileName);
            response.setContentType("application/vnd.ms-excel");    
            response.setContentLength(content.length);
            
            FileUtil.downLoad(is, response);
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
        	if (null != os){ 
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
        }
    }
	
	@SuppressWarnings({ "unused", "static-access" })
	public static void exportExcelX(String title,List<ExportFieldColumn> headMap,JSONArray jsonArray,String datePattern,int colWidth, OutputStream out, String sortField) {
		if(datePattern == null) {
			datePattern = ExcelUtil.DEFAULT_DATE_PATTERN;
		}
        // 声明一个工作薄
        SXSSFWorkbook workbook = new SXSSFWorkbook(1000);//缓存
        workbook.setCompressTempFiles(true);
         //表头样式
        CellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER);
        Font titleFont = workbook.createFont();
        titleFont.setFontHeightInPoints((short) 20);
        titleFont.setBoldweight((short) 700);
        titleStyle.setFont(titleFont);
        // 列头样式
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        headerStyle.setFillForegroundColor(HSSFColor.WHITE.index);
        headerStyle.setBorderBottom(CellStyle.BORDER_THIN);
        headerStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);
        Font headerFont = workbook.createFont();
        headerFont.setFontHeightInPoints((short) 12);
        headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
        headerStyle.setFont(headerFont);
        // 单元格样式
        CellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        cellStyle.setFillForegroundColor(HSSFColor.WHITE.index);
        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyle.setBorderTop(CellStyle.BORDER_THIN);
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        Font cellFont = workbook.createFont();
        cellFont.setBoldweight(Font.BOLDWEIGHT_NORMAL);
        cellStyle.setFont(cellFont);
        // 生成一个(带标题)表格
        SXSSFSheet sheet = (SXSSFSheet) workbook.createSheet();
        //设置列宽
        int minBytes = colWidth<ExcelUtil.DEFAULT_COLOUMN_WIDTH ? ExcelUtil.DEFAULT_COLOUMN_WIDTH : colWidth;//至少字节数
        List<ExportFieldColumn> allHeadMap = new ArrayList<ExportFieldColumn>();
        getAllHeadMap(headMap, allHeadMap);
        int[] arrColWidth = new int[allHeadMap.size()];
        // 产生表格标题行,以及设置列宽
        String[] properties = new String[allHeadMap.size()];
        int ii = 0;
        int rowspan = getColumnLength(headMap);
        for (ExportFieldColumn field:allHeadMap) {
            String fieldName = field.getField();

            properties[ii] = fieldName;

            int bytes = fieldName.getBytes().length;
            arrColWidth[ii] =  bytes < minBytes ? minBytes : bytes;
            sheet.setColumnWidth(ii,arrColWidth[ii]*256);
            ii++;
        }
        // 遍历集合数据，产生数据行
        int rowIndex = 0;
        if(rowIndex == 65535 || rowIndex == 0){
            if ( rowIndex != 0 ) {
				sheet = (SXSSFSheet) workbook.createSheet();//如果数据超过了，则在第二页显示
			}

            SXSSFRow titleRow = (SXSSFRow) sheet.createRow(0);//表头 rowIndex=0
            titleRow.createCell(0).setCellValue(title);
            titleRow.getCell(0).setCellStyle(titleStyle);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, allHeadMap.size() - 1));
            
            //先创建表头行，才能进行表格合并
            rowIndex = 1;
            for(int l=0;l<rowspan;l++){
            	sheet.createRow(l+1);
            	rowIndex+=1;
            }
            //绘制表头
            drawTitleColumn(sheet, headerStyle, 1, 0, rowspan, headMap);            
        }
        
        Map<String, JSONObject> rowMap = new HashMap<String, JSONObject>();
        int startIndex = rowIndex;
        int countIndex = 0;
        for (int k = 0; k < jsonArray.size(); k++) {
        	Object obj = jsonArray.get(k);
            //绘制数据
            JSONObject jo = (JSONObject) JSON.toJSON(obj);
            SXSSFRow dataRow = (SXSSFRow) sheet.createRow(rowIndex);
            for (int i = 0; i < properties.length; i++)
            {
                SXSSFCell newCell = (SXSSFCell) dataRow.createCell(i);

                Object o =  jo.get(properties[i]);
                String cellValue = ""; 
                if(o==null) {
					cellValue = "";
				} else if(o instanceof Date) {
					cellValue = new SimpleDateFormat(datePattern).format(o);
				} else if(o instanceof Float || o instanceof Double) {
					cellValue= new BigDecimal(o.toString()).setScale(2,BigDecimal.ROUND_HALF_UP).toString();
				}  else {
					cellValue = o.toString();
				}

                newCell.setCellValue(cellValue);
                newCell.setCellStyle(cellStyle);
                
                //writed by Louis
                JSONArray jArr = new JSONArray();
                jArr = JSONArray.parseArray(sortField);
                for(Object arrObj : jArr) {
                	JSONObject oo = new JSONObject();
        			oo = (JSONObject)JSONObject.toJSON(arrObj);
        			
        			JSONObject rObj = new JSONObject();
        			if(!oo.getString("fieldName").equals(properties[i])) {
        				continue;
        			}
        			
        			if(k == 0) { //第一行
        				rObj.put("value", cellValue);
        				rObj.put("startIndex", rowIndex);
        				rObj.put("countIndex", 1);
        				rowMap.put(properties[i], rObj);
        			} else if(k == jsonArray.size() - 1) {
        				if(i == 0) {//首先判断是否*行*第一个值
        					if(rowMap.get(properties[i]).getString("value").equals(cellValue)) {
        						sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
        								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex"), i, i));
        					} else {
        						sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
        								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex") - 1, i, i));
        					}
        					rowMap.get(properties[i]).put("value", cellValue);
        				} else {//不是行第一个值，先判断前一个值是否与上一行的前一个值相同
        					//可能存在BUG，--观察
        					if(sheet.getRow(rowIndex - 1).getCell(i - 1).getStringCellValue().equals(rowMap.get(properties[i - 1]).get("value"))) { //same
        						if(rowMap.get(properties[i]).getString("value").equals(cellValue)) {
        							sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
            								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex"), i, i));
        						} else {
        							sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
            								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex") - 1, i, i));
        						}
        					} else { //diff
        						sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
        								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex") - 1, i, i));
        					}
        				}
        			} else {
        				if(i == 0) {//首先判断是否*行*第一个值
        					if(rowMap.get(properties[i]).getString("value").equals(cellValue)) {//上一行的value和当前行的cellValue是否相同
        						rowMap.get(properties[i]).put("countIndex", rowMap.get(properties[i]).getIntValue("countIndex") + 1);
        					} else {
    							sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
        								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex") - 1, i, i));
        						rowMap.get(properties[i]).put("countIndex", 1);
        						rowMap.get(properties[i]).put("startIndex", rowIndex);
        						rowMap.get(properties[i]).put("value", cellValue);
        					}
        				} else {//不是行第一个值，先判断前一个值是否与上一行的前一个值相同
        					if(sheet.getRow(rowIndex - 1).getCell(i - 1).getStringCellValue().equals(rowMap.get(properties[i - 1]).get("value"))) { //same, 可以和上面的单元格合并
        						if(rowMap.get(properties[i]).getString("value").equals(cellValue)) {//上一行的value和当前行的cellValue是否相同
            						rowMap.get(properties[i]).put("countIndex", rowMap.get(properties[i]).getIntValue("countIndex") + 1);
            					} else {
        							sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
            								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex") - 1, i, i));
            						rowMap.get(properties[i]).put("countIndex", 1);
            						rowMap.get(properties[i]).put("startIndex", rowIndex);
            						rowMap.get(properties[i]).put("value", cellValue);
            					}
        					} else { //diff value
    							sheet.addMergedRegion(new CellRangeAddress(rowMap.get(properties[i]).getIntValue("startIndex"), 
        								rowMap.get(properties[i]).getIntValue("startIndex") + rowMap.get(properties[i]).getIntValue("countIndex") - 1, i, i));
        						rowMap.get(properties[i]).put("countIndex", 1);
        						rowMap.get(properties[i]).put("startIndex", rowIndex);
        						rowMap.get(properties[i]).put("value", cellValue);
        					}
        				}
        			}
                }
            }
            rowIndex++;
        }
        //System.err.println(rowMap);
        try {
            workbook.write(out);            
            workbook.dispose();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
        	try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    }
	
	private static void getAllHeadMap(List<ExportFieldColumn> headMaps,List<ExportFieldColumn> allHeadMap){
    	for(ExportFieldColumn headMap:headMaps){
    		if(headMap.getChildColumn().size()>0){
    			getAllHeadMap(headMap.getChildColumn(),allHeadMap);
    		}else{
    			allHeadMap.add(headMap);
    		}
    	}
    }
	
	private static int getColumnLength2(ExportFieldColumn headColumn){
    	int newl = 1;
    	if(headColumn.getChildColumn().size()>0){
	    	List<ExportFieldColumn> headColumns = headColumn.getChildColumn();
	    	int l1 = getColumnLength(headColumns);
	    	newl = newl +l1;
    	}
    	return newl;
    }
    private static int getColumnLength(List<ExportFieldColumn> headColumns){
    	int l = 0;
    	for(ExportFieldColumn headColumn:headColumns){    		
			int newl = getColumnLength2(headColumn);
			if(newl>l){
				l = newl;
			}
    	}
    	return l;
    }
    
    private static void drawTitleColumn2(SXSSFSheet sheet,CellStyle headerStyle,int row,int column,int rowspan,ExportFieldColumn fieldColumn){
    	SXSSFRow titleRow = (SXSSFRow) sheet.getRow(row);
    	if(fieldColumn.getColspan()>1){
    		CellRangeAddress region = new CellRangeAddress(row, row, column, column+fieldColumn.getColspan()-1);
    		setRegionStyle(sheet, region, headerStyle);
        	sheet.addMergedRegion(region);//合并列
    	}
    	if(fieldColumn.getChildColumn().size()>0){
    		List<ExportFieldColumn> subFieldColumn = fieldColumn.getChildColumn();
    		drawTitleColumn(sheet,headerStyle,row+1,column,rowspan,subFieldColumn);
    	}else if(rowspan>row){
    		CellRangeAddress region = new CellRangeAddress(row, rowspan, column, column);
    		setRegionStyle(sheet, region, headerStyle);
    		sheet.addMergedRegion(region);//合并行
    	}
    	titleRow.createCell(column).setCellValue(fieldColumn.getHeader());
    	titleRow.getCell(column).setCellStyle(headerStyle);
    }
    
    private static void drawTitleColumn(SXSSFSheet sheet,CellStyle headerStyle,int startRow,int startColumn,int rowspan,List<ExportFieldColumn> fieldColumns){
    	int sn = 0;
    	for(ExportFieldColumn fieldColumn:fieldColumns){
    		drawTitleColumn2(sheet,headerStyle,startRow,startColumn+sn,rowspan,fieldColumn);
    		sn += fieldColumn.getColspan();
    	}
    }
    
    public static void setRegionStyle(SXSSFSheet sheet, CellRangeAddress region,
            CellStyle headerStyle) {

        for (int i = region.getFirstRow(); i <= region.getLastRow(); i++) {

        	SXSSFRow row = (SXSSFRow) sheet.getRow(i);
            if (row == null) {
				row = (SXSSFRow) sheet.createRow(i);
			}
            for (int j = region.getFirstColumn(); j <= region.getLastColumn(); j++) {
            	SXSSFCell cell = (SXSSFCell) row.getCell(j);
                if (cell == null) {
                    cell = (SXSSFCell) row.createCell(j);
                    cell.setCellValue("");
                }
                cell.setCellStyle(headerStyle);
            }
        }
    }

	public void doImport(MultipartFile file) throws Exception {
		List<SysEchartsCustom> chartList = getEchartsCustomExt(file);
		String tenantId = ContextUtil.getCurrentTenantId();
		for(SysEchartsCustom chart : chartList) {
			doImport(chart, tenantId);
		}
	}

	private void doImport(SysEchartsCustom chart, String tenantId) {
		chart.setTenantId(tenantId);
		boolean keyHasExisted = sysEchartsCustomDao.getByKey(chart.getKey()).size() > 0 ? true : false;
		if(keyHasExisted) {
			update(chart);
			return;
		}
		chart.setId(IdUtil.getId());
		create(chart);
	}

	private List<SysEchartsCustom> getEchartsCustomExt(MultipartFile file) throws IOException {
		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		xstream.alias("sysEchartsCustom", SysEchartsCustom.class);
		xstream.autodetectAnnotations(true);
		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		List<SysEchartsCustom> list = new ArrayList<>();
		while((zipIs.getNextZipEntry()) != null){
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");
			SysEchartsCustom chart = (SysEchartsCustom) xstream.fromXML(xml);
			list.add(chart);
		}

		return list;
	}
}
