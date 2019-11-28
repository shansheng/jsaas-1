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
<div class="div-form"></div>
<div class="div-form-main">
	<div class="caption" >${ent.comment}</div>
	<div class="form-container form-containerrow" >
		<#list ent.sysBoAttrs as field>
			<#if field.control!="mini-hidden">
			<div class="form">
				<div class="form-title">
					${field.comment}<#if field.required><span class="required">*</span></#if>
				</div>
				<div class="form-input">
					<@fieldCtrl field=field type="main" entName=""/>
				</div>
			</div>
			</#if>
		</#list>
	</div>
</div>
	