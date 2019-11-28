var fieldEditors=[{mapType:'',mapTypeName:'',editor:null},
		{mapType:'field',mapTypeName:'从字段获取',editor:'fieldEditor',hasValue:true},
		{mapType:'mainField',mapTypeName:'从主表字段获取',editor:'mainFieldEditor',hasValue:true},
		{mapType:'fixValue',mapTypeName:'固定值',editor:'textboxEditor',hasValue:true},
		{mapType:'scriptValue',mapTypeName:'从脚本函数计算获取',editor:'buttonEditEditor',hasValue:true},
		{mapType:'srcPkId',mapTypeName:'源表主键字段值',editor:null,hasValue:false},
		{mapType:'pkId',mapTypeName:'由系统产生的主键字段值',editor:null,hasValue:false},
		{mapType:'mainPkId',mapTypeName:'源主表主键字段',editor:null,hasValue:false},	
		{mapType:'mainPk',mapTypeName:'主表主键字段值(新建表单时使用)',editor:null,hasValue:false},
		{mapType:'seqValue',mapTypeName:'由流水号产生',editor:'seqEditor',hasValue:true},
		{mapType:'curDate',mapTypeName:'获取当前时间',editor:null,hasValue:false},
		{mapType:'curUserId',mapTypeName:'获取当前用户Id',editor:null,hasValue:false},
		{mapType:'curUserName',mapTypeName:'获取当前用户姓名',editor:null,hasValue:false},
		{mapType:'curDepId',mapTypeName:'获取当前部门Id',editor:null,hasValue:false},
		{mapType:'curDepName',mapTypeName:'获取当前部门名称',editor:null,hasValue:false},
		{mapType:'curInstId',mapTypeName:'获取当前机构Id',editor:null,hasValue:false},
		{mapType:'curInstName',mapTypeName:'获取当前机构名称',editor:null,hasValue:false}];

//构建类型map。
var fieldEditorMap={}

for(var i=0;i<fieldEditors.length;i++){
	var o=fieldEditors[i];
	fieldEditorMap[o.mapType]=o;
}

function selectCanDeps(name){
	var canDepIds=mini.get(name);
	
	_TenantGroupDlg('',false,'','1',function(groups){
		var uIds=[];
		var uNames=[];
		for(var i=0;i<groups.length;i++){
			uIds.push(groups[i].groupId);
			uNames.push(groups[i].name);
		}
		if(canDepIds.getValue()!=''){
			uIds.unshift(canDepIds.getValue().split(','));
		}
		if(canDepIds.getText()!=''){
			uNames.unshift(canDepIds.getText().split(','));	
		}
		canDepIds.setValue(uIds.join(','));
		canDepIds.setText(uNames.join(','));
	},false);
}

/**
 * 加载BODEF列表。
 */
function loadBoDef(boDefId,callBack){
	 var url=__rootPath+'/sys/bo/sysBoDef/getBosByDefId.do?boDefId='+boDefId;
	 $.get(url,function(data){
		 if(callBack){
			 callBack(data);
		 }
	 })
}

/**
 * 加载bo字段对象。
 * @param comboxId
 * @param boDefId
 * @param entName
 * @param needCommonFields
 * @returns
 */
function loadBoAttrs(comboxId,boDefId,entName,needCommonFields,showName){
	var fieldObj=mini.get(comboxId);
	var url=__rootPath +"/sys/bo/sysBoEnt/getFieldByBoDefId.do?boDefId="+boDefId+"&tableName="+entName;
	$.get(url,function(data){
		var obj=mini.get(comboxId);
		var ary=[];
		if(!showName){
			ary=data;
		}
		else{
			for(var i=0;i<data.length;i++){
				var item=data[i];
				if(item.isSingle==1){
					ary.push(item);
				}
				else{
					var nameObj=$.clone(item);
					nameObj.name=nameObj.name +"_name";
					nameObj.comment=nameObj.comment +"(名称)";
					ary.push(item);
					ary.push(nameObj);
				}
			}
		}
		
		if(needCommonFields){
			var idObj={"name": "ID_","fieldName": "ID_","comment": "主键","dataType": "varchar"};
			var refObj={"name": "REF_ID_","fieldName": "REF_ID_","comment": "关联字段","dataType": "varchar"};
			var instObj={"name": "INST_ID_","fieldName": "INST_ID_","comment": "流程实例ID","dataType": "varchar"};
			ary.splice(0,0,idObj,refObj,instObj);
		}
		
		obj.setData(ary);
	})
	
}


function loadTableFields(comboxId,tableName,dsName){
	var fieldObj=mini.get(comboxId);
	var url=__rootPath +"/sys/db/sysDb/getByName.do?tbName=" + tableName +"&dsName="+dsName;
	$.get(url,function(data){
		fieldObj.setData(data.columnList);
	})
}

function dataRender(e){
  var record = e.record;
  var fieldType=record.columnType.toLowerCase();
  var s="";
  if(fieldType=="varchar"){
	  s="varchar(" + record.charLen +")";
  }
  else if(fieldType=="number" ){
	  if(record.decimalLen==0){
		  s=(record.intLen>10)?"long":"int";
	  }
	  else{
		  s="number(" + (record.intLen +record.decimalLen) +"," + record.decimalLen +")";  
	  }
  }
  else{
  	s=fieldType;
  }
  return s;	
}

function emptyRender(e){
	var val = e.value;
	var arr = [ {'key' : true, 'value' : '是','css' : 'green'}, 
	            {'key' : false,'value' : '否','css' : 'red'} ];
	return $.formatItemValue(arr,val);
}

function onCellValidation(e){
	var record=e.record;
	if(e.field=='mapType' && record.isNull==false && (!e.value||e.value=='')){
		e.isValid = false;
   		e.errorText='字段值不能为空！';
	}
}

/**
 * 隐藏过滤条件。
 * @param e
 * @returns
 */
function changeOperator(e){
	var val=e.value;
	var filterSqlObj=$(".filterSql", $(e.sender.el).closest(".table-detail"));
	if(val=="start"){
		filterSqlObj.hide();
	}
	else{
		filterSqlObj.show();
	}
}

function changeFieldMapEditor(e){
    var record = e.record, field = e.field;
    var val=e.value;
    //只有在点击值的时候响应。
   	if(field!='mapValue') return;
   	
   	var editorType=getEditor(record.mapType);
   	var editor=null;
	if(editorType){
		editor=mini.get(editorType);
	}
	e.editor=editor;
	e.column.editor=editor;
}

var operatorType={'new':'新增','upd':'更新','del':'删除'};

/**
 * data:{
 * 	tableName:"表名",
 * 	gridData:"配置映射数据",
 * 	operator:"new,upd,del",
 * 	pk:"",
 * 	condition:"执行条件",
 * 	num:编号随机值
 * }
 */
function addTableTab(data){
	var name = data.name;
	
	var gridTab=mini.get('gridTab');
	var tab=gridTab.addTab({
		title:name+'映射',
		name:name,
		showCloseButton:true,
		iconCls:'icon-table'
	});
	var el=gridTab.getTabBodyEl(tab);
	data.num=new Date().getTime();
	var html=baidu.template('formulaSettingTemplate',data);
	$(el).html(html);
	mini.parse();
	//加载数据
	loadData(data,el);
	gridTab.activeTab(tab);
}

/**
 * data:{
 * 	tableName:"表名",
 * 	gridData:"配置映射数据",
 * 	operator:"new,upd,del",
 * 	condition:"执行条件"
 * }
 */
function loadData(data,el){
	var tableName=data.tableName;
	var operator=data.operator;
	var gridData=data.gridData;
	var grid=getDataGrid(el);
//	var idKey="primaryKey_"+tableName+"_"+operator;
//	var comPk=mini.get(idKey);
	grid.on('cellbeginedit',changeFieldMapEditor);
	var url=__rootPath+"/sys/db/sysDb/getByName.do?tbName="+tableName;
	$.get(url,function(metaData){
		var colList=$.clone(metaData.columnList);
//		comPk.setData(colList);
		if(!gridData){
//			var primaryKeys=metaData.primayKey;
			grid.setData(metaData.columnList);
//			if(primaryKeys.length>0){
//				comPk.setValue(primaryKeys[0].fieldName);
//			}
		}
		else{
			$.extend(metaData.columnList,gridData) ;
			grid.setData(metaData.columnList);
//			comPk.setValue(data.primaryKey);
		}
	})
}


function getEditor(fieldType){
	for(var i=0;i<fieldEditors.length;i++){
		if(fieldEditors[i].mapType==fieldType){
			return fieldEditors[i].editor;
		}
	}
}

function getDataGrid(el){
	var ctls=mini.getChildControls(el);
	for(var i=0;i<ctls.length;i++){
		var ctl=ctls[i];
		if(ctl.type=="datagrid"){
			return ctl;
		}
	}
}

/**
 * 查找控件。
 * @param btn
 * @param name
 * @returns
 */
function getCtlByByName(obj,name){
	var el=$(obj.el).closest(".table-detail")[0];
	var ctls=mini.getChildControls(el);
	for(var i=0;i<ctls.length;i++){
		var ctl=ctls[i];
		if(ctl.name==name){
			return ctl;
		}
	}
	return null;
}


function onSelDatasource(e){
	var btnEdit=e.sender;
	openDatasourceDialog(function(data){
		btnEdit.setValue(data.alias);
		btnEdit.setText(data.name);
	})
}

function handOperator(targetId){
	$("div.operatorContainer div").click(function(e){
		var obj=$(this);
		insert(obj.attr("operator"),targetId)
	})
}

function insert(content,targetId){
	var formulaObj=document.getElementById(targetId);
	$.insertText(formulaObj,content);
}