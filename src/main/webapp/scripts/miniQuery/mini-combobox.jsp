<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI" %>
<!DOCTYPE html>
<html>
<head>
<title>下拉列表</title>
<%@include file="/commons/edit.jsp"%>
<script src="${ctxPath}/scripts/share/dialog.js"></script>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="CloseWindow('ok')">保存</a>
			<a class="mini-button btn-red" onclick="CloseWindow()">关闭</a>
		</div>
	</div>
<div class="mini-fit" style="background: #fff">
	<div style="width:100%;text-align: center">
		<div style="margin-left:auto;margin-right: auto;padding:5px;">
			<form id="miniForm">
			
				<table class="table-detail column-four" cellpadding="1" cellspacing="0">
					<tr>
						<td>字段备注<span class="star">*</span></td>
						<td>
							<input class="mini-textbox" name="fieldLabel" required="true" vtype="maxLength:100,chinese"  style="width:90%" emptytext="请输入字段备注" />
						</td>
						<td>
							空文本提示
						</td>
						<td>
							<input class="mini-textbox" name="emptytext" style="width:90%"/>
						</td>
					</tr>
					<tr>
						<td>字段标识<span class="star">*</span></td>
						<td>
							<input id="fieldName" class="mini-combobox" name="fieldName"  allowInput="true"
								textField="header" valueField="field"
								style="width:90%;">
						</td>
						<td>比较类型</td>
						<td>
							<input class="mini-combobox" id="opType" name="opType"  data="opData" textField="fieldOpLabel" valueField="fieldOp" style="width:90%;">
						</td>
					</tr>
					<tr>
						<td witdth="15%">值来源</td>
						<td colspan="3" witdth="35%">
							<div id="from" name="from" class="mini-radiobuttonlist" onvaluechanged="fromChanged" required="true"
							data="[{id:'self',text:'自定义'},{id:'url',text:'URL'},{id:'dic',text:'数据字典'},{id:'sql',text:'自定义SQL'}]" value="self"></div>
						</td>
					</tr>
					<tr id="url_row" class="hiddenTr url_row" style="display:none">
						<td>
							JSON URL
						</td>
						<td  colspan="3">
							<input id="url" class="mini-textbox" name="url" required="true" style="width:90%"/>
						</td>
					</tr>
					<tr class="hiddenTr url_row" style="display:none">
						<td>
							文本字段:
						</td>
						<td colspan="3">
							<input id="url_textfield" class="mini-textbox" name="url_textfield" style="width:90%" required="true">
						</td>
					</tr>
					<tr class="hiddenTr url_row" style="display:none">
						<td>
							数值字段:
						</td>
						<td colspan="3">
							<input id="url_valuefield" class="mini-textbox" name="url_valuefield" required="true" style="width:90%">
						</td>
					</tr>
					<tr id="dic_row" class="hiddenTr" style="display:none">
						<td>
							数据字典项
						</td>
						<td  colspan="3">
							<input id="dicKey" name="dickey" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listDicTree.do"  style="width:450px"
						        textField="name" valueField="pkId" parentField="parentId" 
						        showFolderCheckBox="false" onnodeclick="setTreeKey(e)"/>
						</td>
					</tr>
					<tr id="selfSQL_row" class="hiddenTr" style="display: none">
						<td witdth="15%">自定SQL设置</td>
						<td colspan="3" style="padding: 5px;" witdth="35%">
							<input id="sql" name="sql" style="width: 250px;"
								   class="mini-buttonedit"
								   onbuttonclick="onButtonEdit_sql"
							/>
							&nbsp;&nbsp;&nbsp;&nbsp;文本字段：
							<input id="sql_textfield"
								   name="sql_textfield"
								   class="mini-combobox"
								   style="width: 100px;"
								   data=""
								   valueField="fieldName"
								   textField="comment"
								   required="true"
								   allowInput="false" enabled="false" />
							&nbsp;-&nbsp;数值字段：
							<input id="sql_valuefield"
								   name="sql_valuefield"
								   class="mini-combobox"
								   style="width: 100px;"
								   valueField="fieldName"
								   textField="comment"
								   value=""
								   required="true"
							allowInput="false" enabled="false" />
						</td>
					</tr>										
					<tr id="self_row" class="hiddenTr" style="display:none">
						<td >选项</td>
						<td colspan="3" style="padding:5px;" >
							<div class="form-toolBox" >
								<a class="mini-button"   plain="true" onclick="addRow">新增</a>
								<a class="mini-button btn-red"  plain="true" onclick="removeRow">删除</a>

								<a class="mini-button"  plain="true" onclick="upRow">向上</a>
								<a class="mini-button"  plain="true" onclick="downRow">向下</a>
							</div>
							<div id="props" class="mini-datagrid" style="width:100%;min-height:100px;" height="auto" showPager="false"
								allowCellEdit="true" allowCellSelect="true">
							    <div property="columns">
							        <div type="indexcolumn"></div>                
							        <div field="key" width="120" headerAlign="center">标识键
							         <input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" />
							        </div>    
							        <div field="name" width="120" headerAlign="center">名称
							        	<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" />
							        </div>    
							    </div>
							</div>
						</td>
					</tr>
				</table>
			</form>
			</div>
	</div>
</div>
	<script type="text/javascript">

		var opData=[
					{'fieldOp':'EQ','fieldOpLabel':'等于'},
		            {'fieldOp':'LK','fieldOpLabel':'%模糊匹配%'},
		            {'fieldOp':'LEK','fieldOpLabel':'%左模糊匹配'},
		            {'fieldOp':'RIK','fieldOpLabel':'右模糊匹配%'}];
			mini.parse();
			
			var form=new mini.Form('miniForm');
			var grid=mini.get('props');
			function setData(data,fieldDts){
				form.setData(data);
				grid.setData(data.selOptions);
				mini.get('fieldName').setData(fieldDts);
				mini.get('dicKey').setText(data.dicKeyName);
				mini.get('sql').setText(data.sqlName);
				mini.get('sql_textfield').setText(data.sql_textfieldName);
				mini.get('sql_valuefield').setText(data.sql_valuefieldName);
				mini.get('opType').setText(data.fieldOpLabel);
				
				
				fromChanged();
			}
			function getData(){
				var data=form.getData();
				data.selOptions=grid.getData();
				data.dicKeyName=mini.get('dicKey').getText();
				data.sqlName=mini.get('sql').getText();
				data.sql_textfieldName=mini.get('sql_textfield').getText();
				data.sql_valuefieldName=mini.get('sql_valuefield').getText();
				
				data.fieldOpLabel=mini.get('opType').getText();
				
				return data;
			}
			
		
		/*点击选择自定义SQL对话框时间处理*/
		function onButtonEdit_sql(e) {
			var btnEdit = this;
			var callBack=function (data){
				btnEdit.setValue(data.key);   //设置自定义SQL的Key
				btnEdit.setText(data.name);
				_SubmitJson({                             //根据SQK的KEY获取SQL的列名和列头
					url:"${ctxPath}/sys/db/sysSqlCustomQuery/listColumnByKeyForJson.do",
					data:{
						key:data.key
					},
					showMsg:false,
					method:'POST',
					success:function(result){
						var data=result.data;
						var text=mini.get("sql_textfield");
						var value=mini.get("sql_valuefield");
						text.setEnabled(true);   //设置下拉控件为可用状态
						value.setEnabled(true);
						text.setData();          //每次选择不同SQL，清空下拉框的数据
						value.setData();
						text.setData(data.resultField);      //设置下拉框的数据
						value.setData(data.resultField);
					}
				});
			}
			openCustomQueryDialog(callBack);
		}
		
		/*数据来源点击事件处理*/
		function fromChanged(){
			var val=mini.get('from').getValue();
			$(".hiddenTr").css('display','none');
			if(val=='self'){
				$("#self_row").css('display','');
			}else if(val=='url'){
				$(".url_row").css('display','');
			}else if(val=='dic'){
				$("#dic_row").css('display','');
			}else if(val=='sql'){
				$("#selfSQL_row").css('display','');
			}
		}
		
		//添加行
		function addRow(){
			grid.addRow({});
		}
		
		function removeRow(){
			var selecteds=grid.getSelecteds();
			if(selecteds.lengtd>0 && confirm('确定要删除？')){
				grid.removeRows(selecteds);
			}
		}
		
		function upRow() {
            var row = grid.getSelected();
            if (row) {
                var index = grid.indexOf(row);
                grid.moveRow(row, index - 1);
            }
        }
        function downRow() {
            var row = grid.getSelected();
            if (row) {
                var index = grid.indexOf(row);
                grid.moveRow(row, index + 2);
            }
        }
		
		function setTreeKey(e){
			var node=e.node;
			e.sender.setValue(node.key);
			e.sender.setText(node.name);
		}
	</script>
</body>
</html>
