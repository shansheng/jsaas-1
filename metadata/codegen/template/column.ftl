<#list models as model>
<#if (model.tableName?capitalize?starts_with("W_")) >
alter  table ${model.tableName} change CREATE_USER_ID_ CREATE_BY_ VARCHAR(64);
alter  table ${model.tableName} change CREATE_GROUP_ID_ GROUP_ID_ VARCHAR(64);
alter table  ${model.tableName} add UPDATE_BY_ varchar(64);

</#if>
</#list>