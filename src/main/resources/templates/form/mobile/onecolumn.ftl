<script>
// 表单公式计算
var formulas_${boDefId}=${formula};
// 表单日期计算
var dateCalcs_${boDefId}=${datecalc};
//实体扩展JSON
var extJson_${boDefId}=${extJson};
//验证规则
var validRule_${boDefId}=${validRule};
</script>

<rx-popup v-model="showUserDialog" position="center" width="100%">
       <rx-sysuser :single="singleUser" ref="sysUser" v-on:ok="selectUser" v-on:cancel="closeUserDialog()"></rx-sysuser>
</rx-popup>
<rx-popup v-model="showGroupDialog" position="center" width="100%">
       <rx-sysgroup :single="singleGroup" ref="sysGroup" v-on:ok="selectGroup" v-on:cancel="closeGroupDialog()"></rx-sysgroup>
</rx-popup>

<div class="div-form-main">
	<div class="caption" >${ent.comment}</div>
	<div class="form-container form-containerrow" >
		<#assign rowTwoCol = ["mini-textbox","mini-checkboxlist","mini-combobox","mini-checkbox","mini-radiobuttonlist","mini-time","mini-month","mini-datepicker","mini-spinner"]>
		<#assign rowCol = ["mini-buttonedit","upload-panel","mini-user","mini-group","mini-dep","mini-textarea","mini-ueditor"]>
		<#list ent.sysBoAttrs as field>

			<#if  rowTwoCol?seq_contains(field.control)>
				<div class="form">
					<div class="row2col-title">
						${field.comment}<#if field.required><span class="required">*</span></#if>
					</div>
					<div class="row2col-input">
						<@fieldCtrl field=field type="main" entName=""/>
					</div>
				</div>
			<#elseif rowCol?seq_contains(field.control)>
				<div class="form-rowcol">
					<div class="rowcol-title">
						${field.comment}<#if field.required><span class="required">*</span></#if>
					</div>
					<div class="rowcol-input">
						<@fieldCtrl field=field type="main" entName=""/>
					</div>
				</div>
			</#if>
		</#list>
	</div>
</div>
	