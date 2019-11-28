<%-- 
    Document   : 用户明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<%-- 	<rx:toolbar toolbarId="toolbar1" hideRecordNav="true"/> --%>
<div class="fitTop"></div>
<div class="mini-fit">
	<div id="form1" class="form-container">
			<table style="width: 100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
				<caption>基本信息</caption>
				<tr>
					<td>姓　　名  </td>
					<td>${osUser.fullname}</td>
					<td>编　　号 </td>
					<td>${osUser.userNo}</td>
				</tr>
				<tr>
					<td>入职时间 </td>
					<td>
						<fmt:formatDate value="${osUser.entryTime}" pattern="yyyy-MM-dd"/>	
					</td>
					<td>离职时间 </td>
					<td>
						<fmt:formatDate value="${osUser.quitTime}" pattern="yyyy-MM-dd"/>	
					</td>
				</tr>
				<tr>
					<td>状　　态 </td>
					<td>${osUser.status}</td>
					<td>来　　源</td>
					<td>${osUser.from}</td>
				</tr>
				<tr>
					<td>手　　机</td>
					<td>${osUser.mobile}</td>
					<td>邮　　件 </td>
					<td>${osUser.email}</td>
				</tr>
				<tr>
					<td>QQ 号</td>
					<td colspan="3">${osUser.qq}</td>
				</tr>
				<tr>
					<td>地　　址</td>
					<td colspan="3">${osUser.address}</td>
				</tr>
				<tr>
					<td>紧急联系人</td>
					<td>${osUser.urgent}</td>
					<td>紧急联系人手机 </td>
					<td>${osUser.urgentMobile}</td>
				</tr>
				<tr>
					<td>生　　日</td>
					<td>
						<fmt:formatDate value="${osUser.birthday}" pattern="yyyy-MM-dd"/>
					</td>
					<td>性　　别</td>
					<td>${osUser.sex}</td>
				</tr>
				<tr>
					<td>照　　片</td>
					<td colspan="3">
					<img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&view=true&fileId=${osUser.photo}" class="view-img" id="${osUser.photo}"/>
					</td>
				</tr>
			</table>

		<c:if test="${fn:length(accountList)>0}">

				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					<caption>绑定的用户账号</caption>
					<c:forEach items="${accountList}" var="account">
					<tr>
						<td>账  号  名</td>
						<td>${account.name}</td>
					</tr>
					</c:forEach>
				</table>

		</c:if>
		<div>
			<table class="table-detail column-four" cellpadding="0" cellspacing="1">
				<caption>更新信息</caption>
				<tr>
					<td>创  建  人</td>
					<td><rxc:userLabel userId="${osUser.createBy}" /></td>
					<td>创建时间</td>
					<td><fmt:formatDate value="${osUser.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>更  新  人</td>
					<td><rxc:userLabel userId="${osUser.updateBy}" /></td>
					<td>更新时间</td>
					<td><fmt:formatDate value="${osUser.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>
		</div>
	</div>
</div>
	<rx:detailScript baseUrl="sys/org/osUser" formId="form1" />
	<script type="text/javascript">
		addBody();
       	$(function(){
       		$(".view-img").css('cursor','pointer');
       		$(".view-img").on('click',function(){
       			var fileId=$(this).attr('id');
       			if(fileId=='')return;
       			_ImageViewDlg(fileId);
       		});
       	});
     </script>
</body>
</html>