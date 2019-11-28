<div class="table-container" relationtype="onetoone" tablename="${ent.name}">
	<table class="table-detail column-two blue" >
		<caption>${ent.comment}</caption>
		
		<#list ent.sysBoAttrs as attr>
		<tr >		
						
				<td >${attr.comment}</td>
				<td >
					<@getField attr=attr pre=ent.name />
				</td>		
			
		</tr>
		</#list>			
		
	</table>
</div>