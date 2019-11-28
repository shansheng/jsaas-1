<%--
	//部门初始化数据对话框
	//
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>部门初始化数据对话框</title>
	<%@include file="/commons/list.jsp"%>
	<style>
		.mini-layout-region{
			background: transparent;
		}
		#west{
			background: #fff;
		}
	</style>
</head>
<body>

	<div id="layout1" class="mini-layout" style="width:100%;height:100%;" >
		 <div region="south" showSplit="false" showHeader="false" height="40" showSplitIcon="false"  
			style="width:100%" bodyStyle="border:0;text-align:center;padding-top:5px;">
			     <a class="mini-button"     onclick="onOk()">确定</a>
				 <a class="mini-button btn-red"    onclick="onCancel()">取消</a>
		 </div>
		 
		 <c:if test="${param['single']=='false'}">
			 <div region="east" title="选中用户组列表"   width="250" showHeader="false" showCollapseButton="false">
					<div class="mini-toolbar mini-toolbar-one" >
						<a class="mini-button btn-red" iconCls="icon-remove" onclick="removeSelectedGroup">移除</a>
						<a class="mini-button btn-red" iconCls="icon-trash"  onclick="clearGroup">清空</a>
					</div>
					<div class="mini-fit form-outer4">
						<div id="selectedGroupGrid" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" url="" 
								idField="groupId" multiSelect="true" showColumnsMenu="true" allowAlternating="true" showPager="false" onrowdblclick="removeGroup(e)">
								<div property="columns">
									<div type="checkcolumn" width="30"></div>
									<div field="name" name="name" displayfield="name" width="120" headerAlign="center" >名称</div>
								</div>
						</div>
					</div>
			</div>
		 </c:if>
		 
		 
		 <div 
		 	region="center" 
		 	style="padding:0;margin:0;" 
	 		showCollapseButton="false">
	 		<c:if test="${param['showTenant']=='true'}">
		 		<div style="padding:5px" >
		 			租户选择:
		 			<input class="mini-combobox" 
		 				textField="name" 
		 				valueField="id"  
		 				value="" 
		 				showNullItem="true"
		 				url="${ctxPath}/sys/org/getTenants.do"
		 				onvaluechanged="changeTenant"
		 				/>    
		 		</div>
	 		</c:if>
			<div class="mini-fit">
				<div 
					id="groupGrid"
					class="mini-treegrid" 
					style="width:100%;height:100%;"     
			        showTreeIcon="true"  
			        onbeforeload="onBeforeGridTreeLoad"
			        resultAsTree="false" 
			        treeColumn="name" 
			        idField="groupId" 
			        parentField="parentId" 
			        allowResize="false" 
			        onlyCheckSelection="true"
			        allowRowSelect="true" 
			        allowUnselect="true"   
			        onbeforeload="userLoaded"
			        allowAlternating="true"
					<c:choose>
						<c:when test="${param['single']=='true'}">
							multiSelect="false"
						</c:when>
						<c:otherwise>
							multiSelect="true"
							onselect="selectGroup(e)"
						</c:otherwise>
					</c:choose>
				 >
					<div property="columns">
						<div type="checkcolumn" width="40"></div>
						<div field="name" name="name" displayfield="name" width="180" headerAlign="center" allowSort="true">名称</div>
						<div field="key" width="130" headerAlign="center" allowSort="true">标识Key</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		var groupGrid=mini.get("groupGrid");
		var config='${param['config']}';
		var tenantId='${param['tenantId']}'
		var selectedGroupGrid=mini.get("selectedGroupGrid");
		var url=__rootPath + "/sys/org/sysOrg/getInitData.do?config="+config;
		if(tenantId){
			url+="&tenantId=" +tenantId;
		}
		
		var dialogUrl = encodeURI( url);
		
		groupGrid.setUrl(dialogUrl);
		
		function onBeforeGridTreeLoad(e){
			var tree = e.sender;    //树控件
	        var node = e.node;      //当前节点
	        var params = e.params;  //参数对象
	        //可以传递自定义的属性
	        params.parentId = node.groupId; 
		}
		
		function removeSelectedGroup(){
			var rows=selectedGroupGrid.getSelecteds();
			selectedGroupGrid.removeRows(rows,true);
		}
		
		function clearGroup(){
			selectedGroupGrid.clearRows();
		}

		 //返回选择用户信息
		function getGroups(){			
			if(selectedGroupGrid){
				var groups=selectedGroupGrid.getData();
				return groups;	
			}
			else{
				var groups=groupGrid.getSelecteds();
				return groups;	
			}
		}
		 
		function selectGroup(e){
			var row=e.record;
			var groupId=row.groupId;
			var groups=selectedGroupGrid.getData();
			for(var i=0;i<groups.length;i++){
				var group=groups[i];
				if(groupId==group.groupId){
					return;
				}
			}
			selectedGroupGrid.addRow({groupId:groupId,name:row.name})
		}
		 
		function init(groups){
			selectedGroupGrid.setData(groups);
		}
		
		function changeTenant(e){
			var tenantId=e.value;
			if(!tenantId) return;
			var url=__rootPath + "/sys/org/sysOrg/getInitData.do?config="+config+"&tenantId=" +tenantId;
			var dialogUrl = encodeURI( url);
			groupGrid.setUrl(dialogUrl);
		}
		
		function onOk(){
			var groups=getGroups();
			if(groups.length==0){
				alert("请选择组织!")
				return;
			}
			CloseWindow('ok');
		}
	
		function onCancel(){
			CloseWindow('cancel');
		}
	</script>
</body>
</html>