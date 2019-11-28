<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<title>任务审批</title>
	<%@include file="/commons/edit.jsp"%>
	<script src="${ctxPath }/scripts/flow/inst/bpmtask.js?version=${static_res_version}"></script>
	<script src="${ctxPath }/scripts/flow/inst/opinions.js?version=${static_res_version}"></script>
	<style type="text/css">
		.checkusers{
			display: inline-block !important;
		}
		
		.destBox{
			display: inline-block !important;
		}
	</style>
</head>
<body>
<div class="topToolBar">
	<div>
		<a class="mini-button"    onclick="approve()">确定</a>
		<a class="mini-button"  onclick="saveOpinion()">暂存意见</a>
		<a class="mini-button btn-red"  onclick="CloseWindow();">关闭</a>
	</div>
</div>
<div class="mini-fit">
	<div class="form-container">
		<c:if test="${not empty nodeUsers}">
			<div style="padding:8px;border:solid 1px #eee;">
				<div>
					<c:forEach items="${nodeUsers }" var="item" varStatus="status">
						<c:if test="${status.index>0 }"><span style="color:#0697b5;">➜</span></c:if>
						<span>${item.nodeText }:${item.userFullnames }</span>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<form id="approveForm">
			<c:set var="allowChangePath" value="${taskConfig.allowChangePath=='true'}"/>
			<c:set var="allowNextExecutor" value="${taskConfig.allowNextExecutor=='true'}"/>
			<table class="table-detail column_2_m" cellpadding="0" cellspacing="1" style="width:100%" >
				<c:if test="${!allowChangePath}">
					<tr>
						<td>
							即将流向
						</td>
						<td id="doUserList">
						</td>
					</tr>
				</c:if>
				<c:if test="${allowChangePath}">
					<tr>
						<td>
							跳转路径
						</td>
						<td id="doDestNodeUserList">
						</td>
					</tr>
				</c:if>
				<tr>
					<td>
						意见类型
					</td>
					<td>
						<c:choose>
							<c:when test="${isMulti}">
								<div  id="jumpType" class="mini-radiobuttonlist" textField="text" valueField="id" value="${param.jumpType }"
									  data="[{id:'AGREE',text:'${opinionMap.AGREE}'},{id:'REFUSE',text:'${opinionMap.REFUSE}'},{id:'ABSTAIN',text:'${opinionMap.ABSTAIN}'}]" onvaluechanged="jumpTypeChange"></div>
							</c:when>
							<c:otherwise>
								<div id="jumpType"   class="mini-radiobuttonlist" textField="text" valueField="id" value="${param.jumpType}"
									 data="[{id:'AGREE',text:'${opinionMap.AGREE}'},{id:'REFUSE',text:'${opinionMap.REFUSE}'}]" onvaluechanged="jumpTypeChange"></div>
							</c:otherwise>
						</c:choose>

					</td>
				</tr>

				<tr>
					<td>意见</td>
					<td>
						<div style="clear:both;width:100%;margin:4px 0px;">
							<input name="opinionSelect"  id="opinionSelect" class="mini-combobox"  emptyText="常用处理意见..." style="width:40%;" minWidth="120"
								   url="${ctxPath}/bpm/core/bpmOpinionLib/getUserText.do" valueField="opId" textField="opText"
								   onvaluechanged="showOpinion()"  ondrawcell="onDrawCells" allowInput="true"/>
							<a class="mini-button" onclick="saveOpinionLib()" >保存</a>
						</div>
						<textarea class="mini-textarea" id="opinion" name="opinion" style="width:80%" value="" emptyText="请填写审批意见！"></textarea>
					</td>
				</tr>
				<tr>
					<td>附件</td>
					<td>
						<div id="opFiles" name="opFiles" class="upload-panel"  style="width:auto;" isDown="false" isPrint="false"  readOnly="false" value='' ></div>
					</td>
				</tr>
				<tr>
					<td>
						抄送人
					</td>
					<td>
						<input class="mini-hidden" id="taskId" name="taskId" value="${param.taskId}"/>
						<input id="ccUserIds" name="ccUserIds" class="mini-user"  single="false" allowInput="false" style="width:80%;"/>
					</td>
				</tr>

			</table>
		</form>
	</div>
</div>

<script id="userListTemplate"  type="text/html">
<#if(isReachEndEvent){#>
结束
<#}else{#>
<table  cellpadding="0"  style="width:100%;" id="nodeUserTable">
	<#for(var i=0;i<destNodeUserList.length;i++){
		var destNodeUser=destNodeUserList[i];
	#>
		<tr>
			<td style="text-align:left;white-space:nowrap;">
				<#if(allowPathSelect){#>
					<input type="radio" id="destNodeId_<#=i#>" name="destNodeId" value="<#=destNodeUser.nodeId#>" class="destNode"/>
				<#}#>
				<#if(allowChangePath && destNodeUser.taskNodeUser){#>
					<input id="nodeId_<#=i#>" name="nodeId" class="mini-buttonedit" value="<#=destNodeUser.nodeId#>" text="<#=destNodeUser.nodeText#>" showClose="true"  emptyText="请输入..." oncloseclick="_OnButtonEditClear" onbuttonclick="onSelectPath"  />
				<#}else{#>
					<div class="destBox" id="DIV<#=destNodeUser.nodeId#>"><#=destNodeUser.nodeText#></div>
				<#}#>
			</td>
			<td style="padding-left:5px;">
				<#if(destNodeUser.taskNodeUser){#>
					<#if(destNodeUser.taskNodeUser.nodeType=='userTask'){#>
							<input class="mini-checkboxlist checkusers" name="users" data-options="{seqId:'<#=i#>',nodeId:'<#=destNodeUser.nodeId#>'}" id="users<#=i#>"  value="<#=destNodeUser.taskNodeUser.userIds#>"
								   textField="text" valueField="id" data='<#=destNodeUser.taskNodeUser.userIdsAndText#>' valuechanged="changeDestUser('users<#=i#>')" 
							<#if(!allowNextExecutor){#>
								readonly="true" 
							<#}#>
							/>
							<#if(allowNextExecutor){#>
								<a class="mini-button" iconCls="icon-users" plain="true"  onclick="selectUsers('<#=i#>')" alt="审批者">...</a>
							<#}#>
					<#}#>
				<#}else{#>
						<table  style="width:100%">
							<#for(var key in destNodeUser.fllowNodeUserMap){
								var destMap = destNodeUser.fllowNodeUserMap[key];
							#>
								<#if(destMap.nodeType=='userTask'){#>
									<tr>
										<td>
											<#if(allowChangePath){#>
												<input id="nodeId_<#=i#>_<#=key#>" name="nodeId" class="mini-buttonedit" value="<#=destMap.nodeId#>" text="<#=destMap.nodeText#>" showClose="true"  emptyText="请输入..." oncloseclick="_OnButtonEditClear" onbuttonclick="onSelectPath"  />
											<#}else{#>
												<#=destMap.nodeText#>
											<#}#>
										</td>
										<td >
											<#if(!allowChangePath){#>
											<input type="hidden" name="nodeId" value="<#=destMap.nodeId#>" id=""/>
											<#}#>
											<input class="mini-checkboxlist checkusers"  name="users"
												   data-options="{seqId:'<#=i#>_<#=key#>',nodeId:'<#=destMap.nodeId#>'}" textField="text" valueField="id"
												   id="users<#=i#>_<#=key#>"  value="<#=destMap.userIds#>" data="<#=destMap.userJsons#>"
												   <#if(!allowNextExecutor){#>
													readonly="true"
													<#}#>/>
											<#if(allowNextExecutor){#>
												<a class="mini-button" iconCls="icon-users" plain="true" onclick="selectUsers('<#=i#>_<#=key#>')" alt="审批者">...</a>
											<#}#>
											<#if(destMap.groupIds && destMap.groupIds!=''){#>
												<input class="mini-checkboxlist checkgroups" name="groups" id="groups<#=i#>_<#=key#>"
													   text="<#=destMap.groupNames#>"
													   value="<#=destMap.groupIds#>"
													   readOnly="true" textField="text" valueField="id"
													   emptyText="请选择用户组"/>
												<#if(allowNextExecutor){#>
													<a class="mini-button" iconCls="icon-users" plain="true" onclick="selectGroups('<#=i#>_<#=key#>')" alt="选择审批组">...</a>
												<#}#>
											<#}#>
										</td>
									</tr>
								<#}else{#>
									<tr>
										<td><#=destMap.nodeText#></td>
									</tr>
								<#}#>
							<#}#>
						</table>
				<#}#>
			</td>
		</tr>
	<#}#>
</table>	
<#}#>
</script>
<script type="text/javascript">
    mini.parse();
    var form=new mini.Form('approveForm');
    var actDefId="${actDefId}";
    var taskId="${taskId}";
    var jumpType="${param.jumpType}";

    //设置左分隔符为 <!
	baidu.template.LEFT_DELIMITER='<#';
	//设置右分隔符为 <!  
	baidu.template.RIGHT_DELIMITER='#>';
    var opinionObj={opinion:"${opinion.opinion}",opFiles:'${opinion.attachment}'};

    initData();

    function initData(){
        var json=form.getData();
        $.extend( json ,opinionObj );
        form.setData(json);
    }

    var formData="{}";
    function setPostData(data){
        formData=data;
        var remark=mini.get("opinion");
        if(data.opinion){
            remark.setValue(data.opinion);
        }
        	$.ajax({
                url:__rootPath+ '/bpm/core/bpmTask/approveUserList.do',
                data:{
                	postData:mini.encode(data),
                	jumpType:jumpType,
                	taskId:taskId
                },
    			type:"POST",
                success: function (data) {
                	var list = data.list;
                	var isReachEndEvent = data.isReachEndEvent;
                	if(!list || list.length<=0)return;
                	var bt=baidu.template;
                	var allowChangePath=${allowChangePath};
        			var data={"destNodeUserList":list,"allowChangePath":allowChangePath,"allowPathSelect":${taskConfig.allowPathSelect},"allowNextExecutor":${taskConfig.allowNextExecutor},"isReachEndEvent":isReachEndEvent};
	        		var html=bt("userListTemplate",data);
	        		if(allowChangePath){
		        		$("#doDestNodeUserList").html("");
		        		$("#doDestNodeUserList").append(html);
	        		}else{
		        		$("#doUserList").html("");
		        		$("#doUserList").append(html);
	        		}
	        		mini.parse();
	        		for(var i=0;i<list.length;i++){
	        			if(list[i].taskNodeUser){
	        				mini.get("users"+i).setData(list[i].taskNodeUser.userIdsAndText);
	        			}else{
	        				for(var j=0;j<list[i].fllowNodeUserMap;j++){
	        					mini.get("users"+i+"_"+list[i].fllowNodeUserMap[j].nodeId).setData(list[i].fllowNodeUserMap[j].userIdsAndText);
	        				}
	        			}
	        		}
                }
            });
    }

    function handFormData(){
        formData.opFiles=mini.get("opFiles").getValue();
        formData.opinion=mini.get("opinion").getValue();
        formData.jumpType=mini.get("jumpType").getValue();
        formData.ccUserIds=mini.get("ccUserIds").getValue();
        formData.taskId=mini.get("taskId").getValue();
    }

    function approve(){
        form.validate();
        if(!form.isValid()){
            mini.showTips({content: "下一级节点没有审批人！",state:"danger"});
            return;
        }
		
        handUsers(formData);
        handFormData();
        var url=__rootPath+'/bpm/core/bpmTask/doNext.do';
        _SubmitJson({
            method : 'POST',
            url:url,
            data:formData,
            showMsg:false,
            success:function(text){
                mini.showMessageBox({
                    title: "成功办理待办任务！",
                    iconCls: "mini-messagebox-question",
                    buttons: ["ok"],
                    message: "关闭当前窗口",
                    callback: function (action) {
                        CloseWindow('ok');
                    }
                }); 
            },
            fail:function(result){
            	top._ShowErr({
            		content:result.message,
            		data:result.data
        		});	
            }
        });
    }

    function onSelectPath(e){
        var btn=e.sender;
        var id=btn.id.substring(7);
        var nId=btn.id.substring(7,btn.id.indexOf("_",7));
        openSolutionNode(actDefId,{single:true},function(data){
            var obj=data[0];
            var nodeId=obj.activityId;
            btn.setValue(nodeId);
            btn.setText(obj.name);
            var url=__rootPath +"/bpm/core/bpmTask/getNodeUsers.do";
            $.ajax({
                url:url,
                data:{
                	postData:mini.encode(formData),
                	jumpType:jumpType,
                	taskId:taskId,
                	nodeId:nodeId
                },
    			type:"POST",
                success: function (result) {
                	var json=eval("(" + result.userJsons+")");
                    var ctl=mini.get("users"+id);
                    var destNodeId=$("#destNodeId_"+nId);
                    ctl.setData(json);
                    ctl.setValue(result.userIds);
                    ctl.nodeId=nodeId;
                    destNodeId.val(nodeId);
                }
            });

        })
    }
    
    function jumpTypeChange(e){
    	jumpType = e.value;
    	setPostData(formData);
    }

    function saveOpinion(){
        _SubmitJson({
            method : 'POST',
            url:__rootPath+'/bpm/core/bpmTask/saveOpinion.do',
            data:form.getData(),
            success:function(text){
                CloseWindow('opinion');
            }
        });
    }


</script>
</body>
</html>