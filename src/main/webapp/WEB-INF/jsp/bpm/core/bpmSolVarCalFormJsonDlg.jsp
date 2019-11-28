<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI"%>
<html>
<head>
<title>业务流程解决方案的人员计算来自表单值选择</title>
<%@include file="/commons/edit.jsp" %>
</head>
<body>
	<div class="topToolBar">
			<div class="mini-toolbar topBtn mini-toolbar-bottom">
						<a class="mini-button"  plain="true" onclick="ok">确定</a>
						<a class="mini-button btn-red"  plain="true" onclick="CloseWindow()">关闭</a>
			</div>
		</div>
		<div class="form-outer shadowBox90">
			<form id="vform" >
				<table class="table-detail column_2" cellpadding="0" cellspacing="1" style="width:100%">
					<tr>
						<td colspan="2">
							说明 ：从表单中获得字段作为审批人员计算的来源值。
						</td>
					</tr>
					<tr>
						<td>类型</td>
						<td>
							<div id="varType" onvaluechanged="changeType" class="mini-radiobuttonlist" name="varType"  
								data="[{id:'user',text:'用户'},{id:'org',text:'用户组'}]" required="true" value="user"></div>					
						</td>
					</tr>
					<tr>
						<td>表单选择</td>
						<td>
							<input id="boDefId" class="mini-combobox" name="boDefId" url="${ctxPath}/bpm/core/bpmSolution/boDefFields.do?solId=${param.solId}" onvaluechanged="onBoChanged"
							valueField="id" textField="name" popupHeight="150" style="width:90%;margin-top: 2px;" required="true"/>
						</td>
					</tr>
					<tr>
						<td>表单字段</td>
						<td>
							<input id="varKey" class="mini-combobox" name="varKey"
							valueField="key" textField="name" popupHeight="150" style="width:90%;margin-top: 2px;" required="true"/>
						</td>
					</tr>
					
					<tr id="trRelationType" style="display:none;">
						<td>关系类型</td>
						<td>
							<input id="relTypeKey" class="mini-combobox" name="relTypeKey" url="${ctxPath}/sys/org/osRelType/getGroupUserRelations.do?dimId=1" 
							  required="true"  valueField="key" textField="name" style="width:70%"/>
							<div id="chkUseRelation" name="useRelation" class="mini-checkbox" 
								checked="true" readOnly="false" text="使用关系" onvaluechanged="changeUserRelation"></div>
						</td>
					</tr>
					
				</table>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		var form=new mini.Form('vform');
		function ok(){
			form.validate();
			if(form.isValid()){
				CloseWindow('ok');
			}else{
				alert('请选择表单值!');
				return;
			}
		}
		
		/* $(function(){
			initRelationType();
		})
		
		function initRelationType(){
			var tr=$("#trRelationType");
			var varType=mini.get("varType").getValue();
			varType="org"?tr.show():tr.hide();
		} */
		
		function onBoChanged(){
			var boDefId = mini.get("boDefId");
			var varKey = mini.get("varKey");
			var id = boDefId.getValue();

            var url = "${ctxPath}/bpm/core/bpmSolution/modelFields.do?boDefId="+id;
            varKey.setUrl(url);
		}
		
		function setData(config){
			form.setData(JSON.parse(decodeURI(config)));
			onBoChanged();
			var varType=mini.get("varType");
			var varTypeValue=varType.getValue();

			if(varTypeValue == 'org'){
				$("#trRelationType").show();
			}else if(varTypeValue == 'user'){
				varType.setValue('user');
				$("#trRelationType").hide();
			}else{
				varType.setValue('user');
			 	$("#trRelationType").hide();
			}
		}
		
		function changeType(e){
			var varType = mini.get("varType").getValue();
			if(varType == "user"){
				$("#trRelationType").hide();
			}else{
				$("#trRelationType").show();
			} 
			
		}
		
		function getConfigJson(){
			var varType=mini.get("varType").getValue();
			var boDefId = mini.get("boDefId").getValue();
			var formKey = mini.get("boDefId").getText();
			var varTypeText=(varType=='user')?'用户':'用户组';
			var varKey=mini.get('varKey').getValue();
			var data=mini.get('varKey').getData();
			var useRelation=mini.get('chkUseRelation').getValue();
			var relTypeKey=mini.get('relTypeKey').getValue();
			
			var varText=null;
			for(var i=0;i<data.length;i++){
				if(varKey==data[i].key){
					varText=data[i].name;
					break;
				}
			}
			var configDescp=varTypeText+"值来自表单字段["+varText+"]("+formKey+")";
			
			return{
				config:{
					varType:varType,
					boDefId:boDefId,
					varKey:varKey,
					useRelation:useRelation,
					relTypeKey:relTypeKey
				},
				configDescp:configDescp
			};
		}
	</script>
</body>
</html>