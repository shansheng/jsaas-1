<!DOCTYPE html >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${name}</title>
	<script type="text/javascript">
		var __rootPath='<#noparse>${ctxPath}</#noparse>';
		var __version='<#noparse>${version}</#noparse>';
	</script>
	<link href="<#noparse>${ctxPath}</#noparse>/styles/skin/default/index.css?version=<#noparse>${version}</#noparse>" rel="stylesheet" type="text/css" /> 
	
	<link href="<#noparse>${ctxPath}</#noparse>/styles/list.css?version=<#noparse>${version}</#noparse>" rel="stylesheet" type="text/css" />
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/mini/boot.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/mini/pagertree.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/share.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<link href="<#noparse>${ctxPath}</#noparse>/styles/skin/default/index.css?version=<#noparse>${version}</#noparse>" rel="stylesheet" type="text/css" /> 
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/common/form.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/common/list.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/sys/customform/customlist.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<link href="<#noparse>${ctxPath}</#noparse>/styles/commons.css?version=<#noparse>${version}</#noparse>" rel="stylesheet" type="text/css" />
	
</head>
<body >   
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
      <div region="center" title="${name}" showCollapseButton="false" >
     	<div class="mini-toolbar">
				<div class="searchBox">
					<div id="searchForm" class="search-form" >
                    	${searchHtml}
                    </div>
				</div>
	     </div>
     	<div class="mini-fit rx-grid-fit">
     	
	        <div id="${sysEsList.alias}Grid" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" allowResize="false" expandOnLoad="true"
	        	url="${ctxPath}/sys/core/sysEsList/${sysEsList.alias}/getData.do" 
		        multiSelect = false
	        	showColumnsMenu="true"
	        	<#if sysEsList.isPage==1> showPager="true"  </#if>
	        	<#if sysEsList.isPage!=1> showPager="false"  </#if>
	        	showTreeIcon="true" resultAsTree="false"  
	        	sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
						${gridColumns}
			</div>
		
		</div>
    </div>
</div>
<script type="text/javascript">
	var sysEsList={
		name:"${sysEsList.name}",
		key:"${sysEsList.alias}"
	};
	
        mini.parse();
		var grid=mini.get('${sysEsList.alias}Grid');
		grid.on("rowdblclick",onRowDbClick);
		
		grid.load();
		
</script>
</body>
</html>