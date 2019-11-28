var excelId="";
	//当前激活的tab idx。
var curTabIndex=0;
//{"sheet_0":[{name:"",val:""},{name:"",val:""}]}
var jsonHeaders={};
//tabs
var gridTab=null;

var timeFormat=[{"format":"yyyy-MM-dd"},{"format":"yyyy-MM-dd HH:mm:ss"}]



var myFieldEditors=[{mapType:'',mapTypeName:'',editor:null},
    {mapType:'excelField',mapTypeName:'从excel字段获取',editor:'excelFieldEditor'},
	  {mapType:'fixValue',mapTypeName:'固定值',editor:'textboxEditor'},
	  {mapType:'batId',mapTypeName:'批次ID',editor:null},
	  {mapType:'image',mapTypeName:'图片字段',editor:'excelFieldEditor'},
	  {mapType:'date',mapTypeName:'系统时间',editor:null},
	  {mapType:'curUser',mapTypeName:'当前用户',editor:null},
	  {mapType:'pkId',mapTypeName:'由系统产生主键',editor:null}];	
	
mini.parse();

	

function initForm() {
	if (!pkId) {
		//myFieldEditors=dbEditors;
		return;
	}
	var url = __rootPath +"/sys/core/sysExcelTemplate/getJson.do";
	$.post(url, {id : pkId}, function(json) {
		var formExcel=new mini.Form("#formExcel");
		formExcel.setData(json);
		
		excelId=json.excelTemplateFile;
		var templateConf=mini.decode(json.templateConf);
		
		var jsonAry=templateConf.jsonAry;
		jsonHeaders=templateConf.jsonHeaders;
		var data={sheets:jsonAry};
		console.info(jsonAry);
		var html=baiduTemplate('tabsBaiduTemplate',data);
		var tabs=$("#result");
		tabs.html(html);
		
		mini.parse();
		
		for(var i=0;i<jsonAry.length;i++){
			var o=jsonAry[i];
			var form=new mini.Form("#tab_" + o.idx);
			form.setData(o);
			var dataType=o.dataType;
			var grid=mini.get("tableExcelGrid_" + o.idx);
			grid.setData(o.fields);
			
			toggleColumn(grid,dataType);
		}
		
	});
}

function toggleColumn(grid,dataType){
	var colFormat=grid.getColumn("format");
	var isNullFormat=grid.getColumn("isNull");
	var commentFormat=grid.getColumn("comment");
	var show=dataType=="db";
	if(show){
		grid.showColumn(colFormat);
		grid.showColumn(isNullFormat);
		grid.showColumn(commentFormat);
	}
	else{
		grid.hideColumn(colFormat);
		grid.hideColumn(isNullFormat);
		grid.hideColumn(commentFormat);
	}
}

//保存Json
function onSaveConfigJson() {
	if(!excelId){
		mini.alert("模板文件不能为空！");
		return;
	}
	var formExcel=new mini.Form("#formExcel");
	formExcel.validate();
	if(!formExcel.isValid()) return;
	var formData=formExcel.getData();
	//选择文件
	formData.excelTemplateFile=excelId;
	//验证表格是否合法
	var conf=getConfigJson();
	if(!conf.success){
		if(conf.msg){
			alert(conf.msg);
			return;
		}
		alert("请检查excel的配置!");
		return;
	}
	delete conf.success;
	delete conf.msg;
	
	formData.templateConf=mini.encode(conf);
	var url =__rootPath +"/sys/core/sysExcelTemplate/save.do";
	var config={
        	url:url,
        	method:'POST',
        	postJson:true,
        	data:formData,
        	success:function(result){
        		CloseWindow('ok');
        	}
     }
	_SubmitJson(config);
}

//选择表
function onTable(e) {
	var btnEdit = e.sender;
	var i=btnEdit.id.replace("tableName_","");
	var tableExcelGrid = mini.get('tableExcelGrid_' + i);
	openTableDialog("",function(data){
		btnEdit.setValue(data.tableName);
		btnEdit.setText(data.tableName);
		var url = __rootPath + "/sys/db/sysDb/getByName.do?tbName=" + data.tableName ;
		$.get(url, function(metaData) {
			
			for(var i=0;i<metaData.columnList.length;i++){
				var o=metaData.columnList[i];
				delete o.defaultValue;
				delete o.fkRefColumn;
				delete o.fkRefTable;
				delete o.index;
				delete o.isFk;
				delete o.isPk;
				delete o.isRequired;
				delete o.label;
				delete o.tableName;
			}
			tableExcelGrid.setData(metaData.columnList);
		});
	})
}

	
function changeEditor(e){
    var record = e.record, field = e.field;
    
   	if(field=='mapValue') {
   		var editor=null;
   		var mapType=record.mapType;
	   	var editorType=getMyEditor(mapType);
		if(editorType){
			editor=mini.get(editorType);
			if("excelField"==mapType){
				var key="sheet_" + curTabIndex;
				var data=jsonHeaders[key];
				editor.setData(data)
			}
		}
		e.editor=editor;
		e.column.editor=editor;
   	}
   	else if(field=='format'){
   		if(record.columnType=="varchar"){
   			var editor=mini.get("timeFormatEditor");
   			e.editor=editor;
			e.column.editor=editor;
   		}
   	}
}		

function getMyEditor(fieldType){
	for(var i=0;i<myFieldEditors.length;i++){
		if(myFieldEditors[i].mapType==fieldType){
			return myFieldEditors[i].editor;
		}
	}
}
	
function doUpload() {
	var files=document.getElementById("excelTemplateFile").files;
	if(files.length==0){
		alert("请选择文件!")
		return ;
	}
	var formData = new FormData();
	formData.append("myfile", files[0]);
	
	
	$.ajax({
		url :__rootPath + "/sys/core/sysExcelTemplate/templateUpload.do",
		type : 'POST',
        contentType:false,
        processData:false,
		data : formData,
		success : function(result) {
			if(!result.success){
				return;
			}
			var tabs=$("#result");
			
			var data=result.data;
			var sheets=data.sheets;
			for(var i=0;i<sheets.length;i++){
				var o=sheets[i];
				o.dataType="db";
			}
			excelId=data.fileId;
			
			var html=baiduTemplate('tabsBaiduTemplate',data);
			tabs.html(html);
			
		    mini.parse();
		    
		    gridTab=mini.get("gridTab");
		    gridTab.on("activechanged",function(e){
		    	var idx= e.tab.tabId.replace("tab_","")
		    	curTabIndex=idx;
		    })
		},
		error : function(returndata) {
			console.info(returndata);
		}
	});
	
};
		
		
function loadHeader(sheet){
	if(!excelId){
		alert("请检查是否上传了excel模版!");
		return;
	}
	var headStart=mini.get("titleStartRow_" + sheet).getValue();
	var url=__rootPath +"/sys/core/sysExcelTemplate/getHeader.do";
	var params={excelId:excelId,sheet:sheet,headStart:headStart};
	$.post(url,params,function(result){
		if(!result.success){
			alert(result.message);
			return;
		}
		
		mini.showMessageBox({
            width: 250,
            title: "提示信息",
            buttons: ["ok"],
            message: "加载成功!",
            showModal: false,
            callback: function (action) {
            	var key="sheet_" + sheet;
				jsonHeaders[key]=result.data;
            }
        });
	})
}

function onFieldChanged(e){
	  var item=e.sender.getSelected();
	  var grid=mini.get("tableExcelGrid_" + curTabIndex );
	  var row=grid.getEditorOwnerRow(e.sender);
	  grid.updateRow(row,{excelFieldName:item.name})
}

function emptyRender(e) {
        var record = e.record;
        var isNull = record.isNull;
        
        var arr = [ {'key' : true, 'value' : '是','css' : 'red'}, 
		            {'key' : false ,'value' : '否','css' : 'green'} ];
		
		return $.formatItemValue(arr,isNull);
}

function changeContentStart(e){
	var id=e.sender.id;
	var idx=id.replace("titleStartRow_","");
	var idxContent="contentStartRow_" + idx;
	mini.get(idxContent).setValue(e.value + 1);
}

function getConfigJson(){
	var jsonAry=[];
	var success=false;
	for(var key in jsonHeaders){
		var idx=key.replace("sheet_","");
		var form=new mini.Form("#tab_" + idx);
		var grid=new mini.get("#tableExcelGrid_" + idx);
		var data=form.getData();
		var msg="";
		if(data.length==0){
			continue;
		}
		//var rtn={excelField:0,batId:0};
		var rtn=validGridData(grid.getData());
		if(rtn.excelField ==0){
			msg="SHEET("+idx +")没有映射EXCEL字段";
			break;
		}
		if(rtn.batId !=1){
			msg="SHEET("+idx +")需要映射批次ID字段!";
			break;
		}
		var gridData=grid.getData();
		//刪除字段
		removeGridData(gridData);
		data.fields=gridData;
		jsonAry.push(data);
		success=true;
	}
	var obj={success:success,msg:msg, jsonAry:jsonAry,jsonHeaders:jsonHeaders}
	return obj;
}
	
function removeGridData(data){
	for(var i=0;i<data.length;i++){
		var row=data[i];
		delete row._id;
		delete row._uid;
		delete row._state;
	}
}

function validGridData(data){
	var rtn={excelField:0,batId:0};
	
	for(var i=0;i<data.length;i++){
		var row=data[i];
		if(row.mapType=="excelField"){
			rtn.excelField++;
		};
		if(row.mapType=="batId"){
			rtn.batId++;
		};
	}
	return rtn;
}

function delSelect(e){
	var btn=e.sender;
	var idx=btn.idx;
	var grid=mini.get("tableExcelGrid_" + idx);
	grid.removeRows(grid.getSelecteds())
}

function validSelect(e){
	var btn=e.sender;
	var idx=btn.idx;
	var grid=mini.get("tableExcelGrid_" + idx);
	var row = grid.getSelected();
	if(!row){
		alert("请选择一个字段");
		return;
	}
	_OpenWindow({
		title:"验证规则",
		height:450,
		width:650,
		url:__rootPath+'/bpm/form/formValidRule/dialog.do',
		onload:function(){
			var win=this.getIFrameEl().contentWindow;
			win.setData(row.valid);
		},
		ondestroy:function(action){
			if(action!='ok') return;
			var win=this.getIFrameEl().contentWindow;
			var data=win.getData();
			grid.updateRow(row,data);
		}
	});
}

function changeDataType(e){
	var val=e.value;
	var idx=e.sender.idx;
	var dbObj=mini.get("tableName_" + idx);
	var esObj=mini.get("esTable_" + idx);
	var grid=mini.get("tableExcelGrid_" + idx);
	
	var mapType=grid.getColumn("mapType").editor;
	
	toggleColumn(grid,val);
	
	if(val=="db"){
		dbObj.setVisible(true);
		esObj.setVisible(false);
	}
	else{
		dbObj.setVisible(false);
		esObj.setVisible(true);
	}
}

function loadFields(e){
	var idx=e.sender.idx;
	var grid=mini.get("tableExcelGrid_" + idx);
	var url= __rootPath +"/sys/core/sysEsQuery/getMapping.do";
	var esTable=e.value;
	var params={alias:esTable};
	$.post(url,params,function(rtn){
		var data=rtn.data;
		var ary=[];
		for(var i=0;i<data.length;i++){
			var o=data[i];
			if(o.keyword) continue;
			var obj={fieldName:o.name,comment:o.name,columnType:o.type};
			ary.push(obj);
			grid.setData(ary);
		}
	})
}