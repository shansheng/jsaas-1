
<%-- 
    Document   : [系统自定义业务管理列表]编辑页
    Created on : 2017-05-21 12:11:18
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>树型对话框编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<style type="text/css">
	.CodeMirror{border: 1px solid #ececec;}
</style>

</head>
<body>
	<div class="topToolBar" >
	   <div>
			<a class="mini-button" plain="true" onclick="onSaveNext">保存&下一步</a>
			<c:if test="${not empty sysBoList.id}">
			<a class="mini-button"" plain="true" onclick="onNext">下一步</a>
			</c:if>
			<a class="mini-button btn-red" plain="true" onclick="onCancel">关闭</a>
	   </div>
	</div>
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${sysBoList.id}" />
				<input id="isDialog" name="isDialog" class="mini-hidden" value="${sysBoList.isDialog}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[系统自定义树型对话框]基本信息</caption>
					<tr>
						<td>
							名　　称<span class="star">*</span>
						</td>
						<td>
							<input name="name" value="${sysBoList.name}" class="mini-textbox" required="true"  style="width: 90%" />
						</td>
						<td>
							标  识  键<span class="star">*</span>
						</td>
						<td >
							<input name="key" value="${sysBoList.key}" required="true" class="mini-textbox" style="width: 90%"/>
						</td>
					</tr>
					<tr>
							<td>高　　度</td>
							<td>
								<input name="height" class="mini-spinner" value="${sysBoList.height}" minValue="100" maxValue="1500"/>
							</td>
							<td>宽　　度</td>
							<td>
								<input name="width" class="mini-spinner" value="${sysBoList.width}" minValue="100" maxValue="1500"/>
							</td>
					</tr>
					<tr>
						<td>默认SQL语句</td>
						<td colspan="3">
							<div class="form-toolBox">
								<span>数据源：</span>
								<input id="dbAs"
									   name="dbAs"
									   text="${dsName}"
									   value="${sysBoList.dbAs}"
									   class="mini-buttonedit"
									   onbuttonclick="onSelDatasource"
									   oncloseclick="_ClearButtonEdit"
									   style="width: 180px"
								/>
								<a class="mini-menubutton " plain="true" menu="popupMenu" >插入上下文的SQL条件参数</a>
								<a class="mini-button" plain="true" onclick="onRun">执行</a>
							</div>
						    <ul id="popupMenu" class="mini-menu" style="display:none;">
						    	<li onclick="onSqlExp('{CREATE_BY_}')">当前用户ID</li>
						    	<li onclick="onSqlExp('{DEP_ID_}')">当前部门ID</li>
						    	<li onclick="onSqlExp('{TENANT_ID_}')">当前机构ID</li>
						    </ul>
							<textarea id="sql" name="sql" cols="60" rows="4" style="width: 90%">${sysBoList.sql}</textarea>
						</td>
					</tr>
					<tr>
						<td>是否多选</td>
						<td>
							<div class="mini-radiobuttonlist" name="multiSelect" value="${sysBoList.multiSelect}" data="[{id:'true',text:'是'},{id:'false',text:'否'}]"/>
						</td>
						<td>是否仅选择子节点</td>
						<td>
							<div class="mini-radiobuttonlist" name="onlySelLeaf" value="${sysBoList.onlySelLeaf}" data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]"/>
						</td>
					</tr>
					<tr>
						<td>
							值  字  段<span class="star">*</span>
						</td>
						<td>
							<input id="idField" name="idField" class="mini-combobox" allowInput="true" 
						            textField="field" valueField="field" required="true" value="${sysBoList.idField}" />
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td> 
					</tr>
					<tr>
						<td>
							<span class="starBox">
								显示字段<span class="star">*</span>
							</span>
						</td>
						<td>
							<input id="textField" name="textField" class="mini-combobox" allowInput="true" 
						           textField="field" valueField="field" required="true" value="${sysBoList.textField}"
						            />
						</td>
						<td>父ID字段</td>
						<td>
							<input id="parentField" name="parentField" class="mini-combobox" allowInput="true" value="${sysBoList.parentField}"
						           textField="field" valueField="field" style="width:90%;" />
						</td>
					</tr>

					<tr>
						<td>描　　述</td>
						<td colspan="3">
							<textarea name="descp" value="${sysBoList.descp}" class="mini-textarea" style="width:90%;height:80px;" ></textarea>
							<textarea name="fieldsJson" id="fieldsJson" class="mini-hidden">${sysBoList.fieldsJson}</textarea>
						</td>
					</tr>
				
				</table>
				
			</div>
			
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="sys/core/sysBoList"
		entityName="com.redxun.sys.core.entity.SysBoList" />
	<script type="text/javascript">
		addBody();
		function onSelDatasource(e){
			var btnEdit=e.sender;
			mini.open({
				url : "${ctxPath}/sys/core/sysDatasource/dialog.do",
				title : "选择数据源",
				width : 650,
				height : 380,
				ondestroy : function(action) {
					if (action == "ok") {
						var iframe = this.getIFrameEl();
						var data = iframe.contentWindow.GetData();
						data = mini.clone(data);
						if (data) {
							btnEdit.setValue(data.alias);
							btnEdit.setText(data.name);
						}
					}
				}
			});
		}
		

		
		var editor = CodeMirror.fromTextArea(document.getElementById("sql"), {
	        lineNumbers: true,
	        matchBrackets: true,
	        mode: "text/x-sql"
	      });
		editor.setSize('auto',150);
		function onSqlExp(text){
			var doc = editor.getDoc();
       		var cursor = doc.getCursor(); // gets the line number in the cursor position
      		doc.replaceRange("$"+text, cursor); // adds a new line
		}
		//执行
		function onRun(){
			
			var ds=mini.get('dbAs').getValue();
			var sql=editor.getValue();
			_SubmitJson({
				url:__rootPath+'/sys/core/sysBoList/onRun.do',
				data:{
					ds:ds,
					sql:sql
				},
				method:'POST',
				success:function(result){
					var idField=mini.get('idField');
					var textField=mini.get('textField');
					var parentField=mini.get('parentField');
					var fields=result.data.fields;
					idField.setData(fields);
					textField.setData(fields);
					parentField.setData(fields);
					mini.get('fieldsJson').setValue(mini.encode(fields));
				}
			});
		}
		
		function onSaveNext(){
			var form=new mini.Form('form1');
			form.validate();
			if(!form.isValid()){
				return;
			}
			var formData=form.getData();
			var sql=editor.getValue();
			formData.isDialog='YES';
			formData.isTreeDlg='YES';
			formData.sql=sql;
			
			_SubmitJson({
				url:__rootPath+'/sys/core/sysBoList/save.do',
				data:formData,
				method:'POST',
				success:function(result){
					var id=result.data.id;
					location.href=__rootPath+'/sys/core/sysBoList/treeDlgEdit2.do?id='+id;
				}
			});
		}
		
		function onNext(){
			location.href=__rootPath+'/sys/core/sysBoList/treeDlgEdit2.do?id=${sysBoList.id}'
		}

	</script>
</body>
</html>