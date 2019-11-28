<%-- 
    Document   : 新闻公告编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>新闻公告编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button" plain="true" onclick="saveNews">保存</a>
			<c:if test="${insNews.status !='Issued'}">
				<a class="mini-button" plain="true" onclick="publish()">发布</a>
			</c:if>
		</div>
	</div>
	<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div >
				<input id="pkId" name="newId" class="mini-hidden" value="${insNews.newId}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>新闻公告基本信息</caption>
					<tr>
						<td >
							标　　题 <span class="star">*</span>
						</td>
						<td colspan="3" ><input name="subject" value="${insNews.subject}" class="mini-textbox" vtype="maxLength:120" style="width: 80%" required="true" emptyText="请输入标题" /></td>
						
					</tr>
					<tr>
						<td>
							<span class="starBox">
								摘　　要<span class="star">*</span>
							</span>		
						</td>
						<td  colspan="3"><input name="keywords" value="${insNews.keywords}" class="mini-textbox" vtype="maxLength:50" style="width: 80%" required="true" emptyText="将显示在手机端公告列表中"/></td>
					</tr>
					<tr>
						<td>发布栏目<span class="star">*</span> </td>
						<td  colspan="3"><input id="columnId" name="columnId" class="mini-combobox" url="${ctxPath}/oa/info/insColumnDef/getByType.do?type=newsNotice"
						 textField="name" valueField="colId" required="true"  style="width: 80%" showFolderCheckBox="false" 
						expandOnLoad="true" showClose="true" showNullItem="true" allowInput="false"  oncloseclick="clearIssuedCols"  value="${insNews.columnId}" /></td>
					</tr>

					<tr id="comment">
						<td>
							<span class="starBox">
								是否允许评论 <span class="star">*</span>
							</span>
						</td>
						<td><ui:radioBoolean name="allowCmt" value="${insNews.allowCmt}" required="true" /></td>
						<td>
							<span class="starBox">
								状　　态<span class="star">*</span>
							</span>
						</td>
						<td><c:choose>
							<c:when test="${insNews.status =='Issued'}">
							<div style="color:#05b905;">发　布</div>
							</c:when>
							<c:otherwise>
							<div style="color:red;">草　稿</div>
							</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>带图公告</td>
						<td  colspan="3"><input name="imgFileId" value="${insNews.imgFileId}" class="mini-hidden" vtype="maxLength:64" /> <img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=${insNews.imgFileId}" class="upload-file" />
						
						<span style="color: #c93756">PS:该图片将应用于手机端工作台轮播图片</span></td>
					</tr>
					<tr>
						<td>附　　件</td>
						<td  colspan="3">
							<div id="files" name="files" class="upload-panel"  style="width:auto;" isone="false" sizelimit="50" isDown="false" isPrint="false" value='${insNews.files}' readOnly="false" ></div>   
						</td>
					</tr>
					
					
					<tr>
						<td colspan="4" class="mini-ueditor-td"><ui:UEditor height="300" name="content" id="content">${insNews.content}</ui:UEditor></td>
					</tr> 
				</table>
			</div>
		</form>
	</div>
	</div>
	<script type="text/javascript">
	addBody();
	var form = new mini.Form('form1');
	$(function(){
		 $(".upload-file").on('click',function(){
			 var img=this;
			_UserImageDlg(true,
				function(imgs){
					if(imgs.length==0) return;
					$(img).attr('src','${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId='+imgs[0].fileId);
					$(img).siblings('input[type="hidden"]').val(imgs[0].fileId);
					
				}
			);
		 });
	});
	
	
		function changeIsImg(ck){
			if(ck.checked){
				$("#imgRow").css("display","");
			}else{
				$("#imgRow").css("display","none");
			}
		}
	    function clearIssuedCols() {
			var columnId = mini.get("columnId");
			columnId.setValue("");
			columnId.setText("");
		}
	    
	    function publish(){
	    	saveNews(true);
	    }
	    
	    
	    
	    //保存
	    function saveNews(isPublish) {
	    	
	    	//若有自定义函数，则调用页面本身的自定义函数
	        form.validate();
	        if (!form.isValid()) {
	            return;
	        }
	        
	        var formData=$("#form1").serializeArray();
	        //处理扩展控件的名称
	        var extJson=_GetExtJsons("form1");
	        
	        for(var key in extJson){
	        	formData.push({name:key,value:extJson[key]});
	        }
	       
	        if(!isPublish){
	        	isPublish=false;
	    	}
	        
	        formData.push({name:'isPublish',value:isPublish});
	        
	        //加上附件
	        var files = mini.get('files').getValue();
	        if(files!=''){
		        formData.push({
		        	name:'files',
		        	value:files
		        });
	        }
	        var config={
	        	url:__rootPath+"/oa/info/insNews/save.do",
	        	method:'POST',
	        	data:formData,
	        	success:function(result){	        		
	        		CloseWindow('ok');
	        	}
	        }
	        _SubmitJson(config);
	     }
	</script>
	<rx:formScript formId="form1" baseUrl="oa/info/insNews" entityName="com.redxun.oa.info.entity.InsNews"/>
</body>
</html>