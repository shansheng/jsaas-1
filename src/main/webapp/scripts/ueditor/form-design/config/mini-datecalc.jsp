<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html >
<html>
<head>
<title>日期计算</title>
<%@include file="/commons/mini.jsp"%>

<style type="text/css">
fieldset {
	height: 100%;
	border: 1px solid silver;
}

fieldset legend {
	font-weight: bold;
}

.droppable {
	width: 150px;
	cursor: pointer;
	height: 30px;
	padding: 0.5em;
	margin: 5px;
	border: 1px dashed black;
}

.droppable.highlight {
	background: orange;
}
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
</style>
</head>
<body>
	<script type="text/javascript">
		var isMain = true;
		var curEditEl = editor.editdom;
		window.onload = function() {
			//加载树
			loadTree(editor, curEditEl);
			//初始化公式
			init();
		}

		function init() {
			var curEl = $(curEditEl);
			var options = curEl.attr("data-options") || "{}";
			var json = mini.decode(options);
			var setting = json.datecalc;
			var obj = $("#condition");
			obj.val(setting);
		}

		function loadTree(editor, el) {
			var data = getMetaData(editor, el);
			var treeObj = mini.get("fieldTree");
			treeObj.loadList(data.aryData);
		}

		function getMetaData(editor, el) {
			var container = $(editor.getContent());
			var elObj = $(el);
			var grid = elObj.closest(".rx-grid");
			isMain = grid.length == 0;
			var aryJson = [];
			var root = {
				id : "root_",
				text : "根节点",
				table_ : false,
				main : false,
				expanded : true
			};

			aryJson.push(root);
			if (isMain) {
				var els = $(
						"[plugins]:not(div.rx-grid [plugins])",
						container);
				els.each(function() {
					var obj = $(this);
					var label = obj.attr("label");
					var name = obj.attr("name");
					var fieldObj = {
						id : name,
						text : label,
						table_ : false,
						main : true,
						pid : "root_"
					};
					aryJson.push(fieldObj);
				});
			} else {
				$("[plugins]", grid).each(function() {
					var obj = $(this);
					var label = obj.attr("label");
					var name = obj.attr("name");
					var fieldObj = {
						id : name,
						text : label,
						table_ : false,
						main : false,
						pid : "root_"
					};
					aryJson.push(fieldObj);
				});
			}
			var obj = {
				aryData : aryJson,
				el : el
			};
			return obj;

		}

		function fieldClick(e) {
			var node = e.node;
			if (node.id == "root_")
				return;

			var obj = $("#condition");
			obj.val(obj.val()+"{"+node.id+"}");
		}

		dialog.onok = function() {
			var curEl = $(curEditEl);
			var options = curEl.attr("data-options") || "{}";
			var json = mini.decode(options);
			json.datecalc = $("#condition").val();
			curEl.attr("data-options", mini.encode(json));
		}

		dialog.oncancel = function() {
			var curEl = $(curEditEl);
			curEl.removeAttr("data-options");
		}
	</script>
	<table style="width: 100%; height: 100%;">
		<tr style="height: 40%;">
			<td width="30%" style="vertical-align: top;">
				<fieldset>
					<legend>表单字段</legend>
					<ul id="fieldTree" class="mini-tree" onnodeclick="fieldClick"
						style="width: 100%; padding: 5px; height: 175px;"
						showTreeIcon="true" resultAsTree="false" allowDrag="true">
					</ul>
				</fieldset>
			</td>
			<td style="vertical-align: top;">
				<fieldset style="height: 180px;">
					<legend>日期计算设置</legend>
					<div class="operatorContainer">
						<div operator="+">+</div>
						<div operator="-">-</div>
						<div operator="*">*</div>
						<div operator="/">/</div>
						<div operator="()">()</div>
						<div operator=".subtract(,)">两个日期相减</div>
						<div operator=".addDate(,)">两个日期相加</div>
						<div operator=".sub(,)">减日期时间</div>
						<div operator=".add(,)">加日期时间</div>
					</div>
				</fieldset>
				<fieldset style="height: 180px;">
					<legend>脚本运算</legend>
					<textarea id="condition" style="width:100%;height:180px"></textarea>
				</fieldset>
			</td>
		</tr>
	</table>
	<div style="display: none" id="formulaHelp"></div>
	<script type="text/javascript">
		mini.parse();
		$(function(){
			handOperator("condition");
		})
		function handOperator(targetId){
			$("div.operatorContainer div").click(function(e){
				var obj=$(this);
				insert(obj.attr("operator"),targetId)
			})
		}
		function insert(content,targetId){
			var formulaObj=document.getElementById(targetId);
			$.insertText(formulaObj,content);
		}
	</script>
</body>
</html>