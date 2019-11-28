<%-- 
    Document   : [表间公式]编辑页
    Created on : 2018-08-07 09:06:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[表间公式]条件配置</title>
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
	/*border:1px solid silver;*/
	display:inline-block;
	background: #8bb8e6;
	padding: 2px 6px;
	line-height:32px;
	text-align:center;
	margin:3px;
	min-width: 32px;
	font-size:16px;
	color: #fff;
	height: 32px;
	cursor: pointer;
}

div.operatorContainer > div:hover{
	background: #66b1ff;
}
.mini-layout-region{
	border-top: 1px solid #ddd;
}

.conditionBox{
	padding:  6px;
	box-sizing: border-box;
}
.divBox{
	border: 1px solid #ddd;
	margin-top: 6px;
}
header{
	padding: 6px;
	font-size: 16px;
	border-bottom: 1px solid #ddd;
	background: #ecf5ff;
}
textarea{
	border-color: #ddd;
}
</style>
</head>
<body>
	<div class="mini-fit">
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		<div region="south" title="条件" showSplit="false" showHeader="true" height="140" showSplitIcon="false"  showCollapseButton="false" style="width:100%">
			<div class="mini-fit" style="padding: 0 6px">
				<textarea id="condition" style="width:100%;height:94%;box-sizing: border-box;"></textarea>
			</div>
		</div>
		 <div region="west"
			  title="字段属性"
			  showSplit="false"
			  showHeader="true"
			  showSplitIcon="false"
			  style="width:100%"
			  showCollapseButton="false"
		 >
			 <div class="mini-fit">
				 <ul id="systree"
					 url="${ctxPath}/sys/bo/sysBoDef/getBoDefConstruct.do?boDefId=${param.boDefId }&isMain=${param.isMain }&entName=${param.entName }"
					 class="mini-tree"  style="width:100%;height: 100%;"  showTreeIcon="true"
					 textField="comment"  idField="name"  resultAsTree="true" expandOnLoad="true" onnodeclick="treeNodeClick"   ></ul>
			 </div>
		 </div>
		<div title="条件" region="center" showHeader="false" showCollapseButton="false">
			<div class="conditionBox">
				<div class="divBox" style="margin-top: 0">
					<header>运算</header>
					<div class="operatorContainer">
						<div operator="+">+</div>
						<div operator="-">-</div>
						<div operator="*">*</div>
						<div operator="/">/</div>
						<div operator="!">!</div>
						<div operator="()">()</div>
						<div operator="&&">AND</div>
						<div operator="||">OR</div>
						<div operator="==">==</div>
						<div operator=".equals()">相等</div>
						<div operator='com.redxun.bpm.form.service.FormulaUtil.in("","","")'>IN</div>

						<div operator='action.equals("new")'>新增</div>
						<div operator='action.equals("upd")'>更新</div>

						<div operator='action.equals("del")'>删除</div>


						<c:choose>
							<c:when test="${action=='upd' }">
								<c:choose>
									<c:when test="${isMain=='yes'}">
										<div operator='cur.ID_'>源表主键</div>
										<div operator='cur.'>源当前</div>
										<div operator='old.'>源原记录</div>
									</c:when>
									<c:otherwise >
										<div operator='mainCur.ID_'>源主表主键</div>
										<div operator='mainCur.'>源主当前</div>
										<div operator='mainOld.'>源主原记录</div>

										<div operator='cur.ID_'>源当前主键</div>
										<div operator='cur.'>源当当前</div>
										<div operator='old.'>源原记录</div>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${isMain=='yes'}">
										<div operator='cur.'>当前</div>
										<div operator='cur.ID_'>源表主键</div>
									</c:when>
									<c:otherwise >
										<div operator='main.'>源主表</div>
										<div operator='main.ID_'>源主表主键</div>
										<div operator='cur.'>源当前</div>
										<div operator='cur.ID_'>源当前主键</div>

									</c:otherwise>
								</c:choose>
							</c:otherwise>



						</c:choose>
						<div operator='com.redxun.bpm.form.service.FormulaUtil.isExist("${param.tableName}","fieldName","值")'>存在</div>
						<div operator='com.redxun.bpm.form.service.FormulaUtil.isExistBySql("SQL")'>SQL存在</div>
					</div>
				</div>
				<div  class="divBox">
					<header>表单方案</header>
					<div class="operatorContainer">
						<div operator='mode.equals("form")'>表单</div>
						<div operator='op.equals("save")'>保存</div>
						<div operator='op.equals("draft")'>草稿</div>
						<div operator='op.equals("start")'>启动流程</div>
					</div>
				</div>
				<div  class="divBox">
					<header>表单方案</header>
					<div class="operatorContainer" >
						<div operator='mode.equals("form")'>流程</div>
						<div operator='op.equals("draft")'>草稿</div>
						<div operator='op.equals("start")'>启动流程</div>
						<div operator='op.equals("save")'>保存(任务)</div>
						<div operator='op.equals("approve")'>审批(任务)</div>
						<div operator='opinion.equals("AGREE")'>通过</div>
						<div operator='opinion.equals("ABSTAIN")'>弃权</div>
						<div operator='opinion.equals("REFUSE")'>反对</div>
						<div operator='opinion.equals("BACK")'>驳回</div>
						<div operator='opinion.equals("BACK_SPEC")'>驳回(指定)</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	</div>
	<div class="bottom-toolbar">
		<a class="mini-button"     onclick="onOk()">确定</a>
		<a class="mini-button btn-red"    onclick="onCancel()">取消</a>
	</div>
	<script type="text/javascript">
	mini.parse();
	
	
	$(function(){
		handOperator("condition");
		loadTableFields("comboTableField","${param.tableName}","");
	});
	
	function treeNodeClick(e){
		var node=e.node;
		var type=node.type;
		var isField=node.isField;
		var content="";
		if(isField){
			content=node.name;
		}
		insert(content,"condition");
	}
	
	function changeFields(e){
		insert(e.value,"condition")
	}
	
	function onAdd(e){
		var obj=mini.get("comboTableField");
		insert(obj.getValue(),"condition");
	}
	
	function setData(data){
		$("#condition").val(data);
	}

	/**
	*读取条件。
	*/
	function getCondition(){
		return $("#condition").val();
	}
	
	function onOk(){
		CloseWindow("ok");
	}
	</script>
	<script src="${ctxPath}/scripts/flow/tableformula/tableformula.js"></script>
</body>
</html>