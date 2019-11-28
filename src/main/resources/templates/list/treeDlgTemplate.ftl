 <!DOCTYPE html >
<html >
<head>
    <title></title>	
	<script type="text/javascript">
		var __rootPath='<#noparse>${ctxPath}</#noparse>';
		var __version='<#noparse>${version}</#noparse>';
	</script>
	<link href="<#noparse>${ctxPath}</#noparse>/styles/list.css?version=<#noparse>${version}</#noparse>" rel="stylesheet" type="text/css" />
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/mini/boot.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/share.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/common/list.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/common/form.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<link href="<#noparse>${ctxPath}</#noparse>/styles/commons.css?version=<#noparse>${version}</#noparse>" rel="stylesheet" type="text/css" />
	
</head>
<body>

<div class="topToolBar">
	<div>
			 <a class="mini-button"  plain="true" onclick="onExpand()">展开</a>
			 <a class="mini-button" plain="true" onclick="onCollapse()">收起</a>
             <a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
	</div>
</div> 
<div class="mini-fit">
 	<ul id="tree1" class="mini-tree" url="<#noparse>${ctxPath}</#noparse>/dev/cus/customData/${sysBoList.key}/getTreeJson.do" style="width:100%;height:100%;" 
        showTreeIcon="true" textField="${textField}" idField="${idField}" parentField="${parentField}" resultAsTree="false" expandOnLoad="true"
        <#if onlySelLeaf=='YES'>
         onbeforenodeselect="onBeforeNodeSelect" 
        </#if>
        <#noparse>
        	<#if params?? && params.single?? && (params.single=='false')>
     			showCheckBox="true"
     	</#noparse>
     	<#noparse>
     		<#else>
     	</#noparse>
     	    	<#if allowCheck=='true'>
	        		showCheckBox="true"
	        	</#if>
	    <#noparse>
     		</#if>
     	</#noparse>
        showArrow="true">
    </ul>
</div>

<div class="bottom-toolbar">
    <a class="mini-button"  onclick="CloseWindow('ok')">确定</a>
    <a class="mini-button btn-red"  onclick="CloseWindow('cancel')">取消</a>
</div>

<script type="text/javascript">
	mini.parse();
	
	var tree=mini.get('tree1');
	
	function getData(){
		var single=${allowCheck};
		<#noparse>
			<#if params??>
        	<#if params.single??>
        		single=${params.single};
        	</#if>
        	</#if>
        </#noparse>
	
		var rows=[];
		
		<#noparse>
		     <#if params?? && params.single??>
		     	<#if params.single=='true'>
					row=tree.getSelectedNode();
					rows.push(row);
				<#else>
					rows=tree.getCheckedNodes(false);
				</#if>
		</#noparse>
		<#noparse>
		     <#else>
		</#noparse>
				<#if allowCheck=='true'>
					rows=tree.getCheckedNodes(false);
				<#else>
					row=tree.getSelectedNode();
					rows.push(row);
				</#if>
		<#noparse>
		    </#if>
		</#noparse>
		var data={rows:rows,single:single};
		return data;
	}
	
	function onExpand(){
   		tree.expandAll();
   	}
   	
   	function onCollapse(){
   		tree.collapseAll();
   	}
	
	function refreshSysTree(){
   		tree.load();
   	}
   	
   	 function onBeforeNodeSelect(e) {
        
        var tree = e.sender;
        var node = e.node;
        if (tree.hasChildren(node)) {
            e.cancel = true;
        }
    }
</script>
</body>
</html>