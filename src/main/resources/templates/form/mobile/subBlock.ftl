<div class="div-form-sub" v-if="hasRight('${ent.name}')">
	
	<div class="subTable" v-for="(item, index) in data.SUB_${ent.name}" v-if="data.SUB_${ent.name} && data.SUB_${ent.name}.length>0">
		<div class="subTitle">
			<div class="caption">${ent.comment}</div>
			<div class="btnDel" v-if="getDelRight('${ent.name}')" v-on:click="remove('${ent.name}',index)">删除</div>
		</div>
		<#assign rowTwoCol = ["mini-textbox","mini-checkboxlist","mini-combobox","mini-checkbox","mini-radiobuttonlist","mini-time","mini-month","mini-datepicker","mini-spinner"]>
		<#assign rowCol = ["mini-buttonedit","upload-panel","mini-user","mini-group","mini-dep","mini-textarea","mini-ueditor"]>
		
		<#list ent.sysBoAttrs as field>
			<#if rowTwoCol?seq_contains(field.control)>
				<div class="form">
					<div class="row2col-title">
						${field.comment}<#if field.required><span class="required">*</span></#if>
					</div>
					<div class="row2col-input">
						<@fieldCtrl field=field type="sub" entName=ent.name/>
					</div>
				</div>
			<#elseif rowCol?seq_contains(field.control)>
				<div class="form-rowcol">
					<div class="rowcol-title">
						${field.comment}<#if field.required><span class="required">*</span></#if>
					</div>
					<div class="rowcol-input">
						<@fieldCtrl field=field type="sub" entName=ent.name/>
					</div>
				</div>
			</#if>
		</#list>
	</div>
	
	<div class="toolbar" v-if="getAddRight('${ent.name}')">
		<div class="button" v-on:click="add('${ent.name}')">增加(${ent.comment})</div>
	</div>
	
</div>
