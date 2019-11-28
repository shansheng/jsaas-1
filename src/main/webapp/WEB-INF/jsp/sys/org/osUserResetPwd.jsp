<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>重设密码</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
		    <a class="mini-button"    onclick="onOk()">确定</a>
			<a class="mini-button btn-red"    onclick="onCancel()">取消</a>
		</div>
	</div>
	<div class="form-container" >
	    <form id="resetForm" >
			<input type="hidden" name="userId" value="${param['userId']}"/>
			<table id="accountTable" class="table-detail column-two" cellpadding="0" cellspacing="1">
				<tr>
					<td>
						密　　码<span class="star">*</span>
					</td>
					<td>
						<input class="mini-password" name="password" id="password" required="true" style="width:60%"/>
					</td>
				</tr>
				<tr>
					<td>
						确认密码<span class="star">*</span>
					</td>
					<td>
						<input class="mini-password" name="rePassword" id="rePassword" required="true" onvalidation="onValidateRepassword" style="width:60%"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
		 <script type="text/javascript">
		 	mini.parse();
		 	var form=new mini.Form('resetForm');
		 	//OK
		 	function onOk(){
		 		form.validate();
		        if (form.isValid() == false) {
		            return;
		        }
		        
		        var formData=$("#resetForm").serializeArray();
		       
		        _SubmitJson({
		        	url:"${ctxPath}/sys/org/osUser/modifyPassword.do",
		        	method:'POST',
		        	data:formData,
		        	success:function(result){
		        		CloseWindow('ok');		
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