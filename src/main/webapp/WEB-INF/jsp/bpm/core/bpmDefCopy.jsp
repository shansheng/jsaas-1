<%-- 
    Document   : 业务表单视图编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>业务表单视图编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar" >
	    <div>
			<a class="mini-button" plain="true" onclick="newCopy">确定</a>
<!-- 	    <a class="mini-button btn-red" iconCls="icon-close" plain="true" onclick="onCancel">关闭</a> -->
		</div>
	</div>
	<div class="form-container" >
	
	<form id="form1" method="post" >
		<table class="table-detail column-four" cellspacing="1" cellpadding="0" border="2">
			<tr>
				<td >源名称 </td>
				<td >
					<input class="mini-hidden" value="${bpmDef.defId }" name="defId" />
					${bpmDef.subject }
				</td>
				<td >源别名 </td>
				<td >
					${bpmDef.key }
				</td>
			</tr>
			<tr>
				<td >
					<span class="starBox">
						新名称<span class="star">*</span>
					</span>
				</td>
				<td>
					<input class="mini-textbox" value="" name="subject" required="true" />
				</td>
				<td >
					<span class="starBox">
						新别名<span class="star">*</span>
					</span>
				</td>
				<td>
					<input class="mini-textbox" value="" name="key" required="true"/>
				</td>
			</tr>
			<tr>
				<td>发布</td>
				<td colspan="3">
					<div   name="deploy" class="mini-checkbox" readOnly="false" text="发布" ></div>
				</td>
			</tr>
		</table>
			
	</form>
	</div>
	
	<rx:formScript formId="form1" baseUrl="bpm/form/bpmFormView" entityName="com.redxun.bpm.form.entity.BpmFormView" />
	<script type="text/javascript">
		$(function(){
			
		});
		
		function newCopy(){
			var url=__rootPath +"/bpm/core/bpmDef/copyDef.do";
			_SaveJson("form1",url,function(result){
				if(result.success){
					CloseWindow("ok")
				}
			})
		}
	</script>
</body>
</html>