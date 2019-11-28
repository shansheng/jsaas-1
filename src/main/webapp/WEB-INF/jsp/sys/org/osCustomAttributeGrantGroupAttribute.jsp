<%-- 
    Document   : [自定义属性]列表页
    Created on : 2017-12-14 14:02:29
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>属性列表</title>
<%@include file="/commons/list.jsp"%>
<style>
.mini-splitter-handler{
	display: block;
}
.toolbox-li{
	display: flex;
	margin-top: 10px;
}
.toolbox-span{
	width: 120px;
	display: inline-block;
	line-height: 30px;
	text-align: right;
}
</style>
</head>
<body>
<div class="topToolBar">
	<div>
		<a class="mini-button"  onclick="saveAttributes">保存</a>
	</div>
</div>
    <!-- <div class="mini-splitter" id="minispliter" vertical="true" style="width:100%;height:100%"> -->
    <div class="mini-toolbar" >
		<div class="form-toolBox">
			 <ul>
				 <li><span>分类:</span>
					 <input class="mini-treeselect"
							url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE"
							parentField="parentId"  valueField="treeId" textField="name" onnodeclick="treeNodeClick"/></li>
				<li><a class="mini-button"  plain="true" onclick="addAllToForm()">加载</a></li>
			 </ul>
		</div>
     </div>
<div class="mini-fit">
<div class="mini-layout" title="用户属性管理" id="minispliter" activeIndex="0" style="width:100%;height:100%">
	<div>
	   	<div id="p1" class="form-outer">
			<form id="form1" method="post">
				<input id="targetId" name="targetId" class="mini-hidden" value="${targetId}" />
					<div class="form-inner">
					<ul id="dataBox">
						<c:forEach items="${osCustomAttributes}" var="attr">
							<li class="toolbox-li" id="tr_attr_${attr.ID}">
								<span class="toolbox-span">${attr.attributeName}：</span>
								<div style="flex:1;">
									<c:if test="${attr.widgetType=='textbox'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-textbox" value="${attr.value}"  style="display: inline-block;vertical-align:middle;"/></c:if>
									<c:if test="${attr.widgetType=='spinner'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-spinner"  value="${attr.value}"  style="display: inline-block;vertical-align:middle;"/></c:if>
									<c:if test="${attr.widgetType=='datepicker'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-datepicker"  value="${attr.value}" style="display: inline-block;vertical-align:middle;"/></c:if>
									<c:if test="${attr.widgetType=='combobox'}">
											<c:set value="${attr.valueSource}" var="valuesource"></c:set>
											<c:set value="${attr.sourceType}" var="sourceType"></c:set>
											<script>
												var jsonAttr = '${valuesource}';
												var key = '${sourceType}';
												jsonAttr = JSON.parse(jsonAttr);
												if(key == 'URL'){
													document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-combobox" style="width: 150px;" textField="'+jsonAttr[0].key+'" valueField="'+jsonAttr[0].value+'" url="'+'${ctxPath}'+jsonAttr[0].URL+'" value="${attr.value}" showNullItem="true" allowInput="true" style="display: inline-block;vertical-align:middle;"/>');
												}else if(key == 'CUSTOM'){
													var id = "widgetType_${attr.ID}";
													document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" textField="text" valueField="id"  class="mini-combobox" data="" value="${attr.value}" style="display: inline-block;vertical-align:middle;"/>');
													mini.parse();
													mini.get(id).setData('${attr.valueSource}');
												}
											</script>
										</c:if>
										<c:if test="${attr.widgetType=='radiobuttonlist'}">
											<c:set value="${attr.valueSource}" var="valuesource"></c:set>
											<c:set value="${attr.sourceType}" var="sourceType"></c:set>
											<script>
												var jsonAttr = '${valuesource}';
												var key = '${sourceType}';
												if(key == 'URL'){
													jsonAttr = JSON.parse(jsonAttr);
													document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-radiobuttonlist" style="width: auto" repeatItems="4" repeatLayout="table" textField="'+jsonAttr[0].key+'" valueField="'+jsonAttr[0].value+'" value="${attr.value}" url="'+'${ctxPath}'+jsonAttr[0].URL+'" style="display: inline-block;vertical-align:middle;"/>');
												}else if(key == 'CUSTOM'){
													var id = "widgetType_${attr.ID}";
													document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-radiobuttonlist" style="width: auto" repeatItems="4" repeatLayout="table" textField="text" valueField="id" data="" value="${attr.value}" style="display: inline-block;vertical-align:middle;"/>');
													mini.parse();
													mini.get(id).setData('${attr.valueSource}');
												}
											</script>
										</c:if>
									 <%-- <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="removeTr('tr_attr_${attr.ID}')">删除</a> --%>
									 <a class="mini-button btn-red"  plain="true" onclick="removeTr('tr_attr_${attr.ID}')" style="margin-left:10px;">删除</a>
								</div>
							</li>
						 </c:forEach>
					</ul>
				 </div>
			 </form>
	  	</div>
	</div>
</div>
</div>
	<script type="text/javascript">
		mini.parse();
		
		var spliter=mini.get("minispliter");
		var form=new mini.Form("#form1");
		var ary;
	
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="加入" onclick="joinRowIntoForm(\'' + pkId + '\')">加入</span>';
			return s;
		}
		
		
		function treeNodeClick(e){
			var node=e.node;
			var treeId=node.treeId;
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/org/osCustomAttribute/getAttrsByTreeId.do",
				data:{type:'${attributeType}',treeId:treeId},
				success:function (data) {
					ary = data.data;
				}
			});
		}
		
		
		function removeTr(id){
			$("#"+id).remove();
		}
		function saveAttributes(){
			$.ajax({
				url:__rootPath+'/sys/org/osAttributeValue/saveTargetAttributes.do',
				type:'post',
				data:form.getData(),
				success:function (result){
					CloseWindow('ok');
				}
			});
		}
		function joinRowIntoForm(attribute){
			var EL=$("#widgetType_"+attribute.id);
			if(!EL.length>0){
				var extendField;
				// 控件名
				var btn_name = attribute.widgetType;
				// 类别
				var sourceType = attribute.sourceType;
				if(sourceType == 'URL'){
					var jsonAttr = attribute.valueSource;
					jsonAttr = JSON.parse(jsonAttr);
					$("#dataBox").prepend('<li class="toolbox-li" id="tr_attr_'+attribute.id+'">'
							+'<span class="toolbox-span">'+attribute.attributeName+'：</span>'
							+'<div style="flex:1;"><input class="mini-'+attribute.widgetType+'"  textField="'+jsonAttr[0].key+'" valueField="'+jsonAttr[0].value+'" url="'+'${ctxPath}'+jsonAttr[0].URL+'"  id="widgetType_'+attribute.id+'" name="widgetType_'+attribute.id+'"   style="display: inline-block;vertical-align:middle;"/>'
							+'<a class="mini-button btn-red"  plain="true" onclick="removeTr(\'tr_attr_'+attribute.id+'\')" style="margin-left:10px;">删除</a>'
							+'</div></li>');
					
				}else{
					$("#dataBox").prepend('<li class="toolbox-li" id="tr_attr_'+attribute.id+'">'
							+'<span class="toolbox-span">'+attribute.attributeName+'：</span>'
							+'<div style="flex:1;"><input  class="mini-'+attribute.widgetType+'"  textField="text" valueField="id"  id="widgetType_'+attribute.id+'" name="widgetType_'+attribute.id+'"   style="display: inline-block;vertical-align:middle;"/>'
							+'<a class="mini-button btn-red"  plain="true" onclick="removeTr(\'tr_attr_'+attribute.id+'\')" style="margin-left:10px;">删除</a>'
							+'</div></li>');
					mini.parse();
					var plugin=mini.get("widgetType_"+attribute.id);
					if(attribute.widgetType=='combobox'||attribute.widgetType=='radiobuttonlist'){
						plugin.setData(attribute.valueSource);
					}
				}
				
			}else{
				//已经存在
			}
			
		} 
		/*逐个添加到表单内*/
		function addToForm(){
			var list=grid.getSelecteds();
			for(var i=0;i<list.length;i++){
				joinRowIntoForm(list[i].id);
			}
		}
		
		function addAllToForm(){
			if(!ary)return;
			for(var i=0;i<ary.length;i++){
				joinRowIntoForm(ary[i]);
			}
		}

	</script>
	
</body>
</html>