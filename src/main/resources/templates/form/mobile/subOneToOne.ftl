<div class="div-form">
	<div class="caption" >${ent.comment}</div>
	<div class="form-container form-containerrow" >
		<#list ent.sysBoAttrs as field>
			<#if field.control!="mini-hidden">
			<div class="form">
				<div class="form-title">
					${field.comment}<#if field.required><span class="required">*</span></#if>
				</div>
				<div class="form-input">
					<@fieldCtrl field=field type="onetoone" entName=ent.name />
				</div>
			</div>
			</#if>
		</#list>
	</div>
</div>
	