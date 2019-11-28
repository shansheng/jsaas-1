RelationGrid={};

/**
 * 解析关联表单。
 */
RelationGrid.parseGrid=function(){
	var parent=$("#form-panel");
	var grids=$(".relation-grid",parent);
	for(var i=0;i<grids.length;i++){
	   var grid=grids[i];
	   var id=grid.id;
	   var relGrid=mini.get(id);
	   
	   var gridMode=relGrid.gridMode;
	   var url=this.getListUrl(relGrid);
	   if(gridMode=="relQuery"){
		   this.handGridRel(relGrid);
	   }
	   else if(gridMode=="relFill"){
		   this.handGridFill(relGrid);
		   relGrid.setUrl(url);
	   }
	   else{
			relGrid.setUrl(url);
			relGrid.load();
	   }
	}
}

/**
 * 获取URL
 */
RelationGrid.getListUrl=function(relGrid){
	var url=__rootPath +"/dev/cus/customData/"+relGrid.alias+"/getData.do";
	var gridMode=relGrid.gridMode;
	
	if(gridMode=="relQuery"){
		var mapping=relGrid.mapping;
		var aryParam=[];
		for(var i=0;i<mapping.length;i++){
			var tmp=mapping[i];
			//{"mField":"name","qField":"F_CUSTOM"}
			var val=mini.getByName(tmp.mField).getValue();
			if(!val) continue;
			aryParam.push(tmp.qField +"=" + val);
		}
		if(aryParam.length>0){
			url+="?" +aryParam.join("&");
		}
	}
	
	return url;
}

/**
 * 处理关联表查询。
 */
RelationGrid.handGridRel=function(relGrid){
	var url=RelationGrid.getListUrl(relGrid);
	var params=RelationGrid.getRelSearchParams(relGrid);
	var url=RelationGrid.getListUrl(relGrid);
	relGrid.setUrl(url);
	relGrid.load(params);
}

/**
 * 子表填充。
 */
RelationGrid.handGridFill=function(relGrid){
	var self=this;
	relGrid.on("rowdblclick",function(e){
		var row=e.record;
		self.addRow(relGrid,row);
	})
}

/**
 * 添加一行数据。
 */
RelationGrid.addRow=function(relGrid,row){
	var mapping=relGrid.mapping;
	var uniField=relGrid.uniField;
	var gridTo=mini.get("grid_"+relGrid.toTable);
	if(!gridTo) return;
	var gridData=gridTo.getData();

	
	var obj={};
	for(var i=0;i<mapping.length;i++){
		var tmp=mapping[i];
		obj[tmp.to]=row[tmp.src];
	}
	if(!uniField){
		gridTo.addRow(obj);
	}
	else{
		var val=obj[uniField];
		var isExist=false;
		for(var i=0;i<gridData.length;i++){
			var tmp=gridData[i];
			if(tmp[uniField]==val) {
				isExist=true;
			};
		}
		if(!isExist){
			gridTo.addRow(obj);
		}
	}
}

RelationGrid.loadData=function(gridId){
	var grid=mini.get(gridId);
	var url=RelationGrid.getListUrl(grid);
	relGrid.setUrl(url);
	relGrid.load();
}

/**
 * 添加数据。
 */
RelationGrid.onAdd=function(e){
	
	var obj=RelationGrid.getListKey(e);
	var formAlias=obj.form;
	var alias=obj.alias;
	
	var grid=mini.get(alias +"Grid");
	
	var url="/sys/customform/sysCustomFormSetting/"+formAlias+"/add.do";
	if(grid.gridMode=="relQuery"){
		var paramAry=RelationGrid.getRelParams(grid);
		if(paramAry.length>0){
			url+="?" + paramAry.join("&");
		}
	}
	_OpenWindow({
		title: name +'--添加',
		height:400,
		width:800,
		max:true,
		url:__rootPath+url,
		ondestroy:function(action){
			if(action!='ok') return;
			grid.load();
		}
	});
}

RelationGrid.getRelParams=function(grid){
	var mapping=grid.mapping;
	if(!mapping && mapping.length==0) return [];
	var paramAry=[];
	for(var i=0;i<mapping.length;i++){
		var tmp=mapping[i];
		var val=mini.getByName(tmp.mField).getValue();
		if(!val) continue;
		paramAry.push(tmp.field +"=" + val)
	}
	return paramAry;
}

/**
 * 获取查询参数
 */
RelationGrid.getRelSearchParams=function(grid){
	var mapping=grid.mapping;
	if(!mapping || mapping.length==0) return {};
	//不是关联查询
	if(grid.gridMode!="relQuery") return {};
	var params={};
	for(var i=0;i<mapping.length;i++){
		var tmp=mapping[i];
		var val=mini.getByName(tmp.mField).getValue();
		if(!val) continue;
		params[tmp.qField]=val;
	}
	return params;
}


/**
 * 点击数据进行编辑。
 */
RelationGrid.onEdit=function(e){
	var obj=RelationGrid.getListKey(e);
	var formAlias=obj.form;
	var alias=obj.alias;
	
	if(!formAlias){
		alert('请联系管理员配置行的表单方案！');
		return ;
	}
	var grid=mini.get(alias +"Grid");
	var row=grid.getSelected();
	if(row==null){
	   alert('请选择表格行');
	   return;
	}
	
	var url="/sys/customform/sysCustomFormSetting/form/"+formAlias+"/{pk}.do";
	url=url.replace('{pk}',row[grid.idField]);
	
   _OpenWindow({
		title:'表单编辑',
		height:400,
		width:800,
		max:true,
		url:__rootPath+url,
		ondestroy:function(action){
			if(action!='ok') return;
			grid.load();
		}
	});
}

/**
 * 点击数据进行编辑。
 */
RelationGrid.onDetail=function(e){
	var obj=RelationGrid.getListKey(e);
	var formAlias=obj.form;
	var alias=obj.alias;
	
	if(!formAlias){
		alert('请联系管理员配置行的表单方案！');
		return ;
	}
	var grid=mini.get(alias +"Grid");
	var row=grid.getSelected();
	if(row==null){
	   alert('请选择表格行');
	   return;
	}
	
	var url="/sys/customform/sysCustomFormSetting/"+formAlias+"/detail.do?pk={pk}";
	url=url.replace('{pk}',row[grid.idField]);
	
   _OpenWindow({
		title:'表单明细',
		height:400,
		width:800,
		max:true,
		url:__rootPath+url,
		ondestroy:function(action){
			if(action!='ok') return;
			grid.load();
		}
	});
}

/**
 * 获取列表和表单
 */
RelationGrid.getListKey=function(e){
	var btn=$(e.sender.el);
	var parent=btn.closest(".grid-container");
	var obj= {alias:parent.attr("alias"),form:parent.attr("form")};
	return obj;
}

/**
 * 删除选择的数据。
 */
RelationGrid.onDel=function(e){
	var obj=RelationGrid.getListKey(e);
	var formAlias=obj.form;
	var alias=obj.alias;
	
	//alias,formAlias
	if(!formAlias){
		alert('请联系管理员配置行的表单方案！');
		return ;
	}
	var grid=mini.get(alias +"Grid");
	
	var row=grid.getSelecteds();
	if(row.length==0){
	   alert('请选择表格行');
	   return;
	}
	var idField=grid.idField;
	
	var url="/sys/customform/sysCustomFormSetting/"+formAlias+"/removeById.do";
	url=__rootPath+url;
	mini.confirm("确定删除吗?", "提示信息", function(action){
        if (action != "ok")  return;
		var ids = [];
		for(var i=0; i < row.length; i++){
			if(row[i][idField]){
				ids.push(row[i][idField]);
			}
		}
		
		if(ids.length>0){
			_SubmitJson({url:url,method:"POST",data:{'id':ids.join(',')},success:function(){
				grid.load();
			}}) ;
		}  
    })
}

/**
 * 查询列表数据。
 */
RelationGrid.onSearch=function(e){
	var obj=RelationGrid.getListKey(e);
	var alias=obj.alias;
	var grid=mini.get(alias +"Grid");
	
	var obj=$("#searchForm_"+ alias)[0];
	var ctls= mini.getChildControls(obj);
	var data=RelationGrid.getRelSearchParams(grid);
	for(var i=0;i<ctls.length;i++){
		var ctl=ctls[i];
		if(ctl.type=="button") continue;
		data[ctl.getName()]=ctl.getValue(); 
	}
	_ConvertFormData(data);
	grid.load(data);
}

/**
 * 清空查询。
 */
RelationGrid.onClear=function(e){
	var obj=RelationGrid.getListKey(e);
	var alias=obj.alias;
	var grid=mini.get(alias +"Grid");
	
	var data=RelationGrid.getRelSearchParams(grid);
	
	var url=RelationGrid.getListUrl(grid);
	grid.setUrl(url);
	grid.load(data);
}

 
/**
 * 添加选中的项。
 */
RelationGrid.addRows=function(e){
	
	var obj=RelationGrid.getListKey(e);
	var alias=obj.alias;
	var grid=mini.get(alias +"Grid");
	var rows=grid.getSelecteds();
	for(var i=0;i<rows.length;i++){
		RelationGrid.addRow(grid,rows[i]);
	}
}




