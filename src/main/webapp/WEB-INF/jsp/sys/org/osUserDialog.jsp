<%
	//用户选择框
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>用户选择框</title>
    <%@include file="/commons/list.jsp" %>
    <style type="text/css">
    	#toolbarBody >*{
    		float: left;
    	}
    	
    	#toolbarBody::after{
    		content: '';
    		display: block;
    		clear: both;
    	}
    	
    	#center{
    		background: transparent;
    	}
    </style>
    
    
</head>
<body>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		<div
				region="south"
				showSplit="false"
				showHeader="false"
				height="46"
				showSplitIcon="false"
				style="width:100%"
		>
			<div class="southBtn">
				<a class="mini-button"    onclick="onOk()">确定</a>
				<a class="mini-button btn-red"    onclick="onCancel()">取消</a>
			</div>
		</div>
		<div
		 	title="用户组" 
		 	region="west" 
		 	width="200"
		 	showSplitIcon="true"
	    	showCollapseButton="false"
	    	showProxy="false"
		 	bodyStyle="overflow: auto;"
	 	>
			 <div class="treeToolBar">
				<c:if test="${param['showTenant']=='true'}">
							<input
								id="tenantCombo"
								class="mini-combobox"
								style="width:100%;"
								allowInput="true"
								onvaluechanged="onTenantChange"
								url="${ctxPath}/sys/org/getTenants.do"
								textField="name"
								valueField="id"
							/>
				</c:if>
				<c:if test="${param['showDimId']==true}">
				<input
					id="dimCombo"
					class="mini-combobox"
					style="width:100%;"
					onvaluechanged="onDimChange"
					url="${ctxPath}/sys/org/osDimension/jsonAll.do?containContact=yes&tenantId=<c:out value="${param.tenantId}" />"
					textField="name"
					valueField="dimId"
					value="${adminDim.dimId}"
					text="${adminDim.name}"
				/>
				</c:if>
			 </div>
			 <div class="mini-fit">
				<div
					id="groupTree"
					class="mini-tree"
					url="${ctxPath}/sys/org/sysOrg/listByDimId.do?initParentId=<c:out value="${param.groupId}" />&tenantId=<c:out value="${param.tenantId}" />&dimId=${adminDim.dimId}"
					style="width:100%;"
					showTreeIcon="true"
					resultAsTree="false"
					textField="name"
					idField="groupId"
					parentField="parentId"
					onbeforeload="onBeforeGridTreeLoad"
					onnodeclick="groupNodeClick"
				>
				</div>
			 </div>
		 </div>
		  <c:if test="${param['single']==false}">
				<div region="east" title="选中用户列表" width="250" showHeader="false" showCollapseButton="false">
					<div class="treeToolBar">
						<a class="mini-button btn-red"  onclick="removeSelectedUser">移除</a>
						<a class="mini-button btn-red"  onclick="clearUser">清空所有</a>
					</div>
					<div class="mini-fit">
						<div 
							id="selectedUserGrid" 
							class="mini-datagrid" 
							style="width: 100%; height: 100%;" 
							allowResize="false" url="" 
							idField="userId" 
							multiSelect="true" 
							showColumnsMenu="true" 
							allowAlternating="true" 
							showPager="false" 
							onrowdblclick="removeUser(e)"
						>
							<div property="columns">
								<div type="checkcolumn" width="30"></div>
								<div field="fullname" width="120"  headerAlign="center" allowSort="true">姓名</div>
							</div>
						</div>
					</div>
				</div>
		 </c:if>


		 
		 <div region="center" title="用户列表"   showHeader="false" showCollapseButton="false" style=" mini-toolbar-bottom">
				<div class="mini-toolbar">
					<div class="searchBox">
						<form id="searchForm" class="search-form" >						
							<ul>
								<li class="liAuto">
									<input class="mini-hidden" id="groupId" name="groupId"/>
									<input class="mini-textbox" id="fullname" name="fullname" emptyText="请输入姓名" onenter="onSearch"/>
								</li>
								<li class="liAuto">
									<input class="mini-textbox"  id="email" name="email" emptyText="请输入邮箱" onenter="onSearch"/>
									<input type="hidden" name="crsf_token" class="mini-hidden"  value="${sessionScope.crsf_token}"/>
								</li>
								<li class="liBtn">
									<a class="mini-button " onclick="onSearch">搜索</a>
									<a class="mini-button  btn-red" onclick="onClear">清空</a>
									<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
										<em>展开</em>
										<i class="unfoldIcon"></i>
									</span>
								</li>
							</ul>
							<div id="moreBox">
								<ul>
									<li class="liAuto">
										<input class="mini-textbox"  id="userNo" name="userNo" emptyText="请输入用户编号" onenter="onSearch"/>
									</li>
								</ul>
							</div>
						</form>
					</div>
					<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
						<i class="icon-sc-lower"></i>
					</span>
		        </div>
				<div class="mini-fit ">
					<div 
						id="userGrid" 
						class="mini-datagrid"  
						style="width: 100%; height: 100%;" 
						allowResize="false" 
						idField="userId"  
						onbeforeload="userLoaded"
						<c:choose>
							<c:when test="${param['single']==true}">
								multiSelect="false"
							</c:when>
							<c:otherwise>
								multiSelect="true" onselect="selectUser(e)"
							</c:otherwise>
						</c:choose>
						 showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
						<div property="columns"  class="form-outer">
							<div type="checkcolumn" width="25"></div>
							<div field="sex" width="30"></div>
							<div field="fullname" width="120" sortField="FULLNAME_" headerAlign="center" allowSort="true">姓名</div>
							<div field="userNo" width="120"   headerAlign="center" allowSort="false">编号</div>
							<div field="email" width="120" sortField="EMAIL_" headerAlign="center" allowSort="true">邮件</div>
						</div>
					</div>
				</div>
			</div><!-- end of the region center -->

	</div>


	<script type="text/javascript">
		mini.parse();
		var tenantId="<c:out value='${param.tenantId}' />";
		var userGrid=mini.get("#userGrid");
		var groupTree=mini.get("#groupTree");
		var dimCombo=mini.get("#dimCombo");
		var searchForm=mini.get("#searchForm");
		var selectedUserGrid=mini.get("selectedUserGrid");
		var url;
		
		function setConfig(config){
			url = "${ctxPath}/sys/org/osUser/search.do?";
			if(config.initDim){
				url += "initDim="+config.initDim;
			}
			if(config.initRankLevel){
				url += "initRankLevel="+config.initRankLevel;
			}
			if(config.orgconfig){
				url += "&orgconfig="+config.orgconfig;
				if(config.orgconfig=="selOrg"){
					url += "&orgId="+config.orgid;
				}
			}
			if(config.refconfig){
				if(config.refconfig=="specific"){
					url += "&instId="+config.instid;
				}
				if(config.refconfig=="level"){
					url += "&instId="+config.instlevel;
				}
			}
			userGrid.setUrl(url);
			userGrid.load();
		}
		
		var selectedRecord;
		
		function onCancel(){
			CloseWindow('cancel');
		}
		
		function onOk(){
			CloseWindow('ok');
		}
		<c:if test="${param['showDimId']==true}">
		loadGroupRootNode();
		</c:if>
		//当前维度一样时才切换
		function loadGroupRootNode(){
			var gt=mini.get('groupTree');
			var nodes=gt.getRootNode().children;
			for(var i=0;i<nodes.length;i++){
				gt.loadNode(nodes[0]);
			}
		}
		
		function onBeforeGridTreeLoad(e){
	        var node = e.node;      //当前节点
	        var params = e.params;  //参数对象
			
	        //可以传递自定义的属性
	        params.parentId = node.groupId; //后台：request对象获取"myField"
		}
		

		userGrid.on("drawcell", function (e) {
	            var record = e.record,
		        field = e.field,
		        value = e.value;
	          
	            if(field=='sex'){
	            	if(value=='Male'){
	            		e.cellHtml='<img src="${ctxPath}/styles/images/male.png" alt="男性">';
	            	}else{
	            		e.cellHtml='<img src="${ctxPath}/styles/images/female.png" alt="女性">';
	            	}
	            }
		});
		
		
		var isSingle="<c:out value='${param.single}' />";
		
		function onClear(){
			$("#searchForm")[0].reset();
			userGrid.setUrl(url);
			userGrid.load();
		}
		
		function removeSelectedUser(){
			var rows=selectedUserGrid.getSelecteds();
			selectedUserGrid.removeRows(rows,false);
		}
		
		function clearUser(){
			selectedUserGrid.clearRows();
		}
		
		function userLoaded(e){
			userGrid.deselectAll(false);
		}
		
		function selectUser(e){
			var record=e.record;
			var user=selectedUserGrid.findRow(function(row){
			    if(row.userId == record.userId){
			    	return true;
			    }
			});
			if(user) return;
				
			selectedUserGrid.addRow($.clone(record));
		}
		
		function removeUser(e){
			var row=e.row;
			selectedUserGrid.removeRow(row);
		}
		
		//搜索
		function onSearch(){
			var formData=$("#searchForm").serializeArray();
			var data=jQuery.param(formData);
			userGrid.setUrl(url+"&"+data);
			userGrid.load();
		}
		
		function onTenantChange(e){
			tenantId = e.value;
			dimCombo.load("${ctxPath}/sys/org/osDimension/jsonAll.do?containContact=yes&tenantId="+e.value);
			var dimId=dimCombo.getValue();
			groupTree.setUrl("${ctxPath}/sys/org/sysOrg/listByDimId.do?tenantId="+tenantId+"&dimId="+dimId);
			groupTree.load();
			loadGroupRootNode();
		}
		
		//维度变化时，更改组织架构
		function onDimChange(e){
			var dimId=dimCombo.getValue();
			groupTree.setUrl("${ctxPath}/sys/org/sysOrg/listByDimId.do?tenantId="+tenantId+"&dimId="+dimId);
			groupTree.load();
			loadGroupRootNode();
		}
		
		//返回选择用户信息
		function getUsers(){
			var users=null;
			if(isSingle=='false')
				users=selectedUserGrid.getData();
			else
				users=userGrid.getSelecteds();
			return users;
		}
		
		/**
		*初始化用户。
		*[{userId:"",fullname:""},{userId:"",fullname:""}]
		*/
		function init(users){
			selectedUserGrid.setData(users);
		}
		
		function groupNodeClick(e){
			//var dimValue=dimCombo.getValue();
			var node=e.node;
			var url="${ctxPath}/sys/org/osUser/search.do?tenantId="+tenantId+"&groupId="+node.groupId;
			$("#groupId").val(node.groupId);	
			userGrid.setUrl(url);
			userGrid.load();
		}
	</script>
</body>
</html>