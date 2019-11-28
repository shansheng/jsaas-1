<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>权限批量设置</title>
	<%@include file="/commons/list.jsp"%>
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
		    <div 
		    	title="权限转移管理" 
		    	region="west" 
		    	width="170"  
		    	showSplitIcon="true"
		    	showCollapseButton="false"
		    	showProxy="false"
	    	>
		        <div class="mini-fit">
			         <ul 
			         	id="dimTree" 
			         	class="mini-tree" 
			         	url="${ctxPath}/sys/transset/sysTransferSetting/jsonAll.do" 
			         	style="width:100%; height:100%;" 
						imgPath="${ctxPath}/upload/icons/"
						showTreeIcon="true" 
						textField="name" 
						idField="id" 
						resultAsTree="false"  
		                onnodeclick="dimNodeClick" 
	                >        
		            </ul>
	            </div>
		    </div>
        
		    <div showHeader="false" showCollapseButton="false" iconCls="icon-group" region="center">
              	<div class="titleBar mini-toolbar" >
			         <ul>
			         	<li>
			         		权限转移人：
			         		<input id="userIdEditA" name="userId" value="${osUser.userId }" text="${osUser.fullname }" required="true" 
							class="mini-buttonedit" emptyText="请输入..."  allowInput="false" onbuttonclick="onSelectUser('userIdEditA')"/>
			         	</li>
						<li>
							选择到：
							<input id="userIdEditB" name="userId" value="" text="" required="true" 
							class="mini-buttonedit" emptyText="请输入..."  allowInput="false" onbuttonclick="onSelectUser('userIdEditB')"/>
						</li>
						<li>
							<a class="mini-button"  onclick="onOk();">确认</a>
						</li>
						<li>
							<a class="mini-button"  plain="true" onclick="back()">返回</a>
						</li>
						<li class="clearfix"></li>
					</ul>
		     	</div>
		         <div class="mini-fit rx-grid-fit form-outer5" >
		         	<div id="groupGrid" class="mini-tabs" style="width:100%;height:100%;border:none"></div>
		        </div>
		    </div><!-- end of the center region  -->		    
    </div>
	<script type="text/javascript">
		mini.parse();
		var dimTree=mini.get('#dimTree');
		var groupGrid = mini.get("#groupGrid");
		var tenantId='${tenantId}';
		var flag = true;
		
		function onSelectUser(name){
			_TenantUserDlg(tenantId,true,function(user){
				var userIdEdit=mini.get(name);
				if(user){
					userIdEdit.setValue(user.userId);
					userIdEdit.setText(user.fullname);
					flag = false;
				}
			});
		}
		
		function back(){
			history.back(-1);
		}
		
		function onOk(){
			var authorId = mini.get("userIdEditA").value;
			if(validataObj(authorId)){
				mini.alert("请选择权限转移人");
				return;
			}
			var targetAuthorId = mini.get("userIdEditB").value;
			if(validataObj(targetAuthorId)){
				mini.alert("请选择目标人");
				return;
			}
			
			var row = dimTree.getSelected();
			var tab = groupGrid.getActiveTab();
			if(validataObj(tab)){
				mini.alert("请选择要转移的权限类型");
				return;
			}
			var relTypeId=tab.name;
        	var grid=mini.get('#groupGrid_'+relTypeId);
        	var ids = grid.getSelecteds();
        	if(validataAry(ids)){
				mini.alert("请选择要转移的权限");
				return;
			}
			_SubmitJson({
	        	url:__rootPath+"/sys/transset/sysTransferSetting/excuteUpdateSql.do",
	        	method:'POST',
	        	data:{id:row.pkId,authorId:authorId,targetPersonId:targetAuthorId,selectedItem:mini.encode(ids)},
	        	success: function(text) {
	                grid.load();
	            }
	         });
			
		}
		
		
		function validataObj(obj){
			if(!obj || obj == ""){
				return true;
			}
			return false;
		}
		
		function validataAry(ary){
			if(!ary || ary.length<=0){
				return true;
			}
			return false;
		}
		
		function dimNodeClick(e){
			var node=e.node;
			var id = node.pkId;
			var authorId = mini.get("userIdEditA").value;
			//动态加载查询列表
			$.getJSON(__rootPath+'/sys/transset/sysTransferSetting/excuteSelectSql.do?id='+id+'&authorId='+authorId,function(json){
				if(json.columns.length<=1){
					alert("此权限转移人没有可转移的权限");
					return;
				}
				var tabs = groupGrid.getTabs();
				for(var i=0;i<tabs.length;i++){
					var tab = tabs[i];
					if(json.id==tab.name){
						if(!flag){
							groupGrid.removeTab(tab.name);
							break;
						}
			        	var relTypeId=tab.name;
			        	var grid=mini.get('#groupGrid_'+relTypeId);
			        	grid.load();
						groupGrid.activeTab(tab);
						return;
					}
				}
				var tab=groupGrid.addTab({
					title:json.name,
					name:json.id,
					iconCls:'icon-user',
					showCloseButton:true
				});
				var el=groupGrid.getTabBodyEl(tab);
				var grid=new mini.DataGrid();
				grid.set({
					id:"groupGrid_"+json.id,
					style:"width:100%;height:100%;",
					idField:"id_",
					url:__rootPath+'/sys/transset/sysTransferSetting/excuteSelectSqlData.do?id='+id+'&authorId='+authorId,
					multiSelect:true,
					allowAlternating:true,
					columns:json.columns
				});
				
				grid.reload();
				grid.render(el);
				groupGrid.activeTab(groupGrid.getTab(tabs.length-1));
			});
		}
		
		function onShowingNodeMenu(e){
			var node=dimTree.getSelectedNode();
			//为默认
			if(node && node.isSystem=='YES'){
				  e.cancel = true;
				  //阻止浏览器缺省右键菜单
				  e.htmlEvent.preventDefault();
			      return;
			}
		}
		
		
	</script>
</body>
</html>