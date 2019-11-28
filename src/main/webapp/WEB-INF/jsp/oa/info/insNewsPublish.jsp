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
			<a class="mini-button" plain="true" onclick="onPublish">发布</a>
			<a class="mini-button btn-red" plain="true" onclick="onCancel">关闭</a></td>
		</div>
	</div>
	<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div>
				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					<caption>新闻发布</caption>
					<tr>
						<td>新闻标题</td>
						<td><input id="pkId" name="newId" class="mini-textboxlist" style="width: 80%;" value="${newId}" text="${newTitle}" readonly/></td>
					</tr>
					<tr>
						<td>发布栏目</td>
						<td>
							<input id="columnId" name="columnId" style="width: 80%;" class="mini-combobox" url="${ctxPath}/oa/info/insColumnDef/getByType.do?type=newsNotice"
								textField="name" valueField="colId"    showFolderCheckBox="false" expandOnLoad="true" showClose="true" showNullItem="true" allowInput="true" 
								oncloseclick="clearIssuedCols" value="${insNews.columnId}" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/info/insNews" />
	<script type="text/javascript">
		var form = new mini.Form("form1");
		function onPublish(){
			form.validate();
			if (!form.isValid()) {
				return;
			}
			var formData = form.getData();
			_SubmitJson({
				url : __rootPath + '/oa/info/insNews/deploy.do',
				method : 'POST',
				data : formData ,
				postJson:true,
				success : function(result) {
						CloseWindow('ok');
				}
			});
		}
	
	
	
		$(function() {
			$(".upload-file").on('click', function() {
				var img = this;
				_UserImageDlg(true, function(imgs) {
					if (imgs.length == 0)
						return;
					$(img).attr('src', '${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=' + imgs[0].fileId);
					$(img).siblings('input[type="hidden"]').val(imgs[0].fileId);

				});
			});
		});

		function change(e) {
			if ("NO" == e.sender.getValue()) {
				$("#shortValid").show();
			} else if ("YES" == e.sender.getValue()) {
				$("#shortValid").hide();
				$("#endTime").find("input").val("2026-01-01 00:00:00");
				$("#startTime").find("input").val("2015-01-01 00:00:00");
			}
		}
		$(function() {
			$("#shortValid").hide();

		});

		function changeIsImg(ck) {
			if (ck.checked) {
				$("#imgRow").css("display", "");
			} else {
				$("#imgRow").css("display", "none");
			}
		}
		function clearIssuedCols() {
			var issuedColIds = mini.get("issuedColIds");
			issuedColIds.setValue("");
			issuedColIds.setText("");
		}
	</script>
</body>
</html>