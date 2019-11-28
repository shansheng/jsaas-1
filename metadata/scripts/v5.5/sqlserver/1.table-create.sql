/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     2018-2-7 上午 9:20:45                          */
/*==============================================================*/

/*==============================================================*/
/* Table: BPM_AGENT                                             */
/*==============================================================*/
CREATE TABLE BPM_AGENT (
   AGENT_ID_            VARCHAR(64)          NOT NULL,
   SUBJECT_             VARCHAR(100)         NOT NULL,
   TO_USER_ID_          VARCHAR(64)          NOT NULL,
   AGENT_USER_ID_       VARCHAR(64)          NOT NULL,
   START_TIME_          DATETIME             NOT NULL,
   END_TIME_            DATETIME             NOT NULL,
   TYPE_                VARCHAR(20)          NOT NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   DESCP_               VARCHAR(300)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_AGENT PRIMARY KEY NONCLUSTERED (AGENT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程方案代理',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'AGENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理人ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'TO_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '被代理人ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'AGENT_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理类型
   ALL=全部代理
   PART=部分代理',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   ENABLED
   DISABLED',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_AGENT_SOL                                         */
/*==============================================================*/
CREATE TABLE BPM_AGENT_SOL (
   AS_ID_               VARCHAR(64)          NOT NULL,
   AGENT_ID_            VARCHAR(64)          NULL,
   SOL_ID_              VARCHAR(64)          NOT NULL,
   SOL_NAME_            VARCHAR(100)         NOT NULL,
   AGENT_TYPE_          VARCHAR(20)          NULL,
   CONDITION_           TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_AGENT_SOL PRIMARY KEY NONCLUSTERED (AS_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部分代理的流程方案',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'AS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'AGENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案名称',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'SOL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理类型
   全部=ALL
   条件代理=PART',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'AGENT_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理条件',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'CONDITION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_AGENT_SOL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_AUTH_DEF                                          */
/*==============================================================*/
CREATE TABLE BPM_AUTH_DEF (
   ID_                  VARCHAR(50)          NOT NULL,
   SOL_ID_              VARCHAR(50)          NULL,
   RIGHT_JSON_          VARCHAR(1000)        NULL,
   SETTING_ID_          VARCHAR(50)          NULL,
   TREE_ID_             VARCHAR(50)          NULL,
   CONSTRAINT PK_BPM_AUTH_DEF PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权流程定义',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_DEF', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_DEF', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限JSON',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_DEF', 'column', 'RIGHT_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_DEF', 'column', 'TREE_ID_'
go

/*==============================================================*/
/* Table: BPM_AUTH_RIGHTS                                       */
/*==============================================================*/
CREATE TABLE BPM_AUTH_RIGHTS (
   ID_                  VARCHAR(50)          NOT NULL,
   RIGHT_TYPE_          VARCHAR(50)          NULL,
   TYPE_                VARCHAR(50)          NULL,
   AUTH_ID_             VARCHAR(50)          NULL,
   AUTH_NAME_           VARCHAR(50)          NULL,
   SETTING_ID_          VARCHAR(50)          NULL,
   CONSTRAINT PK_BPM_AUTH_RIGHTS PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义授权',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_RIGHTS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_RIGHTS', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限类型(def,流程定义,inst,流程实例,task,待办任务,start,发起流程)',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_RIGHTS', 'column', 'RIGHT_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权类型(all,全部,user,用户,group,用户组)',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_RIGHTS', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权对象ID',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_RIGHTS', 'column', 'AUTH_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权对象名称',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_RIGHTS', 'column', 'AUTH_NAME_'
go

/*==============================================================*/
/* Table: BPM_AUTH_SETTING                                      */
/*==============================================================*/
CREATE TABLE BPM_AUTH_SETTING (
   ID_                  VARCHAR(50)          NOT NULL,
   NAME_                VARCHAR(50)          NULL,
   ENABLE_              VARCHAR(10)          NULL,
   TYPE_                VARCHAR(10)          NULL,
   TENANT_ID_           VARCHAR(50)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(50)          NULL,
   UPDATE_BY_           VARCHAR(50)          NULL,
   CONSTRAINT PK_BPM_AUTH_SETTING PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义授权',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权名称',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'ENABLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权类型(sol,解决方案,form,表单)',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'BPM_AUTH_SETTING', 'column', 'UPDATE_BY_'
go

/*==============================================================*/
/* Table: BPM_BUS_LINK                                          */
/*==============================================================*/
CREATE TABLE BPM_BUS_LINK (
   BPM_BUS_LINK_ID_     VARCHAR(64)          NOT NULL,
   FORM_INST_ID_        VARCHAR(64)          NULL,
   INST_ID_             VARCHAR(64)          NULL,
   LINK_PK_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_BUS_LINK PRIMARY KEY NONCLUSTERED (BPM_BUS_LINK_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BPM_BUS_LINK第三方业务链接表',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'BPM_BUS_LINK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'FORM_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '第三方物理表主键ID',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'LINK_PK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_BUS_LINK', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_CHECK_FILE                                        */
/*==============================================================*/
CREATE TABLE BPM_CHECK_FILE (
   FILE_ID_             VARCHAR(64)          NOT NULL,
   FILE_NAME_           VARCHAR(255)         NULL,
   JUMP_ID_             VARCHAR(64)          NOT NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_CHECK_FILE PRIMARY KEY NONCLUSTERED (FILE_ID_, JUMP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批意见附件',
   'user', @CURRENTUSER, 'table', 'BPM_CHECK_FILE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_CHECK_FILE', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_CHECK_FILE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_CHECK_FILE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_CHECK_FILE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_CHECK_FILE', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: BPM_DEF                                               */
/*==============================================================*/
CREATE TABLE BPM_DEF (
   DEF_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   SUBJECT_             VARCHAR(255)         NOT NULL,
   DESCP_               VARCHAR(1024)        NULL,
   KEY_                 VARCHAR(255)         NOT NULL,
   ACT_DEF_ID_          VARCHAR(255)         NULL,
   ACT_DEP_ID_          VARCHAR(255)         NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   VERSION_             INT                  NOT NULL,
   IS_MAIN_             VARCHAR(20)          NULL,
   SETTING_             TEXT                 NULL,
   MODEL_ID_            VARCHAR(64)          NOT NULL,
   MAIN_DEF_ID_         VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_DEF PRIMARY KEY NONCLUSTERED (DEF_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义',
   'user', @CURRENTUSER, 'table', 'BPM_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识Key',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Activiti流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程发布ID',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'ACT_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本号',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主版本',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'IS_MAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '定义属性设置',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'SETTING_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '设计模型ID
   关联Activiti中的ACT_RE_MODEL表主键',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'MODEL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'MAIN_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_FM_ATT                                            */
/*==============================================================*/
CREATE TABLE BPM_FM_ATT (
   ATT_ID_              VARCHAR(64)          NOT NULL,
   TITLE_               VARCHAR(64)          NOT NULL,
   KEY_                 VARCHAR(100)         NOT NULL,
   DATA_TYPE_           VARCHAR(64)          NOT NULL,
   TYPE_                VARCHAR(64)          NULL,
   DEF_VAL_             VARCHAR(255)         NULL,
   REQUIRED_            VARCHAR(20)          NOT NULL,
   LEN_                 INT                  NULL,
   PREC_                INT                  NULL,
   SN_                  INT                  NOT NULL,
   GROUP_TITLE_         VARCHAR(100)         NULL,
   REMARK_              VARCHAR(512)         NULL,
   CTL_TYPE_            VARCHAR(50)          NULL,
   CTL_CONFIG_          VARCHAR(512)         NULL,
   REF_FM_ID_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_FM_ATT PRIMARY KEY NONCLUSTERED (ATT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据模型属性定义',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性标签',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性标识',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性数据类型
   String
   Date
   Float
   Double
   
   元数据类型或外部模型ID',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'DATA_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性类型
   元数据=META
   集合=COLLECTION-MODEL
   外部数据模型=EXT_MODEL',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '默认值',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'DEF_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否必须',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'REQUIRED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '长度',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'LEN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '精度(小数位)',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'PREC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分组标题',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'GROUP_TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性帮助描述',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'REMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '控件类型
   界面绑定的控件类型',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'CTL_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '控件配置参数(JSON配置)',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'CTL_CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_FM_ATT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_FORMBO_SETTING                                    */
/*==============================================================*/
CREATE TABLE BPM_FORMBO_SETTING (
   ID_                  VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   NODE_ID_             VARCHAR(64)          NULL,
   ENT_NAME_            VARCHAR(64)          NULL,
   ATTR_NAME_           VARCHAR(64)          NULL,
   INIT_SETTING_        VARCHAR(500)         NULL,
   SAVE_SETTING_        VARCHAR(500)         NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_FORMBO_SETTING PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单数据配置',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点配置ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实体名称',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'ENT_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性名称',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'ATTR_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '初始设定',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'INIT_SETTING_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '保存时设定',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'SAVE_SETTING_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_FORMBO_SETTING', 'column', 'CREATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_FORM_INST                                         */
/*==============================================================*/
CREATE TABLE BPM_FORM_INST (
   FORM_INST_ID_        VARCHAR(64)          NOT NULL,
   SUBJECT_             VARCHAR(127)         NULL,
   INST_ID_             VARCHAR(64)          NULL,
   ACT_INST_ID_         VARCHAR(64)          NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   DEF_ID_              VARCHAR(64)          NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   FM_ID_               VARCHAR(64)          NULL,
   FM_VIEW_ID_          VARCHAR(64)          NULL,
   STATUS_              VARCHAR(20)          NULL,
   JSON_DATA_           TEXT                 NULL,
   IS_PERSIST_          VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_FORM_INST PRIMARY KEY NONCLUSTERED (FORM_INST_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程数据模型实例',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实例标题',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'ACT_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据模型ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'FM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单视图ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'FM_VIEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据JSON',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'JSON_DATA_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否持久化',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'IS_PERSIST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_INST', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_FORM_TEMPLATE                                     */
/*==============================================================*/
CREATE TABLE BPM_FORM_TEMPLATE (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(50)          NULL,
   ALIAS_               VARCHAR(50)          NULL,
   TEMPLATE_            TEXT                 NULL,
   TYPE_                VARCHAR(50)          NULL,
   INIT_                SMALLINT             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CATEGORY_            VARCHAR(50)          NULL,
   CONSTRAINT PK_BPM_FORM_TEMPLATE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单模版',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模版名称',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模版',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'TEMPLATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模版类型 (pc,mobile)',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '初始添加的(1是,0否)',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'INIT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类别',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_TEMPLATE', 'column', 'CATEGORY_'
go

/*==============================================================*/
/* Table: BPM_FORM_VIEW                                         */
/*==============================================================*/
CREATE TABLE BPM_FORM_VIEW (
   VIEW_ID_             VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   NAME_                VARCHAR(255)         NOT NULL,
   KEY_                 VARCHAR(100)         NOT NULL,
   TYPE_                VARCHAR(50)          NOT NULL,
   RENDER_URL_          VARCHAR(255)         NULL,
   VERSION_             INT                  NOT NULL,
   IS_MAIN_             VARCHAR(20)          NOT NULL,
   MAIN_VIEW_ID_        VARCHAR(64)          NULL,
   DESCP_               VARCHAR(500)         NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   IS_BIND_MD_          VARCHAR(20)          NULL,
   TEMPLATE_VIEW_       TEXT                 NULL,
   TEMPLATE_ID_         VARCHAR(64)          NULL,
   DISPLAY_TYPE_        VARCHAR(64)          NULL,
   TEMPLATE_            TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   BO_DEFID_            VARCHAR(20)          NULL,
   TITLE_               VARCHAR(1000)        NULL,
   BUTTON_DEF_          VARCHAR(1000)        NULL,
   PDF_TEMP_            TEXT                 NULL,
   CONSTRAINT PK_BPM_FORM_VIEW PRIMARY KEY NONCLUSTERED (VIEW_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务表单视图',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识键',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型
   ONLINE=在线表单
   URL=线下定制表单',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单展示URL',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'RENDER_URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为主版本',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'IS_MAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '隶属主版本视图ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'MAIN_VIEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '视图说明',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否绑定业务模型
   YES=是
   NO=否',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'IS_BIND_MD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板类型ID
   用于生成视图的模板类型ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'TEMPLATE_VIEW_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板内容',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'TEMPLATE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'tab展示模式normal first',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'DISPLAY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '转换过的模板',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'TEMPLATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BO定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'BO_DEFID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'PDF模板',
   'user', @CURRENTUSER, 'table', 'BPM_FORM_VIEW', 'column', 'PDF_TEMP_'
go

/*==============================================================*/
/* Table: BPM_FV_RIGHT                                          */
/*==============================================================*/
CREATE TABLE BPM_FV_RIGHT (
   RIGHT_ID_            VARCHAR(64)          NOT NULL,
   VIEW_ID_             VARCHAR(64)          NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   FIELD_NAME_          VARCHAR(255)         NOT NULL,
   FIELD_LABEL_         VARCHAR(255)         NOT NULL,
   EDIT_                TEXT                 NULL,
   EDIT_DF_             TEXT                 NULL,
   READ_                TEXT                 NULL,
   READ_DF_             TEXT                 NULL,
   HIDE_                TEXT                 NULL,
   HIDE_DF_             TEXT                 NULL,
   SN_                  INT                  NULL,
   NODE_ID_             VARCHAR(64)          NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TYPE_                VARCHAR(64)          NULL,
   DEALWITH_            VARCHAR(20)          NULL,
   FORM_ALIAS_          VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_FV_RIGHT PRIMARY KEY NONCLUSTERED (RIGHT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单视图字段权限',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限ID',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'RIGHT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务表单视图ID',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'VIEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Activiti定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段路径',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'FIELD_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '编辑权限描述',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'EDIT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '编辑权限
   格式：
   {
   all:false,
   userIds:'''',
   unames:'''',
   groupIds:'''',
   gnames:''''
   }',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'EDIT_DF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '只读权限',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'READ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '只读权限描述',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'READ_DF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '隐藏权限',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'HIDE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '隐藏权限描述',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'HIDE_DF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程解决方案Id',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限类型(field:字段,opinion:意见)',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '子表添加数据处理',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'DEALWITH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单别名',
   'user', @CURRENTUSER, 'table', 'BPM_FV_RIGHT', 'column', 'FORM_ALIAS_'
go

/*==============================================================*/
/* Table: BPM_GROUP_SCRIPT                                      */
/*==============================================================*/
CREATE TABLE BPM_GROUP_SCRIPT (
   SCRIPT_ID_           VARCHAR(64)          NOT NULL,
   CLASS_NAME_          VARCHAR(200)         NULL,
   CLASS_INS_NAME_      VARCHAR(200)         NULL,
   METHOD_NAME_         VARCHAR(64)          NULL,
   METHOD_DESC_         VARCHAR(200)         NULL,
   RETURN_TYPE_         VARCHAR(64)          NULL,
   ARGUMENT_            VARCHAR(1000)        NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_GROUP_SCRIPT PRIMARY KEY NONCLUSTERED (SCRIPT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '人员脚本',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'SCRIPT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类名',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'CLASS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类实例名',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'CLASS_INS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方法名',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'METHOD_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方法描述',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'METHOD_DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '返回类型',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'RETURN_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数定义',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'ARGUMENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_GROUP_SCRIPT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_INST                                              */
/*==============================================================*/
CREATE TABLE BPM_INST (
   INST_ID_             VARCHAR(64)          NOT NULL,
   DEF_ID_              VARCHAR(64)          NOT NULL,
   ACT_INST_ID_         VARCHAR(64)          NULL,
   ACT_DEF_ID_          VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   INST_NO_             VARCHAR(50)          NULL,
   IS_USE_BMODEL_       VARCHAR(20)          NULL,
   SUBJECT_             VARCHAR(255)         NULL,
   STATUS_              VARCHAR(20)          NULL,
   VERSION_             INT                  NULL,
   BUS_KEY_             VARCHAR(64)          NULL,
   CHECK_FILE_ID_       VARCHAR(64)          NULL,
   FORM_INST_ID_        VARCHAR(64)          NULL,
   IS_TEST_             VARCHAR(20)          NULL,
   ERRORS_              TEXT                 NULL,
   END_TIME_            DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   DATA_SAVE_MODE_      VARCHAR(10)          NULL,
   SUPPORT_MOBILE_      INT                  NULL,
   BO_DEF_ID_           VARCHAR(20)          NULL,
   BILL_NO_             VARCHAR(255)         NULL,
   START_DEP_ID_        VARCHAR(64)          NULL,
   START_DEP_FULL_      VARCHAR(300)         NULL,
   CONSTRAINT PK_BPM_INST PRIMARY KEY NONCLUSTERED (INST_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例',
   'user', @CURRENTUSER, 'table', 'BPM_INST'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Activiti实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'ACT_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Activiti定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID_',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例工单号',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'INST_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '单独使用业务模型
   YES=表示不带任何表单视图',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'IS_USE_BMODEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '运行状态',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务键ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'BUS_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批正文依据ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'CHECK_FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务表单数据ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'FORM_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为测试',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'IS_TEST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据保存模式(all,json,db)',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'DATA_SAVE_MODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '支持手机端',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'SUPPORT_MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BO定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'BO_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '单号',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'BILL_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发起部门ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'START_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发起部门全名',
   'user', @CURRENTUSER, 'table', 'BPM_INST', 'column', 'START_DEP_FULL_'
go

/*==============================================================*/
/* Table: BPM_INST_ATTACH                                       */
/*==============================================================*/
CREATE TABLE BPM_INST_ATTACH (
   ID_                  VARCHAR(64)          NOT NULL,
   INST_ID_             VARCHAR(64)          NOT NULL,
   FILE_ID_             VARCHAR(64)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_INST_ATTACH PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例附件',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实例Id',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH', 'column', 'FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_ATTACH', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_INST_CC                                           */
/*==============================================================*/
CREATE TABLE BPM_INST_CC (
   CC_ID_               VARCHAR(64)          NOT NULL,
   SUBJECT_             VARCHAR(255)         NOT NULL,
   NODE_ID_             VARCHAR(255)         NULL,
   NODE_NAME_           VARCHAR(255)         NULL,
   FROM_USER_           VARCHAR(50)          NULL,
   FROM_USER_ID_        VARCHAR(255)         NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   INST_ID_             VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_INST_CC PRIMARY KEY NONCLUSTERED (CC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程抄送',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送标题',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送人',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'FROM_USER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'FROM_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CC', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_INST_CP                                           */
/*==============================================================*/
CREATE TABLE BPM_INST_CP (
   ID_                  VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NULL,
   GROUP_ID_            VARCHAR(64)          NULL,
   IS_READ_             VARCHAR(10)          NULL,
   CC_ID_               VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_INST_CP PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程抄送人员',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组Id',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'CC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CP', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_INST_CTL                                          */
/*==============================================================*/
CREATE TABLE BPM_INST_CTL (
   CTL_ID               VARCHAR(64)          NOT NULL,
   BPM_INST_ID_         VARCHAR(64)          NULL,
   INST_ID_             VARCHAR(64)          NULL,
   TYPE_                VARCHAR(50)          NULL,
   RIGHT_               VARCHAR(60)          NULL,
   ALLOW_ATTEND_        VARCHAR(20)          NULL,
   ALLOW_STARTOR_       VARCHAR(20)          NULL,
   GROUP_IDS_           TEXT                 NULL,
   USER_IDS_            TEXT                 NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_INST_CTL PRIMARY KEY NONCLUSTERED (CTL_ID)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程附件权限',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'READ=阅读权限
   FILE=附件权限',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ALL=全部权限
   EDIT=编辑
   DEL=删除
   PRINT=打印
   DOWN=下载',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'RIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '允许发起人
   YES',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'ALLOW_STARTOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组Ids（多个用户组Id用“，”分割）',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'GROUP_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户Ids（多个用户Id用“，”分割）',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'USER_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_CTL', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: BPM_INST_DATA                                         */
/*==============================================================*/
CREATE TABLE BPM_INST_DATA (
   ID_                  VARCHAR(64)          NOT NULL,
   BO_DEF_ID_           VARCHAR(64)          NULL,
   INST_ID_             VARCHAR(64)          NULL,
   PK_                  VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_INST_DATA PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关联关系',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务对象ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'BO_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实例ID_',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务表主键',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'PK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_DATA', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Index: IDX_INSTDATA_INSTID                                   */
/*==============================================================*/
CREATE INDEX IDX_INSTDATA_INSTID ON BPM_INST_DATA (
INST_ID_ ASC
)
go

/*==============================================================*/
/* Table: BPM_INST_READ                                         */
/*==============================================================*/
CREATE TABLE BPM_INST_READ (
   READ_ID_             VARCHAR(64)          NOT NULL,
   INST_ID_             VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(64)          NULL,
   STATE_               VARCHAR(50)          NULL,
   DEP_ID_              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_INST_READ PRIMARY KEY NONCLUSTERED (READ_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例阅读',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程阶段',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'STATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部门ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_READ', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_INST_TMP                                          */
/*==============================================================*/
CREATE TABLE BPM_INST_TMP (
   TMP_ID_              VARCHAR(64)          NOT NULL,
   BUS_KEY_             VARCHAR(64)          NULL,
   INST_ID_             VARCHAR(64)          NOT NULL,
   FORM_JSON_           TEXT                 NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_INST_TMP PRIMARY KEY NONCLUSTERED (TMP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例启动临时表',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '临时ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'TMP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程JSON',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'FORM_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_INST_TMP', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_LIB                                               */
/*==============================================================*/
CREATE TABLE BPM_LIB (
   LIB_ID_              VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   NAME_                VARCHAR(255)         NOT NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   DESCP_               VARCHAR(1024)        NULL,
   HELP_ID              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_LIB PRIMARY KEY NONCLUSTERED (LIB_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务流程解决方案共享库',
   'user', @CURRENTUSER, 'table', 'BPM_LIB'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '共享库ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'LIB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '共享所属分类ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案名称',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '帮助ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'HELP_ID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_LIB', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_LIB_CMT                                           */
/*==============================================================*/
CREATE TABLE BPM_LIB_CMT (
   CMT_ID_              VARCHAR(64)          NOT NULL,
   LIB_ID_              VARCHAR(64)          NULL,
   CONTENT_             VARCHAR(512)         NOT NULL,
   LEVEL_               INT                  NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_LIB_CMT PRIMARY KEY NONCLUSTERED (CMT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '共享库评论',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '共享库ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'LIB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '评论内容',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '评分(0-100)',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_LIB_CMT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_LOG                                               */
/*==============================================================*/
CREATE TABLE BPM_LOG (
   LOG_ID_              VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   INST_ID_             VARCHAR(64)          NULL,
   TASK_ID_             VARCHAR(64)          NULL,
   LOG_TYPE_            VARCHAR(50)          NOT NULL,
   OP_TYPE_             VARCHAR(50)          NOT NULL,
   OP_CONTENT_          VARCHAR(512)         NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_LOG PRIMARY KEY NONCLUSTERED (LOG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程更新日志
   包括流程任务日志、流程解决方案的更新，流程实例的更新日志等。',
   'user', @CURRENTUSER, 'table', 'BPM_LOG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程任务ID',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'TASK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志分类
   
   方案本身信息操作
   业务模型
   流程表单
   测试
   
   流程实例
   流程任务',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'LOG_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '操作类型
   
   更新
   删除
   备注
   沟通
   ',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'OP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '操作内容',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'OP_CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_LOG', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_MESSAGE_BOARD                                     */
/*==============================================================*/
CREATE TABLE BPM_MESSAGE_BOARD (
   ID_                  VARCHAR(64)          NOT NULL,
   INST_ID_             VARCHAR(64)          NULL,
   MESSAGE_AUTHOR_      VARCHAR(64)          NULL,
   MESSAGE_AUTHOR_ID_   VARCHAR(64)          NULL,
   MESSAGE_CONTENT_     TEXT                 NULL,
   FILE_ID_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_MESSAGE_BOARD PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程沟通留言板',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '留言用户',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'MESSAGE_AUTHOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '留言用户ID',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'MESSAGE_AUTHOR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '留言消息',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'MESSAGE_CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件ID',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_MESSAGE_BOARD', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: BPM_MOBILE_FORM                                       */
/*==============================================================*/
CREATE TABLE BPM_MOBILE_FORM (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(50)          NULL,
   ALIAS_               VARCHAR(50)          NULL,
   FORM_HTML            TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   BO_DEF_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_MOBILE_FORM PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机表单配置表',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单模版',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'FORM_HTML'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单分类ID',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'bo定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_MOBILE_FORM', 'column', 'BO_DEF_ID_'
go

/*==============================================================*/
/* Table: BPM_MODULE_BIND                                       */
/*==============================================================*/
CREATE TABLE BPM_MODULE_BIND (
   BIND_ID_             VARCHAR(64)          NOT NULL,
   MODULE_NAME_         VARCHAR(50)          NOT NULL,
   MODULE_KEY_          VARCHAR(80)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   SOL_KEY_             VARCHAR(60)          NULL,
   SOL_NAME_            VARCHAR(100)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_MODULE_BIND PRIMARY KEY NONCLUSTERED (BIND_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程模块方案绑定',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块名称',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'MODULE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块Key',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'MODULE_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程解决方案Key',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'SOL_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程解决方案名称',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'SOL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_MODULE_BIND', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_NODE_JUMP                                         */
/*==============================================================*/
CREATE TABLE BPM_NODE_JUMP (
   JUMP_ID_             VARCHAR(64)          NOT NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   ACT_INST_ID_         VARCHAR(64)          NULL,
   NODE_NAME_           VARCHAR(255)         NULL,
   NODE_ID_             VARCHAR(255)         NOT NULL,
   TASK_ID_             VARCHAR(64)          NULL,
   COMPLETE_TIME_       DATETIME             NULL,
   DURATION_            INT                  NULL,
   DURATION_VAL_        INT                  NULL,
   OWNER_ID_            VARCHAR(64)          NULL,
   HANDLER_ID_          VARCHAR(64)          NULL,
   AGENT_USER_ID_       VARCHAR(64)          NULL,
   CHECK_STATUS_        VARCHAR(50)          NULL,
   JUMP_TYPE_           VARCHAR(50)          NULL,
   REMARK_              VARCHAR(512)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   ENABLE_MOBILE_       SMALLINT             NULL,
   OPINION_NAME_        VARCHAR(50)          NULL,
   HANDLE_DEP_ID_       VARCHAR(64)          NULL,
   HANDLE_DEP_FULL_     VARCHAR(300)         NULL,
   CONSTRAINT PK_BPM_NODE_JUMP PRIMARY KEY NONCLUSTERED (JUMP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程流转记录',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'ACT_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点Key',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'TASK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '完成时间',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'COMPLETE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '持续时长',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'DURATION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '有效审批时长',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'DURATION_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务所属人ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'OWNER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '处理人ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'HANDLER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '被代理人',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'AGENT_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批状态',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'CHECK_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '跳转类型',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'JUMP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '意见备注',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'REMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否支持手机',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'ENABLE_MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段意见名称',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'OPINION_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '处理部门ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'HANDLE_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '处理部门全名',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_JUMP', 'column', 'HANDLE_DEP_FULL_'
go

/*==============================================================*/
/* Table: BPM_NODE_SET                                          */
/*==============================================================*/
CREATE TABLE BPM_NODE_SET (
   SET_ID_              VARCHAR(128)         NOT NULL,
   SOL_ID_              VARCHAR(64)          NOT NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   NODE_ID_             VARCHAR(255)         NOT NULL,
   NAME_                VARCHAR(255)         NULL,
   DESCP_               VARCHAR(255)         NULL,
   NODE_TYPE_           VARCHAR(100)         NOT NULL,
   NODE_CHECK_TIP_      VARCHAR(1024)        NULL,
   SETTINGS_            TEXT                 NULL,
   PRE_HANDLE_          VARCHAR(255)         NULL,
   AFTER_HANDLE_        VARCHAR(255)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_NODE_SET PRIMARY KEY NONCLUSTERED (SET_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义节点配置',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点描述',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点类型',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'NODE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点设置',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'SETTINGS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '前置处理器',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'PRE_HANDLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '后置处理器',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'AFTER_HANDLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_NODE_SET', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_OPINION_LIB                                       */
/*==============================================================*/
CREATE TABLE BPM_OPINION_LIB (
   OP_ID_               VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   OP_TEXT_             VARCHAR(512)         NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_OPINION_LIB PRIMARY KEY NONCLUSTERED (OP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '意见收藏表',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID，为0代表公共的',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批意见',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB', 'column', 'OP_TEXT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_LIB', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_OPINION_TEMP                                      */
/*==============================================================*/
CREATE TABLE BPM_OPINION_TEMP (
   ID_                  VARCHAR(64)          NOT NULL,
   TYPE_                VARCHAR(20)          NULL,
   INST_ID_             VARCHAR(64)          NULL,
   OPINION_             VARCHAR(1000)        NULL,
   ATTACHMENT_          VARCHAR(1000)        NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_OPINION_TEMP PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程临时意见',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型(inst,task)',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务或实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '意见',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'OPINION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'ATTACHMENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'BPM_OPINION_TEMP', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: BPM_PH_TABLE                                          */
/*==============================================================*/
CREATE TABLE BPM_PH_TABLE (
   BPM_PH_TABLE_ID_     VARCHAR(64)          NOT NULL,
   VIEW_ID_             VARCHAR(64)          NULL,
   FM_TREE_ID_          VARCHAR(64)          NULL,
   FM_ID_               VARCHAR(64)          NULL,
   STATUS_              VARCHAR(64)          NULL,
   DS_ID_               VARCHAR(64)          NULL,
   DS_NAME_             VARCHAR(256)         NULL,
   JSON_DATA_           TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_PH_TABLE PRIMARY KEY NONCLUSTERED (BPM_PH_TABLE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BPM_PH_TABLE物理表',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'BPM_PH_TABLE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单视图ID',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'VIEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务模型树分类ID',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'FM_TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模型ID',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'FM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源ID',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'DS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源名称',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'DS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据JSON映射
   ',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'JSON_DATA_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_PH_TABLE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_REMIND_DEF                                        */
/*==============================================================*/
CREATE TABLE BPM_REMIND_DEF (
   ID_                  VARCHAR(50)          NOT NULL,
   SOL_ID_              VARCHAR(50)          NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   NODE_ID_             VARCHAR(50)          NULL,
   NAME_                VARCHAR(50)          NULL,
   ACTION_              VARCHAR(50)          NULL,
   REL_NODE_            VARCHAR(50)          NULL,
   EVENT_               VARCHAR(50)          NULL,
   DATE_TYPE_           VARCHAR(50)          NULL,
   EXPIRE_DATE_         VARCHAR(50)          NULL,
   CONDITION_           VARCHAR(1000)        NULL,
   SCRIPT_              VARCHAR(1000)        NULL,
   NOTIFY_TYPE_         VARCHAR(50)          NULL,
   TIME_TO_SEND_        VARCHAR(50)          NULL,
   SEND_TIMES_          INT                  NULL,
   SEND_INTERVAL_       VARCHAR(50)          NULL,
   SOLUTION_NAME_       VARCHAR(50)          NULL,
   NODE_NAME_           VARCHAR(50)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_REMIND_DEF PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '催办定义',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '到期动作',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'ACTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '相对节点',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'REL_NODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '事件',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'EVENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日期类型',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'DATE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '期限',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'EXPIRE_DATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '条件',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'CONDITION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '到期执行脚本',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通知类型',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'NOTIFY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始发送消息时间点',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'TIME_TO_SEND_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送次数',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'SEND_TIMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送时间间隔',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'SEND_INTERVAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案名称',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'SOLUTION_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_DEF', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: BPM_REMIND_HISTORY                                    */
/*==============================================================*/
CREATE TABLE BPM_REMIND_HISTORY (
   ID_                  VARCHAR(50)          NOT NULL,
   REMINDER_INST_ID_    VARCHAR(50)          NULL,
   REMIND_TYPE_         VARCHAR(50)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_REMIND_HISTORY PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '催办历史',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '催办实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'REMINDER_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '催办类型',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'REMIND_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_HISTORY', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: BPM_REMIND_INST                                       */
/*==============================================================*/
CREATE TABLE BPM_REMIND_INST (
   ID_                  VARCHAR(50)          NOT NULL,
   SOL_ID_              VARCHAR(50)          NULL,
   NODE_ID_             VARCHAR(50)          NULL,
   TASK_ID_             VARCHAR(50)          NULL,
   NAME_                VARCHAR(50)          NULL,
   ACTION_              VARCHAR(50)          NULL,
   EXPIRE_DATE_         DATETIME             NULL,
   SCRIPT_              VARCHAR(1000)        NULL,
   NOTIFY_TYPE_         VARCHAR(50)          NULL,
   TIME_TO_SEND_        DATETIME             NULL,
   SEND_TIMES_          INT                  NULL,
   SEND_INTERVAL_       INT                  NULL,
   STATUS_              VARCHAR(10)          NULL,
   SOLUTION_NAME_       VARCHAR(50)          NULL,
   NODE_NAME_           VARCHAR(50)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   ACT_INST_ID_         VARCHAR(64)          NULL,
   CONSTRAINT PK_BPM_REMIND_INST PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '催办实例表',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'TASK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '到期动作',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'ACTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '期限',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'EXPIRE_DATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '到期执行脚本',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通知类型',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'NOTIFY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始发送消息时间点',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'TIME_TO_SEND_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送次数',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'SEND_TIMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送时间间隔',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'SEND_INTERVAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态(2,完成,0,创建,1,进行中)',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案名称',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'SOLUTION_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_REMIND_INST', 'column', 'ACT_INST_ID_'
go

/*==============================================================*/
/* Table: BPM_RU_PATH                                           */
/*==============================================================*/
CREATE TABLE BPM_RU_PATH (
   PATH_ID_             VARCHAR(64)          NOT NULL,
   INST_ID_             VARCHAR(64)          NOT NULL,
   ACT_DEF_ID_          VARCHAR(64)          NOT NULL,
   ACT_INST_ID_         VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NOT NULL,
   NODE_ID_             VARCHAR(255)         NOT NULL,
   NODE_NAME_           VARCHAR(255)         NULL,
   NODE_TYPE_           VARCHAR(50)          NULL,
   START_TIME_          DATETIME             NOT NULL,
   END_TIME_            DATETIME             NULL,
   DURATION_            INT                  NULL,
   DURATION_VAL_        INT                  NULL,
   ASSIGNEE_            VARCHAR(64)          NULL,
   TO_USER_ID_          VARCHAR(64)          NULL,
   IS_MULTIPLE_         VARCHAR(20)          NULL,
   EXECUTION_ID_        VARCHAR(64)          NULL,
   USER_IDS_            VARCHAR(300)         NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   LEVEL_               INT                  NULL,
   OUT_TRAN_ID_         VARCHAR(255)         NULL,
   TOKEN_               VARCHAR(255)         NULL,
   JUMP_TYPE_           VARCHAR(50)          NULL,
   NEXT_JUMP_TYPE_      VARCHAR(50)          NULL,
   OPINION_             VARCHAR(500)         NULL,
   REF_PATH_ID_         VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TIMEOUT_STATUS_      VARCHAR(20)          NULL,
   CONSTRAINT PK_BPM_RU_PATH PRIMARY KEY NONCLUSTERED (PATH_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例运行路线',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Act定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Act实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'ACT_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点类型',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'NODE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '持续时长',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'DURATION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '有效审批时长',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'DURATION_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '处理人ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'ASSIGNEE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理人ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'TO_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为多实例',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'IS_MULTIPLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '活动执行ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'EXECUTION_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '原执行人IDS',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'USER_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '层次',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '跳出路线ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'OUT_TRAN_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路线令牌',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'TOKEN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '跳到该节点的方式
   正常跳转
   自由跳转
   回退跳转',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'JUMP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '下一步跳转方式',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'NEXT_JUMP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批意见',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'OPINION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '引用路径ID
   当回退时，重新生成的结点，需要记录引用的回退节点，方便新生成的路径再次回退。',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'REF_PATH_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'timeout_status_',
   'user', @CURRENTUSER, 'table', 'BPM_RU_PATH', 'column', 'TIMEOUT_STATUS_'
go

/*==============================================================*/
/* Table: BPM_SIGN_DATA                                         */
/*==============================================================*/
CREATE TABLE BPM_SIGN_DATA (
   DATA_ID_             VARCHAR(64)          NOT NULL,
   ACT_DEF_ID_          VARCHAR(64)          NOT NULL,
   ACT_INST_ID_         VARCHAR(64)          NOT NULL,
   NODE_ID_             VARCHAR(255)         NOT NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   VOTE_STATUS_         VARCHAR(50)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_SIGN_DATA PRIMARY KEY NONCLUSTERED (DATA_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务会签数据
   运行过程中会清空该表，一般为流程实例运行过程中清空',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'DATA_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'ACT_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程节点Id',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '投票人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '投票状态
   同意
   反对
   弃权
   ',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'VOTE_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SIGN_DATA', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_SOLUTION                                          */
/*==============================================================*/
CREATE TABLE BPM_SOLUTION (
   SOL_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   TREE_PATH_           VARCHAR(512)         NULL,
   NAME_                VARCHAR(100)         NOT NULL,
   KEY_                 VARCHAR(100)         NOT NULL,
   DEF_KEY_             VARCHAR(255)         NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   DESCP_               VARCHAR(512)         NULL,
   STEP_                INT                  NOT NULL,
   IS_USE_BMODEL_       VARCHAR(20)          NULL,
   STATUS_              VARCHAR(64)          NOT NULL,
   SUBJECT_RULE_        VARCHAR(255)         NULL,
   HELP_ID_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   GRANT_TYPE_          SMALLINT             NULL,
   FORMAL_              VARCHAR(10)          NULL,
   BO_DEF_ID_           VARCHAR(64)          NULL,
   DATA_SAVE_MODE_      VARCHAR(10)          NULL,
   SUPPORT_MOBILE_      INT                  NULL,
   CONSTRAINT PK_BPM_SOLUTION PRIMARY KEY NONCLUSTERED (SOL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务流程方案定义',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否跳过第一步，
   代表流程启动后，是否跳过第一步',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'TREE_PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识键',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '绑定流程KEY',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'DEF_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案描述',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '完成的步骤',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'STEP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '单独使用业务模型
   YES=表示不带任何表单视图',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'IS_USE_BMODEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   INIT =创建状态
   DEPLOYED=发布状态
   DISABLED=禁用状态',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务标题规则',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'SUBJECT_RULE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '帮助ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'HELP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权类型
   0=全部
   1=部分授权',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'GRANT_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否正式(yes,no)',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'FORMAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BO定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'BO_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BO数据保存模式',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'DATA_SAVE_MODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '支持手机端表单',
   'user', @CURRENTUSER, 'table', 'BPM_SOLUTION', 'column', 'SUPPORT_MOBILE_'
go

/*==============================================================*/
/* Table: BPM_SOL_CTL                                           */
/*==============================================================*/
CREATE TABLE BPM_SOL_CTL (
   RIGHT_ID_            VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   USER_IDS_            TEXT                 NULL,
   GROUP_IDS_           TEXT                 NULL,
   ALLOW_STARTOR_       VARCHAR(20)          NULL,
   ALLOW_ATTEND_        VARCHAR(20)          NULL,
   RIGHT_               VARCHAR(60)          NULL,
   TYPE_                VARCHAR(50)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_SOL_CTL PRIMARY KEY NONCLUSTERED (RIGHT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程解决方案资源访问权限控制',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户Ids（多个用户Id用“，”分割）',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'USER_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组Ids（多个用户组Id用“，”分割）',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'GROUP_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '允许发起人
   YES',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'ALLOW_STARTOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ALL=全部权限
   EDIT=编辑
   DEL=删除
   PRINT=打印
   DOWN=下载',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'RIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'READ=阅读权限
   FILE=附件权限',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_CTL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_SOL_FM                                            */
/*==============================================================*/
CREATE TABLE BPM_SOL_FM (
   ID_                  VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NOT NULL,
   MOD_KEY_             VARCHAR(100)         NOT NULL,
   IS_MAIN_             VARCHAR(20)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_SOL_FM PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案关联的业务模型',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务模型标识键',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'MOD_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为主模型',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'IS_MAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FM', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_SOL_FV                                            */
/*==============================================================*/
CREATE TABLE BPM_SOL_FV (
   ID_                  VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NOT NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   NODE_ID_             VARCHAR(255)         NOT NULL,
   NODE_TEXT_           VARCHAR(255)         NULL,
   FORM_TYPE_           VARCHAR(30)          NULL,
   FORM_URI_            VARCHAR(255)         NULL,
   FORM_NAME_           VARCHAR(255)         NULL,
   PRINT_URI_           VARCHAR(255)         NULL,
   PRINT_NAME_          VARCHAR(255)         NULL,
   SN_                  INT                  NULL,
   MOBILE_NAME_         VARCHAR(50)          NULL,
   MOBILE_ALIAS_        VARCHAR(50)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TAB_RIGHTS_          TEXT                 NULL,
   IS_USE_CFORM_        VARCHAR(20)          NULL,
   COND_FORMS_          TEXT                 NULL,
   DATA_CONFS_          TEXT                 NULL,
   MOBILE_FORMS_        TEXT                 NULL,
   PRINT_FORMS_         TEXT                 NULL,
   CONSTRAINT PK_BPM_SOL_FV PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案关联的表单视图',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'NODE_TEXT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单类型
   ONLINE-DESIGN=在线表单
   SEL-DEV=自定义的URL表单',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'FORM_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单地址',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'FORM_URI_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'FORM_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '打印表单地址',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'PRINT_URI_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '打印表单名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'PRINT_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机表单名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'MOBILE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机表单别名',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'MOBILE_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单TAB权限配置',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'TAB_RIGHTS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '使用权限表单',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'IS_USE_CFORM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '条件表单设置',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'COND_FORMS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单数据设定',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'DATA_CONFS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机表单配置',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'MOBILE_FORMS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '打印表单配置',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_FV', 'column', 'PRINT_FORMS_'
go

/*==============================================================*/
/* Table: BPM_SOL_USER                                          */
/*==============================================================*/
CREATE TABLE BPM_SOL_USER (
   ID_                  VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   NODE_ID_             VARCHAR(255)         NOT NULL,
   NODE_NAME_           VARCHAR(255)         NULL,
   USER_TYPE_           VARCHAR(50)          NOT NULL,
   USER_TYPE_NAME_      VARCHAR(100)         NULL,
   CONFIG_DESCP_        VARCHAR(512)         NULL,
   CONFIG_              VARCHAR(512)         NULL,
   IS_CAL_              VARCHAR(20)          NOT NULL,
   CAL_LOGIC_           VARCHAR(20)          NOT NULL,
   SN_                  INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CATEGORY_            VARCHAR(20)          NULL,
   GROUP_ID_            VARCHAR(50)          NULL,
   CONSTRAINT PK_BPM_SOL_USER PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案关联的人员配置',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务流程解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户类型',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'USER_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户类型名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'USER_TYPE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '配置显示信息',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'CONFIG_DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点配置',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否计算用户',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'IS_CAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '集合的人员运算',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'CAL_LOGIC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类别',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USER', 'column', 'CATEGORY_'
go

/*==============================================================*/
/* Table: BPM_SOL_USERGROUP                                     */
/*==============================================================*/
CREATE TABLE BPM_SOL_USERGROUP (
   ID_                  VARCHAR(50)          NOT NULL,
   GROUP_NAME_          VARCHAR(50)          NULL,
   ACT_DEF_ID_          VARCHAR(50)          NULL,
   SOL_ID_              VARCHAR(50)          NULL,
   GROUP_TYPE_          VARCHAR(50)          NULL,
   NODE_ID_             VARCHAR(50)          NULL,
   NODE_NAME_           VARCHAR(50)          NULL,
   TENANT_ID_           VARCHAR(50)          NULL,
   SETTING_             VARCHAR(2000)        NULL,
   SN_                  INT                  NULL,
   NOTIFY_TYPE_         VARCHAR(50)          NULL,
   CREATE_BY_           VARCHAR(50)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(50)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_SOL_USERGROUP PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程配置用户组',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'GROUP_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分组类型(flow,copyto)',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'GROUP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '配置',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'SETTING_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_USERGROUP', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_SOL_VAR                                           */
/*==============================================================*/
CREATE TABLE BPM_SOL_VAR (
   VAR_ID_              VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   KEY_                 VARCHAR(255)         NOT NULL,
   NAME_                VARCHAR(255)         NOT NULL,
   TYPE_                VARCHAR(50)          NOT NULL,
   SCOPE_               VARCHAR(128)         NOT NULL,
   NODE_NAME_           VARCHAR(255)         NULL,
   DEF_VAL_             VARCHAR(100)         NULL,
   EXPRESS_             VARCHAR(512)         NULL,
   IS_REQ_              VARCHAR(20)          NULL,
   SN_                  INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_TIME_         DATETIME             NULL,
   FORM_FIELD_          VARCHAR(100)         NULL,
   CONSTRAINT PK_BPM_SOL_VAR PRIMARY KEY NONCLUSTERED (VAR_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程解决方案变量',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '变量ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'VAR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACT流程定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '变量Key',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '变量名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '作用域
   全局为_PROCESS
   节点范围时存储节点ID
   ',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'SCOPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '缺省值',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'DEF_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '计算表达式',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'EXPRESS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否必须',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'IS_REQ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单字段',
   'user', @CURRENTUSER, 'table', 'BPM_SOL_VAR', 'column', 'FORM_FIELD_'
go

/*==============================================================*/
/* Table: BPM_SQL_NODE                                          */
/*==============================================================*/
CREATE TABLE BPM_SQL_NODE (
   BPM_SQL_NODE_ID_     VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   NODE_ID_             VARCHAR(64)          NULL,
   NODE_TEXT_           VARCHAR(256)         NULL,
   SQL_                 TEXT                 NULL,
   DS_ID_               VARCHAR(64)          NULL,
   DS_NAME_             VARCHAR(256)         NULL,
   JSON_DATA_           TEXT                 NULL,
   JSON_TABLE_          TEXT                 NULL,
   SQL_TYPE_            SMALLINT             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_SQL_NODE PRIMARY KEY NONCLUSTERED (BPM_SQL_NODE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BPM_SQL_NODE中间表',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'BPM_SQL_NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点ID',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'NODE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点名称',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'NODE_TEXT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SQL语句',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'SQL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源ID',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'DS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源名称',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'DS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据JSON映射
   ',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'JSON_DATA_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表映射数据',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'JSON_TABLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SQL类型',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'SQL_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_SQL_NODE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_TEST_CASE                                         */
/*==============================================================*/
CREATE TABLE BPM_TEST_CASE (
   TEST_ID_             VARCHAR(64)          NOT NULL,
   TEST_SOL_ID_         VARCHAR(64)          NOT NULL,
   ACT_DEF_ID_          VARCHAR(64)          NULL,
   CASE_NAME_           VARCHAR(20)          NOT NULL,
   PARAMS_CONF_         TEXT                 NULL,
   START_USER_ID_       VARCHAR(64)          NULL,
   USER_CONF_           TEXT                 NULL,
   INST_ID_             VARCHAR(64)          NULL,
   LAST_STATUS_         VARCHAR(20)          NULL,
   EXE_EXCEPTIONS_      TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_TEST_CASE PRIMARY KEY NONCLUSTERED (TEST_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '测试用例',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '测试用例ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'TEST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '测试方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'TEST_SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用例名称',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'CASE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数配置',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'PARAMS_CONF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发起人',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'START_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户干预配置',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'USER_CONF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '执行最终状态',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'LAST_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '执行异常',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'EXE_EXCEPTIONS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_CASE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: BPM_TEST_SOL                                          */
/*==============================================================*/
CREATE TABLE BPM_TEST_SOL (
   TEST_SOL_ID_         VARCHAR(64)          NOT NULL,
   TEST_NO_             VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NOT NULL,
   ACT_DEF_ID_          VARCHAR(64)          NOT NULL,
   MEMO_                VARCHAR(1024)        NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_BPM_TEST_SOL PRIMARY KEY NONCLUSTERED (TEST_SOL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程测试方案',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '测试方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'TEST_SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案编号',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'TEST_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Activiti定义ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'ACT_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '测试方案描述',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'BPM_TEST_SOL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: CAL_CALENDAR                                          */
/*==============================================================*/
CREATE TABLE CAL_CALENDAR (
   CALENDER_ID_         VARCHAR(64)          NOT NULL,
   SETTING_ID_          VARCHAR(64)          NULL,
   START_TIME_          DATETIME             NULL,
   END_TIME_            DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_CAL_CALENDAR PRIMARY KEY NONCLUSTERED (CALENDER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '工作日历安排',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日历Id',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'CALENDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '设定ID',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'SETTING_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'CAL_CALENDAR', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: CAL_GRANT                                             */
/*==============================================================*/
CREATE TABLE CAL_GRANT (
   GRANT_ID_            VARCHAR(64)          NOT NULL,
   SETTING_ID_          VARCHAR(64)          NULL,
   GRANT_TYPE_          VARCHAR(64)          NULL,
   BELONG_WHO_          VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_CAL_GRANT PRIMARY KEY NONCLUSTERED (GRANT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日历分配',
   'user', @CURRENTUSER, 'table', 'CAL_GRANT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分配类型 USER/GROUP',
   'user', @CURRENTUSER, 'table', 'CAL_GRANT', 'column', 'GRANT_TYPE_'
go

/*==============================================================*/
/* Table: CAL_SETTING                                           */
/*==============================================================*/
CREATE TABLE CAL_SETTING (
   SETTING_ID_          VARCHAR(64)          NOT NULL,
   CAL_NAME_            VARCHAR(64)          NULL,
   IS_COMMON_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_CAL_SETTING PRIMARY KEY NONCLUSTERED (SETTING_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日历设定',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '设定ID',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'SETTING_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日历名称',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'CAL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '默认',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'IS_COMMON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'CAL_SETTING', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: CAL_TIME_BLOCK                                        */
/*==============================================================*/
CREATE TABLE CAL_TIME_BLOCK (
   SETTING_ID_          VARCHAR(64)          NOT NULL,
   SETTING_NAME_        VARCHAR(128)         NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   TIME_INTERVALS_      VARCHAR(1024)        NULL,
   CONSTRAINT PK_CAL_TIME_BLOCK PRIMARY KEY NONCLUSTERED (SETTING_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '工作时间段设定',
   'user', @CURRENTUSER, 'table', 'CAL_TIME_BLOCK'
go

/*==============================================================*/
/* Table: CRM_PROVIDER                                          */
/*==============================================================*/
CREATE TABLE CRM_PROVIDER (
   PRO_ID_              VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(80)          NOT NULL,
   SHORT_DESC_          VARCHAR(100)         NOT NULL,
   CMP_LEVEL_           VARCHAR(20)          NULL,
   CMP_TYPE_            VARCHAR(20)          NULL,
   CREDIT_TYPE_         VARCHAR(20)          NULL,
   CREDIT_LIMIT_        INT                  NULL,
   CREDIT_PERIOD_       INT                  NULL,
   WEB_SITE_            VARCHAR(200)         NULL,
   ADDRESS_             VARCHAR(200)         NULL,
   ZIP_                 VARCHAR(20)          NULL,
   CONTACTOR_           VARCHAR(32)          NULL,
   MOBILE_              VARCHAR(20)          NULL,
   PHONE_               VARCHAR(20)          NULL,
   WEIXIN_              VARCHAR(50)          NULL,
   WEIBO_               VARCHAR(80)          NULL,
   MEMO_                TEXT                 NULL,
   ADDTION_FIDS_        VARCHAR(512)         NULL,
   CHARGE_ID_           VARCHAR(64)          NULL,
   STATUS_              VARCHAR(20)          NULL,
   ACT_INST_ID_         VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_CRM_PROVIDER PRIMARY KEY NONCLUSTERED (PRO_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '供应商管理',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '供应商ID',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'PRO_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '供应商名',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '供应商简称',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'SHORT_DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '单位级别',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CMP_LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '单位类型
   
   来自数据字典',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CMP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '信用级别
   AAAA
   AAA
   AA
   A',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CREDIT_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '信用额度
   元
   ',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CREDIT_LIMIT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '信用账期 
    天
   ',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CREDIT_PERIOD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '网站',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'WEB_SITE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '地址',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'ADDRESS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮编',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'ZIP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人名',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CONTACTOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人手机',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '固定电话',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'PHONE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信号',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'WEIXIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微博号',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'WEIBO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件IDS',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'ADDTION_FIDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '负责人ID',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CHARGE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'ACT_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'CRM_PROVIDER', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_DUTY_INST                                          */
/*==============================================================*/
CREATE TABLE HR_DUTY_INST (
   DUTY_INST_ID_        VARCHAR(64)          NOT NULL,
   HOLIDAY_ID_          VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   USER_NAME_           VARCHAR(64)          NULL,
   DEP_ID_              VARCHAR(64)          NULL,
   DEP_NAME_            VARCHAR(64)          NULL,
   SECTION_ID_          VARCHAR(64)          NULL,
   SECTION_NAME_        VARCHAR(16)          NULL,
   SECTION_SHORT_NAME_  VARCHAR(4)           NULL,
   SYSTEM_ID_           VARCHAR(64)          NULL,
   SYSTEM_NAME_         VARCHAR(100)         NULL,
   TYPE_                VARCHAR(10)          NULL,
   DATE_                DATETIME             NULL,
   VAC_APP_             TEXT                 NULL,
   OT_APP_              TEXT                 NULL,
   TR_APP_              TEXT                 NULL,
   OUT_APP_             TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_DUTY_INST PRIMARY KEY NONCLUSTERED (DUTY_INST_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班实例',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班实例ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'DUTY_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '假期ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'HOLIDAY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户名称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'USER_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部门ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部门名称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'DEP_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'SECTION_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次名称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'SECTION_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次简称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'SECTION_SHORT_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'SYSTEM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制名字',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'SYSTEM_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实例类型',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日期',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'DATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '请假申请',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'VAC_APP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '加班申请',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'OT_APP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '调休申请',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'TR_APP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '出差申请',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'OUT_APP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_DUTY_INST_EXT                                      */
/*==============================================================*/
CREATE TABLE HR_DUTY_INST_EXT (
   EXT_ID_              VARCHAR(64)          NOT NULL,
   DUTY_INST_ID_        VARCHAR(64)          NULL,
   START_SIGN_IN_       INT                  NULL,
   DUTY_START_TIME_     VARCHAR(20)          NULL,
   END_SIGN_IN_         INT                  NULL,
   EARLY_OFF_TIME_      INT                  NULL,
   DUTY_END_TIME_       VARCHAR(20)          NULL,
   SIGN_OUT_TIME_       INT                  NULL,
   SECTION_ID_          VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_DUTY_INST_EXT PRIMARY KEY NONCLUSTERED (EXT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班实例扩展表',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班实例扩展ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'EXT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班实例ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'DUTY_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始签到',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'START_SIGN_IN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上班时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'DUTY_START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签到结束时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'END_SIGN_IN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '早退计时',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'EARLY_OFF_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '下班时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'DUTY_END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签退结束',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'SIGN_OUT_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'SECTION_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_INST_EXT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_DOC                                               */
/*==============================================================*/
CREATE TABLE INF_DOC (
   DOC_ID_              VARCHAR(64)          NOT NULL,
   FOLDER_ID_           VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(100)         NOT NULL,
   CONTENT_             TEXT                 NULL,
   SUMMARY_             VARCHAR(512)         NULL,
   HAS_ATTACH_          VARCHAR(8)           NULL,
   IS_SHARE_            VARCHAR(8)           NOT NULL,
   AUTHOR_              VARCHAR(64)          NULL,
   KEYWORDS_            VARCHAR(256)         NULL,
   DOC_TYPE_            VARCHAR(64)          NULL,
   DOC_PATH_            VARCHAR(255)         NULL,
   SWF_PATH_            VARCHAR(256)         NULL,
   USER_ID_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INF_DOC PRIMARY KEY NONCLUSTERED (DOC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档',
   'user', @CURRENTUSER, 'table', 'INF_DOC'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'FOLDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档名称',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '摘要',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'SUMMARY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否包括附件',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'HAS_ATTACH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否共享',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'IS_SHARE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '作者',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'AUTHOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关键字',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'KEYWORDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档类型',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'DOC_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档路径',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'DOC_PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SWF文件f路径',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'SWF_PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_DOC', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_DOC_FILE                                          */
/*==============================================================*/
CREATE TABLE INF_DOC_FILE (
   DOC_ID_              VARCHAR(64)          NOT NULL,
   FILE_ID_             VARCHAR(64)          NOT NULL,
   CONSTRAINT PK_INF_DOC_FILE PRIMARY KEY NONCLUSTERED (DOC_ID_, FILE_ID_)
)
go

/*==============================================================*/
/* Table: INF_DOC_FOLDER                                        */
/*==============================================================*/
CREATE TABLE INF_DOC_FOLDER (
   FOLDER_ID_           VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(128)         NOT NULL,
   PARENT_              VARCHAR(64)          NULL,
   PATH_                VARCHAR(128)         NULL,
   DEPTH_               INT                  NOT NULL,
   SN_                  INT                  NULL,
   SHARE_               VARCHAR(8)           NOT NULL,
   DESCP                VARCHAR(256)         NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   TYPE_                VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INF_DOC_FOLDER PRIMARY KEY NONCLUSTERED (FOLDER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档文件夹',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '目录名称',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父目录',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'PARENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '层次',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'DEPTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '共享',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'SHARE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档描述',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'DESCP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '个人文档文件夹=PERSONAL
   公共文档文件夹=PUBLIC
   默认为PERSONAL',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_DOC_FOLDER', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_DOC_RIGHT                                         */
/*==============================================================*/
CREATE TABLE INF_DOC_RIGHT (
   RIGHT_ID_            VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   FOLDER_ID_           VARCHAR(64)          NULL,
   RIGHTS_              INT                  NOT NULL,
   IDENTITY_TYPE_       VARCHAR(64)          NULL,
   IDENTITY_ID_         VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INF_DOC_RIGHT PRIMARY KEY NONCLUSTERED (RIGHT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档或目录的权限，只要是针对公共目录下的文档，或个人的文档的共享
   
   某个目录或文档若没有指定某部门或某个人，即在本表中没有记录，
   则表示可以进行所有的操作',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'RIGHT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'FOLDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限
   文档或目录的读写修改权限
   1=读
   2=修改
   4=删除
   
   权限值可以为上面的值之和
   如：3则代表进行读，修改的操作
   
   
   ',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'RIGHTS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权类型',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'IDENTITY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户或组ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'IDENTITY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_DOC_RIGHT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_INBOX                                             */
/*==============================================================*/
CREATE TABLE INF_INBOX (
   REC_ID_              VARCHAR(64)          NOT NULL,
   MSG_ID_              VARCHAR(64)          NOT NULL,
   REC_USER_ID_         VARCHAR(64)          NULL,
   REC_TYPE_            VARCHAR(20)          NOT NULL,
   FULLNAME_            VARCHAR(50)          NULL,
   GROUP_ID_            VARCHAR(64)          NULL,
   GROUP_NAME_          VARCHAR(64)          NULL,
   IS_READ_             VARCHAR(20)          NULL,
   IS_DEL_              VARCHAR(20)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NOT NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_INF_INBOX PRIMARY KEY NONCLUSTERED (REC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内部短消息收件箱',
   'user', @CURRENTUSER, 'table', 'INF_INBOX'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收ID',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'REC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息ID',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'MSG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收人ID',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'REC_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收信=REC
   发信=SEND',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'REC_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收人名称',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'FULLNAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组ID
   0代表全公司',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组名',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'GROUP_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否阅读',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'IS_READ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否删除',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'IS_DEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_INBOX', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: INF_INNER_MAIL                                        */
/*==============================================================*/
CREATE TABLE INF_INNER_MAIL (
   MAIL_ID_             VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   SENDER_              VARCHAR(32)          NOT NULL,
   CC_IDS_              TEXT                 NULL,
   CC_NAMES_            TEXT                 NULL,
   SUBJECT_             VARCHAR(256)         NOT NULL,
   CONTENT_             TEXT                 NOT NULL,
   SENDER_ID_           VARCHAR(64)          NOT NULL,
   URGE_                VARCHAR(32)          NOT NULL,
   SENDER_TIME_         DATETIME             NOT NULL,
   REC_NAMES_           TEXT                 NOT NULL,
   REC_IDS_             TEXT                 NOT NULL,
   STATUS_              SMALLINT             NOT NULL,
   FILE_IDS_            VARCHAR(500)         NULL,
   FILE_NAMES_          VARCHAR(500)         NULL,
   FOLDER_ID_           VARCHAR(64)          NULL,
   DEL_FLAG_            VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INF_INNER_MAIL PRIMARY KEY NONCLUSTERED (MAIL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内部邮件',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送人ID列表
   用'',''分开',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'CC_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送人姓名列表',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'CC_NAMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件标题',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件内容',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '1=一般
   2=重要
   3=非常重要',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'URGE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收件人姓名列表',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'REC_NAMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收件人ID列表
   用'',''分隔',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'REC_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件状态
   1=正式邮件
   0=草稿邮件',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件Ids，多个附件的ID，通过,分割',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'FILE_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件名称列表，通过,进行分割',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'FILE_NAMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'FOLDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '删除标识
   YES
   NO',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'DEL_FLAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MAIL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_INNER_MSG                                         */
/*==============================================================*/
CREATE TABLE INF_INNER_MSG (
   MSG_ID_              VARCHAR(64)          NOT NULL,
   CONTENT_             VARCHAR(512)         NOT NULL,
   LINK_MSG_            VARCHAR(1024)        NULL,
   CATEGORY_            VARCHAR(50)          NULL,
   SENDER_ID_           VARCHAR(50)          NULL,
   SENDER_              VARCHAR(50)          NULL,
   DEL_FLAG_            VARCHAR(20)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NOT NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_INF_INNER_MSG PRIMARY KEY NONCLUSTERED (MSG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内部短消息',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'MSG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息内容',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息携带连接,
   生成的消息带有连接，但本地的连接不加contextPath',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'LINK_MSG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息分类',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'CATEGORY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送人名',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'SENDER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '删除标识',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'DEL_FLAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_INNER_MSG', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: INF_MAIL                                              */
/*==============================================================*/
CREATE TABLE INF_MAIL (
   MAIL_ID_             VARCHAR(64)          NOT NULL,
   UID_                 VARCHAR(512)         NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   CONFIG_ID_           VARCHAR(64)          NOT NULL,
   FOLDER_ID_           VARCHAR(64)          NULL,
   SUBJECT_             VARCHAR(512)         NOT NULL,
   CONTENT_             TEXT                 NULL,
   SENDER_ADDRS_        TEXT                 NOT NULL,
   SENDER_ALIAS_        TEXT                 NULL,
   REC_ADDRS_           TEXT                 NOT NULL,
   REC_ALIAS_           TEXT                 NULL,
   CC_ADDRS_            TEXT                 NULL,
   CC_ALIAS_            TEXT                 NULL,
   BCC_ADDRS_           TEXT                 NULL,
   BCC_ALIAS_           TEXT                 NULL,
   SEND_DATE_           DATETIME             NOT NULL,
   READ_FLAG_           VARCHAR(8)           NOT NULL,
   REPLY_FLAG_          VARCHAR(8)           NOT NULL,
   STATUS_              VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INF_MAIL PRIMARY KEY NONCLUSTERED (MAIL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '外部邮件',
   'user', @CURRENTUSER, 'table', 'INF_MAIL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '外部邮箱标识ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'UID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮箱设置ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'CONFIG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'FOLDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主题',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发件人地址',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'SENDER_ADDRS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发件人地址别名',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'SENDER_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收件人地址',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'REC_ADDRS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收件人地址别名',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'REC_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送人地址',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'CC_ADDRS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送人地址别名',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'CC_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '暗送人地址',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'BCC_ADDRS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '暗送人地址别名',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'BCC_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送日期',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'SEND_DATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '0:未阅
   1:已阅',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'READ_FLAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '0:未回复
   1;已回复',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'REPLY_FLAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   COMMON 正常
   DELETED 删除',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_MAIL_BOX                                          */
/*==============================================================*/
CREATE TABLE INF_MAIL_BOX (
   BOX_ID_              VARCHAR(64)          NOT NULL,
   MAIL_ID_             VARCHAR(64)          NULL,
   FOLDER_ID_           VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(64)          NULL,
   IS_DEL_              VARCHAR(20)          NOT NULL,
   IS_READ_             VARCHAR(20)          NOT NULL,
   REPLY_               VARCHAR(20)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INF_MAIL_BOX PRIMARY KEY NONCLUSTERED (BOX_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内部邮件收件箱',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'MAIL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'FOLDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '员工ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '删除标识=YES',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'IS_DEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '阅读标识',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'IS_READ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '回复标识',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'REPLY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_BOX', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_MAIL_CONFIG                                       */
/*==============================================================*/
CREATE TABLE INF_MAIL_CONFIG (
   CONFIG_ID_           VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   USER_NAME_           VARCHAR(128)         NULL,
   ACCOUNT_             VARCHAR(128)         NULL,
   MAIL_ACCOUNT_        VARCHAR(128)         NOT NULL,
   MAIL_PWD_            VARCHAR(128)         NOT NULL,
   PROTOCOL_            VARCHAR(32)          NOT NULL,
   SSL_                 VARCHAR(12)          NULL,
   SMTP_HOST_           VARCHAR(128)         NOT NULL,
   SMTP_PORT_           VARCHAR(64)          NOT NULL,
   RECP_HOST_           VARCHAR(128)         NOT NULL,
   RECP_PORT_           VARCHAR(64)          NOT NULL,
   IS_DEFAULT_          VARCHAR(20)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INF_MAIL_CONFIG PRIMARY KEY NONCLUSTERED (CONFIG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '外部邮箱设置',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '配置ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'CONFIG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户名称',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'USER_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '帐号名称',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'ACCOUNT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '外部邮件地址',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'MAIL_ACCOUNT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '外部邮件密码',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'MAIL_PWD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '协议类型
   IMAP
   POP3',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'PROTOCOL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '启用SSL
   true or false',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'SSL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件发送主机',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'SMTP_HOST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件发送端口',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'SMTP_PORT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收主机',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'RECP_HOST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收端口',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'RECP_PORT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否默认
   YES
   NO',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_CONFIG', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INF_MAIL_FILE                                         */
/*==============================================================*/
CREATE TABLE INF_MAIL_FILE (
   FILE_ID_             VARCHAR(64)          NOT NULL,
   MAIL_ID_             VARCHAR(64)          NOT NULL,
   CONSTRAINT PK_INF_MAIL_FILE PRIMARY KEY NONCLUSTERED (FILE_ID_, MAIL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '外部邮箱附件',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FILE'
go

/*==============================================================*/
/* Table: INF_MAIL_FOLDER                                       */
/*==============================================================*/
CREATE TABLE INF_MAIL_FOLDER (
   FOLDER_ID_           VARCHAR(64)          NOT NULL,
   CONFIG_ID_           VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(128)         NOT NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   DEPTH_               INT                  NOT NULL,
   PATH_                VARCHAR(256)         NULL,
   TYPE_                VARCHAR(32)          NOT NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   IN_OUT_              VARCHAR(20)          NULL,
   CONSTRAINT PK_INF_MAIL_FOLDER PRIMARY KEY NONCLUSTERED (FOLDER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件文件夹',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹编号',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'FOLDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '配置ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'CONFIG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹名称',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父目录',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '目录层',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'DEPTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '目录路径',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件夹类型
   RECEIVE-FOLDER=收信箱
   SENDER-FOLDEr=发信箱
   DRAFT-FOLDER=草稿箱
   DEL-FOLDER=删除箱
   OTHER-FOLDER=其他',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内部外部邮箱标识
   IN=内部
   OUT=外部',
   'user', @CURRENTUSER, 'table', 'INF_MAIL_FOLDER', 'column', 'IN_OUT_'
go

/*==============================================================*/
/* Table: INS_COLUMN_DEF                                        */
/*==============================================================*/
CREATE TABLE INS_COLUMN_DEF (
   COL_ID_              VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(100)         NULL,
   KEY_                 VARCHAR(64)          NULL,
   DATA_URL_            VARCHAR(200)         NULL,
   IS_DEFAULT_          VARCHAR(20)          NULL,
   TEMPLET_             VARCHAR(4000)        NULL,
   FUNCTION_            VARCHAR(100)         NULL,
   IS_NEWS_             VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_COLUMN_DEF PRIMARY KEY NONCLUSTERED (COL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目定义',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目ID',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'COL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目名',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目别名',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更多URL',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'DATA_URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否默认',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'TEMPLET_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '获取数据方法',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'FUNCTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为新闻公告栏目',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'IS_NEWS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_COLUMN_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_COL_NEW                                           */
/*==============================================================*/
CREATE TABLE INS_COL_NEW (
   ID_                  VARCHAR(64)          NOT NULL,
   NEW_ID_              VARCHAR(64)          NOT NULL,
   SN_                  INT                  NOT NULL,
   START_TIME_          DATETIME             NOT NULL,
   END_TIME_            DATETIME             NOT NULL,
   IS_LONG_VALID_       VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_COL_NEW PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '信息所属栏目',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID_',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '新闻ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'NEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '有效开始时间',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '有效结束时间',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否长期有效',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'IS_LONG_VALID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_COL_NEW_DEF                                       */
/*==============================================================*/
CREATE TABLE INS_COL_NEW_DEF (
   ID_                  VARCHAR(64)          NOT NULL,
   COL_ID_              VARCHAR(64)          NULL,
   NEW_ID_              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_COL_NEW_DEF PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目新闻关联表',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'COL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '新闻ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'NEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_COL_NEW_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_MSGBOX_BOX_DEF                                    */
/*==============================================================*/
CREATE TABLE INS_MSGBOX_BOX_DEF (
   ID_                  VARCHAR(64)          NOT NULL,
   BOX_ID_              VARCHAR(64)          NULL,
   MSG_ID_              VARCHAR(64)          NULL,
   SN_                  VARCHAR(16)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_MSGBOX_BOX_DEF PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息和消息盒子关联表',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '盒子ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'BOX_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'MSG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_BOX_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_MSGBOX_DEF                                        */
/*==============================================================*/
CREATE TABLE INS_MSGBOX_DEF (
   BOX_ID_              VARCHAR(64)          NOT NULL,
   COL_ID_              VARCHAR(64)          NULL,
   KEY_                 VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_MSGBOX_DEF PRIMARY KEY NONCLUSTERED (BOX_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目消息盒子表',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '盒子ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'BOX_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '栏目ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'COL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识键',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名字',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_MSGBOX_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_MSG_DEF                                           */
/*==============================================================*/
CREATE TABLE INS_MSG_DEF (
   MSG_ID_              VARCHAR(64)          NOT NULL,
   COLOR_               VARCHAR(64)          NULL,
   URL_                 VARCHAR(256)         NULL,
   ICON_                VARCHAR(64)          NULL,
   CONTENT_             VARCHAR(64)          NULL,
   DS_NAME_             VARCHAR(64)          NULL,
   DS_ALIAS_            VARCHAR(64)          NULL,
   SQL_FUNC_            VARCHAR(512)         NULL,
   TYPE_                VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_MSG_DEF PRIMARY KEY NONCLUSTERED (MSG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'INS_MSG_DEF',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'MSG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '颜色',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'COLOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更多URL',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '图标',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'ICON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据库名字',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'DS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据库别名',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'DS_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SQL语句',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'SQL_FUNC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_MSG_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_NEWS                                              */
/*==============================================================*/
CREATE TABLE INS_NEWS (
   NEW_ID_              VARCHAR(64)          NOT NULL,
   SUBJECT_             VARCHAR(120)         NOT NULL,
   TAG_                 VARCHAR(80)          NULL,
   KEYWORDS_            VARCHAR(255)         NULL,
   CONTENT_             TEXT                 NULL,
   IS_IMG_              VARCHAR(20)          NULL,
   IMG_FILE_ID_         VARCHAR(64)          NULL,
   READ_TIMES_          INT                  NOT NULL,
   AUTHOR_              VARCHAR(50)          NULL,
   ALLOW_CMT_           VARCHAR(20)          NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   FILES_               VARCHAR(512)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_NEWS PRIMARY KEY NONCLUSTERED (NEW_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '信息公告',
   'user', @CURRENTUSER, 'table', 'INS_NEWS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标签',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'TAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关键字',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'KEYWORDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为图片新闻',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'IS_IMG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '图片文件ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'IMG_FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '阅读次数',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'READ_TIMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '作者',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'AUTHOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许评论',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'ALLOW_CMT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'FILES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_NEWS', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_NEWS_CM                                           */
/*==============================================================*/
CREATE TABLE INS_NEWS_CM (
   COMM_ID_             VARCHAR(64)          NOT NULL,
   NEW_ID_              VARCHAR(64)          NOT NULL,
   FULL_NAME_           VARCHAR(50)          NOT NULL,
   CONTENT_             VARCHAR(1024)        NOT NULL,
   AGREE_NUMS_          INT                  NOT NULL,
   REFUSE_NUMS_         INT                  NOT NULL,
   IS_REPLY_            VARCHAR(20)          NOT NULL,
   REP_ID_              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NOT NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_NEWS_CM PRIMARY KEY NONCLUSTERED (COMM_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司或新闻评论',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '评论ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'COMM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '信息ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'NEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '评论人名',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'FULL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '评论内容',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '赞同与顶',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'AGREE_NUMS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '反对与鄙视次数',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'REFUSE_NUMS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为回复',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'IS_REPLY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '回复评论ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'REP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CM', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_NEWS_CTL                                          */
/*==============================================================*/
CREATE TABLE INS_NEWS_CTL (
   CTL_ID_              VARCHAR(64)          NOT NULL,
   NEWS_ID_             VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(512)         NULL,
   GROUP_ID_            VARCHAR(512)         NULL,
   RIGHT_               VARCHAR(16)          NULL,
   TYPE_                VARCHAR(16)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_NEWS_CTL PRIMARY KEY NONCLUSTERED (CTL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '新闻公告权限表',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'CTL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '新闻ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'NEWS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限分类',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'RIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限类型',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_NEWS_CTL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_PORTAL_DEF                                        */
/*==============================================================*/
CREATE TABLE INS_PORTAL_DEF (
   PORT_ID_             VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(128)         NULL,
   KEY_                 VARCHAR(64)          NULL,
   IS_DEFAULT_          VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(64)          NULL,
   LAYOUT_HTML_         TEXT                 NULL,
   PRIORITY_            INT                  NULL,
   EDIT_HTML_           TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_PORTAL_DEF PRIMARY KEY NONCLUSTERED (PORT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '门户定义',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '门户ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'PORT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否默认',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '布局HTML',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'LAYOUT_HTML_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '优先级',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'PRIORITY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '编辑界面HTML字段',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'EDIT_HTML_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: INS_PORTAL_PERMISSION                                 */
/*==============================================================*/
CREATE TABLE INS_PORTAL_PERMISSION (
   ID_                  VARCHAR(64)          NOT NULL,
   LAYOUT_ID_           VARCHAR(64)          NULL,
   TYPE_                VARCHAR(32)          NULL,
   OWNER_ID_            VARCHAR(32)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_INS_PORTAL_PERMISSION PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '布局权限设置',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '门户ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'LAYOUT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户或组ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'OWNER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'INS_PORTAL_PERMISSION', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: KD_DOC                                                */
/*==============================================================*/
CREATE TABLE KD_DOC (
   DOC_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   SUBJECT_             VARCHAR(128)         NOT NULL,
   TEMP_ID_             VARCHAR(64)          NULL,
   IS_ESSENCE_          VARCHAR(20)          NULL,
   AUTHOR_              VARCHAR(64)          NOT NULL,
   AUTHOR_TYPE_         VARCHAR(20)          NULL,
   AUTHOR_POS_          VARCHAR(64)          NULL,
   BELONG_DEPID_        VARCHAR(64)          NULL,
   KEYWORDS_            VARCHAR(128)         NULL,
   APPROVAL_ID_         VARCHAR(64)          NULL,
   ISSUED_TIME_         DATETIME             NULL,
   VIEW_TIMES_          INT                  NULL,
   SUMMARY_             VARCHAR(512)         NULL,
   CONTENT_             TEXT                 NULL,
   COMP_SCORE_          NUMERIC(8,2)         NULL,
   TAGS                 VARCHAR(200)         NULL,
   STORE_PEROID_        INT                  NULL,
   COVER_IMG_ID_        VARCHAR(64)          NULL,
   IMG_MAPS_            TEXT                 NULL,
   BPM_INST_ID_         VARCHAR(64)          NULL,
   ATT_FILEIDS_         VARCHAR(512)         NULL,
   ARCH_CLASS_          VARCHAR(20)          NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   DOC_TYPE_            VARCHAR(20)          NULL,
   VERSION_             INT                  NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC PRIMARY KEY NONCLUSTERED (DOC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识文档、地图、词条',
   'user', @CURRENTUSER, 'table', 'KD_DOC'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属分类',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档标题',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '词条或知识模板ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'TEMP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否精华',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'IS_ESSENCE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '作者',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'AUTHOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '作者类型
   内部=INNER
   外部=OUTER',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'AUTHOR_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属岗位',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'AUTHOR_POS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属部门ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'BELONG_DEPID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关键字',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'KEYWORDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'APPROVAL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发布日期',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'ISSUED_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '浏览次数',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'VIEW_TIMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '摘要',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'SUMMARY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识内容',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '综合评分',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'COMP_SCORE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标签',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'TAGS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '存放年限
   单位为年',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'STORE_PEROID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '封面图',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'COVER_IMG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识地图描点信息',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'IMG_MAPS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'BPM_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档附件',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'ATT_FILEIDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '归档分类
   知识文档
   知识地图
   词条',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'ARCH_CLASS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档状态
   废弃=abandon
   草稿=draft
   驳回=back
   待审=pending
   发布=issued
   过期=overdue
   归档=archived',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识文档=KD_DOC
   词条=KD_WORD
   知识地图=KD_MAP',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'DOC_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: KD_DOC_CMMT                                           */
/*==============================================================*/
CREATE TABLE KD_DOC_CMMT (
   COMMENT_ID_          VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   SCORE_               INT                  NOT NULL,
   CONTENT_             VARCHAR(1024)        NULL,
   LEVEL_               VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_CMMT PRIMARY KEY NONCLUSTERED (COMMENT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识文档点评',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '点评ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'COMMENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分数',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'SCORE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '点评内容',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '非常好
   很好
   一般
   差
   很差',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CMMT', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_DOC_CONTR                                          */
/*==============================================================*/
CREATE TABLE KD_DOC_CONTR (
   CONT_ID_             VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   MOD_TYPE_            VARCHAR(50)          NOT NULL,
   REASON_              VARCHAR(500)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_CONTR PRIMARY KEY NONCLUSTERED (CONT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识文档贡献者',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '词条',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更正错误
   内容扩充
   删除冗余
   目录结构
   概述
   基本信息栏
   内链
   排版
   参考资料
   图片',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR', 'column', 'MOD_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_CONTR', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_DOC_DIR                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_DIR (
   DIR_ID_              VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NOT NULL,
   LEVEL_               VARCHAR(20)          NOT NULL,
   SUBJECT_             VARCHAR(120)         NOT NULL,
   ANCHOR_              VARCHAR(255)         NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_DIR PRIMARY KEY NONCLUSTERED (DIR_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档索引目录',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题等级
   1级标题
   2组标题',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题连接锚点',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'ANCHOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上级目录ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_DIR', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: KD_DOC_FAV                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_FAV (
   FAV_ID_              VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NOT NULL,
   QUE_ID_              VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_FAV PRIMARY KEY NONCLUSTERED (FAV_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档知识收藏',
   'user', @CURRENTUSER, 'table', 'KD_DOC_FAV'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_FAV', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_FAV', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_FAV', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_FAV', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_FAV', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_FAV', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: KD_DOC_HANDLE                                         */
/*==============================================================*/
CREATE TABLE KD_DOC_HANDLE (
   HANDLE_ID_           VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   TYPE_                VARCHAR(20)          NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   IS_READ_             SMALLINT             NULL,
   OPINION_             VARCHAR(1024)        NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_KD_DOC_HANDLE PRIMARY KEY NONCLUSTERED (HANDLE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公文办理',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '办理ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'HANDLE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收发文ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '办理类型
   分发
   传阅
   拟办
   批办
   承办
   注办',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '办理人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否已阅',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'IS_READ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '处理意见',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'OPINION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HANDLE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: KD_DOC_HIS                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_HIS (
   HIS_ID_              VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   VERSION_             INT                  NOT NULL,
   SUBJECT_             VARCHAR(128)         NOT NULL,
   CONTENT_             TEXT                 NOT NULL,
   AUTHOR_              VARCHAR(50)          NOT NULL,
   COVER_FILE_ID_       VARCHAR(64)          NULL,
   ATTACH_IDS_          VARCHAR(512)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_HIS PRIMARY KEY NONCLUSTERED (HIS_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识文档历史版本',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本号',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档标题',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档内容',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档作者',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'AUTHOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档封面',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'COVER_FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档附件IDS',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'ATTACH_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_HIS', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_DOC_READ                                           */
/*==============================================================*/
CREATE TABLE KD_DOC_READ (
   READ_ID_             VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   DOC_STATUS_          VARCHAR(50)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_READ PRIMARY KEY NONCLUSTERED (READ_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识文档阅读',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '阅读人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ', 'column', 'READ_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '阅读文档阶段',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ', 'column', 'DOC_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_READ', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_DOC_REM                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_REM (
   REM_ID_              VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NOT NULL,
   DEP_ID_              VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(64)          NULL,
   LEVEL_               INT                  NULL,
   MEMO_                VARCHAR(1024)        NULL,
   REC_TREE_ID_         VARCHAR(64)          NULL,
   NOTICE_CREATOR_      VARCHAR(20)          NULL,
   NOTICE_TYPE_         VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_REM PRIMARY KEY NONCLUSTERED (REM_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档推荐',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '推荐ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM', 'column', 'REM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '推荐精华库分类ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM', 'column', 'REC_TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_REM', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_DOC_RIGHT                                          */
/*==============================================================*/
CREATE TABLE KD_DOC_RIGHT (
   RIGHT_ID_            VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NOT NULL,
   IDENTITY_TYPE_       VARCHAR(20)          NOT NULL,
   IDENTITY_ID_         VARCHAR(64)          NOT NULL,
   RIGHT_               VARCHAR(60)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_KD_DOC_RIGHT PRIMARY KEY NONCLUSTERED (RIGHT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档权限',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'RIGHT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权类型
   USER=用户
   GROUP=用户组',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'IDENTITY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户或组ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'IDENTITY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'READ=可读
   EDIT=可编辑
   PRINT=打印
   DOWN_FILE=可下载附件',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'RIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_RIGHT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: KD_DOC_ROUND                                          */
/*==============================================================*/
CREATE TABLE KD_DOC_ROUND (
   ROUND_ID_            VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_DOC_ROUND PRIMARY KEY NONCLUSTERED (ROUND_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档传阅',
   'user', @CURRENTUSER, 'table', 'KD_DOC_ROUND'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_ROUND', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_ROUND', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_ROUND', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_ROUND', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_ROUND', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_ROUND', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_DOC_TEMPLATE                                       */
/*==============================================================*/
CREATE TABLE KD_DOC_TEMPLATE (
   TEMP_ID_             VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   NAME_                VARCHAR(80)          NOT NULL,
   CONTENT_             TEXT                 NULL,
   TYPE_                VARCHAR(20)          NULL,
   STATUS_              VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_KD_DOC_TEMPLATE PRIMARY KEY NONCLUSTERED (TEMP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档模板',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'TEMP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板分类ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板名称',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板内容',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板类型
   词条模板
   文档模板',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板状态',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_DOC_TEMPLATE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: KD_QUESTION                                           */
/*==============================================================*/
CREATE TABLE KD_QUESTION (
   QUE_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   SUBJECT_             VARCHAR(80)          NOT NULL,
   QUESTION_            TEXT                 NULL,
   FILE_IDS_            VARCHAR(512)         NULL,
   TAGS_                VARCHAR(128)         NULL,
   REWARD_SCORE_        INT                  NOT NULL,
   REPLY_TYPE_          VARCHAR(80)          NULL,
   REPLIER_ID_          VARCHAR(64)          NULL,
   STATUS_              VARCHAR(20)          NULL,
   REPLY_COUNTS_        INT                  NOT NULL,
   VIEW_TIMES_          INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_QUESTION PRIMARY KEY NONCLUSTERED (QUE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档知识收藏',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '问题ID',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'QUE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '问题内容',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '详细问题',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'QUESTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'FILE_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标签',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'TAGS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '悬赏货币',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'REWARD_SCORE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所有人
   专家个人
   领域专家',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'REPLY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '回复人ID',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'REPLIER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '待解决=UNSOLVED
   已解决=SOLVED',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '回复数',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'REPLY_COUNTS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '浏览次数',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'VIEW_TIMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_QUESTION', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_QUES_ANSWER                                        */
/*==============================================================*/
CREATE TABLE KD_QUES_ANSWER (
   ANSWER_ID_           VARCHAR(64)          NOT NULL,
   QUE_ID_              VARCHAR(64)          NOT NULL,
   REPLY_CONTENT_       TEXT                 NOT NULL,
   IS_BEST_             VARCHAR(20)          NULL,
   AUTHOR_ID_           VARCHAR(64)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_QUES_ANSWER PRIMARY KEY NONCLUSTERED (ANSWER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '问题答案',
   'user', @CURRENTUSER, 'table', 'KD_QUES_ANSWER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '问题ID',
   'user', @CURRENTUSER, 'table', 'KD_QUES_ANSWER', 'column', 'QUE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_QUES_ANSWER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_QUES_ANSWER', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_QUES_ANSWER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_QUES_ANSWER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_QUES_ANSWER', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_USER                                               */
/*==============================================================*/
CREATE TABLE KD_USER (
   KUSER_ID             VARCHAR(64)          NOT NULL,
   POINT_               INT                  NOT NULL,
   DOC_SCORE_           INT                  NULL,
   GRADE_               VARCHAR(20)          NULL,
   USER_TYPE_           VARCHAR(20)          NULL,
   FULLNAME_            VARCHAR(32)          NULL,
   SN_                  INT                  NULL,
   KN_SYS_ID_           VARCHAR(64)          NULL,
   REQ_SYS_ID_          VARCHAR(64)          NULL,
   SIGN_                VARCHAR(80)          NULL,
   PROFILE_             VARCHAR(100)         NULL,
   HEAD_ID_             VARCHAR(64)          NULL,
   SEX_                 VARCHAR(64)          NULL,
   OFFICE_PHONE_        VARCHAR(20)          NULL,
   MOBILE_              VARCHAR(16)          NULL,
   EMAIL_               VARCHAR(80)          NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_USER PRIMARY KEY NONCLUSTERED (KUSER_ID)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识用户信息',
   'user', @CURRENTUSER, 'table', 'KD_USER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'KUSER_ID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '积分',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'POINT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '专家个人=PERSON
   领域专家=DOMAIN
   
   ',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'USER_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '知识领域',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'KN_SYS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '爱问领域',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'REQ_SYS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '个性签名',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'SIGN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '个人简介',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'PROFILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '头像',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'HEAD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '性别',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'SEX_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '办公电话',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'OFFICE_PHONE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机号码',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '电子邮箱',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'EMAIL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '从属用户ID',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_USER', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: KD_USER_LEVEL                                         */
/*==============================================================*/
CREATE TABLE KD_USER_LEVEL (
   CONF_ID_             VARCHAR(32)          NOT NULL,
   START_VAL_           INT                  NOT NULL,
   END_VAL_             INT                  NOT NULL,
   LEVEL_NAME_          VARCHAR(100)         NOT NULL,
   HEADER_ICON_         VARCHAR(128)         NULL,
   MEMO_                VARCHAR(500)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_KD_USER_LEVEL PRIMARY KEY NONCLUSTERED (CONF_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户知识等级配置',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '配置ID',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'CONF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '起始值',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'START_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束值',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'END_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '等级名称',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'LEVEL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '头像Icon',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'HEADER_ICON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'KD_USER_LEVEL', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: LOG_MODULE                                            */
/*==============================================================*/
CREATE TABLE LOG_MODULE (
   ID_                  VARCHAR(64)          NOT NULL,
   MODULE_              VARCHAR(128)         NULL,
   SUB_MODULE           VARCHAR(128)         NULL,
   ENABLE_              VARCHAR(64)          NULL,
   CONSTRAINT PK_LOG_MODULE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志模块',
   'user', @CURRENTUSER, 'table', 'LOG_MODULE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'LOG_MODULE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块',
   'user', @CURRENTUSER, 'table', 'LOG_MODULE', 'column', 'MODULE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '子模块',
   'user', @CURRENTUSER, 'table', 'LOG_MODULE', 'column', 'SUB_MODULE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '启用',
   'user', @CURRENTUSER, 'table', 'LOG_MODULE', 'column', 'ENABLE_'
go

/*==============================================================*/
/* Table: MI_DB_ID                                              */
/*==============================================================*/
CREATE TABLE MI_DB_ID (
   ID_                  INT                  NOT NULL,
   START_               NUMERIC(20,0)        NOT NULL,
   MAX_                 NUMERIC(20,0)        NOT NULL,
   MAC_NAME_            VARCHAR(256)         NOT NULL,
   CONSTRAINT PK_MI_DB_ID PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统表主键增长表',
   'user', @CURRENTUSER, 'table', 'MI_DB_ID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机器ID,
   默认为1',
   'user', @CURRENTUSER, 'table', 'MI_DB_ID', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始值',
   'user', @CURRENTUSER, 'table', 'MI_DB_ID', 'column', 'START_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '增长值',
   'user', @CURRENTUSER, 'table', 'MI_DB_ID', 'column', 'MAX_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '服务器的机器名称，由程序启动时自动读取并且加入数据库',
   'user', @CURRENTUSER, 'table', 'MI_DB_ID', 'column', 'MAC_NAME_'
go

/*==============================================================*/
/* Table: MOBILE_TOKEN                                          */
/*==============================================================*/
CREATE TABLE MOBILE_TOKEN (
   ID_                  VARCHAR(64)          NOT NULL,
   ACCOUNT_             VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NULL,
   TOKEN                VARCHAR(64)          NULL,
   STATUS_              SMALLINT             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   EXPIRED_TIME_        DATETIME             NULL,
   CONSTRAINT PK_MOBILE_TOKEN PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机端令牌',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ACCOUNT',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'ACCOUNT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '令牌',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'TOKEN'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '失效时间',
   'user', @CURRENTUSER, 'table', 'MOBILE_TOKEN', 'column', 'EXPIRED_TIME_'
go

/*==============================================================*/
/* Table: OA_ADDR_BOOK                                          */
/*==============================================================*/
CREATE TABLE OA_ADDR_BOOK (
   ADDR_ID_             VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(50)          NOT NULL,
   COMPANY_             VARCHAR(120)         NULL,
   DEP_                 VARCHAR(50)          NULL,
   POS_                 VARCHAR(50)          NULL,
   MAIL_                VARCHAR(255)         NULL,
   COUNTRY_             VARCHAR(32)          NULL,
   SATE_                VARCHAR(32)          NULL,
   CITY_                VARCHAR(32)          NULL,
   STREET_              VARCHAR(80)          NULL,
   ZIP_                 VARCHAR(20)          NULL,
   BIRTHDAY_            DATETIME             NULL,
   MOBILE_              VARCHAR(16)          NULL,
   PHONE_               VARCHAR(16)          NULL,
   WEIXIN_              VARCHAR(80)          NULL,
   QQ_                  VARCHAR(32)          NULL,
   PHOTO_ID_            VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OA_ADDR_BOOK PRIMARY KEY NONCLUSTERED (ADDR_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通讯录联系人',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'ADDR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '姓名',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'COMPANY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部门',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'DEP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '职务',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'POS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主邮箱',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'MAIL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '国家',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'COUNTRY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '省份',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'SATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '城市',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'CITY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '街道',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'STREET_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮编',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'ZIP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '生日',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'BIRTHDAY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主手机',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主电话',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'PHONE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主微信号',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'WEIXIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'QQ',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'QQ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '头像文件ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'PHOTO_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_BOOK', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OA_ADDR_CONT                                          */
/*==============================================================*/
CREATE TABLE OA_ADDR_CONT (
   CONT_ID_             VARCHAR(64)          NOT NULL,
   ADDR_ID_             VARCHAR(64)          NULL,
   TYPE_                VARCHAR(50)          NOT NULL,
   CONTACT_             VARCHAR(255)         NULL,
   EXT1_                VARCHAR(100)         NULL,
   EXT2_                VARCHAR(100)         NULL,
   EXT3_                VARCHAR(100)         NULL,
   EXT4_                VARCHAR(100)         NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OA_ADDR_CONT PRIMARY KEY NONCLUSTERED (CONT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通讯录联系信息',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系信息ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'CONT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'ADDR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型
   手机号=MOBILE
   家庭地址=HOME_ADDRESS
   工作地址=WORK_ADDRESS
   QQ=QQ
   微信=WEI_XIN
   GoogleTalk=GOOGLE-TALK
   工作=WORK_INFO
   备注=MEMO',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系主信息',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'CONTACT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系扩展字段1',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'EXT1_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系扩展字段2',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'EXT2_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系扩展字段3',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'EXT3_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系扩展字段4',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'EXT4_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_CONT', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OA_ADDR_GPB                                           */
/*==============================================================*/
CREATE TABLE OA_ADDR_GPB (
   GROUP_ID_            VARCHAR(64)          NOT NULL,
   ADDR_ID_             VARCHAR(64)          NOT NULL,
   CONSTRAINT PK_OA_ADDR_GPB PRIMARY KEY NONCLUSTERED (GROUP_ID_, ADDR_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通讯录分组下的联系人',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GPB'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分组ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GPB', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GPB', 'column', 'ADDR_ID_'
go

/*==============================================================*/
/* Table: OA_ADDR_GRP                                           */
/*==============================================================*/
CREATE TABLE OA_ADDR_GRP (
   GROUP_ID_            VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(50)          NOT NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OA_ADDR_GRP PRIMARY KEY NONCLUSTERED (GROUP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通讯录分组',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分组ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名字',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_ADDR_GRP', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OA_ASSETS                                             */
/*==============================================================*/
CREATE TABLE OA_ASSETS (
   ASS_ID_              VARCHAR(64)          NOT NULL,
   PROD_DEF_ID_         VARCHAR(64)          NULL,
   CODE_                VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NULL,
   JSON_                TEXT                 NULL,
   DESC_                VARCHAR(256)         NULL,
   STATUS_              VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_ASSETS PRIMARY KEY NONCLUSTERED (ASS_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资产信息',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资产ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'ASS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数定义ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'PROD_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资产编号',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'CODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资产名称',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数JSON',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_ASSETS_BID                                         */
/*==============================================================*/
CREATE TABLE OA_ASSETS_BID (
   BID_ID_              VARCHAR(64)          NOT NULL,
   ASS_ID_              VARCHAR(64)          NULL,
   PARA_ID_             VARCHAR(64)          NULL,
   START_               DATETIME             NOT NULL,
   END_                 DATETIME             NOT NULL,
   MEMO_                TEXT                 NULL,
   USE_MANS_            VARCHAR(20)          NULL,
   STATUS_              VARCHAR(20)          NULL,
   BPM_INST_ID_         VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_ASSETS_BID PRIMARY KEY NONCLUSTERED (BID_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '【资产申请】',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '申请ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'BID_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资产ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'ASS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数ID(不做关联)',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'PARA_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'START_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'END_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '申请说明',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '申请人员',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'USE_MANS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'BPM_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_ASSETS_BID', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_ASS_PARAMETER                                      */
/*==============================================================*/
CREATE TABLE OA_ASS_PARAMETER (
   PARA_ID_             VARCHAR(64)          NOT NULL,
   VALUE_ID_            VARCHAR(64)          NULL,
   KEY_ID_              VARCHAR(64)          NULL,
   ASS_ID_              VARCHAR(64)          NULL,
   CUSTOM_VALUE_NAME_   VARCHAR(255)         NULL,
   CUSTOM_KEY_NAME_     VARCHAR(255)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_ASS_PARAMETER PRIMARY KEY NONCLUSTERED (PARA_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资产参数',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数ID',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'PARA_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数VALUE主键',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'VALUE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数KEY主键',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'KEY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资产ID',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'ASS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定义VALUE名',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'CUSTOM_VALUE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定义KEY名',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'CUSTOM_KEY_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_ASS_PARAMETER', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_CAR                                                */
/*==============================================================*/
CREATE TABLE OA_CAR (
   CAR_ID_              VARCHAR(64)          NOT NULL,
   SYS_DIC_ID_          VARCHAR(64)          NULL,
   NAME_                VARCHAR(60)          NOT NULL,
   CAR_NO_              VARCHAR(20)          NOT NULL,
   TRAVEL_MILES_        INT                  NULL,
   ENGINE_NUM_          VARCHAR(20)          NULL,
   FRAME_NO_            VARCHAR(20)          NULL,
   BRAND_               VARCHAR(64)          NULL,
   MODEL_               VARCHAR(64)          NULL,
   WEIGHT_              INT                  NULL,
   SEATS_               INT                  NULL,
   BUY_DATE_            DATETIME             NULL,
   PRICE_               NUMERIC(18,4)        NULL,
   ANNUAL_INSP_         TEXT                 NULL,
   INSURANCE_           TEXT                 NULL,
   MAINTENS_            TEXT                 NULL,
   MEMO_                TEXT                 NULL,
   PHOTO_IDS_           VARCHAR(512)         NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_CAR PRIMARY KEY NONCLUSTERED (CAR_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆信息',
   'user', @CURRENTUSER, 'table', 'OA_CAR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'CAR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆名称',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车牌号',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'CAR_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '行驶里程',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'TRAVEL_MILES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发动机号',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'ENGINE_NUM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆识别代号',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'FRAME_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '品牌',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'BRAND_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '型号',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'MODEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆载重',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'WEIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆座位',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'SEATS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '购买日期',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'BUY_DATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '购买价格',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'PRICE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '年检情况',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'ANNUAL_INSP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '保险情况',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'INSURANCE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '保养维修情况',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'MAINTENS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注信息',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆照片',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'PHOTO_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆状态
   IN_USED=在使用
   IN_FREE=空闲
   SCRAP=报废',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_CAR', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_CAR_APP                                            */
/*==============================================================*/
CREATE TABLE OA_CAR_APP (
   APP_ID_              VARCHAR(64)          NOT NULL,
   CAR_CAT_             VARCHAR(50)          NOT NULL,
   CAR_ID_              VARCHAR(64)          NOT NULL,
   CAR_NAME_            VARCHAR(50)          NOT NULL,
   START_TIME_          DATETIME             NOT NULL,
   END_TIME_            DATETIME             NOT NULL,
   DRIVER_              VARCHAR(20)          NULL,
   CATEGORY_            VARCHAR(64)          NULL,
   DEST_LOC_            VARCHAR(100)         NULL,
   TRAV_MILES_          INT                  NULL,
   USE_MANS_            VARCHAR(20)          NULL,
   MEMO_                TEXT                 NULL,
   STATUS_              VARCHAR(20)          NULL,
   BPM_INST_            VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_CAR_APP PRIMARY KEY NONCLUSTERED (APP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆申请',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '汽车类别',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'CAR_CAT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'CAR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '车辆名称',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'CAR_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '起始时间',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '终止时间',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '驾驶员',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'DRIVER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '行程类别',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'CATEGORY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '目的地点',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'DEST_LOC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '行驶里程',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'TRAV_MILES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '使用人员',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'USE_MANS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '使用说明',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '申请状态',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'BPM_INST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_CAR_APP', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_COM_BOOK                                           */
/*==============================================================*/
CREATE TABLE OA_COM_BOOK (
   COM_ID_              VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(64)          NOT NULL,
   FIRST_LETTER_        VARCHAR(16)          NULL,
   DEPNAME_             VARCHAR(64)          NULL,
   MOBILE_              VARCHAR(64)          NULL,
   MOBILE2_             VARCHAR(64)          NULL,
   PHONE_               VARCHAR(64)          NULL,
   EMAIL_               VARCHAR(64)          NULL,
   QQ_                  VARCHAR(32)          NULL,
   IS_EMPLOYEE_         VARCHAR(16)          NOT NULL,
   REMARK_              VARCHAR(500)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_COM_BOOK PRIMARY KEY NONCLUSTERED (COM_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_BOOK', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_BOOK', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_COM_BOOK', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_BOOK', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_COM_BOOK', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_COM_RIGHT                                          */
/*==============================================================*/
CREATE TABLE OA_COM_RIGHT (
   RIGHT_ID_            VARCHAR(64)          NOT NULL,
   COMBOOK_ID_          VARCHAR(64)          NOT NULL,
   IDENTITY_TYPE_       VARCHAR(20)          NOT NULL,
   IDENTITY_ID_         VARCHAR(64)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_COM_RIGHT PRIMARY KEY NONCLUSTERED (RIGHT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'RIGHT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'COMBOOK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权类型
   USER=用户
   GROUP=用户组',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'IDENTITY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户或组ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'IDENTITY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_COM_RIGHT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_MEETING                                            */
/*==============================================================*/
CREATE TABLE OA_MEETING (
   MEET_ID_             VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(255)         NOT NULL,
   DESCP_               TEXT                 NULL,
   START_               DATETIME             NOT NULL,
   END_                 DATETIME             NOT NULL,
   LOCATION_            VARCHAR(255)         NULL,
   ROOM_ID_             VARCHAR(64)          NULL,
   BUDGET_              NUMERIC(18,4)        NULL,
   HOST_UID_            VARCHAR(64)          NULL,
   RECORD_UID_          VARCHAR(64)          NULL,
   IMP_DEGREE_          VARCHAR(20)          NULL,
   STATUS_              VARCHAR(20)          NULL,
   SUMMARY_             TEXT                 NULL,
   BPM_INST_ID_         VARCHAR(64)          NULL,
   FILE_IDS_            VARCHAR(512)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_MEETING PRIMARY KEY NONCLUSTERED (MEET_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '会议申请',
   'user', @CURRENTUSER, 'table', 'OA_MEETING'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '重要程度',
   'user', @CURRENTUSER, 'table', 'OA_MEETING', 'column', 'IMP_DEGREE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_MEETING', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_MEETING', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_MEETING', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_MEETING', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_MEETING', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_MEET_ATT                                           */
/*==============================================================*/
CREATE TABLE OA_MEET_ATT (
   ATT_ID_              VARCHAR(64)          NOT NULL,
   MEET_ID_             VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   FULLNAME_            VARCHAR(20)          NULL,
   SUMMARY_             TEXT                 NULL,
   STATUS_              VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_MEET_ATT PRIMARY KEY NONCLUSTERED (ATT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '会议参与人',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '会议ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'MEET_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '姓名',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'FULLNAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '总结',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'SUMMARY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '总结状态
   INIT
   SUBMITED',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ATT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_MEET_ROOM                                          */
/*==============================================================*/
CREATE TABLE OA_MEET_ROOM (
   ROOM_ID_             VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(100)         NOT NULL,
   LOCATION_            VARCHAR(255)         NULL,
   DESCP_               VARCHAR(512)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_MEET_ROOM PRIMARY KEY NONCLUSTERED (ROOM_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '会议室',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '会议室名称',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '地址',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'LOCATION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_MEET_ROOM', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_PLAN_TASK                                          */
/*==============================================================*/
CREATE TABLE OA_PLAN_TASK (
   PLAN_ID_             VARCHAR(64)          NOT NULL,
   PROJECT_ID_          VARCHAR(64)          NULL,
   REQ_ID_              VARCHAR(64)          NULL,
   VERSION_             VARCHAR(50)          NULL,
   SUBJECT_             VARCHAR(128)         NOT NULL,
   CONTENT_             TEXT                 NULL,
   PSTART_TIME_         DATETIME             NOT NULL,
   PEND_TIME_           DATETIME             NULL,
   START_TIME_          DATETIME             NULL,
   END_TIME_            DATETIME             NULL,
   STATUS_              VARCHAR(20)          NULL,
   LAST_                INT                  NULL,
   ASSIGN_ID_           VARCHAR(64)          NULL,
   OWNER_ID_            VARCHAR(64)          NULL,
   EXE_ID_              VARCHAR(64)          NULL,
   BPM_DEF_ID_          VARCHAR(64)          NULL,
   BPM_INST_ID_         VARCHAR(64)          NULL,
   BPM_TASK_ID_         VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_PLAN_TASK PRIMARY KEY NONCLUSTERED (PLAN_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '工作计划任务',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项目或产品ID',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'PROJECT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '需求ID',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'REQ_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本号',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '计划标题',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '计划内容',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '计划开始时间',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'PSTART_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '计划结束时间',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'PEND_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实际开始时间',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实际结束时间',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   未开始
   执行中
   延迟
   暂停
   中止
   完成',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '耗时(分）',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'LAST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分配人',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'ASSIGN_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属人',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'OWNER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '执行人',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'EXE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程定义ID',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'BPM_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'BPM_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程任务ID',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'BPM_TASK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PLAN_TASK', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_PRODUCT_DEF                                        */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF (
   PROD_DEF_ID_         VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NULL,
   DESC_                VARCHAR(256)         NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OA_PRODUCT_DEF PRIMARY KEY NONCLUSTERED (PROD_DEF_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '产品分类定义',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数定义ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'PROD_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OA_PRODUCT_DEF_PARA                                   */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF_PARA (
   ID_                  VARCHAR(64)          NOT NULL,
   KEY_ID_              VARCHAR(64)          NULL,
   VALUE_ID_            VARCHAR(64)          NULL,
   PROD_DEF_ID_         VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OA_PRODUCT_DEF_PARA PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '产品定义参数表',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数KEY主键',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'KEY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数VALUE主键',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'VALUE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数定义ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'PROD_DEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OA_PRODUCT_DEF_PARA_KEY                               */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF_PARA_KEY (
   KEY_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NULL,
   CONTROL_TYPE_        VARCHAR(64)          NULL,
   DATA_TYPE_           VARCHAR(20)          NULL,
   IS_UNIQUE_           SMALLINT             NULL,
   DESC_                VARCHAR(256)         NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OA_PRODUCT_DEF_PARA_KEY PRIMARY KEY NONCLUSTERED (KEY_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '产品定义参数KEY(产品类型)',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数KEY主键',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'KEY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型(radio-list checkbox-list textbox number date textarea)',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'CONTROL_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据类型(string number date 大文本)',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'DATA_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否唯一属性',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'IS_UNIQUE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_KEY', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OA_PRODUCT_DEF_PARA_VALUE                             */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF_PARA_VALUE (
   VALUE_ID_            VARCHAR(64)          NOT NULL,
   KEY_ID_              VARCHAR(64)          NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NULL,
   NUMBER_              DOUBLE PRECISION     NULL,
   STRING_              VARCHAR(20)          NULL,
   TEXT_                VARCHAR(4000)        NULL,
   DATETIME__           DATETIME             NULL,
   DESC_                VARCHAR(256)         NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OA_PRODUCT_DEF_PARA_VALUE PRIMARY KEY NONCLUSTERED (VALUE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '产品定义参数VALUE(产品属性)',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数VALUE主键',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'VALUE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数KEY主键',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'KEY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数字类型',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'NUMBER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字符串类型',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'STRING_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文本类型',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'TEXT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '时间类型',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'DATETIME__'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OA_PRODUCT_DEF_PARA_VALUE', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OA_PROJECT                                            */
/*==============================================================*/
CREATE TABLE OA_PROJECT (
   PROJECT_ID_          VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   PRO_NO_              VARCHAR(50)          NOT NULL,
   TAG_                 VARCHAR(50)          NULL,
   NAME_                VARCHAR(100)         NOT NULL,
   DESCP_               TEXT                 NULL,
   REPOR_ID_            VARCHAR(64)          NOT NULL,
   COSTS_               NUMERIC(16,4)        NULL,
   START_TIME_          DATETIME             NULL,
   END_TIME_            DATETIME             NULL,
   STATUS_              VARCHAR(20)          NULL,
   VERSION_             VARCHAR(50)          NULL,
   TYPE_                VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_PROJECT PRIMARY KEY NONCLUSTERED (PROJECT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项目或产品',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '编号',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'PRO_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标签名称',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'TAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '负责人',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'REPOR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '预计费用',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'COSTS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '启动时间',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   未开始=UNSTART
   暂停中=SUSPEND
   已延迟=DELAYED
   已取消=CANCELED
   进行中=UNDERWAY
   已完成=FINISHED',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '当前版本',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型
   PROJECT=项目
   PRODUCT=产品',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PROJECT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_PRO_ATTEND                                         */
/*==============================================================*/
CREATE TABLE OA_PRO_ATTEND (
   ATT_ID_              VARCHAR(64)          NOT NULL,
   PROJECT_ID_          VARCHAR(64)          NULL,
   USER_ID_             TEXT                 NULL,
   GROUP_ID_            TEXT                 NULL,
   PART_TYPE_           VARCHAR(20)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_PRO_ATTEND PRIMARY KEY NONCLUSTERED (ATT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项目或产品参与人、负责人、关注人',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参与人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参与组ID',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参与类型
   Participate
   
         JOIN=参与
         RESPONSE=负责
         APPROVE=审批
         PAY_ATT=关注',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'PART_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PRO_ATTEND', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_PRO_VERS                                           */
/*==============================================================*/
CREATE TABLE OA_PRO_VERS (
   VERSION_ID_          VARCHAR(64)          NOT NULL,
   PROJECT_ID_          VARCHAR(64)          NULL,
   START_TIME_          DATETIME             NULL,
   END_TIME_            DATETIME             NULL,
   STATUS_              VARCHAR(20)          NULL,
   VERSION_             VARCHAR(50)          NOT NULL,
   DESCP_               TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_PRO_VERS PRIMARY KEY NONCLUSTERED (VERSION_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项目或产品版本',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项目或产品ID',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'PROJECT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   DRAFTED=草稿
   DEPLOYED=发布
   RUNNING=进行中
   FINISHED=完成
   ',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本号',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_PRO_VERS', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_REQ_MGR                                            */
/*==============================================================*/
CREATE TABLE OA_REQ_MGR (
   REQ_ID_              VARCHAR(64)          NOT NULL,
   PROJECT_ID_          VARCHAR(64)          NULL,
   REQ_CODE_            VARCHAR(50)          NOT NULL,
   SUBJECT_             VARCHAR(128)         NOT NULL,
   PATH_                VARCHAR(512)         NULL,
   DESCP_               TEXT                 NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   STATUS_              VARCHAR(50)          NULL,
   LEVEL_               INT                  NULL,
   CHECKER_ID_          VARCHAR(64)          NULL,
   REP_ID_              VARCHAR(64)          NULL,
   EXE_ID_              VARCHAR(64)          NULL,
   VERSION_             VARCHAR(20)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_REQ_MGR PRIMARY KEY NONCLUSTERED (REQ_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '产品或项目需求',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '需求编码',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'REQ_CODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父需求ID',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '层次',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批人',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'CHECKER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '负责人',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'REP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '执行人',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'EXE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本号',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_REQ_MGR', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_WORK_ATT                                           */
/*==============================================================*/
CREATE TABLE OA_WORK_ATT (
   ATT_ID_              VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NOT NULL,
   ATT_TIME_            DATETIME             NULL,
   NOTICE_TYPE_         VARCHAR(50)          NOT NULL,
   TYPE_                VARCHAR(50)          NOT NULL,
   TYPE_PK_             VARCHAR(64)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_WORK_ATT PRIMARY KEY NONCLUSTERED (ATT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '工作动态关注',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关注人ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关注时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'ATT_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通知方式
   Mail,ShortMsg,WeiXin',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'NOTICE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关注类型
   项目=PROJECT
   工作计划=PLAN
   需求=REQ',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型主键ID
   当类型主键为需求类型时，即存入需求ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'TYPE_PK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_ATT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_WORK_LOG                                           */
/*==============================================================*/
CREATE TABLE OA_WORK_LOG (
   LOG_ID_              VARCHAR(64)          NOT NULL,
   PLAN_ID_             VARCHAR(64)          NULL,
   CONTENT_             VARCHAR(1024)        NOT NULL,
   START_TIME_          DATETIME             NOT NULL,
   END_TIME_            DATETIME             NOT NULL,
   STATUS_              VARCHAR(20)          NULL,
   LAST_                INT                  NULL,
   CHECKER_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_WORK_LOG PRIMARY KEY NONCLUSTERED (LOG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '工作日志',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '计划任务ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'PLAN_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '耗时',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'LAST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审批人',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'CHECKER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_LOG', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OA_WORK_MAT                                           */
/*==============================================================*/
CREATE TABLE OA_WORK_MAT (
   ACTION_ID_           VARCHAR(64)          NOT NULL,
   CONTENT_             VARCHAR(512)         NOT NULL,
   TYPE_                VARCHAR(50)          NOT NULL,
   TYPE_PK_             VARCHAR(64)          NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OA_WORK_MAT PRIMARY KEY NONCLUSTERED (ACTION_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '工作动态',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '评论内容',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型
   项目=PROJECT
   工作计划=PLAN
   需求=REQ',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型主键ID
   当类型主键为需求类型时，即存入需求ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'TYPE_PK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OA_WORK_MAT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OD_DOCUMENT                                           */
/*==============================================================*/
CREATE TABLE OD_DOCUMENT (
   DOC_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   ISSUE_NO_            VARCHAR(100)         NOT NULL,
   ISSUE_DEP_ID_        VARCHAR(64)          NULL,
   IS_JOIN_ISSUE_       VARCHAR(20)          NULL,
   JOIN_DEP_IDS_        VARCHAR(512)         NULL,
   MAIN_DEP_ID_         VARCHAR(64)          NULL,
   CC_DEP_ID_           VARCHAR(64)          NULL,
   TAKE_DEP_ID_         VARCHAR(64)          NULL,
   ASS_DEP_ID_          VARCHAR(64)          NULL,
   SUBJECT_             VARCHAR(200)         NOT NULL,
   PRIVACY_LEVEL_       VARCHAR(50)          NULL,
   SECRECY_TERM_        INT                  NULL,
   PRINT_COUNT_         INT                  NULL,
   KEYWORDS_            VARCHAR(256)         NULL,
   URGENT_LEVEL_        VARCHAR(50)          NULL,
   SUMMARY_             VARCHAR(1024)        NULL,
   BODY_FILE_PATH_      VARCHAR(255)         NULL,
   FILE_IDS_            VARCHAR(512)         NULL,
   FILE_NAMES_          VARCHAR(512)         NULL,
   ISSUE_USR_ID_        VARCHAR(64)          NULL,
   ARCH_TYPE_           SMALLINT             NOT NULL,
   ORG_ARCH_ID_         VARCHAR(64)          NULL,
   SELF_NO_             VARCHAR(100)         NULL,
   STATUS_              VARCHAR(256)         NOT NULL,
   BPM_INST_ID_         VARCHAR(64)          NULL,
   BPM_SOL_ID_          VARCHAR(64)          NULL,
   DOC_TYPE_            VARCHAR(20)          NULL,
   ISSUED_DATE_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OD_DOCUMENT PRIMARY KEY NONCLUSTERED (DOC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发文分类ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发文字号',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'ISSUE_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发文机关或部门',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'ISSUE_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否联合发文件',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'IS_JOIN_ISSUE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联合发文单位或部门',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'JOIN_DEP_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主送单位',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'MAIN_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '抄送单位或部门',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'CC_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '承办部门ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'TAKE_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '协办部门ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'ASS_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件标题',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '秘密等级
   普通=COMMON
   秘密=SECURITY
   机密=MIDDLE-SECURITY
   绝密=TOP SECURITY
   ',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'PRIVACY_LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '保密期限(年)
   ',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'SECRECY_TERM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '打印份数',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'PRINT_COUNT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主题词',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'KEYWORDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '紧急程度
   普通=COMMON
   紧急=URGENT
   特急=URGENTEST
   特提=MORE_URGENT',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'URGENT_LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容简介',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'SUMMARY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '正文路径',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'BODY_FILE_PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件IDs',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'FILE_IDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件名称',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'FILE_NAMES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发文人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'ISSUE_USR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '0=发文
   1=收文',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'ARCH_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用于收文时使用，指向原公文ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'ORG_ARCH_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用于收文时，部门对自身的公文自编号',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'SELF_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公文状态
   0=拟稿、修改状态
   1=发文状态
   2=归档状态',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程运行id
   通过该id可以查看该公文的审批历史',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'BPM_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程方案ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'BPM_SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公文的类型
   上行文
      报告
      请示
      议案
      签报
      
   下行文
      命令
      决定
      公告
      通告
      通知
      通报
      批复
      会议纪要
   来文
   其他
   平行文
    函',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'DOC_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发布日期',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'ISSUED_DATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OD_DOCUMENT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OD_DOC_FLOW                                           */
/*==============================================================*/
CREATE TABLE OD_DOC_FLOW (
   SCHEME_ID_           VARCHAR(64)          NOT NULL,
   DEP_ID_              VARCHAR(64)          NOT NULL,
   SEND_SOL_ID_         VARCHAR(64)          NULL,
   SEND_SOL_NAME_       VARCHAR(128)         NULL,
   REC_SOL_ID_          VARCHAR(64)          NULL,
   REC_SOL_NAME_        VARCHAR(128)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OD_DOC_FLOW PRIMARY KEY NONCLUSTERED (SCHEME_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收发文流程方案',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'SCHEME_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部门ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发文流程方案ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'SEND_SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发文流程方案名称',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'SEND_SOL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收文流程方案ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'REC_SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收文流程方案名称',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'REC_SOL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_FLOW', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OD_DOC_REC                                            */
/*==============================================================*/
CREATE TABLE OD_DOC_REC (
   REC_ID_              VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NOT NULL,
   REC_DEP_ID_          VARCHAR(64)          NOT NULL,
   REC_DTYPE_           VARCHAR(20)          NULL,
   IS_READ_             VARCHAR(20)          NULL,
   READ_TIME_           DATETIME             NULL,
   FEED_BACK_           VARCHAR(200)         NULL,
   SIGN_USR_ID_         VARCHAR(64)          NULL,
   SIGN_STATUS_         VARCHAR(20)          NULL,
   SIGN_TIME_           DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OD_DOC_REC PRIMARY KEY NONCLUSTERED (REC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'REC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收发文ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收文部门ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'REC_DEP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收文单位类型
   接收单位
   抄送单位
   ',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'REC_DTYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否阅读',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'IS_READ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '阅读时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'READ_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '反馈意见',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'FEED_BACK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签收人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'SIGN_USR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签收状态',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'SIGN_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签收时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'SIGN_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REC', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OD_DOC_REMIND_                                        */
/*==============================================================*/
CREATE TABLE OD_DOC_REMIND_ (
   REMIND_ID_           VARCHAR(64)          NOT NULL,
   DOC_ID_              VARCHAR(64)          NULL,
   CONTENT_             VARCHAR(1024)        NULL,
   MIND_USR_ID_         VARCHAR(64)          NULL,
   TAKE_USR_ID_         VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OD_DOC_REMIND_ PRIMARY KEY NONCLUSTERED (REMIND_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收发文办理催办',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '收发文ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '催办内容',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '催办人',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'MIND_USR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '承办人',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'TAKE_USR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_REMIND_', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OD_DOC_TEMPLATE                                       */
/*==============================================================*/
CREATE TABLE OD_DOC_TEMPLATE (
   TEMP_ID_             VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(20)          NOT NULL,
   DESCP_               VARCHAR(512)         NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   FILE_ID_             VARCHAR(64)          NULL,
   FILE_PATH_           VARCHAR(255)         NULL,
   TEMP_TYPE_           VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OD_DOC_TEMPLATE PRIMARY KEY NONCLUSTERED (TEMP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公文模板',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板名称',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板描述',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板状态
   启用=ENABLED
   禁用=DISABLED',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板分类ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板文件路径',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'FILE_PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '套红模板
   公文发文模板
   收文模板',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'TEMP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OD_DOC_TEMPLATE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_ATTRIBUTE_VALUE                                    */
/*==============================================================*/
CREATE TABLE OS_ATTRIBUTE_VALUE (
   ID_                  VARCHAR(64)          NOT NULL,
   VALUE_               VARCHAR(256)         NULL,
   ATTRIBUTE_ID_        VARCHAR(256)         NULL,
   TARGET_ID_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_ATTRIBUTE_VALUE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '人员属性值',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键ID',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数值',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'VALUE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性ID',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'ATTRIBUTE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '目标ID',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'TARGET_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构ID',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_ATTRIBUTE_VALUE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_CUSTOM_ATTRIBUTE                                   */
/*==============================================================*/
CREATE TABLE OS_CUSTOM_ATTRIBUTE (
   ID                   VARCHAR(64)          NOT NULL,
   ATTRIBUTE_NAME_      VARCHAR(64)          NULL,
   KEY_                 VARCHAR(64)          NULL,
   ATTRIBUTE_TYPE_      VARCHAR(64)          NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   WIDGET_TYPE_         VARCHAR(64)          NULL,
   VALUE_SOURCE_        TEXT                 NULL,
   SOURCE_TYPE_         VARCHAR(64)          NULL,
   DIM_ID_              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_CUSTOM_ATTRIBUTE PRIMARY KEY NONCLUSTERED (ID)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定义属性',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'ID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性名称',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'ATTRIBUTE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'KEY',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性类型',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'ATTRIBUTE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID_',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '控件类型',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'WIDGET_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '值来源',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'VALUE_SOURCE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '来源类型',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'SOURCE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度ID',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'DIM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构ID',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_CUSTOM_ATTRIBUTE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_DIMENSION                                          */
/*==============================================================*/
CREATE TABLE OS_DIMENSION (
   DIM_ID_              VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(40)          NOT NULL,
   DIM_KEY_             VARCHAR(64)          NOT NULL,
   IS_COMPOSE_          VARCHAR(10)          NOT NULL,
   IS_SYSTEM_           VARCHAR(10)          NOT NULL,
   STATUS_              VARCHAR(40)          NOT NULL,
   SN_                  INT                  NOT NULL,
   SHOW_TYPE_           VARCHAR(40)          NOT NULL,
   IS_GRANT_            VARCHAR(10)          NULL,
   DESC_                VARCHAR(255)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_DIMENSION PRIMARY KEY NONCLUSTERED (DIM_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组织维度',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'DIM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度名称',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度业务主键',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'DIM_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否组合维度',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'IS_COMPOSE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否系统预设维度',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'IS_SYSTEM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   actived 已激活；locked 锁定（禁用）；deleted 已删除',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排序号',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据展示类型
   tree=树型数据。flat=平铺数据',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'SHOW_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否参与授权',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'IS_GRANT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_DIMENSION_RIGHT                                    */
/*==============================================================*/
CREATE TABLE OS_DIMENSION_RIGHT (
   RIGHT_ID_            VARCHAR(64)          NOT NULL,
   USER_ID_             TEXT                 NULL,
   GROUP_ID_            TEXT                 NULL,
   DIM_ID_              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_DIMENSION_RIGHT PRIMARY KEY NONCLUSTERED (RIGHT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度授权',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'RIGHT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'DIM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_DIMENSION_RIGHT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_GROUP                                              */
/*==============================================================*/
CREATE TABLE OS_GROUP (
   GROUP_ID_            VARCHAR(64)          NOT NULL,
   DIM_ID_              VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NOT NULL,
   KEY_                 VARCHAR(64)          NOT NULL,
   RANK_LEVEL_          INT                  NULL,
   STATUS_              VARCHAR(40)          NOT NULL,
   DESCP_               VARCHAR(255)         NULL,
   SN_                  INT                  NOT NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   DEPTH_               INT                  NULL,
   PATH_                VARCHAR(1024)        NULL,
   CHILDS_              INT                  NULL,
   FORM_                VARCHAR(20)          NULL,
   SYNC_WX_             INT                  NULL,
   WX_PARENT_PID_       INT                  NULL,
   WX_PID_              INT                  NULL,
   IS_DEFAULT_          VARCHAR(40)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_GROUP PRIMARY KEY NONCLUSTERED (GROUP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统用户组',
   'user', @CURRENTUSER, 'table', 'OS_GROUP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'DIM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组名称',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组业务主键',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属用户组等级值',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'RANK_LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   inactive 未激活；actived 已激活；locked 锁定；deleted 已删除',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排序号',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父用户组ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '层次',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'DEPTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '下级数量',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'CHILDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '来源
   sysem,系统添加,import导入,grade,分级添加的',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'FORM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '同步到微信',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'SYNC_WX_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信内部维护父部门ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'WX_PARENT_PID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信平台部门唯一ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'WX_PID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否默认，代表系统自带，不允许删除',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_GROUP', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_GROUP_MENU                                         */
/*==============================================================*/
CREATE TABLE OS_GROUP_MENU (
   ID_                  VARCHAR(64)          NOT NULL,
   MENU_ID_             VARCHAR(64)          NOT NULL,
   GROUP_ID_            VARCHAR(64)          NOT NULL,
   SYS_ID_              VARCHAR(64)          NOT NULL,
   CONSTRAINT PK_OS_GROUP_MENU PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组下的授权菜单',
   'user', @CURRENTUSER, 'table', 'OS_GROUP_MENU'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '菜单ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP_MENU', 'column', 'MENU_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP_MENU', 'column', 'GROUP_ID_'
go

/*==============================================================*/
/* Table: OS_GROUP_SYS                                          */
/*==============================================================*/
CREATE TABLE OS_GROUP_SYS (
   ID_                  VARCHAR(64)          NOT NULL,
   GROUP_ID_            VARCHAR(64)          NOT NULL,
   SYS_ID_              VARCHAR(64)          NULL,
   CONSTRAINT PK_OS_GROUP_SYS PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组ID',
   'user', @CURRENTUSER, 'table', 'OS_GROUP_SYS', 'column', 'GROUP_ID_'
go

/*==============================================================*/
/* Table: OS_RANK_TYPE                                          */
/*==============================================================*/
CREATE TABLE OS_RANK_TYPE (
   ID_                  VARCHAR(64)          NOT NULL,
   DIM_ID_              VARCHAR(64)          NULL,
   NAME_                VARCHAR(255)         NOT NULL,
   KEY_                 VARCHAR(64)          NOT NULL,
   LEVEL_               INT                  NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_RANK_TYPE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组等级分类，放置组织的等级分类定义
   如集团，分公司，部门等级别',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度ID',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'DIM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类业务键',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '级别数值',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_RANK_TYPE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_REL_INST                                           */
/*==============================================================*/
CREATE TABLE OS_REL_INST (
   INST_ID_             VARCHAR(64)          NOT NULL,
   REL_TYPE_ID_         VARCHAR(64)          NULL,
   REL_TYPE_KEY_        VARCHAR(64)          NULL,
   PARTY1_              VARCHAR(64)          NOT NULL,
   PARTY2_              VARCHAR(64)          NOT NULL,
   DIM1_                VARCHAR(64)          NULL,
   DIM2_                VARCHAR(64)          NULL,
   IS_MAIN_             VARCHAR(20)          NOT NULL,
   STATUS_              VARCHAR(40)          NOT NULL,
   ALIAS_               VARCHAR(80)          NULL,
   REL_TYPE_            VARCHAR(64)          NULL,
   PATH_                VARCHAR(1024)        NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CONSTRAINT PK_OS_REL_INST PRIMARY KEY NONCLUSTERED (INST_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系实例',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组关系ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系类型ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'REL_TYPE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系类型KEY_
   ',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'REL_TYPE_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '当前方ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'PARTY1_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关联方ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'PARTY2_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '当前方维度ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'DIM1_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关联方维度ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'DIM2_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'IS_MAIN_',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'IS_MAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   ENABLED
   DISABLED',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系类型',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'REL_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_INST', 'column', 'TENANT_ID_'
go

/*==============================================================*/
/* Table: OS_REL_TYPE                                           */
/*==============================================================*/
CREATE TABLE OS_REL_TYPE (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(64)          NOT NULL,
   KEY_                 VARCHAR(64)          NOT NULL,
   REL_TYPE_            VARCHAR(40)          NOT NULL,
   CONST_TYPE_          VARCHAR(40)          NOT NULL,
   PARTY1_              VARCHAR(128)         NOT NULL,
   PARTY2_              VARCHAR(128)         NOT NULL,
   DIM_ID1_             VARCHAR(64)          NULL,
   DIM_ID2_             VARCHAR(64)          NULL,
   STATUS_              VARCHAR(40)          NOT NULL,
   IS_SYSTEM_           VARCHAR(10)          NOT NULL,
   IS_DEFAULT_          VARCHAR(10)          NOT NULL,
   IS_TWO_WAY_          VARCHAR(10)          NOT NULL,
   MEMO_                VARCHAR(255)         NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_REL_TYPE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系类型定义',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系类型ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系名',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系业务主键',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系类型。用户关系=USER-USER；用户组关系=GROUP-GROUP；用户与组关系=USER-GROUP；组与用户关系=GROUP-USER',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'REL_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系约束类型。1对1=one2one；1对多=one2many；多对1=many2one；多对多=many2many',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'CONST_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系当前方名称',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'PARTY1_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系关联方名称',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'PARTY2_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '当前方维度ID（仅对用户组关系）',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'DIM_ID1_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关联方维度ID（用户关系忽略此值）',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'DIM_ID2_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态。actived 已激活；locked 锁定；deleted 已删除',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否系统预设',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'IS_SYSTEM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否默认',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否是双向',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'IS_TWO_WAY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系备注',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公共 - 创建者所属SAAS ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_REL_TYPE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: OS_USER                                               */
/*==============================================================*/
CREATE TABLE OS_USER (
   USER_ID_             VARCHAR(64)          NOT NULL,
   FULLNAME_            VARCHAR(64)          NOT NULL,
   USER_NO_             VARCHAR(64)          NOT NULL,
   ENTRY_TIME_          DATETIME             NULL,
   QUIT_TIME_           DATETIME             NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   FROM_                VARCHAR(20)          NULL,
   BIRTHDAY_            DATETIME             NULL,
   SEX_                 VARCHAR(10)          NULL,
   MOBILE_              VARCHAR(20)          NULL,
   EMAIL_               VARCHAR(100)         NULL,
   ADDRESS_             VARCHAR(255)         NULL,
   URGENT_              VARCHAR(64)          NULL,
   SYNC_WX_             INT                  NULL,
   URGENT_MOBILE_       VARCHAR(20)          NULL,
   QQ_                  VARCHAR(20)          NULL,
   PHOTO_               VARCHAR(255)         NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_OS_USER PRIMARY KEY NONCLUSTERED (USER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户信息表',
   'user', @CURRENTUSER, 'table', 'OS_USER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '姓名',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'FULLNAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '入职时间',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'ENTRY_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '离职时间',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'QUIT_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   
   在职=ON_JOB
   离职=OUT_JOB
   ',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '来源
   system,系统添加,import,导入,grade,分级添加的',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'FROM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '出生日期',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'BIRTHDAY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '姓别',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'SEX_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'EMAIL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '地址',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'ADDRESS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '紧急联系人',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'URGENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否同步到微信',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'SYNC_WX_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '紧急联系人手机',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'URGENT_MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'QQ号',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'QQ_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '照片',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'PHOTO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构ID',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'OS_USER', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: PRO_ARTICLE                                           */
/*==============================================================*/
CREATE TABLE PRO_ARTICLE (
   ID_                  VARCHAR(64)          NOT NULL,
   BELONG_PRO_ID_       VARCHAR(64)          NULL,
   TITLE_               VARCHAR(128)         NULL,
   AUTHOR_              VARCHAR(64)          NULL,
   OUT_LINE_            VARCHAR(64)          NULL,
   TYPE_                VARCHAR(64)          NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   SN_                  VARCHAR(64)          NULL,
   CONTENT_             TEXT                 NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_PRO_ARTICLE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文章',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属项目ID',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'BELONG_PRO_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'AUTHOR_',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'AUTHOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '概要',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'OUT_LINE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父ID',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'PRO_ARTICLE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: PRO_ITEM                                              */
/*==============================================================*/
CREATE TABLE PRO_ITEM (
   ID                   VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(128)         NULL,
   DESC_                TEXT                 NULL,
   VERSION_             VARCHAR(64)          NULL,
   GEN_SRC_             VARCHAR(512)         NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_PRO_ITEM PRIMARY KEY NONCLUSTERED (ID)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项目',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'ID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项目名',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档生成路径',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'GEN_SRC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'PRO_ITEM', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SMS_MSG_INFO                                          */
/*==============================================================*/
CREATE TABLE SMS_MSG_INFO (
   SMS_ID_              VARCHAR(64)          NOT NULL,
   SEND_USER_           VARCHAR(64)          NULL,
   RECEIVE_USER_        VARCHAR(64)          NULL,
   MOBILE_              VARCHAR(20)          NULL,
   CONTENT_             TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   STATUS_              SMALLINT             NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_SMS_MSG_INFO PRIMARY KEY NONCLUSTERED (SMS_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '短信信息表',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'SMS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'RECEIVE_USER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '1保存2未发送3发送成功4发送失败',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_INFO', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: SMS_MSG_SEND                                          */
/*==============================================================*/
CREATE TABLE SMS_MSG_SEND (
   SEND_ID_             VARCHAR(64)          NOT NULL,
   GATEWAY_ID_          VARCHAR(64)          NULL,
   SEND_USER_           VARCHAR(64)          NULL,
   RECEIVE_USER_        VARCHAR(64)          NULL,
   MOBILE_              VARCHAR(20)          NULL,
   MSG_ID_              VARCHAR(64)          NULL,
   CONTENT_             TEXT                 NULL,
   RECEIPT_ID_          VARCHAR(512)         NULL,
   STATUS_              SMALLINT             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_SMS_MSG_SEND PRIMARY KEY NONCLUSTERED (SEND_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '短信发送表',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'SEND_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '代理应用ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'GATEWAY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'RECEIVE_USER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'MOBILE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '1保存2未发送3发送成功4发送失败',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SMS_MSG_SEND', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: SYS_ACCOUNT                                           */
/*==============================================================*/
CREATE TABLE SYS_ACCOUNT (
   ACCOUNT_ID_          VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(50)          NOT NULL,
   PWD_                 VARCHAR(64)          NOT NULL,
   ENC_TYPE_            VARCHAR(20)          NULL,
   FULLNAME_            VARCHAR(32)          NOT NULL,
   USER_ID_             VARCHAR(64)          NULL,
   REMARK_              VARCHAR(200)         NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   DOMAIN_              VARCHAR(64)          NULL,
   CREAT_ORG_ID_        VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_ACCOUNT PRIMARY KEY NONCLUSTERED (ACCOUNT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '登录账号',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '账号名称',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '密码',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'PWD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '加密算法
   MD5
   SHA-256
   PLAINTEXT',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'ENC_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户名',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'FULLNAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '绑定用户ID',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'REMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   ENABLED=可用
   DISABLED=禁用
   DELETED=删除',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '域名',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'DOMAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人组织ID',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'CREAT_ORG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_ACCOUNT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_AUDIT                                             */
/*==============================================================*/
CREATE TABLE SYS_AUDIT (
   ID_                  VARCHAR(64)          NOT NULL,
   MODULE_              VARCHAR(128)         NULL,
   SUB_MODULE_          VARCHAR(128)         NULL,
   ACTION_              VARCHAR(128)         NULL,
   IP_                  VARCHAR(128)         NULL,
   USER_AGENT_          VARCHAR(1024)        NULL,
   TARGET_              TEXT                 NULL,
   MAIN_GROUP_NAME_     VARCHAR(500)         NULL,
   MAIN_GROUP_          VARCHAR(64)          NULL,
   DURATION_            INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_AUDIT PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志实体',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属模块',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'MODULE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '功能',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'SUB_MODULE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '操作名',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'ACTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '操作IP',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'IP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '设备信息',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'USER_AGENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '操作目标',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'TARGET_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主部门名',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'MAIN_GROUP_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主部门ID',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'MAIN_GROUP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '持续时长',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'DURATION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_AUDIT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_BO_ATTR                                           */
/*==============================================================*/
CREATE TABLE SYS_BO_ATTR (
   ID_                  VARCHAR(20)          NOT NULL,
   ENT_ID_              VARCHAR(20)          NULL,
   NAME_                VARCHAR(64)          NULL,
   FIELD_NAME_          VARCHAR(64)          NULL,
   COMMENT_             VARCHAR(100)         NULL,
   DATA_TYPE_           VARCHAR(10)          NULL,
   LENGTH_              INT                  NULL,
   DECIMAL_LENGTH_      INT                  NULL,
   CONTROL_             VARCHAR(30)          NULL,
   EXT_JSON_            VARCHAR(4000)        NULL,
   HAS_GEN_             VARCHAR(10)          NULL,
   STATUS_              VARCHAR(10)          NULL,
   IS_SINGLE_           INT                  NULL,
   TENANT_ID_           VARCHAR(20)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_BO_ATTR PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务实体属性定义',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实体ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'ENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段名',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'FIELD_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'COMMENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'DATA_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据长度',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'LENGTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据精度',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'DECIMAL_LENGTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '控件类型',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'CONTROL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '扩展JSON',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'EXT_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否生成字段',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'HAS_GEN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否单个属性字段',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'IS_SINGLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ATTR', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_BO_DEFINITION                                     */
/*==============================================================*/
CREATE TABLE SYS_BO_DEFINITION (
   ID_                  VARCHAR(20)          NOT NULL,
   NAME_                VARCHAR(64)          NULL,
   ALAIS_               VARCHAR(64)          NULL,
   COMMENT_             VARCHAR(200)         NULL,
   SUPPORT_DB_          VARCHAR(20)          NULL,
   GEN_MODE_            VARCHAR(20)          NULL,
   TREE_ID_             VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(20)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   OPINION_DEF_         VARCHAR(2000)        NULL,
   CONSTRAINT PK_SYS_BO_DEFINITION PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务对象定义',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'ALAIS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'COMMENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否支持数据库',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'SUPPORT_DB_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '生成模式',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'GEN_MODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单意见定义',
   'user', @CURRENTUSER, 'table', 'SYS_BO_DEFINITION', 'column', 'OPINION_DEF_'
go

/*==============================================================*/
/* Table: SYS_BO_ENTITY                                         */
/*==============================================================*/
CREATE TABLE SYS_BO_ENTITY (
   ID_                  VARCHAR(20)          NOT NULL,
   NAME_                VARCHAR(64)          NULL,
   COMMENT_             VARCHAR(64)          NULL,
   TABLE_NAME_          VARCHAR(64)          NULL,
   DS_NAME_             VARCHAR(64)          NULL,
   EXT_JSON_            VARCHAR(1000)        NULL,
   GEN_TABLE_           VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(20)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_BO_ENTITY PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务实体对象',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '注释',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'COMMENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表名',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'TABLE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源名称',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'DS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '扩展配置数据',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'EXT_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否生成物理表',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'GEN_TABLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_ENTITY', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_BO_LIST                                           */
/*==============================================================*/
CREATE TABLE SYS_BO_LIST (
   ID_                  VARCHAR(64)          NOT NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   NAME_                VARCHAR(200)         NOT NULL,
   KEY_                 VARCHAR(120)         NOT NULL,
   DESCP_               VARCHAR(500)         NULL,
   ID_FIELD_            VARCHAR(60)          NULL,
   TEXT_FIELD_          VARCHAR(60)          NULL,
   PARENT_FIELD_        VARCHAR(60)          NULL,
   IS_TREE_DLG_         VARCHAR(20)          NULL,
   ONLY_SEL_LEAF_       VARCHAR(20)          NULL,
   URL_                 VARCHAR(256)         NULL,
   MULTI_SELECT_        VARCHAR(20)          NULL,
   IS_LEFT_TREE_        VARCHAR(20)          NULL,
   LEFT_NAV_            VARCHAR(80)          NULL,
   LEFT_TREE_JSON_      TEXT                 NULL,
   SQL_                 VARCHAR(2000)        NOT NULL,
   USE_COND_SQL_        VARCHAR(20)          NULL,
   COND_SQLS_           TEXT                 NULL,
   DB_AS_               VARCHAR(64)          NULL,
   FIELDS_JSON_         TEXT                 NULL,
   COLS_JSON_           TEXT                 NULL,
   LIST_HTML_           TEXT                 NULL,
   SEARCH_JSON_         TEXT                 NULL,
   BPM_SOL_ID_          VARCHAR(64)          NULL,
   FORM_ALIAS_          VARCHAR(64)          NULL,
   TOP_BTNS_JSON_       TEXT                 NULL,
   BODY_SCRIPT_         TEXT                 NULL,
   IS_DIALOG_           VARCHAR(20)          NULL,
   IS_PAGE_             VARCHAR(20)          NULL,
   IS_EXPORT_           VARCHAR(20)          NULL,
   HEIGHT_              INT                  NULL,
   WIDTH_               INT                  NULL,
   ENABLE_FLOW_         VARCHAR(20)          NULL,
   IS_GEN_              VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   IS_SHARE_            VARCHAR(20)          NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   DRAW_CELL_SCRIPT_    TEXT                 NULL,
   MOBILE_HTML_         TEXT                 NULL,
   DATA_STYLE_          VARCHAR(20)          NULL,
   ROW_EDIT_            VARCHAR(20)          NULL,
   DATA_RIGHT_JSON_     TEXT                 NULL,
   CONSTRAINT PK_SYS_BO_LIST PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统自定义业务管理列表',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识键',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键字段',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'ID_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '显示字段(树)',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'TEXT_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父ID(树)',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'PARENT_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否树对话框',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'IS_TREE_DLG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '仅可选择树节点',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'ONLY_SEL_LEAF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据地址',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否多选择',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'MULTI_SELECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否显示左树',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'IS_LEFT_TREE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '左树SQL，格式如"select * from abc"##"select * from abc2"',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'LEFT_NAV_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '左树字段映射',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'LEFT_TREE_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SQL语句',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'SQL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'DB_AS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列字段JSON',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'FIELDS_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列的JSON',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'COLS_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列表显示模板',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'LIST_HTML_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '搜索条件HTML',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'SEARCH_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '绑定流程方案',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'BPM_SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '绑定表单方案',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'FORM_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '头部按钮配置',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'TOP_BTNS_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '脚本JS',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'BODY_SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否对话框',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'IS_DIALOG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否分页',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'IS_PAGE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许导出',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'IS_EXPORT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '高',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'HEIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '宽',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'WIDTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否启用流程',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'ENABLE_FLOW_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否已产生HTML',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'IS_GEN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否共享',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'IS_SHARE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '脚本',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'DRAW_CELL_SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机表单模板',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'MOBILE_HTML_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据风格',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'DATA_STYLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '行数据编辑',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'ROW_EDIT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据权限',
   'user', @CURRENTUSER, 'table', 'SYS_BO_LIST', 'column', 'DATA_RIGHT_JSON_'
go

/*==============================================================*/
/* Table: SYS_BO_RELATION                                       */
/*==============================================================*/
CREATE TABLE SYS_BO_RELATION (
   ID_                  VARCHAR(20)          NOT NULL,
   BO_DEFID_            VARCHAR(20)          NULL,
   RELATION_TYPE_       VARCHAR(20)          NULL,
   FORM_ALIAS_          VARCHAR(64)          NULL,
   IS_REF_              INT                  NULL,
   BO_ENTID_            VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(20)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_BO_RELATION PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务对象定义',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BO定义ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'BO_DEFID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关系类型(main,sub)',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'RELATION_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单别名',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'FORM_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否引用实体',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'IS_REF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BO实体ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'BO_ENTID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_BO_RELATION', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_BUTTON                                            */
/*==============================================================*/
CREATE TABLE SYS_BUTTON (
   BUTTON_ID_           VARCHAR(64)          NOT NULL,
   MODULE_ID_           VARCHAR(64)          NULL,
   NAME_                VARCHAR(50)          NOT NULL,
   ICON_CLS_            VARCHAR(50)          NULL,
   GLYPH_               VARCHAR(50)          NULL,
   SN_                  INT                  NOT NULL,
   BTN_TYPE_            VARCHAR(20)          NOT NULL,
   KEY_                 VARCHAR(50)          NOT NULL,
   POS_                 VARCHAR(50)          NOT NULL,
   CUSTOM_HANDLER_      TEXT                 NULL,
   LINK_MODULE_ID_      VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_BUTTON PRIMARY KEY NONCLUSTERED (BUTTON_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统功能按钮管理
   包括列表表头的按钮、管理列的按钮、表单按钮、子模块（明细）按钮',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '按钮ID',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'BUTTON_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'MODULE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '按钮名称',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '按钮ICONCLS',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'ICON_CLS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'GLYPH',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'GLYPH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '按钮类型
   
   明细=DETAIL
   新建=NEW
   修改=EDIT
   删除=DEL
   高级查询=SEARCH_COMPOSE
   新增附件=NEW_ATTACH
   打印=PRINT
   导出=EXPORT
   按字段查询=SEARCH_FIELD
   保存=SAVE
   上一条=PREV
   下一条=NEXT
   自定义=CUSTOM',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'BTN_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '按钮Key',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '按钮位置
   TOP=表头工具栏
   MANAGE=管理列
   FORM_BOTTOM=表单底部按钮栏
   FORM_TOP=表单的头部
   DETAIL_TOP=明细的头部
   DETAIL_BOTTOM=表单底部明细
   
   ',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'POS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定义执行处理',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'CUSTOM_HANDLER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关联模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_BUTTON', 'column', 'LINK_MODULE_ID_'
go

/*==============================================================*/
/* Table: SYS_CUSTOMFORM_SETTING                                */
/*==============================================================*/
CREATE TABLE SYS_CUSTOMFORM_SETTING (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(64)          NULL,
   ALIAS_               VARCHAR(64)          NULL,
   PRE_JS_SCRIPT_       VARCHAR(1000)        NULL,
   AFTER_JS_SCRIPT_     VARCHAR(1000)        NULL,
   PRE_JAVA_SCRIPT_     VARCHAR(1000)        NULL,
   AFTER_JAVA_SCRIPT_   VARCHAR(1000)        NULL,
   SOL_NAME_            VARCHAR(64)          NULL,
   SOL_ID_              VARCHAR(64)          NULL,
   FORM_NAME_           VARCHAR(100)         NULL,
   FORM_ALIAS_          VARCHAR(64)          NULL,
   BODEF_ID_            VARCHAR(64)          NULL,
   BODEF_NAME_          VARCHAR(100)         NULL,
   IS_TREE_             INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   EXPAND_LEVEL_        INT                  NULL,
   LOAD_MODE_           INT                  NULL,
   DISPLAY_FIELDS_      VARCHAR(64)          NULL,
   BUTTON_DEF_          VARCHAR(1000)        NULL,
   DATA_HANDLER_        VARCHAR(100)         NULL,
   TABLE_RIGHT_JSON_    VARCHAR(1000)        NULL,
   MOBILE_FORM_ALIAS_   VARCHAR(64)          NULL,
   MOBILE_FORM_NAME_    VARCHAR(64)          NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_CUSTOMFORM_SETTING PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定义表单设定',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '前置JS',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'PRE_JS_SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '后置JS',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'AFTER_JS_SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '前置JAVA脚本',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'PRE_JAVA_SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '后置JAVA脚本',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'AFTER_JAVA_SCRIPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'SOL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单名称',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'FORM_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单别名',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'FORM_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务模型ID',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'BODEF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '业务模型',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'BODEF_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '树形表单(0,普通表单,1,树形表单)',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'IS_TREE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '展开级别',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'EXPAND_LEVEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '树形加载方式0,一次性加载,1,懒加载',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'LOAD_MODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '显示字段',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'DISPLAY_FIELDS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定义按钮',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'BUTTON_DEF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据处理器',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'DATA_HANDLER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '子表权限配置',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'TABLE_RIGHT_JSON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机表单模版别名',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'MOBILE_FORM_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '手机表单模版名称',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'MOBILE_FORM_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOMFORM_SETTING', 'column', 'TREE_ID_'
go

/*==============================================================*/
/* Table: SYS_CUSTOM_QUERY                                      */
/*==============================================================*/
CREATE TABLE SYS_CUSTOM_QUERY (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(64)          NULL,
   KEY_                 VARCHAR(64)          NULL,
   TABLE_NAME_          VARCHAR(64)          NULL,
   IS_PAGE_             INT                  NULL,
   PAGE_SIZE_           INT                  NULL,
   WHERE_FIELD_         TEXT                 NULL,
   RESULT_FIELD_        VARCHAR(2000)        NULL,
   ORDER_FIELD_         VARCHAR(1024)        NULL,
   DS_ALIAS_            VARCHAR(64)          NULL,
   TABLE_               INT                  NULL,
   SQL_DIY_             TEXT                 NULL,
   SQL_BUILD_TYPE_      VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   SQL_                 VARCHAR(2000)        NULL,
   CONSTRAINT PK_SYS_CUSTOM_QUERY PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定查询',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识名 租户中唯一',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '对象名称(表名或视图名)',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'TABLE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '支持分页(1,支持,0不支持)',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'IS_PAGE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分页大小',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'PAGE_SIZE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '条件字段定义',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'WHERE_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结果字段定义',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'RESULT_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排序字段',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'ORDER_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源名称',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'DS_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为表(1,表,0视图)',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'TABLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定sql',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'SQL_DIY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SQL构建类型',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'SQL_BUILD_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SQL',
   'user', @CURRENTUSER, 'table', 'SYS_CUSTOM_QUERY', 'column', 'SQL_'
go

/*==============================================================*/
/* Table: SYS_DATASOURCE_DEF                                    */
/*==============================================================*/
CREATE TABLE SYS_DATASOURCE_DEF (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(64)          NULL,
   ALIAS_               VARCHAR(64)          NULL,
   ENABLE_              VARCHAR(10)          NULL,
   SETTING_             VARCHAR(2000)        NULL,
   DB_TYPE_             VARCHAR(10)          NULL,
   INIT_ON_START_       VARCHAR(10)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_DATASOURCE_DEF PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源定义管理',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源名称',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否使用',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'ENABLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源设定',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'SETTING_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据库类型',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'DB_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '启动时初始化',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'INIT_ON_START_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_DATASOURCE_DEF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_DB_SQL                                            */
/*==============================================================*/
CREATE TABLE SYS_DB_SQL (
   ID_                  VARCHAR(64)          NOT NULL,
   KEY_                 VARCHAR(256)         NOT NULL,
   NAME_                VARCHAR(256)         NOT NULL,
   HEADER_              TEXT                 NOT NULL,
   DS_NAME_             VARCHAR(256)         NULL,
   DS_ID_               VARCHAR(64)          NULL,
   SQL_                 TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_DB_SQL PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '自定义SQL',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID_',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'KEY_',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司英文名',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表头中文名称,以JSON存储',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'HEADER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源名称',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'DS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源ID',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'DS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SQL语句',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'SQL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_DB_SQL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_DIC                                               */
/*==============================================================*/
CREATE TABLE SYS_DIC (
   DIC_ID_              VARCHAR(64)          NOT NULL,
   TYPE_ID_             VARCHAR(64)          NULL,
   KEY_                 VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NOT NULL,
   VALUE_               VARCHAR(100)         NOT NULL,
   DESCP_               VARCHAR(256)         NULL,
   SN_                  INT                  NULL,
   PATH_                VARCHAR(256)         NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_DIC PRIMARY KEY NONCLUSTERED (DIC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'DIC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'TYPE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项Key',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项名',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项值',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'VALUE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父ID',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_DIC', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_ELEM_RIGHT                                        */
/*==============================================================*/
CREATE TABLE SYS_ELEM_RIGHT (
   RIGHT_ID_            VARCHAR(64)          NOT NULL,
   COMP_ID_             VARCHAR(64)          NOT NULL,
   COMP_TYPE_           VARCHAR(20)          NOT NULL,
   RIGHT_TYPE_          VARCHAR(20)          NOT NULL,
   IDENTITY_ID_         VARCHAR(64)          NOT NULL,
   IDENTITY_TYPE_       VARCHAR(20)          NOT NULL,
   CONSTRAINT PK_SYS_ELEM_RIGHT PRIMARY KEY NONCLUSTERED (RIGHT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统元素权限
   表单、组、字段、按钮权限',
   'user', @CURRENTUSER, 'table', 'SYS_ELEM_RIGHT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限ID',
   'user', @CURRENTUSER, 'table', 'SYS_ELEM_RIGHT', 'column', 'RIGHT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组件ID
   表单ID/组/字段ID/按钮ID',
   'user', @CURRENTUSER, 'table', 'SYS_ELEM_RIGHT', 'column', 'COMP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组件类型
   Form=表单
   Group=组
   Field=字段
   Button=按钮
   ',
   'user', @CURRENTUSER, 'table', 'SYS_ELEM_RIGHT', 'column', 'COMP_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限类型
   ReadOnly=只读
   Edit=可用
   Hidden=隐藏',
   'user', @CURRENTUSER, 'table', 'SYS_ELEM_RIGHT', 'column', 'RIGHT_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户标识ID',
   'user', @CURRENTUSER, 'table', 'SYS_ELEM_RIGHT', 'column', 'IDENTITY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户=User
   用户组=Group',
   'user', @CURRENTUSER, 'table', 'SYS_ELEM_RIGHT', 'column', 'IDENTITY_TYPE_'
go

/*==============================================================*/
/* Table: SYS_FIELD                                             */
/*==============================================================*/
CREATE TABLE SYS_FIELD (
   FIELD_ID_            VARCHAR(64)          NOT NULL,
   MODULE_ID_           VARCHAR(64)          COLLATE CHINESE_PRC_CI_AS NOT NULL,
   TITLE_               VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NOT NULL,
   ATTR_NAME_           VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NOT NULL,
   LINK_MOD_ID_         VARCHAR(64)          NULL,
   FIELD_TYPE_          VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NOT NULL,
   FIELD_GROUP_         VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   FIELD_LENGTH_        INT                  NULL,
   PRECISION_           INT                  NULL,
   SN_                  INT                  NULL,
   COLSPAN_             INT                  NULL,
   FIELD_CAT_           VARCHAR(20)          NULL,
   RELATION_TYPE_       VARCHAR(20)          NULL,
   EDIT_RIGHT_          VARCHAR(20)          NULL,
   ADD_RIGHT_           VARCHAR(20)          NULL,
   IS_HIDDEN_           VARCHAR(6)           NULL,
   IS_READABLE_         VARCHAR(6)           NULL,
   IS_REQUIRED_         VARCHAR(6)           NULL,
   IS_DISABLED_         VARCHAR(6)           NULL,
   ALLOW_GROUP_         VARCHAR(6)           NULL,
   ALLOW_SORT_          VARCHAR(6)           NULL,
   ALLOW_SUM_           VARCHAR(6)           NULL,
   IS_DEFAULT_COL_      VARCHAR(8)           NULL,
   IS_QUERY_COL_        VARCHAR(8)           NULL,
   DEF_VALUE_           VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   REMARK_              TEXT                 COLLATE CHINESE_PRC_CI_AS NULL,
   SHOW_NAV_TREE_       VARCHAR(6)           NULL,
   DB_FIELD_NAME_       VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   DB_FIELD_FORMULA_    TEXT                 COLLATE CHINESE_PRC_CI_AS NULL,
   ALLOW_EXCEL_INSERT_  VARCHAR(6)           NULL,
   ALLOW_EXCEL_EDIT_    VARCHAR(6)           NULL,
   HAS_ATTACH_          VARCHAR(6)           NULL,
   IS_CHAR_CAT_         VARCHAR(6)           NULL,
   RENDERER_            VARCHAR(512)         NULL,
   IS_USER_DEF_         VARCHAR(6)           NULL,
   COMP_TYPE_           VARCHAR(50)          NULL,
   JSON_CONFIG_         TEXT                 NULL,
   LINK_ADD_MODE_       VARCHAR(16)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_FIELD PRIMARY KEY NONCLUSTERED (FIELD_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '功能模块字段',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段ID',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'FIELD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'MODULE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段名称',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'ATTR_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关联模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'LINK_MOD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段类型',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'FIELD_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段分组',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'FIELD_GROUP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段长度',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'FIELD_LENGTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段精度',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'PRECISION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段序号',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '跨列数',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'COLSPAN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段分类
   FIELD_COMMON=普通字段
   FIELD_PK=主键字段
   FIELD_RELATION=关系字段
   ',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'FIELD_CAT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'OneToMany
   ManyToOne
   OneToOne
   ManyToMany',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'RELATION_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '编辑权限',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'EDIT_RIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '添加权限',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'ADD_RIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否隐藏',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_HIDDEN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否只读',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_READABLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否必须',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_REQUIRED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否禁用',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_DISABLED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许分组',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'ALLOW_GROUP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许统计',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'ALLOW_SUM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否缺省显示列',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_DEFAULT_COL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否缺省查询列',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_QUERY_COL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '缺省值',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'DEF_VALUE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'REMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否在导航树上展示',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'SHOW_NAV_TREE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据库字段名',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'DB_FIELD_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据库字段公式',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'DB_FIELD_FORMULA_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许Excel插入',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'ALLOW_EXCEL_INSERT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许Excel编辑',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'ALLOW_EXCEL_EDIT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许有附件',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'HAS_ATTACH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否图表分类',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_CHAR_CAT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户定义字段
   当为用户定义字段时，其展示方式则由JS上的字段展示控制',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'IS_USER_DEF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关联字段值新增方式，只对关联的字段才有效
   有三种值，
   WINDOW=通过弹出对话框进行新增加
   SELECT=通过弹出窗口进行选择
   INNER=通过在列表中进行编辑增加处理',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'LINK_ADD_MODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_FIELD', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_FILE                                              */
/*==============================================================*/
CREATE TABLE SYS_FILE (
   FILE_ID_             VARCHAR(64)          NOT NULL,
   TYPE_ID_             VARCHAR(64)          NULL,
   FILE_NAME_           VARCHAR(100)         NOT NULL,
   NEW_FNAME_           VARCHAR(100)         NULL,
   PATH_                VARCHAR(255)         NOT NULL,
   THUMBNAIL_           VARCHAR(120)         NULL,
   EXT_                 VARCHAR(20)          NULL,
   MINE_TYPE_           VARCHAR(50)          NULL,
   DESC_                VARCHAR(255)         NULL,
   TOTAL_BYTES_         INT                  NULL,
   DEL_STATUS_          VARCHAR(20)          NULL,
   MODULE_ID_           VARCHAR(64)          NULL,
   RECORD_ID_           VARCHAR(64)          NULL,
   FROM_                VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   COVER_STATUS_        VARCHAR(20)          NULL,
   CONSTRAINT PK_SYS_FILE PRIMARY KEY NONCLUSTERED (FILE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统附件',
   'user', @CURRENTUSER, 'table', 'SYS_FILE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类ID',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'TYPE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件名',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'FILE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '新文件名',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'NEW_FNAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件路径',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '图片缩略图',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'THUMBNAIL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '扩展名',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'EXT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件类型',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'MINE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '说明',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '总字节数',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'TOTAL_BYTES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '删除标识',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'DEL_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'MODULE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '记录ID',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'RECORD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '来源类型
   APPLICATION=应用级上传类型
   SELF=个性上传',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'FROM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '生成PDF状态',
   'user', @CURRENTUSER, 'table', 'SYS_FILE', 'column', 'COVER_STATUS_'
go

/*==============================================================*/
/* Table: SYS_FORM_FIELD                                        */
/*==============================================================*/
CREATE TABLE SYS_FORM_FIELD (
   FORM_FIELD_ID_       VARCHAR(64)          NOT NULL,
   GROUP_ID_            VARCHAR(64)          NULL,
   FIELD_ID_            VARCHAR(64)          NULL,
   FIELD_NAME_          VARCHAR(50)          NOT NULL,
   FIELD_LABEL_         VARCHAR(64)          NOT NULL,
   SN_                  INT                  NOT NULL,
   HEIGHT_              INT                  NULL,
   WIDTH_               INT                  NULL,
   COLSPAN_             INT                  NULL,
   JSON_CONF_           TEXT                 NULL,
   COMP_TYPE_           VARCHAR(50)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_FORM_FIELD PRIMARY KEY NONCLUSTERED (FORM_FIELD_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单组内字段',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单字段ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'FORM_FIELD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分组ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'FIELD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '高',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'HEIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '宽',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'WIDTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列跨度',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'COLSPAN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '其他JSON设置',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'JSON_CONF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_FIELD', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_FORM_GROUP                                        */
/*==============================================================*/
CREATE TABLE SYS_FORM_GROUP (
   GROUP_ID_            VARCHAR(64)          NOT NULL,
   FORM_SCHEMA_ID_      VARCHAR(64)          NULL,
   TITLE_               VARCHAR(50)          NOT NULL,
   SN_                  INT                  NOT NULL,
   DISPLAY_MODE_        VARCHAR(50)          NULL,
   COLLAPSIBLE_         VARCHAR(8)           NULL,
   COLLAPSED_           VARCHAR(8)           NULL,
   SUB_MODEL_ID_        VARCHAR(64)          NULL,
   JSON_CONFIG_         TEXT                 NULL,
   COL_NUMS_            INT                  NULL,
   CONSTRAINT PK_SYS_FORM_GROUP PRIMARY KEY NONCLUSTERED (GROUP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统表单字段分组',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单方案ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'FORM_SCHEMA_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组标题',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '显示模式',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'DISPLAY_MODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否可收缩',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'COLLAPSIBLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '默认收缩',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'COLLAPSED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '子模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'SUB_MODEL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '其他JSON配置',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'JSON_CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列数',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_GROUP', 'column', 'COL_NUMS_'
go

/*==============================================================*/
/* Table: SYS_FORM_SCHEMA                                       */
/*==============================================================*/
CREATE TABLE SYS_FORM_SCHEMA (
   FORM_SCHEMA_ID_      VARCHAR(64)          NOT NULL,
   MODULE_ID_           VARCHAR(64)          NULL,
   SCHEMA_NAME_         VARCHAR(64)          NOT NULL,
   TITLE_               VARCHAR(50)          NULL,
   SN_                  INT                  NOT NULL,
   IS_SYSTEM_           VARCHAR(8)           NOT NULL,
   SCHEMA_KEY_          VARCHAR(50)          NOT NULL,
   WIN_WIDTH_           INT                  NOT NULL,
   WIN_HEIGHT_          INT                  NOT NULL,
   COL_NUMS_            INT                  NOT NULL,
   DISPLAY_MODE_        VARCHAR(50)          NOT NULL,
   JSON_CONFIG_         TEXT                 NULL,
   CONSTRAINT PK_SYS_FORM_SCHEMA PRIMARY KEY NONCLUSTERED (FORM_SCHEMA_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单方案',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单方案ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'FORM_SCHEMA_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'MODULE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案名称',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'SCHEMA_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表单标题',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案排序',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否为系统默认',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'IS_SYSTEM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '方案Key',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'SCHEMA_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '窗口宽',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'WIN_WIDTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '窗口高',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'WIN_HEIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列数',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'COL_NUMS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '显示模式',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'DISPLAY_MODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '其他JSON配置',
   'user', @CURRENTUSER, 'table', 'SYS_FORM_SCHEMA', 'column', 'JSON_CONFIG_'
go

/*==============================================================*/
/* Table: SYS_GRID_FIELD                                        */
/*==============================================================*/
CREATE TABLE SYS_GRID_FIELD (
   GD_FIELD_ID_         VARCHAR(64)          NOT NULL,
   FIELD_ID_            VARCHAR(64)          NULL,
   FIELD_NAME_          VARCHAR(50)          NULL,
   FIELD_TITLE_         VARCHAR(50)          NOT NULL,
   GRID_VIEW_ID_        VARCHAR(64)          NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   PATH_                VARCHAR(255)         NULL,
   ITEM_TYPE_           VARCHAR(20)          NULL,
   SN_                  INT                  NOT NULL,
   IS_LOCK_             VARCHAR(8)           NULL,
   ALLOW_SORT_          VARCHAR(8)           NULL,
   IS_HIDDEN_           VARCHAR(8)           NULL,
   ALLOW_SUM_           VARCHAR(8)           NULL,
   COL_WIDTH_           INT                  NULL,
   IS_EXPORT_           VARCHAR(8)           NULL,
   FOMART_              VARCHAR(250)         NULL,
   REMARK_              TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_GRID_FIELD PRIMARY KEY NONCLUSTERED (GD_FIELD_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列表视图分组及字段',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段ID',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'FIELD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属图视图ID
   当不属于任何分组时，需要填写该值',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'GRID_VIEW_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '项类型
   GROUP=分组
   FIELD=字段',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'ITEM_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否锁定',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'IS_LOCK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许排序',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'ALLOW_SORT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否隐藏',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'IS_HIDDEN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许总计',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'ALLOW_SUM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列宽',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'COL_WIDTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否允许导出',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'IS_EXPORT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '格式化',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'FOMART_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'REMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_FIELD', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_GRID_VIEW                                         */
/*==============================================================*/
CREATE TABLE SYS_GRID_VIEW (
   GRID_VIEW_ID_        VARCHAR(64)          NOT NULL,
   MODULE_ID_           VARCHAR(64)          NULL,
   NAME_                VARCHAR(60)          NOT NULL,
   IS_SYSTEM_           VARCHAR(8)           NULL,
   IS_DEFAULT_          VARCHAR(8)           NULL,
   ALLOW_EDIT_          VARCHAR(8)           NULL,
   CLICK_ROW_ACTION_    VARCHAR(120)         NULL,
   DEF_SORT_FIELD_      VARCHAR(50)          NULL,
   SN_                  INT                  NOT NULL,
   REMARK_              TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_GRID_VIEW PRIMARY KEY NONCLUSTERED (GRID_VIEW_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '列表展示视图',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'MODULE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否系统默认',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'IS_SYSTEM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否在表格中编辑',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'ALLOW_EDIT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '点击行动作',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'CLICK_ROW_ACTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '默认排序',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'DEF_SORT_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'REMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_GRID_VIEW', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_INST                                              */
/*==============================================================*/
CREATE TABLE SYS_INST (
   INST_ID_             VARCHAR(64)          NOT NULL,
   NAME_CN_             VARCHAR(256)         NOT NULL,
   NAME_EN_             VARCHAR(256)         NOT NULL,
   BUS_LICE_NO_         VARCHAR(50)          NOT NULL,
   INST_NO_             VARCHAR(50)          NOT NULL,
   BUS_LICE_FILE_ID_    VARCHAR(64)          NULL,
   REG_CODE_FILE_ID_    VARCHAR(64)          NULL,
   DOMAIN_              VARCHAR(100)         NOT NULL,
   NAME_CN_S_           VARCHAR(80)          NULL,
   NAME_EN_S_           VARCHAR(80)          NULL,
   LEGAL_MAN_           VARCHAR(64)          NULL,
   DESCP_               TEXT                 NULL,
   ADDRESS_             VARCHAR(128)         NULL,
   PHONE_               VARCHAR(30)          NULL,
   EMAIL_               VARCHAR(255)         NULL,
   FAX_                 VARCHAR(30)          NULL,
   CONTRACTOR_          VARCHAR(30)          NULL,
   DS_NAME_             VARCHAR(64)          NULL,
   DS_ALIAS_            VARCHAR(64)          NULL,
   HOME_URL_            VARCHAR(120)         NULL,
   INST_TYPE_           VARCHAR(50)          NULL,
   STATUS_              VARCHAR(30)          NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   PATH_                VARCHAR(1024)        NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_INST PRIMARY KEY NONCLUSTERED (INST_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '注册机构',
   'user', @CURRENTUSER, 'table', 'SYS_INST'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司中文名',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'NAME_CN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司英文名',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'NAME_EN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构编码',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'INST_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司营业执照图片',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'BUS_LICE_FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组织机构代码证图',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'REG_CODE_FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司域名
   唯一，用户后续的账号均是以此为缀，如公司的域名为abc.com,管理员的账号为admin@abc.com',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'DOMAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司简称(中文)',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'NAME_CN_S_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司简称(英文)',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'NAME_EN_S_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司法人',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'LEGAL_MAN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公司描述',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '地址',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'ADDRESS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系电话',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'PHONE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '传真',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'FAX_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'CONTRACTOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源名称',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'DS_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源别名',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'DS_ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构类型',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'INST_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_INST', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_INST_TYPE                                         */
/*==============================================================*/
CREATE TABLE SYS_INST_TYPE (
   TYPE_ID_             VARCHAR(64)          NOT NULL,
   TYPE_CODE_           VARCHAR(50)          NULL,
   TYPE_NAME_           VARCHAR(100)         NULL,
   ENABLED_             VARCHAR(20)          NULL,
   IS_DEFAULT_          VARCHAR(20)          NULL,
   HOME_URL_            VARCHAR(200)         NULL,
   DESCP_               VARCHAR(500)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_INST_TYPE PRIMARY KEY NONCLUSTERED (TYPE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构类型',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'TYPE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型编码',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'TYPE_CODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型名称',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'TYPE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否启用',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'ENABLED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否系统缺省',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_INST_TYPE_MENU                                    */
/*==============================================================*/
CREATE TABLE SYS_INST_TYPE_MENU (
   ID_                  VARCHAR(64)          NOT NULL,
   INST_TYPE_ID_        VARCHAR(64)          NULL,
   SYS_ID_              VARCHAR(64)          NULL,
   MENU_ID_             VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_INST_TYPE_MENU PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构类型授权菜单',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE_MENU'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE_MENU', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构类型ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE_MENU', 'column', 'INST_TYPE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '子系统ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE_MENU', 'column', 'SYS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '菜单ID',
   'user', @CURRENTUSER, 'table', 'SYS_INST_TYPE_MENU', 'column', 'MENU_ID_'
go

/*==============================================================*/
/* Table: SYS_LDAP_CN                                           */
/*==============================================================*/
CREATE TABLE SYS_LDAP_CN (
   SYS_LDAP_USER_ID_    VARCHAR(64)          NOT NULL,
   USER_ID_             VARCHAR(64)          NULL,
   SYS_LDAP_OU_ID_      VARCHAR(64)          NULL,
   USER_ACCOUNT_        VARCHAR(64)          NULL,
   USER_CODE_           VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NULL,
   TEL_                 VARCHAR(64)          NULL,
   MAIL_                VARCHAR(512)         NULL,
   USN_CREATED_         VARCHAR(64)          NULL,
   USN_CHANGED_         VARCHAR(64)          NULL,
   WHEN_CREATED_        VARCHAR(64)          NULL,
   WHEN_CHANGED_        VARCHAR(64)          NULL,
   STATUS_              VARCHAR(64)          NULL,
   USER_PRINCIPAL_NAME_ VARCHAR(512)         NULL,
   DN_                  VARCHAR(512)         NULL,
   OC_                  VARCHAR(512)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_LDAP_CN PRIMARY KEY NONCLUSTERED (SYS_LDAP_USER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SYS_LDAP_CN【LADP用户】',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'LDAP用户（主键）',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'SYS_LDAP_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组织单元（主键）',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'SYS_LDAP_OU_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '账户',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'USER_ACCOUNT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户编号',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'USER_CODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '电话',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'TEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '邮件',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'MAIL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'USN_CREATED',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'USN_CREATED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'USN_CHANGED',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'USN_CHANGED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'LDAP创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'WHEN_CREATED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'LDAP更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'WHEN_CHANGED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户主要名称',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'USER_PRINCIPAL_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '区分名',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'DN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '对象类型',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'OC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CN', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: SYS_LDAP_CONFIG                                       */
/*==============================================================*/
CREATE TABLE SYS_LDAP_CONFIG (
   SYS_LDAP_CONFIG_ID_  VARCHAR(64)          NOT NULL,
   STATUS_              VARCHAR(64)          NULL,
   STATUS_CN_           VARCHAR(64)          NULL,
   DN_BASE_             VARCHAR(1024)        NULL,
   DN_DATUM_            VARCHAR(1024)        NULL,
   URL_                 VARCHAR(1024)        NULL,
   ACCOUNT_             VARCHAR(64)          NULL,
   PASSWORD_            VARCHAR(64)          NULL,
   DEPT_FILTER_         VARCHAR(1024)        NULL,
   USER_FILTER_         VARCHAR(1024)        NULL,
   ATT_USER_NO_         VARCHAR(64)          NULL,
   ATT_USER_ACC_        VARCHAR(64)          NULL,
   ATT_USER_NAME_       VARCHAR(64)          NULL,
   ATT_USER_PWD_        VARCHAR(1024)        NULL,
   ATT_USER_TEL_        VARCHAR(64)          NULL,
   ATT_USER_MAIL_       VARCHAR(64)          NULL,
   ATT_DEPT_NAME_       VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_LDAP_CONFIG PRIMARY KEY NONCLUSTERED (SYS_LDAP_CONFIG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'LDAP配置(主键)',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'SYS_LDAP_CONFIG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'STATUS_CN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '基本DN',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'DN_BASE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '基准DN',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'DN_DATUM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '地址',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '账号名称',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ACCOUNT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '密码',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'PASSWORD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部门过滤器',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'DEPT_FILTER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户过滤器',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'USER_FILTER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户编号属性',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ATT_USER_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户账户属性',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ATT_USER_ACC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户名称属性',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ATT_USER_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户密码属性',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ATT_USER_PWD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户电话属性',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ATT_USER_TEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户邮件属性',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ATT_USER_MAIL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部门名称属性',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'ATT_DEPT_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_CONFIG', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: SYS_LDAP_LOG                                          */
/*==============================================================*/
CREATE TABLE SYS_LDAP_LOG (
   LOG_ID_              VARCHAR(64)          NOT NULL,
   LOG_NAME_            VARCHAR(256)         NULL,
   CONTENT_             TEXT                 NULL,
   START_TIME_          DATETIME             NULL,
   END_TIME_            DATETIME             NULL,
   RUN_TIME_            INT                  NULL,
   STATUS_              VARCHAR(64)          NULL,
   SYNC_TYPE_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_LDAP_LOG PRIMARY KEY NONCLUSTERED (LOG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SYS_LDAP_LOG【LDAP同步日志】
   ',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志主键',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'LOG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志名称',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'LOG_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志内容',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '持续时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'RUN_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '同步类型',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'SYNC_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_LOG', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: SYS_LDAP_OU                                           */
/*==============================================================*/
CREATE TABLE SYS_LDAP_OU (
   SYS_LDAP_OU_ID_      VARCHAR(64)          NOT NULL,
   GROUP_ID_            VARCHAR(64)          NULL,
   SN_                  INT                  NULL,
   DEPTH_               INT                  NULL,
   PATH_                VARCHAR(1024)        NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   STATUS_              VARCHAR(64)          NULL,
   OU_                  VARCHAR(512)         NULL,
   NAME_                VARCHAR(512)         NULL,
   DN_                  VARCHAR(512)         NULL,
   OC_                  VARCHAR(512)         NULL,
   USN_CREATED_         VARCHAR(64)          NULL,
   USN_CHANGED_         VARCHAR(64)          NULL,
   WHEN_CREATED_        VARCHAR(64)          NULL,
   WHEN_CHANGED_        VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_LDAP_OU PRIMARY KEY NONCLUSTERED (SYS_LDAP_OU_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SYS_LDAP_OU【LDAP组织单元】',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组织单元（主键）',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'SYS_LDAP_OU_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '层次',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'DEPTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父目录',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组织单元',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'OU_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组织单元名称',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '区分名',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'DN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '对象类型',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'OC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'USN_CREATED',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'USN_CREATED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'USN_CHANGED',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'USN_CHANGED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'LDAP创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'WHEN_CREATED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'LDAP更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'WHEN_CHANGED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_LDAP_OU', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: SYS_LIST_SOL                                          */
/*==============================================================*/
CREATE TABLE SYS_LIST_SOL (
   SOL_ID_              VARCHAR(64)          NOT NULL,
   KEY_                 VARCHAR(100)         NOT NULL,
   NAME_                VARCHAR(128)         NOT NULL,
   DESCP_               VARCHAR(256)         NULL,
   RIGHT_CONFIGS_       TEXT                 NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_LIST_SOL PRIMARY KEY NONCLUSTERED (SOL_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统列表方案',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '解决方案ID',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'SOL_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识健',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限配置',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'RIGHT_CONFIGS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_LIST_SOL', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_MENU                                              */
/*==============================================================*/
CREATE TABLE SYS_MENU (
   MENU_ID_             VARCHAR(64)          NOT NULL,
   SYS_ID_              VARCHAR(64)          NULL,
   NAME_                VARCHAR(60)          NOT NULL,
   KEY_                 VARCHAR(80)          NULL,
   FORM_                VARCHAR(80)          NULL,
   ENTITY_NAME_         VARCHAR(100)         NULL,
   MODULE_ID_           VARCHAR(64)          NULL,
   ICON_CLS_            VARCHAR(32)          NULL,
   IMG_                 VARCHAR(50)          NULL,
   PARENT_ID_           VARCHAR(64)          NOT NULL,
   DEPTH_               INT                  NULL,
   PATH_                VARCHAR(256)         NULL,
   SN_                  INT                  NULL,
   URL_                 VARCHAR(256)         NULL,
   SHOW_TYPE_           VARCHAR(20)          NULL,
   IS_BTN_MENU_         VARCHAR(20)          NOT NULL,
   CHILDS_              INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   BO_LIST_ID_          VARCHAR(256)         NULL,
   CONSTRAINT PK_SYS_MENU PRIMARY KEY NONCLUSTERED (MENU_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '菜单项目',
   'user', @CURRENTUSER, 'table', 'SYS_MENU'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属子系统',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'SYS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '菜单名称',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '菜单Key',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实体表单',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'FORM_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块实体名',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'ENTITY_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'MODULE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '图标样式',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'ICON_CLS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '图标',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'IMG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上级父ID',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '层次',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'DEPTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '访问地址URL',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '访问方式
    缺省打开
   在新窗口打开',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'SHOW_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表示是否为按钮菜单
   YES=为按钮菜单
   NO=非按钮菜单',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'IS_BTN_MENU_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'BO列表ID',
   'user', @CURRENTUSER, 'table', 'SYS_MENU', 'column', 'BO_LIST_ID_'
go

/*==============================================================*/
/* Table: SYS_MODULE                                            */
/*==============================================================*/
CREATE TABLE SYS_MODULE (
   MODULE_ID_           VARCHAR(64)          NOT NULL,
   TITLE_               VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NOT NULL,
   DESCP_               VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   REQ_URL_             VARCHAR(150)         COLLATE CHINESE_PRC_CI_AS NULL,
   ICON_CLS_            VARCHAR(20)          COLLATE CHINESE_PRC_CI_AS NULL,
   SHORT_NAME_          VARCHAR(20)          COLLATE CHINESE_PRC_CI_AS NULL,
   SYS_ID_              VARCHAR(64)          NULL,
   TABLE_NAME_          VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   ENTITY_NAME_         VARCHAR(100)         NULL,
   NAMESPACE_           VARCHAR(100)         NULL,
   PK_FIELD_            VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NOT NULL,
   PK_DB_FIELD_         VARCHAR(50)          NULL,
   CODE_FIELD_          VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   ORDER_FIELD_         VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   DATE_FIELD_          VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   YEAR_FIELD_          VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   MONTH_FIELD_         VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   SENSON_FIELD_        VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   FILE_FIELD_          VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   IS_ENABLED_          VARCHAR(6)           NOT NULL,
   ALLOW_AUDIT_         VARCHAR(6)           NOT NULL,
   ALLOW_APPROVE_       VARCHAR(6)           NOT NULL,
   HAS_ATTACHS_         VARCHAR(6)           NOT NULL,
   DEF_ORDER_FIELD_     VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   SEQ_CODE_            VARCHAR(50)          COLLATE CHINESE_PRC_CI_AS NULL,
   HAS_CHART_           VARCHAR(6)           NOT NULL,
   HELP_HTML_           TEXT                 COLLATE CHINESE_PRC_CI_AS NULL,
   IS_DEFAULT_          VARCHAR(8)           NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_MODULE PRIMARY KEY NONCLUSTERED (MODULE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统功能模块',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块ID',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'MODULE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模块标题',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '映射URL地址',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'REQ_URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'icon地址样式',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'ICON_CLS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '简称',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'SHORT_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属子系统',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'SYS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '表名',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'TABLE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实体名',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'ENTITY_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '命名空间',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'NAMESPACE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键字段名',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'PK_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '编码字段名',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'CODE_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排序字段名',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'ORDER_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日期字段',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'DATE_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '年份字段',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'YEAR_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '月份字段',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'MONTH_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '季度字段',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'SENSON_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件字段',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'FILE_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否启用',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'IS_ENABLED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否审计执行日记',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'ALLOW_AUDIT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否启动审批',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'ALLOW_APPROVE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否有附件',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'HAS_ATTACHS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '缺省排序字段',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'DEF_ORDER_FIELD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '编码流水键',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'SEQ_CODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否有图表',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'HAS_CHART_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '帮助内容',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'HELP_HTML_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否系统默认
   YES
   NO',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_MODULE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_OFFICE                                            */
/*==============================================================*/
CREATE TABLE SYS_OFFICE (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(200)         NULL,
   SUPPORT_VERSION_     VARCHAR(64)          NULL,
   VERSION_             INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_OFFICE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'OFFICE附件',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '支持版本',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'SUPPORT_VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_OFFICE_TEMPLATE                                   */
/*==============================================================*/
CREATE TABLE SYS_OFFICE_TEMPLATE (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(200)         NULL,
   TYPE_                VARCHAR(20)          NULL,
   DOC_ID_              VARCHAR(200)         NULL,
   DOC_NAME_            VARCHAR(200)         NULL,
   DESCRIPTION_         VARCHAR(255)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_OFFICE_TEMPLATE PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'OFFICE模板',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型(normal,red)',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文档ID',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'DOC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件名',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'DOC_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'DESCRIPTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_TEMPLATE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_OFFICE_VER                                        */
/*==============================================================*/
CREATE TABLE SYS_OFFICE_VER (
   ID_                  VARCHAR(64)          NOT NULL,
   OFFICE_ID_           VARCHAR(64)          NULL,
   VERSION_             INT                  NULL,
   FILE_ID_             VARCHAR(64)          NULL,
   FILE_NAME_           VARCHAR(200)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_OFFICE_VER PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'OFFICE版本',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'OFFICE主键',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'OFFICE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '版本',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'VERSION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '附件ID',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'FILE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '文件名',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'FILE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_OFFICE_VER', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_PRIVATE_PROPERTIES                                */
/*==============================================================*/
CREATE TABLE SYS_PRIVATE_PROPERTIES (
   ID_                  VARCHAR(64)          NOT NULL,
   PRO_ID_              VARCHAR(64)          NULL,
   PRI_VALUE_           VARCHAR(2000)        NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_PRIVATE_PROPERTIES PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户参数',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数主键',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'PRO_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数值',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'PRI_VALUE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_PRIVATE_PROPERTIES', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_PROPERTIES                                        */
/*==============================================================*/
CREATE TABLE SYS_PROPERTIES (
   PRO_ID_              VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(64)          NULL,
   ALIAS_               VARCHAR(64)          NULL,
   GLOBAL_              VARCHAR(64)          NULL,
   ENCRYPT_             VARCHAR(64)          NULL,
   VALUE_               VARCHAR(2000)        NULL,
   CATEGORY_            VARCHAR(100)         NULL,
   DESCRIPTION_         VARCHAR(200)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_PROPERTIES PRIMARY KEY NONCLUSTERED (PRO_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统属性表',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性ID',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'PRO_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否全局',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'GLOBAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否加密',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'ENCRYPT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '属性值',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'VALUE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'CATEGORY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'DESCRIPTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_PROPERTIES', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_QUARTZ_LOG                                        */
/*==============================================================*/
CREATE TABLE SYS_QUARTZ_LOG (
   LOG_ID_              VARCHAR(64)          NOT NULL,
   ALIAS_               VARCHAR(256)         NULL,
   JOB_NAME_            VARCHAR(256)         NULL,
   TRIGGER_NAME_        VARCHAR(256)         NULL,
   CONTENT_             TEXT                 NULL,
   START_TIME_          DATETIME             NULL,
   END_TIME_            DATETIME             NULL,
   RUN_TIME_            INT                  NULL,
   STATUS_              VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_QUARTZ_LOG PRIMARY KEY NONCLUSTERED (LOG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '定时器日志
   ',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志??键ID',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'LOG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务别名',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务名称',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'JOB_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '计划名称',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'TRIGGER_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '日志内容',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '持续时间',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'RUN_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态STATUS_',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用ID',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_QUARTZ_LOG', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_REPORT                                            */
/*==============================================================*/
CREATE TABLE SYS_REPORT (
   REP_ID_              VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   SUBJECT_             VARCHAR(128)         NOT NULL,
   KEY_                 VARCHAR(128)         NULL,
   DESCP_               VARCHAR(500)         NOT NULL,
   FILE_PATH_           VARCHAR(128)         NOT NULL,
   SELF_HANDLE_BEAN_    VARCHAR(100)         NULL,
   FILE_ID_             VARCHAR(64)          NULL,
   IS_DEFAULT_          VARCHAR(20)          NULL,
   PARAM_CONFIG_        TEXT                 NULL,
   ENGINE_              VARCHAR(30)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   DS_ALIAS_            VARCHAR(64)          NULL,
   CONSTRAINT PK_SYS_REPORT PRIMARY KEY NONCLUSTERED (REP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统报表',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '报表ID',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'REP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识key',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '报表模块的jasper文件的路径',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'FILE_PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '报表参数自定义处理Bean',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'SELF_HANDLE_BEAN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否缺省
   1=缺省
   0=非缺省',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数配置',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'PARAM_CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '报表解析引擎，可同时支持多种报表引擎类型，如
   JasperReport
   FineReport',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'ENGINE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据源',
   'user', @CURRENTUSER, 'table', 'SYS_REPORT', 'column', 'DS_ALIAS_'
go

/*==============================================================*/
/* Table: SYS_RES_AUTH                                          */
/*==============================================================*/
CREATE TABLE SYS_RES_AUTH (
   AUTH_ID_             VARCHAR(64)          NOT NULL,
   RES_ID_              VARCHAR(64)          NOT NULL,
   GROUP_ID_            VARCHAR(64)          NOT NULL,
   RES_TYPE_            VARCHAR(80)          NOT NULL,
   RIGHT_               VARCHAR(20)          NOT NULL,
   VISIT_SUB_           VARCHAR(20)          NULL,
   CONSTRAINT PK_SYS_RES_AUTH PRIMARY KEY NONCLUSTERED (AUTH_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统资源权限表',
   'user', @CURRENTUSER, 'table', 'SYS_RES_AUTH'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '授权ID',
   'user', @CURRENTUSER, 'table', 'SYS_RES_AUTH', 'column', 'AUTH_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资源主键，其值为不同表的主键',
   'user', @CURRENTUSER, 'table', 'SYS_RES_AUTH', 'column', 'RES_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组ID',
   'user', @CURRENTUSER, 'table', 'SYS_RES_AUTH', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资源类型
   暂时使用表名',
   'user', @CURRENTUSER, 'table', 'SYS_RES_AUTH', 'column', 'RES_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '权限
   ALL=所有权限
   GET=查看
   DEL=删除
   EDIT=编辑
   QERY=查询
   ',
   'user', @CURRENTUSER, 'table', 'SYS_RES_AUTH', 'column', 'RIGHT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'YES
   NO',
   'user', @CURRENTUSER, 'table', 'SYS_RES_AUTH', 'column', 'VISIT_SUB_'
go

/*==============================================================*/
/* Table: SYS_SEARCH                                            */
/*==============================================================*/
CREATE TABLE SYS_SEARCH (
   SEARCH_ID_           VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(100)         NOT NULL,
   ENTITY_NAME_         VARCHAR(100)         NOT NULL,
   ENABLED_             VARCHAR(8)           NOT NULL,
   IS_DEFAULT_          VARCHAR(8)           NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_SEARCH PRIMARY KEY NONCLUSTERED (SEARCH_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '高级搜索',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '搜索名称',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '实体名称',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'ENTITY_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否启用',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'ENABLED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_SEARCH_ITEM                                       */
/*==============================================================*/
CREATE TABLE SYS_SEARCH_ITEM (
   ITEM_ID_             VARCHAR(64)          NOT NULL,
   SEARCH_ID_           VARCHAR(64)          NOT NULL,
   NODE_TYPE_           VARCHAR(20)          NOT NULL,
   NODE_TYPE_LABEL_     VARCHAR(20)          NULL,
   PARENT_ID_           VARCHAR(64)          NOT NULL,
   PATH_                VARCHAR(256)         NULL,
   SN_                  INT                  NULL,
   FIELD_TYPE_          VARCHAR(20)          NULL,
   LABEL_               VARCHAR(100)         NOT NULL,
   FIELD_OP_            VARCHAR(20)          NULL,
   FIELD_OP_LABEL_      VARCHAR(32)          NULL,
   FIELD_TITLE_         VARCHAR(50)          NULL,
   FIELD_ID_            VARCHAR(64)          NULL,
   FIELD_NAME_          VARCHAR(64)          NULL,
   FIELD_VAL_           VARCHAR(80)          NULL,
   CTL_TYPE_            VARCHAR(50)          NULL,
   FORMAT_              VARCHAR(50)          NULL,
   PRE_HANDLE_          TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_SEARCH_ITEM PRIMARY KEY NONCLUSTERED (ITEM_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '搜索条件项',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '条件类型',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'NODE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段类型',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'FIELD_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '条件标签',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'LABEL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段标签',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'FIELD_TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'FIELD_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段名称',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'FIELD_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '字段值',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'FIELD_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '控件类型',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'CTL_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '值格式',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'FORMAT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '预处理',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'PRE_HANDLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_SEARCH_ITEM', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_SEQ_ID                                            */
/*==============================================================*/
CREATE TABLE SYS_SEQ_ID (
   SEQ_ID_              VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(80)          NOT NULL,
   ALIAS_               VARCHAR(50)          NULL,
   CUR_DATE_            DATETIME             NULL,
   RULE_                VARCHAR(100)         NOT NULL,
   RULE_CONF_           VARCHAR(512)         NULL,
   INIT_VAL_            INT                  NULL,
   GEN_TYPE_            VARCHAR(20)          NULL,
   LEN_                 INT                  NULL,
   CUR_VAL              INT                  NULL,
   STEP_                SMALLINT             NULL,
   MEMO_                VARCHAR(512)         NULL,
   IS_DEFAULT_          VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_SEQ_ID PRIMARY KEY NONCLUSTERED (SEQ_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统流水号',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流水号ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'SEQ_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '当前日期',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'CUR_DATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '规则',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'RULE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '规则配置',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'RULE_CONF_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '初始值',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'INIT_VAL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '生成方式
   DAY=每天
   WEEK=每周
   MONTH=每月
   YEAR=每年
   AUTO=一直增长',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'GEN_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流水号长度',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'LEN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '当前值',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'CUR_VAL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '步长',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'STEP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'MEMO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统缺省
   YES
   NO',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_SEQ_ID', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_STAMP                                             */
/*==============================================================*/
CREATE TABLE SYS_STAMP (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(200)         NULL,
   SIGN_USER_           VARCHAR(64)          NULL,
   PASSWORD_            VARCHAR(64)          NULL,
   STAMP_ID_            VARCHAR(64)          NULL,
   DESCRIPTION_         VARCHAR(255)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_STAMP PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'office印章',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签章名称',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签章用户',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'SIGN_USER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签章密码',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'PASSWORD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '印章文件ID',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'STAMP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'DESCRIPTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_STAMP', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_SUBSYS                                            */
/*==============================================================*/
CREATE TABLE SYS_SUBSYS (
   SYS_ID_              VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(80)          NOT NULL,
   KEY_                 VARCHAR(64)          NOT NULL,
   LOGO_                VARCHAR(120)         NULL,
   IS_DEFAULT_          VARCHAR(12)          NOT NULL,
   HOME_URL_            VARCHAR(120)         NULL,
   STATUS_              VARCHAR(20)          NOT NULL,
   DESCP_               VARCHAR(256)         NULL,
   ICON_CLS_            VARCHAR(50)          NULL,
   SN_                  INT                  NULL,
   INST_TYPE_           VARCHAR(50)          NULL,
   IS_SAAS_             VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_SUBSYS PRIMARY KEY NONCLUSTERED (SYS_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '子系统',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统名称',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统Key',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统Logo',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'LOGO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否缺省',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '首页地址',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'HOME_URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态
   YES/NO',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '图标样式',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'ICON_CLS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_SUBSYS', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_TEMPLATE                                          */
/*==============================================================*/
CREATE TABLE SYS_TEMPLATE (
   TEMP_ID_             VARCHAR(64)          NOT NULL,
   TREE_ID_             VARCHAR(64)          NULL,
   NAME_                VARCHAR(80)          NOT NULL,
   KEY_                 VARCHAR(50)          NOT NULL,
   CAT_KEY_             VARCHAR(64)          NOT NULL,
   IS_DEFAULT_          VARCHAR(20)          NOT NULL,
   CONTENT_             TEXT                 NOT NULL,
   DESCP                VARCHAR(500)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_TEMPLATE PRIMARY KEY NONCLUSTERED (TEMP_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统模板',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板ID',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'TEMP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板名称',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板KEY',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板分类Key',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'CAT_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否系统缺省',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'IS_DEFAULT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板内容',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '模板描述',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'DESCP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_TEMPLATE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_TREE                                              */
/*==============================================================*/
CREATE TABLE SYS_TREE (
   TREE_ID_             VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(128)         NOT NULL,
   PATH_                VARCHAR(1024)        NULL,
   DEPTH_               INT                  NOT NULL,
   PARENT_ID_           VARCHAR(64)          NULL,
   KEY_                 VARCHAR(64)          NOT NULL,
   CODE_                VARCHAR(50)          NULL,
   DESCP_               VARCHAR(512)         NULL,
   CAT_KEY_             VARCHAR(64)          NOT NULL,
   SN_                  INT                  NOT NULL,
   DATA_SHOW_TYPE_      VARCHAR(20)          NULL,
   CHILDS_              INT                  NULL,
   USER_ID_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_TREE PRIMARY KEY NONCLUSTERED (TREE_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统分类树
   用于显示树层次结构的分类
   可以允许任何层次结构',
   'user', @CURRENTUSER, 'table', 'SYS_TREE'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Id',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'TREE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '路径',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'PATH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '层次',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'DEPTH_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '父节点',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'PARENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '节点的分类Key',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '同级编码',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'CODE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统树分类key',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'CAT_KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '数据项展示类型
   默认为:FLAT=平铺类型
   TREE=树类型',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'DATA_SHOW_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID
   树所属的用户ID,可空',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_TREE', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_TREE_CAT                                          */
/*==============================================================*/
CREATE TABLE SYS_TREE_CAT (
   CAT_ID_              VARCHAR(64)          NOT NULL,
   KEY_                 VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(64)          NOT NULL,
   SN_                  INT                  NULL,
   DESCP_               VARCHAR(255)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_TREE_CAT PRIMARY KEY NONCLUSTERED (CAT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '系统树分类类型',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类Key',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'KEY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类名称',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '序号',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'SN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'DESCP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_TREE_CAT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: SYS_TYPE_SUB_REF                                      */
/*==============================================================*/
CREATE TABLE SYS_TYPE_SUB_REF (
   ID_                  VARCHAR(64)          NOT NULL,
   INST_TYPE_ID_        VARCHAR(64)          NULL,
   SUB_SYS_ID_          VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_SYS_TYPE_SUB_REF PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构子系统关系表',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构类型ID',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'INST_TYPE_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '子系统ID',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'SUB_SYS_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用用户Id',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'SYS_TYPE_SUB_REF', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: TASK_NODE_MSG                                         */
/*==============================================================*/
CREATE TABLE TASK_NODE_MSG (
   MSG_ID_              VARCHAR(64)          NOT NULL,
   SUBJECT_             VARCHAR(128)         NULL,
   CONTENT_             VARCHAR(4000)        NULL,
   LINKED_              VARCHAR(512)         NULL,
   TASK_ID_             VARCHAR(64)          NULL,
   TASK_NODE_NAME_      VARCHAR(128)         NULL,
   DEPLOY_ID_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_TASK_NODE_MSG PRIMARY KEY NONCLUSTERED (MSG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务节点消息表(用于第三方接收)
   
   ',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息ID',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'MSG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主题',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '链接',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'LINKED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务ID',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'TASK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务节点名称',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'TASK_NODE_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '部署ID',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'DEPLOY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'TASK_NODE_MSG', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: TASK_TIP_MSG                                          */
/*==============================================================*/
CREATE TABLE TASK_TIP_MSG (
   ID_                  VARCHAR(64)          NOT NULL,
   TASK_ID_             VARCHAR(64)          NULL,
   SENDER_ID_           VARCHAR(64)          NULL,
   SENDER_TIME_         DATETIME             NULL,
   RECEIVER_ID_         VARCHAR(64)          NULL,
   SUBJECT_             VARCHAR(256)         NULL,
   CONTENT_             VARCHAR(4000)        NULL,
   LINKED_              VARCHAR(512)         NULL,
   SENDBACK_STATUS_     VARCHAR(2)           NULL,
   SHORT_CONTENT_       VARCHAR(128)         NULL,
   STATUS_              VARCHAR(2)           NULL,
   IMPORTANT_STATUS_    VARCHAR(2)           NULL,
   MSG_STATUS_          VARCHAR(32)          NULL,
   READ_TIME_           DATETIME             NULL,
   GEN_TIME_            DATETIME             NULL,
   ISINVALID_           VARCHAR(64)          NULL,
   INCALID_TIME_        DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_TASK_TIP_MSG PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务提示消息表(用于第三方接收)
   
   ',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '提示ID',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '任务ID',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'TASK_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送者ID',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'SENDER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送时间',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'SENDER_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收者ID',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'RECEIVER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主题',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'SUBJECT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '内容',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '链接',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'LINKED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '返回状态',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'SENDBACK_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '简介',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'SHORT_CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主要状态',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'IMPORTANT_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息状态',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'MSG_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '阅读时间',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'READ_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '资料时间',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'GEN_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '撤销',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'ISINVALID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '撤销时间',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'INCALID_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'TASK_TIP_MSG', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: WX_ENT_AGENT                                          */
/*==============================================================*/
CREATE TABLE WX_ENT_AGENT (
   ID_                  VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(100)         NULL,
   DESCRIPTION_         VARCHAR(200)         NULL,
   DOMAIN_              VARCHAR(64)          NULL,
   HOME_URL_            VARCHAR(200)         NULL,
   ENT_ID_              VARCHAR(64)          NULL,
   CORP_ID_             VARCHAR(64)          NULL,
   AGENT_ID_            VARCHAR(64)          NULL,
   SECRET_              VARCHAR(64)          NULL,
   DEFAULT_AGENT_       INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_ENT_AGENT PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信应用',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '信任域名',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'DOMAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '企业主键',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'ENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '企业ID',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'CORP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '应用ID',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'AGENT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '密钥',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'SECRET_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否默认',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'DEFAULT_AGENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'WX_ENT_AGENT', 'column', 'UPDATE_BY_'
go

/*==============================================================*/
/* Table: WX_ENT_CORP                                           */
/*==============================================================*/
CREATE TABLE WX_ENT_CORP (
   ID_                  VARCHAR(64)          NOT NULL,
   CORP_ID_             VARCHAR(64)          NULL,
   SECRET_              VARCHAR(64)          NULL,
   ENABLE_              INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_ENT_CORP PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信企业配置',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '企业ID',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'CORP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '通讯录密钥',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'SECRET_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否启用企业微信',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'ENABLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人',
   'user', @CURRENTUSER, 'table', 'WX_ENT_CORP', 'column', 'UPDATE_BY_'
go

/*==============================================================*/
/* Table: WX_KEY_WORD_REPLY                                     */
/*==============================================================*/
CREATE TABLE WX_KEY_WORD_REPLY (
   ID_                  VARCHAR(64)          NOT NULL,
   PUB_ID_              VARCHAR(64)          NULL,
   KEY_WORD_            VARCHAR(512)         NULL,
   REPLY_TYPE_          VARCHAR(64)          NULL,
   REPLY_CONTENT_       VARCHAR(1024)        NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_KEY_WORD_REPLY PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号关键字回复',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID_',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号ID',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'PUB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '关键字',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'KEY_WORD_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '回复方式',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'REPLY_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '回复内容',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'REPLY_CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_KEY_WORD_REPLY', 'column', 'UPDATE_BY_'
go

/*==============================================================*/
/* Table: WX_MESSAGE_SEND                                       */
/*==============================================================*/
CREATE TABLE WX_MESSAGE_SEND (
   ID                   VARCHAR(64)          NOT NULL,
   PUB_ID_              VARCHAR(64)          NULL,
   MSG_TYPE_            VARCHAR(64)          NULL,
   SEND_TYPE_           VARCHAR(64)          NULL,
   RECEIVER_            VARCHAR(1024)        NULL,
   CONTENT_             TEXT                 NULL,
   SEND_STATE_          VARCHAR(64)          NULL,
   CONFIG_              TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_MESSAGE_SEND PRIMARY KEY NONCLUSTERED (ID)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送消息',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'ID'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号ID',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'PUB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息类型',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'MSG_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送类型',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'SEND_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接收者',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'RECEIVER_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '消息内容',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'CONTENT_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '发送状态',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'SEND_STATE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备用配置',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租户ID',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_MESSAGE_SEND', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: WX_METERIAL                                           */
/*==============================================================*/
CREATE TABLE WX_METERIAL (
   ID_                  VARCHAR(64)          NOT NULL,
   PUB_ID_              VARCHAR(64)          NULL,
   TERM_TYPE_           VARCHAR(64)          NULL,
   MEDIA_TYPE_          VARCHAR(64)          NULL,
   NAME_                VARCHAR(64)          NULL,
   MEDIA_ID_            VARCHAR(64)          NULL,
   ART_CONFIG_          TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_METERIAL PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信素材',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '素材ID',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号ID',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'PUB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '期限类型',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'TERM_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '素材类型',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'MEDIA_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '素材名',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信后台指定ID',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'MEDIA_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '图文配置',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'ART_CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_METERIAL', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: WX_PUB_APP                                            */
/*==============================================================*/
CREATE TABLE WX_PUB_APP (
   ID_                  VARCHAR(64)          NOT NULL,
   WX_NO_               VARCHAR(64)          NULL,
   APP_ID_              VARCHAR(64)          NULL,
   SECRET_              VARCHAR(64)          NULL,
   TYPE_                VARCHAR(64)          NULL,
   AUTHED_              VARCHAR(64)          NULL,
   INTERFACE_URL_       VARCHAR(200)         NULL,
   TOKEN                VARCHAR(64)          NULL,
   JS_DOMAIN_           VARCHAR(200)         NULL,
   NAME_                VARCHAR(64)          NULL,
   ALIAS_               VARCHAR(64)          NULL,
   DESCRIPTION_         VARCHAR(200)         NULL,
   MENU_CONFIG_         TEXT                 NULL,
   OTHER_CONFIG_        TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_PUB_APP PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号管理',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信号',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'WX_NO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'APP_ID_',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'APP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '密钥',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'SECRET_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否认证',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'AUTHED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '接口消息地址',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'INTERFACE_URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'token',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'TOKEN'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'js安全域名',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'JS_DOMAIN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '别名',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'ALIAS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '描述',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'DESCRIPTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '菜单配置',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'MENU_CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '其他配置',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'OTHER_CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_PUB_APP', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: WX_SUBSCRIBE_                                         */
/*==============================================================*/
CREATE TABLE WX_SUBSCRIBE_ (
   ID_                  VARCHAR(64)          NOT NULL,
   PUB_ID_              VARCHAR(64)          NULL,
   SUBSCRIBE_           VARCHAR(64)          NULL,
   OPEN_ID_             VARCHAR(64)          NULL,
   NICK_NAME_           VARCHAR(64)          NULL,
   LANGUAGE_            VARCHAR(64)          NULL,
   CITY_                VARCHAR(64)          NULL,
   PROVINCE_            VARCHAR(64)          NULL,
   COUNTRY_             VARCHAR(64)          NULL,
   UNIONID_             VARCHAR(64)          NULL,
   SUBSCRIBE_TIME_      DATETIME             NULL,
   REMARK_              VARCHAR(200)         NULL,
   GROUPID_             VARCHAR(64)          NULL,
   TAGID_LIST_          VARCHAR(512)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_SUBSCRIBE_ PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信关注者',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号ID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'PUB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'SUBSCRIBE',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'SUBSCRIBE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'OPENID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'OPEN_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '昵称',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'NICK_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '语言',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'LANGUAGE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '城市',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'CITY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '省份',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'PROVINCE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '国家',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'COUNTRY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '绑定ID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'UNIONID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '最后的关注时间',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'SUBSCRIBE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '粉丝备注',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'REMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户分组ID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'GROUPID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标签ID列表',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'TAGID_LIST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_SUBSCRIBE_', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: WX_TAG_USER                                           */
/*==============================================================*/
CREATE TABLE WX_TAG_USER (
   ID_                  VARCHAR(64)          NOT NULL,
   PUB_ID_              VARCHAR(64)          NULL,
   TAG_ID_              VARCHAR(64)          NULL,
   USER_ID_             VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_TAG_USER PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信用户标签',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号Id',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'PUB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标签名',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'TAG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_TAG_USER', 'column', 'CREATE_BY_'
go

/*==============================================================*/
/* Table: WX_TICKET                                             */
/*==============================================================*/
CREATE TABLE WX_TICKET (
   ID_                  VARCHAR(64)          NOT NULL,
   PUB_ID_              VARCHAR(64)          NULL,
   CARD_TYPE_           VARCHAR(64)          NULL,
   LOGO_URL_            VARCHAR(128)         NULL,
   CODE_TYPE_           VARCHAR(16)          NULL,
   BRAND_NAME_          VARCHAR(36)          NULL,
   TITLE_               VARCHAR(27)          NULL,
   COLOR_               VARCHAR(16)          NULL,
   NOTICE_              VARCHAR(64)          NULL,
   DESCRIPTION_         VARCHAR(3072)        NULL,
   SKU_                 TEXT                 NULL,
   DATE_INFO            TEXT                 NULL,
   BASE_INFO_           TEXT                 NULL,
   ADVANCED_INFO_       TEXT                 NULL,
   SPECIAL_CONFIG_      TEXT                 NULL,
   CHECKED_             VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_TICKET PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信卡卷',
   'user', @CURRENTUSER, 'table', 'WX_TICKET'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'ID_',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号ID',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'PUB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '卡券类型',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'CARD_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '卡券的商户logo',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'LOGO_URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '码型',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'CODE_TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '商户名字',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'BRAND_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '卡券名',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '券颜色',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'COLOR_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '卡券使用提醒',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'NOTICE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '卡券使用说明',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'DESCRIPTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '商品信息',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'SKU_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '使用日期',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'DATE_INFO'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '基础非必须信息',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'BASE_INFO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '高级非必填信息',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'ADVANCED_INFO_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '专用配置',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'SPECIAL_CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '审核是否通过',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'CHECKED_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_TICKET', 'column', 'UPDATE_BY_'
go

/*==============================================================*/
/* Table: WX_WEB_GRANT                                          */
/*==============================================================*/
CREATE TABLE WX_WEB_GRANT (
   ID_                  VARCHAR(64)          NOT NULL,
   PUB_ID_              VARCHAR(64)          NULL,
   URL_                 VARCHAR(300)         NULL,
   TRANSFORM_URL_       VARCHAR(300)         NULL,
   CONFIG_              TEXT                 NULL,
   CREATE_TIME_         DATETIME             NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   CONSTRAINT PK_WX_WEB_GRANT PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '微信网页授权',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '公众号ID',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'PUB_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '链接',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '转换后的URL',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'TRANSFORM_URL_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '配置信息',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'CONFIG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构ID',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'UPDATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'WX_WEB_GRANT', 'column', 'UPDATE_BY_'
go

/*==============================================================*/
/* Table: W_TOPCONTACTS                                         */
/*==============================================================*/
CREATE TABLE W_TOPCONTACTS (
   ID_                  VARCHAR(64)          NOT NULL,
   REF_ID_              VARCHAR(64)          NULL,
   F_LXRFL              VARCHAR(50)          NULL,
   F_LXRFL_NAME         VARCHAR(50)          NULL,
   F_LXR                VARCHAR(50)          NULL,
   F_LXR_NAME           VARCHAR(50)          NULL,
   INST_ID_             VARCHAR(64)          NULL,
   INST_STATUS_         VARCHAR(20)          NULL,
   CREATE_USER_ID_      CHAR(10)             NULL,
   CREATE_GROUP_ID_     CHAR(10)             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_W_TOPCONTACTS PRIMARY KEY NONCLUSTERED (ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '常用联系人',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '外键',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'REF_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人分类ID',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'F_LXRFL'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人分类',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'F_LXRFL_NAME'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人ID',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'F_LXR'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '联系人',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'F_LXR_NAME'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '状态',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'INST_STATUS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户ID',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'CREATE_USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组ID',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'CREATE_GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '机构ID',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'W_TOPCONTACTS', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_DUTY                                               */
/*==============================================================*/
CREATE TABLE HR_DUTY (
   DUTY_ID_             VARCHAR(64)          NOT NULL,
   DUTY_NAME_           VARCHAR(50)          NOT NULL,
   SYSTEM_ID_           VARCHAR(64)          NULL,
   START_TIME_          DATETIME             NOT NULL,
   END_TIME_            DATETIME             NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   USER_ID_             TEXT                 NULL,
   GROUP_ID_            TEXT                 NULL,
   USER_NAME_           TEXT                 NULL,
   GROUP_NAME_          TEXT                 NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_DUTY PRIMARY KEY NONCLUSTERED (DUTY_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班',
   'user', @CURRENTUSER, 'table', 'HR_DUTY'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'DUTY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '排班名称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'DUTY_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制编号',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'SYSTEM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '使用者ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '使用者名字',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'USER_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组名字',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'GROUP_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_DUTY_REGISTER                                      */
/*==============================================================*/
CREATE TABLE HR_DUTY_REGISTER (
   REGISTER_ID_         VARCHAR(64)          NOT NULL,
   REGISTER_TIME_       DATETIME             NOT NULL,
   REG_FLAG_            SMALLINT             NOT NULL,
   REG_MINS_            INT                  NOT NULL,
   REASON_              VARCHAR(128)         NULL,
   DAYOFWEEK_           INT                  NOT NULL,
   IN_OFF_FLAG_         VARCHAR(8)           NOT NULL,
   USER_NAME_           VARCHAR(64)          NULL,
   SYSTEM_ID_           VARCHAR(64)          NULL,
   SECTION_ID_          VARCHAR(64)          NULL,
   LONGITUDE_           NUMERIC(11,3)        NULL,
   LATITUDE_            NUMERIC(11,3)        NULL,
   ADDRESSES_           VARCHAR(64)          NULL,
   SIGNREMARK_          VARCHAR(300)         NULL,
   DISTANCE_            INT                  NULL,
   DATE_                DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_DUTY_REGISTER PRIMARY KEY NONCLUSTERED (REGISTER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '考勤登记记录',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '登记ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'REGISTER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '登记时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'REGISTER_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '登记标识
   1=正常登记（上班，下班）
   2＝迟到
   3=早退
   4＝休息
   5＝旷工
   6=放假
   
   ',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'REG_FLAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '迟到或早退分钟
   正常上班时为0',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'REG_MINS_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '迟到原因',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'REASON_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '周几
   1=星期日
   ..
   7=日期六',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'DAYOFWEEK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上下班标识
   1=签到
   2=签退',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'IN_OFF_FLAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户名',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'USER_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'SYSTEM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'SECTION_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '经度',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'LONGITUDE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '维度',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'LATITUDE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '地址详情',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'ADDRESSES_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签到备注',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'SIGNREMARK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签到增加距离',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'DISTANCE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_REGISTER', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_DUTY_SECTION                                       */
/*==============================================================*/
CREATE TABLE HR_DUTY_SECTION (
   SECTION_ID_          VARCHAR(64)          NOT NULL,
   SECTION_NAME_        VARCHAR(16)          NOT NULL,
   SECTION_SHORT_NAME_  VARCHAR(4)           NOT NULL,
   START_SIGN_IN_       INT                  NULL,
   DUTY_START_TIME_     VARCHAR(20)          NULL,
   END_SIGN_IN_         INT                  NULL,
   EARLY_OFF_TIME_      INT                  NULL,
   DUTY_END_TIME_       VARCHAR(20)          NULL,
   SIGN_OUT_TIME_       INT                  NULL,
   IS_TWO_DAY_          VARCHAR(8)           NULL,
   GROUP_LIST_          TEXT                 NULL,
   IS_GROUP_            VARCHAR(8)           NOT NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_DUTY_SECTION PRIMARY KEY NONCLUSTERED (SECTION_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次
   ',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次编号',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'SECTION_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次名称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'SECTION_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次简称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'SECTION_SHORT_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始签到',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'START_SIGN_IN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上班时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'DUTY_START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签到结束时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'END_SIGN_IN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '早退计时',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'EARLY_OFF_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '下班时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'DUTY_END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '签退结束',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'SIGN_OUT_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否跨日',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'IS_TWO_DAY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '组合班次列表',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'GROUP_LIST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否组合班次',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'IS_GROUP_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SECTION', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_DUTY_SYSTEM                                        */
/*==============================================================*/
CREATE TABLE HR_DUTY_SYSTEM (
   SYSTEM_ID_           VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(100)         NOT NULL,
   IS_DEFAULT           VARCHAR(8)           NOT NULL,
   TYPE_                VARCHAR(20)          NULL,
   WORK_SECTION_        VARCHAR(64)          NULL,
   WK_REST_SECTION_     VARCHAR(64)          NULL,
   REST_SECTION_        VARCHAR(100)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_DUTY_SYSTEM PRIMARY KEY NONCLUSTERED (SYSTEM_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制
   ',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制编号',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'SYSTEM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '名称',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '是否缺省
   1＝缺省
   0＝非缺省',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'IS_DEFAULT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '分类
   一周=WEEKLY
   周期性=PERIODIC',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '作息班次',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'WORK_SECTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '休息日加班班次',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'WK_REST_SECTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '休息日',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'REST_SECTION_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_DUTY_SYSTEM', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_ERRANDS_REGISTER                                   */
/*==============================================================*/
CREATE TABLE HR_ERRANDS_REGISTER (
   ER_ID_               VARCHAR(64)          NOT NULL,
   REASON_              VARCHAR(500)         NULL,
   START_TIME_          DATETIME             NOT NULL,
   END_TIME_            DATETIME             NOT NULL,
   FLAG_                SMALLINT             NULL,
   BPM_INST_ID_         VARCHAR(64)          NULL,
   TYPE_                VARCHAR(20)          NOT NULL,
   STATUS_              VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_ERRANDS_REGISTER PRIMARY KEY NONCLUSTERED (ER_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '请假、加班、外出登记',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'erID',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'ER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始日期',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束日期',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标识
   0=加班
   1=请假
   2=外出',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'FLAG_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '流程实例ID',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'BPM_INST_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '类型',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_ERRANDS_REGISTER', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_HOLIDAY                                            */
/*==============================================================*/
CREATE TABLE HR_HOLIDAY (
   HOLIDAY_ID_          VARCHAR(64)          NOT NULL,
   NAME_                VARCHAR(32)          NOT NULL,
   START_DAY_           DATETIME             NOT NULL,
   END_DAY_             DATETIME             NOT NULL,
   DESC_                VARCHAR(512)         NULL,
   SYSTEM_ID_           TEXT                 NULL,
   USER_ID_             TEXT                 NULL,
   USER_NAME_           TEXT                 NULL,
   GROUP_ID_            TEXT                 NULL,
   GROUP_NAME_          TEXT                 NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_HOLIDAY PRIMARY KEY NONCLUSTERED (HOLIDAY_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '放假记录',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '假期ID',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'HOLIDAY_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '假期名称',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '开始日期',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'START_DAY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结束日期',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'END_DAY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '假期描述',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次ID',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'SYSTEM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属用户
   若为某员工的假期，则为员工自己的id',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'USER_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户名',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'USER_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '所属用户组',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'GROUP_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '用户组名',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'GROUP_NAME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_HOLIDAY', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_OVERTIME_EXT                                       */
/*==============================================================*/
CREATE TABLE HR_OVERTIME_EXT (
   OT_ID_               VARCHAR(64)          NOT NULL,
   ER_ID_               VARCHAR(64)          NULL,
   TYPE_                VARCHAR(20)          NULL,
   TITLE_               VARCHAR(50)          NULL,
   DESC_                VARCHAR(500)         NULL,
   PAY_                 VARCHAR(20)          NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_OVERTIME_EXT PRIMARY KEY NONCLUSTERED (OT_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '加班',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '加班ID',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'OT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '加班类型',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '标题',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'TITLE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '备注',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'DESC_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '结算',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'PAY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_OVERTIME_EXT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_SECTION_CONFIG                                     */
/*==============================================================*/
CREATE TABLE HR_SECTION_CONFIG (
   CONFIG_ID_           VARCHAR(64)          NOT NULL,
   IN_START_TIME_       INT                  NULL,
   IN_END_TIME_         INT                  NULL,
   OUT_START_TIME_      INT                  NULL,
   OUT_END_TIME_        INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_SECTION_CONFIG PRIMARY KEY NONCLUSTERED (CONFIG_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '参数标号',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'CONFIG_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上班开始签到时间',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'IN_START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上班结束签到时间',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'IN_END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '下班开始签到时间',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'OUT_START_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '下班结束签到时间',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'OUT_END_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_SECTION_CONFIG', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_SYSTEM_SECTION                                     */
/*==============================================================*/
CREATE TABLE HR_SYSTEM_SECTION (
   SYSTEM_SECTION_ID_   VARCHAR(64)          NOT NULL,
   SECTION_ID_          VARCHAR(64)          NULL,
   SYSTEM_ID_           VARCHAR(64)          NULL,
   WORKDAY_             INT                  NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_SYSTEM_SECTION PRIMARY KEY NONCLUSTERED (SYSTEM_SECTION_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制班次表',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '主键',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'SYSTEM_SECTION_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班次ID',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'SECTION_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '班制ID',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'SYSTEM_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_SYSTEM_SECTION', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_TRANS_REST_EXT                                     */
/*==============================================================*/
CREATE TABLE HR_TRANS_REST_EXT (
   TR_ID_               VARCHAR(64)          NOT NULL,
   ER_ID_               VARCHAR(64)          NULL,
   TYPE_                VARCHAR(20)          NULL,
   WORK_                DATETIME             NULL,
   REST_                DATETIME             NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_TRANS_REST_EXT PRIMARY KEY NONCLUSTERED (TR_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '调休扩展表',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '调休ID',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'TR_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '调休类型',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '上班时间',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'WORK_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '休息时间',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'REST_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_TRANS_REST_EXT', 'column', 'UPDATE_TIME_'
go

/*==============================================================*/
/* Table: HR_VACATION_EXT                                       */
/*==============================================================*/
CREATE TABLE HR_VACATION_EXT (
   VAC_ID_              VARCHAR(64)          NOT NULL,
   ER_ID_               VARCHAR(64)          NULL,
   TYPE_                VARCHAR(20)          NULL,
   WORK_PLAN_           VARCHAR(500)         NULL,
   TENANT_ID_           VARCHAR(64)          NULL,
   CREATE_BY_           VARCHAR(64)          NULL,
   CREATE_TIME_         DATETIME             NULL,
   UPDATE_BY_           VARCHAR(64)          NULL,
   UPDATE_TIME_         DATETIME             NULL,
   CONSTRAINT PK_HR_VACATION_EXT PRIMARY KEY NONCLUSTERED (VAC_ID_)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '请假扩展表',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '请假扩展ID',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'VAC_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '请假类型',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'TYPE_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '工作安排',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'WORK_PLAN_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '租用机构Id',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'TENANT_ID_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建人ID',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'CREATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '创建时间',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'CREATE_TIME_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新人ID',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'UPDATE_BY_'
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   '更新时间',
   'user', @CURRENTUSER, 'table', 'HR_VACATION_EXT', 'column', 'UPDATE_TIME_'
go

ALTER TABLE BPM_AGENT_SOL
   ADD CONSTRAINT AGT_SOL_R_AGT FOREIGN KEY (AGENT_ID_)
      REFERENCES BPM_AGENT (AGENT_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_AGENT_SOL
   ADD CONSTRAINT BPM_AGENT_R_BSOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_CHECK_FILE
   ADD CONSTRAINT FK_CKFILE_R_NODE_JUMP FOREIGN KEY (JUMP_ID_)
      REFERENCES BPM_NODE_JUMP (JUMP_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_DEF
   ADD CONSTRAINT BPM_DEF_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE BPM_FV_RIGHT
   ADD CONSTRAINT BPM_FVR_R_BFV FOREIGN KEY (VIEW_ID_)
      REFERENCES BPM_FORM_VIEW (VIEW_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_INST
   ADD CONSTRAINT BPM_INST_R_DEF FOREIGN KEY (DEF_ID_)
      REFERENCES BPM_DEF (DEF_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_INST_ATTACH
   ADD CONSTRAINT FK_BPM_INST_ATT_R_BPM_INST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_INST_CP
   ADD CONSTRAINT FK_INST_CP_R_INSTCC FOREIGN KEY (CC_ID_)
      REFERENCES BPM_INST_CC (CC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_INST_CTL
   ADD CONSTRAINT FK_BPM_INST_FK_BPM_IN_BPM_INST FOREIGN KEY (BPM_INST_ID_)
      REFERENCES BPM_INST (INST_ID_)
go

ALTER TABLE BPM_INST_READ
   ADD CONSTRAINT FK_BPM_INS_RD_R_BPM_INST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_LIB
   ADD CONSTRAINT BM_LIB_R_SOLUT FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_LIB
   ADD CONSTRAINT BPM_LIB_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE BPM_LIB_CMT
   ADD CONSTRAINT BPM_LIBCMT_R_LIB FOREIGN KEY (LIB_ID_)
      REFERENCES BPM_LIB (LIB_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_NODE_SET
   ADD CONSTRAINT NODE_SET_R_BPMSOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_SOLUTION
   ADD CONSTRAINT BM_SON_R_SYS_TREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE BPM_SOL_CTL
   ADD CONSTRAINT FK_BPM_SOL_CTL_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_SOL_FM
   ADD CONSTRAINT SOL_FM_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_SOL_FV
   ADD CONSTRAINT SOL_FV_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_SOL_USER
   ADD CONSTRAINT FK_BPM_SOL_USR_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE BPM_SOL_VAR
   ADD CONSTRAINT BPM_SOL_VAR_R_BPMSOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
         ON DELETE SET NULL
go

ALTER TABLE BPM_TEST_CASE
   ADD CONSTRAINT FK_TEST_CASE_R_TESTSOL FOREIGN KEY (TEST_SOL_ID_)
      REFERENCES BPM_TEST_SOL (TEST_SOL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE CAL_CALENDAR
   ADD CONSTRAINT FK_CAL_CALE_REFERENCE_CAL_SETT FOREIGN KEY (SETTING_ID_)
      REFERENCES CAL_SETTING (SETTING_ID_)
go

ALTER TABLE CAL_GRANT
   ADD CONSTRAINT FK_CAL_GRAN_REFERENCE_CAL_SETT FOREIGN KEY (SETTING_ID_)
      REFERENCES CAL_SETTING (SETTING_ID_)
go

ALTER TABLE HR_DUTY_INST
   ADD CONSTRAINT INST_R_HOLIDAY FOREIGN KEY (HOLIDAY_ID_)
      REFERENCES HR_HOLIDAY (HOLIDAY_ID_)
go

ALTER TABLE HR_DUTY_INST_EXT
   ADD CONSTRAINT INSTEXT_R_INST FOREIGN KEY (DUTY_INST_ID_)
      REFERENCES HR_DUTY_INST (DUTY_INST_ID_)
         ON UPDATE CASCADE ON DELETE CASCADE
go

ALTER TABLE INF_DOC
   ADD CONSTRAINT FK_INF_DOC_DT_R_DF_INF_DOC_ FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_DOC_FOLDER (FOLDER_ID_)
go

ALTER TABLE INF_DOC_FILE
   ADD CONSTRAINT FK_INF_DOC__DF_F_DT_INF_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES INF_DOC (DOC_ID_)
go

ALTER TABLE INF_DOC_FILE
   ADD CONSTRAINT FK_DOC_FILE_R_SYSFILE FOREIGN KEY (FILE_ID_)
      REFERENCES SYS_FILE (FILE_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INF_DOC_RIGHT
   ADD CONSTRAINT FK_INF_DOC__DP_R_DF_INF_DOC_ FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_DOC_FOLDER (FOLDER_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INF_DOC_RIGHT
   ADD CONSTRAINT FK_INF_DOC__DP_R_DT_INF_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES INF_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INF_INBOX
   ADD CONSTRAINT FK_INF_INBOX_R_INMSG FOREIGN KEY (MSG_ID_)
      REFERENCES INF_INNER_MSG (MSG_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INF_MAIL
   ADD CONSTRAINT FK_OUT_MAIL_R_MAIL_CFG FOREIGN KEY (CONFIG_ID_)
      REFERENCES INF_MAIL_CONFIG (CONFIG_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INF_MAIL
   ADD CONSTRAINT FK_INF_MAIL_R_FOLDER FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_MAIL_FOLDER (FOLDER_ID_)
         ON DELETE SET NULL
go

ALTER TABLE INF_MAIL_BOX
   ADD CONSTRAINT FK_MAILBOX_R_INMAIL FOREIGN KEY (MAIL_ID_)
      REFERENCES INF_INNER_MAIL (MAIL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INF_MAIL_BOX
   ADD CONSTRAINT FK_MAILBOX_R_MAILFOLDER FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_MAIL_FOLDER (FOLDER_ID_)
         ON DELETE SET NULL
go

ALTER TABLE INF_MAIL_FILE
   ADD CONSTRAINT FK_MAIL_FILE_R_OUT_MAIL FOREIGN KEY (MAIL_ID_)
      REFERENCES INF_MAIL (MAIL_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INF_MAIL_FOLDER
   ADD CONSTRAINT FK_MAIL_FO_R_MAIL_CFG FOREIGN KEY (CONFIG_ID_)
      REFERENCES INF_MAIL_CONFIG (CONFIG_ID_)
         ON DELETE SET NULL
go

ALTER TABLE INS_COL_NEW
   ADD CONSTRAINT IS_CN_R_NEWS FOREIGN KEY (NEW_ID_)
      REFERENCES INS_NEWS (NEW_ID_)
         ON DELETE CASCADE
go

ALTER TABLE INS_NEWS_CM
   ADD CONSTRAINT FK_INS_NEWCM_R_INS_NEW FOREIGN KEY (NEW_ID_)
      REFERENCES INS_NEWS (NEW_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC
   ADD CONSTRAINT DOC_R_DOC_TMP FOREIGN KEY (TEMP_ID_)
      REFERENCES KD_DOC_TEMPLATE (TEMP_ID_)
         ON DELETE SET NULL
go

ALTER TABLE KD_DOC
   ADD CONSTRAINT KD_DOC_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
go

ALTER TABLE KD_DOC_CMMT
   ADD CONSTRAINT DOCMT_R_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_CONTR
   ADD CONSTRAINT DOC_CONT_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_DIR
   ADD CONSTRAINT KD_DOCDIR_R_KDDOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_FAV
   ADD CONSTRAINT DOC_FAV_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_FAV
   ADD CONSTRAINT KD_DOC_FAV_R_QUE FOREIGN KEY (QUE_ID_)
      REFERENCES KD_QUESTION (QUE_ID_)
go

ALTER TABLE KD_DOC_HANDLE
   ADD CONSTRAINT FK_KD_DOC_H_REFERENCE_OD_DOCUM FOREIGN KEY (DOC_ID_)
      REFERENCES OD_DOCUMENT (DOC_ID_)
go

ALTER TABLE KD_DOC_HIS
   ADD CONSTRAINT DOCVER_R_KDDOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_READ
   ADD CONSTRAINT DOC_RD_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_REM
   ADD CONSTRAINT DOC_REM_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_RIGHT
   ADD CONSTRAINT DOC_RHT_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_ROUND
   ADD CONSTRAINT DOC_ROUND_R_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE KD_DOC_TEMPLATE
   ADD CONSTRAINT DOC_TMPL_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE KD_QUESTION
   ADD CONSTRAINT QUES_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE KD_QUES_ANSWER
   ADD CONSTRAINT QUE_AW_R_QUES FOREIGN KEY (QUE_ID_)
      REFERENCES KD_QUESTION (QUE_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_ADDR_CONT
   ADD CONSTRAINT FK_ADD_CNT_R_ADD_BK FOREIGN KEY (ADDR_ID_)
      REFERENCES OA_ADDR_BOOK (ADDR_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_ADDR_GPB
   ADD CONSTRAINT FK_ADD_GPB_R_ADD_GRP FOREIGN KEY (GROUP_ID_)
      REFERENCES OA_ADDR_GRP (GROUP_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_ADDR_GPB
   ADD CONSTRAINT FK_ADD_GPB_R_ADD_BK FOREIGN KEY (ADDR_ID_)
      REFERENCES OA_ADDR_BOOK (ADDR_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_ASSETS
   ADD CONSTRAINT FK_OA_ASSET_ASSERTS_R_OA_PRODU FOREIGN KEY (PROD_DEF_ID_)
      REFERENCES OA_PRODUCT_DEF (PROD_DEF_ID_)
go

ALTER TABLE OA_ASSETS_BID
   ADD CONSTRAINT ASSETS_BID_R_ASSETS FOREIGN KEY (ASS_ID_)
      REFERENCES OA_ASSETS (ASS_ID_)
go

ALTER TABLE OA_ASS_PARAMETER
   ADD CONSTRAINT ASSPARA_R_PK FOREIGN KEY (KEY_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_KEY (KEY_ID_)
go

ALTER TABLE OA_ASS_PARAMETER
   ADD CONSTRAINT ASSPARA_R_PV FOREIGN KEY (VALUE_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_VALUE (VALUE_ID_)
go

ALTER TABLE OA_ASS_PARAMETER
   ADD CONSTRAINT ASS_PARA_R_ASS FOREIGN KEY (ASS_ID_)
      REFERENCES OA_ASSETS (ASS_ID_)
go

ALTER TABLE OA_CAR_APP
   ADD CONSTRAINT CAR_APP_R_CAR FOREIGN KEY (CAR_ID_)
      REFERENCES OA_CAR (CAR_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_COM_RIGHT
   ADD CONSTRAINT COM_RT_R_COM_BK FOREIGN KEY (COMBOOK_ID_)
      REFERENCES OA_COM_BOOK (COM_ID_)
go

ALTER TABLE OA_MEETING
   ADD CONSTRAINT OA_MET_R_ROOM FOREIGN KEY (ROOM_ID_)
      REFERENCES OA_MEET_ROOM (ROOM_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OA_MEET_ATT
   ADD CONSTRAINT MEET_ATT_R_MEET FOREIGN KEY (MEET_ID_)
      REFERENCES OA_MEETING (MEET_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_PLAN_TASK
   ADD CONSTRAINT PLAN_R_PROJ FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OA_PLAN_TASK
   ADD CONSTRAINT PLAN_R_REQ_MGR FOREIGN KEY (REQ_ID_)
      REFERENCES OA_REQ_MGR (REQ_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OA_PRODUCT_DEF
   ADD CONSTRAINT PRODUCTDEF_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
go

ALTER TABLE OA_PRODUCT_DEF_PARA
   ADD CONSTRAINT PRODDEFPPARA_R_PRODDEF FOREIGN KEY (PROD_DEF_ID_)
      REFERENCES OA_PRODUCT_DEF (PROD_DEF_ID_)
go

ALTER TABLE OA_PRODUCT_DEF_PARA
   ADD CONSTRAINT PRODUCTDEFPARA_R_PK FOREIGN KEY (KEY_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_KEY (KEY_ID_)
go

ALTER TABLE OA_PRODUCT_DEF_PARA
   ADD CONSTRAINT PRODUCTDEFPARA_R_PV FOREIGN KEY (VALUE_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_VALUE (VALUE_ID_)
go

ALTER TABLE OA_PRODUCT_DEF_PARA_KEY
   ADD CONSTRAINT PRODUCTDEF_PK_R_ST FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
go

ALTER TABLE OA_PRODUCT_DEF_PARA_VALUE
   ADD CONSTRAINT FK_OA_PRODU_PRODUCTDE_OA_PRODU FOREIGN KEY (KEY_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_KEY (KEY_ID_)
go

ALTER TABLE OA_PRODUCT_DEF_PARA_VALUE
   ADD CONSTRAINT PRODUCTDEF_PV_R_ST FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
go

ALTER TABLE OA_PROJECT
   ADD CONSTRAINT PROJ_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OA_PRO_ATTEND
   ADD CONSTRAINT PRO_ATT_R_PROJ FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_PRO_VERS
   ADD CONSTRAINT PRO_VER_R_PROJECT FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OA_REQ_MGR
   ADD CONSTRAINT REQ_MGR_R_PROJECT FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OA_WORK_LOG
   ADD CONSTRAINT WORKLOG_R_PLANTASK FOREIGN KEY (PLAN_ID_)
      REFERENCES OA_PLAN_TASK (PLAN_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OD_DOCUMENT
   ADD CONSTRAINT FK_OD_DOC_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OD_DOC_REC
   ADD CONSTRAINT FK_DOC_REC_R_ODDOC FOREIGN KEY (DOC_ID_)
      REFERENCES OD_DOCUMENT (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OD_DOC_REMIND_
   ADD CONSTRAINT FK_DOC_RM_R_ODDOC FOREIGN KEY (DOC_ID_)
      REFERENCES OD_DOCUMENT (DOC_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OD_DOC_TEMPLATE
   ADD CONSTRAINT FK_DOC_TMP_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE OS_GROUP
   ADD CONSTRAINT FK_GP_R_DMN FOREIGN KEY (DIM_ID_)
      REFERENCES OS_DIMENSION (DIM_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OS_GROUP_MENU
   ADD CONSTRAINT FK_OS_GROUP_FK_GRP_MN_OS_GROUP FOREIGN KEY (GROUP_ID_)
      REFERENCES OS_GROUP (GROUP_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OS_GROUP_MENU
   ADD CONSTRAINT FK_GRP_MN_R_SYS_MENU FOREIGN KEY (MENU_ID_)
      REFERENCES SYS_MENU (MENU_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OS_GROUP_SYS
   ADD CONSTRAINT FK_GRP_SYS_R_GRP FOREIGN KEY (GROUP_ID_)
      REFERENCES OS_GROUP (GROUP_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OS_RANK_TYPE
   ADD CONSTRAINT FK_ORK_TYPE_R_OSDIM FOREIGN KEY (DIM_ID_)
      REFERENCES OS_DIMENSION (DIM_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OS_REL_INST
   ADD CONSTRAINT FK_OS_REL_I_OS_RIST_R_OS_REL_T FOREIGN KEY (REL_TYPE_ID_)
      REFERENCES OS_REL_TYPE (ID_)
go

ALTER TABLE OS_REL_TYPE
   ADD CONSTRAINT FK_OS_REL_T_REL_PAR1__OS_DIMEN FOREIGN KEY (DIM_ID1_)
      REFERENCES OS_DIMENSION (DIM_ID_)
         ON DELETE CASCADE
go

ALTER TABLE OS_REL_TYPE
   ADD CONSTRAINT FK_OS_REL_T_REFERENCE_OS_DIMEN FOREIGN KEY (DIM_ID2_)
      REFERENCES OS_DIMENSION (DIM_ID_)
go

ALTER TABLE SYS_BO_LIST
   ADD CONSTRAINT FK_SYS_BO_L_SYS_BO_LI_SYS_LIST FOREIGN KEY (SOL_ID_)
      REFERENCES SYS_LIST_SOL (SOL_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_BUTTON
   ADD CONSTRAINT SYS_BTN_R_SYS_MOD FOREIGN KEY (MODULE_ID_)
      REFERENCES SYS_MODULE (MODULE_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_DIC
   ADD CONSTRAINT GL_TP_R_DIC FOREIGN KEY (TYPE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_FIELD
   ADD CONSTRAINT FK_SYS_FIEL_SYS_FIELD_SYS_MODU FOREIGN KEY (MODULE_ID_)
      REFERENCES SYS_MODULE (MODULE_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_FILE
   ADD CONSTRAINT SYS_FILE_TREE FOREIGN KEY (TYPE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_FORM_FIELD
   ADD CONSTRAINT FORM_FD_R_FORM_GP FOREIGN KEY (GROUP_ID_)
      REFERENCES SYS_FORM_GROUP (GROUP_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_FORM_FIELD
   ADD CONSTRAINT ORM_FD_R_FIELD FOREIGN KEY (FIELD_ID_)
      REFERENCES SYS_FIELD (FIELD_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_FORM_GROUP
   ADD CONSTRAINT FORM_GP_R_FORM_SMA FOREIGN KEY (FORM_SCHEMA_ID_)
      REFERENCES SYS_FORM_SCHEMA (FORM_SCHEMA_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_FORM_SCHEMA
   ADD CONSTRAINT FORM_SM_R_SYS_MOD FOREIGN KEY (MODULE_ID_)
      REFERENCES SYS_MODULE (MODULE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_GRID_FIELD
   ADD CONSTRAINT SGF_R_SFD FOREIGN KEY (FIELD_ID_)
      REFERENCES SYS_FIELD (FIELD_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_GRID_FIELD
   ADD CONSTRAINT SGF_R_SGV FOREIGN KEY (GRID_VIEW_ID_)
      REFERENCES SYS_GRID_VIEW (GRID_VIEW_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_GRID_VIEW
   ADD CONSTRAINT GV_R_SM FOREIGN KEY (MODULE_ID_)
      REFERENCES SYS_MODULE (MODULE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_LDAP_CN
   ADD CONSTRAINT FK_SYS_LDAP_LDAP_CN_R_SYS_LDAP FOREIGN KEY (SYS_LDAP_OU_ID_)
      REFERENCES SYS_LDAP_OU (SYS_LDAP_OU_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_LDAP_CN
   ADD CONSTRAINT FK_SYS_LDAP_SYS_LDAP__OS_USER FOREIGN KEY (USER_ID_)
      REFERENCES OS_USER (USER_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_LDAP_OU
   ADD CONSTRAINT LADP_OU_R_OS_GROUP FOREIGN KEY (GROUP_ID_)
      REFERENCES OS_GROUP (GROUP_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_MENU
   ADD CONSTRAINT SYS_MENU_R_SUBS FOREIGN KEY (SYS_ID_)
      REFERENCES SYS_SUBSYS (SYS_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_MODULE
   ADD CONSTRAINT SYS_R_MODULE FOREIGN KEY (SYS_ID_)
      REFERENCES SYS_SUBSYS (SYS_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_REPORT
   ADD CONSTRAINT REP_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE SYS_SEARCH_ITEM
   ADD CONSTRAINT SEARCH_ITM_R_SF FOREIGN KEY (FIELD_ID_)
      REFERENCES SYS_FIELD (FIELD_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_SEARCH_ITEM
   ADD CONSTRAINT SFIELD_R_SEARCH FOREIGN KEY (SEARCH_ID_)
      REFERENCES SYS_SEARCH (SEARCH_ID_)
         ON DELETE CASCADE
go

ALTER TABLE SYS_TEMPLATE
   ADD CONSTRAINT SYS_TMP_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_)
         ON DELETE SET NULL
go

ALTER TABLE HR_DUTY
   ADD CONSTRAINT DUY_R_DS FOREIGN KEY (SYSTEM_ID_)
      REFERENCES HR_DUTY_SYSTEM (SYSTEM_ID_)
go

ALTER TABLE HR_OVERTIME_EXT
   ADD CONSTRAINT OTEXT_R_ERRREG FOREIGN KEY (ER_ID_)
      REFERENCES HR_ERRANDS_REGISTER (ER_ID_)
go

ALTER TABLE HR_SYSTEM_SECTION
   ADD CONSTRAINT SYSSEC_R_SEC FOREIGN KEY (SECTION_ID_)
      REFERENCES HR_DUTY_SECTION (SECTION_ID_)
go

ALTER TABLE HR_SYSTEM_SECTION
   ADD CONSTRAINT SYSSEC_R_SYS FOREIGN KEY (SYSTEM_ID_)
      REFERENCES HR_DUTY_SYSTEM (SYSTEM_ID_)
go

ALTER TABLE HR_TRANS_REST_EXT
   ADD CONSTRAINT TSEXT_R_ERRREG FOREIGN KEY (ER_ID_)
      REFERENCES HR_ERRANDS_REGISTER (ER_ID_)
go

ALTER TABLE HR_VACATION_EXT
   ADD CONSTRAINT VAC_R_ERRREG FOREIGN KEY (ER_ID_)
      REFERENCES HR_ERRANDS_REGISTER (ER_ID_)
go



