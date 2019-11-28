<%-- 
    Document   : [业务对象定义]编辑页
    Created on : 2018-05-21 17:43:07
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[业务对象定义]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="sysBoDef.id" />
	<div class="mini-fit">

	<div class="form-container2" id="p1">
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${sysBoDef.id}" />
				 <table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>业务对象定义信息</caption>
					<tr>
						<td>名称：</td>
						<td>
							<input name="name"  class="mini-textbox"   style="width: 100%" required="true"/>
						</td>
						<td>别名：</td>
						<td>
							<input name="alais"  class="mini-textbox"   style="width: 100%"  required="true" />
						</td>
					</tr>
					<tr>
						<td>分类：</td>
						<td>
							<input name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_FORM_VIEW" 
								textField="name"  idField="treeId" resultAsTree="false" parentField="parentId" value="${sysBoDef.treeId}" style="width:100%"/>							
						</td>
						<td>主实体：</td>
						<td>
							<input name="mainEntId" textname="mainEntName"  style="width:70%"  class="mini-buttonedit" allowinput="false" onbuttonclick="onSelectBoEnt" oncloseclick="ClearButtonEdit"  showclose="true"   required="true"/>
							<input id="supportDb" name="supportDb"  class="mini-checkbox" checked="true" trueValue="yes" falseValue="no" text="支持数据库"  />
						</td>
					</tr>
					<tr>
						<td>备注：</td>
						<td colspan="3">
							<input name="comment"  class="mini-textarea"   style="width: 100%" />
						</td>
					</tr>
				</table>
		</form>
	<div class="form-toolBox">
         <a class="mini-button" id="addBtn"    onclick="addEnt()" plain="true" enabled="true">新增</a>
         <a class="mini-button btn-red" id="delBtn" onclick="removeEnt" plain="true" enabled="true">删除</a>
	</div>	
	<div 
			id="datagrid1" 
			class="mini-datagrid" 
			style="width: 100%;" 
			allowResize="false"
			multiSelect="true" 
			showColumnsMenu="true"
			showPager="false" 
			height="auto"
			allowAlternating="true" 
			allowCellEdit="true" allowCellSelect="true"  
		>
			<div property="columns">
				 <div type="checkcolumn"></div>     
				<div field="entId"  displayField="entName"  width="120" headerAlign="center" vtype="required">实体
					<input property="editor"  class="mini-buttonedit" allowinput="false" onbuttonclick="onSelectBoEnt" oncloseclick="_OnButtonEditClear"  showclose="true" style="width:100%;" minWidth="200" />
				</div>
				<div field="relateType" type="comboboxcolumn"   width="120" headerAlign="center" vtype="required">关系定义
					<input property="editor" class="mini-combobox" style="width:100%;" data=relationTypes />   
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
	var relationTypes = [{ id: "onetoone", text: "一对一" }, { id: "onetomany", text: '一对多'}];
	
	mini.parse();
	var grid=mini.get("datagrid1");
	var form = new mini.Form("#form1");
	var pkId = '${sysBoDef.id}';
	$(function(){
		initForm();
	})
	

	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/sys/bo/sysBoDef/getBoDefJson.do";
		$.post(url,{pkId:pkId},function(json){
			grid.setData(json.subEnts);
			form.setData(json);
		});
	}
	
	function addEnt(){
		grid.addRow({});
	}
	
	function removeEnt(){
		var rows=grid.getSelecteds();
		grid.removeRows(rows,true);
	}
	
	function onSelectBoEnt(e){
		var btn=e.sender;
		var supportDb=mini.get("supportDb").getValue();
		openBoEntDialog({single:true,supportDb:supportDb,callBack:function(data){
			var row=data[0];
			btn.setText(row.comment);
			btn.setValue(row.id);
			btn.doValueChanged();
		}})
	}
		
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
	    if(pkId){
	    	data.id=pkId;
	    }
	    grid.validate();
	    if(!grid.isValid()){
	    	return ;
	    }
	    var rows=grid.getData();
	    data.rows=rows;
		var config={
        	url:"${ctxPath}/sys/bo/sysBoDef/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
		
		
		_SubmitJson(config);
	}	
	</script>
</body>
</html>