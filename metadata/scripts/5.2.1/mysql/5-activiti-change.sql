alter table ACT_RU_TASK add CREATE_BY_ varchar(64) null comment '创建人ID' ;
alter table ACT_RU_TASK add UPDATE_BY_ varchar(64) null comment '更新人ID' ;
alter table ACT_RU_TASK add UPDATE_TIME_ datetime null comment '更新时间' ;
alter table ACT_RU_TASK add SOL_ID_ varchar(64) null comment '业务解决方案ID' ;
alter table ACT_RU_TASK add AGENT_USER_ID_ varchar(64) null comment '代理人ID' ;

alter table ACT_RU_TASK add ENABLE_MOBILE_  integer default 0;

alter table ACT_RU_TASK  add RC_TASK_ID_ varchar(64) comment '原沟通任务Id';  
alter table ACT_RU_TASK add CM_LEVEL_ INTEGER comment '沟通层次';
alter table ACT_RU_TASK add TASK_TYPE_ varchar(20) comment '任务类型';
alter table ACT_RU_TASK add GEN_CM_TASK_ varchar(20) comment '是否产生沟通任务';
alter table act_ru_task add CM_FUSRID_ varchar(64) comment '发起沟通人';
alter table ACT_RU_TASK add CM_TASK_ID_ varchar(64) null comment '发起任务ID' ;