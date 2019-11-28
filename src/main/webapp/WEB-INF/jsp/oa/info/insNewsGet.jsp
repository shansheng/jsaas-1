<%-- 
    Document   : 新闻显示页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>新闻公告明细</title>
<%@include file="/commons/customForm.jsp"%>
<style type="text/css">
.MyCenter1 .shadowBox90{
	padding: 0 30px 20px;
}
.MyCenter1 h1{
	text-align: center;
	font-size:28px;
	color:#333;
	font-weight:bold;
	line-height:60px;
	margin-top: 14px;
}

.MyCenter1 .nav_Bottom em{
	font-style:normal;
	display:inline-block;
	width:14px;
	height:14px;
	font-size:12px;
	color:#9fa3aa;
	margin-right:4px;
}
.MyCenter1 .MyText{
	margin-top:16px;
	padding-bottom:10px;
	border-bottom:1px solid #ddd;
}
.MyCenter1 .MyText p{
	margin:0!important;
	line-height:40px!important;
}
.MyCenter1 #comment{
	margin-top:20px;
}
.MyCenter1 .MyFooterBtn{
	margin-top:10px;
}
.MyCenter1 .MyInput{
	display:inline-block;
}
.MyCenter1 .MyInput .mini-textbox{
	height:32px;
}
.MyCenter1 .MyInput .mini-textbox-border{
	height:30px;
}
.MyCenter1 .MyInput .mini-textbox-border input{
	height:30px;
}
.MyCenter1 .MyImg{
	display:inline-block;
	width:120px;
	height: 32px;
    vertical-align: middle;
    cursor:pointer;
}
.MyCenter1 .MyImg img{
	height:100%;
	width:100%;
}
</style>
</head>
<body >
<div class="mini-fit">
<div class="form-container MyCenter1" style="margin-top: 20px">
	<div id="form1">		
		<h1 name="tc">${insNews.subject}</h1>
		<ul class="form-messages nav_Bottom">
			<li>
				<em class="MyAdmin"></em>${insNews.author}
			</li>
			<li><em class="MyTime"></em><fmt:formatDate value="${insNews.createTime}" pattern="yyyy-MM-dd HH:mm"/></li>
			<li><em class="MyDegree"></em>${insNews.readTimes}</li>
			<li><em class="MyColumn"></em>${insNews.columnName}</li>
		</ul>

		<div class="MyText">
			${insNews.content}	
		</div>
	</div>
	<c:if test="${isCheck}">
		<div id="files" name="files" class="upload-panel"  style="width:auto;" isDown="true" isPrint="false" value='${insNews.files}' readOnly="true" ></div>
	</c:if>
	
	
	<div id="comment">
			<div id="p1">
				<form id="form2" name="form1" method="post">
					<table style="width: 100%; cellspacing="0" cellpadding="0" class="column_1" >
						<tr>
							<td>我要点评:</td>
						</tr>
						<tr>
							<td style="padding-top:4px;padding-bottom:4px;">
								<div style="margin-top:4px;">
									<input 
										name="content" 
										class="mini-textarea" 
										id="content" 
										required="true" 
										emptyText="说点什么吧..." 
										vtype="maxLength:128" 
										style="height: 90px; width: 60%" 
									/>
								</div>
							</td>
						</tr>
						<%-- <tr>
		                    <td>
		                   		<div style="margin-top:10px;">
				                    <div class="MyInput">
				                 		<input name="validCode" class="mini-textbox" id="validCode" vtype="maxLength:4"  required="true" emptyText="请输入验证码"  />  
				                 	</div>	
			                 		<span class="MyImg">
			                 			<img src="${ctxPath}/captcha-image.do" id="kaptchaImage" onclick="refreshCode()"/> 
			                 		</span>
			                 		<span style="font-size:12px;">
			                 			(看不清楚？点击图片更换图片。)
			                 		</span> 
		                 		</div>              
		                    </td>
		               </tr> --%>
					</table>
				</form>
				<div class="MyFooterBtn" property="footer">
					<a id="submitCm" class="mini-button"><b>提交</b></a>
					<a class="mini-button" onclick="clear()"><b>重置</b></a>
				</div>
			</div>
			
			
		</div>
</div>
</div>
</div>
<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<rx:detailScript baseUrl="oa/info/insNews" formId="form1"  />
	<script type="text/javascript">
		mini.parse();
		var cmId = null;//评论Id,用于子评论的回复评论Id
		var comments = '${comments}';//评论
		var permit = '${permit}';//权限,是否允许删除评论
		var commentsArr = mini.decode(comments);//转换成数组
		var form = new mini.Form("form2");//回复评论的Form
		var newId = ${insNews.newId};//当前新闻Id
		//判断是否允许评论
		$(function() {
			if('${insNews.allowCmt}' == 'NO'){
				$("#comment").hide();
			}
		});
		
		//刷新验证码
		/* function refreshCode(){
	    	   var randId=parseInt(10000000*Math.random());
	    	   $('#kaptchaImage').attr('src','${ctxPath}/captcha-image.do?randId='+randId);
	       } */
		//点击图片预览原图
		$(function() {
			$(".view-img").on('click', function() {
				var fileId = $(this).attr('id');
				if (fileId == '')
					return;
				_ImageViewDlg(fileId);//预览原图
			});
		});
		//点击回复
		$(function() {
			$("#submitCm").click(function() {
				submitCm();
			});
		});
		//显示评论
		$(function() {
			for (var i = 0; i < commentsArr.length; i++) {//遍历每个评论
				$("#comment").append("<div style='margin-top:8px;'><input id='cmId' type='hidden' value='"+commentsArr[i].cmId+"' />" + "<span id='name'><b>" + commentsArr[i].name + "</b></span>&nbsp;发表于&nbsp;<span id='time'><b>" + mini.formatDate(commentsArr[i].time, 'yyyy-MM-dd HH:mm:ss') + "</b></span>" + "<div style='text-align:right;float:right;'><span class='delPart'><a class='del' href='Javascript:void(0);''>[删除]</a>&nbsp;|&nbsp;</span>" + "<a class='reply' href='Javascript:void(0);''>[回复]</a></div>" + "</b></span></div><div id='content'>" + commentsArr[i].content + "</div><hr/>");
				var rpcomment = commentsArr[i].rpcomment;//得到每条评论的子评论
				for (var j = 0; j < rpcomment.length; j++) {//遍历该评论下的子评论
					$("#comment").append("<div id='reply'><ul><li><p><input id='cmId' type='hidden' value='"+rpcomment[j].cmId+"'/><b>" + rpcomment[j].name + "</b>&nbsp;回复&nbsp;<b>" + rpcomment[j].replyName + "</b>&nbsp;：" + "<span style='text-align:right;float:right;'>" + mini.formatDate(rpcomment[j].time, 'yyyy-MM-dd HH:mm:ss') + "&nbsp;&nbsp;&nbsp;" + "<span class='delPart'><a class='del' href='Javascript:void(0);''>[删除]</a>&nbsp;|&nbsp;</span>" + "<a class='sonReply' href='Javascript:void(0);''>[回复]</a></span></p>" + "<span id='reply-content'>" + rpcomment[j].content + "</span></li>");
				}
				$("#comment").append("</ul></div><br>");

			}
			//点击提交评论触发
			$(".reply").each(function() {
				$(this).on("click", function() {
					$("#submitCm").unbind('click');//解除原来的提交点击事件
					$("#submitCm").click(function() {//绑定新的提交点击事件
						submitReply();
					});
					cmId = $(this).parent().parent().find("#cmId").val();
				});
			});
			//点击子评论的回复评论触发
			$(".sonReply").each(function() {
				$(this).on("click", function() {
					$("#submitCm").unbind('click');//解除原来的提交点击事件
					$("#submitCm").click(function() {//绑定新的提交点击事件
						submitReply();
					});
					cmId = $(this).parent().parent().find("#cmId").val();
				});
			});
			$(".del").each(function() {
				$(this).on("click", function() {
					cmId = $(this).parent().parent().parent().find("#cmId").val();
					//console.log(cmId);
					delCm();
				});
			});
			$(".delPart").each(function() {
				if (permit != "yes") {
					//console.log($(".delPart").html());
					$(".delPart").hide();
				}
			});

		});

		//提交评论
		function submitCm() {
			var formJson = _GetFormJson("form2");
			form.validate();

			if (!form.isValid()) {
				return;
			}
			_SubmitJson({
				url : __rootPath + '/oa/info/insNewsCm/save.do?reply=no&newId=' + newId,
				method : 'POST',
				data : formJson,
				success : function(result) {
					location.reload();
				}
			});
		}
		//删除评论
		function delCm() {
			_SubmitJson({
				url : __rootPath + '/oa/info/insNewsCm/del.do',
				method : 'POST',
				data : {
					ids : cmId
				},
				success : function(result) {
					location.reload();
					return;
				}
			});
		}
		
		//点击回复后的提交评论
		function submitReply() {
			var formJson = _GetFormJson("form2");
			form.validate();

			if (!form.isValid()) {
				return;
			}
			_SubmitJson({
				url : __rootPath + '/oa/info/insNewsCm/save.do?reply=yes&newId=' + newId + '&cmId=' + cmId,
				method : 'POST',
				data : formJson,
				success : function(result) {
					location.reload();
				}
			});
		}
		
		function clear() {
			$(".mini-textarea").find(".mini-textbox-input").val("");
		}

/* 		function reply() {
			console.log($(this).parent().parent().find("#user").html());
			$(".mini-textarea").find(".mini-textbox-input").val("");
		} */
	</script>
</body>
</html>