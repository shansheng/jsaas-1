<%--
	//企业注册，生成企业需要的基本内容，
	//同时分配基础的账号
 --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSaaS私有云租用应用平台--申请试用</title>  
        <%@include file="/commons/edit.jsp"%>
        <link rel="stylesheet" type="text/css" href="${ctxPath}/styles/login-h01.css"/>
        <script src="${ctxPath}/scripts/anonymus.js" type="text/javascript"></script>
        <style>
        	html,body{
        		background: #f8f8f8;
        	}
        	.title{
        		width:100%;
        		text-align: center;
        		line-height: 40px;
        		height: 40px;
        		color:#333;
        		
        	}
        	#p1{
        		background:#fff;
        	}
        	td,tr,table,th{
        		border:0!important;
        		padding:0!important;
        		color:#333!important;
        	}
        	.mini-textbox{
        		margin:6px 0;
        	}
        	img{
        		height:28px;
        		vertical-align:middle;
        	}
        	.mini-textbox-border input{
        		width:100%;
        		height:100%;
        	}
        	.MyBtn{
        		text-align:center;
        		line-height:40px;
        		margin-top:10px;
        	}
        	.MyBtn a.mini-button:first-child{
        		margin-right:10px;
        	}
        </style>
    </head>
    <body>
    	<canvas id="canvas" width="1500" height="1000"></canvas>
       	<div class="registerBox">
            <form id="regForm" method="post">
                	<div style="padding:5px;">
                			<div class="title">
                				<h2>申请试用</h2>
                			</div>
                		    <table class="table-detail column_2_m" cellspacing="1" cellpadding="0">
                		    	<tr>
	                                <th>姓名：</th>
	                                <td>                        
	                                    <input name="contractor" class="mini-textbox" required="true" style="width:80%"/>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th>公司：</th>
	                                <td > 
	                                    <input name="nameCn" class="mini-textbox" required="true" vtype="maxLength:256" emptyText="请输入公司名" style="width:80%"/>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th>手机：</th>
	                                <td >                        
	                                    <input name="phone"  required="true"  class="mini-textbox" vtype="float;minLength:11;maxLength:11" style="width:200px"/>
	                                </td>
	                            </tr>
	                          
	                            <tr>
	                            	<th>验证码</th>
	                            	<td >
	                            		<input name="validCode" class="mini-textbox" id="validCode" vtype="maxLength:4" width="100"  required="true" />                 
        								<img src="${ctxPath}/captcha-image.do" width="75" height="35" id="kaptchaImage"  style="cursor:pointer" onclick="refreshCode()"/> 
	                            	</td>
	                            </tr>
	                        </table>
						</div>
            </form>
           	<div class="MyBtn">
	         	<a class="mini-button"    onclick="onOk()">确定</a>
				<a class="mini-button btn-red"    onclick="onCancel()">重置</a>
           	</div>
        </div>
      <script src="${ctxPath}/scripts/common/login-01.js"></script>	
       <script type="text/javascript">
       		var form=new mini.Form('regForm');
			//刷新编码
	        function refreshCode(){
	    	   var randId=parseInt(10000000*Math.random());
	    	   $('#kaptchaImage').attr('src','${ctxPath}/captcha-image.do?randId='+randId);
	        }
	       
	        //确认
	        function onOk(){
	    	   form.validate();
	           if (!form.isValid())  return;
	           var formData=form.getData();
	           var url="${ctxPath}/register.do";
	           _SaveJson("regForm",url,function(text){
	        	   var result=mini.decode(text);
	        	   window.location=__rootPath+'/pub/anony/sysInst/regSuccess.do?instId='+result.data.instId;
	           })
	        }
	       //取消
	       function onCancel(){
	    	   $("#regForm")[0].reset();
	       }
		</script>
    </body>
</html>
