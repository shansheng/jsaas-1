<div id="chartContainer_${key}" style="width:100%;height:100%;padding:0;" 
	<#if dashboard??>class="colId_${colId} modularBox" colId="${colId}"<#else>class="colId_${r'${colId}'} modularBox" colId="${r'${colId}'}"</#if> 
	key="${key}" alias="${alias}" eType="${chartType}" <#if dashboard??>dashboard="${dashboard}"</#if>>
	<div id="fit_${key}" class="mini-fit"></div>
</div>