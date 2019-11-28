<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>重设密码</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div style="height: 1px"></div>

	<div class="shadowBox90" style="margin: 40px auto;">

			 	<form id="editForm"  class="form-outer" style="padding:5px;;margin:0">
			 		<input type="hidden" name="accountId" value="${param['accountId']}"/>
					<table id="accountTable" class="table-detail column_1" cellpadding="0" cellspacing="1">
						<caption>修改密码</caption>
						<tr>
							<th>
								原密码
							</th>
							<td>
								<input class="mini-password" name="oldPassword" id="oldPassword" required="true" style="width:60%"/>
							</td>
						</tr>
						<tr>
							<th>
								新密码
							</th>
							<td>
								<input class="mini-password" name="password" id="password" required="true" style="width:60%"/>
							</td>
						</tr>
						<tr>
							<th>
								确认密码
							</th>
							<td>
								<input class="mini-password" name="rePassword" id="rePassword" required="true" onvalidation="onValidateRepassword" style="width:60%"/>
							</td>
						</tr>
					</table>
		</div>			
			 	</form>
	 	
			 	<div id="toolbar1" class="mini-toolbar topBtn" style="text-align: center;">
				    <a class="mini-button"    onclick="onOk()">确定</a>
				    <a class="mini-button btn-red"    onclick="onCancel()">取消</a>
				</div>

		 <script type="text/javascript">
		 	mini.parse();
		 	var form=new mini.Form('editForm');
		 	//OK
		 	function onOk(){
		 		form.validate();
		        if (form.isValid() == false) {
		            return;
		        }
		        var formData=form.getData();
		        formData.accountId="${param['accountId']}";
		        _SubmitJson({
		        	url:"${ctxPath}/sys/core/sysAccount/modifiedPassword.do",
		        	method:'POST',
		        	data:formData,
		        	success:function(result){
		        		if(result.success){
		        			CloseWindow('ok');	
		        		}
		        	}
		        });
		 	}
		 	//Cancel
		 	function onCancel(){
		 		//$("#resetForm")[0].reset();
		 		CloseWindow('cancel');
		 	}
		 	
		 	function onValidateRepassword(e) {
	    		if (e.isValid) {
	    			var pwd=mini.get('password').getValue();
	    			var rePassword=mini.get('rePassword').getValue();
	    			if (pwd!=rePassword) {
	    				e.errorText = "两次密码不一致!";
	    				e.isValid = false;
	    			}
	    		}
	    	}
		 </script>
</body>
</html>