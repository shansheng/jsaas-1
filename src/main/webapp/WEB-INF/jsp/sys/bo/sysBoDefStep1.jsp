<%-- 
    Document   : [BO定义]列表页
    Created on : 2017-03-01 23:24:22
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>业务模型列表管理</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	    <div title="业务模型" region="north"  showCloseButton="false" showHeader="false" height="120">
				<div class="mini-toolbar">
					<a class="mini-button"  onclick="onSave">保存</a>
					<a class="mini-button" iconCls="icon-script" onclick="genTable">生成物理表</a>
					<a class="mini-button btn-red" onclick="CloseWindow('ok')">关闭</a>
				</div>
				<div id="boDefForm">
					
					<table class="table-detail" cellspacing="0" cellpadding="0">
						<tr>
							<th style="width:10%">
								<span class="starBox">
									分　　类  <span class="star">*</span>
								</span>
							</th>
							<td style="width:20%">
								<input id="pkId" name="ID" class="mini-hidden" value="${sysBoDef.id}" />
								<input 
							 	id="treeId" 
							 	name="treeId" 
							 	class="mini-treeselect" 
							 	url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_FORM_VIEW" 
							 	multiSelect="false" 
							 	textField="name" 
							 	valueField="treeId" 
							 	parentField="parentId"  
							 	required="true" 
							 	value="${sysBoDef.treeId}" 
							 	pinyinField="right"
						        showFolderCheckBox="false"  
						        expandOnLoad="true" 
						        showClose="true" 
						        oncloseclick="onClearTree" 
						       style="width:100%"/>
							</td>
							<th style="width:10%"> 
								<span class="starBox">
									名　　称 <span class="star">*</span>
								</span>
							</th>
							<td style="width:20%">
								<input class="mini-textbox" name="name" value="${sysBoDef.name}" style="width:90%;" required="true">
							</td>
							<th style="width:10%"> 
								<span class="starBox">
									别 名 <span class="star">*</span>
								</span>
							</th>
							<td style="width:20%">
								<input class="mini-textbox" name="alais" value="${sysBoDef.alais}" style="width:90%;" required="true">
							</td>
							</tr>
							<tr>
								<th style="width:10%">
									备注
								</th>
								<td colspan="5">
									<input class="mini-textbox" value="${sysBoDef.comment}" style="width:90%;" name="comment">
								</td>
							</tr>
					</table>
				</div>
			</div>

		  <div title="对象实体列表" region="center" height="200"  showHeader="true" showCollapseButton="false">
				<div class="mini-toolbar">
					<a class="mini-button"   onclick="onAddRow">添加</a>
					<a class="mini-button"   onclick="onSelEntDlg">添加业务对象</a>
					<a class="mini-button"   onclick="addFromDb">从数据库添加</a>
					<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRow('datagrid1')">向上</a>
					<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRow('datagrid1')">向下</a>		
					<a class="mini-button btn-red" iconCls="icon-remove" onclick="removeEntRow">删除</a>
				</div>
				<div class="mini-fit">
					<div id="entGrid" class="mini-datagrid" style="width:100%; height:100%;" allowResize="false"
						url="${ctxPath}/sys/bo/sysBoDef/getBoEntities.do?boDefId=${sysBoDef.id}" 
						onrowclick="onEntRowClick" allowCellValid="true" oncellvalidation="onEntCellValidation" 
		            	allowCellEdit="true" allowCellSelect="true" oncellendedit="onEntCellEndEdit" 
						multiSelect="false" showPager="false" allowAlternating="true" >
						<div property="columns">
							<div type="indexcolumn" width="40"></div>
							<div type="checkcolumn" width="20"></div>
							<div name="tableName" field="tableName" width="100" headerAlign="center">表名
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div name="name" field="name" width="100" headerAlign="center">名称
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div name="comment" field="comment" width="180" headerAlign="center">注释
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div field="relationType" width="80" headerAlign="center">关系类型
								<input property="editor" class="mini-combobox" style="width:100%" required="true"
								required="true" data="[{id:'main',text:'主表'},{id:'sub',text:'从表'}]" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<div  title="对象实体配置" region="east" width="350" showHeader="true" >
				<div class="mini-toolbar">
					<a class="mini-button"  onclick="onSaveBoEnt">保存</a>
				</div>
				<div id="entForm">
					<table class="table-detail column_2" cellspacing="0" cellpadding="0">
						<tr>
							<th> 
								<span class="starBox">
									名　　称 <span class="star">*</span>
								</span>
							</th>
							<td>
								<input class="mini-textbox" name="name" required="true">
							</td>
						</tr>
						<tr>
							<th> 
								<span class="starBox">
									表 名 <span class="star">*</span>
								</span>
							</th>
							<td >
								<input class="mini-textbox" name="tableName" required="true">
							</td>
						</tr>
						<tr>
							<th>
								表说明
							</th>
							<td>
								<input class="mini-textbox"  name="comment">
							</td>
						</tr>
						<tr>
							<th style="width:10%">
								与主表关系
							</th>
							<td>
								<input id="relationType" name="relationType" class="mini-combobox" style="width:100%"  onvaluechanged="changeRelationType()"
								required="true" data="[{id:'main',text:'主表'},{id:'sub',text:'从表'}]" />
							</td>
						</tr>
						<tr id="linkRelation1" style="display:none">
							<th>
								主表关联字段
							</th>
							<td>
								<input name="mainField" class="mini-textbox" required="true"/>
							</td>
						</tr>
						<tr id="linkRelation2" style="display:none">
							<th>
								子表关联字段
							</th>
							<td>
								<input name="subField" class="mini-textbox" />
							</td>
						</tr>
						<tr>
							<th>数据源</th>
							<td>
								<input name="dsName" class="mini-buttonedit" onclick="selectDatasource"/>
							</td>
						</tr>
						<tr>
							<th>
								树结构
							</th>
							<td>
								<input name="tree" class="mini-combobox" allowinput="false" 
								data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]" required="true"/>
							</td>
						</tr>
						<tr>
							<th>
								主键字段
							</th>
							<td>
								<input name="pkField" class="mini-textbox" required="true"/>
							</td>
						</tr>
						<tr>
							<th>
								父键字段
							</th>
							<td>
								<input name="parentField" class="mini-textbox" required="true"/>
							</td>
						</tr>
						
					</table>
				</div>
			</div>
			<div title="字段列表" region="south" height="250" >
				<div class="mini-toolbar">
				<a class="mini-button"   onclick="onAddFieldRow">添加</a>
				<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRow('fieldGrid')">向上</a>
				<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRow('fieldGrid')">向下</a>		
				<a class="mini-button btn-red" iconCls="icon-remove" onclick="delFieldRow(false)">删除</a>
				<a class="mini-button btn-red" iconCls="icon-remove" onclick="delFieldRow(true)">物理删除</a>
				<a class="mini-button" iconCls="icon-edit" onclick="onFieldConfig()">属性配置</a>
				</div>
				<div class="mini-fit">
					<div id="fieldGrid" class="mini-datagrid" style="width:100%; height:100%;" allowResize="false"
						onrowclick="onFieldRowClick" allowCellValid="true" oncellvalidation="onFieldCellValidation" 
		            	allowCellEdit="true" allowCellSelect="true" oncellendedit="onFieldCellEndEdit" 
						multiSelect="false" showPager="false" allowAlternating="true">
						<div property="columns">
							<div type="indexcolumn" width="40"></div>
							<div type="checkcolumn" width="20"></div>
							<div name="name" field="name" width="120" headerAlign="center">字段名
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div name="fieldName" field="fieldName" width="120" headerAlign="center">字段Key
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div field="control" name="control" width="100" headerAlign="center">控件类型
								<input property="editor" class="mini-combobox" style="width:100%" required="true"
								required="true" data="controls" />
							</div>
							<div name="comment" field="comment" width="150" headerAlign="center">注释
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	<script type="text/javascript">
		mini.parse();
		var entGrid=mini.get('entGrid');
		var fieldGrid=mini.get('fieldGrid');
		var boDefForm=new mini.Form('boDefForm');
		var entForm=new mini.Form('entForm');
		var layout=mini.get('layout1');
		entGrid.load();
		var controls=[
			{id:'default_',text:'缺省属性控件'},
			{id:'pk_',text:'主键字段'},
			{id:'mini-textbox',text:'文本控件'},
			{id:'mini-textarea',text:'多行文本控件'},
			{id:'mini-datepicker',text:'日期控件'}];
		
		function changeRelationType(){
			var combo=mini.get('relationType');
			
			if(combo.getValue()=='sub'){
				$('#linkRelation1').css('display','');
				$('#linkRelation2').css('display','');
			}else{
				$('#linkRelation1').css('display','none');
				$('#linkRelation2').css('display','none');
			}
		}
		//从数据库中添加
		function addFromDb(){
			
			_OpenWindow({
				title:'从数据库中查找表',
				url:__rootPath+'/sys/db/sysDbTable/dialog2.do',
				height:500,
				width:800,
				ondestroy:function(action){
					
					if(action!='ok'){
						return;
					}
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.getData();
					if(!data){
						return;
					}
					var ds=iframe.contentWindow.getDbAlias();
					var query=data.tableName;
					var queryType=data.type;
					
					
					
					_SubmitJson({
						url:__rootPath+'/sys/db/sysDb/getColumns.do',
						showMsg:false,
						data:{
							query:query,
							queryType:queryType,
							ds:ds
						},
						success:function(result){
							var cols=result.data;
							var columns=[];
							for(var i=0;i<cols.length;i++){
								columns.push({
									name:cols[i].fieldLabel,
									fieldName:cols[i].fieldName,
									dataType:cols[i].dataType,
									control:'mini-textbox',
									length:cols[i].length
								});
							}
							entGrid.addRow({
								name:data.comment,
								tableName:data.tableName,
								comment:data.comment,
								relationType:'sub',
								sysBoAttrsJson:mini.encode(columns)
							});
							//fieldGrid.setData(columns);
						}
					});
				}
			});
		}
		//选择数据源
		function selectDatasource(e){
			var btnEdit=e.sender;
			mini.open({
				url : "${ctxPath}/sys/core/sysDatasource/dialog.do",
				title : "选择数据源",
				width : 650,
				height : 380,
				ondestroy : function(action) {
					if (action != "ok") { return;}
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.GetData();
					data = mini.clone(data);
					if (data) {
						btnEdit.setValue(data.alias);
						btnEdit.setText(data.name);
						var row=entGrid.getSelected();
						entGrid.updateRow(row,{dsName:data.alias});
					}
				}
			});
		}
		
		function onAddRow(){
			entGrid.addRow({});
		}
		
		function onSelEntDlg(){
			_OpenWindow({
				title:'业务实体选择',
				width:800,
				height:480,
				url:__rootPath+'/sys/bo/sysBoEnt/dialog.do',
				ondestroy:function(action){
					if(action!='ok'){
						return;
					}
					var win=this.getIFrameEl().contentWindow;
					var data=win.getData();
					
					_SubmitJson({
						url:__rootPath+'/sys/bo/sysBoEnt/getEntInfo.do?entId='+data.entId,
						success:function(result){
							alert(mini.encode(result));
						}
					});
				}
			});
		}
		
		//同时删除物理表
		function removeEntRow(){
			var ids=[];
			var rows=entGrid.getSelecteds();
			for(var i=0;i<rows.length;i++){
				if(rows[i].id){//存在Id
					ids.push(rows[i].id);
				}else{
					entGrid.removeRow(rows[]);
					fieldGrid.setData({});
				}
			}
			if(ids.length>0){
				_SubmitJson({
					url:__rootPath+'/sys/bo/sysBoDef/delEntByIds.do',
					data:{
						boDefId:'${sysBoDef.id}',
						entIds:ids.join(',')
					},
					success:function(result){
						entGrid.removeRows(rows);
						fieldGrid.setData({});
					}
				});
			}
		}
		
		function onAddFieldRow(){
			fieldGrid.addRow({});
		}
		
		function onSaveBoEnt(e){
			entForm.validate();
			if(!entForm.isValid()){
				return;
			}
			var row=entGrid.getSelected();
			entGrid.updateRow(row,entForm.getData());
		}
		
		function onEntRowClick(e){
			var row=entGrid.getSelected();
			if(!row.sysBoAttrsJson || row.sysBoAttrsJson.length==0){
				var attrsJson=[{
					name:'INST_STATUS_',
					fieldName:'INST_STATUS_',
					comment:'流程实例状态',
					dataType:'varchar',
					control:'default_',
					length:20
				},{
					name:'INST_ID_',
					fieldName:'INST_ID_',
					comment:'流程实例ID',
					control:'default_',
					dataType:'varchar',
					length:64
				},{
					name:'CREATE_USER_ID_',
					fieldName:'CREATE_USER_ID_',
					comment:'创建用户ID',
					control:'default_',
					dataType:'varchar',
					length:64
				},{
					name:'CREATE_GROUP_ID_',
					fieldName:'CREATE_GROUP_ID_',
					comment:'创建用户组ID',
					control:'default_',
					dataType:'varchar',
					length:64
				},{
					name:'TENANT_ID_',
					fieldName:'TENANT_ID_',
					comment:'创建机构ID',
					control:'default_',
					dataType:'varchar',
					length:64
				},{
					name:'CREATE_TIME_',
					fieldName:'CREATE_TIME_',
					comment:'创建时间',
					control:'default_',
					dataType:'date'
				},{
					name:'UPDATE_TIME_',
					fieldName:'UPDATE_TIME_',
					comment:'更新时间',
					control:'default_',
					dataType:'date'
				}];
				row.sysBoAttrsJson=mini.encode(attrsJson);
			}
			fieldGrid.setData(mini.decode(row.sysBoAttrsJson));
			entForm.setData(row);
		}
		
		/**
		**删除行
		**/
		function delFieldRow(phDel){
			var rows=fieldGrid.getSelecteds();
			var arrIds=[];
			for(var i=0;i<rows.length;i++){
				if(rows[i].id){
					arrIds.push(rows[i].id);
				}else{
					fieldGrid.removeRow(rows[i]);
				}
			}
			if(arrIds.length>0){
				_SubmitJson({
					url:__rootPath+'/sys/bo/sysBoDef/delEntAttr.do?phDel='+phDel,
					data:{
						arrIds:arrIds.join(',')
					},
					success:function(result){
						fieldGrid.removeRows(rows);
					}
				});
			}
		}
		
		function onEntCellValidation(e){
        	if(e.field=='tableName' && (!e.value||e.value=='')){
        		 e.isValid = false;
        		 e.errorText='表名不能为空！';
        	}
        	
        	var reg = new RegExp(/^[a-zA-Z][0-9a-zA-Z_]*$/); 
        	if(e.field=='tableName' && !reg.test(e.value)) {
        		e.isValid = false;
       		 	e.errorText='表名必须以字母开开头，由英文、数字、下划线组合的标识符！';
        	}
        	
        	var isKeyExist=false;
        	if(e.field=='name' && (!e.value||e.value=='')){
        		e.isValid = false;
       		 	e.errorText='属性名称不能为空！';
        	}

        	if(e.field=='refType'  && (!e.value||e.value=='')){
        		e.isValid = false;
       		 	e.errorText='关联类型不能为空！';
        	}
        }
		
		function onEntCellEndEdit(e){
			var row=entGrid.getSelected();
			entForm.setData(row);
			changeRelationType();
		}
		
		function onFieldCellValidation(e){
			if(e.field=='fieldName' && (!e.value||e.value=='')){
	       		 e.isValid = false;
	       		 e.errorText='字段名不能为空！';
	       	}
	       	
	       	var reg = new RegExp(/^[a-zA-Z][0-9a-zA-Z_]*$/); 
	       	if(e.field=='fieldName' && !reg.test(e.value)) {
	       		e.isValid = false;
	      		 	e.errorText='字段名必须以字母开开头，由英文、数字、下划线组合的标识符！';
	       	}

        	var rows=fieldGrid.getSelecteds();
        	var cn=0;
        	for(var i=0;i<rows.length;i++){
        		var key=rows[i].key;
        		if(key==e.value){
        			cn++;	
        		}
        	}
        	if(cn>1){
        		e.isValid = false;
       		 	e.errorText='属性Key已经存在！';
        	}
        	
        	var isKeyExist=false;
        	if(e.field=='name' && (!e.value||e.value=='')){
        		e.isValid = false;
       		 	e.errorText='属性名称不能为空！';
        	}
        	
        	if(e.field=='fieldName'  && (!e.value||e.value=='')){
        		e.isValid = false;
       		 	e.errorText='字段名不能为空！';
        	}
        	
        	if(e.field=='control'  && (!e.value||e.value=='')){
        		e.isValid = false;
       		 	e.errorText='控件不能为空！';
        	}
        }
		
		function onFieldCellEndEdit(e){
			var row=entGrid.getSelected();
			entGrid.updateRow(row,{sysBoAttrsJson:mini.encode(fieldGrid.getData())});
		}
		
		function onFieldConfig(e){
			var row=fieldGrid.getSelected();
			if(!row) return;
			if(row.control && row.control!='default_'){
				_OpenWindow({
					title:'字段展示配置',
					height:500,
					width:800,
					url:__rootPath+'/scripts/bodesign/'+row.control+'.jsp'
				});
			}
		}
		
		function onSave(){
			boDefForm.validate();
			if(!boDefForm.isValid()){
				return;
			}
			entGrid.validate();
			if(!entGrid.isValid()){
				return;
			}
			//提交Jsono数值 
			_SubmitJson({
				url:__rootPath+'/sys/bo/sysBoDef/saveBoDef.do',
				data:{
					boDefJson:mini.encode(boDefForm.getData()),
					sysBoEnties:mini.encode(entGrid.getData())
				},
				success:function(result){
					alert('成功保存业务对象定义！');
					CloseWindow('ok');
				}
			});
		}
	</script>
</body>
</html>