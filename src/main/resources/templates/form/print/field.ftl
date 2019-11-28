<#function getPre pre>
 	<#assign rtn><#if pre=="">data.<#elseif pre="item_">item.<#else>data.SUB_${pre}.</#if></#assign>
 	
	<#return rtn>
</#function>

<#macro getField attr pre>
	<#switch attr.control>
		<#case "upload-panel">
			<#noparse>${util.displayFile(</#noparse>${getPre(pre)}${attr.name}<#noparse>)}</#noparse>
		<#break>
		<#case "mini-office">
			<#noparse>${util.displayOffice(</#noparse>${getPre(pre)}${attr.name}<#noparse>)}</#noparse>
		<#break>
		<#case "mini-img">
			<#noparse>${util.displayImg(</#noparse>${getPre(pre)}${attr.name}<#noparse>)}</#noparse>
		<#break>
		<#case "mini-datepicker">
			<#noparse>${util.displayDate(</#noparse>${getPre(pre)}${attr.name}<#noparse>)}</#noparse>
		<#break>
		
		
		<#default>
			<#if (attr.isSingle==1)>
				<#noparse>${</#noparse>${getPre(pre)}${attr.name}<#noparse>}</#noparse>
			<#else>
				<#noparse>${</#noparse>${getPre(pre)}${attr.name}_name<#noparse>}</#noparse>
			</#if>
	</#switch>
	
</#macro>
