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
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/common/util.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<script src="<#noparse>${ctxPath}</#noparse>/scripts/sys/customform/customlist.js?version=<#noparse>${version}</#noparse>" type="text/javascript"></script>
	<link href="<#noparse>${ctxPath}</#noparse>/styles/commons.css?version=<#noparse>${version}</#noparse>" rel="stylesheet" type="text/css" />


	<#function getUrl sysBoList>
		<#if sysBoList.url??>
			<#assign rtn>${sysBoList.url}</#assign>
		<#else>
			<#assign rtn><#noparse>${ctxPath}</#noparse>/dev/cus/customData/${sysBoList.key}/getData.do</#assign>
		</#if>
		 <#return rtn>
	</#function>
	<#-- 构建外部传入参数 -->
	<#noparse>
		<#assign query="">
		<#if params??&&(params?size>0)>
			<#assign query="?">
			<#assign  keys=params?keys/>
			<#list keys as key>
				<#if (key_index==0)>
					<#assign query=query + key +"=" + params[key] >
				<#else>
					<#assign query=query +"&" +key +"=" + params[key] >
				</#if>
			</#list>
		</#if>
	</#noparse>
</head>
<body >
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
 	<#if isDialog=="YES">
		<div region="south" showSplit="false" showHeader="false" height="46" showSplitIcon="false">
			<div class="southBtn">
			   	<a class="mini-button"    onclick="CloseWindow('ok');">确定</a>
		    	<a class="mini-button btn-red"    onclick="CloseWindow();">取消</a>
			</div>
		 </div>
	</#if>
 	<#if isLeftTree=="YES">
	    <div showHeader="true"
			 title="${leftNav}" region="west"
			 width="220" maxWidth="250" minWidth="150"
			 showCollapseButton="false" showProxy="false" expanded="true" showSplitIcon="true"
		>
	        <div class="mini-fit ">
		        <div id="tabs1" class="mini-tabs"
					 tabAlign="left" tabPosition="bottom"
					 activeIndex="0" style="100%;height:100%;"
					 bodyStyle="background-color:white;border:none;"
					 plain="false"
				>
				    <#list treeConfigs as treeConfig>
					    <div title="${treeConfig.tabName}" >
					         <ul id="${treeConfig.treeId}" class="mini-tree"
							 	 url="<#noparse>${ctxPath}</#noparse>/dev/cus/customData/${sysBoList.key}/${treeConfig.treeId}/getTabTreeJson.do<#noparse>${query}</#noparse>"
								 style="width:100%;"
								 parentField="${treeConfig.parentField}"
								 textField="${treeConfig.textField}"
								 idField="${treeConfig.idField}"
								 expandOnLoad="${treeConfig.expandOnLoad}"
								 resultAsTree="false" showTreeIcon="true"
								 onnodeclick="${treeConfig.onnodeclick}">
				             </ul>
					    </div>
				    </#list>
				</div>
			</div>
	    </div>
     </#if>
      <#noparse>
	    <#if params?? && params.single?? && params.single=="false">
				<div region="east" title="选中列表" width="250" showHeader="false" showCollapseButton="false">
					<div class="treeToolBar">
						<a class="mini-button btn-red" onclick="removeSelected">移除</a>
						<a class="mini-button" onclick="clearSelected">清空所有</a>
					</div>
					<div class="mini-fit">
						<div
							id="selectedGrid"
							class="mini-datagrid yangxin2"
							style="width: 100%; height: 100%;"
							allowResize="false" url=""
							idField="userId"
							multiSelect="true"
							showColumnsMenu="true"
							allowAlternating="true"
							showPager="false"
							onrowdblclick="removeSel(e)"
						>
	</#noparse>
								${dialgColumns}
	<#noparse>
						</div>
					</div>
				</div>
		</#if>
	</#noparse>
      <div region="center" <#if isLeftTree=="YES"> showHeader="false"  </#if> title="${name}" showCollapseButton="false" >
     	<div class="mini-toolbar">
				<div class="searchBox">
					<#if searchHtml!="">
					<div id="searchForm" class="search-form" >
                    	${searchHtml}
                    </div>
                    </#if>
				</div>
				<ul class="toolBtnBox">
					<#list topButtonJson as item>
					<li>
						<#if item.url??>
							<#noparse><#if (SysBoListUtil.isAllowBtn</#noparse>('${item.url}')=="YES")<#noparse>></#noparse>
						</#if>
						<#if item.children?exists && (item.children?size >0)>
						<#list item.children as menu>
						<#if menu.url??>
							<#noparse><#if (SysBoListUtil.isAllowBtn</#noparse>('${menu.url}')=="YES")<#noparse>></#noparse>
						</#if>
						<ul id="${item.btnName}Menu" class="mini-menu" style="display:none;">
							<li  <#if menu.url??>data-options="{url:'${menu.url}'}" </#if> onclick="${menu.btnClick}">${menu.btnLabel}</li>
						</ul>
						<a id="${item.btnName}" class="mini-menubutton"    menu="#${item.btnName}Menu">${item.btnLabel}</a>
						<#if menu.url??>
						<#noparse></#if></#noparse>
					</#if>
					</#list>
					<#else>
						<a id="${item.btnName}" class="mini-button <#if item.btnClass??>${item.btnClass}</#if>" <#if item.url??>data-options="{url:'${item.url}'}" </#if>   onclick="${item.btnClick}">${item.btnLabel}</a>
						</#if>
						<#if item.url??>
						<#noparse></#if></#noparse>
					</#if>
					</li>
					</#list>
					<li id="rapidSearchForm">
						${rapidSearchHtml}
					</li>
					<#if (rapidSerchJson?size>0)>
						<li><a class="mini-button"   onclick="onRapidSearch()">搜索</a></li>
					</#if>
				</ul>
				<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
	     </div>
     	<div class="mini-fit">
	        <div id="${sysBoList.key}Grid" class="${controlClass} <#if IsChildren??>moreHeader</#if>" style="width: 100%; height: 100%;" allowResize="false" allowResize="false" expandOnLoad="true"
	        	url="<#noparse>${ctxPath}</#noparse>/dev/cus/customData/${sysBoList.key}/getData.do<#noparse>${query}</#noparse>" idField="${sysBoList.idField}"
	        	<#noparse>
		        	<#if params?? && params.single?? && params.single=="false">
		        		multiSelect="${(params.single=="true")?string('false','true')}" onselect="select(e)"
		        	<#elseif params.single=="true">
		        		multiSelect = false
		        	<#else>
		        </#noparse>
		        		multiSelect="${sysBoList.multiSelect}"
		        <#noparse>
		        	</#if>
	        	</#noparse>
	        	<#if showFroCol=="true">
	        		frozenStartColumn="${sysBoList.startFroCol}" frozenEndColumn="${sysBoList.endFroCol}"
	        	</#if>
	        	<#if sysBoList.showSummaryRow=="YES">
	        	showSummaryRow="true"
	        	</#if>
	        	showColumnsMenu="true" parentField="${sysBoList.parentField}" treeColumn="${sysBoList.textField}"
	        	showTreeIcon="true" resultAsTree="false"
	        	<#if sysBoList.rowEdit=="YES">
	        		allowCellEdit="true" allowCellSelect="true"
	        		allowCellValid="true" oncellvalidation="onCellValidation"
	        	</#if>
	        	sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
						${gridColumns}
			</div>

		</div>
    </div>
</div>
<script type="text/javascript">
	var sysBoList={
		formAlias:"${sysBoList.formAlias}",
		formDetailAlias:"${sysBoList.formDetailAlias}",
		rowEdit:"${sysBoList.rowEdit}",
		name:"${sysBoList.name}",
		dataStyle:"${sysBoList.dataStyle}",
		idField:"${sysBoList.idField}",
		parentField:"${sysBoList.parentField}",
		key:"${sysBoList.key}"
	};

	var single=${sysBoList.multiSelect};
	<#noparse>
    	<#if params?? && params.single??>
    		single=${params.single};
    	</#if>
    </#noparse>

        mini.parse();
		var grid=mini.get('${sysBoList.key}Grid');
		grid.on("rowdblclick",onRowDbClick);

		<#if isInitData=="true">grid.load();</#if>
		<#if isLeftTree=="YES">
		 <#list treeConfigs as treeConfig>
		 	 <#if treeConfig.onnodeclick !='' >
			 	function ${treeConfig.onnodeclick}(e){
			 		handTreeClick(e,'${treeConfig.paramName}','${treeConfig.idField}');
			 	}
			</#if>
		 </#list>
		</#if>

		<#if sysBoList.bodyScript??>
			${sysBoList.bodyScript}
		</#if>

		//---------------开始生成服务器自定义按钮-------------
		 	<#list topButtonJson as item>
         		<#if item.scriptButton??>
	         		function ${item.btnClick}(e){
	         			handButtonClick(e);
	         		}
         		</#if>
	        </#list>
		 //-------------结束生成服务器自定义按钮-------------

		 grid.on("drawcell", function (e) {
		   var record = e.record,
		   field = e.field,
		   value = e.value;
            <#list urlColumns as col>
             if (field== "${col.field}") {
	             var url=getUrlFromRecord('${col.url}',record);
	             if(value){
	             	e.cellHtml='<a href="javascript:void(0);" onclick="showLink(\''+value+'\',\'${col.field}\',\''+url+'\',\'${col.urlType}\',\'${sysBoList.formAlias}\');">'+value+'</a>';
	             }
             }
            </#list>

            ${drawCellScript}
		 });
</script>
</body>
</html>