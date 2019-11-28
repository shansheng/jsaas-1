/**
处理子表字段
*/
function handMainField(el,node){
	var relType=el.closest("div[relationType]");
	if(relType.length==0){
		alert("字段必须放到主表中!")
		return;
	}
	var type=relType.attr("relationType");
	if(type!="main"){
		alert("字段必须放到主表中!")
		return;
	}
	insertAttr(node.attrId,node.type);
}
		
/**
 插入一对一的字段。
*/
function handOneToOneField(el,node){
	var relType=el.closest("div[relationType]");
	if(relType.length==0){
		alert("字段必须放到子表中!");
		return;
	}
	var type=relType.attr("relationType");
	var tablename=relType.attr("tablename");
	if(type=="onetoone" && node.entName==tablename){
		insertAttr(node.attrId,node.type);
	}
	else{
		alert("字段必须放到子表中!");
	}
}
		
/**
* 一对多子表。
*/
function handOneToMany(node){
	var isExist=false;
	var container=$("<div>"+templateView.getContent()+"</div>");
	var aryRelation=$("div.rx-grid",container);
	aryRelation.each(function(){
		var obj=$(this);
		var tbName=obj.attr("name");
		if(node.name==tbName){
			isExist=true;
			return false;
		}
	});
	if(!isExist){
		insertEnt(node.boEntId,"onetomany")	
	}
	else{
		alert("子表已经添加!")
	}
}
		
function handOneToOne(el,node){
	//判断外边是否为主表或者子表。
	var relType=el.closest("div[relationType]");
	var grid=el.closest("div.rx-grid");
	if(relType.length>0 || grid.length>0){
		alert("一对一子表不能在其他的主表或子表内");
		return;
	}
	var isExist=false;
	var container=$("<div>"+templateView.getContent()+"</div>");
	var aryRelation=$("div[relationType]",container);
	aryRelation.each(function(){
		var obj=$(this);
		var relationType=obj.attr("relationType");
		if(relationType=="onetoone" ){
			var tbName=obj.attr("tablename");
			if(node.name==tbName){
				isExist=true;
				return false;
			}
		}
	});
	if(!isExist){
		insertEnt(node.boEntId,"onetoone")	
	}
	else{
		alert("子表已经添加!")
	}
}
		
function insertEnt(entId,category){
	openSelTemplate({category:category,type:"pc",callBack:function(template){
		var url=__rootPath +"/bpm/form/bpmFormView/generateByBoEnt.do";
		var params={entId:entId,template:template};
		$.post(url,params,function(html){
			templateView.execCommand('insertHtml',html);
		})
	}})
}

function insertAttr(attrId,relType){
	var url=__rootPath +"/bpm/form/bpmFormView/generateByAttr.do";
	var params={attrId:attrId,relType:relType};
	$.post(url,params,function(html){
		templateView.execCommand('insertHtml',html);
	})
}

/**
 * 初始生成HTML。
 * 
 * @param boDefId	bo定义ID
 * @param templates	模版
 * @returns
 */
function generateHtml(genTab,boDefId,templates,color){
	var url=__rootPath +"/bpm/form/bpmFormView/generateHtml.do";
	var params={genTab:genTab,boDefId:boDefId,templates:templates,color:color};
	$.post(url,params,function(data){
		var title=data.message;
		var content=data.data;
		initTab(title,content);
	})
}

/**
 * 根据表单ID加载表单。
 * @param viewId
 * @returns
 */
function getFormViewById(viewId){
	var url=__rootPath +"/bpm/form/bpmFormView/getJsonById.do";
	var params={viewId:viewId};
	$.post(url,params,function(data){
		initTab(data.title,data.templateView);
		var form=new mini.Form("#form1");
		form.setData(data);
	})
}


/**
 * 根据表单ID及摸板重新生成表单。
 * @param viewId
 * @returns
 */
function getFormViewByIdAgain(viewId,genTab,boDefId,templates,color){
	var url=__rootPath +"/bpm/form/bpmFormView/getFormViewByIdAgain.do";
	var params={viewId:viewId,genTab:genTab,boDefId:boDefId,templates:templates,color:color};
	$.post(url,params,function(data){
		initTab(data.title,data.templateView);
		var form=new mini.Form("#form1");
		form.setData(data);
	})
}


/**
 * 树点击事件
 * @param e
 * @returns
 */
function treeNodeClick(e){
	var node=e.node;
	
	var range=templateView.selection.getRange();
	if(!range) {
		alert("请在设计创建点击插入位置!");
		return;
	}
	var el=$(range.startContainer);
	var isField=node.isField;
	var type=node.type;
	//选中的字段时
	if(node.isField){
		//主表字段
		if(type=="main"){
			handMainField(el,node);
		}
		else if(type=="onetoone"){
			handOneToOneField(el,node);
		}
	}
	//选中的字段为表
	else{
		if(type=="onetoone"){
			handOneToOne(el,node);
		}
		else{
			handOneToMany(node);
		}
	}
}


/**
 * 保存表单。
 * @returns
 */
function saveFormView(){
	var rtn=checkTitle();
	if(!rtn){
		_ShowTips({msg:"表单页签重复!"});
		return;
	}
	saveChange();
	
	_SaveDataJson("form1",function(result){
		CloseWindow('ok');
	},function(data){
		putArrayToFormData(data);
		return true;
	})
}

/**
 * 重新生成PC表单。
 * @returns
 */
function reinitialization(boDefId){
	var url=__rootPath +"/bpm/form/bpmFormView/addByBo.do?boDefId="+boDefId+"&editViewId="+viewId+"&editIsAgaion=1";
	_OpenWindow({
		url: url,
		title: "新增业务表单", width: 600, height: 400,
		onload:function(){
			var iframe = this.getIFrameEl().contentWindow;
		},
		ondestroy: function(action) {
			if (action != 'ok') return;
				CloseWindow('ok');
		}
	});
}


