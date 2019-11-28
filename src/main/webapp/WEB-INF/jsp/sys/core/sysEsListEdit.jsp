<%-- 
    Document   : [SYS_ES_LIST]编辑页
    Created on : 2019-01-19 15:01:59
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[es单据列表]编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
</head>
<body>
<div class="topToolBar">
		<div>
	       	<c:if test="${not empty sysEsList.id }">
	  			<a class="mini-button" iconCls="icon-next" plain="true" onclick="onNext">下一步</a>
	     	</c:if>
	     	<a class="mini-button" iconCls="icon-next" plain="true" onclick="onSaveNext">保存&下一步</a>
     	</div>
    </div>
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${sysEsList.id}" />
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
					<caption>[es单据列表] 基本信息</caption>
					
					
			            <tr>
						<th>名称：</th>
						<td>
								<input name="name"  class="mini-textbox" />
						</td>
						<th>别名：</th>
						<td>
								<input name="alias"  class="mini-textbox" />
						</td>
						</tr>
						<tr>
				            	<th>选择索引：</th>
								<td>
									<input id="esTable" 
										name="esTable"  
										class="mini-combobox" 
										textField="index" 
										valueField="index" 
    									url="${ctxPath}/sys/core/sysEsQuery/getIndexs.do" 
    									showNullItem="true" 
    									required="true" 
    									allowInput="true"
    									onvalidation="onComboValidation" 
									/> 
									
								</td>
								<th>查询类型 :</th>
								<td>
										<div id="queryType" 
												name="queryType" 
												class="mini-radiobuttonlist"  
												textField="text" 
												valueField="id" 
												data="[{id:'1',text:'基于配置'},{id:'2',text:'编写SQL'}]" 
												value="1" 
												onvaluechanged="changeQueryType">
										</div>
								</td>
								
							</tr>
			            <tr>
			            <tr>
						<th>分类：</th>
						<td>
								<input id="treeId" name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_ES_LIST" 
								 	multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="true"
							        showFolderCheckBox="false"  expandOnLoad="true" showClose="true" oncloseclick="_ClearButtonEdit"
							        popupWidth="300" style="width:300px"/>
						</td>
						<th>是否分页：</th>
						<td>
								<input  class="mini-radiobuttonlist" name="isPage" emptyText="请选择..." textField="text" valueField="id" data="[{id:'1',text:'是'},{id:'0',text:'否'}]" value="1" required="false"/>
						</td>
						</tr>
						<tr id="trCustomSql" style="display:none;">
							<th>自定义SQL：</th>
							<td colspan="3">
								<textarea id="query" name="query" rows="10" cols="100"></textarea>
							</td>
						</tr>
				</table>
		</form>
	
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${sysEsList.id}';
	var editor=null;
	$(function(){
		initForm();
	})
	
	function initForm(){
		initCodeMirror();
		if(!pkId) return;
		var url="${ctxPath}/sys/core/sysEsList/getJson.do";
		$.post(url,{ids:pkId},function(json){
			form.setData(json);
			if(json.queryType=="1"){
				$("#trCustomSql").hide();
			}
			else{
				$("#trCustomSql").show();
			}
			if(json.query){
				editor.setValue(json.query);
			}
		});
	}
	
	function initCodeMirror() {
		var obj = document.getElementById("query");
		editor = CodeMirror.fromTextArea(obj, {
			matchBrackets : true,
			mode : "text/x-groovy"
		});
	}
	
	function changeQueryType(e){
		if(e.value=="1"){
			$("#trCustomSql").hide();
		}
		else{
			initSql()
			$("#trCustomSql").show();
		}
	}
	
	/**
	 * 当sql框没有数据时自动构建SQL
	 * @returns
	 */
	function initSql(){
		var esTable=mini.getByName("esTable").getValue();
		if(!esTable){
			alert("没有填写索引!");
			return;
		}
		var sql=editor.getValue().trim();
		if(!sql){
			
			var str="select * from " + esTable + " where 1=1 ";
			sql = "String sql=\"" + str + "\";\r\n return sql;"
			insertVal(editor, sql);
		}
	}
	
	function insertVal(editor, val) {
		var doc = editor.getDoc();
		var cursor = doc.getCursor(); // gets the line number in the cursor position
		doc.replaceRange(val, cursor); // adds a new line
	}
	
	function onComboValidation(e) {
	    var items = this.findItems(e.value);
	    if (!items || items.length == 0) {
	        e.isValid = false;
	        e.errorText = "输入值不在下拉数据中";
	    }
	}
	
	function onNext(){
		var id='${sysEsList.id}';
		location.href=__rootPath+'/sys/core/sysEsList/edit2.do?id='+id;
	}
	
	function onSaveNext(){
		var form=new mini.Form('form1');
		form.validate();
		if(!form.isValid()){
			return;
		}
		var formData=form.getData();
		var query=editor.getValue();
		formData.query=query;
		_SubmitJson({
			url:__rootPath+'/sys/core/sysEsList/save.do',
			data:formData,
			method:'POST',
			postJson:true,
			success:function(result){
				var id=result.data.id;
				location.href=__rootPath+'/sys/core/sysEsList/edit2.do?id='+id;
			}
		});
	}	
		
	</script>
</body>
</html>