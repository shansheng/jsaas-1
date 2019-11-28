<%-- 
    Document   : 租用机构编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
    <head>
        <title>租用机构编辑</title>
        <%@include file="/commons/edit.jsp" %>   
    </head>
    <body>
    	<div class="topToolBar">
			<div>
		        <a class="mini-button"     onclick="onOk()">确定</a>
				<a class="mini-button btn-red"    onclick="onCancel()">关闭</a>
			</div>
		</div>
        <div class="mini-fit">
            <div class="form-container ">
                <form id="form1" method="post">
                    <input id="pkId" name="pkId" class="mini-hidden" value="${sysInst.instId}"/>
                    <table class="table-detail column-two" cellspacing="1" cellpadding="0">
                        <caption>域名信息</caption>
                         <tr>
                            <td>
                                <span class="starBox">
                                    原域名
                                </span>
                            </td>
                             <td>
                                 <input name="oldDomain" value="${sysInst.domain}" class="mini-textbox" allowInput="false" style="width:80%"/>
                             </td>
                         </tr>
                         <tr>
                            <td>
                                <span class="starBox">
                                    新域名
                                </span>
                             </td>
                             <td>
                                 <input name="newDomain" value="" class="mini-textbox" required="true" vtype="maxLength:64" style="width:80%"/>
                             </td>
                         </tr>

                     </table>
                </form>
            </div>
        </div>
       <script type="text/javascript">
	       	function onCancel(){
				CloseWindow('cancel');
			}
			
			function onOk(){
				var form = new mini.Form('form1');
				var url= __rootPath +'/sys/core/sysInst/saveDomain.do';
				var data = form.getData();
				_SubmitJson({
        			url:url,
        			data:data,
        			method:'POST',
        			success:function(result){
        				CloseWindow('ok');
        			}
        		});
				
			}
		</script>
    </body>
</html>
