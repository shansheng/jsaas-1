<#setting number_format="#">
<div class="form">
	<div class="rx-grid rxc grid-d" plugins="rx-grid"  label="${ent.comment}" name="${ent.name}" edittype="inline" required="false" templateid=""  formkey="" fwidth="0" fheight="0" treegrid="false" treecolumn="" mwidth="0" wunit="px" mheight="0" hunit="px" formname="" data-options="{required:false}">
	    <table style="width:100%;">
	        <thead>
	            <tr>
	            	<#list ent.sysBoAttrs as field>
	            	<#assign json="${field.extJson}"?eval />
	                <td class="header" <#if (field.isSingle==0)> displayfield="${field.name}_name" </#if> datatype="${field.dataType}" width="" header="${field.name}"  vtype_name="${field.comment}" length="${field.length}" decimal="${field.decimalLength}" requires="${field.required}" editcontrol="${field.control}"  format="${json.format}">
	                    	${field.comment}
	                </td>
	                </#list>
	               
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	            	<#list ent.sysBoAttrs as field>
	                <td header="${field.name}">
	                	<@fieldCtrl field=field inTable=true />
	                </td>
	                </#list>
	            </tr>
	        </tbody>
	    </table>
	</div>
</div>