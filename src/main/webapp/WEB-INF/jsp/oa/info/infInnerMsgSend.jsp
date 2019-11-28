<%-- 
    Document   : 内部短消息发送页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>发送新消息</title>
<%@include file="/commons/edit.jsp"%>

</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"   onclick="sendMsg()">发送</a>
			<a class="mini-button btn-red"   onclick="clearAll()">重置</a>
			<a class="mini-button btn-red"  onclick="cancel()">取消</a>
		</div>
	</div>

<div class="mini-fit">
	<div class="form-container">
		<table class="table-detail column-two" >
			<tr>
				<td>收信人</td>
				<td>
					<textarea 
						class="mini-textboxlist" 
						emptyText="请选择收信人" 
						allowInput="false" 
						validateOnChanged="false"
						id="receive" 
						name="receive" 
						style="width:70%"></textarea>
				
					<a 
						class="mini-button"
						onclick="addPerson()">新增</a>
					<a 
						class="mini-button btn-red"
						onclick="clearPerson()"
					>清空</a>
				</td>
			</tr>
			<tr>
				<td>收信组</td>
				<td>
				
					<textarea 
						class="mini-textboxlist" 
						emptyText="请选择收信组" 
						allowInput="false" 
						validateOnChanged="false" 
						id="receiveGroup" 
						name="receiveGroup" 
						style="width:70%"></textarea>
					
					<a 
						class="mini-button"
						onclick="addGroup()"
					>新增</a>
					<a 
						class="mini-button btn-red"
						onclick="clearGroup()"
					>清空</a>
				</td>
			</tr>
			<tr id="subjectPart">
				<td>任务主题</td>
				<td id="subject"></td>
			</tr>
			<tr>
				<td>内　容</td>
				<td>
					<textarea 
						class="mini-textarea" 
						emptyText="请输入信息" 
						id="sendContext" 
						vtype="maxLength:128" 
						name="sendContext" 
						style="width:100%;height:120px;"
					></textarea>
				</td>
			</tr>
		
		</table>
	</div>
</div>
	
	<script type="text/javascript">
		addBody();
		$(function() {
			if ($("#subject").html() == "") {
				$("#subjectPart").hide();
			}
		});

		//发送新消息
		function sendMsg() {
			var infUser = mini.get('receive');//获取收信人
			var infGroup = mini.get('receiveGroup');//获取收信组
			var context = mini.get('sendContext');//获取内容
			if (infUser.getValue() == "" && infGroup.getValue() == "") {//判断两个收信是否为空
				mini.showTips({
					content : "收信人和收信组两个至少需要填写一个。",
					state : "info",
					x : "center",
					y : "bottom",
					timeout : 4000
				});
				return;
			}
			if (context.getValue() == "") {//判断正文是否为空
				mini.showTips({
					content : "消息内容不能为空。",
					state : "info",
					x : "center",
					y : "bottom",
					timeout : 3000
				});
				return;
			}
			if (context.getValue().length > 128) {//判断正文是否超过128个字符
				mini.showTips({
					content : "消息内容过长。",
					state : "info",
					x : "center",
					y : "bottom",
					timeout : 3000
				});
				return;
			}
			var userId = infUser.getValue();//收信人Id
			var userName = infUser.getText();//收信人名
			var groupId = infGroup.getValue();//收信组Id
			var groupName = infGroup.getText();//收信组名
			var contextMsg = context.getValue();//内容
			var linkMsg = $('#subject').html();
			//发送到后台
			_SubmitJson({
				url : __rootPath + '/oa/info/infInnerMsg/sendMsg.do',
				method : 'POST',
				data : {
					userId : userId,
					userName : userName,
					groupId : groupId,
					groupName : groupName,
					context : contextMsg,
					linkMsg : linkMsg
				},
				success : function(result) {
					if (!confirm("成功保存，是否写下一条消息？")) {
						CloseWindow('ok');
						return;
					} else {
						location.reload();
						return;
					}
				}
			});
		}
		//清空收信人
		function clearPerson() {
			var infUser = mini.get('receive');
			infUser.setValue("");
			infUser.setText("");
		}
		//清空收信组
		function clearGroup() {
			var infGroup = mini.get('receiveGroup');
			infGroup.setValue("");
			infGroup.setText("");
		}
		//重置所有
		function clearAll() {
			if (confirm("重置将清空所有数据,是否要重置?")) {
				var infUser = mini.get('receive');
				infUser.setValue("");
				infUser.setText("");
				var infGroup = mini.get('receiveGroup');
				infGroup.setValue("");
				infGroup.setText("");
				var context = mini.get('sendContext');
				context.setValue("");
			}
		}
		//取消按钮
		function cancel() {
			CloseWindow();
		}
		//增加收信人按钮
		function addPerson() {
			var infUser = mini.get('receive');
			var osusers=[];
			//获得原选择的值
			if(infUser.getValue()!='' ){
				var uIds=infUser.getValue().split(',');
				var uNames=infUser.getText().split(',');
				if(uIds && uNames && uIds.length==uNames.length){
					for(var i=0;i<uIds.length;i++){
						osusers.push({userId:uIds[i],fullname:uNames[i]});
					}
				}
			}
		
			_UserDialog({single:false,users:osusers,
				callback: function(users) {//打开收信人选择页面,返回时获得选择的user的Id和name
				var uIds = [];
				var uNames = [];
				infUser.setValue('');
				infUser.setText('');
				//将返回的选择分别存起来并显示
				for (var i = 0; i < users.length; i++) {
					uIds.push(users[i].userId);
					uNames.push(users[i].fullname);
				}
				
				infUser.setValue(uIds.join(','));
				infUser.setText(uNames.join(','));
			}});
		}
		//增加收信组
		function addGroup() {
			var infGroup = mini.get('receiveGroup');
			infGroup.setValue("");
			infGroup.setText("");
			_GroupDlg(false, function(users) {
				var uIds = [];
				var uNames = [];
				for (var i = 0; i < users.length; i++) {
					uIds.push(users[i].groupId);
					uNames.push(users[i].name);
				}
				if (infGroup.getValue() != '') {
					uIds.unshift(infGroup.getValue().split(','));
				}
				if (infGroup.getText() != '') {
					uNames.unshift(infGroup.getText().split(','));
				}
				infGroup.setValue(uIds.join(','));
				infGroup.setText(uNames.join(','));
			});
		}

		function setSubject(s) {
			s = s.replace(/rootPath/g, '${pageContext.request.contextPath}');
			$('#subject').html(s);

			$('.subject').on("click", function() {//绑定新的提交点击事件
				var url = $(this).attr('href1');
				_OpenWindow({
					title : '任务详细',
					height : 500,
					width : 780,
					max:true,
					url : url,
				});
			});
			$("#subjectPart").show();
		}
	</script>
</body>
</html>