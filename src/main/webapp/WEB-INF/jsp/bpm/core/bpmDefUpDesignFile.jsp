<%-- 
    Document   : 流程定义管理列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>流程定义设计文件上传处理</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
	        <a class="mini-button"  onclick="UploadFile()" plain="true">上传</a>
	    </div>
	</div>
	<div class="mini-fit">
	<div class="form-container">
	    	<form id="uploadForm" method="post" enctype="multipart/form-data" action="${ctxPath}/bpm/core/bpmDef/uploadDesignFile.do" class=" form-outer">
		    	<table class="table-detail column-four" style="width:100%;" >
		    		<tr>
						<td>分　类 </td>
						<td>
								<input id="treeId" name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BPM_DEF" 
							 	multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="true" 
						        showFolderCheckBox="false"  expandOnLoad="true" showClose="true" oncloseclick="onClearTree"
						        popupWidth="300" style="width:80%" popupHeight="180"/>
						
						     <input class="mini-hidden" id="isDeployNew" name="isDeployNew" />
						</td>
					</tr>
		    		<tr>
		    			<td>流程标题</td>
		    			<td>
		    				<input class="mini-textbox" name="subject"  required="true" style="width:80%" value=""/>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>流程Key</td>
		    			<td>
		    				<input class="mini-textbox" name="key" vtype="isEnglishAndNumber" required="true" style="width:80%" />
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    				流程描述
		    			</td>
		    			<td>
		    				<textarea class="mini-textarea" name="descp" style="width:80%"></textarea>
		    			</td>
		    		</tr>
		    		
		    		<tr>
		    			<td>
		    				是否发布
		    			</td>
		    			<td>
		    				<input type="checkbox" name="deploy"  />
		    			</td>
		    		</tr>
		    	
		    		<tr>
		    			<td>上传设计文件</td>
		    			<td>
		    			
		    				<input type="file" name="designFile"  id="designFile" style="width:300px;"/>
		    			</td>
		    		</tr>
		    	</table>
		    </form>
	    
	    </div>
	</div>
    <script type="text/javascript">
    
   		mini.parse();
    
    	function onClearTree(e){
			var obj = e.sender;
            obj.setText("");
            obj.setValue("");
		}
    	
    	$(function(){
    		$('#uploadForm').ajaxForm({  
                dataType: 'json',  
                success: function(result){  
                	if(result.success){
                		mini.showMessageBox({
                            showHeader: false,
                            width: 250,
                            title: "提示信息",
                            buttons: ["ok"],
                            message: result.message,
                            iconCls: "Info",
                            callback: function (action) {
                            	CloseWindow('ok');
                            }
                        });	
                	}
                	else{
                		_ShowTips({msg:result.message});
                	}
                }
            });  
    	})
    	
    	function UploadFile() {
    		var form=new mini.Form("#uploadForm");
    		form.validate();
    		if(!form.isValid()) {
    			_ShowTips({msg:"表单验证不通过!"});
    			return ;
    		}
    		$("#uploadForm").submit();
    	}
    </script>
</body>
</html>