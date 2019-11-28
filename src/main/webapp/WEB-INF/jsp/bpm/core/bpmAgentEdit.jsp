<%-- 
    Document   : 流程代理设置编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>流程代理设置编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="${bpmAgent.agentId}" />
<div class="mini-fit">
	<div class="form-container">
				<form id="form1" method="post">
						<input id="pkId" name="agentId" class="mini-hidden" value="${bpmAgent.agentId}" />
						<table class="table-detail column-four" cellspacing="1" cellpadding="0">
							<caption>流程代理设置基本信息</caption>
							<tr>
								<td>代理简述 <span class="star">*</span></td>
								<td>
									<input name="subject" value="${bpmAgent.subject}" class="mini-textbox" vtype="maxLength:100" style="width: 90%" required="true" emptyText="请输入代理简述" />
								</td>
								<td>代理类型 <span class="star">*</span>
								</td>
								<td>
									<input id="type" name="type" value="${bpmAgent.type}" class="mini-radiobuttonlist" vtype="maxLength:20"
										data="[{id:'ALL',text:'全部'},{id:'PART',text:'部分'}]" onvaluechanged="typeChange" allowInput="false"
									style="width: 90%" required="true" emptyText="请输入代理类型" />
								</td>
							</tr>
							<tr>
								<td>代  理  给 <span class="star">*</span></td>
								<td>
									<input name="toUserId" value="${bpmAgent.toUserId}" class="mini-buttonedit icon-user-button"
									onbuttonclick="selectToUser" text="<cf:userLabel userId='${bpmAgent.toUserId}' />"
									vtype="maxLength:64" style="width: 90%" required="true" emptyText="请输入代理人" />
								</td>
								<td>状　　态 <span class="star">*</span></td>
								<td>
									<ui:radioStatus name="status" value="${bpmAgent.status}" emptyText="请输入状态" required="true"></ui:radioStatus>
								</td>
							</tr>
							<tr>
								<td>开始时间 <span class="star">*</span></td>
								<td>
									<input id="startTime" name="startTime" value="${bpmAgent.startTime}" class="mini-datepicker" onvaluechanged="onChangeValue" format="yyyy-MM-dd HH:mm:ss" timeFormat="H:mm:ss" showTime="true" vtype="maxLength:19" style="width: 90%" required="true" emptyText="请输入开始时间" />
								</td>
								<td>结束时间 <span class="star">*</span></td>
								<td>
									<input id="endTime" name="endTime" value="${bpmAgent.endTime}" class="mini-datepicker" onvaluechanged="onChangeValue" format="yyyy-MM-dd HH:mm:ss" timeFormat="H:mm:ss" showTime="true" vtype="maxLength:19" style="width: 90%" required="true" emptyText="请输入结束时间" />
								</td>
							</tr>
							<tr>
								<td>描　　述 </td>
								<td colspan="3"><textarea name="descp" class="mini-textarea" vtype="maxLength:300" style="width: 90%">${bpmAgent.descp}</textarea></td>
							</tr>
						</table>


					<div id="solDiv" style="display:none">
						<div class="form-inner">
							<div class="mini-toolbar" style="border-bottom: none">
								<table style="width:100%">
									<tr>
										<td style="width:100%">
											<a class="mini-button"   plain="true" onclick="addSols">添加流程方案</a>
											<a class="mini-button btn-red"  plain="true" onclick="delSols">删除</a>
										</td>
									</tr>
								</table>
							</div>
							<div id="solGrid" class="mini-datagrid" style="width:100%;height:300px"idField="asId"
								allowCellEdit="true" allowCellSelect="true" multiSelect="true"
								<c:if test="${not empty bpmAgent.agentId }">
								url="${ctxPath}/bpm/core/bpmAgent/getAgentSol.do?agentId=${bpmAgent.agentId}"
								</c:if>
								editNextOnEnterKey="true" editNextRowCell="true" showPager="false">
								<div property="columns">
									<div type="indexcolumn" width="20"></div>
									<div type="checkcolumn" width="50"></div>
									<div field="solName" width="200" headerAlign="center" >解决方案名称</div>

								</div>
							</div>
						</div>
					</div>
				</form>

		<rx:formScript formId="form1" baseUrl="bpm/core/bpmAgent" entityName="com.redxun.bpm.core.entity.BpmAgent" />
	</div>
</div>
	<script type="text/javascript">
		var agentId='${bpmAgent.agentId}';
		var solGrid=mini.get('solGrid');
		$(function(){
			if(agentId!=''){
				solGrid.load();
			}
			typeChange();
		});
		function typeChange(){
			var val=mini.get('type').getValue();
			if(val=='PART'){
				$("#solDiv").css("display","");
			}else{
				$("#solDiv").css("display","none");
			}
		}
		
		function onChangeValue(e){
			var field = e.sender.id;
			var startTime = mini.get("startTime");
			var endTime = mini.get("endTime");
			
			if(field == "startTime"){
				if(endTime.getValue() && ( e.value > endTime.getValue())) {
					alert("开始时间大于结束时间");
					startTime.setValue(null);
				}	
			}
			if(field == "endTime"){
				if(startTime.getValue() && (startTime.getValue() > e.value)) {
					alert("结束时间小于开始时间");
					endTime.setValue(null);
				}
			}
		}
		
		//添加解决方案
		function addSols(){
			var totals=solGrid.getTotalCount();
			_BpmSolutionDialog(false,function(sols){
				for(var i=0;i<sols.length;i++){
					var find=false;
					for(var j=0;j<totals-1;j++){
						var row=solGrid.getRow(j);
						if(sols[i].solId==row.solId){
							find=true;
							break;
						}
					}
					if(!find){
						solGrid.addRow({
							solId:sols[i].solId,
							solName:sols[i].name
						})
					}
				}
			});
		}
		
		//处理表单的数据
		function handleFormData(formData){
			var val=mini.get('type').getValue();
			if(val=='PART'){
				formData.push({
					name:'sols',
					value:mini.encode(solGrid.getData())
				});
			}
			
			return {
				isValid:true,
				formData:formData
			};
		}
		
		function selectToUser(e){
			var buttonEdit=e.sender;
			_UserDlg(true,function(user){
				buttonEdit.setValue(user.userId);
				buttonEdit.setText(user.fullname);
				buttonEdit.doValueChanged();
			});
		}
		
		function delSols(e){
			var sels=solGrid.getSelecteds();
			if(sels.length==0){
				return;
			}
			var asIds=[];
			for(var i=0;i<sels.length;i++){
				if(sels[i].asId){
					asIds.push(sels[i].asId);
				}
			}
			if(asIds.length>0){
				_SubmitJson({
					url:__rootPath+'/bpm/core/bpmAgent/delSols.do',
					data:{
						asIds:asIds.join(',')
					},
					method:'POST',
					success:function(text){
					}
				});
			}
			solGrid.removeRows(sels);
		};
		
		
		function selfSaveData() {
	        form.validate();
	        if (!form.isValid()) {
	            return;
	        }
	        
	        var formData=$("#form1").serializeArray();
	        //处理扩展控件的名称
	        var extJson=_GetExtJsons("form1");
	        if(extJson.type_name=="部分" && extJson.SUB_solGrid.length<=0){
	        	alert("流程方案未添加数据!");
	        	return;
	        }
	        for(var key in extJson){
	        	formData.push({name:key,value:extJson[key]});
	        }
	        //加上租用Id
	        if(tenantId!=''){
		        formData.push({
		        	name:'tenantId',
		        	value:tenantId
		        });
	        }
	       
	        var result=handleFormData(formData);
	        if(!result.isValid) return;
	        formData=result.formData;
	        
	        var config={
	        	url: __rootPath +"/bpm/core/bpmAgent/save.do",
	        	method:'POST',
	        	data:formData,
	        	success:function(result){
	        		//如果存在自定义的函数，则回调
	        		if(isExitsFunction('successCallback')){
	        			successCallback.call(this,result);
	        			return;	
	        		}
	        		
	        		CloseWindow('ok');
	        	}
	        }
	        
	        if(result && result["postJson"]){
	        	config.postJson=true;
	        }
	        
	        _SubmitJson(config);
	     }

	</script>
</body>
</html>