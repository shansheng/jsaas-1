<%-- 
    Document   : 流程定义管理列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>流程定义BPMN文件上传处理</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="UploadFile()" plain="true">上传</a>
			<c:if test="${not empty bpmDef.defId}">
				<a class="mini-button"  onclick="UploadFile(true)" plain="true">上传并发布</a>
			</c:if>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container">
			<form id="uploadForm" method="post" action="${ctxPath}/bpm/core/bpmDef/uploadBpmnFile.do" enctype="multipart/form-data" class=" form-outer">
				<table class="table-detail column-four" style="width:100%;" >
					<c:if test="${not empty msg }">
					<tr>
						<td colspan="2">
							<span style="color:red">${msg}</span>
						</td>
					</tr>
					</c:if>
					<tr>
						<td>分　类 </td>
						<td>
								<input id="treeId" name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BPM_DEF"
								multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="true" value="${bpmDef.treeId}"
								showFolderCheckBox="false"  expandOnLoad="true" showClose="true" oncloseclick="onClearTree"
								popupWidth="300" style="width:80%" popupHeight="180"/>
							 <input class="mini-hidden" name="defId" value="${bpmDef.defId}"/>
							 <input class="mini-hidden" id="isDeployNew" name="isDeployNew" />
						</td>
					</tr>
					<tr>
						<td>流程标题</td>
						<td>
							<input class="mini-textbox" name="subject"  required="true" style="width:80%" value="${bpmDef.subject}"/>
						</td>
					</tr>
					<tr>
						<td>流程Key</td>
						<td>
							<input class="mini-textbox" name="key" vtype="isEnglishAndNumber" required="true" style="width:80%" <c:if test="${not empty bpmDef.defId}">allowInput="false"</c:if> value="${bpmDef.key}"/>
						</td>
					</tr>
					<tr>
						<td>
							流程描述
						</td>
						<td>
							<textarea class="mini-textarea" name="descp" style="width:80%">${bpmDef.descp}</textarea>
						</td>
					</tr>
					<!-- tr>
						<th>
							转为化设计器格式
						</th>
						<td>
							<input class="mini-checkbox" name="convertToDesign" value="true"/>
						</td>
					</tr>
					-->
					<tr>
						<td>上传BPMN文件</td>
						<td>
							<input id="file" type="file" name="bpmnFile"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
    <script type="text/javascript">
   		mini.parse();
    	var success='${success}';
    	if(success=='true'){
    		mini.confirm("成功上传流程定义！", "确定关闭？",
    	            function (action) {
    	                if (action == "ok") {
    	                   CloseWindow('ok');
    	                } 
    	            }
    	      );
    	}
    	
    	function onClearTree(e){
			var obj = e.sender;
            obj.setText("");
            obj.setValue("");
		}
    	
    	var form=new mini.Form('uploadForm');
    	
    	function UploadFile(isDeployNew){
    		form.validate();
    		if(!form.isValid()){
    			return;
    		}
    		if(isDeployNew){//发布新版本
    			mini.get('isDeployNew').setValue(true);
    		}else{
    			mini.get('isDeployNew').setValue(false);
    		}
    		var file=document.getElementById('file');
    		if(file.value==''){
    			alert('请选择BPMN文件！');
    			return;
    		}
    		//上传文件
    		$("#uploadForm").submit();
    	}
    </script>
</body>
</html>