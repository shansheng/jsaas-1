
<%-- 
    Document   : [SYS_WORD_TEMPLATE【模板表】]编辑页
    Created on : 2018-05-16 11:29:19
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>WORD模板编辑</title>
<%@include file="/commons/edit.jsp"%>
<script type="text/javascript" src="${ctxPath}/scripts/common/vue.min.js"></script>
<style type="text/css">
.subTableSql{
	display: block;
}
	.clearBtn{
		width: 60px;
		height: 30px;
		border: 0;
		cursor:pointer;
		border-radius: 3px;
		background-color:#2d93fb;
		color: white;
	}
.rx-font{
	height: 34px;
	display: inline-block;
	line-height: 34px;
	padding: 0 10px;
	background: #409EFF;
	color: #fff;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	cursor: pointer;
}
.clearBtn:hover,
.rx-font:hover{
	background-color:#66b1ff;
}
</style>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button" plain="true" onclick="onSave(true)">保存</a>
	   	 	<a class="mini-button" plain="true" onclick="onSave(false)">下一步</a>
		</div>
	</div>
	<div class="mini-fit">
	<div class="form-container" id="datagrid1">
		<form id="form1" method="post">
			<input id="pkId" name="id" class="mini-hidden" value="${sysWordTemplate.id}" />
			<table class="table-detail column-two" cellspacing="1" cellpadding="0">
				<tr>
					<td>
						<span class="starBox">名称<span class="star">*</span></span>
                    </td>
					<td><input name="name" class="mini-textbox"  value="" required="true" /></td>
				</tr>
				<tr>
					<td>模板名称</td>
					<td><input name="templateName" class="mini-textbox"  vtype="isEnglish"  required="true" /></td>
				</tr>
				<tr>
					<td>描述</td>
					<td ><input name="description" class="mini-textbox"   /></td>
				</tr>
				<tr>
					<td>数据源</td>
					<td >
						<input id="dsAlias" name="dsAlias" class="mini-combobox" style="width: 100%;"  showClose="true"
							onbuttonclick="onDatasource" oncloseclick="onCloseClick(e)" />
					</td>
				</tr>
				<tr>
					<td>数据源(SQL/自定义)</td>
					<td>
						<input name="type" id="type"   required="true"
							class="mini-combobox" style="width: 100%;"
							onvaluechanged="fromChanged" valueField="id"
							textField="text" value="" data="[{id:'sql',text:'SQL'},{id:'boDef',text:'Bo定义'}]" />
					</td>
				</tr>
				<tr id="selfSQL_row" style="display: none">
					<td>SQL</td>
					<td >
						<div class="form-toolBox">
							<a class="rx-font"
							   @click="addRow()">添加</a>
						</div>
						<table spacing="1" cellspacing="0" cellpadding="0" id="sqlTable" class="table-view" >
							<col style="width: 20%;min-width: 200px;" />
							<col style="width: 60%" />
							<col style="width: 20%;min-width: 200px;"/>
								<thead>
								<tr>
									<th >表类型</th>
									<th>SQL语句设置</th>
									<th >操作</th>
								</tr>
								</thead>
								<tbody id="tbodySql">
									<tr>
										<td style="text-align: center">main</td>

										<td>
											<textarea id="main" name="textareaSql" validate="{required:true}"cols="60" rows="4" 
													style="width:100%; resize:none;border-color:#ddd;" required="true"
												   	v-model="data.main"
											></textarea>
										</td>
										<td style="text-align: center"></td>
									</tr>
									<tr class="tbodySqltr" v-for="(item, idx)  in data.sub" >
										<td style="text-align: center">
											<input  v-model="item.name" style="height: 30px;"/>
										</td>
										<td>
											<div class="form-toolBox">
												关系类型:
												<select v-model="item.type" style="width:80px;">
													<option value="onetoone">一对一</option>
													<option value="onetomany">一对多</option>
												</select>
											</div>
											<textarea class="subTableSql"
													  cols="60" rows="4"
													  style="width: 100%;border-color:#ddd ;
													  resize:none;" v-model="item.sql"
											></textarea>
										</td>
										<td style="text-align: center">
											<input class="clearBtn" type="button"
													value="删除"
													@click="deleteRow(idx)"
											/>
										</td>
									</tr>
								</tbody>
						</table>
					</td>
				</tr>

				<tr id="selfBoDialog_row" style="display: none">
					<td>请选择BO定义</td>
					<td >
						<input name="boDefId" required="true" class="mini-buttonedit" id="boDefId" textName="boDefName" style="width: 100%;"
							showClose="true" onbuttonclick="onSelBo" oncloseclick="onCloseClick(e)" /> 
					</td>
				</tr>
			
			</table>
		</form>
	</div>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		
		var vm=new Vue({
			  el: '#selfSQL_row',
			  data: {
				data:{
					main:"",
					sub:[]
				}  
			  },
			  methods:{
				  deleteRow:function(i){
					  this.data.sub.splice(i,1);
				  },
				  addRow:function(){
					  this.data.sub.push({name:"",type:"onetomany",sql:"select * from "});
				  }
			  }
		})
		
		
		var form = new mini.Form("#form1");
		var pkId = '${sysWordTemplate.id}';
		
		 
		$(function() {
			initForm();
		})
			
		function goToOffice(pkId) {
			var wh= getWindowSize();
			_OpenWindow({
				url: __rootPath + "/sys/core/sysWordTemplate/office.do?pkId=" + pkId,
				title: "word模板编辑",
				width: wh.width, 
				height: wh.height,
	            ondestroy: function(action) {
	                CloseWindow('ok');
	            }
	    	});
		}
		
		function initForm() {
			if (!pkId) return;
			var url=__rootPath + "/sys/core/sysWordTemplate/getJson.do";
			$.post(url,{ids : pkId},function(json){
				
				init(json);
				form.setData(json);
				fromChanged();
			})
		}
		
		function init(json){
			if(!json.setting) return ;
			
			if(json.type == "sql"){
				var jsonSet = JSON.parse(json.setting);
				vm.data=jsonSet;
			} 
		}

		//选择数据源
		function onDatasource(e) {
			var btnEdit = e.sender;
			openDatasourceDialog(function(data){
				btnEdit.setValue(data.alias);
				btnEdit.setText(data.name);
			})
		}
		
		//查询bo列表，并选择表
		function onSelBo(e) {
			var btnEdit = this;
			openBoDefDialog("db",function(action,data){
				btnEdit.setValue(data.id);
				btnEdit.setText(data.name);
				btnEdit.doValueChanged();
			},false)
		}

		/*数据来源点击事件处理*/
		function fromChanged() {
			var val = mini.get('type').getValue();
			var trSql=$("#selfSQL_row");
			var trBo=$("#selfBoDialog_row");
			if (val == 'sql') {
				trSql.show();
				trBo.hide();
			} 
			else {
				trSql.hide();
				trBo.show();
			}
		}

		//清除控件值
		function onCloseClick(e) {
			var btn = e.sender;
			btn.setText('');
			btn.setValue('');
		}
		
		function onSave(onlySave){
			form.validate();
			if (!form.isValid()) return;
			var data = form.getData();
			if(data.type == "sql"){
				data.setting = JSON.stringify(vm.data);
			} 
			
			var config = {
				url : __rootPath +"/sys/core/sysWordTemplate/save.do",
				method : 'POST',
				postJson : true,
				data : data,
				success : function(result) {
					var resultData = result.data;
					if(!onlySave){
						goToOffice(resultData.pkId);
					}
				}
			}
			_SubmitJson(config);
		}
	</script>
</body>
</html>