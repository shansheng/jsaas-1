function onSaveForm(){
	setting.action="save";
	_SubmitForm('form-panel');
}

function startFlow(){
	setting.action="startFlow";
	_SubmitForm('form-panel');
}

function openFlowChart(){
	openFlowChartDialog({solId:solId})
}

/**
 * 关闭窗口。
 */
function closeWin(action){
	if(isTree==1 && typeof(tree)!="undefined"){
		parent.closeWin();
	}
	else{
		CloseWindow(action);
	}
}



function loadButtons(aryBtns){
	var commonButtons=[{name:"打印",icon:"icon-print",method:"onPrint"},
			{name:"保存",icon:"icon-save",method:"onSaveForm"}];
	//是否能启动流程。
	if(canStartFlow){
		var flowBtns=[{name:"启动流程",icon:"icon-start",method:"startFlow"},
		              {name:"流程图",icon:"icon-flow",method:"openFlowChart"}];
		merageButtons(commonButtons,flowBtns);
	}
	
	var buttons=mini.decode(buttonDef);
	buttons.push({name:'关闭',icon:'icon-close',method:'closeWin("cancel")'});
	merageButtons(commonButtons,buttons);
	
	var aryBtn=[];
	for(var i=0;i<commonButtons.length;i++){
		var obj=commonButtons[i];
		var isIn=isInBtns(aryBtns,obj.name);
		if(isIn) continue;
		aryBtn.push(obj);
	}
	
	var html=baiduTemplate('buttonTemplate',{buttons:aryBtn});
	$("#btttonContainer").html(html);
}

function isInBtns(btns,alias){
	for(var i=0;i<btns.length;i++){
		var tmp=btns[i];
		if(tmp==alias) return true;
	}
	return false;
}

function merageButtons(target,buttons){
	for(var i=0;i<buttons.length;i++){
		var btn=buttons[i];
		target.push(btn);
	}
}

function validCombox(form){
	var ary = form.getFields();
	
    for(var i=0;i<ary.length;i++){
    	var obj = ary[i];
    	if(obj.type=='combobox'){
    		var text = obj.text;
    		var temp = obj.listbox.data;
    		var bl = false;
    		for(var j=0;j<temp.length;j++){
    			if(text == temp[j].name){
    				bl = true;
    				break;
    			}
    		}
    		obj.setIsValid(bl);
    	}
    }
}

function GetRequest() {  
	   var url = location.search; //获取url中"?"符后的字串  
	   var theRequest = new Object();  
	   if (url.indexOf("?") != -1) {  
	      var str = url.substr(1);  
	      strs = str.split("&");  
	      for(var i = 0; i < strs.length; i ++) {  
	         theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);  
	      }  
	   }  
	   return theRequest;  
	} 

function _SubmitForm(formId){
	//若有自定义函数，则调用页面本身的自定义函数
	if(isExitsFunction('selfSaveData')){
		selfSaveData.call();
		return;
	}
	var form = new mini.Form("#"+formId);
    form.validate();
    
    var isValid=true;
    
//    validCombox(form);
    
    $('.mini-datagrid',$("#" +formId)).each(function(){
		var name=$(this).attr('id');
		
		var grid=mini.get(name);
		grid.validate();
		
		var label=grid.label;
		var required = grid.required;
		if(required) {
			var rowSize = grid.getData().length;
			if(rowSize <= 0) {
				isValid = false;
				_ShowTips({
					msg: "子表“"+label+"”必须要有数据。"
				});
			}
		}


		if(!grid.isValid()){
			isValid=false;
			_ShowTips({
				msg: "子表“"+label+"”行有必填内容没有填入。"
			});
			return false;
		}
	});
    
    if (!isValid || !form.isValid())  return;
    
    var formData=_GetFormJsonMini(formId);
    var url=__rootPath + $("#" + formId).attr("action");
 
   //若定义了handleFormData函数，需要先调用 
   if(isExitsFunction('handleFormData')){
    	var result=handleFormData(formData);
    	if(result==false) return;
    }
   
    var vars = GetRequest();
   
    for(var d in vars){
    	if(!formData[d]){
    		formData[d] = vars[d];
    	}
    }
    var data={formData:mini.encode(formData)};
    
    
    if(isExitsFunction('handleData')){
    	handleData(data);
    }
   
    var config={
    	url:url,
    	method:'POST',
    	data:data,
    	success:function(result){
    		//如果存在自定义的函数，则回调
    		if(isExitsFunction('successCallback')){
    			successCallback.call(this,result);
    			return;	
    		}
    		CloseWindow('ok');
    	}
    }
    
    config.postJson=true;
    
    OfficeControls.save(function(){
    	_SubmitJson(config);
    });
}