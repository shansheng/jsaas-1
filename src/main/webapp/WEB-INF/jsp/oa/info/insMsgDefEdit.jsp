
<%-- 
    Document   : [INS_MSG_DEF]编辑页
    Created on : 2017-08-31 14:54:23
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>消息编辑</title>
<%@include file="/commons/edit.jsp"%>
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/sql/sql.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${ctxPath}/scripts/share/dialog.js"></script>

<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">

</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="insMsgDef.id" />
<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
			
				<input id="pkId" name="id" class="mini-hidden" value="${insMsgDef.msgId}" />
				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					<caption>消息基本信息</caption>
					<tr>
						<td>标　　题</td>
						<td>
							
								<input name="content" value="${insMsgDef.content}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>颜　色</td>
						<td>
							<input type="color" name="color" id="color" value="${insMsgDef.color}">
						</td>
					</tr> 
					<tr>
						<td>更多URl</td>
						<td>
							
								<input name="url" value="${insMsgDef.url}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>图　　标</td>
						<td>
							<input name="icon" id="icon" value="${insMsgDef.icon}" text="${insMsgDef.icon}" class="mini-buttonedit" onbuttonclick="selectIcon" style="width:20%"/>
		    				<a class="mini-button MyBlock" id="icnClsBtn" style=""></a>
							
						</td>
					</tr>
					<tr>
						<td>数量比较类型</td>
						<td>
							<div class="mini-radiobuttonlist" value="${insMsgDef.countType}"
    						textField="text" valueField="id"  id="countType" name="countType"  data="[{id:'none',text:'无'},{id:'week',text:'同比上周'},{id:'month',text:'同比上月'},{id:'year',text:'同比上年'}]" ></div>
						</td>
					</tr>
					<%-- <tr>
						<td>数据源</td>
                         <td colspan="3">   
                         	<input id="btnDataSource" name="dsName" textName="dsAlias" text="${insMsgDef.dsName}" value="${insMsgDef.dsAlias}" class="mini-buttonedit" onbuttonclick="onDataSourceEdit"/> 
                         </td>
					</tr> --%>
					<tr>
						<td>类　　型</td>
						<td>
							<div class="mini-radiobuttonlist" value="${insMsgDef.type}" require=true
    						textField="text" valueField="id"  id="type" name="type"  data="[{id:'function',text:'调用方法（groovy语法）'},{id:'sql',text:'调用sql语句'}]" ></div>
						</td>
					</tr>
					<tr id="sqlTR">
							<td>调用方法或SQL语句</td>
							<td style="padding: 4px 0 0 0 !important;">
								<div id="conditionDiv">
									支持freemaker语法 条件字段:
									<input 
										id="freemarkColumn"
										class="mini-combobox" 
										showNullItem="true"
										nullItemText="可选条件列头" 
										valueField="fieldName"
										textField="fieldLabel" 
										onvalueChanged="varsFreeChanged" 
									/>
									常量:
									<input 
										id="constantItem" 
										class="mini-combobox"
										showNullItem="true" 
										nullItemText="可用常量"
										url="${ctxPath}/sys/core/public/getConstantItem.do"
										valueField="key" 
										textField="val"
										onvalueChanged="constantFreeChanged" 
									/>
								</div>
								
							<textarea name="sqlFunc" id="sql" emptyText="请输入sql" require=true 
							width="500" style="height: 100px;">${insMsgDef.sqlFunc}</textarea>
							</td>
						</tr>
						
					
				</table>
 			</div> 
		</form>
	</div>
</div>
	<rx:formScript formId="form1" baseUrl="oa/info/insMsgDef"
		entityName="com.redxun.oa.info.entity.InsMsgDef" />
	<script type="text/javascript">
		addBody();
		var editor = null;
		var sqlEditor = null;
		function initCodeMirror() {
			var sqlObj = document.getElementById("sql");
			sqlEditor = CodeMirror.fromTextArea(sqlObj, {
				lineNumbers : true,
				matchBrackets : true,
				mode : "text/x-sql"
			});
			sqlEditor.setSize('auto', '200px');
		}

		initCodeMirror();

		function onDataSourceEdit(e){
	 	   var btnEdit=e.sender;
	 	   _CommonDialogExt({dialogKey:"dataSourceDialog",title:"选择数据源",ondestroy:function(data){
	 		   var row=data[0];
	 		   btnEdit.setText(row.NAME_);
	 		   btnEdit.setValue(row.ALIAS_);
	 	   }})
	    }
		
		//选择图标
	    function selectIcon(e){
	 	   var btn=e.sender;
	 	   _IconSelectDlg(function(icon){
				//grid.updateRow(row,{iconCls:icon});
				btn.setText(icon);
				btn.setValue(icon);
				mini.get('icnClsBtn').setIconCls(icon);
			});
	    }
		
		$(function(){
			var icon = '${insMsgDef.icon}';
    		mini.get('icnClsBtn').setIconCls(icon);
		});
		
		function insertVal(editor, val) {
			var doc = editor.getDoc();
			var cursor = doc.getCursor(); // gets the line number in the cursor position
			doc.replaceRange(val, cursor); // adds a new line
		}

		//可选常量
		function constantFreeChanged(e) {
			var val = e.value;
			insertVal(sqlEditor, val);
		}
		//条件字段
		function varsFreeChanged(e) {
			var val = e.value;
			insertVal(sqlEditor, val);
		}
		
		function handleFormData(data){
			for(var i=0,j=data.length;i<j;i++){
				if(data[i].name=='sqlFunc'){
					data[i].value=sqlEditor.getValue();
					break;
				}
			}
			return {isValid:true,formData:data};
		}

	</script>
</body>
</html>