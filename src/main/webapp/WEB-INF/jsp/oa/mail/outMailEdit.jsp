<%-- 
    Document   : 外部邮件编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<title>外部邮件编辑</title>
<%@include file="/commons/edit.jsp"%>
<style type="text/css">
	.mini-panel-toolbar{
		text-align:left;
		padding-left:6px;
	}
	#form1 .mini-button .mini-button-icon-only .mini-button-icon{
		left:2px;
	}

</style>
</head>
<body>

<div class="topToolBar">
	<div>
		<a class="mini-button" plain="true" onclick="sendmail">发送</a> 
		<a class="mini-button btn-red" plain="true" onclick="closeWindow">关闭</a>
	</div>
</div>
	
<div class="Mauto">
	<div id="p1" class="form-outer2">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="mailId" class="mini-hidden" value="${mail.mailId}" />
				<table class="table-detail column_2" cellspacing="0" cellpadding="0">
					<caption>邮件信息</caption>


					<tr>
						<td width="120">收件人邮箱</td>
						<td colspan="3"><input id="recAddrs" name="recAddrs" class="mini-textarea" vtype="maxLength:65535" style="width: 70%; height: 25px" required="true" emptyText="请输入收件人邮箱" value="${mail.recAddrs}" /> <a class="mini-button MyBlock" iconCls="icon-add"
							onclick="addAddrBook" plain="true"></a></td>
					</tr>

					<tr>
						<td>抄　送</td>
						<td colspan="3"><textarea name="ccAddrs" class="mini-textarea" vtype="maxLength:65535" style="width: 70%; height: 25px">${mail.ccAddrs}</textarea></td>
					</tr>

					<tr>
						<td>密　送</td>
						<td colspan="3"><textarea name="bccAddrs" class="mini-textarea" vtype="maxLength:65535" style="width: 70%; height: 25px">${mail.bccAddrs}</textarea></td>
					</tr>

					<tr>
						<td>主　题 <span class="star">*</span> 
						</td>
						<td colspan="3"><textarea name="subject" class="mini-textarea" vtype="maxLength:512" style="width: 70%; height: 25px;" required="true" emptyText="请输入主题">${mail.subject}</textarea></td>
					</tr>

					<tr>
						<td>发件人邮箱 </td>
						<td colspan="3"><textarea name="senderAddrs" class="mini-textarea" vtype="maxLength:65535" style="width: 70%; height: 25px" required="true" emptyText="请输入发件人邮箱" allowInput="false">${mail.mailConfig.mailAccount}</textarea></td>
					</tr>
					<tr>
						<td>附　件 </td>
						<td colspan="3" class="customform">
						<input id="fileIds" name="fileIds" class="upload-panel"  style="width: 80%" allowupload="true" label="附件" fname="fileName" allowlink="true" zipdown="true" mwidth="80" 
							wunit="%" mheight="0" hunit="px" />
						</td>
					</tr>

					<tr>
						<td colspan="4">
							<div id="content" name="content" class="mini-ueditor"   style="width:auto;"  height="400" width="700" ></div>
						</td>
					</tr>



				</table>
			</div>
		</form>
	</div>
<rx:formScript formId="form1" baseUrl="oa/mail/mail" />
</div>
	<script type="text/javascript">
	mini.parse();
	
	/*关闭窗口事件处理*/
	function handle(){
		 if (confirm("你的邮件内容已经改变，是否将邮件保存到草稿箱？")) {
				var content = _GetFormJson("form1");
				var data = mini.encode(content);
				_SubmitJson({
					url : __rootPath + "/oa/mail/outMail/saveToDraft.do",
					data : {
						data : data,
						configId : '${mail.mailConfig.configId}'
					},
					method : 'POST',
					success : function(text) {
						alert("保存成功");
					}
				});
		 }
	}
	
	
		$(function() {
			mini.get("fileIds").setValue(mini.decode('${files}'));
		});

		/*发送外部邮件*/
		function sendmail() {
			form.validate();
	        if (!form.isValid()) {
	            return;
	        }
			var content = _GetFormJsonMini("form1");
			var data=mini.encode(content);
			_SubmitJson({
				url : __rootPath + "/oa/mail/outMail/sendMail.do",
				data : {
					data : data,
					configId : '${mail.mailConfig.configId}'
				},
				method : 'POST',
				success : function() {
					CloseWindow();
				}
			});
		}

		/*关闭窗口*/
		function closeWindow() {
			CloseWindow('ok',handle);
		}
		
		/*打开添加收件人列表*/
		function addAddrBook(){
			_OpenWindow({
				url:__rootPath+"/oa/personal/addrGrp/list.do?mail=sendmail",
				title:"添加联系人邮箱地址",
				width:800,
				height:600,
				ondestroy:function(action){
					if(action!='ok') return;
					  var iframe = this.getIFrameEl();
					  	var rec=mini.get("recAddrs");
		                var value=rec.getValue();
		                var mails = iframe.contentWindow.getAllAddrBook(value);  //调用其他窗口函数
		                
		                //rec.setValue(value+mails);   //设置收件人
		                var l=value.length;
		                var s="";
		                if(l<=0){
		                	for(var i=0;i<mails.length;i++){
		                		if(i==0){
		                			s=mails[i].contact;	
		                			continue;
		                		}
		                		s=s+","+mails[i].contact;	
		                	}
		                	
		                }
		                else{
		                	if(","!=value.substr(l-1)){
		                		s=",";
		                	}
		                	for(var i=0;i<mails.length;i++){
		                		if(i==0){
		                			s=s+mails[i].contact;	
		                			continue;
		                		}
		                		s=s+","+mails[i].contact;	
		                	}		                	
		                }
		                rec.setValue(value+s);
				}
			});
		}
	</script>

	
</body>
</html>