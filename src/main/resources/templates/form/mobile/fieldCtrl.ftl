<#setting number_format="0">
<#function getField type  entName>
 	<#assign rtn><#if type=="main">data<#elseif (type=="sub" || type=="subRow") >item<#elseif type=="curRow">curRow<#elseif type=="onetoone">data.SUB_${entName}</#if></#assign>
	<#return rtn>
</#function>

<#function getReadonly type>
 	<#assign rtn><#if (type=="subRow")>true<#else>readonly</#if></#assign>
	<#return rtn>
</#function>

<#function getPermission field entName>
 	<#assign rtn>${field.name}</#assign><#return rtn>
</#function>

<#function isKeyName field>
	<#assign type=field.control>
 	<#assign rtn><#if (type=="mini-user" || type=="mini-group" || type=="mini-dep" || type=="mini-radiobuttonlist" || type=="mini-buttonedit") >yes<#else>no</#if></#assign>
	<#return rtn>
</#function>


<#function getRight type ,entName>
 	<#assign rtn><#if (type=="main")>permission.main<#else>permission.sub['${entName}'].fields</#if></#assign>
	<#return rtn>
</#function>

<#function getSingle json>
	<#assign single=json.single!'false'>
	<#if (single=='') ><#assign single>true</#assign></#if>
	<#return single>
</#function>

<#function getRequired field>
	<#assign rtn = ""/>
	<#if (field.required )><#assign rtn = ":required=\"" +field.required +"\"" /></#if>
	<#return rtn>
</#function>


<#macro fieldCtrl field type entName>
	<#assign json="${field.extJson}"?eval />
	
	<#switch field.control>
		<#case "mini-hidden">
		<#break>
		<#case "mini-textbox">
			<rx-input v-model="${getField(type,entName)}.${field.name}" 
					permissionkey="${getPermission(field,entName)}"
					${getRequired(field)}
					<#if json.vtype?? >vtype="${json.vtype}"</#if>
					:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"  ></rx-input>
		<#break>
		<#case "mini-checkboxlist">
			<rx-checkboxlist :data="${getField(type,entName)}"  name="${field.name}" 
				${getRequired(field)}
				conf='${field.extJson}'  permissionkey="${getPermission(field,entName)}" 
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}" ></rx-checkboxlist>
		<#break>
		
		<#case "mini-buttonedit">
			<rx-buttonedit :data="${getField(type,entName)}"  name="${field.name}" 
				${getRequired(field)}
				conf='${field.extJson}'  permissionkey="${getPermission(field,entName)}" 
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}" ></rx-buttonedit>
		<#break>
		<#case "mini-combobox">
			<rx-combobox :data="${getField(type,entName)}"  name="${field.name}"
				${getRequired(field)}
				placeholder="请选择${field.comment}"
				conf='${field.extJson}' permissionkey="${getPermission(field,entName)}"
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-combobox>
		<#break>
	
		<#case "mini-checkbox">
			<rx-checkbox :data="${getField(type,entName)}" name="${field.name}" permissionkey="${getPermission(field,entName)}"
				conf='${field.extJson}' :readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-checkbox>
		<#break>
		<#case "mini-radiobuttonlist">
			<rx-radiobuttonlist :data="${getField(type,entName)}" name="${field.name}" 
				${getRequired(field)}
				conf='${field.extJson}' permissionkey="${getPermission(field,entName)}"
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-radiobuttonlist>
		<#break>
		<#case "upload-panel">
			<rx-attachment v-model="${getField(type,entName)}.${field.name}" ref="attachment_${field.name}" name="${field.name}" permissionkey="${getPermission(field,entName)}" 
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-attachment>
		<#break>
		<#case "mini-user">
			<rx-user :data="${getField(type,entName)}"  name="${field.name}" 
				${getRequired(field)}
				permissionkey="${getPermission(field,entName)}" v-on:openuserdialog="onOpenUserDialog"
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}" :single="${getSingle(json)}"></rx-user>
		<#break>
		<#case "mini-group">
			<rx-group :data="${getField(type,entName)}"  name="${field.name}" 
				${getRequired(field)}
				permissionkey="${getPermission(field,entName)}" v-on:opengroupdialog="onOpenGroupDialog"
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}" :single="${getSingle(json)}"></rx-group>
		<#break>
		<#case "mini-dep">
			<rx-group :data="${getField(type,entName)}"  name="${field.name}" 
				${getRequired(field)}
				permissionkey="${getPermission(field,entName)}" v-on:opengroupdialog="onOpenGroupDialog"
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}" :single="${getSingle(json)}"></rx-group>
		<#break>
		<#case "mini-textarea">
			<rx-textarea v-model="${getField(type,entName)}.${field.name}" 
				permissionkey="${getPermission(field,entName)}" 
				${getRequired(field)}
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-textarea>
		<#break>
		<#case "mini-ueditor">
			<rx-richtex  v-model="${getField(type,entName)}.${field.name}" permissionkey="${getPermission(field,entName)}" 
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}" ></rx-richtex>	
		<#break>
		<#case "mini-time">
			<rx-time  v-model="${getField(type,entName)}.${field.name}" 
				 permissionkey="${getPermission(field,entName)}" 
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-time>	
		<#break>
		<#case "mini-month">
			<rx-month  v-model="${getField(type,entName)}.${field.name}" 
				 permissionkey="${getPermission(field,entName)}" 
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-month>	
		<#break>
		<#case "mini-datepicker">
			<rx-date  v-model="${getField(type,entName)}.${field.name}" 
				${getRequired(field)}
				conf='${field.extJson}' permissionkey="${getPermission(field,entName)}" 
				:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-date>	
		<#break>
		
		<#case "mini-spinner">
			<rx-spiner v-model="${getField(type,entName)}.${field.name}"
					${getRequired(field)}
					permissionkey="${getPermission(field,entName)}"
					:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}" ></rx-spiner>
		<#break>
		
		
		
	<#default>
		<#if isKeyName(field)=="yes" >
				<rx-complex :data="${getField(type,entName)}" name="${field.name}" permissionkey="${getPermission(field,entName)}" 
					:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"></rx-complex>
		<#else>
				<rx-input v-model="${getField(type,entName)}.${field.name}" 
					permissionkey="${getPermission(field,entName)}"
					${getRequired(field)}
					<#if json.vtype?? >vtype="${json.vtype}"</#if>
					:readonly="${getReadonly(type)}" :permission="${getRight(type ,entName)}"  ></rx-input>
		</#if>
	</#switch>
</#macro>
