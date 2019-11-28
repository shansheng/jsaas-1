function onSearch(){
	var data=getSearchFormData("searchForm");
	_ConvertFormData(data);
	grid.load(data);
}

//快速搜索
function onRapidSearch(){
	var data=getSearchFormData("rapidSearchForm");
	_ConvertFormData(data);
	grid.load(data);
}

function getSearchFormData(formId){
	var data={};
	var obj=$("#"+ formId)[0];
	if(!obj)return data;
	var ctls= mini.getChildControls(obj);
	for(var i=0;i<ctls.length;i++){
		var ctl=ctls[i];
		if(ctl.type=="button") continue;
		data[ctl.getName()]=ctl.getValue(); 
	}
	return data;
	
}


function getUrlFromRecord(url,record){
    url=url.replace('{ctxPath}',__rootPath);
    for(var field in record){
    	url=url.replace('{'+field+'}',record[field]);
    }
    return url;
}

function onClear(){
	var searchForm=new mini.Form("#searchForm");
	searchForm.clear();
	var url=grid.getUrl();
	var index=url.indexOf('?');
	if(index!=-1){
		url=url.substring(0,index);
	}
	grid.setUrl(url);
	grid.load();
}


function onCellValidation(e){
	
	var col=e.column;
	var editor=col.editor;
	if(!editor){
		return;
	}
	if(editor.setValue && editor.validate){
		editor.setValue(e.value);
		editor.validate();
		if(!editor.isValid()){
			e.isValid = false;
			e.errorText='字段值不合法！';
		}
		editor.setValue('');
	}
	
}

function onClose(){
	CloseWindow();
}

//对于树型表格才适用
function onAddSub(e){
	var node = grid.getSelectedNode();
	if(sysBoList.rowEdit=="NO"){
		var formAlias=sysBoList.formAlias;
		var idField=sysBoList.idField;
		var parentField=sysBoList.parentField;
		var name=sysBoList.name;
		if(!formAlias){
			alert('请联系管理员配置行的表单方案！');
			return ;
		}

		var url="/sys/customform/sysCustomFormSetting/form/"+formAlias+".do";
		if(e.sender && e.sender.url){
			url=e.sender.url;
		}
		if(parentField){
			url += "?"+parentField+"="+node[idField];
		}

		_OpenWindow({
			title: name +'--添加',
			height:400,
			width:800,
			max:true,
			url:__rootPath+url,
			ondestroy:function(action){
				if(action!='ok'){
					return;
				}
				grid.load();
			}
		});
	}else{
		grid.addNode({}, "add", node);
	}
}

function onRefresh(){
	grid.load();
}


function onExpand(e){
	grid.expandAll();
}

function onCollapse(e){
	grid.collapseAll();
}

//多行的数据保存
function onRowsSave(e){
	grid.validate();
	
	if(!grid.isValid()){
		return;
	}
	
	var saveUrl=e.sender.url;
	//获得修改的数据
	var rows=grid.getChanges(null,true);
	//alert(mini.encode(rows));
	//更新bo对应的业务对象
	
	_SubmitJson({
		url:__rootPath+ saveUrl,
		method:"POST",
		data:{rows:mini.encode(rows)},
		success:function(){
			grid.load();
		}
	});
}


function showDetail(e,boList){

	if(!boList.formDetailAlias){
		alert('请联系管理员配置行的表单方案！');
		return ;
	}
	var row=grid.getSelected();
	
	if(row==null){
	   alert('请选择表格行');
	   return;
	}
	
	var url="/sys/customform/sysCustomFormSetting/detail/"+boList.formDetailAlias+"/{pk}.do";
	if(e.sender && e.sender.url){
		url=e.sender.url;
	}
	url=url.replace('{pk}',row[boList.idField]);
	
	var myregexp = /\{(.*?)\}/g;
	var match = myregexp.exec(url);
	while (match != null) {
		url=url.replace(match[0],row[match[1]]);
		match = myregexp.exec(url);
	}
	
	_OpenWindow({
		title: boList.name + '--明细',
		height:400,
		width:800,
		max:true,
		url:__rootPath+url,
		ondestroy:function(action){
			if(action!='ok'){
				return;
			}
		}
	});

}

function exportXls(e,boList){
	var boKey =boList.key;
	var name =boList.name;
    
    var data=getSearchFormData("searchForm");
	_ConvertFormData(data);
    var url="/sys/core/sysBoList/{boKey}/exportExcelDialog.do";
	url=url.replace('{boKey}',boKey);
    _OpenWindow({
		title: name +'导出EXCEL表单',
		height:600,
		width:800,
		url:__rootPath+url,
		onload:function(){
    		var iframe = this.getIFrameEl().contentWindow;
    		iframe.init(data);
    	},
		ondestroy:function(action){
			if(action!='ok'){
				return;
			}
		}
	});
	
}

function importXls(boList){
	var boKey = boList.key;
    _OpenWindow({
		title:boList.name + '导入EXCEL表单',
		height:600,
		width:800,
		url:__rootPath+'/sys/core/sysBoList/importExcelDialog.do?boKey='+boKey,
		ondestroy:function(action){
			if(action!='ok'){
				grid.reload();
			}
		}
	});
}

function editForm(e,boList){
	if(!boList.formAlias){
		alert('请联系管理员配置行的表单方案！');
		return ;
	}
	var row=grid.getSelected();
	
	if(row==null){
	   alert('请选择表格行');
	   return;
	}
	
	var url="/sys/customform/sysCustomFormSetting/form/"+boList.formAlias+"/{pk}.do";
	if(e.sender && e.sender.url){
		url=e.sender.url;
	}
	url=url.replace('{pk}',row[boList.idField]);
	
   _OpenWindow({
		title:boList.name +'--编辑',
		height:400,
		width:800,
		max:true,
		url:__rootPath+url,
		ondestroy:function(action){
			if(action!='ok'){return;}
			grid.load();
		}
	});
}

/**
 * @param e 双击行对象
 * @param boList 
 * @param extUrlParam url参数
 */
function rowDoubleClick(e,boList){
	var formAlias=boList.formDetailAlias;
	var rowEdit=boList.rowEdit;
	var name=boList.name;
	var idField=boList.idField;
	
	var extUrl="";
	if(window.getExtFields){
		var fields=window.getExtFields();
		var params=[];
		for(var i=0;i<fields.length;i++){
			var key=fields[i];
			var val=e.record[key];
			if(!val) continue;
			params.push(key +"=" + val);
		}
		extUrl=params.join("&");
	}

	if(!formAlias || rowEdit=='YES'){
		return ;
	}
	var record=e.record;
	
	if(record==null){
	   alert('请选择表格行');
	   return;
	}
	var url=__rootPath+'/sys/customform/sysCustomFormSetting/detail/'+formAlias+'/'+record[idField]+'.do';
	if(extUrl){
		url=url +"?" + extUrl;
	}
	
   _OpenWindow({
		title:name + '--明细',
		height:600,
		width:800,
		max:true,
		url:url
	});
}

function handRemove(e,boList){
	var formAlias=boList.formAlias;
	var idField=boList.idField;
	
	if(!formAlias){
		alert('请联系管理员配置行的表单方案！');
		return ;
	}
	
	var row=grid.getSelecteds();
	if(row.length==0){
	   alert('请选择表格行');
	   return;
	}
	var url="/sys/customform/sysCustomFormSetting/"+formAlias+"/removeById.do";
	if(e.sender && e.sender.url){
		url=e.sender.url;
	}
	url=__rootPath+url;
	mini.confirm("确定删除吗?", "提示信息", function(action){
        if (action != "ok")  return;
		var ids = [];
		for(var i=0; i < row.length; i++){
			if(row[i][idField]){
				ids.push(row[i][idField]);
			}else{
				var type=grid.type;
				if(type=="treegrid"){
					grid.removeNode(row[i]);
				}
				else{
					grid.removeRow(row[i]);
				}
			}
		}
		
		if(ids.length>0){
			_SubmitJson({url:url,method:"POST",data:{'id':ids.join(',')},success:function(){
				grid.load();
			}}) ;
		}  
    })
}

function handAdd(e,boList){
	var rowEdit=boList.rowEdit;
	var dataStyle=boList.dataStyle;
	var formAlias=boList.formAlias;
	var name=boList.name;
	if(!formAlias){
		alert('请联系管理员配置行的表单方案！');
		return ;
	}
	
	//行编辑
	if(rowEdit=='YES'){
		if(dataStyle=='tree'){
        	grid.addNode({}, "add", null);
		}else{
			grid.addRow({});
		}
		return;
	}

	var url="/sys/customform/sysCustomFormSetting/form/"+formAlias+".do";
	if(e.sender && e.sender.url){
		url=e.sender.url;
	}

	_OpenWindow({
		title: name +'--添加',
		height:400,
		width:800,
		max:true,
		url:__rootPath+url,
		ondestroy:function(action){
			if(action!='ok'){
				return;
			}
			grid.load();
		}
	});
}

/*grid.on('cellendedit',function(e){
	if(e.column.displayfield && e.editor.getText && e.editor.getText()){
		e.record[e.column.displayfield]=e.editor.getText();
	}
});
*/

function showLink(value,field,url,linkType,formAlias){
	if(linkType=='tabWindow'){
		top['index'].showTabFromPage({
			tabId: formAlias +'_'+field,
			title:value + '-信息',
			url:url
		});
	}else if(linkType=="newWindow"){
		 window.open(url); 
	}else{
		 _OpenWindow({
			title:value,
			height:400,
			width:800,
			max:true,
			url:url
		});
	}
}

function handButtonClick(e){
	var url=e.sender.url;
	var rows=grid.getSelecteds();
	_SubmitJson({
		url:__rootPath+url,
		data:{
			data:mini.encode(rows)
		},
		method:'POST',
		success:function(result){
			grid.load();
		}
	});
}

function handTreeClick(e,paramName,idField){
	var node=e.node;
	var url=grid.getUrl();
	var index=url.indexOf('?');
	if(index!=-1){
		url=url.substring(0,index);
	}
	grid.setUrl(url + '?'+paramName+'='+ node[idField]);
	grid.load();
}


function onAdd(e){
	handAdd(e,sysBoList);
}

function onEdit(e){
	editForm(e,sysBoList);
}

function onDetail(e){
	showDetail(e,sysBoList);
}

function onXLSExport(e){
	exportXls(e,sysBoList);
}

function onImport(){
	importXls(sysBoList);
}

function onRemove(e){
	handRemove(e,sysBoList);
}

function onRowDbClick(e){
	rowDoubleClick(e,sysBoList);
}

//返回选择的数据
function getData(){
	var selectedGrid=mini.get("selectedGrid");
    var rows = {};
    if(!single){
    	rows = selectedGrid.getData();
    }else{
		rows = grid.getSelecteds();
	}
	
	var data={rows:rows,single:single};
	return data;
}

function removeSelected(){
	var selectedGrid=mini.get("selectedGrid");
	var rows=selectedGrid.getSelecteds();
	selectedGrid.removeRows(rows,false);
}

function clearSelected(){
	var selectedGrid=mini.get("selectedGrid");
	selectedGrid.clearRows();
}

function removeSel(e){
	var selectedGrid=mini.get("selectedGrid");
	var row=e.row;
	selectedGrid.removeRow(row);
}

function select(e){
	var selectedGrid=mini.get("selectedGrid");
	var idField = sysBoList.idField;
	var record=e.record;
	var rows=selectedGrid.findRow(function(row){
		if(row[idField] == record[idField]){
	    	return true;
	    }
	});
	if(rows) return;
		
	selectedGrid.addRow($.clone(record));
}

