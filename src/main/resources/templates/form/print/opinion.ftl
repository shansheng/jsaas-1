<table class="table-detail column-two blue">
		<#list opinions as opinion>	
		<tr>		
			<td>${opinion.label}</td>
			<td ><#noparse>${render(opinion.</#noparse>${opinion.name})}</td>		
		</tr>
		</#list>
</table>


