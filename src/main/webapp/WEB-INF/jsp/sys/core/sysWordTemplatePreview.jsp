<%--
	time:2011-11-16 16:34:16
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>WORD表单套打</title>
	<%@include file="/commons/edit.jsp"%>
    <script src="${ctxPath}/scripts/sys/sysWordTemplate/WordTemplate.js" type="text/javascript"></script>
    
	<script type="text/javascript">
		var templateId="${templateId}";
		var pkId = "${pkId}";
		var pk="${pk}";
		
		function officeControlLoaded(){
			loadData();
		}
		
		function documentOpenedOnCompleteCallback(name){
			loadData();
		}
		
		function loadData(){
			var url = "${ctxPath}/sys/core/sysWordTemplate/getData.do?pkId=" + pkId + "&pk=" + pk;
			$.get(url,function(data){
				replaceTemplate(data);
			});
		}
	
	</script>
	<style type="text/css">
	   
		html,body{
			height: 100%;
			width: 100%;
		}
    </style>
</head>
<body style="overflow:hidden">
	
	<div class="mini-office"  style="height:100%;width:100%" readonly="true" name="office" rights="print,printSetting" version="false"  value="{type:'docx',id:'${templateId}'}"> </div>
	
</body>
</html>

