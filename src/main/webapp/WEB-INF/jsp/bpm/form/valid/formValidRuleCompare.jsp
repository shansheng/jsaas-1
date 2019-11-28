<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>数值比较</title>
	<%@include file="/commons/get.jsp"%>
</head>
<body>
	<div id="p1" class="form-outer" style="height: 80%">
		<form id="form1" method="post">
			<div class="form-inner">
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<tr>
						<th>比较字段</th>
						<td>
							<input class="mini-combobox" required="true"
							url="${ctxPath }/sys/bo/sysBoEnt/getFieldByBoDefId.do?tableName=${param.tableName }&boDefId=${param.boDefId}"
							 name="field" style="width: 90%;"   textField="name" valueField="name" showNullItem="false"  />
						</td>
					</tr>
					<tr>
						<th>比较规则</th>
						<td>
							<input name="type" class="mini-combobox" required="true"
							data="[{id:'gt',text:'大于'},{id:'gte',text:'大于等于'},{id:'lt',text:'小于'},{id:'lte',text:'小于等于'},{id:'eq',text:'等于'},{id:'neq',text:'不等于'}]"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<div class="mini-toolbar" style="text-align: center;">
		<a class="mini-button"   onclick="onOk()">确定</a>
		<a class="mini-button" onclick="CloseWindow()">关闭</a>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		
		var form = new mini.Form("#form1");
		
		function onOk() {
			if(!form.validate())return;
			CloseWindow("ok");
		}
		
		function setData(data){
			form.setData(data);
		}
		
		function getData(){
			return form.getData();
		}
	</script>
</body>
</html>