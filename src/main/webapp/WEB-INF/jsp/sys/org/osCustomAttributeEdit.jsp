
<%-- 
    Document   : [自定义属性]编辑页
    Created on : 2017-12-14 14:02:29
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义属性]编辑</title>
<%@include file="/commons/edit.jsp"%>

</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="osCustomAttribute.id" />
<div class="mini-fit">
<div class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${osCustomAttribute.ID}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<tr>
						<td>名　　称</td>
						<td ><input name="attributeName" value="${osCustomAttribute.attributeName}" class="mini-textbox" style="width: 100%" /></td>

						<td>键　　名</td>
						<td ><input name="key" value="${osCustomAttribute.key}" class="mini-textbox" style="width: 100%" /></td>
					</tr>
					<tr>
						<td>属性类型</td>
						<td >
							<div name="attributeType" id="attributeType" class="mini-radiobuttonlist"
								 textField="text" valueField="id" value="${osCustomAttribute.attributeType}" onvaluechanged="changeAttType"
								data="[{'text':'用户类型','id':'User'},{'text':'用户组类型','id':'Group'}]" style="width:90%"></div>
						</td>

						<td>分　　类</td>
						<td >
                            <input class="mini-treeselect"  id="treeId" name = "treeId" multiSelect="false" textField="name"
							valueField="treeId" checkRecursive="false" showFolderCheckBox="false" expandOnLoad="true"
							style="width:100%" />

						</td>
					</tr>
					<tr id="dimension">
						<td>维　　度</td>
						<td colspan="3"><input class="mini-treeselect" id="dimId" name="dimId" url="${ctxPath}/sys/org/osDimension/getAllDimansion.do"
							multiSelect="false" textField="name" valueField="dimId" checkRecursive="false" showFolderCheckBox="false" expandOnLoad="true"
							value="${osCustomAttribute.dimId}" style="width:50%" /></td>
					</tr>
					<tr>
						<td>控件类型</td>
						<td colspan="3"><input class="mini-combobox" name="widgetType" id="widgetType"  textField="text"
							valueField="id" value="${osCustomAttribute.widgetType}" allowInput="false" onvaluechanged="showSource" style="width:50%"
							data="[{'text':'文本控件','id':'textbox'},{'text':'数字控件','id':'spinner'},{'text':'时间控件','id':'datepicker'},{'text':'下拉框','id':'combobox'},{'text':'多选框','id':'radiobuttonlist'}]" />
						</td>
					</tr>
					<tr class="datasource" style="display: none;">
						<td>来源类型</td>
						<td colspan="3"><div name="sourceType" id="sourceType" class="mini-radiobuttonlist"
								 textField="text" valueField="id" value="${osCustomAttribute.sourceType}" style="width:50%"
											 data="[{'text':'url','id':'URL'},{'text':'自定义','id':'CUSTOM'}]" onvaluechanged="changeSourceType"></div>
						</td>

					</tr>
					<tr class="datasource" style="display: none;">
					<td>值  来  源</td>
						<td id="sourceTD" colspan="4"></td>
					</tr>
				</table>
			</div>
		</form>

	<rx:formScript formId="form1" baseUrl="sys/org/osCustomAttribute" entityName="com.redxun.sys.org.entity.OsCustomAttribute" />
</div>
</div>
	<script type="text/javascript">
		addBody();
		mini.parse();
		var widgetType=mini.get("widgetType");
		var sourceType=mini.get("sourceType");
		var valueSource=mini.get("valueSource");
		var attributeType=mini.get("attributeType");
        //记录tree值
		var recordVal = ""


		showSource();
		changeSourceType();
        hiddenTree();
		initGridData();
		changeAttType();


		function hiddenTree() {
            var attrType=attributeType.getValue();
            var url="";
            if(attrType=="User"){
                url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE"
            }else{
                url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE_GROUP"
            }
            var tr = mini.get("treeId")
            tr.load(url)
            tr.setValue(${osCustomAttribute.treeId})
        }

		function showSource(){
			var wType=widgetType.getValue();
			if(wType=="combobox"||wType=="radiobuttonlist"){
				$(".datasource").show();
			}else{
				$(".datasource").hide();
			}
		}
		function changeSourceType(){
			var sType=sourceType.getValue();
			if(sType=="URL"){
				$("#sourceTD").html('<div id="URLSource" >'+
									'<div><input id="valueSource" name="valueSource" value="${osCustomAttribute.valueSource}" class="mini-textbox" style="width: 90%" /></div>' +
									'<div style="padding-top:6px;">文本字段:<input id="url_text" class="mini-textbox" name="url_text" style="width:120px; padding:10px;" required="true">' +
									'&nbsp;&nbsp;数值字段:<input id="url_value" class="mini-textbox" name="url_value" required="true" style="width:120px;"></div></div>'
									);
			}else if(sType=="CUSTOM"){
				$("#sourceTD").html('<div id="toolbar1" class="form-toolBox" ><a class="mini-button"   plain="true" onclick="addData">添加数据</a><a class="mini-button btn-red" plain="true" onclick="removeData">删除数据</a></td></div><div id="sourceData" name="sourceData" class="mini-datagrid" style="width: 100%;" allowCellEdit="true" height="auto" allowCellEdit="true" allowCellSelect="true"  idField="groupId" showPager="false"><div property="columns"><div type="indexcolumn"  headerAlign="center">序号</div><div field="text" name="text" width="160">名<input property="editor" class="mini-textbox" required="true" style="width:100%;" minWidth="200" /></div><div field="id" name="id" width="200">值<input property="editor" class="mini-textbox" required="true" style="width:100%;" minWidth="200" /></div></div></div>');
			}
			mini.parse();
		}

		function addData(){
			var grid=mini.get("sourceData");
			grid.addRow({});
		}
		function removeData(){
			var grid=mini.get("sourceData");
		    var row = grid.getSelected()
			if (!row) {
				alert('请选择需要删除的行!');
				return;
			}
			grid.removeRow(row);
		}

		//动态设置每列的编辑器
		function changeColumnEditor(e) {
			var field = e.field, rs = e.record;
			if (field == "relTypeName") {
				e.editor = mini.get('relTypeEditor');
			} else if (field == 'partyName1') {
				if (!rs.relTypeName) {
					return;
				}
				if (rs.relTypeCat == 'GROUP-USER') {
					e.editor = mini.get('groupEditor');
				} else {
					e.editor = mini.get('userEditor');
				}
			}
			e.column.editor = e.editor;
		}

		function initGridData(){
			var widgetTypeValue=widgetType.getValue();
	        if((widgetTypeValue!='textbox'||widgetTypeValue!='spinner'||widgetTypeValue!='datepicker')){
	        	var gridData=JSON.parse('${osCustomAttribute.valueSource}');
	        	if(sourceType.getValue()=="CUSTOM"){
	        		var grid=mini.get("sourceData");
					grid.setData(gridData);
	        	}else if(sourceType.getValue()=="URL"){
	        		mini.get("valueSource").setValue(gridData[0].URL);
	        		mini.get("url_text").setValue(gridData[0].key);
	        		mini.get("url_value").setValue(gridData[0].value);
	        	}

	        }

		}

		function changeAttType(e){
		    var tre = mini.get("treeId")
		    var temp = recordVal;
            recordVal =tre.getValue()
		    var url="";
		    if(e.value=="User"){
                $("#dimension").hide();
                url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE"
            }else{
                $("#dimension").show();
                url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE_GROUP"
            }
            tre.load(url)
            tre.setValue(temp)
		}

		function selfSaveData(){
			form.validate();
			if(!specialValidation()||!form.isValid()){
				mini.showTips({
		            content: "<b>注意</b> <br/>表单有内容尚未填写",
		            state: 'danger',
		            x: 'center',
		            y: 'center',
		            timeout: 3000
		        });
				return;
			}
			var formData=form.getData();
		        var widgetTypeValue=widgetType.getValue();
		        if((widgetTypeValue!='textbox'&&widgetTypeValue!='spinner'&&widgetTypeValue!='datepicker')){
		        	if(sourceType.getValue()=="CUSTOM"){
		        		var grid=mini.get("sourceData");
			        	formData.valueSource=JSON.stringify(grid.getData());
		        	}else if(sourceType.getValue()=="URL"){
		        		var urlData = mini.get("valueSource").getValue();
		        		var url_text = mini.get("url_text").getValue();
		        		var url_value = mini.get("url_value").getValue();
		        		formData.valueSource = JSON.stringify([{"URL" : urlData, "key" : url_text, "value" : url_value}]);
		        	}

		        }
		        var config={
		        	url:"${ctxPath}/sys/org/osCustomAttribute/save.do",
		        	method:'POST',
		        	data:formData,
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
		
		function specialValidation(){
			var widgetTypeValue=widgetType.getValue();
			if((widgetTypeValue!='textbox'&&widgetTypeValue!='spinner'&&widgetTypeValue!='datepicker')){
				var sourceTypeValue=sourceType.getValue();
				if(sourceTypeValue==""||sourceTypeValue==null){//没选类型
					return false;
				}else if(sourceTypeValue=="URL"){
					if(mini.get("valueSource").getValue()==""||mini.get("valueSource").getValue()==null){//没填URL
						return false
					}
				}else if(sourceTypeValue=="CUSTOM"){
					var grid=mini.get("sourceData");
					if(grid.getData().length<1){//没填grid
						return false
					}
				}
			}
			return true;
		}
		
	</script>
</body>
</html>