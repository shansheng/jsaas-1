<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <title>设计表单</title>
        <%@include file="/commons/edit.jsp"%>
		<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/ueditor-fd-config.js"></script>
		<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/ueditor-fd.all.js"> </script>
		<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>
		<!-- 引入表单控件 -->
		<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/ueditor-form-design.js"></script>
		<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/form-design/design-plugin.js"></script>
		<link href="${ctxPath}/scripts/form/tab/css/tab.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript"  src="${ctxPath}/scripts/form/tab/PageTab.js"></script>
		<script type="text/javascript"  src="${ctxPath}/scripts/form/tab/FormContainer.js"></script>
		<script type="text/javascript"  src="${ctxPath}/scripts/flow/form/bpmFormView.js"></script>
		<script type="text/javascript"  src="${ctxPath}/scripts/flow/form/bpmFormViewTab.js"></script>
		<script type="text/javascript"  src="${ctxPath}/scripts/flow/form/bpmFormViewDesign.js"></script>
		<style>
			.column_2 ul li{
				float: left;
			}
			.table-detail .mini-textbox{
				width: 150px
			}
			
			.mini-tree-icon{
				padding-top: 8px;
			}
		</style>
    </head>
    <body  > 
    
		<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		   <div region="north"  showHeader="false" height="105">
					<div class="topToolBar">
						<div>
							<a class="mini-button"  plain="true" onclick="reinitialization(${boDefId})">重新生成表单</a>
							<a class="mini-button"  plain="true" onclick="saveFormView">保存</a>
							<a class="mini-button"  plain="true" onclick="preview()">预览</a> 
						</div>
					</div>
					<table id="form1" class="table-detail column_2" cellspacing="0" cellpadding="0"  action="${ctxPath}/bpm/form/bpmFormView/saveDesignForm.do">
						<tr>
							<td style="width:8%">
								<span class="starBox">
									分　　类  <span class="star">*</span>
								</span>
							</td>
							<td style="width:12%">
								<input id="pkId" name="viewId" class="mini-hidden" value="" />
								<input   name="boDefId" class="mini-hidden" value="${boDefId}" />
								 <input  id="treeId"  name="treeId"  class="mini-treeselect" 
								 	url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_FORM_VIEW" 
								 	multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  
								 	required="true" pinyinField="right" showFolderCheckBox="false"  
							        expandOnLoad="true"   showClose="true"  oncloseclick="onClearTree" 
							        popupWidth="300"  style="width:92%"
						        />
							</td>
							<td style="width:8%"> 
								<span class="starBox">
									名　　称 <span class="star">*</span>
								</span>
							</td>
							<td style="width:14%">
								<input  name="name"  value="${boDefName}"  class="mini-textbox"  vtype="maxLength:255"  style="width:92%"  required="true"  emptyText="请输入名称"  />
							</td>
							<td style="width:8%">标   识   键 <span class="star">*</span></td>
							<td style="width:12%">
								<input  name="key"  value="${alais}"  class="mini-textbox"  vtype="key,maxLength:100"  style="width:92%"  required="true"  emptyText="请输入标识键"  />
							</td>
							<td style="width:8%">展示模式 </td>
							<td style="width:15%">
								<input name="type" class="mini-hidden"   value="GENBYBO" />
								<div   name="displayType"  id="displayType"  class="mini-radiobuttonlist"  	textField="text"  valueField="id" 
			 						data="[{'id':'first','text':'展示首tab'},{'id':'normal','text':'默认模式'}]"  value="normal" ></div>
							</td>
							<td style="widows: 15%">
								生成表单方案 &nbsp;<input name="isCreate" class="mini-checkbox" value="true" />
							</td>
						</tr>
					</table>
		   </div>
		    <div  title="业务模型数据结构"  region="west"  width="220"  showSplitIcon="true" showCollapseButton="true">
		         <ul id="systree" 
					url="${ctxPath}/sys/bo/sysBoDef/getBoDefConstruct.do?boDefId=${boDefId}" 
					class="mini-tree"  style="width:100%;height: 100%;"  showTreeIcon="true" 
					textField="comment"  idField="name"  resultAsTree="true" expandOnLoad="true" onnodeclick="treeNodeClick"   ></ul>
		    </div>
		    <div showHeader="false" showCollapseButton="false" region="center" bodyStyle="padding:0;margin:0">
				<script id="templateView" name="templateView" type="text/plain"></script>
				<div id="pageTabContainer"></div>
			</div>
		</div>
       <script type="text/javascript">
		var boDefId='${boDefId}';
		var color='${color}';
		var viewId='${viewId}';
		var genTab='${param.genTab}';
		var templates='${templates}';
		var templateView = UE.getEditor('templateView',{
			initialFrameWidth:'99.8%'
		});

		templateView.ready(function() {
			if(!viewId){
				generateHtml(genTab,boDefId,templates,color);
			}else if(viewId && !templates){
				getFormViewById(viewId)
			}else{
				getFormViewByIdAgain(viewId,genTab,boDefId,templates,color);
			}

			templateView.setHeight($("body").height()-246);
		});
		mini.parse();

		var choiceSysTreeId='${choiceSysTreeId}';
		var treeId = mini.get('#treeId');
		treeId.setValue(choiceSysTreeId)

		var layout=mini.get('layout1');
		
		 $(window).resize(function(){
			 setTimeout(function(){
					templateView.setHeight($("body").height()-246);
			 },500);
		 });
	   </script>
    </body>
</html>