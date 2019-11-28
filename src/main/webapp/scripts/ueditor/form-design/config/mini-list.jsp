<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>wor预览控件</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="1" cellpadding="1">
					<tr>
						<td>
							<span class="starBox">
								选择列表<span class="star">*</span>
							</span>
						</td>
						<td>
							<input id="listId" name="listId" textname="ListName" class="mini-buttonedit" onbuttonclick="onButtonEdit" style="width:100%;"/>
						</td>
					</tr>
					<tr>
						<td>
							模式
						</td>
						<td >
							<div name="gridMode" id="gridMode" class="mini-radiobuttonlist"    textField="text" valueField="id" value="relQuery" 
								onvaluechanged="onGridMode"
    							data="[{id:'relQuery',text:'关联查询'},{id:'relFill',text:'关联填充'},{id:'list',text:'列表'}]" >
							</div>
						</td>
					</tr>
					
					<tr id="trRelQuery">
						<td>
							关联字段配置
						</td>
						<td >
							<div class="form-toolBox" >
						            <a class="mini-button " onclick="addRelRow">添加</a>
						            <a class="mini-button btn-red"  onclick="removeRow('gridRelation')">删除</a>
						            <span class="separator"></span>
						            <a class="mini-button" onclick="upRowGrid('gridRelation')">向上</a>
						            <a class="mini-button"  onclick="downRowGrid('gridRelation')">向下</a>
							</div>
							<div id="gridRelation" class="mini-datagrid"  style="width:100%;min-height:150px"  oncellbeginedit="onFieldSelected"
								 showPager="fasle"  allowCellEdit="true" allowCellSelect="true">
							    <div property="columns">
							        <div type="indexcolumn"></div>                
							        <div field="mField" width="120" headerAlign="center"  >主表字段</div>    
							        <div field="qField" width="120" headerAlign="center"  >列表查询字段</div>
							        <div field="field" width="120" headerAlign="center"  >表单字段
							        	<input property="editor" class="mini-textbox" style="width:100%;"  />
							        </div>
							    </div>
							</div>
						</td>
					</tr>
					<tr id="trFill" style="display:none;">
						<td>
							填充配置
						</td>
						<td >
							目标子表:<input 
								id="toTable" 
								class="mini-combobox" 
								textField="comment" 
								valueField="name" 
								required="true" 
								allowInput="false" 
								onvaluechanged="onChangeTable"
								nullItemText="请选择"
								showNullItem="true"
							/>
							唯一字段:<input 
								id="uniqueField" 
								class="mini-combobox" 
								textField="comment" 
								valueField="name" 
								allowInput="false" 
								nullItemText="请选择"
								showNullItem="true"
							/>
							<div class="form-toolBox" >
						            <a class="mini-button "  onclick="addFillRow">添加</a>
						            <a class="mini-button btn-red" onclick="removeRow('gridRelFill')">删除</a>
						            <span class="separator"></span>
						            <a class="mini-button"  plain="true" onclick="upRowGrid('gridRelFill')">向上</a>
						            <a class="mini-button"  plain="true" onclick="downRowGrid('gridRelFill')">向下</a>
							</div>
							<div id="gridRelFill" class="mini-datagrid" style="width:100%;height:150px"   showPager="fasle" oncellbeginedit="onFillSelected" 
								allowCellEdit="true" allowCellSelect="true">
							    <div property="columns">
							        <div type="indexcolumn"></div>                
							        <div field="src" width="120" headerAlign="center" >源字段</div>    
							        <div field="to" width="120" headerAlign="center"  >目标字段</div>    
							    </div>
							</div>
						</td>
					</tr>
				</table>
			</form>
	</div>
	<div style="display:none">
			<input 
				id="fieldEditor" 
				class="mini-combobox" 
				style="width:100%" 
				textField="comment" 
				valueField="name" 
				required="true" 
				allowInput="false" 
				showNullItem="true"
				nullItemText="请选择"
			/>
			
			<input 
				id="myFieldEditor" 
				class="mini-combobox" 
				style="width:100%" 
				textField="comment" 
				valueField="name" 
				required="true" 
				allowInput="false" 
				showNullItem="true"
				nullItemText="请选择"
				onvaluechanged="handFieldChange"
			/>
	</div>
	<script type="text/javascript">
		var metaData=null;
	
		mini.parse();
		var form=new mini.Form('miniForm');
		//编辑的控件的值
		var oNode = null,
		thePlugins = 'mini-list';
		var pluginLabel="${fn:trim(param['titleName'])}";
		
		var isCreate=true;
		
		var editdom=null;
		
		window.onload = function() {
			var content=editor.formContainer.aryForm.join("");
			metaData=getMetaDataByContent(content);
			bindToTable(metaData);
			//编辑。
			if( UE.plugins[thePlugins].editdom ){
				editdom=UE.plugins[thePlugins].editdom;
				var parent=$(UE.plugins[thePlugins].editdom);
				var grid=$(".mini-datagrid",parent);
				var options=eval("(" + grid.attr("data-options") +")");
				setFormByJson(options);
				
				isCreate=false;
			}
		};
		
		function bindToTable(metaData){
			var tbCombox=mini.get("toTable");
			var aryTb=[];
			for(var key in metaData){
				if(key=="main") continue;
				var obj=metaData[key];
				var o={name:key,comment:obj.comment};
				aryTb.push(o);
			}
			tbCombox.setData(aryTb);
		}
		
		//取消按钮
		dialog.oncancel = function () {
		    if( UE.plugins[thePlugins].editdom ) {
		        delete UE.plugins[thePlugins].editdom;
		    }
		};
		//确认
		dialog.onok = function (){
			form.validate();
			if(!form.isValid()) return;
	        
	        var formData=form.getData();
	        
	        var jqHtml=$(gridHtml);
	        var grid=$(".relation-grid",jqHtml);
	        var json=eval("(" +grid.attr("data-options") +")");
	        //收集数据。
	        var options= getSettingJson();
	        $.extend(json, options);
	        
	        grid.attr("data-options",JSON.stringify(json));
	        
	        if(isCreate){
	        	editor.execCommand('insertHtml',jqHtml.prop("outerHTML"));
	        }
	        else{
	        	editdom.parentNode.innerHTML=jqHtml.prop("outerHTML");
	        }
	        
		};
		
		function onChangeTable(e){
			var obj=mini.get("uniqueField");
			var val=e.value;
			var fields=metaData[val].fields;
			obj.setData(fields);
		}
		
		//点击编辑,重新设置参数。
		function setFormByJson(json){
			var listIdObj=mini.get("listId");
			var uniObj=mini.get("uniqueField");
			listIdObj.setText(json.ListName);
			listIdObj.setValue(json.listId);
			
			//加载列表
			loadDataByListId(json.listId,json.gridMode);
			
			var gridModeObj=mini.get("gridMode");
			gridModeObj.setValue(json.gridMode);
			gridModeObj.doValueChanged();
			
			
			var gridMode=json.gridMode;
			if(gridMode=="relQuery"){
				mini.get("gridRelation").setData(json.mapping);
			}
			else if (gridMode=="relFill"){
				mini.get("toTable").setValue(json.toTable);
				mini.get("gridRelFill").setData(json.mapping);
				
				uniObj.setValue(json.uniField);
			}
		}
		
		//获取配置
		function getSettingJson(){
			var listId=mini.get("listId");
			var uniObj=mini.get("uniqueField");
			var rtn={};
			//自定列表。
			rtn.listId=listId.getValue();
			rtn.ListName=listId.getText();
			//模式
			var gridMode=mini.get("gridMode").getValue();
			rtn.gridMode=gridMode;
			//[{id:'relQuery',text:'关联查询'},{id:'relFill',text:'关联填充'},{id:'list',text:'列表'}]
			if(gridMode=="relQuery"){
				var data=mini.get("gridRelation").getData();
				_RemoveGridData(data);
				rtn.mapping=data;
			}
			else if (gridMode=="relFill"){
				var toTable=mini.get("toTable").getValue();
				var data=mini.get("gridRelFill").getData();
				_RemoveGridData(data);
				rtn.mapping=data;
				rtn.toTable=toTable;
				rtn.uniField=uniObj.getValue();
			}
			return rtn;
			
		}
		
		var gridHtml="";
		//关联表字段。
		var relFields=[];
		//搜索字段
		var searchFields=[];
		
		function onButtonEdit(e){
			var btn=e.sender;
			var gridMode=mini.get("gridMode").getValue();
			openSysBoListDialog({callback:function(data){
					btn.setText(data.name);
					btn.setValue(data.id);
					//加载数据。
					loadDataByListId(data.id,gridMode);
				}
			});
		}
		
		//加载数据。
		function loadDataByListId(id,gridMode){
			var params={id:id,gridMode:gridMode};
			var url=__rootPath +"/sys/core/sysBoList/genFormHtml.do";
			searchFields=[];
			relFields=[];
			$.post(url,params,function(res){
				gridHtml=res.html;
				for(var i=0;i<res.fields.length;i++){
					var tmp=res.fields[i];
					if(!tmp.field) continue;
					relFields.push({name:tmp.field,comment:tmp.header});
				}
				for(var i=0;i<res.searchFields.length;i++){
					var tmp=res.searchFields[i];
					var name="Q_" + tmp.fieldName +"_" + tmp.queryDataType +"_" +tmp.fieldOp;
					searchFields.push({name:name,comment:tmp.fieldLabel,field:tmp.fieldName})
				}
			})
		}
		
		function onGridMode(e){
			//trRelQuery,trFill
			var trRelQuery=$("#trRelQuery");
			var trFill=$("#trFill");
			var val=e.value;
			//[{id:'relQuery',text:'关联查询'},{id:'relFill',text:'关联填充'},{id:'list',text:'列表'}]
			if(val=="relQuery"){
				trRelQuery.show();
				trFill.hide();
			}
			else if(val=="relFill"){
				trRelQuery.hide();
				trFill.show();
			}
			else{
				trRelQuery.hide();
				trFill.hide();
			}
		}
		
		function removeRow(gridId){
			var grid=mini.get(gridId);
			grid.removeRow(grid.getSelected(),true);
		}
		
		function addRelRow(e){
			var listObj=mini.get("listId");
			if(!listObj.getValue()) {
				alert("请选择一个列表!");
				return ;
			}
			var grid=mini.get("gridRelation");
			grid.addRow({});
		}
		
		function addFillRow(e){
			var listObj=mini.get("listId");
			if(!listObj.getValue()) {
				alert("请选择一个列表!");
				return ;
			}
			var grid=mini.get("gridRelFill");
			grid.addRow({});
		}
		//填充字段。
		function onFieldSelected(e) {
		    var field = e.field,rs=e.record;
		    var editor=null;
		    if (field == "mField") {
		    	editor=mini.get('fieldEditor');
		    	var fields=metaData.main.fields;
		    	fields.splice(0,0,{name:"ID_",comment:"主键"})
			    editor.setData(fields);
		    	e.editor=editor;
				e.column.editor=editor;
		    }
		    else if(field == "qField"){
		    	editor=mini.get('myFieldEditor');
		    	editor.setData(searchFields);
		    	e.editor=editor;
				e.column.editor=editor;
		    }
		    
		   
		}
		
		function handFieldChange(e){
			var grid=mini.get("gridRelation");
			 var item=e.sender.getSelected();
			  var row=grid.getEditorOwnerRow(e.sender);
			  grid.updateRow(row,{field:item.field})
		}
		
		function onFillSelected(e){
			 var field = e.field;
			 if(field=="src"){
				var editor=mini.get('fieldEditor');
				editor.setData(relFields);
			    e.editor=editor;
			    e.column.editor=editor;
			 }
			 else if(field=="to"){
				var toTable=mini.get("toTable").getValue();
				if(!toTable){
					alert("请选择映射到的表!");
					return;
				}
				 var editor=mini.get('fieldEditor');
				 var fields=metaData[toTable].fields;
				 editor.setData(fields);
				 e.editor=editor;
				 e.column.editor=editor;
			 }
		}
		
		  
	</script>
</body>
</html>
