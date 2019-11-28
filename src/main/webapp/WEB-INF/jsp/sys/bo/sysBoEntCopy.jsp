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
		</div>

	</div>
	<div class="mini-fit">
		<div class="form-container" >
			<form id="form1" method="post" class="form-outer2">
				<table class="table-detail column-two" cellspacing="1" cellpadding="0" border="2">
					<tr>
						<td >源名称 </td>
						<td >
							<input class="mini-hidden" value="${pkId }" name="id" />
							${ent.name }【${ent.comment }】
						</td>
					</tr>
					<tr>
						<td >
							<span class="starBox">
								新备注<span class="star">*</span>
							</span>
						</td>
						<td>
							<input class="mini-textbox" value="" name="comment" required="true" />
						</td>

					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			
		});
		
		function newCopy(){
			var url=__rootPath +"/sys/bo/sysBoEnt/copyNew.do";
			_SaveJson("form1",url,function(result){
				if(result.success){
					CloseWindow("ok")
				}
				
			})
		}
	</script>
</body>
</html>