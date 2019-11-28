
function setFormData(formId,data){
	var formContainer=$("#" + formId);
	var form = new mini.Form("#"+formId);
	form.setData(data);
	/**
	 * 获取字表的数据。
	 */
	$('.mini-datagrid,.mini-treegrid',formContainer).each(function(){
		var name=this.id;
		var grid=mini.get(name);
		grid.setData(data[name]);
	});
}

function setConfVars(data){
	if(conf){
		conf.vars=data;
	}
}
/**
 * 获取表单数据。
 * 数据格式如下:
 * 	{
 * 		result:true,
 * 		data:""
 * 	}
 * 
 * @returns 
 */
function getFormData(formType,formId,needValid){
	var form = new mini.Form("#"+formId); 
	var rtnJson={result:true,data:{}};
	if(formType=="ONLINE-DESIGN"){
		if(needValid){
			form.validate();
			if(!form.isValid()){
				rtnJson.result=false;
				return rtnJson;
			}
			var frm=$("#" + formId);
			var isValid=true;
			
			$('.mini-datagrid',frm).each(function(){
				var name=$(this).attr('id');
				var grid=mini.get(name);
				grid.validate();
				if(!grid.isValid()){
					isValid=false;
					return false;
				}
			});
			if(!isValid){
				rtnJson.result=false;
				return rtnJson;
			}
		}
		var modelJson = _GetFormJsonMini(formId);
		
		
		rtnJson.data=modelJson;
		return rtnJson;
	}else{
		var frameWindow=document.getElementById('formFrame').contentWindow;
		if(needValid){
			if(frameWindow.isValid && (!frameWindow.isValid())){
				rtnJson.result=false;
				return rtnJson;
			}
		}
		if(frameWindow.getData){
			rtnJson.data=frameWindow.getData();
		}
		return rtnJson;
	}
}

function getBoFormDataByType(formType,needValid){
	if(formType=="SEL-DEV"){
		var rtnJson={result:true,data:{}};
		var frameWindow=document.getElementById('formFrame').contentWindow;
		if(needValid){
			if(frameWindow.isValid && (!frameWindow.isValid())){
				rtnJson.result=false;
				return rtnJson;
			}
		}
		if(frameWindow.getData){
			rtnJson.data=frameWindow.getData();
		}
		return rtnJson;
	}else{//formType=="ONLINE-DESIGN"
		return getBoFormData(needValid);
	}
}

function getBoFormData(needValid){
	var forms=$('.form-model');
	var boDatas=[];
	var isValid=true;
	forms.each(function(){
		var formId=$(this).attr('id');
		var boDefId=$(this).attr('boDefId');
		var formKey=$(this).attr('formKey');
		
		var form=new mini.Form(formId);
		if(needValid){
			form.validate();
			if(!form.isValid()){
				isValid=false;
				return false;
			}
			var frm=$("#" + formId);
			$('.mini-datagrid',frm).each(function(){
				var name=$(this).attr('id');
				if($("#"+name).is(":hidden")) return true;
				var grid=mini.get(name);
				grid.validate();
				if(grid.required&&grid.getData().length<1){
					isValid=false;
					return false;
				}
				if(!grid.isValid()){
					isValid=false;
					return false;
				}
			});
		}
		
		var modelJson = _GetFormJsonMini(formId);
		boDatas.push({
			boDefId:boDefId,
			formKey:formKey,
			data:modelJson});
	});
	
	return {
		data:{bos:boDatas},
		result:isValid
	}
}

/**
 * 表单是否必填。
 * @returns {Boolean}
 */
function hasUserConfig(){
	//获得节点的必需人员配置
	var nodeUserMustConfig=mini.get('nodeUserMustConfig').getValue();
	//获得节点的人员映射
	var nodeUserIds=mini.get('nodeUserIds').getValue();
	if(!nodeUserMustConfig) return true;
	
	if(nodeUserIds=='') return false;
	
	var userConfs=mini.decode(nodeUserIds);
	var nodeIds=nodeUserMustConfig.split(',');
	for(var i=0;i<nodeIds.length;i++){
		for(var j=0;i<userConfs.length;i++){
			//没有配置对应的人员
			if(userConfs[i].nodeId==nodeIds[i] && userConfs[i].userIds==''){
				return false;
			}
		}
	}
	return true;
}


/**
 * 加载用户。
 */


/**
 * iframe 高度随内容自动变化。
 * @param obj
 */
function autoHeightOnLoad(obj){
	obj.load(function () {
		var body=$(this).contents().find("body");
		body.css("overflow","auto");
	    var mainheight = body.height() + 100;
	    $(this).height(mainheight);
	});
}










$(function(){
	initFieldSet();
	
});

function initFieldSet() {
	$(".fieldsetContainer").each(function() {
		var fieldSetObj = $(this);
		var divObj = $("div.divContainer", fieldSetObj);
		if (divObj.length == 0) {
			divObj = $("<div class='divContainer' style='line-height: normal'></div>");
			fieldSetObj.append(divObj);
		}
		var childAry = fieldSetObj[0].childNodes;
		var childs = [];
		for (var i = 0; i < childAry.length; i++) {
			var child = $(childAry[i]);
			if (child.is("legend")) {
				child.append("<div class='icon-button toggleButton expand'  title='展开/收缩' ></div>");
			} else {
				childs.push(child);
			}
		}
		for (var i = 0; i < childs.length; i++) {
			divObj.append(childs[i]);
		}

	});
	$(".toggleButton").bind("click", function() {
		var self=$(this);
		if (self.is('.expand')) {
			self.removeClass("expand");
			self.addClass("collapse");
		} else {
			self.removeClass("collapse");
			self.addClass("expand");
		}
		
		$(this).parent().next().toggle();
	});
}


/**
 * 初始化表单状态。
 * r 只读
 * h 隐藏
 * var permission={
 * 	add:{
 * 		field1:"r",
 * 		field1:"h"
 * 		GRID_:{
 * 			table1:{
 * 				field1:"h"
 * 			}
 * 		}
 * 	},
 * 	edit{
 * 		field1:"r",
 * 		field1:"h"
 * 	}
 * }
 */
function initFormElementStatus(){
	if(!window.permission) return ;
	//visible
	var id=mini.getByName("ID_").getValue();
	var rights=null;
	//编辑
	if(id){
		rights=getRights("edit");
	}//添加
	else{
		rights=getRights("add");
	}
	if(!rights) return;
	for(var key in rights){
		if(key=="GRID_") continue;
		var ctl=mini.getByName(key);
		var right=rights[key];
		if(right=="h"){
			ctl.setVisible(false);
		}
		else if(right=="r"){
			if(ctl.setEnabled){
				ctl.setEnabled(false);
			}
			if(ctl.setReadOnly){
				ctl.setReadOnly(true);
			}
		}
	}
	//子表
	var subRights=rights["GRID_"];
	if(!subRights) return;
	for(var table in subRights){
		var grid=mini.get("grid_" + table);
		var tableRight=subRights[table];
		for(var field in tableRight){
			var tmp=tableRight[field];
			if(tmp=="h"){
				grid.hideColumn (grid.getColumn ( field ))
			}
		}
	}
}

function getRights(status){
	return 	window.permission[status];
}



/**
 * 对意见表格数据进行处理。
 * @param e
 * @returns
 */
function drawNodeJump(e) {
    var record = e.record,
    field = e.field,
    value = e.value;
  	var ownerId=record.ownerId;
    if(field=='handlerId'){
    	if(ownerId && ownerId!=value){
    		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>&nbsp;代('+ '<a class="mini-user" iconCls="icon-user" userId="'+ownerId+'"></a>)';
    	}else if(value){
    		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>';
    	}else{
    		e.cellHtml='<span style="color:red">无</span>';
    	}
    } 
    if(field=='remark'){
    	var attachHtml=getAttachMents(record.attachments);
    	e.cellHtml='<span style="line-height:15px;">'+value+ attachHtml+'</span>';
    }
    if(field=='checkStatusText'){
    	e.cellHtml='<span style="line-height:15px;">'+value+'</span>';
    }
    if(field=='nodeName'){
    	e.cellHtml='<span style="line-height:15px;">'+value+'</span>';
    }
}

/**
 * 设置下拉框值。
 * @param alias			自定义查询别名
 * @param params		参数 {param1:val1}
 * @param targetCtl		下拉框控件
 * @param valField		返回值字段
 * @param nameField		返回值名称字段
 * @returns
 */
function setComboxData(alias,params,targetCtl){
	doQuery(alias, params,function(result){
		targetCtl.setData(result.data)
	})
}

/**
 * 启动流程
 * @param uid
 * @returns
 */
function startRow(uid){
	var row=grid.getRowByUID(uid);
	var url=__rootPath+'/bpm/core/bpmInst/start.do?solId='+row.solId;
	openNewWindow(url,"startWindow");
}

/**
 * 启动流程
 * @param uid
 * @returns
 */
function startRowBySolId(solId){
	var url=__rootPath+'/bpm/core/bpmInst/start.do?solId='+solId;
	openNewWindow(url,"startWindow");
}


/**
* 判断任务锁定状态
* @param uid
 * @param fromMgr 从管理页面进入
* @param fromPortal 从门户进入
*/
function checkAndHandTask(uid,fromMgr,fromPortal,colId){
	if(fromPortal){
		$.ajax({
			url:__rootPath+'/bpm/core/bpmTask/checkTaskLockStatus.do?taskId='+uid,
			success:function (result) {
				if(!result.success){
					top._ShowTips({
						msg:result.message
					});
					var _inp = $('.colId_'+colId).find("input[id='Refresh']");
					_inp.click();
				}else{
					handTask(uid,false,fromPortal);
				}
			}

		})
	}else{
		var row=grid.getRowByUID(uid);
		$.ajax({
			url:__rootPath+'/bpm/core/bpmTask/checkTaskLockStatus.do?taskId='+row.id + '&fromMgr=' + fromMgr,
			success:function (result) {
				if(!result.success){
					top._ShowTips({
						msg:result.message
					});
					grid.reload();
				}else{
					handTask(uid,fromMgr,false);
				}
			}

		})
	}

}

/**
 * 审批任务
 * @param uid
 * @returns
 */
function handTask(uid,fromMgr,fromPortal){
	var row = {id:uid};
	if(!fromPortal){
		row = grid.getRowByUID(uid);
	}
	var url=__rootPath+'/bpm/core/bpmTask/toStart.do?taskId='+row.id + '&fromMgr=' + fromMgr;
	console.info(url);
	var winObj = openNewWindow(url,"handTask");
	var loop = setInterval(function() {
		if(winObj.closed) {
			clearInterval(loop);
			if(grid){
				grid.reload()
			};
		}
	}, 1000);

}


/**
 * 释放任务
 */
function releaseTask(uid){
	var row=grid.getRowByUID(uid);

	var url=__rootPath+'/bpm/core/bpmTask/releaseTask.do?taskId='+row.id;

	var config = {};
	config.url = url;
	config.data = {'taskId':row.id};
	config.success = function(result){
		if(result.success){
			grid.reload();
		}
	}
	_SubmitJson(config);


}

/**
 * 在表单显示BO数据或自定义查询数据。
 */
;(function($){
	//$("[formtype='main']").showForm();
    $.fn.showForm = function(){
    	this.each(function(){
    		var self=$(this);
    		//{param:[{name:"customerId",type:"fixed",val:1},{name:"customerId",type:"form",val:"customerId"}],type:'query',alias:'alias'}
    		//{param:"cusomerId",type:'bo',alias:'alias'}
    		var options=eval("("+ self.attr("options") +")");
    		if(options.type=="bo"){
    			$.fn.showForm.handBo(options,self);
    		}
    		else{
    			$.fn.showForm.handQuery(options,self);
    		}
        });
        return this;
    };
    //处理bo的情况
    $.fn.showForm.handBo = function(options,self) {       
    	var id=mini.getByName(options.param).getValue();
    	
		var url=__rootPath +"/dev/cus/customData/getBoData/"+options.alias+"/"+id+".do";
		$.get(url,function(data){
			var main=data.main;
			$.fn.showForm.render(main,self);
		})   
    };    
    //处理自定义查询的情况
    $.fn.showForm.handQuery = function(options,self) {       
    	var params=options.param;
		var para={};
		for(var i=0;i<params.length;i++){
			var o=params[i];
			var type=o.type;
			if(type=="fixed"){
				para[o.name]=o.val;
			}
			else if(type=="form"){
				var val=mini.getByName(o.val);
				para[o.name]=o.val;
			}
		}
		doQuery(alias,para,function(data){
			$.fn.showForm.render(data,self);
		})      
    };
    //渲染
    $.fn.showForm.render=function(data,parent){
    	$("[model]",parent).each(function(){
			var name= $(this).attr("model"); 
			$(this).html(data[name]);
		})
    }
})(jQuery);

