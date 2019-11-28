<%-- 
    Document   : [OsRelType]明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[OsRelType]明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
<%-- 	<rx:toolbar toolbarId="toolbar1" /> --%>
<div class="fitTop"></div>
<div class="mini-fit">
<div class="form-container">
	<div class="form-title">
		<h1>更新信息</h1>
		<ul class="form-messages">
			<li>
				创  建  人：<rxc:userLabel userId="${osRelType.createBy}" />
			</li>
			<li>
				更  新  人：<rxc:userLabel userId="${osRelType.updateBy}" />
			</li>
			<li>
				创建时间：<fmt:formatDate value="${osRelType.createTime}" pattern="yyyy-MM-dd HH:mm" />
			</li>
			<li>
				更新时间：<fmt:formatDate value="${osRelType.updateTime}" pattern="yyyy-MM-dd HH:mm" />
			</li>
		</ul>
	</div>


	<div id="form1" >
		<div class="shadowBox">
			<table style="width: 100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
				<caption>机构基本信息</caption>
				<tr>
					<td>关  系  名 </td>
					<td>${osRelType.name}</td>
			
					<td>关系业务主键 <span class="star">*</span></td>
					<td>${osRelType.key}</td>
				</tr>
				<tr>
					<td>关系类型 </td>
					<td>${osRelType.relType}</td>
					<td>关系约束类型 </td>
					<td>${osRelType.constType}</td>
				</tr>
				<tr>
					<td>关系当前方名称</td>
					<td>${osRelType.party1}</td>

					<td>关系关联方名称</td>
					<td>${osRelType.party2}</td>
				</tr>
				<tr id="rowDim">
					<td>当前方维度</td>
					<td>
						<c:choose>
							<c:when test="${not empty osRelType.dimId1}">
								${osRelType.dimId1}
							</c:when>
							<c:otherwise>
								无
							</c:otherwise>
						</c:choose>
					</td>
					<td>关联方维度</td>
					<td>
						<c:choose>
							<c:when test="${not empty osRelType.dimId2}">
								${osRelType.dimId2}
							</c:when>
							<c:otherwise>
								无
							</c:otherwise>
						</c:choose>	
					</td>
				</tr>
				<tr>
					<td>状　　态</td>
					<td>${osRelType.status}</td>
					<td>是否是双向 <span class="star">*</span>
					</td>
					<td>${osRelType.isTwoWay}</td>
				</tr>
				<tr>
					<td>是否默认 <span class="star">*</span>
					</td>
					<td>${osRelType.isDefault}</td>
					<td>是否系统预设 <span class="star">*</span>
					</td>
					<td>${osRelType.isSystem}</td>
				</tr>
				<tr>
					<td>关系备注 </td>
					<td colspan="3">${osRelType.memo}</td>
				</tr>
			</table>
		</div>
		<%-- <div>
			<table class="table-detail column_2" cellpadding="0" cellspacing="1">
				<caption>更新信息</caption>
				<tr>
					<th>创建人</th>
					<td><rxc:userLabel userId="${osRelType.createBy}" /></td>
					<th>创建时间</th>
					<td><fmt:formatDate value="${osRelType.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<th>更新人</th>
					<td><rxc:userLabel userId="${osRelType.updateBy}" /></td>
					<th>更新时间</th>
					<td><fmt:formatDate value="${osRelType.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>
		</div> --%>
	</div>
</div>
</div>
	<rx:detailScript baseUrl="sys/org/osRelType" formId="form1" />
	<script type="text/javascript">
		$(function(){
			var relType='${osRelType.relType}';
			if(relType=='')return;
			if(relType=='USER-USER'){
				$("#rowDim").css("display","none");
			}else{
				$("#rowDim").css("display","");
			}
		});
	</script>
</body>
</html>