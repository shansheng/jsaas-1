<%-- 
    Document   : 系统树节点编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>系统树节点编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>

	<rx:toolbar toolbarId="toolbar1" pkId="${sysTree.treeId}" hideRecordNav="true"/>
	<div class="mini-fit">
		<div id="p1" class="form-container">
			<form id="form1" method="post">
				<input id="pkId" name="treeId" class="mini-hidden" value="${sysTree.treeId}" />
				<input name="parentId" value="${sysTree.parentId}" class="mini-hidden"/>
				<input name="catKey" value="${sysTree.catKey}" class="mini-hidden"  />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>分类基本信息</caption>
					<tr>
						<td>
							名　　称<span class="star">*</span>
						</td>
						<td colspan="3">
							<input
								name="name"
								value="${sysTree.name}"
								onblur="getPinyin"
								class="mini-textbox"
								vtype="maxLength:128"
								required="true"
								emptyText="请输入名称"
								style="width:100%"
							/>
						</td>
					</tr>
					<tr>
						<td>
							标  识  键<span class="star">*</span>
						</td>
						<td  colspan="3">
							<input
								id="key"
								name="key"
								value="${sysTree.key}"
								class="mini-textbox"
								vtype="maxLength:64"
								required="true"
								emptyText="标识键"
								style="width:100%"
							/>
						</td>
					</tr>
					<tr>
						<td>编　　码 </td>
						<td>
							<input
									name="code"
									value="${sysTree.code}"
									class="mini-textbox"
									vtype="maxLength:64"
									emptyText="编码"
									style="width:100%"
							/></td>
						<td>
							序　　号<span class="star">*</span>
						</td>
						<td colspan="0">
							<input
								name="sn"
								value="${sysTree.sn}"
								class="mini-spinner"
								vtype="maxLength:10"
								required="true"
								minValue="1"
								maxValue="10000"
								emptyText="请输入序号"
								style="width:100%"
							/>
						</td>
					</tr>
					<tr>
						<td>描　　述</td>
						<td colspan="3"><textarea name="descp" class="mini-textarea" vtype="maxLength:512" style="width:100%">${sysTree.descp}</textarea></td>
					</tr>
					<tr <c:if test="${sysTree.catKey!='CAT_DIM'}">style="display:none"</c:if>>
						<td>数据项展示类型 </td>
						<td colspan="3">
							<div
								id="dataShowType"
								name="dataShowType"
								class="mini-radiobuttonlist"
								repeatDirection="horizontal"
								textField="text"
								valueField="id"
								value="${sysTree.dataShowType}"
								required="true"
								style="width:80%"
								data="[{id:'FLAT',text:'平铺'},{id:'TREE',text:'树'}]"
							></div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<rx:formScript formId="form1" baseUrl="sys/core/sysTree" />
	<script type="text/javascript">
		function getPinyin(e){
			var val=e.sender.getValue();
			var key=mini.get('key');
			if(key.getValue().trim()==''){
				_SubmitJson({
					url:__rootPath+'/pub/base/baseService/getPinyin.do',
					method:'POST',
					showMsg:false,
					showProcessTips:false,
					data:{
						words:val,
						isCap:'true',
						isHead:'true'
					},
					success:function(result){
						key.setValue(result.data);
					}
				});
			}
		}
		addBody();
	</script>
</body>
</html>