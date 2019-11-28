/**
 * 启动流程
 * @param e
 * @param config
 * {
 * 	formType:"",
 * 	solId:"",
 * 	instId:""
 * }
 * @returns
 */
function startProcess(e) {
	if(conf.showExecPath=="true" || conf.selectUser=="true" || (conf.isSkipFirst=="true" && conf.needOpinion=="true" ) ){
		openStartFlow(e);
	}
	else{
		start(e);
	}
	
}

function start(e){;
	if(conf.confirmStart=="true"){
		mini.confirm("确认启动流程吗?","提示信息",function(action){;
			if(action=="ok"){
				handStart(e);
			}
		});
	}
	else{
		handStart(e);
	}
}

function openStartFlow(e){
	var url=__rootPath+'/bpm/core/bpmInst/startFlow.do?solId='+conf.solId +"&instId=" +conf.instId ;
	
	var formType=conf.formType;
	
	var boResult=getBoFormDataByType(formType,true);
	
	if (!boResult.result) {
		mini.alert("表单有内容验证不通过!");
		btn.setEnabled(true);
		return;
	}
	
	_OpenWindow({
		title:'发起流程审批事项',
		width:800,
		height:550,
		url:url,
		onload:function(){
			if(conf.showExecPath=="true"){
				var iframe = this.getIFrameEl().contentWindow;
				iframe.setFormData(conf.solId,boResult.data);
			}
		},
		ondestroy:function(action){
			if(action!='ok'){return;}
			var iframe = this.getIFrameEl().contentWindow;
			var rtn=iframe.getData();
			
			$.extend(conf, rtn);
			
			start(e);
		}
	});
}

function handStart(e){
	var btn=e.sender;
	btn.setEnabled(false);
	
	var formType=conf.formType;
	
	var boResult=getBoFormDataByType(formType,true);
	
	if (!boResult.result) {
		mini.alert("表单有内容验证不通过!");
		btn.setEnabled(true);
		return;
	}
	
	//允许在表单中自定义验证规则
	if (window._selfFormValidate) {
		var result = window._selfFormValidate(boResult.data,true);
		btn.setEnabled(true);
		if (!result)  return;
	}
	if(window._asyncStartFormValidate){
		_asyncStartFormValidate(boResult.data,btn);
	}
	else{
		startFlow(conf,btn);
	}
}

function startFlow(conf,btn){
	var postData = {
			solId : conf.solId,
			bpmInstId : conf.instId
	};
	//用户数据
	if(conf.nodeUserIds){
		postData.nodeUserIds=conf.nodeUserIds;
	}
	if(conf.opinion){
		postData.opinion=conf.opinion;
	}
	if(conf.opFiles){
		postData.opFiles=conf.opFiles;
	}
	//来自
	if(conf.from){
		postData.from=conf.from;
	}
	//主流程数据
	if(conf.mainSolId){
		postData.mainSolId=conf.mainSolId;
	}
	if(conf.taskId){
		postData.taskId=conf.taskId;
	}
	
	if(conf.destNodeUsers){
		postData.destNodeUsers=conf.destNodeUsers;
	}
	
	if(conf.vars){
		postData.vars=mini.encode(conf.vars);
	}
	
	OfficeControls.save(function(){
		//重新获取表单值
		var boResult=getBoFormDataByType(conf.formType,true);
		postData.jsonData = mini.encode(boResult.data);
		_SubmitJson({
			url : __rootPath + '/bpm/core/bpmInst/startProcess.do',
			method : 'POST',
			data : postData,
			showMsg:false,
			success : function(result) {
				if(window.afterStart){
					window.afterStart(result);
				}
				else{
                    mini.showMessageBox({
                        title: "成功启动流程！",
                        iconCls: "mini-messagebox-question",
                        buttons: ["ok"],
                        message: "关闭当前窗口",
                        callback: function (action) {
                            CloseWindow('ok');
                        }
                    });
				}
			},
			fail:function(result){
				btn.setEnabled(true);
				_ShowErr({content:result.message,data:result.data});
			}
		});	
	})
}

/**
 * 保存草稿
 * @param e
 * @param config
 * @returns
 */
function saveDraft(e) {	
	var btn=e.sender;
	btn.setEnabled(false);
	var formType=conf.formType;
	var solId=conf.solId;
	var instId=conf.instId;
	
	//允许在表单中自定义验证规则
	if (window._selfFormValidate) {
		var result = window._selfFormValidate(boResult.data,false);
		if (!result)  return;
	}
	
	if(window._asyncFormValidate){
		_asyncFormValidate(boResult.data);
	}
	else{
		saveData(conf);
	}
}


function saveData(conf){
	OfficeControls.save(function(){
		var boResult=getBoFormDataByType(conf.formType,false);
		_SubmitJson({
			url : __rootPath + '/bpm/core/bpmInst/saveDraft.do',
			method : 'POST',
			data : {
				solId : conf.solId,
				bpmInstId : conf.instId,
				jsonData : mini.encode(boResult.data)
			},
			success : function(result) {
				if(result.data.instId!==''){
					conf.instId=result.data.instId;
				}
				CloseWindow('ok');
			}
		});	
	})
}


//显示关联数据
function showLinkData(){
	_OpenWindow({
		title:'实例关联的数据',
		url:__rootPath+"/bpm/core/bpmInst/showLinkData.do?tmpInstId="+conf.tmpInstId+"&instId="+conf.instId,
		height:400,
		width:800
	})
}	

function openFlowImg(){
	openFlowImgDialog({actDefId:conf.actDefId})
}

function formPrint() {
	printForm(conf);
}

