<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>按钮编辑框-mini-buttonedit</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="mini-toolbar">
			<a class="mini-button"  onclick="CloseWindow('ok')">保存</a>
			<a class="mini-button btn-red" onclick="CloseWindow()">关闭</a>
	</div>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="0" cellpadding="1">
					<tr id="checkdlgTr">
						<td>自定义对话框</td>
						<td colspan="3">
							<span id="bindDlgDiv">
								绑定的对话框&nbsp; &nbsp; &nbsp; 
								<input class="mini-buttonedit" id="dialogalias" textName="dialogname" allowInput="false" name="dialogalias" onbuttonclick="selectDialog" style="width: 60%" />
							</span>
						</td>
					</tr>
					<tr>
<!-- 						<th>必　填<span class="star">*</span></th> -->
<!-- 						<td><input class="mini-checkbox" name="required" -->
<!-- 							id="required" /> 是</td> -->
						<td>允许文本输入</td>
						<td><input class="mini-checkbox" name="allowinput"
							id="allowinput" />
							 是</td>
							 
							<input class="mini-hidden" name="field"
							id="field" />
						
					</tr>
					<tr>
					</tr>
						<td>显示清除</td>
						<td><input class="mini-checkbox" name="showclose"
							id="showclose" /> 是</td>
					</tr>
					<tr id="bindDlgTr1">
<!-- 						<th>绑定返回文本</th> -->
<!-- 						<td><input class="mini-combobox" textField="field" -->
<!-- 							valueField="field" name="textfield" id="textField" -->
<!-- 							allowInput="true" /></td> -->
						<td>绑定返回值</td>
						<td><input class="mini-combobox" textField="field"
							valueField="field" name="valuefield" id="valueField"
							allowInput="true" /></td>
					</tr>
					<tr id="bindDlgTr2">
						<td>返回值绑定</td>
						<td colspan="3" style="padding: 5px;">
							
							<div class="form-toolBox">
								<a class="mini-button btn-red"  plain="true" onclick="removeRow">删除</a>
							</div>
							
							
							<div id="returnFields" class="mini-datagrid" style="width:100%;minHeight:120px" height="auto" showPager="false" 
								allowCellEdit="true" allowCellSelect="true" multiSelect="true" oncellbeginedit="gridBtnReturnBeginEdit" allowSortColumn="false">
							    <div property="columns">
							        
							        <div type="checkcolumn" width="20"></div>
							        <div field="field" displayfield="header"  headerAlign="center" >返回字段</div> 
							        <div field="bindField" displayField="bindFieldName" width="120" headerAlign="center">绑定字段
							         	<input property="editor"  class="mini-combobox"  valueField="field" textField="header" showNullItem="true" nullItemText="请选择..." />
							        </div>
							    </div>
							</div>
						</td>
					</tr>
				</table>
			</form>
	</div>
<!-- 	<div style="display:none;"> -->
<!-- 		<textarea id="inputScriptEditor"  class="mini-textarea" emptyText="请输入脚本"></textarea> -->
<!-- 		<textarea id="rtnScriptEditor"  class="mini-textarea" emptyText="请输入脚本"></textarea> -->
<!-- 		<input id="inputColumnMapEditor" class="mini-combobox"  valueField="name" textField="comment" /> -->
<!-- 	</div> -->
	<script type="text/javascript">
		
		
		mini.parse();
		var fields=[];
		var form=new mini.Form('miniForm');
 		grid=mini.get('returnFields');
		
		function addRow(){
			grid.addRow({});
		}
		
		function removeRow(){
			var selecteds=grid.getSelecteds();
			grid.removeRows(selecteds);
		}
		
		function selectDialog(){
			_OpenWindow({
				url:'${ctxPath}/sys/core/sysBoList/dialog.do',
				height:450,
				width:800,
				title:'选择对话框',
				ondestroy:function(action){
					if(action!='ok') return;
					var win=this.getIFrameEl().contentWindow;
					var rs=win.getData();
					
					if(!rs) return;
					
					var dialogObj=mini.get('dialogalias');
					
					dialogObj.setValue(rs.key);
					dialogObj.setText(rs.name);
					
					//返回值设定
					var rtnAry=getReturnList(rs);
					
					
					if(rtnAry.length==0) {
						alert("请设置对话框的返回列!");
						return;
					}
				 
					mini.get('returnFields').setData(rtnAry);
					mini.get('valueField').setData(rtnAry);
					//mini.get('textField').setData(rtnAry);
				}
			});
		}
		
		function gridBtnReturnBeginEdit(e){
  			var editor=e.editor;
  			if(editor){
  				editor.setData(fields);	
  			}
			
		}
		
		function setData(data){
			form.setData(data);
			if(data&&data.returnFields){
				mini.get("returnFields").setData(data.returnFields);
			}
		}
		
		function getData(){
			var formData=form.getData();
			formData.returnFields=mini.get("returnFields").getData();
			return formData;
		}
		
		function setColumnFields(returnfields){
			fields=returnfields;
		}
			
		/**
		 * 返回列表数据。
		 * @param rs
		 * @returns
		 */
		function getReturnList(rs){
			var rtnJson=mini.decode(rs.fieldsJson);
			var rtnAry=[];
			for(var i=0;i<rtnJson.length;i++){
				var o=rtnJson[i];
				if(o.isReturn=="YES"){
					rtnAry.push(o);
				}
			}
			return rtnAry;
		}
	</script>
</body>
</html>
