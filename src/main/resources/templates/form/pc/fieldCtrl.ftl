<#setting number_format="#">
<#function getJson data type>
	<#assign rtn =""/>
	<#list data as item>
		<#if (type=="key") >
			<#if (item_index==0) >
				<#assign rtn =rtn +"," + item.key />
			<#else>
				<#assign rtn = item.key />
			</#if>
		<#else>
			<#if (item_index==0) >
				<#assign rtn =rtn +"," + item.name />
			<#else>
				<#assign rtn = item.name />
			</#if>
		</#if>
	</#list>
	<#return rtn>
</#function>

<#function jsonAryToString data>
	<#assign rtn ="["/>
	<#list data as item>
			<#if (item_index==0) >
				<#assign rtn =rtn + "{key:'"+item.key +"',name:'" +item.name +"'}" />
			<#else>
				<#assign rtn = rtn +",{key:'"+item.key +"',name:'" +item.name +"'}" />
			</#if>
	</#list>
	<#assign rtn =rtn + "]"/>
	<#return rtn>
</#function>

<#function getRequired field>
	<#assign rtn = ""/>
	<#if (field.required )><#assign rtn = "required=\"" +field.required +"\"" /></#if>
	<#return rtn>
</#function>

<#function getAllowInput field>
	<#assign rtn = ""/>
	<#if (field.allowinput )><#assign rtn = "allowinput=\"" +field.allowinput +"\"" /></#if>
	<#return rtn>
</#function>

<#function getTextName field json>
	<#assign rtn = ""/>
	<#if (json.refField ?? )>
		<#assign rtn = json.refField />
	<#else>
		<#assign rtn = field.name+"_name" />
	</#if>
	<#return rtn>
</#function>

<#function getRefField json>
	<#assign rtn = ""/>
	<#if (json.refField ?? )>
		<#assign rtn = "dataoptions=\"{refField=\"" + field.refField+"\"}\"" />
	</#if>
	<#return rtn>
</#function>


<#macro fieldCtrl field	inTable>
	<#assign json="${field.extJson}"?eval />
	<#switch field.control>
		<#case "mini-textbox">
			<input  ${getAllowInput(json)}
				plugins="mini-textbox"  class="rxc mini-textbox"  editcontrol="mini-textbox" editcontrol_name="单行文本"
				datatype="${field.dataType}" length="${field.length}" ${getRequired(field)}
				<#if ( inTable ) > property="editor" </#if>
				<#if (field.dataType=="varchar")>decimal="0"<#else>decimal="${field.decimalLength}"</#if>
				name="${field.name}" label="${field.comment}"  
				<#if (json.from=="sequence")>sequence="${json.sequence}"</#if>
				<#if (json.from=="scripts")>scripts="${json.scripts}"</#if>
				<#if (util.isNotEmpty(json.validrule)) ><#if (json.validrule=="onUniqueValidation") > onvalidation="onUniqueValidation" <#else> vtype="${json.validrule}"</#if></#if> 
				 from="${json.from}" mwidth="0" wunit="px" mheight="0" hunit="%" />
		<#break>
		<#case "mini-textarea">
			<textarea <#if inTable > property="editor" </#if> name="${field.name}" class="mini-textarea rxc" plugins="mini-textarea"  
			 label="${field.comment}" datatype="${field.dataType}" length="${field.length}"  minlen="${json.minlen}" ${getAllowInput(json)}
			 ${getRequired(field)} value="" emptytext="" mwidth="0" wunit="px" mheight="0" hunit="px"></textarea>
		<#break>
		<#case "mini-checkbox">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-checkbox rxc" plugins="mini-checkbox" 
			label="${field.comment}" text="${field.comment}" length="${field.length}" truevalue="${json.truevalue}" falsevalue="${json.falsevalue}" checked="${json.checked}" type="checkbox"/>
		<#break>
		<#case  "mini-radiobuttonlist">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-radiobuttonlist rxc" plugins="mini-radiobuttonlist"
			 label="${field.name}"  ${getRefField(json)} length="${field.length}" from="${json.from}" defaultvalue="${json.defaultvalue}" 
			 ${getRequired(field)} mwidth="0" wunit="px" mheight="0" hunit="px" 
			 <#if (json.from=="self")>
			 	textfield="name" valuefield="key" data="${jsonAryToString(json.data)}" datafield="data"
			 <#elseif (json.from=="url")>
			 	url="${json.url}" url_textfield="${json.textfield}" url_valuefield="${json.valuefield}"
			 <#elseif (json.from=="dic")>
			 	dickey="${json.dicKey}"  textfield="name" valuefield="key"
			 <#elseif (json.from=="sql")>
			 	sql="${json.sqlKey}" sql_textfield="${json.textfield}" sql_valuefield="${json.valuefield}"
			 </#if>/>
		<#break>
		<#case "mini-checkboxlist">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-checkboxlist rxc" plugins="mini-checkboxlist"  
			 label="${field.comment}" ${getRefField(json)} length="${field.length}" 
			from="${json.from}" ${getRequired(field)} defaultvalue="${json.defaultvalue}"
			<#if (json.from=="self")>
			 	textfield="name" valuefield="key" data="${jsonAryToString(json.data)}" datafield="data"
			 <#elseif (json.from=="url")>
			 	url="${json.url}" url_textfield="${json.textfield}" url_valuefield="${json.valuefield}"
			 <#elseif (json.from=="dic")>
			 	dickey="${json.dicKey}"  textfield="name" valuefield="key"
			 <#elseif (json.from=="sql")>
			 	sql="${json.sqlKey}" sql_textfield="${json.textfield}" sql_valuefield="${json.valuefield}"
			 </#if> />
		<#break>
		
		<#case "mini-combobox">
			 <input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-combobox rxc" plugins="mini-combobox" 
			  label="${field.comment}" textname="${getTextName(field, json)}" length="${field.length}" from="${json.from}"
			  ${getRequired(field)} defaultvalue="${json.defaultvalue}"   
			 <#if (json.from=="self")>
			  datafield="data" textfield="name" valuefield="key" data="${jsonAryToString(json.data)}"
			 <#elseif (json.from=="url")>
			 	url="${json.url}" url_textfield="${json.textfield}" url_valuefield="${json.valuefield}"
			 <#elseif (json.from=="dic")>
			 	dickey="${json.dicKey}"  textfield="name" valuefield="key"
			 <#elseif (json.from=="sql")>
			 	sql_parent="${json.sqlParent}" sql="${json.sqlKey}" sql_textfield="${json.textfield}" sql_valuefield="${json.valuefield}" sql_params="${json.sqlParam}"
			 </#if>
			 />
		<#break>
		<#case "mini-datepicker">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-datepicker rxc" plugins="mini-datepicker" format="${json.format}" 
			label="${field.comment}"  ${getRequired(field)} showtime="${json.showtime}" showokbutton="${json.showokbutton}" 
			showclearbutton="${json.showclearbutton}" ${getAllowInput(json)} initcurtime="${json.initcurtime}"  format="${json.format}" />
		<#break>
		<#case "mini-month">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-month rxc" plugins="mini-month" 
				label="${field.comment}" ${getAllowInput(json)} initcurtime="${json.initcurtime}" value="" 
				mwidth="0" wunit="px" mheight="0" hunit="px" style="" format="yyyy-MM"/>
		<#break>
		<#case "mini-time">
			 <input name="${field.name}" class="mini-time rxc" plugins="mini-time" format="${json.format}" 
			 	label="${field.comment}" ${getAllowInput(json)} initcurtime="${json.initcurtime}" value="" mwidth="0" wunit="px" mheight="0" hunit="px" />
		<#break>
		<#case "mini-spinner">
			 <input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-spinner rxc" plugins="mini-spinner" vtype="rangeLength:${json.minvalue},${json.maxvalue}" label="${field.comment}" 
			 	minvalue="${json.minvalue}" maxvalue="${json.maxvalue}" increment="${json.increment}" ${getRequired(field)}
			 	format="" ${getAllowInput(json)} mwidth="0" wunit="px" mheight="0" hunit="px"  datatype="number"/>
		<#break>
		<#case "mini-ueditor">
			<textarea <#if inTable > property="editor" </#if> name="${field.name}" plugins="mini-ueditor" class="mini-ueditor  rxc" 
			 label="${field.comment}" datatype="${field.dataType}" length="${field.length}" ${getRequired(field)} mwidth="0" wunit="px" mheight="0" hunit="px"></textarea>
		<#break>
		<#case "mini-user">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-user rxc" plugins="mini-user"   allowinput="false" 
			label="${field.comment}" textname="${getTextName(field, json)}" length="${field.length}" single="${json.single}" ${getRequired(field)} initloginuser="${json.initloginuser}" 
			mwidth="0" wunit="px" mheight="0" hunit="px"/>
		<#break>
		<#case "mini-group">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-group rxc" plugins="mini-group" 
				data-options="{&quot;single&quot;:&quot;${json.single}&quot;,&quot;showDim&quot;:&quot;${json.showdim}&quot;,&quot;dimId&quot;:&quot;${json.dimId}&quot;}" 
				 allowinput="false" label="${field.comment}" textname="${getTextName(field, json)}"
				 length="${field.length}" single="${json.single}" ${getRequired(field)} showdim="${json.showdim}" initlogingroup="${json.initlogingroup}" 
				 level="${json.level}" dimid="${json.dimId}" mwidth="0" wunit="px" mheight="0" hunit="px"/>
		<#break>
		<#case "upload-panel">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="upload-panel rxc" plugins="upload-panel"  
				allowupload="true" label="${field.comment}" length="${field.length}" sizelimit="${json.sizelimit}" 
				isone="${json.single}" filetype="${json.filetype}" mwidth="0" wunit="px" mheight="0" hunit="px"/>
		<#break>
		<#case "mini-hidden">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-hidden rxc" plugins="mini-hidden" label="${field.comment}" length="${field.length}" value=""/>
		<#break>
		<#case "mini-buttonedit">
			<input name="${field.name}" class="mini-buttonedit rxc" plugins="mini-buttonedit"  label="${field.comment}" textname="${getTextName(field, json)}" length="${field.length}"  ${getRequired(field)} allowinput="false"  mwidth="0" wunit="px" mheight="0" hunit="%"/>
		<#break>
		<#case "mini-dep">
			 <input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-dep rxc" plugins="mini-dep" 
			 	data-options="{&quot;single&quot;:&quot;${json.single}&quot;,&quot;config&quot;:{&quot;type&quot;:&quot;${json.refconfig}&quot;,&quot;grouplevel&quot;:&quot;${json.level}&quot;,&quot;groupids&quot;:&quot;${json.groupids}&quot;,&quot;groupidsText&quot;:&quot;${json.groupidsText}&quot;}}" 
			 	 allowinput="false" label="${field.comment}" textname="${getTextName(field, json)}" length="${field.length}" minlen="0" single="${json.single}" ${getRequired(field)} initlogindep="${json.initlogindep}" level="2" refconfig="${json.refconfig}" grouplevel="${json.level}" groupids="${json.groupids}" mwidth="0" wunit="px" mheight="0" hunit="px"/>
		<#break>
		<#case "mini-treeselect">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-treeselect rxc" plugins="mini-treeselect"  datafield="data" label="${field.comment}" textname="${getTextName(field, json)}"
			 length="${field.length}" from="${json.from}"
			 <#if (json.from=="url") >
			  url="${json.url}" url_textfield="${json.textfield}" url_valuefield="${json.valuefield}" url_parentfield="${json.parentfield}"
			 <#else> 
			  sql="${json.customSql}" sql_textfield="${json.textfield}" sql_valuefield="${json.valuefield}" sql_parentfield="${json.parentfield}" 
			 </#if>
			  ${getRequired(field)} checkrecursive="${json.checkrecursive}" showfoldercheckbox="${json.showfoldercheckbox}" autocheckparent="${json.autocheckparent}" 
			  	<#if (json.expand) ><#if (json.expandType=="all") >expandonload="true"<#else>expandonload="${json.layer}"</#if><#else>expandonload="false"</#if>
			    multiselect="${json.multiselect}"  popupwidth="200" pwunit="px" popupheight="300" phunit="px" mwidth="0" wunit="px" mheight="0" hunit="px" 
			  	textfield="${json.textfield}" valuefield="${json.valuefield}" parentfield="${json.parentfield}"/>
		<#break>
		<#case "mini-textboxlist">
			<input <#if inTable > property="editor" </#if> name="${field.name}" class="mini-textboxlist rxc" plugins="mini-textboxlist" 
			 label="${field.comment}" ${getRefField(json)} length="${field.length}" ${getAllowInput(json)} isurl="${json.isurl}"
			 <#if (json.isurl) > url="${json.url}" valuefield="${json.valuefield}" textfield="${json.textfield}"</#if>
			  ${getRequired(field)}  mwidth="0" wunit="px" mheight="0" hunit="px" value="${getJson(json.data,"key")}" text="${getJson(json.data,"name")}"/>
		<#break>
		<#case "mini-office">
			<div  class="mini-office rxc" plugins="mini-office" label="${field.comment}" name="${field.name}" version="${json.version}" mwidth="100" wunit="%" mheight="500" readonly="false" ></div>
		<#break>
		<#case "mini-img">
			 <img <#if inTable > property="editor" </#if> name="${field.name}" class="mini-img rxc" src="${ctxPath}/styles/images/upload-file.png" plugins="mini-img"  label="${field.comment}" length="${field.length}" imgtype="${json.imgtype}" mwidth="0" wunit="px" mheight="0" hunit="px"/>
		<#break>
	</#switch>
</#macro>


