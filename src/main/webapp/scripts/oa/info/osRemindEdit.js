var editor = null;
var sqlEditor = null;
function initCodeMirror() {
	var obj = document.getElementById("settingScript");
	editor = CodeMirror.fromTextArea(obj, {
		lineNumbers : true,
		matchBrackets : true,
		mode : "text/x-groovy"
	});
	var sqlObj = document.getElementById("settingSql");
	sqlEditor = CodeMirror.fromTextArea(sqlObj, {
		lineNumbers : true,
		matchBrackets : true,
		mode : "text/x-sql"
	});
	editor.setSize('auto', '150px');
	sqlEditor.setSize('auto', '150px');
}

function constantChanged(e){
	var val=e.value;
	var type=mini.get("type").getValue();
	if(type=="func" || type=="groovySql"){
		insertVal(editor, val)
	}
	else{
		insertVal(sqlEditor, val)
	}
}


function initType(){
	var divScript=$("#divScript");
	var divSql=$("#divSql");
	var type=mini.get("type").getValue();
	if(type=="func" || type=="groovySql"){
		divScript.show();
		divSql.hide();
	}
	else{
		divScript.hide();
		divSql.show();
	}
}


//选择数据源
function onDatasource(e) {
	var btnEdit = this;
	var callBack = function(data) {
		btnEdit.setValue(data.alias);
		btnEdit.setText(data.name);
	}
	openDatasourceDialog(callBack);
}

function insertVal(editor, val) {
	var doc = editor.getDoc();
	var cursor = doc.getCursor(); // gets the line number in the cursor position
	doc.replaceRange(val, cursor); // adds a new line
}

function onCloseClick(e){
	var sender=e.sender;
	sender.setValue("");
	sender.setText("");
}

function onOk(){
	var form=new mini.Form("#form1");
	form.validate();
    if (!form.isValid()) {
        return;
    }	        
    var data=form.getData();
    
    var url=__rootPath +"/oa/info/oaRemindDef/save.do";
    
    var type=mini.get("type").getValue();
    var setting="";
	if(type=="func" || type=="groovySql"){
		setting=editor.getValue();
	}
	else{
		setting=sqlEditor.getValue();
	}
	data.setting=setting;
    
	var config={
    	url:url,
    	method:'POST',
    	postJson:true,
    	data:data,
    	success:function(result){
    		CloseWindow('ok');
    	}
    }
        
	_SubmitJson(config);
}	