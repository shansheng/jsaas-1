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
			<a class="mini-button btn-red"  onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container">
			<form id="miniForm" style="padding:20px 10px;">
				<table class="table-detail column_2_m" cellspacing="1" cellpadding="1">
					<tr>
						<td>
							<span class="starBox">
								字段备注<span class="star">*</span>
							</span>
						</td>
						<td>
							<input class="mini-textbox" name="fieldLabel" required="true" vtype="maxLength:100,chinese"  style="width:100%" emptytext="请输入字段备注" />
						</td>
						<td>
							空文本提示
						</td>
						<td>
							<input class="mini-textbox" name="emptytext" style="width:100%"/>
						</td>
					</tr>
					<tr>
						<td>
							<span class="starBox">
								字段标识<span class="star">*</span>
							</span>
						</td>
						<td>
							<input
								id="fieldName"
								class="mini-combobox"
								name="fieldName"
								allowInput="true"
								textField="header"
								valueField="field"
								style="width:100%;"
							>
						</td>
						<td>比较类型</td>
						<td>
							<input class="mini-combobox" id="opType" name="opType"  data="opData" textField="fieldOpLabel" valueField="fieldOp" style="width:100%">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	
	var opData=[
				{'fieldOp':'EQ','fieldOpLabel':'等于'},
	            {'fieldOp':'LK','fieldOpLabel':'%模糊匹配%'},
	            {'fieldOp':'LEK','fieldOpLabel':'%左模糊匹配'},
	            {'fieldOp':'RIK','fieldOpLabel':'右模糊匹配%'}];
		mini.parse();
		
		var form=new mini.Form('miniForm');
		
		function setData(data,fieldDts){
			form.setData(data);
			mini.get('fieldName').setData(fieldDts);
			mini.get('opType').setText(data.fieldOpLabel);
		}
		
		function getData(){
			var formData=form.getData();
			formData.fieldOpLabel=mini.get('opType').getText();
			return formData;
		}
	</script>				
</body>
</html>