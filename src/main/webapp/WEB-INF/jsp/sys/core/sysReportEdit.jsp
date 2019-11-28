<%-- 
    Document   :  报表编辑页
    Created on : 2018-2-27, 10:11:48
 * @author cmc
 * @Email keitch@redxun.cn
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<title>报表编辑</title>
<%@include file="/commons/edit.jsp"%>
	<style>
		.mini-htmlfile .mini-buttonedit-button{
			background: #fff;
			color: #333;
			border-left: 1px solid #eee;
			margin: 0;
			line-height: 26px;
		}
	</style>
</head>
<body>
	
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="uploadTemplate()" plain="true">保存</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container"  id="formInfo">
		<form id="uploadForm" method="post" action="${ctxPath}/sys/core/sysReport/uploadTemplate.do" enctype="multipart/form-data" class="form-outer2">
			<input id="pkId" name="repId" class="mini-hidden" value="${sysReport.repId}" />
			<input name="treeId" id="treeId"  class="mini-hidden"  value="${sysReport.treeId}"/>
			<input name="paramConfig" id="paramConfig"  class="mini-hidden"  value='${sysReport.paramConfig}'/>
			<table class="table-detail column-four" cellspacing="1" cellpadding="0">
				<tr>
					<td width="20%">
						数  据  源<span class="star">*</span>
					</td>　
						<td width="80%">
							<input style="width: 90%;"
						   id="btnEdit_ds"
						   class="mini-buttonedit"
						   onbuttonclick="onButtonEdit_ds"
						   required="true" name="sourceId" value="${sysReport.dsAlias}" text="${sysReport.dsAlias}" showClose="true" oncloseclick="onCloseClick(e)" /></td>
				</tr>
				<tr>
					<td>
						标　　题 <span class="star">*</span>
					</td>
					<td><input name="subject" value="${sysReport.subject}"
							   class="mini-textbox" vtype="maxLength:128" style="width: 90%" required="true" emptyText="请输入标题" /></td>
				</tr>
				<tr>
					<td>
						标识key <span class="star">*</span>
					</td>
					<td><input id="key" name="key" value="${sysReport.key}" class="mini-textbox" vtype="maxLength:128" required="true" style="width: 90%" /></td>
				</tr>

				<tr>
					<td><a class="mini-button"  onclick="showTip()" plain="true">上传模板帮助</a></td>
					<td>
           				 <input class="mini-htmlfile" id="bpmnFile" name="bpmnFile" style="width:90%" />
					</td>
				</tr>
				<tr>
					<td>
						参数配置
					</td>
					<td>
						<div class="form-toolBox">
							<a class="mini-button"   onclick="addParameter()" plain="true">新增参数</a>
							<a class="mini-button btn-red" onclick="removeParameter()" plain="true">删除参数</a>
							<a class="mini-button"  onclick="configWidget()" plain="true">配置控件</a>
						</div>
					<div id="datagrid1" class="mini-datagrid" style="height: 250px;" allowCellEdit="true" allowCellSelect="true"
								showPager="false">
								<div property="columns">
									<div type="indexcolumn"></div>
									<div field="fieldLabel" width="120" headerAlign="center" allowSort="false">
										参数名 <input property="editor" class="mini-textbox" style="width: 100%;" />
									</div>
									<div field="fieldName" width="120" headerAlign="center" allowSort="false">
										参数key <input property="editor" class="mini-textbox" style="width: 100%;" />
									</div>
									<div field="fc" displayField="fcName" width="120" headerAlign="center" allowSort="false">
										输入控件 <input property="editor" class="mini-combobox" valueField="fc" textField="fcName" style="width: 70%;" data="fieldControls" />
									</div>
								</div>
							</div>
						</td>
				</tr>
			</table>
		</form>
	</div>
	</div>
	<script type="text/javascript">
		addBody();
		mini.parse();
		var paramConfig=mini.get("paramConfig");
		var bpmnFile=mini.get("bpmnFile");
		var grid=mini.get("datagrid1");
		
		
		var form = new mini.Form('uploadForm');
    	var fieldControls=[{
			fc:'mini-textbox',
			fcName:'文本框'
		},{
			fc:'mini-datepicker',
			fcName:'日期'
		},{
			fc:'mini-combobox',
			fcName:'下拉选项'
		},
		{
			fc:'mini-dialog',
			fcName:'自定义对话框'
		}];
    	
    	
    	$(function(){
    		if(${!empty sysReport}){
    			bpmnFile.setText("${sysReport.filePath}");
    			grid.setData(mini.decode('${sysReport.paramConfig}'));
    		}
    	});
    	
		/* 上传帮助  */
		function showTip() {
			mini.showTips({
				content : "如果报表模板中不含有图片,只需上传.jasper或者.jrxml模板文件,如果报表模板中含有另外的图片,则需将图片和.jasper文件一起打包成zip格式上传。",
				state : "info",
				x : "center",
				y : "bottom",
				timeout : 10000
			});
		}

		/* 保存   */
		function uploadTemplate() {
			form.validate();
			if (!form.isValid()) {
				return;
			}
			var file=bpmnFile.getValue();//var file = document.getElementById('file');
			if (file== ''&& ${empty sysReport.repId}) {
				mini.showTips({
					content : "上传文件为空。",
					state : "danger",
					x : "center",
					y : "top",
					timeout : 3000
				});
				return;
			}
			
			paramConfig.setValue(mini.encode(grid.getData()));
			
			//上传文件
			$('#uploadForm').ajaxSubmit(function(result){
				if(result.success){
					CloseWindow('ok');
				}
				}); 
		}

		//选择数据源
		function onButtonEdit_ds(e) {
			var btnEdit = this;
			mini.open({
				url : "${ctxPath}/sys/core/sysDatasource/dialog.do",
				title : "选择列表",
				width : 650,
				height : 380,
				ondestroy : function(action) {
					if (action == "ok") {
						var iframe = this.getIFrameEl();
						var data = iframe.contentWindow.GetData();
						data = mini.clone(data); //必须
						if (data) {
							btnEdit.setValue(data.alias);
							btnEdit.setText(data.name);
						}
					}
				}
			});
		}
		
		function editInit(){
			var pkId = '${sysReport.repId}';
			_OpenWindow({
				url : __rootPath + "/sys/core/sysReport/designerDlg.do?pkId=" + pkId,
				title : "编辑报表初始化参数",
				width : 900,
				height : 730,
				ondestroy : function(action) {
					if (action == 'ok') {
						grid.reload();
					}
				}
			});
		}
		
		 //清除控件值
		 function onCloseClick(e){
		 	var btn=e.sender;
			btn.setText('');
			btn.setValue('');
		 }
		 
		 //为参数grid添加行
		 function addParameter(){
			 grid.addRow({fc:'mini-textbox',fcName:'文本框'});
		 }
		 
		 //删除grid中的行
		 function removeParameter(){
			 var row=grid.getSelected();
			 grid.removeRow(row,true);
		 }
		 
		 function configWidget(){
			 var row=grid.getSelected();
			 if(row!=null){
				 _OpenWindow({
						title:'模板控件配置',
						url:__rootPath+'/scripts/miniQuery/'+ row.fc+'.jsp',
						width:800,
						height:500, 
						onload:function(){
							var win=this.getIFrameEl().contentWindow;
							var data=mini.clone(row);
							win.setData(data,data.fieldLabel==undefined?null:data.fieldLabel);
						}, 
						ondestroy:function(action){
							if(action!='ok') return;
							var win=this.getIFrameEl().contentWindow;
							var data=win.getData();
							grid.updateRow(row,data);
						}
					}); 
			 }else{
				 mini.showTips({
			            content: "<b>提醒</b> <br/>请先选中配置的控件",
			            state: 'danger',
			            x: 'center',
			            y: 'center',
			            timeout: 3000
			        });
			 }
		 }
	</script>
</body>
</html>