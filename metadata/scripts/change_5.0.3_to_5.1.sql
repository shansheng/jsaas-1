alter table SYS_QUARTZ_LOG add status_ varchar(64);

alter table SYS_QUARTZ_JOB add status_ varchar(64);

/*==============================================================*/
/* Table: BPM_INST_TMP                                          */
/*==============================================================*/
CREATE TABLE BPM_INST_TMP
(
   TMP_ID_              VARCHAR(64) NOT NULL COMMENT '临时ID',
   BUS_KEY_             VARCHAR(64),
   INST_ID_             VARCHAR(64) NOT NULL COMMENT '流程实例ID',
   FORM_JSON_           TEXT NOT NULL COMMENT '流程JSON',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (TMP_ID_)
);

ALTER TABLE BPM_INST_TMP COMMENT '流程实例启动临时表';


/*==============================================================*/
/* Table: SYS_LDAP_LOG                                          */
/*==============================================================*/
CREATE TABLE SYS_LDAP_LOG
(
   LOG_ID_              VARCHAR(64) NOT NULL COMMENT '日志主键',
   LOG_NAME_            VARCHAR(256) COMMENT '日志名称',
   CONTENT_             TEXT COMMENT '日志内容',
   START_TIME_          TIMESTAMP COMMENT '开始时间',
   END_TIME_            TIMESTAMP COMMENT '结束时间',
   RUN_TIME_            INT COMMENT '持续时间',
   STATUS_              VARCHAR(64) COMMENT '状态',
   SYNC_TYPE_           VARCHAR(64) COMMENT '同步类型',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (LOG_ID_)
);

ALTER TABLE SYS_LDAP_LOG COMMENT 'SYS_LDAP_LOG【LDAP同步日志】';


/*==============================================================*/
/* Table: SYS_LDAP_CONFIG                                       */
/*==============================================================*/
CREATE TABLE SYS_LDAP_CONFIG
(
   SYS_LDAP_CONFIG_ID_  VARCHAR(64) NOT NULL COMMENT 'LDAP配置(主键)',
   STATUS_              VARCHAR(64) COMMENT '状态',
   STATUS_CN_           VARCHAR(64) COMMENT '状态',
   DN_BASE_             VARCHAR(1024) COMMENT '基本DN',
   DN_DATUM_            VARCHAR(1024) COMMENT '基准DN',
   URL_                 VARCHAR(1024) COMMENT '地址',
   ACCOUNT_             VARCHAR(64) COMMENT '账号名称',
   PASSWORD_            VARCHAR(64) COMMENT '密码',
   DEPT_FILTER_         VARCHAR(1024) COMMENT '部门过滤器',
   USER_FILTER_         VARCHAR(1024) COMMENT '用户过滤器',
   ATT_USER_NO_         VARCHAR(64) COMMENT '用户编号属性',
   ATT_USER_ACC_        VARCHAR(64) COMMENT '用户账户属性',
   ATT_USER_NAME_       VARCHAR(64) COMMENT '用户名称属性',
   ATT_USER_PWD_        VARCHAR(1024) COMMENT '用户密码属性',
   ATT_USER_TEL_        VARCHAR(64) COMMENT '用户电话属性',
   ATT_USER_MAIL_       VARCHAR(64) COMMENT '用户邮件属性',
   ATT_DEPT_NAME_       VARCHAR(64) COMMENT '部门名称属性',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (SYS_LDAP_CONFIG_ID_)
);



/*==============================================================*/
/* Table: SYS_LDAP_OU                                           */
/*==============================================================*/
CREATE TABLE SYS_LDAP_OU
(
   SYS_LDAP_OU_ID_      VARCHAR(64) NOT NULL COMMENT '组织单元（主键）',
   SN_                  INT COMMENT '序号',
   DEPTH_               INT COMMENT '层次',
   PATH_                VARCHAR(1024) COMMENT '路径',
   PARENT_ID_           VARCHAR(64) COMMENT '父目录',
   STATUS_              VARCHAR(64) COMMENT '状态',
   OU_                  VARCHAR(512) COMMENT '组织单元',
   NAME_                VARCHAR(512) COMMENT '组织单元名称',
   DN_                  VARCHAR(512) COMMENT '区分名',
   OC_                  VARCHAR(512) COMMENT '对象类型',
   USN_CREATED_         VARCHAR(64) COMMENT 'USN_CREATED',
   USN_CHANGED_         VARCHAR(64) COMMENT 'USN_CHANGED',
   WHEN_CREATED_        VARCHAR(64) COMMENT 'LDAP创建时间',
   WHEN_CHANGED_        VARCHAR(64) COMMENT 'LDAP更新时间',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (SYS_LDAP_OU_ID_)
);

ALTER TABLE SYS_LDAP_OU COMMENT 'SYS_LDAP_OU【LDAP组织单元】';

ALTER TABLE SYS_LDAP_OU ADD CONSTRAINT LADP_OU_R_OS_GROUP FOREIGN KEY ()
      REFERENCES OS_GROUP ON DELETE SET NULL ON UPDATE RESTRICT;

    
/*==============================================================*/
/* Table: SYS_LDAP_CN                                           */
/*==============================================================*/
CREATE TABLE SYS_LDAP_CN
(
   SYS_LDAP_USER_ID_    VARCHAR(64) NOT NULL COMMENT 'LDAP用户（主键）',
   SYS_LDAP_OU_ID_      VARCHAR(64) COMMENT '组织单元（主键）',
   USER_ACCOUNT_        VARCHAR(64) COMMENT '账户',
   USER_CODE_           VARCHAR(64) COMMENT '用户编号',
   NAME_                VARCHAR(64) COMMENT '名称',
   TEL_                 VARCHAR(64) COMMENT '电话',
   MAIL_                VARCHAR(512) COMMENT '邮件',
   USN_CREATED_         VARCHAR(64) COMMENT 'USN_CREATED',
   USN_CHANGED_         VARCHAR(64) COMMENT 'USN_CHANGED',
   WHEN_CREATED_        VARCHAR(64) COMMENT 'LDAP创建时间',
   WHEN_CHANGED_        VARCHAR(64) COMMENT 'LDAP更新时间',
   STATUS_              VARCHAR(64) COMMENT '状态',
   USER_PRINCIPAL_NAME_ VARCHAR(512) COMMENT '用户主要名称',
   DN_                  VARCHAR(512) COMMENT '区分名',
   OC_                  VARCHAR(512) COMMENT '对象类型',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (SYS_LDAP_USER_ID_)
);

ALTER TABLE SYS_LDAP_CN COMMENT 'SYS_LDAP_CN【LADP用户】';

ALTER TABLE SYS_LDAP_CN ADD CONSTRAINT LADP_CN_R_OS_USER FOREIGN KEY ()
      REFERENCES OS_USER ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE SYS_LDAP_CN ADD CONSTRAINT LDAP_CN_R_LDAP_OU FOREIGN KEY (SYS_LDAP_OU_ID_)
      REFERENCES SYS_LDAP_OU (SYS_LDAP_OU_ID_) ON DELETE RESTRICT ON UPDATE RESTRICT;
      
      
      
      
alter table BPM_SOL_FV add PRINT_URI_ varchar2(255) null;
alter table BPM_SOL_FV add PRINT_NAME_ varchar2(255) null;

alter table BPM_INST add CHECK_FILE_ID_ varchar2(255) null;

alter table bpm_node_set add NODE_CHECK_TIP_ varchar2(1024) null;

alter table SYS_TREE add CHILDS_ integer null;

alter table sys_tree add BIND_SOL_ID_ varchar(64);



/*==============================================================*/
/* Table: BPM_OPINION_LIB                                       */
/*==============================================================*/
CREATE TABLE BPM_OPINION_LIB
(
   OP_ID_               VARCHAR(64) NOT NULL,
   USER_ID_             VARCHAR(64) NOT NULL COMMENT '用户ID，为0代表公共的',
   OP_TEXT_             VARCHAR(512) NOT NULL COMMENT '审批意见',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (OP_ID_)
);

ALTER TABLE BPM_OPINION_LIB COMMENT '意见收藏表';


/*==============================================================*/
/* Table: BPM_INST_CTL                                          */
/*==============================================================*/
CREATE TABLE BPM_INST_CTL
(
   CTL_ID               VARCHAR(64) NOT NULL,
   BPM_INST_ID_         VARCHAR(64),
   INST_ID_             VARCHAR(64) COMMENT '流程实例ID',
   TYPE_                VARCHAR(50) COMMENT 'READ=阅读权限
            FILE=附件权限',
   RIGHT_               VARCHAR(60) COMMENT 'ALL=全部权限
            EDIT=编辑
            DEL=删除
            PRINT=打印
            DOWN=下载',
   ALLOW_ATTEND_        VARCHAR(20),
   ALLOW_STARTOR_       VARCHAR(20) COMMENT '允许发起人
            YES',
   GROUP_IDS_           TEXT COMMENT '用户组Ids（多个用户组Id用“，”分割）',
   USER_IDS_            TEXT NOT NULL COMMENT '用户Ids（多个用户Id用“，”分割）',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   PRIMARY KEY (CTL_ID)
);

ALTER TABLE BPM_INST_CTL COMMENT '流程附件权限';

ALTER TABLE BPM_INST_CTL ADD CONSTRAINT FK_FK_BPM_INSTCL_R_BPM_INST FOREIGN KEY (BPM_INST_ID_)
      REFERENCES BPM_INST (INST_ID_) ON DELETE RESTRICT ON UPDATE RESTRICT;
      
      
/*==============================================================*/
/* Table: BPM_INST_ATTACH                                       */
/*==============================================================*/
CREATE TABLE BPM_INST_ATTACH
(
   ID_                  VARCHAR(64) NOT NULL,
   INST_ID_             VARCHAR(64) NOT NULL COMMENT '实例Id',
   FILE_ID_             VARCHAR(64) NOT NULL COMMENT '文件ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_INST_ATTACH COMMENT '流程实例附件';

ALTER TABLE BPM_INST_ATTACH ADD CONSTRAINT FK_BPM_INST_ATT_R_BPM_INST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

/*==============================================================*/
/* Table: BPM_INST_READ                                         */
/*==============================================================*/
CREATE TABLE BPM_INST_READ
(
   READ_ID_             VARCHAR(64) NOT NULL,
   INST_ID_             VARCHAR(64) COMMENT '实例ID',
   USER_ID_             VARCHAR(64) COMMENT '用户ID',
   STATE_               VARCHAR(50) COMMENT '流程阶段',
   DEP_ID_              VARCHAR(64) COMMENT '部门ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (READ_ID_)
);

ALTER TABLE BPM_INST_READ COMMENT '流程实例阅读';

ALTER TABLE BPM_INST_READ ADD CONSTRAINT FK_BPM_INS_RD_R_BPM_INST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

      
      
      /*==============================================================*/
/* Table: BPM_SOL_CTL                                           */
/*==============================================================*/
CREATE TABLE BPM_SOL_CTL
(
   RIGHT_ID_            VARCHAR(64) NOT NULL,
   SOL_ID_              VARCHAR(64) COMMENT '解决方案ID',
   USER_IDS_            TEXT NOT NULL COMMENT '用户Ids（多个用户Id用“，”分割）',
   GROUP_IDS_           TEXT COMMENT '用户组Ids（多个用户组Id用“，”分割）',
   ALLOW_STARTOR_       VARCHAR(20) COMMENT '允许发起人
            YES',
   ALLOW_ATTEND_        VARCHAR(20),
   RIGHT_               VARCHAR(60) COMMENT 'ALL=全部权限
            EDIT=编辑
            DEL=删除
            PRINT=打印
            DOWN=下载',
   TYPE_                VARCHAR(50) COMMENT 'READ=阅读权限
            FILE=附件权限',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         TIMESTAMP COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (RIGHT_ID_)
);

ALTER TABLE BPM_SOL_CTL COMMENT '流程解决方案资源访问权限控制';

ALTER TABLE BPM_SOL_CTL ADD CONSTRAINT FK_BPM_SOL_CTL_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

-----------------add by csx 2016-11-26-------------------------------------      
alter table ACT_RU_TASK  add CM_TASK_ID_ VARCHAR(64);
alter table ACT_RU_TASK  add RC_TASK_ID_ VARCHAR(64);  
alter table ACT_RU_TASK add CM_LEVEL_ INTEGER;
      

