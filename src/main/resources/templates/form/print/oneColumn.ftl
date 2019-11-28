<div class="sperator"></div>
<table class="table-detail column-two blue">
      	<caption>${ent.comment}</caption>
		<#list ent.sysBoAttrs as attr>	
			<tr>		
				<td>${attr.comment}</td>
				<td>
					<@getField attr=attr pre="" />
				</td>	
			</tr>	
		</#list>
</table>