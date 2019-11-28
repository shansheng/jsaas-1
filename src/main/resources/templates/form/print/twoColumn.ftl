<div class="sperator"></div>
<table class="table-detail column-four blue">
	<caption>${ent.comment}</caption>
	<#assign index=0>
	<#list ent.sysBoAttrs as attr>	
			<#if index % 2 == 0>
			<tr>
			</#if>
				<td>${attr.comment}</td>
				<td>
					<@getField attr=attr pre="" />
				</td>
				<#if index % 2 == 0 && !attr_has_next>
					<td></td>
					<td></td>
				</#if>
			<#if index % 2 == 1 || !attr_has_next>
			</tr>
			</#if>
			<#assign index=index+1>
	</#list>
</table>