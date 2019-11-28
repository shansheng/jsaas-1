
<%-- 
    Document   : [考勤计算设置]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤计算设置]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="type" name="type" class="mini-hidden" value="${type}" />
				<div class="mini-toolbar">
						<a class="mini-button"  plain="true" onclick="save">保存</a>
				    	<a class="mini-button"   plain="true" onclick="addRow">添加</a>
						<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="removeRow">删除</a>
					</div>
					<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: auto;" allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false"
					multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<c:if test="${type == 1}">
								<div field="name" displayField="lable" width="120" headerAlign="center" >项目名称
								<input 
								name="summary"
								property="editor"
								class="mini-combobox" 
								data="[{id:'S11',text:'应出勤时数'},{id:'S12',text:'实际出勤时数'},{id:'S21',text:'旷工次数'},
								{id:'S22',text:'旷工时数'},{id:'S31',text:'迟到次数'},{id:'S32',text:'迟到分钟'},
								{id:'S41',text:'早退次数'},{id:'S42',text:'早退分钟'}]"
								style="width:100%;" minWidth="120"
								/></div>
							</c:if>
							<c:if test="${type == 2}">
								<div field="name" displayField="lable"  width="120" headerAlign="center" >项目名称
								<input 
								name="detail"
								property="editor"
								class="mini-combobox" 
								data="[{id:'S11',text:'应出勤时数'},{id:'S12',text:'实际出勤时数'},{id:'S21',text:'旷工次数'},
								{id:'S22',text:'旷工时数'},{id:'S31',text:'迟到次数'},{id:'S32',text:'迟到分钟'},
								{id:'S41',text:'早退次数'},{id:'S42',text:'早退分钟'}]"
								style="width:100%;" minWidth="120"
								/></div>
							</c:if>
						</div>
					</div>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsAttenceCalculateSet"
		entityName="com.redxun.oa.ats.entity.AtsAttenceCalculateSet" />
	
	<script type="text/javascript">
	mini.parse();
	
	var grid = mini.get("datagrid1");
	
	$(function(){
		if("${type}"=="1"){
			grid.setData(mini.decode("${atsAttenceCalculateSet.summary}"));
		}
		if("${type}"=="2"){
			var data = mini.decode("${atsAttenceCalculateSet.detail}");
			grid.setData(data);
		}
	})
	
	
	function removeRow(){
		var selecteds=grid.getSelecteds();
		grid.removeRows(selecteds);
	}
	
	function addRow(){
		var row = {};
		grid.addRow(row);
	}
	
	function setValue(json,type){
		var obj = {};
		if(type=="1"){
			obj.summary = [];
			for(var i=0;i<json.length;i++){
				var data = {};
				data.name = "'"+json[i].name+"'";
				data.lable = "'"+json[i].lable+"'";
				obj.summary[i] = data;
			}
		}else if(type=="2"){
			obj.detail = [];
			for(var i=0;i<json.length;i++){
				var data = {};
				data.name = "'"+json[i].name+"'";
				data.lable = "'"+json[i].lable+"'";
				obj.detail[i] = data;
			}
		}
		obj.type = type;
		return obj;
	}
	
	function save(){
		var form = new mini.Form("#form1");            
		var type = form.getData().type;      //获取表单多个控件的数据
		var data = grid.getData(); 
		var json = setValue(data,type);//序列化成JSON
		var config = {
				url:"${ctxPath}/oa/ats/atsAttenceCalculateSet/save.do",
				method:"POST",
				data: json,
				postJson:true,
				success: function(result){
					CloseWindow("ok");
				}
		}
		_SubmitJson(config);
	}

	</script>
</body>
</html>