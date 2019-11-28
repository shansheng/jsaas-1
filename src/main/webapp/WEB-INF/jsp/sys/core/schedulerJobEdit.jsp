<%-- 
    Document   : 定时器编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>定时器编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  plain="true" onclick="save">保存</a>
		</div>
	</div>

	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<table class="table-detail column-four" cellspacing="1"
					cellpadding="0">
					<caption>定时器任务基本信息</caption>
					<tr>
						<td>
							任务名称<span class=star>*</span>
						</td>
						<td>
							
							<input required="true" 
								name="name" 
								emptyText="请输入名称"
								value="" 
								class="mini-textbox" 
								vtype="maxLength:255"
								style="width: 80%"
								<c:if test="${not empty param.name}">
									allowInput="false"
								</c:if>
								/>
							
							</td>
					</tr>
					<tr>
						<td>
							类 　　名<span class=star>*</span>
						</td>
						<td><input required="true" name="className" value=""
							class="mini-textbox" vtype="maxLength:255" style="width: 80%"
							emptyText="输入类全路径" /></td>
					</tr>
					<tr>
						<td>任务描述</td>
						<td><textarea name="description" class="mini-textarea"
								emptyText="任务描述" style="width: 80%;"></textarea></td>
					</tr>
				</table>



				<div class="form-toolBox">
					<a class="mini-button"
					  plain="true" onclick="addRow">新增</a> <a
					class="mini-button btn-red"  plain="true"
					onclick="delRowGrid('ruleGrid')">删除</a> <span class="separator"></span> <a
					class="mini-button"  plain="true"
					onclick="upRowGrid('ruleGrid')">向上</a> <a class="mini-button"
					 plain="true" onclick="downRowGrid('ruleGrid')">向下</a></td>
				</div>

				<div id="ruleGrid" class="mini-datagrid"
					style="width: 100%; height: 300px;" height="auto"
					showPager="false" allowCellEdit="true" allowCellSelect="true"
					allowAlternating="true">
					<div property="columns">
						<div type="indexcolumn" width="40">序号</div>
						<div field="type" width="50" headerAlign="center">
							类型 <input property="editor" class="mini-combobox"
								allowInput="true"
								data="[{id:'Boolean',text:'Boolean'},{id:'String',text:'String'},{id:'Integer',text:'Integer'},{id:'Long',text:'Long'},{id:'Float',text:'Float'}]"
								style="width: 100%;" minWidth="120" />
						</div>
						<div field="name" width="120" headerAlign="center">
							参数名 <input property="editor" class="mini-textbox"
								style="width: 100%" required="true" />
						</div>
						<div field="value" width="120" headerAlign="center">
							参数值<input property="editor" class="mini-textbox"
								style="width: 100%" required="true" />
						</div>
					</div>
				</div>

			</div>
		</form>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get('ruleGrid');
		var name="${param.name}";
		var form=new mini.Form("#form1");
		
		$(function(){
			init();
		})
		
		function init(){
			var url=__rootPath +  "/sys/core/scheduler/jobInfo?name="+ name;
			$.get(url,function(data){
				form.setData(data);
				var grid=mini.get("ruleGrid");
				grid.setData(data.paramList);
			})
		}
		

		var beforeCallBack = function(formData) {
			var data = grid.getData();
			var json = JSON.stringify(data);
			var obj = {
				name : "parameterJson",
				value : json
			};
			//表示是更新。
			if(name){
				formData.push({name:"update",value:"update"});
			}
			formData.push(obj);
		};

		function save() {
			var url = __rootPath + "/sys/core/scheduler/addJob.do";
			_SaveData("form1", url, function(result) {
				CloseWindow('ok');
			}, beforeCallBack);
		}

		//添加行
		function addRow() {
			grid.addRow({
				type : "String",
				name : "",
				value : ""
			});
		}
		 

		function onCancel() {
			CloseWindow('cancel');
		}
	</script>
</body>
</html>