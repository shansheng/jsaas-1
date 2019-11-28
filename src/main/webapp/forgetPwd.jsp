<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSaaS私有云租用应用平台--忘记密码</title>  
        <%@include file="/commons/edit.jsp"%>
        <link rel="stylesheet" type="text/css" href="${ctxPath}/styles/login-h01.css"/>
        <script src="${ctxPath}/scripts/anonymus.js" type="text/javascript"></script>
		<script src="${ctxPath}/scripts/common/sha256.js" type="text/javascript"></script>
        <style>
        	html,body{
        		background: #f8f8f8;
        	}
        	h2{
        		margin-top:10px;
        	}
        	.title{
        		width:100%;
        		text-align: center;
        		line-height: 40px;
        		height: 40px;
        	}
        	
        	td.button{
        		text-align: center !important;
        		line-height: 40px;
        		height: 40px;
        	}
        	td,tr,table,th{
        		border:0!important;
        		padding:0!important;
        		color:#333!important;
        	}
        	.mini-textbox{
        		margin:6px 0;
        		width:100%!important;
        	}
        	.Myinput .mini-textbox{
        		width:80%!important;
        	}
        </style>
    </head>
    <body>
    	<canvas id="canvas" width="1500" height="1000"></canvas> 
       <div class="registerBox">
            <form id="regForm" method="post">
                	<div style="padding: 4px 54px;">
                			<div class="title">
                				<h2>忘记密码</h2>
                			</div>
                		    <table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
                		    	<tr>
	                                <th>邮箱/账号：</th>
	                                <td>   
	                                    <input id="emailOrAccount" name="emailOrAccount" class="mini-textbox" emptyText="请输入邮箱/账号" required="true" style="width:80%"/>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th>新密码：</th>
	                                <td > 
	                                    <input id="newPwd" name="newPwd" class="mini-password" required="true" style="width:80%"/>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th>确认密码：</th>
	                                <td >                        
	                                    <input id="newPwdRe" name="newPwdRe"  required="true"  class="mini-password" style="width:80%"/>
	                                </td>
	                            </tr>
	                          
	                            <tr>
	                            	<th>验证码</th>
	                            	<td class="Myinput">
	                            		<input name="validCode" class="mini-textbox" id="validCode" width="300"  required="true" />   
	                            		<a id="codeText" class="mini-button" onclick="loadValiCode()">获取验证码</a>              
	                            	</td>
	                            </tr>
                           		<tr>
	                            	<td colspan="2"  class="button">
	                            		<a class="mini-button"    onclick="onOk()">确认修改</a>
	                            	</td>
	                            </tr> 
	                            
	                        </table>
						</div>
            </form>
           
        </div>
      <script src="${ctxPath}/scripts/common/login-01.js"></script>
       <script type="text/javascript">
       		var form=new mini.Form('regForm');
       		var second = 60;
       		var t1 = null;
       		//获取验证码
       		function loadValiCode(){
       			var emailOrAccount = mini.get("emailOrAccount").getValue();
       			if(!emailOrAccount || emailOrAccount == ""){
       				alert("请输入邮箱/账号!");
       				return;
       			}
       			t1 = setInterval(refresh,1000);
       			var codeText = mini.get("codeText");
       			codeText.setEnabled(false);
       			_SubmitJson({
    				url : __rootPath + "/loadValiCode.do",
    				data : {
    					emailOrAccount : emailOrAccount,
    				},
    				method : 'POST',
    				success : function(data) {
    					if(!data.success){
    						alert(data.message);
    					}
    				}
    			});
       		}
       		
       		function refresh(){
       			var codeText = mini.get("codeText");
       			codeText.setText((second--)+"s后获取");
       			if(second==0){
       				clearInterval(t1);
       				second=60;
       				codeText.setEnabled(true);
       				codeText.setText("获取验证码");
       			}
       		}
	       
	        //确认
	        function onOk(){
	    	   form.validate();
	           if (!form.isValid())  return;
	           var newPwd = mini.get("newPwd").getValue();
	           var newPwdRe = mini.get("newPwdRe").getValue();
	           if(newPwd != newPwdRe){
	        	   alert("新密码和再次输入密码不一致！");
	        	   return;
	           }
	           var formData=form.getData();
	           var url="${ctxPath}/sys/org/osUser/editForgetPwd.do";
		       var frm = new mini.Form("regForm");
		       	frm.validate();
		           if (!frm.isValid()) {
		               return;
		           }
		           var formData=frm.getData();
				newPwd=sha256_digest(newPwd);
				formData.newPwd =newPwd;
				formData.newPwdRe =newPwdRe;
			   var config={
				url: url,
				method:'POST',
				data:formData,
				success:function(result){
					if(!result.success){
						   mini.alert(result.message);
						   return;
					   }
					setTimeout(function reloadDataGrid(){
						window.location=__rootPath+'/login.jsp';
					},2000);
				}
			   }
			   _SubmitJson(config);
	        }
		</script>
    </body>
</html>
