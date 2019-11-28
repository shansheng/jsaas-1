<%-- 
    Document   : 业务视图对话框
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>业务视图对话框</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		
		 <div region="south" showSplit="false" showHeader="false" height="40" showSplitIcon="false"  bodyStyle="border:0;text-align:center">

				<a class="mini-button"     onclick="onOk()">确定</a>
				<a class="mini-button btn-red"    onclick="onCancel()">取消</a>

		 </div>
		 
		 <div  region="center" showHeader="false" showCollapseButton="false">
		         <div class="mini-fit" style="border:0;">
						<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;"
						 allowResize="false" url="${ctxPath}/bpm/form/bpmMobileForm/getByBoDefId.do?boDefIds=${param.boDefIds}" idField="id" multiSelect="false"
						  allowAlternating="true" >
							<div property="columns">
								<div type="checkcolumn" width="20"></div>
								<div field="name" width="160" headerAlign="center" allowSort="true">名称</div>
								<div field="alias" width="140" headerAlign="center" allowSort="true">别名</div>
							</div>
						</div>
		        </div>
		 </div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid=mini.get('datagrid1');
		grid.load();
	   	
	   	function getFormView(){
	   		return grid.getSelected();
	   	}
	   	
	   	function onOk(){
	   		CloseWindow('ok');
	   	}
	   	
	   	function onCancel(){
	   		CloseWindow('cancel');
	   	}
	   	
    </script>
	
	
</body>
</html>