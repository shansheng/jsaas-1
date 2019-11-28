
package com.redxun.sys.core.manager;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.elastic.JestService;
import com.redxun.core.excel.ExcelReaderUtil;
import com.redxun.core.excel.IExcelRowReader;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.dao.SysExcelTemplateDao;
import com.redxun.sys.core.entity.SysDataBat;
import com.redxun.sys.core.entity.SysExcelTemplate;

/**
 * 
 * <pre> 
 * 描述：sys_excel_template 处理接口
 * 作者:ray
 * 日期:2018-12-01 18:32:53
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysExcelTemplateManager extends MybatisBaseManager<SysExcelTemplate>{
	
	@Resource
	private SysExcelTemplateDao sysExcelTemplateDao;
	
	@Resource
	private JdbcTemplate jdbcTemplate;	
	@Resource
	private SysDataBatManager sysDataBatManager;
	@Resource
	private JestService jestService;
	@Resource
	private GroovyEngine groovyEngine;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysExcelTemplateDao;
	}
	
	public SysExcelTemplate getByAlias(String alias){
		return sysExcelTemplateDao.getByAlias(alias);
	}
	
	public boolean isAliasExist(SysExcelTemplate template){
		String tenantId=ContextUtil.getCurrentTenantId();
		Integer rtn= sysExcelTemplateDao.getCountByKey(template.getTemplateNameAlias(), tenantId, template.getId());
		return rtn>0;
	}
	
	/**
	 * [{
			"titleStartRow": 1,
			"name": "Sheet1",
			"idx": "0",
			"contentStartRow": 2,
			"tableName": "OS_GROUP",
			"fields": [{
				"comment": "用户组ID",
				"isNull": false,
				"columnType": "varchar",
				"charLen": 64,
				"decimalLen": 0,
				"intLen": 0,
				"fieldName": "GROUP_ID_",
				"mapType": "pkId",
				"mapTypeName": "由系统产生主键"
			}, {
				"comment": "维度ID",
				"isNull": true,
				"columnType": "varchar",
				"charLen": 64,
				"decimalLen": 0,
				"intLen": 0,
				"fieldName": "DIM_ID_",
				"mapType": "excelField",
				"mapTypeName": "从excel字段获取",
				"excelFieldName": "c",
				"mapValue": "2"
			}]
		}]
	 * @param alias
	 * @param is
	 * @param fileName
	 * @throws IOException 
	 */
	public void saveToTable(String uploadId, String fileId,String appId,
			String alias,String srcSys,InputStream is,String fileName) throws Exception{
		SysExcelTemplate excelTemplate= getByAlias( alias);
		if(excelTemplate==null){
			throw new RuntimeException("请传入消息别名");
		}
		String conf= excelTemplate.getTemplateConf();
		JSONObject json=JSONObject.parseObject(conf);
		JSONArray tables=json.getJSONArray("jsonAry");
		
		Map<String,Integer> startPos= getStartPos( tables);
		
		final Map<String,List<List<String>>> resultMap=new HashMap<>();
		ExcelReaderUtil.readExcel(fileName, is,startPos, new IExcelRowReader() {
			@Override
			public void handRow(String sheetName, Integer sheetIndex, int curRow, List<String> cellList) {
				sheetIndex=sheetIndex-1;
				List<String> cpList=new ArrayList<>(cellList);
				String key="sheet_" + sheetIndex;
				if(resultMap.containsKey(key)){
					resultMap.get(key).add(cpList);
				}
				else{
					List<List<String>> list=new ArrayList<>();
					list.add(cpList);
					resultMap.put(key, list);
				}
			}
		});
		try{
			for(int i=0;i<tables.size();i++){
				JSONObject tableJson=tables.getJSONObject(i);
				int idx=tableJson.getIntValue("idx");
				
				List<List<String>> rows=resultMap.get("sheet_" + idx);
				if(rows==null || rows.size()==0) continue;
				String batId=IdUtil.getId();

				String  dataType=tableJson.getString("dataType");
				
				String  tableName="";
				
				if("db".equals(dataType)){
					tableName=tableJson.getString("tableName");
					//添加批次ID
					addBat(uploadId, fileId, appId, alias, batId,tableName,srcSys);
					handTable(rows, tableJson,batId);
				}
				else{
					tableName=tableJson.getString("esTable");
					//添加批次ID
					addBat(uploadId, fileId, appId, alias, batId,tableName,srcSys);
					//添加ES
					handEs(rows, tableJson, batId);
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		
		
	}
	
	private Map<String,Integer> getStartPos(JSONArray tables){
		Map<String,Integer> map=new HashMap<>();
		for(int i=0;i<tables.size();i++){
			JSONObject tableJson=tables.getJSONObject(i);
			int idx=tableJson.getIntValue("idx");
			int startRow=tableJson.getIntValue("contentStartRow");
			map.put("sheet_" + idx, startRow);
		}
		return map;
	}
	
	/**
	 * 添加批次
	 * @param uploadId
	 * @param fileId
	 * @param appId
	 * @param alias
	 * @param batId
	 */
	private void addBat(String uploadId, String fileId,String appId,
			String alias,String batId ,String tableName,String srcSys){
		SysDataBat bat=new SysDataBat();
		bat.setId(batId);
		bat.setUploadId(uploadId);
		bat.setAppId(appId);
		bat.setExcelId(fileId);
		bat.setServiceName(alias);
		bat.setTableName(tableName);
		
		bat.setType(SysDataBat.INPUT_TYPE_BAT);
		sysDataBatManager.create(bat);
		
	}
	
	private void handEs(List<List<String>> rows,JSONObject tableJson,String batId) throws IOException{
		
		//开始表名
		String  tableName=tableJson.getString("esTable");
		
		JSONArray fieldAry= tableJson.getJSONArray("fields");
		
		JsonResult<JSONArray> result= getValidField(fieldAry);
		
		JSONArray validFieldAry =result.getData();
		
		boolean hasPk=result.getSuccess();
	
		
		List<String> list=new ArrayList<>();
		Map<String,String> dataMap=new HashMap<>();
		
		for(int i=0;i<rows.size();i++){
			List<String> row=rows.get(i);
			JSONObject json= getEsRow(row,validFieldAry, batId);
			if(hasPk){
				dataMap.put(json.getString("id"), json.getString("json"));
			}
			else{
				list.add(json.getString("json"));
			}
		}
		if(hasPk){
			jestService.bulk(tableName, dataMap);
		}
		else{
			jestService.bulk(tableName, list);
		}
		
		
		
	}
	
	/**
	 * 处理单表。
	 * @param sheet
	 * @param tableJson
	 * @param batId
	 */
	private void handTable(List<List<String>> rows,JSONObject tableJson,String batId){
		//开始表名
		String  tableName=tableJson.getString("tableName");
		
		JSONArray fieldAry= tableJson.getJSONArray("fields");
		
		JSONArray validFieldAry= getValidField(fieldAry).getData();
		
		String sql="insert into " + tableName ;
		List<String> fields=new ArrayList<>();
		List<String> vals=new ArrayList<>();

		for(int i=0;i<validFieldAry.size();i++){
			JSONObject obj=validFieldAry.getJSONObject(i);
			String mapType=obj.getString("mapType");
			//图片类型的数据跳过
			if("image".equals(mapType)) continue;
			fields.add(obj.getString("fieldName"));
			vals.add("?");
		}
		sql+="(" + StringUtil.join(fields, ",") +") values (" + StringUtil.join(vals, ",") +")";
		
		List<Object[]> args=new ArrayList<>();
		
		List<Object[]> imgs=new ArrayList<>();
		
		int index = 0;
		try {
			for(int i=0;i<rows.size();i++){
				index = i;
				List<String> row=rows.get(i);
				JSONObject json= getRow( row, fieldAry,batId);
				if(json==null)continue;
				Object[] valRow=  (Object[]) json.get("data");
				args.add(valRow);
				String id=json.getString("id");
				String img=json.getString("img");
				//图片。
				if(StringUtil.isNotEmpty(img) && StringUtil.isNotEmpty(id) ){
					String[] aryImg=img.split(",");
					for(String imgPath:aryImg){
						Object[] imgObj=new Object[5];
						imgObj[0]=IdUtil.getId();
						imgObj[1]=id;
						imgObj[2]=tableName;
						imgObj[3]=imgPath;
						imgObj[4]=new Date();
						imgs.add(imgObj);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("第"+(index+1)+"行："+e.getMessage());
		}
		
		jdbcTemplate.batchUpdate(sql, args);
		if(imgs.size()>0){
			String imgSql="insert into DATA_INPUT_IMAGE (ID_,REF_ID_,TABLE_NAME,PATH_,CREATE_TIME_) "
					+ " values (?,?,?,?,?) ";
			jdbcTemplate.batchUpdate(imgSql, imgs);
		}
	}
	
	/**
	 * 获取有效的字段。
	 * @param ary
	 * @return
	 */
	private JsonResult<JSONArray>  getValidField(JSONArray ary){
		JsonResult<JSONArray> result=new JsonResult<>();
		JSONArray rtnAry=new JSONArray();
		boolean hasPk=false;
		for(int i=0;i<ary.size();i++){
			JSONObject obj=ary.getJSONObject(i);
			String mapType=obj.getString("mapType");
			if(StringUtil.isEmpty(mapType)) continue;
			if("pkId".equals(mapType)){
				hasPk=true;
			}
			rtnAry.add(obj);
		}
		result.setSuccess(hasPk);
		result.setData(rtnAry);
		return result;
	}
	
	private JSONObject getEsRow(List<String> row,JSONArray fieldAry,String batId){
		JSONObject rtn=new JSONObject();
		
		String pk="";
		JSONObject json=new JSONObject();
		for(int i=0;i<fieldAry.size();i++){
			
			JSONObject obj=fieldAry.getJSONObject(i);
			String mapType=obj.getString("mapType");
			String fieldName=obj.getString("fieldName");
			
			//主键
			if("pkId".equals(mapType)){
				pk=IdUtil.getId();
				json.put(fieldName, pk);
			}
			//固定值
			else if("fixValue".equals(mapType)){
				json.put(fieldName, obj.getString("mapValue"));
			}
			//excel字段
			else if("excelField".equals(mapType)){
				int col=obj.getIntValue("mapValue");
				String cellVal=row.get(col);
				Object val=getEsCellVal(cellVal, obj);
				json.put(fieldName, val);
			}
			//批次ID
			else if("batId".equals(mapType)){
				json.put(fieldName, batId);
			}
		
		}
		
		rtn.put("json", json.toJSONString());
		rtn.put("id", pk);
		
		return rtn;
	}
	
	/**
	 * 获取一行数据，如果有图片，单独存储。
	 * @param row
	 * @param fieldAry
	 * @param batId
	 * @param hasImg
	 * @return
	 * {
	 * 	id:"",
	 * 	img:"",
	 * 	data:[]
	 * }
	 */
	private JSONObject getRow(List<String> row,JSONArray fieldAry,String batId){
	
		String pkId="";
		String img="";
		
		List<Object> list=new ArrayList<>();
		
		JSONObject json=new JSONObject();
		
		int colN = 0;
		
		try {
			StringBuffer flag = new StringBuffer();
			for(int i=0;i<fieldAry.size();i++){
				
				JSONObject obj=fieldAry.getJSONObject(i);
				String mapType=obj.getString("mapType");
				JSONObject valid=obj.getJSONObject("valid");
				//主键
				if("pkId".equals(mapType)){
					String id=IdUtil.getId();
					//验证规则
					flag.append(validField(valid, id));
					list.add(id);
					pkId=id;
				}
				//固定值
				else if("fixValue".equals(mapType)){
					String val = obj.getString("mapValue");
					//验证规则
					flag.append(validField(valid, val));
					list.add(val);
				}
				//excel字段
				else if("excelField".equals(mapType)){
					int col=obj.getIntValue("mapValue");
					String cellVal= row.get(col);
					colN = col;
					Object val=getCellVal( cellVal, obj);
					//验证规则
					flag.append(validField(valid, val));
					list.add(val);
				}
				else if("date".equals(mapType)){
					list.add( new Date());
				}
				else if("curUser".equals(mapType)){
					list.add(ContextUtil.getCurrentUserId());
				}
				//批次ID
				else if("batId".equals(mapType)){
					//验证规则
					validField(valid, batId);
					list.add(batId);
				}
				else if("image".equals(mapType)){
					int col=obj.getIntValue("mapValue");
					String cellVal= row.get(col);
					//验证规则
					flag.append(validField(valid, cellVal));
					img=cellVal;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("第"+(colN+1)+"列："+e.getMessage());
		}
		Object[] fieldVals=new Object[list.size()];
		for(int i=0;i<list.size();i++){
			fieldVals[i]=list.get(i);
		}
		json.put("data", fieldVals);
		json.put("id", pkId);
		json.put("img", img);
		
		return json;
	}
	
	private boolean validField(JSONObject valid,Object val) {
		if(valid!=null) {
			String script = valid.getString("conf");
			String name = valid.getString("name");
			if(StringUtil.isEmpty(script))return true;
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("data", val);
			boolean rtn= (boolean) groovyEngine.executeScripts(script, param);
			return rtn;
		}
		return true;
	}
	
	/**
	 * 获取excel表格的值。
	 * @param cell
	 * @param obj
	 * @return
	 */
	private Object getCellVal(String cellVal,JSONObject obj){
		String columnType=obj.getString("columnType");
		Object val=null;
		if("varchar".equals(columnType)){
			val=cellVal;
		}
		else if("date".equals(columnType)){
			String format= obj.getString("format");
			if(StringUtil.isEmpty(cellVal))return null;
			val= com.redxun.core.util.DateUtil.parseDate(cellVal, format);
		}
		else if("number".equals(columnType)){
			int decimalLen= obj.getInteger("decimalLen");
			if(decimalLen==0){
				val=Integer.parseInt(cellVal);
			}
			else{
				val=Float.parseFloat(cellVal);
			}
		}
		if(val==null) val="";
		return val;
	}
	
	private boolean isNumer(String columnType){
		int idx="integer,long,short,byte,double,float".indexOf(columnType);
		return idx>=0;
	}
	
	private boolean isInt(String columnType){
		int idx="integer,long,short,byte".indexOf(columnType);
		return idx>=0;
	}
	
	private boolean isFloat(String columnType){
		int idx="double,float".indexOf(columnType);
		return idx>=0;
	}
	
	private Object getEsCellVal(String cellVal,JSONObject obj){
		String columnType=obj.getString("columnType");
		Object val=null;
		if("text".equals(columnType) || "keyword".equals(columnType)){
			val=cellVal;
		}
		else if("date".equals(columnType)){
			String format= obj.getString("format");
			val= com.redxun.core.util.DateUtil.parseDate(cellVal, format);;
		}
		else if(isNumer( columnType)){
			if(isInt(columnType)){
				val=Integer.parseInt(cellVal);
			}
			else{
				val=Float.parseFloat(cellVal);
			}
		}
		if(val==null) val="";
		return val;
	}
}
