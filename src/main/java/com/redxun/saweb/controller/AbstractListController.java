package com.redxun.saweb.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.redxun.core.query.*;
import com.redxun.core.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.IJson;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.export.PoiTableBuilder;
import com.redxun.ui.view.model.IGridColumn;

public abstract class AbstractListController extends BaseController {

	@Resource
	protected PoiTableBuilder poiTableBuilder;
	@Resource
	protected IJson iJson;
	
	/**
	 * 获得查询的过滤条件
	 * @param request
	 * @return
	 */
	protected abstract QueryFilter getQueryFilter(HttpServletRequest request);
	
	public abstract List<?>  getPage(QueryFilter queryFilter);
	
	public abstract  Long  getTotalItems(QueryFilter queryFilter);
	
	
	/**
	 * 分页返回查询列表，包括导出单页，所有页
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("listData")
	public void listData(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String export=request.getParameter("_export");
		//是否导出
		if(StringUtils.isNotEmpty(export)){
			String exportAll=request.getParameter("_all");
			if(StringUtils.isNotEmpty(exportAll)){
				exportAllPages(request,response);
			}else{
				exportCurPage(request,response);
			}
		}else{
			response.setContentType("application/json");
			QueryFilter queryFilter=getQueryFilter(request);
			
			List<?> list=getPage(queryFilter);
			JsonPageResult<?> result=new JsonPageResult(list,queryFilter.getPage().getTotalItems());
			
			String json= JSON.toJSONStringWithDateFormat(result, "yyyy-MM-dd HH:mm:ss");
			PrintWriter pw=response.getWriter();
			pw.println(json);
			pw.close();
		}
	}
	
	
	
	/**
	 * 导出当前页记录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	//@RequestMapping("exportCurPage")
	public void exportCurPage(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 根据前台的列来生成列表
		String columns = URLDecoder.decode(request.getParameter("columns"),"UTF-8");

		QueryFilter queryFilter = getQueryFilter(request);

		//构建查询条件
		setQueryFilter(queryFilter,request);

		List<?> list = getPage(queryFilter);
		
		response.setContentType("application/ms-excel");
		Date curDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmm");

		response.setHeader("Content-Disposition", "attachment;filename=" + sdf.format(curDate) + ".xls");
		ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
		
		List<IGridColumn> gridColumns = poiTableBuilder.constructColumns(columns);
		Workbook wb = poiTableBuilder.writeTable(gridColumns, list);
		wb.write(outByteStream);
		// 生成文件
		OutputStream out = response.getOutputStream();
		out.write(outByteStream.toByteArray());
		out.flush();
	}

	/**
	 * 写入记录到文件中
	 * @param dataList
	 * @param columns
	 * @param index
	 * @return
	 * @throws Exception
	 */
	private File writeRecordsToFile(List<?> dataList, List<IGridColumn> columns, int index) throws Exception {
		FileUtil.checkAndCreatePath(ContextUtil.getUserTmpDir());
		File file = new File(ContextUtil.getUserTmpDir() + "/records_" + index + ".xls");
		FileOutputStream fos = new FileOutputStream(file);
		Workbook wb = poiTableBuilder.writeTable(columns, dataList);
		wb.write(fos);
		return file;
	}
	
	/**
	 * 下载所有页记录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportAllPages")
	public void exportAllPages(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 根据前台的列来生成列表
		String columns = URLDecoder.decode(request.getParameter("columns"),"UTF-8");
		ZipOutputStream zipOutputStream = new ZipOutputStream(response.getOutputStream());
		Date curDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmm");
		response.setContentType("application/zip");
		response.addHeader("Content-Disposition", "attachment; filename=\"all_" + sdf.format(curDate) + ".zip\"");

		QueryFilter queryFilter = getQueryFilter(request);

		//构建查询条件
		setQueryFilter(queryFilter,request);
		// 构建下载列
		List<IGridColumn> gridColumns = poiTableBuilder.constructColumns(columns);

		List<?> list = getPage(queryFilter);
		// 把文件写至临时目录
		File file = writeRecordsToFile(list, gridColumns,  + 1);
		// 添加文件至压缩流
		FileUtil.zipFile(file, zipOutputStream);
		// 删除该临时文件
		file.delete();

		zipOutputStream.close();
	}

	private void setQueryFilter(QueryFilter queryFilter,HttpServletRequest request){
		try{
			String params = URLDecoder.decode(request.getParameter("params"),"UTF-8");
			if(params ==null)return;;
			JSONArray jsonArr=JSONArray.parseArray(params);
			FieldLogic fieldLogic =queryFilter.getFieldLogic();
			if(fieldLogic==null)return;;
			List<IWhereClause> commands =fieldLogic.getCommands();
			for(int i=0;jsonArr!=null&&i<jsonArr.size();i++){
				JSONObject os =(JSONObject)jsonArr.get(i);
				String name = (String)os.get("name");
				String value = (String)os.get("value");
				if(name!=null){
					String[] nameList = name.split("_");
					int length =nameList.length;
					QueryParam iWhereClause =new QueryParam();
					String newName = "";
					for(int k=1;k<length-2;k++){
						if(StringUtil.isNotEmpty(nameList[k])){
							newName =newName+nameList[k]+"_";
						}
					}
					iWhereClause.setFieldName(newName);
					iWhereClause.setOpType(nameList[length-1]);
					iWhereClause.setValue(value);
					iWhereClause.setFieldType(nameList[length-2]);
					commands.add(iWhereClause);
				}
				fieldLogic.setCommands(commands);
				queryFilter.setFieldLogic(fieldLogic);
			}
		}catch (Exception e){

		}
	}

}
