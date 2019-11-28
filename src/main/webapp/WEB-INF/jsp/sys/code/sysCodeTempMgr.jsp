<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>生成配置</title>
	<%@include file="/commons/list.jsp"%>
	<link href="${ctxPath}/styles/form.css?version=${static_res_version}" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.mini-layout-border>#center{
	 		background: transparent;
		}
		.mini-tree .mini-grid-viewport{
			background: #fff;
		}
	</style>
</head>
<body>
	<div id="orgLayout" class="mini-layout" style="width:100%;height:100%;">
		    <div showHeader="false" showCollapseButton="false" iconCls="icon-group" region="center">
		         
              	<div class="titleBar mini-toolbar" >
			         <ul>
						<li>
							<a class="mini-button"   onclick="generate()">生成</a>
						</li>
						<li>
							<a class="mini-button" iconCls="icon-addfolder"  onclick="download()">下载</a>
						</li>
						<li class="clearfix"></li>
					</ul>
		     	</div>
		     	<div class="form-container">	
						<form id="form1" method="post">
								<table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
							            <tr>
										<th>表单名称：</th>
										<td>
												<input name="bodefId" required="true" width="100%" class="mini-buttonedit" onbuttonclick="selectFormSolution" />
										</td>
										<th>模块名称：</th>
										<td>
												<input name="moduleName" required="true" class="mini-textbox" />
										</td>
										<th>包名：</th>
										<td>
												<input name="packageName" required="true" class="mini-textbox" />
										</td>
										</tr>
							            <tr>
										<th>代码模板列表：</th>
										<td colspan="5">
											<!-- <div class="mini-toolbar">
										    	<a class="mini-button"   plain="true" onclick="add">添加</a>
												<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove">删除</a>
											</div> -->
											<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 400px;"
												url="${ctxPath}/sys/code/sysCodeTemp/listData.do" idField="id" allowCellEdit="true" allowCellSelect="true" showPager="false"
												multiSelect="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
												<div property="columns">
													<div type="checkcolumn" width="20"></div>
													<div field="name"  sortField="NAME_"  width="120" headerAlign="center" allowSort="true">名称</div>
													<div field="alias"  sortField="ALIAS_"  width="120" headerAlign="center" allowSort="true">别名</div>
													<div field="override"  width="120" headerAlign="center" displayField="overrideText">是否覆盖
													<input property="editor" class="mini-combobox" style="width:100%;"  minWidth="120" 
													textField="overrideText" valueField="overrideId" data="[{overrideId:'true',overrideText:'是'},{overrideId:'false',overrideText:'否'}]" /></div>
												</div>
											</div>
										</td>
										</tr>
								</table>
						</form>
				</div>	
		    </div><!-- end of the center region  -->		    
    </div>
	<script type="text/javascript">
		mini.parse();
		var setTree = mini.get("setTree");
		var grid = mini.get("datagrid1");
		var form = new mini.Form("#form1");
		grid.load();
		
		function selectFormSolution(e){
			var btn=e.sender;
			_OpenWindow({
				title:'表单方案选择',
				height:450,
				width:800,
				url:__rootPath +'/sys/customform/sysCustomFormSetting/dialog.do',
				ondestroy:function(action){
					if(action!='ok'){
						return;
					}
					var win=this.getIFrameEl().contentWindow;
					var data=win.getData();
					if(!data.bodefId){
						top._ShowTips({
		            		msg:"请在表单方案中设置业务对象"
		            	});
						return;
					}
					if(data!=null){
						btn.setText(data.name);
						btn.setValue(data.bodefId);
					}
				}
			});
		}
		
		/* function add(){
			_OpenWindow({
				title:"代码模板列表",
				height:400,
				width:800,
				url:__rootPath+'/sys/code/sysCodeTemp/dialog.do',
				onload:function(){
				},
				ondestroy:function(action){
					if(action!='ok') return;
					var win=this.getIFrameEl().contentWindow;
					var data=win.getData();
					var row = grid.findRow(function(row){
					    if(row.pkId == data.pkId) return true;
					});
					if(!row){
						grid.addRow(data);
					}
				}
			});
		}
		
		
		
		function remove(){
			var selecteds=grid.getSelecteds();
			grid.removeRows(selecteds);
		} */
		
		//在系统中生成文件代码
		function generate(){
			form.validate();
		    if (!form.isValid()) {
		        return;
		    }	        
		    var formData=form.getData();
		    var ary = grid.getSelecteds();
		    formData.template = mini.encode(ary);
			var config={
			    	url: __rootPath+'/sys/code/sysCodeTemp/generate.do',
			    	method:'POST',
			    	data:formData,
			    	showMsg:false,
			    	success:function(result){
			    		var mesg=result.message?result.message:'成功生成!';
		        		//显示操作信息
		        		top._ShowTips({
		            		msg:mesg
		            	});
			    	}
			    }
				config.postJson=true;
			    _SubmitJson(config);
		}
		
		//生成文件并打成压缩包下载到本地
		function download(){
			form.validate();
		    if (!form.isValid()) {
		        return;
		    }	        
		    var formData=form.getData();
		    var ary = grid.getSelecteds();
		    formData.template = mini.encode(ary);
			var config={
			   	url: __rootPath+'/sys/code/sysCodeTemp/download.do',
			   	method:'POST',
			   	data:formData,
			   	showMsg:false,
			    success:function(result){
			    	var mesg=result.message?result.message:'成功下载!';
	        		//显示操作信息
	        		top._ShowTips({
	            		msg:mesg
	            	});
			   	}
			}
			config.postJson=true;
			_SubmitJson(config);
		}
	</script>
</body>
</html>