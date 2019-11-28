<%-- 
    Document   : [BpmInstCtl]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/commons/edit.jsp"%>
<script src="${ctxPath }/scripts/flow/inst/bpmtask.js?version=${static_res_version}"></script>
<script src="${ctxPath }/scripts/flow/inst/opinions.js?version=${static_res_version}"></script>
</head>

<body>

<div class="mini-toolbar  topToolBar">
	<div>
	    <a class="mini-button"  onclick="onOk()">确定 </a>
	    <a class="mini-button btn-red"   onclick="CloseWindow('cancel')">关闭</a>
    </div>
</div>

<div class="mini-fit form-outer shadowBox90" style="height: 100%;">
	<c:if test="${showTab}">
		<div class="mini-tabs" activeIndex="0"  style="width:100%;height:100%;">
			<div title="填写意见" >
	</c:if>
		
		<c:if test="${skipFirst=='true' }">
			<div id="nodeUsersContainer" style="background-color: white;border-bottom: none"></div>
		
			<table  class="table-detail column_2_m" cellpadding="0" cellspacing="1" style="width:100%" >
				<c:if test="${startUser=='true' }">
				<tr>
					<th>审批人</th>
					<td>
						<div id="nodeUsers" name="nodeUsers" class="mini-user"  single="false"  style="width:80%;"   ></div> 
					</td>
				</tr>
				<tr>
					<th>审批组</th>
					<td>
						<div id="nodeGroups" name="nodeGroups" class="mini-dep"  single="false"  style="width:80%;"   ></div> 
					</td>
				</tr>
				</c:if>
				<tr>
					<th>意见</th>
					<td>
						<div style="clear:both;width:100%;margin:4px 0px;">
						<input name="opinionSelect"  id="opinionSelect" class="mini-combobox"  emptyText="常用处理意见..." style="width:80%;" minWidth="120" 
							url="${ctxPath}/bpm/core/bpmOpinionLib/getUserText.do" valueField="opId" textField="opText" 
						 	onvaluechanged="showOpinion()" ondrawcell="onDrawCells"   allowInput="false"/>
						<a class="mini-button" iconCls="icon-archives" onclick="saveOpinionLib()" >保存意见</a>
						</div>
						<textarea class="mini-textarea" id="opinion" name="opinion" style="width:80%;height:150px;" value="" emptyText="请填写审批意见！"></textarea>
					</td>
				</tr>
				<tr>
					<th>附件</th>
					<td>
						<div id="opFiles" name="opFiles" class="upload-panel"  style="width:auto;" isDown="false" isPrint="false"  readOnly="false" value='' ></div> 
					</td>
				</tr>
			</table>
		</c:if>
		<c:if test="${showTab}">
		</div>
		<div title="选择用户">
		</c:if>
		<c:if test="${selectUser=='true' }">
			<div 
				id="treegrid1" 
				class="mini-treegrid" 
				style="width:100%;height:100%;"  
				url="${ctxPath}/bpm/core/bpmNodeSet/getTaskNodes.do?actDefId=${actDefId}" 
		    	showTreeIcon="true" 
		    	treeColumn="name" 
		    	idField="activityId" 
		    	parentField="parentActivitiId" 
		    	allowAlternating="true"
		    	allowCellEdit="true" allowCellSelect="true"
		   	>
			    <div property="columns">
		   			<div type="indexcolumn" ></div>
			    	<div field="activityId" width="50">节点Id</div>
			    	<div name="name" field="name" width="200">节点名称</div>
			    	<div field="userId" displayfield="userName" width="200">选择人员
			    		<input property="editor" class="mini-user" style="width:auto;"  single="false"/>
			    	</div>
		    	</div>
			</div>
		</c:if>
		
		<c:if test="${showTab}">
			</div>
		</div>
		</c:if>
		
	</div>

	<script type="text/javascript">
        	mini.parse();
        	var tree=mini.get("treegrid1");
        	var skipFirstNode="${skipFirst}";
        	var nodeId="${nodeId}";
        	var users='${users}';
        	var startUser="${startUser}";
        	//[{nodeId:'N1',userIds'1,2'},{nodeId:'N2',userIds:'1,23'}]
        	function onOk(){
        		CloseWindow('ok');
        	}
        	
        	function setData(solId,jsonData){
        		var url="${ctxPath}/bpm/core/bpmInst/getPath.do";
        		var params={solId:solId,"jsonData":JSON.stringify(jsonData)};
        		$.post(url,params,function(nodes){
        			var data={list:nodes};
        			var html=baidu.template("nodeUsersScript",data);
        			$("#nodeUsersContainer").html(html);
        		})
        	}
        	
        	$(function(){
        		var objUser=mini.get("nodeUsers");
        		var objGroup=mini.get("nodeGroups");
        		if(!objUser) return ;
        		var ary=eval("("+users+")");
        		var userIds=[];
        		var userNames=[];
        		
        		var groupIds=[];
        		var groupNames=[];
        		
        		for(var i=0;i<ary.length;i++){
        			var o=ary[i];
        			if(o.type=='user'){
        				userIds.push(o.id);
            			userNames.push(o.name);
        			}
        			else{
        				groupIds.push(o.id);;
                		groupNames.push(o.name);
        			}
        			
        		}
        		objUser.setValue(userIds.join(","));
        		objUser.setText(userNames.join(","));
        		
        		objGroup.setValue(groupIds.join(","));
        		objGroup.setText(groupNames.join(","));
        	})
        	
        	function getData(){
        		var result={};
        		if(tree){
        			var aryData=tree.getData();
            		var rtn=[];
            		var nodeUsers="";
            		for(var i=0;i<aryData.length;i++){
            			var o=aryData[i];	
            			if(o.userId){
            				var obj={nodeId:o.activityId,userIds:o.userId};
            				rtn.push(obj);
            			}
            		}
            		if(rtn.length>0){
            			nodeUsers=JSON.stringify(rtn);
            		}
            		result.nodeUserIds=nodeUsers;
        		}
        		
        		if(skipFirstNode=="true"){
        			var opinion=mini.get("opinion").getValue();
        			var opFiles=mini.get("opFiles").getValue();
        			
        			result.opinion=opinion;
        			result.opFiles=opFiles;
        		}
        		
        		if(startUser=='true'){
        			var objUser=mini.get("nodeUsers");
        			var objGroup=mini.get("nodeGroups");
        			var user={nodeId:nodeId,userIds:objUser.getValue(),groupIds:objGroup.getValue()}	;
        			var aryUser=[];
        			aryUser.push(user);
        			result.destNodeUsers=JSON.stringify( aryUser);
        		}
        		return result;
        	}
        	
        	
        </script>
		<script type="text/html" id="nodeUsersScript">
		<div style="padding:8px;border:solid 1px #eee;">
			<div>
				<#for(var i=0;i<list.length;i++){
					var item=list[i];
				#>
					<#if(i>0){#><span style="color:#0697b5;">➜</span><#}#>
					<span><#=item.nodeText#>:<#=item.userFullnames#></span>
				<#}#>
			</div>
		</div>
		</script>
</body>
</html>