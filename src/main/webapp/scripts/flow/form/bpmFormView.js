var boDefId="";
var viewId = "";
var isAgaion = "";
/**
 * 根据boDefId和类型获取模板数据。
 * @param defId		bo定义
 * @param type		mobile,form
 * @returns
 */
function getTemplates(defId,type){
	var url=__rootPath +"/bpm/form/bpmFormTemplate/getTemplatesByBoDef.do?boDefId=" + defId +"&type=" +type ;
	$.post(url,function(data){
		var html= baidu.template('templateList',{list:data});  
		$("#tbody").html(html);
	})
}


/**
 * 选择BO
 * @param type
 * @returns
 */
function selectBo(type){
	openBoDefDialog("",function(action,boDef){
		var txtName= mini.get("viewName");
		txtName.setValue(boDef.name);
		boDefId=boDef.id;
		getTemplates(boDef.id,type);
	});
}

/**
 * 重新生成时填入摸板
 * @param type
 * @returns
 */
function initBoAgain(newBoDefId,editViewId,editIsAgaion){
	$("#viewNameTr").hide();
	viewId = editViewId;
	isAgaion =editIsAgaion;
	var viewNameBtn =  mini.get("viewNameBtn");
	viewNameBtn.hide();
	boDefId=newBoDefId;
	getTemplates(boDefId,"pc");
}

function exePlugin(pluginName){
	templateView.execCommand(pluginName);
}

/**
 * 获取模板数据。
 * @returns
 */
function getTemplate(){
	var aryTr=$("tr",$("#tbody"));
	var json={};
	aryTr.each(function(){
		var row=$(this);
		var selObj=$("select",row);
		var alias=selObj.attr("alias");
		var type=selObj.attr("type");
		var template=selObj.val();
		var obj={};
		obj[alias]=template;
		if(type=="main"){
			if(!json[type]){
				json[type]=obj;
			}
		}
		else{
			var isChecked=$(":checkbox",row).is(':checked');
			if(!isChecked) return true;
			
			if(!json["sub"]){
				json["sub"]=[obj];
			}
			else{
				json["sub"].push(obj);
			}
		}
	})
	var templates=JSON.stringify(json);
	
	return templates;
}


/**
 * 通过模版生成表单。
 * @param type
 * @returns
 */
function next(type){
	var form = new mini.Form("#form1");
	form.validate();
	if(!form.isValid()) return;
	
	var templates=encodeURI( getTemplate());
	if(type=="mobile"){
		var url=__rootPath + "/bpm/form/bpmMobileForm/generate.do?boDefId=" + boDefId +"&templates=" + templates;
		_OpenWindow({
			url: url,
	        title: "生成手机表单", width: "100%", height:"100%",
	        ondestroy: function(action) {
	        	CloseWindow("ok");
	        }
		});
	}
	else{
		initAgain(templates);
	}
}

function initAgain(templates){
	var color=mini.get("color").getValue();
	var genTabObj=$("#genTab");
	var genTab=false;
	if(genTabObj.length>0){
		genTab=genTabObj.is(":checked");
	}
	var url=__rootPath + "/bpm/form/bpmFormView/design.do?boDefId=" + boDefId +"&templates=" + templates +"&color="+color +"&genTab="+genTab+"&viewId="+viewId;
	_OpenWindow({
		url: url,
		title: "生成PC表单", width: "100%", height:"100%",
		ondestroy: function(action) {
		   if(action !="initAgain"){
			   if(grid){
				   grid.reload();
			   }
			   CloseWindow('ok');
		   }
		}
	});
}


//预览
function preview(){
	$("#pageList").children("li:first-child").click();//点击第一条tabs触发保存
	formContainer.aryForm[0]=templateView.getContent();
	var result=formContainer.getResult();
	var formData=new mini.Form("#form1").getData();
	_SubmitJson({
		url:__rootPath+'/bpm/form/bpmFormView/parseFormTemplate.do',
		method:'POST',
		showMsg:false,
		data:{
			templateHtml:result.form,
			tabsTitle:result.title,
			displayType:formData.displayType
		},
		success:function(result){
			_OpenWindow({
	    		url:__rootPath+'/bpm/form/bpmFormView/preview.do',
	    		title:'表单预览',
	    		width:780,
	    		height:400,
	    		max:true,
	    		onload:function(){
	    			 var iframe = this.getIFrameEl();
	    			 var content=result.data;
	    			 //预留解析参数
                     iframe.contentWindow.setContent(content,{});
	    		}
	    	});	
		}
	});
}
	

function editForm(boDefId){
	var url=__rootPath + "/bpm/form/bpmMobileForm/genTemplate.do?boDefId=" + boDefId;
	_OpenWindow({
		url: url,
        title: "重新生成HTML", width: "600", height: "400",
        ondestroy: function(action) {
        	if(action!="ok") return;
        	var iframe = this.getIFrameEl().contentWindow;
        	var templates=iframe.getTemplate();
        	
    		var urlGen=__rootPath + "/bpm/form/bpmMobileForm/generateHtml.do?boDefId=" + boDefId +"&templates=" + templates ;
    		urlGen=encodeURI(urlGen);
    		$.post(urlGen,function(data){
    			templateView.setContent(data);
    		})
        }
	});
}

//将tab的数组(包括title和html内容)存进formData
function putArrayToFormData(formData) {
	var result = formContainer.getResult();
	
	var titleArray = result.title;//formContainer.aryTitle.join("#page#");
	var contentArray = result.form;//formContainer.aryForm.join("#page#");
	formData.templateView = contentArray;
	formData.title = titleArray;
}

/**
 * 检查是否有重复title
 */
function checkTitle() {
	var titleArray = formContainer.aryTitle;
	return titleArray.length == unique(titleArray).length;
}
/**
 * 数组去重
 */
function unique(arr) {
	var result = [], hash = {};
	for (var i = 0, elem; (elem = arr[i]) != null; i++) {
		if (!hash[elem]) {
			result.push(elem);
			hash[elem] = true;
		}
	}
	return result;
}

