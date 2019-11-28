<table class="table-detail column-two">
    <caption>[XX]详细信息</caption>
<tbody>
  <#list controls as control >
  <tr>
    <td>${control.name}</td>
    <td>
    	<#if control.tag=="input">
    		<${control.tag} plugins="${control.editcontrol}" class="rcx ${control.editcontrol}" name="${control.key}" label="${control.name}"  mwidth="0" wunit="px" mheight="0" hunit="px" />
    	<#else>
    		<${control.tag} plugins="${control.editcontrol}" class="rcx ${control.editcontrol}" name="${control.key}" label="${control.name}"  mwidth="0" wunit="px" mheight="0" hunit="px" ></${control.tag}>
    	</#if>
    	</td>
  </tr>
  </#list>
  </tbody>
</table>