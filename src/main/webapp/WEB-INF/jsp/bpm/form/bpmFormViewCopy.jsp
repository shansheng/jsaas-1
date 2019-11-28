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
<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/ueditor-fd-config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/ueditor-fd.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/ueditor-form.js"> </script>
<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>
<!-- 引入表单控件 -->
<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/form-design/design-plugin.js"></script>
</head>
<body>
	<div class="topToolBar">
	      <div>
			  <a class="mini-button"  plain="true" onclick="newCopy">确定</a>
			  <!-- 	<a class="mini-button btn-red" plain="true" onclick="onCancel">关闭</a> -->
		  </div>
	</div>
	<div class="mini-fit">
		<div class="form-container">
			<form id="form1" method="post" class="form-outer2">
				<table class="table-detail column-four" cellspacing="1" cellpadding="0" >
					<tr>
						<td>源名称 </td>
						<td >
							<input class="mini-hidden" value="${view.viewId}" name="viewId" />
							${view.name }
						</td>
						<td >源别名 </td>
						<td >
							${view.key }
						</td>


					</tr>
					<tr>
						<td >
							新名称<span class="star">*</span>
						</td>
						<td>
							<input class="mini-textbox" value="" name="name" required="true" />
						</td>
						<th >
							新别名<span class="star">*</span>
						</th>
						<td>
							<input class="mini-textbox" value="" name="key" required="true"/>
						</td>
					</tr>
				</table>
			</form>
			<rx:formScript formId="form1" baseUrl="bpm/form/bpmFormView" entityName="com.redxun.bpm.form.entity.BpmFormView" />
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			
		});
		
		function newCopy(){
			var url=__rootPath +"/bpm/form/bpmFormView/copyNew.do";
			_SaveJson("form1",url,function(result){
				if(result.success){
					CloseWindow("ok")
				}
				
			})
		}
	</script>
</body>
</html>