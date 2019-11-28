
<%-- 
    Document   : [文件盘基本类]编辑页
    Created on : 2018-07-26 15:06:15
    Author     : Tom_y
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[文件盘基本类]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="flieTrayBasic.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${flieTrayBasic.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[文件盘基本类]基本信息</caption>
					<tr>
						<th>外键：</th>
						<td>
							
								<input name="refId" value="${flieTrayBasic.refId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>文件盘名：</th>
						<td>
							
								<input name="fileTrayName" value="${flieTrayBasic.fileTrayName}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>排序大小ID：</th>
						<td>
							
								<input name="sn" value="${flieTrayBasic.sn}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>排序大小：</th>
						<td>
							
								<input name="snName" value="${flieTrayBasic.snName}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>管理员：</th>
						<td>
							
								<input name="adminName" value="${flieTrayBasic.adminName}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>管理员ID：</th>
						<td>
							
								<input name="adminId" value="${flieTrayBasic.adminId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>文档描述：</th>
						<td>
							
								<input name="descp" value="${flieTrayBasic.descp}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="flie/tray/flieTrayBasic"
		entityName="com.airdrop.flie.tray.entity.FlieTrayBasic" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>