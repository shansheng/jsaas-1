<%@page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>WORD表单设计</title>
	<%@include file="/commons/edit.jsp"%>
	<script type="text/javascript">
		var pkId = '${sysWordTemplate.id}';
		var templateId = '${sysWordTemplate.templateId}';
		var bookMarkIndex;//保存当前文档中书签的总数
		var i=0;
		
		function treeNodeClick (e) {
			var node = e.node;
			var comment = node.comment;  //中文
			var field = node.field;  	 //英文
			var isField = node.isField;
			var type = node.type;
			if(!isField) return;
			
			var ctl=OfficeControls.getControl("office").getCtl();
			var doc = ctl.ActiveDocument;
			var sel = doc.Application.Selection.Range;
			
			var isChecked = mini.get("checkName").checked;
			if (isChecked) { //选中，保存字段用于模板标签传值，取值标签 ${fieldName}
				sel.Text = comment;
			} 
			//没选中，保存字段仅是说明字段
			else {
				//获取文本书签数目
				if (!bookMarkIndex){
					bookMarkIndex = doc.Bookmarks.Count;
				}  
				if(type=="main"){
					var fieldName = "main_1_" + field+'_1_'+bookMarkIndex; 
					sel.Text = "{" + comment + "}";
					doc.Bookmarks.Add(fieldName, sel); 
					bookMarkIndex++;
				} 
				else if(type=="onetoone"){
					var tableName = node.tableName;
					var fieldName = "oo_1_" + tableName+'_1_'+field +"_1_" + bookMarkIndex;
					sel.Text = "{" + comment + "}";
					doc.Bookmarks.Add(fieldName, sel); 
					bookMarkIndex++;
				}
				else if(type=="onetomany"){
					var tableName = node.tableName;
					sel.Text = "om#" + tableName+'#'+field +"#" + i;
					i++;
				}
			}
			return false;
	  	}
	  	
	  
	  	function saveTemplate(){
	  		OfficeControls.save(function(){
	  			var officeId = mini.get("officeId").getValue();
				var officeObj = JSON.parse(officeId);
				var config = {
					url : "${ctxPath}/sys/core/sysWordTemplate/updTemplateId.do?pkId="+pkId+"&templateId="+officeObj.id,
					method : 'POST',
					success : function() { }
				}
				_SubmitJson(config);
				CloseWindow('ok');
	  		});
	  	}
	  	
	</script>
</head>

<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button" onclick="saveTemplate" id="saveId" >保存</a>
		</div>
	</div>


<div class="mini-fit">
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	    <div  title="表字段分类"  region="west" showSplitIcon="true" showCollapseButton="false" showProxy="false" class="layout-border-r">
	        <div id="toolbar1" class="form-toolBox" style="padding:2px; border-top:0;border-left:0;border-right:0; ">
		       	<span>表字段 </span>
		       	<div id="checkName" name="checkName" class="mini-checkbox"  text="表字段描述" ></div>
			</div>
	        <div class="mini-fit">
	            <ul 
		            id="tree1" 
		            class="mini-tree" 
		            url="${ctxPath}/sys/core/sysWordTemplate/getTableInfo.do?pkId=${sysWordTemplate.id}", 
		            style="width:100%;height: 100%;" 
		            showTreeIcon="true"
		            textField="comment"
		            idField="field"
		            resultAsTree="true"
		            expandOnLoad="true"
		            onnodeclick="treeNodeClick"  
	            >        
	            </ul>
	        </div>
	    </div>
	    <div region="center" showHeader="false" showCollapseButton="false">
			<div class="mini-fit">
				<c:set var="templateId" value="${sysWordTemplate.templateId }"></c:set>
				<div  class="mini-office" style="height:100%;width:100%" readonly="false" version="false" name="office" id="officeId"
					<c:if test="${not empty templateId}">value="{type:'docx',id:'${templateId}'}"</c:if> >
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>