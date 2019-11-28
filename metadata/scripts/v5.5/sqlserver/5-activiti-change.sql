alter table ACT_RU_TASK add CREATE_BY_ varchar(64) null  ;
alter table ACT_RU_TASK add UPDATE_BY_ varchar(64) null  ;
alter table ACT_RU_TASK add UPDATE_TIME_ datetime null  ;
alter table ACT_RU_TASK add SOL_ID_ varchar(64) null  ;
alter table ACT_RU_TASK add AGENT_USER_ID_ varchar(64) null  ;

alter table ACT_RU_TASK add ENABLE_MOBILE_  integer default 0;

alter table ACT_RU_TASK add RC_TASK_ID_ varchar(64);  
alter table ACT_RU_TASK add CM_LEVEL_ INTEGER ;
alter table ACT_RU_TASK add TASK_TYPE_ varchar(20) ;
alter table ACT_RU_TASK add GEN_CM_TASK_ varchar(20) ;
alter table act_ru_task add CM_FUSRID_ varchar(64) ;
alter table ACT_RU_TASK add CM_TASK_ID_ varchar(64) null ;

alter table ACT_RU_TASK add TOKEN_ varchar(64) ;
alter table ACT_RU_TASK add URGENT_TIMES_ integer default 0;

alter table ACT_RU_TASK add RUN_PATH_ID_ varchar(64) ;

alter table ACT_RU_TASK add timeout_status_ varchar(20);

alter table ACT_RU_TASK add OVERTIME_ datetime null  ;
alter table ACT_RU_TASK add OVERTIME_ZONE_ varchar(64) null  ;

CREATE INDEX IDX_BPMINST_ACTINSTID ON BPM_INST (ACT_INST_ID_);
