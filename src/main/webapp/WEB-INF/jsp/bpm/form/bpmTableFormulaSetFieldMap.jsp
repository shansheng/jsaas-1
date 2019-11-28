<%-- 
    Document   : [表间公式]编辑页
    Created on : 2018-08-07 09:06:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[表间公式]编辑</title>
<%@include file="/commons/edit.jsp"%>
<style type="text/css">
fieldset{height: 100%;border: 1px solid silver;}
fieldset legend{font-weight: bold;}

div.operatorContainer{
	padding: 5px;
	text-align: left;
	overflow: auto;
}

div.operatorContainer > div {
    border-radius: 5px;
    border:1px solid silver;
    display:inline-block;
    background: #F0F0F0;
    padding: 2px; 
    line-height:32px;
    text-align:center;
    margin:4px;
    min-width: 32px;
    font-size:16px;
    font-weight:bold;
    height: 32px; 
    
}

div.operatorContainer > div:hover{
  background: white;
}

div.fieldContainer{
	padding: 5px;
	text-align: left;
	overflow: auto;
}

div.fieldContainer > div {
   
    background: #F0F0F0;
    padding: 2px; 
    width:100px;
    line-height:24px;
    text-align:center;
    margin:4px;
    min-width: 32px;
    font-size:14px;
    font-weight:bold;
    height: 24px; 
    
}
</style>
</head>
<body>
	
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		 <div region="south" showSplit="false" showHeader="false" height="45" showSplitIcon="false"  style="width:100%" bodyStyle="border:0">
			<div class="mini-toolbar dialog-footer" style="text-align:center;border:none;" >
			     <a class="mini-button"     onclick="onOk()">确定</a>
				    <a class="mini-button btn-red"    onclick="onCancel()">取消</a>
			</div>	 
		 </div>
		 <div title="业务视图列表" region="center" showHeader="false" showCollapseButton="false">
		 	<table style="width:100%;">
				<tr style="height:180px;">
					<td style="width:50%">
						<fieldset >
							<legend>字段</legend>
							<div id="boFields" style="height:170px">
								<div class="fieldContainer">
									<div>主表字段</div>
									<input id="mainField" class="mini-combobox"  textField="comment" valueField="name" emptyText="请选择..."
    								 showNullItem="true" nullItemText="请选择..." onvaluechanged="insertField"/> 
								</div>
								<c:if test="${param.isMain=='no' }">
									<div  class="fieldContainer">
										<div>子表字段</div>
										<input id="subField" class="mini-combobox"  textField="comment" valueField="name" emptyText="请选择..."
	    								 showNullItem="true" nullItemText="请选择..." onvaluechanged="insertField"/>
									</div>
								</c:if>
							</div>
						</fieldset>
					</td>
					<td style="width:50%">
						<fieldset >
							<legend>运算符</legend>
							<c:set var="action" value="${param.action}"> </c:set>		
							<div class="operatorContainer" style="height:170px">
			    				<div operator="+">+</div>
				    			<div operator="-">-</div>
				    			<div operator="*">*</div>
				    			<div operator="/">/</div>
				    			<div operator="()">()</div>
				    			<c:choose>
				    				<c:when test="${action=='upd' }">
				    					<div operator='cur.'>当前</div>
				    					<div operator='old.'>原记录</div>
				    					<c:if test="${param.isMain=='no' }">
					    					<div operator='mainCur.'>主表当前</div>
					    					<div operator='mainOld.'>主表原记录</div>
				    					</c:if>
				    				</c:when>
				    				<c:otherwise>
				    					<div operator='cur.'>当前</div>
				    					<c:if test="${param.isMain=='no' }">
				    						<div operator='mainCur.'>主表当前</div>
				    					</c:if>
				    				</c:otherwise>
				    				
				    			</c:choose>
				    			
			    			</div>
						</fieldset>
						
					</td>
					
				</tr>
				<tr>
					<td colspan="2">
						<fieldset>
							<legend>字段值</legend>
							<textarea id="fieldMap" style="width:100%;height:60px"><c:if test="${action=='upd' }">"${param.fieldName}"</c:if></textarea>
						</fieldset>
						
					</td>
				</tr>
			</table>
		 
		
		 </div>

	</div>
	
	<script type="text/javascript">
	mini.parse();
	
	var isMain="${param.isMain}";
	
	
	$(function(){
		if(isMain=="yes"){
			getCombFields('${param.boDefId}','${param.entName}',"mainField");
		}
		else{
			getCombFields('${param.boDefId}','_main',"mainField");
			getCombFields('${param.boDefId}','${param.entName}',"subField");
		}
		
		handOperator("fieldMap");
	});
	
	
	
	function getCombFields(boDefId,tableName,ctlId){
		var url= __rootPath +"/sys/bo/sysBoEnt/getFieldByBoDefId.do?boDefId="+boDefId+"&tableName="+tableName;
		var obj=mini.get(ctlId);
		$.get(url,function(data){
			obj.setData(data);
		});
	}

	/**
	*读取条件。
	*/
	function getData(){
		return $("#fieldMap").val();
	}
	
	function setData(val){
		if(val){
			$("#fieldMap").val(val);	
		}
	}
	
	
	function insertField(e){
		insert(e.value,"fieldMap")
	}
	
	
	
	function onOk(){
		CloseWindow("ok");
	}
	</script>
	<script src="${ctxPath}/scripts/flow/tableformula/tableformula.js"></script>
</body>
</html>