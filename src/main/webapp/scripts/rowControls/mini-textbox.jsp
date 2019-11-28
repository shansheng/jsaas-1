<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>文本框属性</title>
<%@include file="/commons/edit.jsp"%>

</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="CloseWindow('ok')">保存</a>
			<a class="mini-button btn-red" onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<form id="miniForm">
		<table class="table-detail column_2_m" cellspacing="1" cellpadding="1">
			<tr>
				<td>字符长度<span class="star">*</span> </td>
				<td>
					<input id="maxlen" name="maxlen" class="mini-spinner"  minValue="0" maxValue="4000" value="0" />
				</td>
				
				<td>是否必填</td>
				<td>
					<input class="mini-checkbox" name="required" trueValue="true" falseValue="false" value="false">
				</td>
			</tr>
			<tr>
				<td>格式化</td>
				<td colspan="3">
					<input class="mini-textbox" name="format" /> 
					<br/>数字格式如：,###.00,#.00,#.000,或日期yyyy-MM-dd或yyyy-MM-dd HH:mm:ss 
				</td>				
			</tr>
			<tr>
					<td>
							默认值
					</td>
					<td>
						<input class="mini-textbox" name="value" style="width:90%"/>
					</td>
				<td>校验规则</td>
				<td>
					<input id="vtype" name="vtype" class="mini-combobox"  textField="name" valueField="value" style="width:280px;"
    				url="${ctxPath}/sys/core/sysDic/getByDicKey.do?dicKey=_FieldValidateRule"  allowInput="false" showNullItem="true" nullItemText="请选择..."/>
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
	
	
		mini.parse();
		
		var form=new mini.Form('miniForm');
		
		function setData(data){
			form.setData(data);
		}
		
		function getData(){
			var formData=form.getData();
			return formData;
		}
	</script>				
</body>
</html>