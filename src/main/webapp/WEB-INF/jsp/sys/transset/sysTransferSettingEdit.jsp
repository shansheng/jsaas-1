
<%-- 
    Document   : [权限转移设置表]编辑页
    Created on : 2018-06-20 17:12:34
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[权限转移设置表]编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet"
	href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
</head>
<body>
<div class="topToolBar">
	<div>
		<rx:toolbar toolbarId="toolbar1" pkId="sysTransferSetting.id" />
	</div>
</div>
	<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${sysTransferSetting.id}" />
				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					<caption>[权限转移设置表]基本信息</caption>
					<tr>
						<td>名称：</td>
						<td>
							
								<input name="name"  class="mini-textbox"   style="width: 50%" />
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
						
								<input class="mini-combobox" name="status" data="[{id:'1',text:'启动'},{id:'0',text:'禁用'}]" style="width: 5%" value="1"/>
						</td>
					</tr>
					<tr>
						<td>常用变量：</td>
						<td>
							<c:forEach items="${constantItem }" var="item">
								<a class="mini-button" onclick="insertVal('${item.key}')">${item.val}</a>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td>SELECTSQL语句：</td>
						<td>
								<textarea class="script" name="selectSql" rows="5" cols="100"></textarea>
						</td>
					</tr>
					<tr>
						<td>UPDATESQL语句：</td>
						<td>
							
								<textarea class="script" name="updateSql" rows="5" cols="100"></textarea>
						</td>
					</tr>
					<tr>
						<td>日志内容模板：</td>
						<td>
						
								<input onfocus="onSelect(this)" class="mini-textarea" name="logTemplet" style="width: 90%;height: 100px;" />
						</td>
					</tr>
				</table>
		</form>
	</div>
</div>
	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${sysTransferSetting.id}';
	$(function(){
		initForm();
		initCodeMirror();
	})
	
	function initForm(){
		if(!pkId) return;
		$.ajax({
			type:'POST',
			url:"${ctxPath}/sys/transset/sysTransferSetting/getJson.do",
			data:{ids:pkId},
			success:function (json) {
				form.setData(json);
				for(var key in editorJson){
					editorJson[key].setValue(json[key]);
				}
			}					
		});
	}
	var sqlEditor = null;
	var editorJson={};
	
	function initCodeMirror() {
		$(".script").each(function(i){
			var editorName=$(this).attr("name");
			var editor= CodeMirror.fromTextArea(this, {
		        matchBrackets: true,
		        mode: "text/x-groovy"
		      });
			editor.setSize('auto', '100px');
			editor.on("cursorActivity",function(){  
				onSelect(editor);
			}); 
			editorJson[editorName]=editor;
		});
	}
	
	function onSelect(obj){
		sqlEditor = obj;
	}
	
	function insertVal(val) {
		if(!sqlEditor)return;
		if(sqlEditor.name=='logTemplet'){
			sqlEditor.setValue(sqlEditor.getValue()+val);
			return;
		}
		var doc = sqlEditor.getDoc();
		var cursor = doc.getCursor(); // gets the line number in the cursor position
		doc.replaceRange(val, cursor); // adds a new line
	}
	
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
	    for(var key in editorJson){
			data[key]=editorJson[key].getValue();
		}
		var config={
        	url:"${ctxPath}/sys/transset/sysTransferSetting/save.do",
        	method:'POST',
        	postJson:true,
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
	        
		_SubmitJson(config);
	}	
	
	
	
	
	
	

	</script>
</body>
</html>