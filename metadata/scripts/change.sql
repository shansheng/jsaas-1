alter table sys_file add from_ varchar(20);

alter table sys_file add  THUMBNAIL_ VARCHAR(120) COMMENT '图片缩略图';

alter table sys_inst add domain_ varchar(100) not null default 'unkown.com';

alter table sys_inst add BUS_LICE_NO_ varchar(50);

alter table sys_inst add bus_lice_file_id_ varchar(64) ;

alter table sys_inst add reg_code_file_id_ varchar(64) ;

alter table sys_menu add img_ varchar(50) null;

alter table sys_file add NEW_FNAME_ varchar(50) null;

alter table sys_inst add email_ varchar(255);


alter table sys_tree add is_child_ varchar(20)  default 'NO' comment '是否为子结点';

alter table sys_tree add data_show_type_ varchar(20)  default 'FLaT' comment '数据项展示类型';

---add by 2015-09-29
DROP TABLE IF EXISTS BPM_SOL_DATA;

/*==============================================================*/
/* Table: BPM_SOL_DATA_                                         */
/*==============================================================*/
CREATE TABLE BPM_SOL_DATA
(
   ID_                  VARCHAR(64) NOT NULL,
   SOL_ID_              VARCHAR(64) COMMENT '流程解决方案ID',
   EVENT_NAME_          VARCHAR(100) COMMENT '事件名称',
   EVENT_KEY_           VARCHAR(255) NOT NULL COMMENT '事件KEY',
   NODE_NAME_           VARCHAR(255) COMMENT '节点名称',
   NODE_ID_             VARCHAR(255) NOT NULL COMMENT '节点ID',
   EXE_DESCP_           VARCHAR(512) COMMENT '执行描述',
   EXE_CONFIG_          LONGTEXT COMMENT '执行配置',
   ENABLED_             VARCHAR(20) NOT NULL COMMENT '是否启用',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_SOL_DATA COMMENT '流程解决方案中的数据交互配置';

ALTER TABLE BPM_SOL_DATA ADD CONSTRAINT FK_SOL_DATA_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;
      
      
  DROP TABLE IF EXISTS BPM_INST;

/*==============================================================*/
/* Table: BPM_INST                                              */
/*==============================================================*/
CREATE TABLE BPM_INST
(
   INST_ID_             VARCHAR(64) NOT NULL,
   DEF_ID_              VARCHAR(64) NOT NULL COMMENT '流程定义ID',
   ACT_INST_ID_         VARCHAR(64) NOT NULL COMMENT 'Activiti实例ID',
   ACT_DEF_ID_          VARCHAR(64) NOT NULL COMMENT 'Activiti定义ID',
   SOL_ID_              VARCHAR(64) COMMENT '解决方案ID',
   SUBJECT_             VARCHAR(255) COMMENT '标题',
   STATUS_              VARCHAR(20) COMMENT '运行状态',
   VERSION_             INT COMMENT '版本',
   BUS_KEY_             VARCHAR(64) NOT NULL COMMENT '业务键ID',
   IS_TEST_             VARCHAR(20) COMMENT '是否为测试',
   END_TIME_            DATETIME COMMENT '结束时间',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (INST_ID_)
);

ALTER TABLE BPM_INST COMMENT '流程实例';


DROP TABLE IF EXISTS BPM_FORM_INST;

/*==============================================================*/
/* Table: BPM_FORM_INST                                         */
/*==============================================================*/
CREATE TABLE BPM_FORM_INST
(
   FORM_INST_ID_        VARCHAR(64) NOT NULL,
   SUBJECT_             VARCHAR(127) NOT NULL COMMENT '实例标题',
   INST_ID_             VARCHAR(64) NOT NULL COMMENT '流程实例ID',
   ACT_INST_ID_         VARCHAR(64) NOT NULL COMMENT 'ACT实例ID',
   ACT_DEF_ID_          VARCHAR(64) NOT NULL COMMENT 'ACT定义ID',
   DEF_ID_              VARCHAR(64) NOT NULL COMMENT '流程定义ID',
   SOL_ID_              VARCHAR(64) COMMENT '解决方案ID',
   FM_ID_               VARCHAR(64) COMMENT '数据模型ID',
   FM_VIEW_ID_          VARCHAR(64) COMMENT '表单视图ID',
   STATUS_              VARCHAR(20) NOT NULL COMMENT '状态',
   JSON_DATA_           LONGTEXT COMMENT '数据JSON',
   IS_PERSIST_          VARCHAR(20) COMMENT '是否持久化',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (FORM_INST_ID_)
);

ALTER TABLE BPM_FORM_INST COMMENT '流程数据模型实例';

alter table bpm_solution add SFORM_URI_ varchar(255) comment '开始表单地址';
alter table bpm_solution add SFORM_TYPE_ varchar(30) comment '开始表单类型';

alter table sys_menu add is_btn_menu_ varchar(20) not null default 'NO';


/*===========================build========================================*/

DROP TABLE IF EXISTS BPM_NODE_JUMP;

/*==============================================================*/
/* Table: BPM_NODE_JUMP                                         */
/*==============================================================*/
CREATE TABLE BPM_NODE_JUMP
(
   JUMP_ID_             VARCHAR(20) NOT NULL,
   INST_ID_             VARCHAR(64) NOT NULL COMMENT '流程实例ID',
   ACT_DEF_ID_          VARCHAR(64) COMMENT 'ACT流程定义ID',
   DEF_ID_              VARCHAR(64) COMMENT '流程定义ID',
   ACT_INST_ID_         VARCHAR(64) COMMENT 'ACT流程实例ID',
   NODE_NAME_           VARCHAR(255) COMMENT '节点名称',
   NODE_ID_             VARCHAR(255) NOT NULL COMMENT '节点Key',
   TASK_ID_             VARCHAR(64) COMMENT '任务ID',
   COMPLETE_TIME_       DATETIME COMMENT '完成时间',
   DURATION_            INT COMMENT '持续时长',
   DURATION_VAL_        INT COMMENT '有效审批时长',
   HANDLER_ID_          VARCHAR(64) COMMENT '处理人ID',
   CHECK_STATUS_        VARCHAR(50) COMMENT '审批状态',
   JUMP_TYPE_           VARCHAR(50) COMMENT '跳转类型',
   REMARK_              VARCHAR(512) COMMENT '意见备注',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (JUMP_ID_)
);

ALTER TABLE BPM_NODE_JUMP COMMENT '流程流转记录';

ALTER TABLE BPM_NODE_JUMP ADD CONSTRAINT FK_NODE_JUMP_R_BPM_INST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

DROP TABLE IF EXISTS BPM_NODE_SET;

/*==============================================================*/
/* Table: BPM_NODE_SET                                          */
/*==============================================================*/
CREATE TABLE BPM_NODE_SET
(
   SET_ID_              VARCHAR(128) NOT NULL,
   SOL_ID_              VARCHAR(64) NOT NULL COMMENT '解决方案ID',
   NODE_ID_             VARCHAR(255) NOT NULL COMMENT '节点ID',
   NAME_                VARCHAR(255) NOT NULL COMMENT '节点名称',
   DESCP_               VARCHAR(255) NOT NULL COMMENT '节点描述',
   NODE_TYPE_           VARCHAR(100) NOT NULL COMMENT '节点类型',
   SETTINGS_            TEXT COMMENT '节点设置',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (SET_ID_)
);

ALTER TABLE BPM_NODE_SET COMMENT '流程定义节点配置';

ALTER TABLE BPM_NODE_SET ADD CONSTRAINT FK_NODE_SET_R_BPMSOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

      
   --------------     add by zwj  2015-12-11   ----------------------

DROP TABLE IF EXISTS INF_MAIL_CONFIG;

/*==============================================================*/
/* Table: INF_MAIL_CONFIG                                       */
/*==============================================================*/
CREATE TABLE INF_MAIL_CONFIG
(
   CONFIG_ID_           VARCHAR(64) NOT NULL COMMENT '配置ID',
   USER_ID_             VARCHAR(64) NOT NULL COMMENT '用户ID',
   USER_NAME_           VARCHAR(128) COMMENT '用户名称',
   ACCOUNT_             VARCHAR(128) COMMENT '帐号名称',
   MAIL_ACCOUNT_        VARCHAR(128) NOT NULL COMMENT '外部邮件地址',
   MAIL_PWD_            VARCHAR(128) NOT NULL COMMENT '外部邮件密码',
   PROTOCOL_            VARCHAR(32) NOT NULL COMMENT '协议类型
            IMAP
            POP3',
   SSL_                 VARCHAR(12) COMMENT '启用SSL
            true or false',
   SMTP_HOST_           VARCHAR(128) NOT NULL COMMENT '邮件发送主机',
   SMTP_PORT_           VARCHAR(64) NOT NULL COMMENT '邮件发送端口',
   RECP_HOST_           VARCHAR(128) NOT NULL COMMENT '接收主机',
   RECP_PORT_           VARCHAR(64) NOT NULL COMMENT '接收端口',
   IS_DEFAULT_          VARCHAR(20) NOT NULL COMMENT '是否默认
            YES
            NO',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (CONFIG_ID_)
);

ALTER TABLE INF_MAIL_CONFIG COMMENT '外部邮箱设置';


DROP TABLE IF EXISTS INF_MAIL_FOLDER;

/*==============================================================*/
/* Table: INF_MAIL_FOLDER                                       */
/*==============================================================*/
CREATE TABLE INF_MAIL_FOLDER
(
   FOLDER_ID_           VARCHAR(64) NOT NULL COMMENT '文件夹编号',
   CONFIG_ID_           VARCHAR(64) COMMENT '配置ID',
   USER_ID_             VARCHAR(64) NOT NULL COMMENT '主键',
   NAME_                VARCHAR(128) NOT NULL COMMENT '文件夹名称',
   PARENT_ID_           VARCHAR(64) COMMENT '父目录',
   DEPTH_               INT NOT NULL COMMENT '目录层',
   PATH_                VARCHAR(256) COMMENT '目录路径',
   TYPE_                VARCHAR(32) NOT NULL COMMENT '文件夹类型
            RECEIVE-FOLDER=收信箱
            SENDER-FOLDEr=发信箱
            DRAFT-FOLDER=草稿箱
            DEL-FOLDER=删除箱
            OTHER-FOLDER=其他',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   PRIMARY KEY (FOLDER_ID_)
);

ALTER TABLE INF_MAIL_FOLDER COMMENT '邮件文件夹';

ALTER TABLE INF_MAIL_FOLDER ADD CONSTRAINT FK_MAIL_FO_R_MAIL_CFG FOREIGN KEY (CONFIG_ID_)
      REFERENCES INF_MAIL_CONFIG (CONFIG_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

      
DROP TABLE IF EXISTS INF_MAIL;

/*==============================================================*/
/* Table: INF_MAIL                                              */
/*==============================================================*/
CREATE TABLE INF_MAIL
(
   MAIL_ID_             VARCHAR(64) NOT NULL,
   UID_                 VARCHAR(512) COMMENT '外部邮箱标识ID',
   USER_ID_             VARCHAR(64) NOT NULL COMMENT '用户ID',
   CONFIG_ID_           VARCHAR(64) NOT NULL COMMENT '邮箱设置ID',
   FOLDER_ID_           VARCHAR(64) COMMENT '文件夹ID',
   SUBJECT_             VARCHAR(512) NOT NULL COMMENT '主题',
   CONTENT_             LONGTEXT COMMENT '内容',
   SENDER_ADDRS_        TEXT NOT NULL COMMENT '发件人地址',
   SENDER_ALIAS_        TEXT COMMENT '发件人地址别名',
   REC_ADDRS_           TEXT NOT NULL COMMENT '收件人地址',
   REC_ALIAS_           TEXT COMMENT '收件人地址别名',
   CC_ADDRS_            TEXT COMMENT '抄送人地址',
   CC_ALIAS_            TEXT COMMENT '抄送人地址别名',
   BCC_ADDRS_           TEXT COMMENT '暗送人地址',
   BCC_ALIAS_           TEXT COMMENT '暗送人地址别名',
   SEND_DATE_           DATETIME NOT NULL COMMENT '发送日期',
   READ_FLAG_           VARCHAR(8) NOT NULL DEFAULT '0' COMMENT '0:未阅
            1:已阅',
   REPLY_FLAG_          VARCHAR(8) NOT NULL DEFAULT '0' COMMENT '0:未回复
            1;已回复',
   STATUS_              VARCHAR(20) COMMENT '状态
            COMMON 正常
            DELETED 删除',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (MAIL_ID_)
);

ALTER TABLE INF_MAIL COMMENT '外部邮件';

ALTER TABLE INF_MAIL ADD CONSTRAINT FK_OUT_MAIL_R_MAIL_CFG FOREIGN KEY (CONFIG_ID_)
      REFERENCES INF_MAIL_CONFIG (CONFIG_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE INF_MAIL ADD CONSTRAINT FK_INF_MAIL_R_FOLDER FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_MAIL_FOLDER (FOLDER_ID_) ON DELETE SET NULL ON UPDATE RESTRICT;


      
DROP TABLE IF EXISTS INF_MAIL_FILE;

/*==============================================================*/
/* Table: INF_MAIL_FILE                                         */
/*==============================================================*/
CREATE TABLE INF_MAIL_FILE
(
   FILE_ID_             VARCHAR(64) NOT NULL,
   MAIL_ID_             VARCHAR(64) NOT NULL,
   PRIMARY KEY (FILE_ID_, MAIL_ID_)
);

ALTER TABLE INF_MAIL_FILE COMMENT '外部邮箱附件';

ALTER TABLE INF_MAIL_FILE ADD CONSTRAINT FK_MAIL_FILE_R_SYSFILE FOREIGN KEY (FILE_ID_)
      REFERENCES SYS_FILE (FILE_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE INF_MAIL_FILE ADD CONSTRAINT FK_MAIL_FILE_R_OUT_MAIL FOREIGN KEY (MAIL_ID_)
      REFERENCES INF_MAIL (MAIL_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;
      
       
      
      -------------add by '陈茂昌'----2015-12-3-------------------------
CREATE TABLE inf_doc (
	DOC_ID_ VARCHAR(64) NOT NULL COMMENT '文档ID',
	FOLDER_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '文件夹ID',
	NAME_ VARCHAR(100) NOT NULL COMMENT '文档名称',
	CONTENT_ LONGTEXT NULL COMMENT '内容',
	SUMMARY_ VARCHAR(512) NULL DEFAULT NULL COMMENT '摘要',
	HAS_ATTACH_ VARCHAR(8) NULL DEFAULT NULL COMMENT '是否包括附件',
	IS_SHARE_ VARCHAR(8) NOT NULL COMMENT '是否共享',
	AUTHOR_ VARCHAR(64) NULL DEFAULT NULL COMMENT '作者',
	KEYWORDS_ VARCHAR(256) NULL DEFAULT NULL COMMENT '关键字',
	DOC_TYPE_ VARCHAR(64) NULL DEFAULT NULL COMMENT '文档类型',
	SWF_PATH_ VARCHAR(256) NULL DEFAULT NULL COMMENT 'SWF文件f路径',
	USER_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '用户ID',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构ID',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (DOC_ID_),
	INDEX FK_DT_R_DF (FOLDER_ID_),
	CONSTRAINT FK_DT_R_DF FOREIGN KEY (FOLDER_ID_) REFERENCES inf_doc_folder (FOLDER_ID_)
)
COMMENT='文档'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;




CREATE TABLE inf_doc_folder (
	FOLDER_ID_ VARCHAR(64) NOT NULL,
	NAME_ VARCHAR(128) NOT NULL COMMENT '目录名称',
	PARENT_ VARCHAR(64) NULL DEFAULT NULL COMMENT '父目录',
	PATH_ VARCHAR(128) NULL DEFAULT NULL COMMENT '路径',
	DEPTH_ INT(11) NOT NULL COMMENT '层次',
	SHARE_ VARCHAR(8) NOT NULL COMMENT '共享',
	DESCP VARCHAR(256) NULL DEFAULT NULL COMMENT '文档描述',
	USER_ID_ VARCHAR(64) NOT NULL COMMENT '用户ID',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构ID',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	SN_ INT(11) NULL DEFAULT NULL COMMENT '序号',
	TYPE_ VARCHAR(20) NULL DEFAULT NULL COMMENT '文档目录类型',
	PRIMARY KEY (FOLDER_ID_)
)
COMMENT='文档文件夹'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



CREATE TABLE inf_doc_right (
	RIGHT_ID_ VARCHAR(64) NOT NULL COMMENT '权限ID',
	DOC_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '文档ID',
	FOLDER_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '文件夹ID',
	RIGHTS_ INT(11) NOT NULL COMMENT '权限',
	USER_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '用户ID',
	GROUP_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '用户组ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构ID',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (RIGHT_ID_),
	INDEX FK_DP_R_DF (FOLDER_ID_),
	INDEX FK_DP_R_DT (DOC_ID_),
	CONSTRAINT FK_DP_R_DF FOREIGN KEY (FOLDER_ID_) REFERENCES inf_doc_folder (FOLDER_ID_) ON DELETE CASCADE,
	CONSTRAINT FK_DP_R_DT FOREIGN KEY (DOC_ID_) REFERENCES inf_doc (DOC_ID_) ON DELETE CASCADE
)
COMMENT='文档或目录的权限'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



CREATE TABLE inf_doc_file (
	DOC_ID_ VARCHAR(64) NOT NULL,
	FILE_ID_ VARCHAR(64) NOT NULL,
	PRIMARY KEY (DOC_ID_, FILE_ID_),
	INDEX FK_DOC_FILE_R_SYSFILE (FILE_ID_),
	CONSTRAINT FK_DF_F_DT FOREIGN KEY (DOC_ID_) REFERENCES inf_doc (DOC_ID_),
	CONSTRAINT FK_DOC_FILE_R_SYSFILE FOREIGN KEY (FILE_ID_) REFERENCES sys_file (FILE_ID_) ON DELETE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;





-----------------------------------add by 陈茂昌 2016.01.07 pro模块-------------------------------------------------------

CREATE TABLE oa_project (
	PROJECT_ID_ VARCHAR(64) NOT NULL COMMENT '项目ID',
	TREE_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '分类Id',
	PRO_NO_ VARCHAR(50) NOT NULL COMMENT '编号',
	TAG_ VARCHAR(50) NULL DEFAULT NULL COMMENT '标签名称',
	NAME_ VARCHAR(100) NOT NULL COMMENT '名称',
	DESCP_ TEXT NULL COMMENT '描述',
	REPOR_ID_ VARCHAR(64) NOT NULL COMMENT '负责人',
	COSTS_ DECIMAL(16,4) NULL DEFAULT NULL COMMENT '预计费用',
	START_TIME_ DATETIME NULL DEFAULT NULL COMMENT '启动时间',
	END_TIME_ DATETIME NULL DEFAULT NULL COMMENT '结束时间',
	STATUS_ VARCHAR(20) NULL DEFAULT NULL COMMENT '状态',
	VERSION_ VARCHAR(20) NULL DEFAULT NULL COMMENT '当前版本',
	TYPE_ VARCHAR(20) NULL DEFAULT NULL COMMENT '类型',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构Id',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (PROJECT_ID_),
	INDEX FK_PROJ_R_SYSTREE (TREE_ID_),
	CONSTRAINT FK_PROJ_R_SYSTREE FOREIGN KEY (TREE_ID_) REFERENCES sys_tree (TREE_ID_) ON DELETE SET NULL
)
COMMENT='项目或产品'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



CREATE TABLE oa_pro_vers (
	VERSION_ID_ VARCHAR(64) NOT NULL,
	PROJECT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '项目或产品ID',
	START_TIME_ DATETIME NULL DEFAULT NULL COMMENT '开始时间',
	END_TIME_ DATETIME NULL DEFAULT NULL COMMENT '结束时间',
	STATUS_ VARCHAR(20) NULL DEFAULT NULL COMMENT '状态',
	DESCP_ TEXT NULL COMMENT '描述',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构Id',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	VERSION_ VARCHAR(50) NOT NULL,
	PRIMARY KEY (VERSION_ID_),
	INDEX FK_PRO_VER_R_PROJECT (PROJECT_ID_),
	CONSTRAINT FK_PRO_VER_R_PROJECT FOREIGN KEY (PROJECT_ID_) REFERENCES oa_project (PROJECT_ID_) ON DELETE CASCADE
)
COMMENT='项目或产品版本'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;


CREATE TABLE oa_pro_attend (
	ATT_ID_ VARCHAR(64) NOT NULL COMMENT '参与人ID',
	PROJECT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '项目ID',
	USER_ID_ VARCHAR(64) NOT NULL COMMENT '参与人ID',
	GROUP_ID_ VARCHAR(64) NOT NULL COMMENT '参与组ID',
	PART_TYPE_ VARCHAR(20) NOT NULL COMMENT '参与类型\\r\\n            Participate\\r\\n            \\r\\n                  JOIN=参与\\r\\n                  RESPONSE=负责\\r\\n                  APPROVE=审批\\r\\n                  PAY_ATT=关注',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL,
	groupnames VARCHAR(255) NULL DEFAULT NULL,
	usernames VARCHAR(255) NULL DEFAULT NULL,
	PRIMARY KEY (ATT_ID_),
	INDEX FK_PRO_ATT_R_PROJ (PROJECT_ID_),
	CONSTRAINT FK_PRO_ATT_R_PROJ FOREIGN KEY (PROJECT_ID_) REFERENCES oa_project (PROJECT_ID_) ON DELETE CASCADE
)
COMMENT='项目或产品参与人、负责人、关注人'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;


CREATE TABLE oa_req_mgr (
	REQ_ID_ VARCHAR(64) NOT NULL COMMENT '需求ID',
	PROJECT_ID_ VARCHAR(64) NOT NULL COMMENT '项目或产品Id',
	REQ_CODE_ VARCHAR(50) NOT NULL COMMENT '需求编码',
	SUBJECT_ VARCHAR(128) NOT NULL COMMENT '标题',
	DESCP_ TEXT NULL COMMENT '描述',
	PARENT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '父需求ID',
	STATUS_ VARCHAR(50) NULL DEFAULT NULL COMMENT '状态',
	LEVEL_ INT(11) NULL DEFAULT NULL COMMENT '层次',
	CHECKER_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '审批人',
	REP_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '负责人',
	EXE_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '执行人',
	VERSION_ VARCHAR(20) NOT NULL COMMENT '版本号',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构Id',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (REQ_ID_),
	INDEX FK_REFERENCE_53 (PROJECT_ID_),
	CONSTRAINT FK_REFERENCE_53 FOREIGN KEY (PROJECT_ID_) REFERENCES oa_project (PROJECT_ID_)
)
COMMENT='产品或项目需求'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



CREATE TABLE oa_plan (
	PLAN_ID_ VARCHAR(64) NOT NULL COMMENT '计划ID',
	PROJECT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '项目或产品ID',
	REQ_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '需求ID',
	SUBJECT_ VARCHAR(128) NOT NULL COMMENT '计划标题',
	CONTENT_ TEXT NULL COMMENT '计划内容',
	PSTART_TIME_ DATETIME NOT NULL COMMENT '计划开始时间',
	PEND_TIME_ DATETIME NULL DEFAULT NULL COMMENT '计划结束时间',
	START_TIME_ DATETIME NULL DEFAULT NULL COMMENT '实际开始时间',
	END_TIME_ DATETIME NULL DEFAULT NULL COMMENT '实际结束时间',
	STATUS_ VARCHAR(20) NULL DEFAULT NULL COMMENT '状态',
	ASSIGN_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '分配人',
	OWNER_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '所属人',
	EXE_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '执行人',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构Id',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (PLAN_ID_),
	INDEX FK_PLAN_R_PROJ (PROJECT_ID_),
	INDEX FK_PLAN_R_REQ_MGR (REQ_ID_),
	CONSTRAINT FK_PLAN_R_PROJ FOREIGN KEY (PROJECT_ID_) REFERENCES oa_project (PROJECT_ID_) ON DELETE SET NULL,
	CONSTRAINT FK_PLAN_R_REQ_MGR FOREIGN KEY (REQ_ID_) REFERENCES oa_req_mgr (REQ_ID_) ON DELETE SET NULL
)
COMMENT='工作计划'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



CREATE TABLE oa_task (
	TASK_ID_ VARCHAR(32) NOT NULL,
	PLAN_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '计划ID',
	CONTENT_ VARCHAR(1024) NOT NULL COMMENT '任务内容',
	START_TIME_ DATETIME NOT NULL COMMENT '开始时间',
	END_TIME_ DATETIME NOT NULL COMMENT '结束时间',
	STATUS_ VARCHAR(32) NULL DEFAULT NULL COMMENT '状态',
	LAST_ INT(11) NULL DEFAULT NULL COMMENT '耗时(分）',
	CHECKER_ VARCHAR(64) NULL DEFAULT NULL COMMENT '审核人',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL,
	PRIMARY KEY (TASK_ID_),
	INDEX FK_TASK_R_PLAN (PLAN_ID_),
	CONSTRAINT FK_TASK_R_PLAN FOREIGN KEY (PLAN_ID_) REFERENCES oa_plan (PLAN_ID_) ON DELETE SET NULL
)
COMMENT='工作任务'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



CREATE TABLE oa_work_att (
	ATT_ID_ VARCHAR(64) NOT NULL COMMENT '主键',
	USER_ID_ VARCHAR(64) NOT NULL COMMENT '关注人ID',
	ATT_TIME_ DATETIME NULL DEFAULT NULL COMMENT '关注时间',
	NOTICE_TYPE_ VARCHAR(50) NOT NULL COMMENT '通知方式',
	TYPE_ VARCHAR(50) NOT NULL COMMENT '关注类型',
	TYPE_PK_ VARCHAR(64) NOT NULL COMMENT '类型主键ID',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构Id',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (ATT_ID_)
)
COMMENT='工作动态关注'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



CREATE TABLE oa_work_mat (
	ACTION_ID_ VARCHAR(64) NOT NULL COMMENT '主键',
	CONTENT_ VARCHAR(512) NOT NULL COMMENT '评论内容',
	TYPE_ VARCHAR(50) NOT NULL COMMENT '类型',
	TYPE_PK_ VARCHAR(64) NOT NULL COMMENT '类型主键ID',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租用机构Id',
	CREATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '创建人ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_BY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '更新人ID',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (ACTION_ID_)
)
COMMENT='工作动态'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;



alter table bpm_form_view add is_bind_md_ varchar(20) default 'NO' comment '是否绑定模型';
alter table bpm_form_view add template_key_ varchar(50) default 'NO' comment '模板类型Key';

DROP TABLE IF EXISTS SYS_TEMPLATE;

/*==============================================================*/
/* Table: SYS_TEMPLATE                                          */
/*==============================================================*/
CREATE TABLE SYS_TEMPLATE
(
   TEMP_ID_             VARCHAR(64) NOT NULL COMMENT '模板ID',
   TREE_ID_             VARCHAR(64) COMMENT '分类Id',
   NAME_                VARCHAR(80) NOT NULL COMMENT '模板名称',
   KEY_                 VARCHAR(50) NOT NULL COMMENT '模板KEY',
   IS_DEFAULT_          VARCHAR(20) NOT NULL COMMENT '是否系统缺省',
   CONTENT_             TEXT NOT NULL COMMENT '模板内容',
   DESCP                VARCHAR(500) COMMENT '模板描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租用用户Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (TEMP_ID_)
);

ALTER TABLE SYS_TEMPLATE COMMENT '系统模板';

ALTER TABLE SYS_TEMPLATE ADD CONSTRAINT FK_SYS_TMP_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE (TREE_ID_) ON DELETE SET NULL ON UPDATE RESTRICT;
      
      
  alter table bpm_form_view add TEMPLATE_ID_ varchar(64) default  comment '模板类型ID';
  
  LTER TABLE BPM_FORM_VIEW ADD CONSTRAINT FK_FORMVIEW_R_SYS_TEMP FOREIGN KEY (TEMPLATE_ID_)
  REFERENCES SYS_TEMPLATE (TEMP_ID_) ON DELETE SET NULL ON UPDATE RESTRICT;

  
  
  alter table inf_doc add doc_path_ varchar(255) null comment '文档路径';
  
  
  -- add by csx-----------2016-03-08
  
  alter table sys_tree drop column childs_;
  
  alter table sys_tree add column code_ varchar(32);
  
  alter table sys_tree add column descp_ varchar(512);
  
  alter table sys_subsys add icon_cls_ varchar(50);
  
    -- add by cjx-----------2016-05-27
    
    alter table bpm_form_model add column IS_GEN_TB_ varchar(20) comment '是否生成物理表';
  
    alter table bpm_form_model add column DATA_FROM_ varchar(20) comment '数据来源';
  
    alter table bpm_fm_att add column REF_FM_ID_ varchar(64) comment '复合类型所属模型ID';
    
    -- add by cjx-----------2016-06-02
    
    alter table BPM_SQL_NODE add column JSON_DATA_ LONGTEXT COMMENT '数据JSON';
  	alter table BPM_SQL_NODE add column JSON_TABLE_ LONGTEXT COMMENT '表数据的JSON';
    alter table BPM_SQL_NODE add column SQL_TYPE_  SMALLINT COMMENT 'SQL类型';
  
	--add by csx 2016-06-05----------------
	ALTER table bpm_solution add column grant_type_  smallint not null default 0;
	alter table bpm_solution add tree_path_ varchar(1024);
	update bpm_solution s inner join sys_tree t on s.tree_id_=t.tree_id_ set s.tree_path_=t.PATH_;
	
	
	
	---------add by csx 2016-06-29-------------------------------------
	alter table ins_col_type add load_type_ varchar(20) default 'URL';
	alter table ins_col_type add temp_id_ varchar(64) ;
	alter table ins_col_type add temp_name_ varchar(200);
	alter table ins_col_type add icon_cls_ varchar(50) ;
	alter table INF_DOC_RIGHT add identity_id_ varchar(64);

	alter table INF_DOC_RIGHT add identity_type_ varchar(64);
	--------------------------------------------------------------------
	
	
	
	-------------add by csx 2016-09-10 --------------
	
	alter table os_rel_inst add REL_TYPE_ varchar(40);

	UPDATE os_rel_inst,os_rel_type
	SET os_rel_inst.REL_TYPE_=os_rel_type.REL_TYPE_
	WHERE os_rel_inst.REL_TYPE_ID_=os_rel_type.ID_;
	
	
	
	
	--------------add by cmc 2016-0912------------------
	ALTER TABLE mobile_token
	ADD ACCOUNT_ VARCHAR(64);
	

/*==============================================================*/
/* Table: BPM_INST_CC                                           */
/*==============================================================*/
CREATE TABLE BPM_INST_CC
(
   CC_ID_               VARCHAR(64) NOT NULL,
   INST_ID_             VARCHAR(64) NOT NULL COMMENT '实例Id',
   SUBJECT_             VARCHAR(255) NOT NULL COMMENT '抄送标题',
   NODE_ID_             VARCHAR(255) COMMENT '节点ID',
   NODE_NAME_           VARCHAR(255) COMMENT '节点名称',
   FROM_USER_ID_        VARCHAR(255) COMMENT '抄送人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (CC_ID_)
);

ALTER TABLE BPM_INST_CC COMMENT '流程抄送';

ALTER TABLE BPM_INST_CC ADD CONSTRAINT FK_INST_CC_R_BPMINST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;

	
	
	/*==============================================================*/
/* Table: BPM_INST_CP                                           */
/*==============================================================*/
CREATE TABLE BPM_INST_CP
(
   ID_                  VARCHAR(64) NOT NULL,
   USER_ID_             VARCHAR(64) COMMENT '用户ID',
   GROUP_ID_            VARCHAR(64) COMMENT '用户组Id',
   CC_ID_               VARCHAR(64) COMMENT '抄送ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_INST_CP COMMENT '流程抄送人员';

ALTER TABLE BPM_INST_CP ADD CONSTRAINT FK_INST_CP_R_INSTCC FOREIGN KEY (CC_ID_)
      REFERENCES BPM_INST_CC (CC_ID_) ON DELETE CASCADE ON UPDATE RESTRICT;


    -- add by cjx-----------2016-10-10
    
    alter table TASK_NODE_MSG add column TASK_ID_ varchar(64) comment '任务Id';
  
    alter table TASK_TIP_MSG add column TASK_ID_ varchar(20) comment '任务Id';
    
    
    
-- add by zyg 2016-11-30 表单配置增加手机表单配置。
ALTER TABLE bpm_sol_fv
ADD COLUMN MOBILE_ALIAS_  varchar(40) NULL COMMENT '手机别名' AFTER UPDATE_TIME_,
ADD COLUMN MOBILE_NAME_  varchar(40) NULL COMMENT '手机表单名称' AFTER MOBILE_ALIAS_;


-- add by zyg 2016-11-30 增加手机表单配置。
CREATE TABLE BPM_MOBILE_FORM (
ID_  varchar(50) NULL COMMENT '主键' ,
VIEW_ID_  varchar(50) NULL COMMENT '关联表单ID' ,
NAME_  varchar(50) NULL COMMENT '手机表单名称' ,
ALIAS_  varchar(30) NULL COMMENT '手机表单名称' ,
FORM_HTML  longtext NULL COMMENT '手机表单对应的模版' ,
TENANT_ID_  varchar(50) NULL COMMENT '租户ID' ,
TREE_ID_  varchar(50) NULL COMMENT '分类ID' ,
CREATE_BY_  varchar(50) NULL COMMENT ' 创建人' ,
CREATE_TIME_  datetime NULL COMMENT '创建时间' ,
UPDATE_BY_  varchar(50) NULL COMMENT '更新人' ,
UPDATE_TIME_  datetime NULL COMMENT '更新时间' ,
PRIMARY KEY (ID_)
)
COMMENT='手机表单配置表'
;

alter table ACT_RU_TASK add ENABLE_MOBILE_ INT null comment '是否支持手机表单' ;


ALTER TABLE bpm_node_jump
ADD COLUMN ENABLE_MOBILE_  int NULL COMMENT '是否允许手机' ;

-- add by zyg 2016-12-8 增加表单模版。
CREATE TABLE bpm_form_template (
  ID_ varchar(50) NOT NULL DEFAULT '' COMMENT '主键',
  NAME_ varchar(50) DEFAULT NULL COMMENT '模版名称',
  ALIAS_ varchar(50) DEFAULT NULL COMMENT '别名',
  TEMPLATE_ text COMMENT '模版',
  TYPE_ varchar(50) DEFAULT NULL COMMENT '模版类型 (pc,mobile)',
  INIT_ int(11) DEFAULT NULL COMMENT '初始添加的(1是,0否)',
  TENANT_ID_ varchar(50) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(50) DEFAULT NULL,
  CREATE_TIME_ datetime DEFAULT NULL,
  UPDATE_BY_ varchar(50) DEFAULT NULL,
  UPDATE_TIME_ datetime DEFAULT NULL,
  CATEGORY_ varchar(40) DEFAULT NULL COMMENT '类别',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单模版';

-- add by zyg 2016-12-8 增加两个字段处理抄送。
ALTER TABLE bpm_sol_user
ADD COLUMN CATEGORY_  varchar(50) NULL AFTER SN_,
ADD COLUMN GROUP_ID_  varchar(50) NULL AFTER CATEGORY_;

-- add by zyg 2016-12-8 增加表处理抄送情况。
CREATE TABLE BPM_SOL_USERGROUP
(
   ID_                  VARCHAR(50) NOT NULL COMMENT '主键',
   GROUP_NAME_          VARCHAR(50) COMMENT '名称',
   SOL_ID_              VARCHAR(50) COMMENT '方案ID',
   GROUP_TYPE_          VARCHAR(50) COMMENT '分组类型(flow,copyto)',
   NODE_ID_             VARCHAR(50) COMMENT '节点ID',
   NODE_NAME_           VARCHAR(50) COMMENT '节点名称',
   TENANT_ID_           VARCHAR(50) COMMENT '租户ID',
   SETTING_             VARCHAR(2000) COMMENT '配置',
   SN_                  INT COMMENT '序号',
   NOTIFY_TYPE_         VARCHAR(50),
   CREATE_BY_           VARCHAR(50) COMMENT '创建人',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(50)  COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_SOL_USERGROUP COMMENT '流程配置用户组';

-- add by zyg 2016-12-18 抄送表增加抄送人。
alter table bpm_inst_cc add column FROM_USER_ varchar(50) COMMENT '抄送人';

-- add by zyg 2016-12-18 添加IS_READ_字段。
alter table bpm_inst_cp add column IS_READ_ varchar(10) COMMENT '是否已读';
-- add by zyg 2016-12-18 。
update bpm_sol_user set CATEGORY_='task';

-- add by zyg 2016-1-5 催办定义。
CREATE TABLE BPM_REMIND_DEF
(
   ID_                  VARCHAR(50) NOT NULL COMMENT '主键',
   SOL_ID_              VARCHAR(50) COMMENT '方案ID',
   NODE_ID_             VARCHAR(50) COMMENT '节点ID',
   NAME_                VARCHAR(50) COMMENT '名称',
   ACTION_              VARCHAR(50) COMMENT '到期动作',
   REL_NODE_            VARCHAR(50) COMMENT '相对节点',
   EVENT_               VARCHAR(50) COMMENT '事件',
   DATE_TYPE_           VARCHAR(50) COMMENT '日期类型',
   EXPIRE_DATE_         VARCHAR(50) COMMENT '期限',
   CONDITION_           VARCHAR(1000) COMMENT '条件',
   SCRIPT_              VARCHAR(1000) COMMENT '到期执行脚本',
   NOTIFY_TYPE_         VARCHAR(50) COMMENT '通知类型',
   TIME_TO_SEND_        VARCHAR(50) COMMENT '开始发送消息时间点',
   SEND_TIMES_          INTEGER COMMENT '发送次数',
   SEND_INTERVAL_       VARCHAR(50) COMMENT '发送时间间隔',
   TENANT_ID_           VARCHAR(50) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(50) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(50) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   SOLUTION_NAME_       VARCHAR(50) COMMENT '解决方案名称',
   NODE_NAME_           VARCHAR(50) COMMENT '节点名称',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_REMIND_DEF COMMENT '催办定义';

-- add by zyg 2016-1-5 催办实例表。
CREATE TABLE BPM_REMIND_INST
(
   ID_                  VARCHAR(50) NOT NULL COMMENT '主键',
   SOL_ID_              VARCHAR(50) COMMENT '方案ID',
   NODE_ID_             VARCHAR(50) COMMENT '节点ID',
   TASK_ID_             VARCHAR(50) COMMENT '任务ID',
   NAME_                VARCHAR(50) COMMENT '名称',
   ACTION_              VARCHAR(50) COMMENT '到期动作',
   EXPIRE_DATE_         DATETIME COMMENT '期限',
   SCRIPT_              VARCHAR(1000) COMMENT '到期执行脚本',
   NOTIFY_TYPE_         VARCHAR(50) COMMENT '通知类型',
   TIME_TO_SEND_        DATETIME COMMENT '开始发送消息时间点',
   SEND_TIMES_          INT COMMENT '发送次数',
   SEND_INTERVAL_       INT COMMENT '发送时间间隔',
   STATUS_              VARCHAR(10) COMMENT '状态(2,完成,0,创建,1,进行中)',
   TENANT_ID_           VARCHAR(50) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(50) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(50) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   SOLUTION_NAME_       VARCHAR(50) COMMENT '方案名称',
   NODE_NAME_           VARCHAR(50) COMMENT '节点名称',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_REMIND_INST COMMENT '催办实例表';

-- add by zyg 2016-1-5 催办历史。
CREATE TABLE BPM_REMIND_HISTORY
(
   ID_                  VARCHAR(50) NOT NULL COMMENT '主键',
   REMINDER_INST_ID_    VARCHAR(50) COMMENT '催办实例ID',
   TANENT_ID_           VARCHAR(50) COMMENT '租用ID',
   REMIND_TYPE_         VARCHAR(50) COMMENT '催办类型',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_REMIND_HISTORY COMMENT '催办历史';


drop table bpm_reminder_def;
drop table bpm_reminder_inst;
drop table bpm_reminder_log;
drop table bpm_reminder_node;
-- 创建实例索引
CREATE INDEX IDX_REMINDHI_INSTID
ON bpm_remind_history (REMINDER_INST_ID_)


--------------------------陈茂昌  工作日历20170107---------------------------------
/*==============================================================*/
/* Table: CAL_SETTING                                           */
/*==============================================================*/
CREATE TABLE CAL_SETTING
(
   SETTING_ID_          VARCHAR(64) NOT NULL COMMENT '设定ID',
   CAL_NAME_            VARCHAR(64) COMMENT '日历名称',
   IS_COMMON_             VARCHAR(64) COMMENT '默认',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构Id',
   PRIMARY KEY (SETTING_ID_)
);

ALTER TABLE CAL_SETTING COMMENT '日历设定';

/*==============================================================*/
/* Table: CAL_TIME_BLOCK                                       */
/*==============================================================*/
CREATE TABLE CAL_TIME_BLOCK
(
   SETTING_ID_          VARCHAR(64) NOT NULL COMMENT '设定ID',
   SETTING_NAME_        VARCHAR(128) COMMENT '设定名称',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构Id',
   TIME_INTERVALS_      VARCHAR(1024) COMMENT '时间段组合json组合',
   PRIMARY KEY (SETTING_ID_)
);

ALTER TABLE CAL_TIME_BLOCK COMMENT '工作时间段设定';


/*==============================================================*/
/* Table: CAL_CALENDAR                                         */
/*==============================================================*/
CREATE TABLE CAL_CALENDAR
(
   CALENDER_ID_         VARCHAR(64) NOT NULL COMMENT '日历Id',
   SETTING_ID_          VARCHAR(64) NOT NULL COMMENT '设定ID',
   START_TIME_          DATETIME COMMENT '开始时间',
   END_TIME_            DATETIME COMMENT '结束时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构Id',
   PRIMARY KEY (CALENDER_ID_)
);

ALTER TABLE CAL_CALENDAR COMMENT '工作日历安排';

ALTER TABLE CAL_CALENDAR ADD CONSTRAINT FK_REFERENCE_work_calendar FOREIGN KEY (SETTING_ID_)
      REFERENCES CAL_SETTING (SETTING_ID_) ON DELETE RESTRICT ON UPDATE RESTRICT;

      
      
      
/*==============================================================*/
/* Table: CAL_GRANT                                             */
/*==============================================================*/
CREATE TABLE CAL_GRANT
(
   GRANT_ID_            VARCHAR(64) NOT NULL COMMENT '主键',
   SETTING_ID_          VARCHAR(64) COMMENT '设定ID',
   GRANT_TYPE_          VARCHAR(64) COMMENT '分配类型 USER/GROUP',
   BELONG_WHO_          VARCHAR(64) COMMENT '被分配者   GROUPID/USERID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构Id',
   PRIMARY KEY (GRANT_ID_)
);

ALTER TABLE CAL_GRANT COMMENT '日历分配';

ALTER TABLE CAL_GRANT ADD CONSTRAINT FK_REFERENCE_cal_grant FOREIGN KEY (SETTING_ID_)
      REFERENCES CAL_SETTING (SETTING_ID_) ON DELETE RESTRICT ON UPDATE RESTRICT;
      
      



-- add by zhy 2016-1-7 抄送表加方案ID和分类ID。
alter table bpm_inst_cc add column SOL_ID_ varchar(64) COMMENT '方案ID';
alter table bpm_inst_cc add column TREE_ID_ varchar(64) COMMENT '分类ID';

------------------------add by 陈茂昌 帮张哥从pdm提上来的----------------------------------
/*==============================================================*/
/* 分管授权表。                                    */
/*==============================================================*/
CREATE TABLE BPM_AUTH_SETTING
(
   ID_                  VARCHAR(50) NOT NULL COMMENT '主键',
   NAME_                VARCHAR(50) COMMENT '授权名称',
   ENABLE_              VARCHAR(10) COMMENT '是否允许',
   TENANT_ID_           VARCHAR(50) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   CREATE_BY_           VARCHAR(50) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(50) COMMENT '更新人',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_AUTH_SETTING COMMENT '流程定义授权';




/*==============================================================*/
/* 分管授权对象表。                                      */
/*==============================================================*/
CREATE TABLE BPM_AUTH_RIGHTS
(
   ID_                  VARCHAR(50) COMMENT '主键',
   SETTING_ID_          VARCHAR(50) COMMENT '设定id',
   RIGHT_TYPE_          VARCHAR(50) COMMENT '权限类型(def,流程定义,inst,流程实例,task,待办任务,start,发起流程)',
   TYPE_                VARCHAR(50) COMMENT '授权类型(all,全部,user,用户,group,用户组)',
   AUTH_ID_             VARCHAR(50) COMMENT '授权对象ID',
   AUTH_NAME_           VARCHAR(50) COMMENT '授权对象名称'
);

ALTER TABLE BPM_AUTH_RIGHTS COMMENT '流程定义授权';




		
/*==============================================================*/
/*  分管授权流程定义表。                                         */
/*==============================================================*/
CREATE TABLE BPM_AUTH_DEF
(
   ID_                  VARCHAR(50) COMMENT '主键',
   SETTING_ID_          VARCHAR(50) COMMENT '设定ID',
   SOL_ID_              VARCHAR(50) COMMENT '解决方案ID',
   RIGHT_JSON_          VARCHAR(500) COMMENT '权限JSON'
);

ALTER TABLE BPM_AUTH_DEF COMMENT '授权流程定义';

-- zyg 2017-1-22号 删除授权表 
drop table bpm_sol_right ;

-- ZYG 2017-2-10 增加数据源定义。
CREATE TABLE SYS_DATASOURCE_DEF
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   NAME_                VARCHAR(64) COMMENT '数据源名称',
   ALIAS_               VARCHAR(64) COMMENT '别名',
   ENABLE_              VARCHAR(10) COMMENT '是否使用',
   SETTING_             VARCHAR(2000) COMMENT '数据源设定',
   DB_TYPE_             VARCHAR(10) COMMENT '数据库类型',
   INIT_ON_START_       VARCHAR(10) COMMENT '启动时初始化',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_DATASOURCE_DEF COMMENT '数据源定义管理';


-- zyg 2017-2-14 先删外键名再删除数据源ID。
ALTER TABLE sys_report DROP FOREIGN KEY  SYS_REP_R_DATASOURCE;
ALTER TABLE sys_report DROP COLUMN SOURCE_ID_;
-- zyg 2017-2-14 添加数据源别名。
ALTER TABLE sys_report ADD COLUMN DS_ALIAS_  varchar(64) NULL COMMENT '数据源' ;

-- zyg 2017-2-26 bpmformview 增加bo定义ID。
ALTER TABLE bpm_form_view ADD COLUMN BO_DEFID_  varchar(50) NULL COMMENT 'bo定义ID' ;

-- zyg 2017-3-3 数据保存模式（all,json,db)。
ALTER TABLE bpm_inst
ADD COLUMN DATA_SAVE_MODE_  varchar(10) NULL COMMENT '数据保存模式(all,json,db)' AFTER ERRORS_;
-- zyg 2017-3-3 bo定义IDw
ALTER TABLE bpm_inst
ADD COLUMN BO_DEF_ID_  varchar(20) NULL COMMENT 'BO定义ID' AFTER DATA_SAVE_MODE_;

-- zyg 2017-3-5 BO定义相关表。
CREATE TABLE SYS_BO_DEFINITION
(
   ID_                  VARCHAR(20) NOT NULL COMMENT '主键',
   NAME_                VARCHAR(64) COMMENT '名称',
   ALAIS_               VARCHAR(64) COMMENT '别名',
   COMMENT_             VARCHAR(200) COMMENT '备注',
   SUPPORT_DB_          VARCHAR(20) COMMENT '是否支持数据库',
   GEN_MODE_            VARCHAR(20) COMMENT '生成模式',
   TREE_ID_             VARCHAR(20) COMMENT '分类ID',
   TENANT_ID_           VARCHAR(20) COMMENT '租户ID',
   CREATE_BY_           VARCHAR(20) COMMENT '创建时间',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(20) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_BO_DEFINITION COMMENT '业务对象定义';


CREATE TABLE SYS_BO_RELATION
(
   ID_                  VARCHAR(20) NOT NULL COMMENT '主键',
   BO_DEFID_            VARCHAR(20) COMMENT 'BO定义ID',
   RELATION_TYPE_       VARCHAR(20) COMMENT '关系类型(main,sub)',
   BO_ENTID_            VARCHAR(20) COMMENT 'BO实体ID',
   TENANT_ID_           VARCHAR(20) COMMENT '租户ID',
   CREATE_BY_           VARCHAR(20) COMMENT '创建时间',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(20) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_BO_RELATION COMMENT '业务对象定义';

CREATE TABLE SYS_BO_ENTITY
(
   ID_                  VARCHAR(20) NOT NULL COMMENT '主键',
   NAME_                VARCHAR(64) COMMENT '名称',
   COMMENT_             VARCHAR(64) COMMENT '注释',
   TABLE_NAME_          VARCHAR(64) COMMENT '表名',
   DS_NAME_             VARCHAR(64) COMMENT '数据源名称',
   GEN_TABLE_           VARCHAR(20) COMMENT '是否生成物理表',
   TENANT_ID_           VARCHAR(20) COMMENT '租户ID',
   CREATE_BY_           VARCHAR(20) COMMENT '创建时间',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(20) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_BO_ENTITY COMMENT '业务实体对象';

CREATE TABLE SYS_BO_ATTR
(
   ID_                  VARCHAR(20) NOT NULL COMMENT '主键',
   ENT_ID_              VARCHAR(20) COMMENT '实体ID',
   NAME_                VARCHAR(64) COMMENT '名称',
   FIELD_NAME_          VARCHAR(64) COMMENT '字段名',
   COMMENT_             VARCHAR(100) COMMENT '备注',
   DATA_TYPE_           VARCHAR(10) COMMENT '类型',
   LENGTH_              INT COMMENT '数据长度',
   DECIMAL_LENGTH_      INT COMMENT '数据精度',
   CONTROL_             VARCHAR(30) COMMENT '控件类型',
   EXT_JSON_            VARCHAR(1000) COMMENT '扩展JSON',
   HAS_GEN_             VARCHAR(10) COMMENT '是否生成字段',
   STATUS_              VARCHAR(10) COMMENT '状态',
   IS_SINGLE_           INT COMMENT '是否单个属性字段',
   TENANT_ID_           VARCHAR(20) COMMENT '租户ID',
   CREATE_BY_           VARCHAR(20) COMMENT '创建时间',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(20) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_BO_ATTR COMMENT '业务实体属性定义';


-----------------------------------------add by cmc 2017-03-08---------增加bpmformview的TITLE_字段-----------------------------------------
ALTER TABLE bpm_form_view
	ADD COLUMN TITLE_ VARCHAR(255) NULL COMMENT 'tab标题数组' AFTER TEMPLATE_VIEW_;

------------------------------------------add by cmc 2017-03-16-------------增加BPMSOLFV-----的权限字段-----------------------------------------------------------
ALTER TABLE bpm_sol_fv
	ADD COLUMN TAB_RIGHTS_ VARCHAR(2000) NULL DEFAULT NULL AFTER UPDATE_TIME_;
------------------------------------------add by cmc 2017-03-27-------------增加BPMSOLFV-----的BO设定-----------------------------------------------------------
	ALTER TABLE bpm_sol_fv
	CHANGE COLUMN TAB_RIGHTS_ TAB_RIGHTS_ VARCHAR(2000) NULL DEFAULT NULL COMMENT 'tab权限' AFTER ACT_DEF_ID_,
	ADD COLUMN INIT_SETTING_ VARCHAR(2000) NULL DEFAULT NULL COMMENT 'BO设定' AFTER TAB_RIGHTS_;
	ALTER TABLE bpm_sol_fv
	ADD COLUMN SAVE_SETTING_ VARCHAR(2000) NULL DEFAULT NULL COMMENT '保存BO设定数据' AFTER INIT_SETTING_;
	
-- zyg 2017-04-05  手机表单和bo进行绑定。	
ALTER TABLE bpm_mobile_form DROP COLUMN VIEW_ID_;
ALTER TABLE bpm_mobile_form  ADD COLUMN BO_DEF_ID_  varchar(255) NULL COMMENT 'BO定义ID' ;

-- zyg 方案增加 是否正式字段。2017-4-11
ALTER TABLE BPM_SOLUTION  ADD COLUMN FORMAL_  varchar(20) NULL COMMENT '是否正式' ;


alter table act_ru_task add token_ varchar(64);
alter table act_ru_task add urgent_times_ int default 0;

-- zyg 方案BO定义。2017-4-18
ALTER TABLE bpm_solution
ADD COLUMN BO_DEF_ID_  varchar(64) NULL COMMENT 'BO定义' AFTER FORMAL_,
ADD COLUMN DATA_SAVE_MODE_  varchar(10) NULL COMMENT '数据保存模式' AFTER BO_DEF_ID_;

-- zyg 催办定义添加字段ACT_DEF_ID_ 2017-4-21 
ALTER TABLE bpm_remind_def
ADD COLUMN ACT_DEF_ID_  varchar(64) NULL COMMENT '流程定义ID' AFTER SOLUTION_NAME_;

------------------------------------------add by cmc 2017-04-30-------------增加流程权限按照分类划分-----------------------------------------------------------
ALTER TABLE bpm_auth_def
	ADD COLUMN TREE_ID_ VARCHAR(50) NULL DEFAULT NULL COMMENT '分类ID' AFTER SOL_ID_;
-- zyg 增加表单意见定义  2017-5-4 
ALTER TABLE sys_bo_definition
ADD COLUMN OPINION_DEF_  varchar(2000) NULL COMMENT '表单意见定义' AFTER UPDATE_TIME_;

-- zyg 表单意见名称,用于表单中显示意见  2017-5-4
ALTER TABLE bpm_node_jump
ADD COLUMN OPINION_NAME_  varchar(20) NULL COMMENT '表单意见名称';

-- zyg 表单意见设置，增加权限类型(字段权限，意见权限)  2017-5-4
ALTER TABLE bpm_fv_right
ADD COLUMN TYPE_  varchar(20) NULL COMMENT '权限类型(field:字段,opinion:意见)' AFTER ACT_DEF_ID_;

------------------------------------------add by cmc 2017-05-09-------------增加表单授权字段-----------------------------------------------------------
ALTER TABLE bpm_auth_setting
ADD COLUMN TYPE_ VARCHAR(10) NULL DEFAULT NULL COMMENT '授权类型' AFTER ENABLE_;


------------------------------------------add by cmc 2017-05-16-------------增加维度授权表-----------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: OS_DIMENSION_RIGHT                             */
/*==============================================================*/
CREATE TABLE OS_DIMENSION_RIGHT
(
   RIGHT_ID_            VARCHAR(64) NOT NULL COMMENT '主键ID',
   USER_ID_             VARCHAR(64) COMMENT '用户ID',
   GROUP_ID_            VARCHAR(64) COMMENT '组ID',
   DIM_ID_               VARCHAR(64) COMMENT '_',
   TENANT_ID_           VARCHAR(64) COMMENT '机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (RIGHT_ID_)
);

ALTER TABLE OS_DIMENSION_RIGHT COMMENT '维度授权';
------- add by zyg 增加自定义表单设置 ，将表单独立使用。2017-05-16
CREATE TABLE SYS_CUSTOMFORM_SETTING
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   NAME_                VARCHAR(64) COMMENT '名称',
   ALIAS_               VARCHAR(64) COMMENT '别名',
   PRE_JS_SCRIPT_       VARCHAR(1000) COMMENT '前置JS',
   AFTER_JS_SCRIPT_     VARCHAR(1000) COMMENT '后置JS',
   PRE_JAVA_SCRIPT_     VARCHAR(1000) COMMENT '前置JAVA脚本',
   AFTER_JAVA_SCRIPT_   VARCHAR(1000) COMMENT '后置JAVA脚本',
   SOL_NAME_            VARCHAR(64) COMMENT '解决方案',
   SOL_ID_              VARCHAR(64) COMMENT '解决方案ID',
   FORM_NAME_           VARCHAR(100) COMMENT '表单名称',
   FORM_ALIAS_			VARCHAR(64) COMMENT '表单别名',
   VIEW_ID_             VARCHAR(64) COMMENT '表单ID',
   BODEF_ID_            VARCHAR(64) COMMENT '业务模型ID',
   BODEF_NAME_          VARCHAR(100) COMMENT '业务模型',
   IS_TREE_             INT COMMENT '树形表单(0,普通表单,1,树形表单)',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   EXPAND_LEVEL_        INT COMMENT '展开级别',
   LOAD_MODE_           INT COMMENT '树形加载方式0,一次性加载,1,懒加载',
   DISPLAY_FIELDS_      VARCHAR(64) COMMENT '显示字段',
   BUTTON_DEF_          VARCHAR(1000) COMMENT '自定义按钮',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_CUSTOMFORM_SETTING COMMENT '自定义表单设定';

------------------------------------------add by cmc 新增人员脚本计算表2017-6-7-------------------------------------------------------------------
/*==============================================================*/
/* Table: BPM_GROUP_SCRIPT                                      */
/*==============================================================*/
CREATE TABLE BPM_GROUP_SCRIPT
(
   SCRIPT_ID_           VARCHAR(64) NOT NULL COMMENT '脚本Id',
   CLASS_NAME_          VARCHAR(300) COMMENT '类名',
   CLASS_INS_NAME_      VARCHAR(100) COMMENT '类实例名',
   METHOD_NAME_         VARCHAR(300) COMMENT '方法名',
   METHOD_DESC_         VARCHAR(500) COMMENT '方法描述',
   RETURN_TYPE_         VARCHAR(64) COMMENT '返回类型',
   ARGUMENT_            VARCHAR(1000) COMMENT '参数',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATE COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATE COMMENT '更新时间',
   PRIMARY KEY (SCRIPT_ID_)
);

ALTER TABLE BPM_GROUP_SCRIPT COMMENT '人员脚本';


--add by zyg 企业微信 2017-6-7

--微信企业设置表
CREATE TABLE WX_ENT_CORP
(
   ID_                  VARCHAR(64) COMMENT '主键',
   CORP_ID_             VARCHAR(64) COMMENT '企业ID',
   SECRET_              VARCHAR(64) COMMENT '通讯录密钥',
   ENABLE_              INT COMMENT '是否启用企业微信',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人'
);

ALTER TABLE WX_ENT_CORP COMMENT '微信企业配置';

--微信企业应用表。
CREATE TABLE WX_ENT_AGENT
(
   ID_                  VARCHAR(64) COMMENT '主键',
   NAME_                VARCHAR(100) COMMENT '应用名称',
   DESCRIPTION_         VARCHAR(200) COMMENT '描述',
   DOMAIN_              VARCHAR(64) COMMENT '域名',
   HOME_URL_            VARCHAR(200) COMMENT '主页地址',
   ENT_ID_              VARCHAR(64) COMMENT '企业主键',
   CORP_ID_             VARCHAR(64) COMMENT '企业ID',
   AGENT_ID_            VARCHAR(64) COMMENT '应用ID',
   SECRET_              VARCHAR(64) COMMENT '密钥',
   DEFAULT_AGENT_             INT COMMENT '是否默认',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人'
);

ALTER TABLE WX_ENT_AGENT COMMENT '微信应用';

ALTER TABLE OS_USER
ADD COLUMN SYNC_WX_ INT  COMMENT '同步到微信' ;

ALTER TABLE OS_GROUP
ADD COLUMN SYNC_WX_ INT  COMMENT '同步到微信' ;

-------------------------------修改数据避免老数据不正确------------------------------------------
UPDATE os_user set SYNC_WX_=0;
UPDATE os_group set SYNC_WX_=0;


alter table sys_bo_list add use_cond_sql_ varchar(20);
alter table sys_bo_list add cond_sqls_ text;

------------------------------系统参数表   createBy cmc  20170621------------------------------------------------------------------
/*==============================================================*/
/* Table: SYS_PROPERTIES                                        */
/*==============================================================*/
CREATE TABLE SYS_PROPERTIES
(
   PRO_ID_              VARCHAR(64) NOT NULL COMMENT '参数ID',
   NAME_                VARCHAR(64) COMMENT '名称',
   ALIAS_               VARCHAR(64) COMMENT '别名',
   GLOBAL_              VARCHAR(64) COMMENT '是否全局',
   ENCRYPT_             VARCHAR(64) COMMENT '是否加密存储',
   VALUE_               VARCHAR(256) COMMENT '参数值',
   CATEGORY_            VARCHAR(64) COMMENT '分类',
   DESCRIPTION_         VARCHAR(1024) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租用用户Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (PRO_ID_)
);

ALTER TABLE SYS_PROPERTIES COMMENT '系统参数';


/*==============================================================*/
/* Table: SYS_PRIVATE_PROPERTIES                                */
/*==============================================================*/
CREATE TABLE SYS_PRIVATE_PROPERTIES
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID_',
   PRO_ID_              VARCHAR(64) COMMENT '参数ID',
   PRI_VALUE_           VARCHAR(256) COMMENT '私有值',
   TENANT_ID_           VARCHAR(64) COMMENT '租用用户Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_PRIVATE_PROPERTIES COMMENT '私有参数';

-- ADD BY ZYG 这个表记录实例和业务主键的关联。
CREATE TABLE BPM_INST_DATA
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   BO_DEF_ID_           VARCHAR(64) COMMENT '业务对象ID',
   INST_ID_             VARCHAR(64) COMMENT '实例ID_',
   PK_                  VARCHAR(64) COMMENT '业务表主键',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_INST_DATA COMMENT '关联关系';


CREATE INDEX IDX_INSTDATA_INSTID ON BPM_INST_DATA
(
   INST_ID_
);

ALTER TABLE bpm_inst
MODIFY COLUMN BUS_KEY_  varchar(64)  NULL ;

-- 配置多个表单后需要初始化数据，保证之前的表单正常工作。 add by zyg 2017-7-4
insert into bpm_inst_data (id_,inst_id_ ,bo_def_id_, pk_,tenant_id_)
select a.INST_ID_,a.INST_ID_,a.BO_DEF_ID_, a.BUS_KEY_,a.TENANT_ID_ from bpm_inst a;

-- 增加数据处理器 add by zyg 2017-7-4
ALTER TABLE sys_customform_setting
ADD COLUMN DATA_HANDLER_  varchar(64) NULL COMMENT '数据处理器' AFTER FORM_ALIAS_;

ALTER TABLE sys_bo_relation
ADD COLUMN IS_REF_  int NULL COMMENT '是否引用' AFTER TENANT_ID_,
ADD COLUMN FORM_ALIAS_  varchar(255) NULL COMMENT '表单别名' AFTER IS_REF_;


-- 为账号加上saas管理配置-2017-07-05-
update sys_account set name_=REPLACE(name_,'@redxun.cn','');
alter table sys_account add domain_ varchar(64);

UPDATE sys_account s INNER JOIN sys_inst i 
ON s.tenant_id_=i.inst_id_ SET s.domain_ = i.domain_ ;

-- 系统属性值  add by zyg 2017-7-6 

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938001','上传目录','upload.dir','YES','NO','c:/abc/temp','上传参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938002','匿名上传目录','upload.dir.anony','YES','NO','c:/abc/temp/anony','上传参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938003','启用SAAS','install.saas','YES','NO','true','SAAS参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938004','根SAAS域名','org.mgr.domain','YES','NO','redxun.cn','SAAS参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938005','催送帐号','sendRemindUser','YES','NO','admin@redxun.cn','系统参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938006','流程权限','bpm.permission','YES','NO','{inst:[{key:"del",name:"删除",val:false}],def:[{key:"design",name:"配置",val:true},{key:"edit",name:"编辑",val:true},{key:"start",name:"启动",val:true},{key:"del",name:"删除",val:true}], task:[{key:"intervene",name:"干预",val:true},{key:"handle",name:"办理",val:true}]}','系统参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938008','平台名称','app.name','YES','NO','私有云应用管理平台','系统参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('240000005938009','平台访问路径','install.host','YES','NO','http://localhost:8080/jsaas','SAAS参数','','1');

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
VALUES ('2400000005531000', '流程授权类型', 'bpm.grantType', 'YES', 'NO', 'actDefinition', '系统参数', 'bpmAssortment 流程分类,actDefinition 方案授权', '1');

commit;

------------------------------------------add by cmc 20170629  微信公众号管理模块--------------------------------------------------------------------
/*==============================================================*/
/* Table: WX_PUB_APP                                            */
/*==============================================================*/
CREATE TABLE WX_PUB_APP
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID',
   WX_NO_               VARCHAR(128) COMMENT '微信号',
   APP_ID_              VARCHAR(128) COMMENT 'APP_ID_',
   SECRET_              VARCHAR(512) COMMENT '密钥',
   TYPE_                VARCHAR(64) COMMENT '类型',
   AUTHED_              VARCHAR(64) COMMENT '是否认证',
   INTERFACE_URL_       VARCHAR(1024) COMMENT '接口消息地址',
   TOKEN                VARCHAR(128) COMMENT 'token',
   JS_DOMAIN_           VARCHAR(1024) COMMENT 'js安全域名',
   NAME_                VARCHAR(128) COMMENT '名称',
   ALIAS_               VARCHAR(128) COMMENT '别名',
   DESCRIPTION_         TEXT COMMENT '描述',
   MENU_CONFIG_         TEXT COMMENT '菜单配置',
   OTHER_CONFIG_         TEXT COMMENT '其他配置',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE WX_PUB_APP COMMENT '公众号管理';


/*==============================================================*/
/* Table: WX_TAG_USER                                           */
/*==============================================================*/
CREATE TABLE WX_TAG_USER
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   PUB_ID_              VARCHAR(64) COMMENT '公众号Id',
   TAG_ID_              VARCHAR(64) COMMENT '标签名',
   USER_ID_             VARCHAR(128) COMMENT '用户ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE WX_TAG_USER COMMENT '微信用户标签';



/*==============================================================*/
/* Table: WX_SUBSCRIBE_                                         */
/*==============================================================*/
CREATE TABLE WX_SUBSCRIBE_
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID',
   PUB_ID_              VARCHAR(64) COMMENT '公众号ID',
   SUBSCRIBE_           VARCHAR(64) COMMENT 'SUBSCRIBE',
   OPEN_ID_             VARCHAR(128) COMMENT 'OPENID',
   NICK_NAME_           VARCHAR(64) COMMENT '昵称',
   LANGUAGE_            VARCHAR(64) COMMENT '语言',
   CITY_                VARCHAR(64) COMMENT '城市',
   PROVINCE_            VARCHAR(64) COMMENT '省份',
   COUNTRY_             VARCHAR(128) COMMENT '国家',
   UNIONID_             VARCHAR(64) COMMENT '绑定ID',
   SUBSCRIBE_TIME_      DATETIME COMMENT '最后的关注时间',
   REMARK_              VARCHAR(64) COMMENT '粉丝备注',
   GROUPID_             VARCHAR(64) COMMENT '用户分组ID',
   TAGID_LIST_          VARCHAR(512) COMMENT '标签ID列表',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE WX_SUBSCRIBE_ COMMENT '微信关注者';

--------------------微信消息发送表单----------add by cmc 20170717------------------------------
/*==============================================================*/
/* Table: MESSAGE_SEND                                          */
/*==============================================================*/
CREATE TABLE WX_MESSAGE_SEND
(
   ID                   VARCHAR(64) NOT NULL COMMENT 'ID',
   PUB_ID_              VARCHAR(64) COMMENT '公众号ID',
   MSG_TYPE_            VARCHAR(64) COMMENT '消息类型',
   SEND_TYPE_           VARCHAR(64) COMMENT '发送类型',
   RECEIVER_            VARCHAR(1024) COMMENT '接收者',
   CONTENT_             TEXT COMMENT '消息内容',
   SEND_STATE_          VARCHAR(64) COMMENT '发送状态',
   CONFIG_              TEXT COMMENT '备用配置',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID)
);

ALTER TABLE WX_MESSAGE_SEND COMMENT '发送消息';

-------------------补充微信素材表            add by cmc 20170718----------------------------------------------------------------------------
/*==============================================================*/
/* Table: WX_METERIAL                                           */
/*==============================================================*/
CREATE TABLE WX_METERIAL
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '素材ID',
   PUB_ID_              VARCHAR(64) COMMENT '公众号ID',
   TERM_TYPE_           VARCHAR(64) COMMENT '期限类型',
   MEDIA_TYPE_          VARCHAR(64) COMMENT '素材类型',
   NAME_                VARCHAR(64) COMMENT '素材名',
   MEDIA_ID_            VARCHAR(64) COMMENT '微信后台指定ID',
   ART_CONFIG_          TEXT COMMENT '图文配置',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE WX_METERIAL COMMENT '微信素材';

----------------------补充微信公众号网页授权表           add by cmc 20170818--------------------------------
/*==============================================================*/
/* Table: WX_WEB_GRANT                                          */
/*==============================================================*/
CREATE TABLE WX_WEB_GRANT
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   PUB_ID_              VARBINARY(64) COMMENT '公众号ID',
   URL_                 VARCHAR(2000) COMMENT '链接',
   TRANSFORM_URL_       VARCHAR(2000) COMMENT '转换后的URL',
   CONFIG_              TEXT COMMENT '配置信息',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE WX_WEB_GRANT COMMENT '微信网页授权';

---------------------补充微信卡券表   edit by cmc 20170901--------------------------------------------------------------------------------
/*==============================================================*/
/* Table: WX_TICKET                                             */
/*==============================================================*/
CREATE TABLE WX_TICKET
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID',
   PUB_ID_              VARCHAR(64) COMMENT '公众号ID',
   CARD_TYPE_           VARCHAR(64) COMMENT '卡券类型',
   LOGO_URL_            VARCHAR(128) COMMENT '卡券的商户logo',
   CODE_TYPE_           VARCHAR(16) COMMENT '码型',
   BRAND_NAME_          VARCHAR(36) COMMENT '商户名字',
   TITLE_               VARCHAR(27) COMMENT '卡券名',
   COLOR_               VARCHAR(16) COMMENT '券颜色',
   NOTICE_              VARCHAR(48) COMMENT '卡券使用提醒',
   DESCRIPTION_         VARCHAR(3072) COMMENT '卡券使用说明',
   SKU_                 TEXT COMMENT '商品信息',
   DATE_INFO            TEXT COMMENT '使用日期',
   BASE_INFO_           TEXT COMMENT '基础非必须信息',
   ADVANCED_INFO_       TEXT COMMENT '高级非必填信息',
   SPECIAL_CONFIG_      TEXT COMMENT '专用配置',
   CHECKED_             VARCHAR(64) COMMENT '审核是否通过',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE WX_TICKET COMMENT '微信卡券';


ALTER TABLE WX_TICKET COMMENT '微信卡券';

---------------------补充微信关键字回复表   edit by cmc 20170830--------------------------------------------------------------------------------
/*==============================================================*/
/* Table: WX_KEY_WORD_REPLY                                     */
/*==============================================================*/
CREATE TABLE WX_KEY_WORD_REPLY
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID_',
   PUB_ID_              VARCHAR(64) COMMENT '公众号ID',
   KEY_WORD_            VARCHAR(512) COMMENT '关键字',
   REPLY_TYPE_          VARCHAR(64) COMMENT '回复方式',
   REPLY_CONTENT_       VARCHAR(1024) COMMENT '回复内容',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE WX_KEY_WORD_REPLY COMMENT '公众号关键字回复';








-- 增加数据源字段，增加分布式数据库功能 add by zyg 2017-7-7
ALTER TABLE sys_inst
ADD COLUMN DS_NAME_  varchar(64) NULL COMMENT '数据源名称' AFTER UPDATE_TIME_;

ALTER TABLE sys_inst
ADD COLUMN DS_ALIAS_  varchar(64) NULL COMMENT '数据源别名' AFTER DS_NAME_;


-- 增加机构类型，其他机构的权限访问 add by csx 2017-07-11 --

/*==============================================================*/
/* Table: SYS_INST_TYPE                                         */
/*==============================================================*/
CREATE TABLE SYS_INST_TYPE
(
   TYPE_ID_             VARCHAR(64) NOT NULL COMMENT '类型',
   TYPE_CODE_           VARCHAR(50) NOT NULL COMMENT '类型编码',
   TYPE_NAME_           VARCHAR(100) NOT NULL COMMENT '类型名称',
   ENABLED_             VARCHAR(20) COMMENT '是否启用',
   IS_DEFAULT_          VARCHAR(20) COMMENT '是否系统缺省',
   DESCP_               VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租用用户Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (TYPE_ID_)
);

ALTER TABLE SYS_INST_TYPE COMMENT '机构类型';

alter table sys_inst add inst_type_ varchar(50);

ALTER table sys_inst add home_url_ varchar(120);

alter table SYS_SUBSYS add inst_type_ varchar(50);


alter table sys_inst_type add home_url_ varchar(200);


--机构类型  add by zhy 2017-07-18 
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, IS_MGR_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
VALUES ('2400000006101005', '210000000418012', '机构类型', 'sysInstTypeList', NULL, NULL, NULL, ' icon-Process-LDAP', NULL, '1', 2, '210000000418012.1.2400000006101005.', '0', 'NO', '/sys/core/sysInstType/list.do', 'URL', 'NO', '0', NULL, 1, NULL, NULL, NULL);

INSERT INTO sys_inst_type (TYPE_ID_, TYPE_CODE_, TYPE_NAME_, ENABLED_, IS_DEFAULT_, DESCP_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, home_url_)
VALUES ('2400000006101006', 'PLATFORM', '平台机构', 'YES', 'YES', '', '1', 1, NULL, 1, NULL, '');
commit;

--数据源对话框  add by zhy 2017-07-20 
INSERT INTO sys_bo_list (ID_, SOL_ID_, NAME_, KEY_, DESCP_, ID_FIELD_, URL_, MULTI_SELECT_, IS_LEFT_TREE_, LEFT_NAV_, LEFT_TREE_JSON_, SQL_, USE_COND_SQL_, COND_SQLS_, DB_AS_, FIELDS_JSON_, COLS_JSON_, LIST_HTML_, SEARCH_JSON_, BPM_SOL_ID_, FORM_ALIAS_, TOP_BTNS_JSON_, BODY_SCRIPT_, IS_DIALOG_, IS_PAGE_, IS_EXPORT_, HEIGHT_, WIDTH_, ENABLE_FLOW_, IS_GEN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
VALUES ('2400000000001017', NULL, '数据源对话框', 'dataSourceDialog', '', 'ID_', NULL, 'false', 'NO', '', NULL, 'select * from sys_datasource_def', 'NO', '[]', '', '[{"field":"ID_","queryDataType":"S","dataType":"string","width":100,"header":"主键","_id":12,"_uid":12},{"field":"NAME_","queryDataType":"S","dataType":"string","width":100,"header":"数据源名称","_id":13,"_uid":13,"isReturn":"YES","_state":"modified"},{"field":"ALIAS_","queryDataType":"S","dataType":"string","width":100,"header":"别名","_id":14,"_uid":14,"isReturn":"YES","_state":"modified"},{"field":"ENABLE_","queryDataType":"S","dataType":"string","width":100,"header":"是否使用","_id":15,"_uid":15},{"field":"SETTING_","queryDataType":"S","dataType":"string","width":100,"header":"数据源设定","_id":16,"_uid":16},{"field":"DB_TYPE_","queryDataType":"S","dataType":"string","width":100,"header":"数据库类型","_id":17,"_uid":17,"isReturn":"YES","_state":"modified"},{"field":"INIT_ON_START_","queryDataType":"S","dataType":"string","width":100,"header":"启动时初始化","_id":18,"_uid":18},{"field":"CREATE_TIME_","queryDataType":"D","dataType":"date","width":100,"format":"yyyy-MM-dd","header":"创建时间","_id":19,"_uid":19},{"field":"CREATE_BY_","queryDataType":"S","dataType":"string","width":100,"header":"创建人","_id":20,"_uid":20},{"field":"UPDATE_BY_","queryDataType":"S","dataType":"string","width":100,"header":"更新人","_id":21,"_uid":21},{"field":"UPDATE_TIME_","queryDataType":"D","dataType":"date","width":100,"format":"yyyy-MM-dd","header":"更新时间","_id":22,"_uid":22}]', '[{"field":"NAME_","queryDataType":"S","dataType":"string","width":100,"header":"数据源名称","expanded":true,"_id":2,"_uid":2,"_pid":-1,"_level":0},{"field":"ALIAS_","queryDataType":"S","dataType":"string","width":100,"header":"别名","expanded":true,"_id":3,"_uid":3,"_pid":-1,"_level":0},{"field":"DB_TYPE_","queryDataType":"S","dataType":"string","width":100,"header":"数据库类型","expanded":true,"_id":6,"_uid":6,"_pid":-1,"_level":0}]', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n    <title>数据源对话框</title>\n    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />\n	<link href="${ctxPath}/styles/commons.css" rel="stylesheet" type="text/css" />\n	<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />\n	<link href="${ctxPath}/styles/icons.css" rel="stylesheet" type="text/css" />\n	<script src="${ctxPath}/scripts/boot.js" type="text/javascript"></script>\n	<script type="text/javascript">\n		var __rootPath=''${ctxPath}'';\n	</script>\n	<script src="${ctxPath}/scripts/share.js" type="text/javascript"></script>\n	\n</head>\n<body >   \n<div id="layout1" class="mini-layout" style="width:100%;height:100%;">\n\n      <div region="center"  title="数据源对话框" showCollapseButton="false" >\n     	<div class="mini-toolbar" >\n	         <table style="width:100%;">\n	             <tr>\n	                 <td style="width:100%;">\n	                    <a class="mini-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>\n                     	<a class="mini-button" iconCls="icon-cancel" plain="true" onclick="onClear()">清空查询</a>\n                     	<span class="separator"></span>\n                     	<a class="mini-button" iconCls="icon-ok"   onclick="CloseWindow(''ok'');">确定</a>\n		    			<a class="mini-button" iconCls="icon-cancel"  onclick="CloseWindow();">取消</a>\n	                 </td>\n	             </tr>\n	              <tr>\n	                  <td  class="search-form" style="white-space:nowrap;">\n	                   	<div id="searchForm">\n	                    	<ul>\n <li><span>数据源名称</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>\n <li><span>别名</span><input class="mini-textbox" name="Q_ALIAS__S_LK"></li>\n</ul>\n	                    </div>\n	                  </td>\n	              </tr>\n	         </table>\n	     </div>\n	    \n     	<div class="mini-fit" style="padding-top:10px;">\n	        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" \n	        	url="${ctxPath}/dev/cus/customData/dataSourceDialog/getData.do" idField="ID_" multiSelect="false" showColumnsMenu="true" \n	        	sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">\n						<div property="columns">\n <div type="indexcolumn"></div>\n <div type="checkcolumn"></div>\n <div header="数据源名称" width="100" field="NAME_"></div>\n <div header="别名" width="100" field="ALIAS_"></div>\n <div header="数据库类型" width="100" field="DB_TYPE_"></div>\n</div>\n			</div>\n		</div>\n    </div>\n</div>\n\n    \n    <script type="text/javascript">\n        mini.parse();\n		var grid=mini.get(''datagrid1'');\n		grid.load();\n		var searchForm=new mini.Form(''searchForm'');\n			\n		function onSearch(){\n			var data=searchForm.getData();\n			grid.load(data);\n		}\n		\n		 grid.on("drawcell", function (e) {\n		   var record = e.record,\n		   field = e.field,\n		   value = e.value;\n		   if(field==''CREATE_BY_'' || field==''UPDATE_BY_'' || field==''CREATE_USER_ID_''){\n		     if(value){\n		     	e.cellHtml=''<a class="mini-user" iconCls="icon-user" userId="''+value+''"></a>'';\n		     }else{\n		     	e.cellHtml=''<span style="color:red">无</span>'';\n		     }\n		   }\n		 });\n		\n		 grid.on(''update'',function(){\n		   _LoadUserInfo();\n		 });\n		\n		function onClear(){\n			searchForm.clear();\n			var url=grid.getUrl();\n			var index=url.indexOf(''?'');\n			if(index!=-1){\n				url=url.substring(0,index);\n			}\n			grid.setUrl(url);\n			grid.load();\n		}\n		\n		function onClose(){\n			CloseWindow();\n		}\n		\n		function onRemove(){\n			var row=grid.getSelected();\n			if(row==null){\n			   alert(''请选择表格行'');\n			   return;\n			}\n			\n			mini.confirm("确定删除吗?", "提示信息", function(action){\n                if (action != "ok")  return;\n            	var url=__rootPath+''/sys/customform/sysCustomFormSetting/remove/.do'';\n				var id= row.ID_;\n				_SubmitJson({url:url,method:"POST",data:{id:id},success:function(){\n					grid.load();\n				}})    \n            })\n		}\n		\n		//返回选择的数据\n		function getData(){\n			var rows=grid.getSelecteds();\n			return rows;\n		}\n    </script>\n\n</body>\n</html>', '[{"fc":"mini-textbox","_id":23,"_uid":23,"_state":"added","fieldLabel":"数据源名称","dataType":"string","queryDataType":"S","fieldName":"NAME_","fieldOpLabel":"%模糊匹配%","fieldOp":"LK","fcName":"文本框"},{"fc":"mini-textbox","_id":24,"_uid":24,"_state":"added","fieldLabel":"别名","dataType":"string","queryDataType":"S","fieldName":"ALIAS_","fieldOpLabel":"%模糊匹配%","fieldOp":"LK","fcName":"文本框"}]', NULL, '', NULL, '', 'YES', 'YES', NULL, 600, 800, NULL, 'YES', '1', '1', NULL, NULL, NULL);


--数据源对话框  add by zhy oracle写法
INSERT INTO SYS_BO_LIST(ID_,SOL_ID_,NAME_,KEY_,DESCP_,ID_FIELD_,URL_,MULTI_SELECT_,IS_LEFT_TREE_,LEFT_NAV_,LEFT_TREE_JSON_,SQL_,USE_COND_SQL_,COND_SQLS_,DB_AS_,FIELDS_JSON_,COLS_JSON_,LIST_HTML_,SEARCH_JSON_,BPM_SOL_ID_,FORM_ALIAS_,TOP_BTNS_JSON_,BODY_SCRIPT_,IS_DIALOG_,IS_PAGE_,IS_EXPORT_,HEIGHT_,WIDTH_,ENABLE_FLOW_,IS_GEN_,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)
VALUES ('2400000000001017','','数据源对话框','dataSourceDialog','','ID_','','false','NO','','','select * from sys_datasource_def','NO','[]','','[{"field":"ID_","queryDataType":"S","dataType":"string","width":100,"header":"主键","_id":12,"_uid":12},{"field":"NAME_","queryDataType":"S","dataType":"string","width":100,"header":"数据源名称","_id":13,"_uid":13,"isReturn":"YES","_state":"modified"},{"field":"ALIAS_","queryDataType":"S","dataType":"string","width":100,"header":"别名","_id":14,"_uid":14,"isReturn":"YES","_state":"modified"},{"field":"ENABLE_","queryDataType":"S","dataType":"string","width":100,"header":"是否使用","_id":15,"_uid":15},{"field":"SETTING_","queryDataType":"S","dataType":"string","width":100,"header":"数据源设定","_id":16,"_uid":16},{"field":"DB_TYPE_","queryDataType":"S","dataType":"string","width":100,"header":"数据库类型","_id":17,"_uid":17,"isReturn":"YES","_state":"modified"},{"field":"INIT_ON_START_","queryDataType":"S","dataType":"string","width":100,"header":"启动时初始化","_id":18,"_uid":18},{"field":"CREATE_TIME_","queryDataType":"D","dataType":"date","width":100,"format":"yyyy-MM-dd","header":"创建时间","_id":19,"_uid":19},{"field":"CREATE_BY_","queryDataType":"S","dataType":"string","width":100,"header":"创建人","_id":20,"_uid":20},{"field":"UPDATE_BY_","queryDataType":"S","dataType":"string","width":100,"header":"更新人","_id":21,"_uid":21},{"field":"UPDATE_TIME_","queryDataType":"D","dataType":"date","width":100,"format":"yyyy-MM-dd","header":"更新时间","_id":22,"_uid":22}]','[{"field":"NAME_","queryDataType":"S","dataType":"string","width":100,"header":"数据源名称","expanded":true,"_id":2,"_uid":2,"_pid":-1,"_level":0},{"field":"ALIAS_","queryDataType":"S","dataType":"string","width":100,"header":"别名","expanded":true,"_id":3,"_uid":3,"_pid":-1,"_level":0},{"field":"DB_TYPE_","queryDataType":"S","dataType":"string","width":100,"header":"数据库类型","expanded":true,"_id":6,"_uid":6,"_pid":-1,"_level":0}]',NULL,'[{"fc":"mini-textbox","_id":23,"_uid":23,"_state":"added","fieldLabel":"数据源名称","dataType":"string","queryDataType":"S","fieldName":"NAME_","fieldOpLabel":"%模糊匹配%","fieldOp":"LK","fcName":"文本框"},{"fc":"mini-textbox","_id":24,"_uid":24,"_state":"added","fieldLabel":"别名","dataType":"string","queryDataType":"S","fieldName":"ALIAS_","fieldOpLabel":"%模糊匹配%","fieldOp":"LK","fcName":"文本框"}]','','','','','YES','YES','','600','800','','YES','1','1','','','');

DECLARE  
  html SYS_BO_LIST.LIST_HTML_ %TYPE;  
BEGIN 
	html := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml">\n<head>\n    <title>数据源对话框</title>\n    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />\n	<link href="${ctxPath}/styles/commons.css" rel="stylesheet" type="text/css" />\n	<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />\n	<link href="${ctxPath}/styles/icons.css" rel="stylesheet" type="text/css" />\n	<script src="${ctxPath}/scripts/boot.js" type="text/javascript"></script>\n	<script type="text/javascript">\n		var __rootPath=''${ctxPath}'';\n	</script>\n	<script src="${ctxPath}/scripts/share.js" type="text/javascript"></script>\n	\n</head>\n<body >   \n<div id="layout1" class="mini-layout" style="width:100%;height:100%;">\n\n      <div region="center"  title="数据源对话框" showCollapseButton="false" >\n     	<div class="mini-toolbar" >\n	         <table style="width:100%;">\n	             <tr>\n	                 <td style="width:100%;">\n	                    <a class="mini-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>\n                     	<a class="mini-button" iconCls="icon-cancel" plain="true" onclick="onClear()">清空查询</a>\n                     	<span class="separator"></span>\n                     	<a class="mini-button" iconCls="icon-ok"   onclick="CloseWindow(''ok'');">确定</a>\n		    			<a class="mini-button" iconCls="icon-cancel"  onclick="CloseWindow();">取消</a>\n	                 </td>\n	             </tr>\n	              <tr>\n	                  <td  class="search-form" style="white-space:nowrap;">\n	                   	<div id="searchForm">\n	                    	<ul>\n <li><span>数据源名称</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>\n <li><span>别名</span><input class="mini-textbox" name="Q_ALIAS__S_LK"></li>\n</ul>\n	                    </div>\n	                  </td>\n	              </tr>\n	         </table>\n	     </div>\n	    \n     	<div class="mini-fit" style="padding-top:10px;">\n	        <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" \n	        	url="${ctxPath}/dev/cus/customData/dataSourceDialog/getData.do" idField="ID_" multiSelect="false" showColumnsMenu="true" \n	        	sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">\n						<div property="columns">\n <div type="indexcolumn"></div>\n <div type="checkcolumn"></div>\n <div header="数据源名称" width="100" field="NAME_"></div>\n <div header="别名" width="100" field="ALIAS_"></div>\n <div header="数据库类型" width="100" field="DB_TYPE_"></div>\n</div>\n			</div>\n		</div>\n    </div>\n</div>\n\n    \n    <script type="text/javascript">\n        mini.parse();\n		var grid=mini.get(''datagrid1'');\n		grid.load();\n		var searchForm=new mini.Form(''searchForm'');\n			\n		function onSearch(){\n			var data=searchForm.getData();\n			grid.load(data);\n		}\n		\n		 grid.on("drawcell", function (e) {\n		   var record = e.record,\n		   field = e.field,\n		   value = e.value;\n		   if(field==''CREATE_BY_'' || field==''UPDATE_BY_'' || field==''CREATE_USER_ID_''){\n		     if(value){\n		     	e.cellHtml=''<a class="mini-user" iconCls="icon-user" userId="''+value+''"></a>'';\n		     }else{\n		     	e.cellHtml=''<span style="color:red">无</span>'';\n		     }\n		   }\n		 });\n		\n		 grid.on(''update'',function(){\n		   _LoadUserInfo();\n		 });\n		\n		function onClear(){\n			searchForm.clear();\n			var url=grid.getUrl();\n			var index=url.indexOf(''?'');\n			if(index!=-1){\n				url=url.substring(0,index);\n			}\n			grid.setUrl(url);\n			grid.load();\n		}\n		\n		function onClose(){\n			CloseWindow();\n		}\n		\n		function onRemove(){\n			var row=grid.getSelected();\n			if(row==null){\n			   alert(''请选择表格行'');\n			   return;\n			}\n			\n			mini.confirm("确定删除吗?", "提示信息", function(action){\n                if (action != "ok")  return;\n            	var url=__rootPath+''/sys/customform/sysCustomFormSetting/remove/.do'';\n				var id= row.ID_;\n				_SubmitJson({url:url,method:"POST",data:{id:id},success:function(){\n					grid.load();\n				}})    \n            })\n		}\n		\n		//返回选择的数据\n		function getData(){\n			var rows=grid.getSelecteds();\n			return rows;\n		}\n    </script>\n\n</body>\n</html>' ; 
  		UPDATE SYS_BO_LIST T SET T.LIST_HTML_ = html WHERE t.ID_='2400000000001017'; 
END;  

  
alter table BPM_SOL_FV add IS_USE_CFORM_ varchar(20);
alter table BPM_SOL_FV add COND_FORMS_ text;
alter table BPM_SOL_FV add DATA_CONFS_ text;
alter table bpm_fv_right add form_alias_ varchar(100);

ALTER TABLE bpm_fv_right
MODIFY COLUMN VIEW_ID_  varchar(64)  NULL ;

update bpm_fv_right r left join bpm_form_view v 
    on r.view_id_=v.view_id_ set r.form_alias_=v.key_

alter table bpm_sol_var add form_field_ varchar(100);  

alter table SYS_BO_LIST add is_share_ varchar(20);

-- add by zyg 表单按钮定义。
ALTER TABLE bpm_form_view
ADD COLUMN BUTTON_DEF_  varchar(1000) NULL COMMENT '按钮定义';

----------------------------------add by cmc 修改维度权限字段长度 20170814------------------------------------------------------------------------------------------
ALTER TABLE os_dimension_right
	CHANGE COLUMN USER_ID_ USER_ID_ TEXT NULL DEFAULT NULL COMMENT '用户ID' AFTER RIGHT_ID_,
	CHANGE COLUMN GROUP_ID_ GROUP_ID_ TEXT NULL DEFAULT NULL COMMENT '组ID' AFTER USER_ID_;
----------------------------------add by zyg 增加手机表单配置 20170815---------------------------------------------
ALTER TABLE bpm_sol_fv
ADD COLUMN MOBILE_FORMS_  text NULL COMMENT '手机表单';

ALTER TABLE bpm_sol_fv
ADD COLUMN PRINT_FORMS_  text NULL COMMENT '打印表单' ;

----------------------------------add by zyg 增加表单配置 20170816---------------------------------------------
UPDATE bpm_sol_fv SET COND_FORMS_=CONCAT('[{"formAlias": "', FORM_URI_ , '","isAll": "true","formName": "',FORM_NAME_ ,'"}]') WHERE FORM_URI_ IS NOT NULL ;
UPDATE bpm_sol_fv SET PRINT_FORMS_=CONCAT('[{"formAlias": "', PRINT_URI_, '","isAll": "true","formName": "',PRINT_NAME_ ,'"}]') WHERE PRINT_URI_ IS NOT NULL ;
UPDATE bpm_sol_fv SET MOBILE_FORMS_=CONCAT('[{"formAlias": "', MOBILE_ALIAS_, '","isAll": "true","formName": "',MOBILE_NAME_ ,'"}]') WHERE MOBILE_ALIAS_ IS NOT NULL ;

----------------------------------add by cmc 删除陈俊先版微信公众号数据库 20170817------------------------------------------------------------------------------------------
DROP TABLE wx_p_user_news;
DROP TABLE wx_p_article;
DROP TABLE wx_p_user;
DROP TABLE wx_p_saas_user_news;
DROP TABLE wx_p_saas_news_article;
DROP TABLE wx_p_saas_news;
DROP TABLE wx_p_saas_material;
DROP TABLE wx_p_saas_article;
DROP TABLE wx_p_news_article;
DROP TABLE wx_p_news;
DROP TABLE wx_p_config;
DROP TABLE wx_p_material;
DROP TABLE wx_p_mt_user_news;
DROP TABLE wx_p_menu;
DROP TABLE wx_p_mt_news;
DROP TABLE wx_p_mt_material_temp;
DROP TABLE wx_p_mt_article;
DROP TABLE wx_p_msg;
DROP TABLE wx_p_mo_text;

----------------------------------add by cmc 修改维度权限字段长度 20170814------------------------------------------------------------------------------------------
ALTER TABLE os_dimension_right
	CHANGE COLUMN USER_ID_ USER_ID_ TEXT NULL DEFAULT NULL COMMENT '用户ID' AFTER RIGHT_ID_,
	CHANGE COLUMN GROUP_ID_ GROUP_ID_ TEXT NULL DEFAULT NULL COMMENT '组ID' AFTER USER_ID_;

	
------------------------add by csx 2017-08-17-----------------------	
alter table sys_bo_list add is_tree_dlg_ varchar(20) default 'NO';

alter table sys_bo_list add text_field_ varchar(60);

alter table sys_bo_list add parent_field_ varchar(60);

alter table sys_bo_list add only_sel_leaf_ varchar(20);

------add by zwj 2017-08-21---------------
update sys_account set PWD_='a4ayc/80/OGda4BO/1o/V0etpOqiLx1JwB5S3beHW0s=';  --修改为哈希256加密，明文为1

------add by zhw 首页 2017-08-21---------------
/*==============================================================*/
/* Table: INS_PORTAL_DEF                                        */
/*==============================================================*/
CREATE TABLE INS_PORTAL_DEF
(
   PORT_ID_             VARCHAR(64) NOT NULL,
   NAME_                VARCHAR(128) NOT NULL,
   KEY_                 VARCHAR(64) NOT NULL,
   IS_DEFAULT_          VARCHAR(64),
   USER_ID_             VARCHAR(64) NOT NULL,
   LAYOUT_HTML_         VARCHAR(2048),
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (PORT_ID_)
);
/*==============================================================*/
/* Table: INS_COLUMN_DEF                                        */
/*==============================================================*/
CREATE TABLE INS_COLUMN_DEF
(
   COL_ID_              VARCHAR(64) NOT NULL,
   NAME_                VARCHAR(80) NOT NULL,
   KEY_                 VARCHAR(64) NOT NULL,
   DATA_URL_            VARCHAR(255),
   IS_DEFAULT_          VARCHAR(20),
   TEMPLET_             VARCHAR(4000),
   FUNCTION_            VARCHAR(128) NOT NULL,
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (COL_ID_)
);

------add by zwc 2017-8-23 10:27:01---------------
alter table hr_duty_register add LONGITUDE_ double(11,3) NULL COMMENT '经度';
alter table hr_duty_register add LATITUDE_ double(11,3) NULL COMMENT '纬度';
alter table hr_duty_register add ADDRESSES_ varchar(128) NULL COMMENT '地址详情';
ALTER TABLE hr_duty_register ADD COLUMN SIGNREMARK_  varchar(300) NULL COMMENT '签到备注' AFTER ADDRESSES_;

CREATE TABLE INS_COL_NEW_DEF
(
   ID_                  VARCHAR(64) NOT NULL,
   COL_ID_              VARCHAR(64) NOT NULL,
   NEW_ID_              VARCHAR(64) NOT NULL,
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

------add by zhw 增加布局门户优先级字段 2017-08-30---------------
alter table INS_PORTAL_DEF add PRIORITY_ int(20);

------add by zhw 增加权限表 2017-08-30---------------
CREATE TABLE INS_PORTAL_PERMISSION
(
   ID_                  VARCHAR(64) NOT NULL,
   LAYOUT_ID_           VARCHAR(64) NOT NULL,
   TYPE_                VARCHAR(32) NOT NULL,
   OWNER_ID_            VARCHAR(32) NOT NULL,
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE INS_PORTAL_PERMISSION COMMENT '布局权限设置';

--------------------------add by cmc 新增公网地址参数 20170904--------------------------------------------------------------
INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES
	('2400000006979000', '公网地址', 'publicAddress', 'NO', 'NO', '', '系统参数', '例如http://www.redxun.cn:8020/saweb/login.jsp的公网IP是http://www.redxun.cn:8020', '1', '1', '2017-08-21 11:19:12', NULL, '2017-09-04 16:19:19');


------add by zhw 增加消息盒子表 2017-08-30---------------
CREATE TABLE INS_MSGBOX_BOX_DEF
(
   SN_                  VARCHAR(16) NOT NULL,
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   MSG_ID_              VARCHAR(64) NOT NULL,
   BOX_ID_              VARCHAR(64) NOT NULL,
   ID_                  VARCHAR(64) NOT NULL,
   PRIMARY KEY (ID_)
);


CREATE TABLE INS_MSGBOX_DEF
(
   BOX_ID_              VARCHAR(64) NOT NULL,
   COL_ID_              VARCHAR(64),
   KEY_                 VARCHAR(64) NOT NULL,
   NAME_                VARCHAR(64) NOT NULL,
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (BOX_ID_)
);

ALTER TABLE INS_MSGBOX_DEF COMMENT '栏目消息盒子表';

CREATE TABLE INS_MSG_DEF
(
   MSG_ID_              VARCHAR(64) NOT NULL,
   COLOR_               VARCHAR(64) COMMENT '颜色',
   URL_                 VARCHAR(256) NOT NULL COMMENT '更多URl',
   ICON_                VARCHAR(64) COMMENT '图标',
   CONTENT_             VARCHAR(64) NOT NULL COMMENT '文字',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   DS_NAME_             VARCHAR(64) COMMENT '数据库名字',
   DS_ALIAS_            VARCHAR(64) COMMENT '数据库id',
   SQL_FUNC_            VARCHAR(512) NOT NULL COMMENT 'SQL语句',
   TYPE_                VARCHAR(16) NOT NULL,
   PRIMARY KEY (MSG_ID_)
);

-- add by zyg 2017-09-05 添加模版列
alter table BPM_FORM_VIEW  add TEMPLATE_ LONGTEXT NULL COMMENT '转换过的模版';

-- add by zyg 2017-09-06 子表添加数据权限控制。
ALTER TABLE bpm_fv_right
ADD COLUMN DEALWITH_  varchar(20) NULL COMMENT '子表添加数据处理' AFTER form_alias_;


alter table sys_bo_list add tree_id_ varchar(64);
alter table sys_bo_list add draw_cell_script_ text;

insert into sys_tree_cat (CAT_ID_, KEY_, NAME_, SN_, DESCP_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000001801010', 'CAT_BO_LIST', '业务列表分类', 1, null, '1', null, null, '1', null);

insert into sys_tree_cat (CAT_ID_, KEY_, NAME_, SN_, DESCP_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000002011000', 'CAT_BO_LIST_DLG', '对话框分类', 1, null, '1', '1', null, null, null);

-- add by zhw 2017-09-07 新版初始化栏目
INSERT INTO ins_column_def VALUES ('2400000003411003', '消息盒', 'msgBox', '1', '1', '<div id=\"msgBox\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"card\">\n		<ul id=\"cardUl\">\n			<#list data.obj as d>\n			<li>\n            	<a href=\"${d.url}\" target=\"_blank\">\n				<div class=\"cardBox\" url=\"${d.url}\">\n					<span class=\"iconfont  span-icon ${d.icon}\"></span> \n					<span>\n						<h3>${d.count}</h3><br>\n						<h2>${d.title}</h2>\n					</span>\n					<div class=\"clearfix\"></div>\n				</div>\n                </a>\n			</li>\n			</#list>		\n			\n			<h1 class=\"clearfix\"></h1>\n		</ul>\n	</div>\n	</div>', 'portalScript.getPortalMsgBox(\"msgbox\")', '1', '1', '2017-8-16 11:46:57', '1', '2017-9-5 17:09:22');
INSERT INTO ins_column_def VALUES ('2400000003411004', '待办列表', 'BpmTask', '1', '1', '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n					<dd id=\"modularTitle\">\n						<span class=\"project_01\">\n							<p>审批环节</p>\n						</span>\n						<span class=\"project_02\">\n							<p>事项</p>\n						</span>\n						<span class=\"project_03\">\n							<p>日期</p>\n						</span>\n						<span class=\"project_04\">\n							<p>操作</p>\n						</span>\n						<div class=\"clearfix\"></div>\n					</dd>\n					<#list data.obj as obj>\n						<dd>\n							<span class=\"project_01\">\n								<a href=\"###\">${obj.name}</a>\n							</span>\n							<span class=\"project_02\">\n								<a href=\"${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}\" target=\"_blank\">${obj.description}</a>\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n							<span class=\"project_04\">\n								<a href=\"${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}\" target=\"_blank\">操作</a>\n							</span>\n							<div class=\"clearfix\"></div>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalBpmTask(colId)', '1', '1', '2017-8-16 16:15:10', '1', '2017-9-5 18:10:01');
INSERT INTO ins_column_def VALUES ('2400000004011000', '公司公告', 'news', '1', '1', '<div id=\"news\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n						<#list data.obj as obj>\n						<dd>\n							<p><a href=\"${ctxPath}/oa/info/insNews/get.do?permit=no&pkId=${obj.newId}\" target=\"_blank\">${obj.subject}</a></p>\n						</dd>\n						</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalNews(colId)', '1', '1', '2017-8-21 17:15:08', '1', '2017-9-5 11:13:12');
INSERT INTO ins_column_def VALUES ('2400000004021000', '我的消息', 'myMsg', '1', '1', '<div id=\"myMsg\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n						<#list data.obj as obj>\n						<dd>\n							<p><a href=\"${ctxPath}/oa/info/infInbox/recPortalGet.do?pkId=${obj.msgId}\" target=\"_blank\">${obj.content}</a></p>\n						</dd>\n						</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalMsg(colId)', '1', '1', '2017-8-21 17:47:32', '1', '2017-9-5 11:13:09');
INSERT INTO ins_column_def VALUES ('2400000004021001', '外部邮件', 'outMail', '1', '1', '<div id=\"outMail\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n						<#list data.obj as obj>\n						<dd>\n							<p><a href=\"${ctxPath}/oa/mail/outMail/get.do?isHome=YES&pkId=${obj.mailId}\" target=\"_blank\">${obj.subject}</a></p>\n						</dd>\n						</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalOutEmail(colId)', '1', '1', '2017-8-21 18:17:03', '1', '2017-9-5 11:13:05');

INSERT INTO ins_portal_def VALUES ('2400000007579001', '全局门户', 'GLOBAL-PERSONAL', 'YES', '', '<div class=\"container-fluid\">\n	<div class=\"row-fluid\">\n		<div class=\"span12\">\n			<div>\n				<div id=\"myTask\" class=\"colId_2400000003411004\"></div>\n			</div>\n		</div>\n	</div>\n</div>', '1', '1', '2017-8-30 09:12:15', '1', '2017-8-30 10:56:32', 00000000000000000000);

INSERT INTO ins_portal_permission VALUES ('2400000007659000', '2400000007579001', 'ALL', 'ALL', '1', '1', '2017-8-30 18:10:28', '1', '2017-8-30 18:10:28');

INSERT INTO ins_msg_def VALUES ('2400000007699002', '1', '/bpm/core/bpmTask/myList.do', ' icon-bpm-task-50', '我的待办', '1', '1', '2017-8-31 15:06:34', '1', '2017-9-7 12:23:12', 'mysql', 'mysql', 'import com.redxun.saweb.context.ContextUtil;\r\n\r\nString userId = ContextUtil.getCurrentUserId();\r\nString sql=\"select count(*) from act_ru_task where assignee_=\"+userId ;\r\nreturn sql;\r\n', 'sql');
INSERT INTO ins_msg_def VALUES ('2400000008039000', NULL, '/bpm/core/bpmTask/myList.do', ' icon-list-50', '我的待办2', '1', '1', '2017-9-4 18:02:39', '1', '2017-9-7 12:23:07', 'mysql', 'mysql', 'import com.redxun.saweb.context.ContextUtil;\r\n\r\nString userId = ContextUtil.getCurrentUserId();\r\nString sql=\"select count(*) from act_ru_task where assignee_=\"+userId ;\r\nreturn sql;\r\n', 'sql');

INSERT INTO ins_msgbox_def VALUES ('2400000007849001', '', 'msgbox', '消息盒', '1', '1', '2017-9-1 15:36:19', '1', '2017-9-1 15:36:19');
INSERT INTO ins_msgbox_def VALUES ('2400000008039002', NULL, 'personalTask', '个人待办', '1', '1', '2017-9-4 18:05:25', '1', '2017-9-4 18:05:25');
INSERT INTO ins_msgbox_def VALUES ('2400000008039007', NULL, 'baseInfo', '基础信息', '1', '1', '2017-9-4 18:12:05', '1', '2017-9-4 18:12:05');

INSERT INTO ins_msgbox_box_def VALUES ('1', '2017-9-4 18:09:56', '1', '2017-9-4 18:09:56', '1', '1', '2400000008039000', '2400000008039002', '2400000008039005');
INSERT INTO ins_msgbox_box_def VALUES ('1', '2017-9-4 18:14:07', '1', '2017-9-4 18:14:07', '1', '1', '2400000008039000', '2400000008039007', '2400000008039008');
INSERT INTO ins_msgbox_box_def VALUES ('2', '2017-9-4 18:14:07', '1', '2017-9-4 18:14:07', '1', '1', '2400000007699002', '2400000008039007', '2400000008039009');
INSERT INTO ins_msgbox_box_def VALUES ('1', '2017-9-5 17:09:47', '1', '2017-9-5 17:09:47', '1', '1', '2400000008039000', '2400000007849001', '2400000008149000');
INSERT INTO ins_msgbox_box_def VALUES ('2', '2017-9-5 17:09:47', '1', '2017-9-5 17:09:47', '1', '1', '2400000007699002', '2400000007849001', '2400000008149001');


---------------------------------add by cmc 系统参数条目增加 20170911--------------------------------------------------------------------

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES
	('2400000008609000', 'redis最大连接池', 'redis.maxTotal', 'YES', 'NO', '20', '系统参数', 'redis最大连接池', '1', '1', '2017-09-11 09:57:24', '1', '2017-09-11 09:57:24'),
	('2400000008609001', 'redis最小连接', 'redis.minIdle', 'YES', 'NO', '10', '系统参数', 'redis最小连接', '1', '1', '2017-09-11 10:00:37', '1', '2017-09-11 10:00:37'),
	('2400000008609002', 'redis端口', 'redis.port', 'YES', 'NO', '6379', '系统参数', 'redis端口', '1', '1', '2017-09-11 10:05:54', '1', '2017-09-11 10:05:54'),
	('2400000008609003', 'redisIP', 'redis.ip', 'YES', 'NO', '192.168.1.110', '系统参数', 'redisID', '1', '1', '2017-09-11 10:16:34', '1', '2017-09-11 10:16:34');

	
----------------------------------add by cmc 系统机构关系表 20170913------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: SYS_TYPE_SUB_REF                                      */
/*==============================================================*/
CREATE TABLE SYS_TYPE_SUB_REF
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键ID',
   INST_TYPE_ID_        VARCHAR(64) COMMENT '机构类型ID',
   SUB_SYS_ID_          VARCHAR(64) COMMENT '子系统ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用用户Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_TYPE_SUB_REF COMMENT '机构--子系统关系';


insert into sys_type_sub_ref  (id_,Inst_type_id_,sub_sys_id_,tenant_id_)   select a.SYS_ID_,b.TYPE_ID_, a.SYS_ID_,a.TENANT_ID_ from sys_subsys  a, sys_inst_type b where a.inst_type_=b.TYPE_CODE_ 


-- add by zhw 2017-09-15 增加自定义门户字段
alter table ins_portal_def add edit_html_ text;

-----------------------------------add by cmc 创建系统操作日志表-------------------------------------------------------------------------------
/*==============================================================*/
/* Table: LOG_ENTITY                                            */
/*==============================================================*/
CREATE TABLE LOG_ENTITY
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID_',
   MODULE_              VARCHAR(128) COMMENT '所属模块',
   SUB_MODULE_          VARCHAR(128) COMMENT '功能',
   ACTION_              VARCHAR(128) COMMENT '操作名',
   IP_                  VARCHAR(128) COMMENT '操作IP',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE LOG_ENTITY COMMENT '日志实体';


/*==============================================================*/
/* Table: LOG_MODULE                                            */
/*==============================================================*/
CREATE TABLE LOG_MODULE
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID_',
   MODULE_              VARCHAR(128) COMMENT '模块',
   SUB_MODULE           VARCHAR(128) COMMENT '子模块',
   PRIMARY KEY (ID_)
);

ALTER TABLE LOG_MODULE COMMENT '日志模块';



-------------------------------------------add by cmc 20170925------------------------------------------------------------------------
ALTER TABLE log_entity
	ADD COLUMN TARGET_ TEXT NULL DEFAULT NULL COMMENT '操作目标' AFTER IP_;

ALTER TABLE log_module
	ADD COLUMN ENABLE_ VARCHAR(64) NULL COMMENT '启用' AFTER SUB_MODULE;
	
-------------------------------------------add by zyg 20170926------------------------------------------------------------------------
	CREATE TABLE BPM_OPINION_TEMP
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   TYPE_                VARCHAR(20) COMMENT '类型(inst,task)',
   INST_ID_             VARCHAR(64) COMMENT '任务或实例ID',
   OPINION_             VARCHAR(1000) COMMENT '意见',
   ATTACHMENT_          VARCHAR(1000) COMMENT '附件',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_OPINION_TEMP COMMENT '流程临时意见';

--------------------------------------------add by cmc 20170927 修改sysFile表增加pdf副本状态---------------------------------------------------------------------------------------
ALTER TABLE sys_file
	ADD COLUMN COVER_STATUS_ VARCHAR(20) NULL DEFAULT NULL COMMENT '是否已经有pdf副本' AFTER FROM_;



-------------------------------------------add by zyg 20170927 增加流程实例------------------------------------------------------------------------
ALTER TABLE bpm_remind_inst
ADD COLUMN ACT_INST_ID_  varchar(64) NULL COMMENT '流程实例ID' AFTER SOLUTION_NAME_;

-------------------------------------------add by zhw 20170927 增加流程实例------------------------------------------------------------------------
ALTER TABLE ins_column_def
ADD COLUMN is_news_  varchar(20) NULL COMMENT '是否为新闻公告栏目';

-------------------------------------------add by zhy 20171011 增加初始化数据------------------------------------------------------------------------
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, IS_MGR_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
VALUES ('2400000000761000', '210000000418012', '系统操作日志模块', 'logModule', NULL, NULL, NULL, ' icon-changjianyijian', NULL, '1', NULL, NULL, 10, 'NO', '/sys/log/logModule/list.do', 'URL', 'NO', '0',  NULL, 1, NULL, NULL, NULL);

INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, IS_MGR_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
VALUES ('2400000000761002', '210000000418012', '系统操作日志流水', 'logEntity', NULL, NULL, NULL, ' icon-articleAD', NULL, '1', NULL, NULL, 11, 'NO', '/sys/log/logEntity/list.do', 'URL', 'NO', '0',  NULL, 1, NULL, NULL, NULL);

INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, IS_MGR_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
VALUES ('2400000000821000', '210000000418012', 'openoffice服务开关', 'openoffice', NULL, NULL, NULL, ' icon-card', NULL, '1', NULL, NULL, 12, 'NO', '/sys/core/sofficeServiceSwitch.do ', 'URL', 'NO', '0',  NULL, 1, NULL, NULL, NULL);

INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, IS_MGR_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
VALUES ('2400000001141094', '210000000418012', '项目文档列表', 'proItemList', NULL, NULL, NULL, ' icon-articleAD', NULL, '1', 2, '210000000418012.1.2400000001141094.', 13, 'NO', '/oa/article/proItem/list.do', 'URL', 'NO', '0',  NULL, 1, NULL, NULL, NULL);


--------------------------------------------add by cmc 20170929 新增项目文章--------------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: PRO_ITEM                                              */
/*==============================================================*/
CREATE TABLE PRO_ITEM
(
   ID                   VARCHAR(64) NOT NULL COMMENT 'ID_',
   NAME_                VARCHAR(128) COMMENT '项目名',
   DESC_                TEXT COMMENT '描述',
   VERSION_             VARCHAR(64) COMMENT '版本',
   GEN_SRC_             VARCHAR(512) COMMENT '文档生成路径',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID)
);

ALTER TABLE PRO_ITEM COMMENT '项目';


/*==============================================================*/
/* Table: PRO_ARTICLE                                           */
/*==============================================================*/
CREATE TABLE PRO_ARTICLE
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID_',
   BELONG_PRO_ID_       VARCHAR(64) COMMENT '所属项目ID',
   TITLE_               VARCHAR(128) COMMENT '标题',
   AUTHOR_              VARCHAR(64) COMMENT 'AUTHOR_',
   OUT_LINE_            VARCHAR(64) COMMENT '概要',
   TYPE_            	VARCHAR(64) COMMENT '类型',
   PARENT_ID_           VARCHAR(64) COMMENT '父ID',
   SN_                  VARCHAR(64) COMMENT '序号',
   CONTENT_             TEXT COMMENT '内容',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   PRIMARY KEY (ID_)
);

ALTER TABLE PRO_ARTICLE COMMENT '文章';

-- 2017-10-17 子表权限设置
ALTER TABLE sys_customform_setting
ADD COLUMN TABLE_RIGHT_JSON_  varchar(1000) NULL COMMENT '子表权限' ;

-------------------------------------add by cmc 20171019 openoffice转换文档系统参数初始化------------------------------------------------------
INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES
	('2400000010149000', 'OpenOffice_HOME路径', 'OpenOffice_HOME', 'YES', 'NO', 'C:/Program Files (x86)/OpenOffice 4/', '系统参数', '', '1', '1', '2017-09-26 16:16:15', '1', '2017-09-26 16:23:33'),
	('2400000010149003', 'openoffice服务IP', 'openoffice.ip', 'YES', 'NO', '127.0.0.1', '系统参数', '', '1', '1', '2017-09-26 16:25:13', '1', '2017-09-26 16:25:13'),
	('2400000010149005', 'openoffice服务端口', 'openoffice.port', 'YES', 'NO', '8100', '系统参数', '', '1', '1', '2017-09-26 16:26:12', '1', '2017-09-26 16:26:12'),
	('2400000010409000', 'openOffice服务开关参数', 'openOfficeSwitch', 'YES', 'NO', 'false', '系统参数', '', '1', '1', '2017-09-29 09:05:33', '1', '2017-09-29 09:05:33'),
	('2400000010949012', '是否启用openOffice转换', 'openoffice', 'YES', 'NO', 'YES', '系统参数', '', '1', '1', '2017-10-12 11:41:35', '1', '2017-10-12 14:22:38');

-------------------------------------add by zhy 20171019 管理员系统参数初始化------------------------------------------------------
INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('10001','管理帐号','adminAccount','YES','NO','admin','系统参数','','1');

-- 2017-10-24 门户栏目增加字段
ALTER TABLE ins_column_def
ADD COLUMN IS_NEWS_  varchar(32) NULL COMMENT '是否公告类型栏目' ;

-- 2017-10-31 流程方案增加是否支持手机表单。
ALTER TABLE bpm_solution
ADD COLUMN SUPPORT_MOBILE_  int NULL DEFAULT 0 COMMENT '支持手机端表单' AFTER DATA_SAVE_MODE_;

-- 2017-10-31 流程方案增加是否支持手机表单。
update bpm_solution     set SUPPORT_MOBILE_=0   ;

update bpm_solution a   set SUPPORT_MOBILE_=1   where exists (select 1 from bpm_sol_fv b
where b.SOL_ID_=a.SOL_ID_ and (b.MOBILE_FORMS_ is not null or b.MOBILE_FORMS_<>''))

------------------------------------------add by cmc 20171106 添加表单显示参数-----------------------------------------------------------------------
ALTER TABLE bpm_form_view
	ADD COLUMN DISPLAY_TYPE_ VARCHAR(64) NULL DEFAULT NULL COMMENT 'tab展示模式normal first' AFTER TEMPLATE_ID_;

-- 2017-11-1 流程实例增加是否支持手机表单。
ALTER TABLE bpm_inst
ADD COLUMN SUPPORT_MOBILE_  int NULL DEFAULT 0 COMMENT '支持手机端' AFTER BO_DEF_ID_;

update bpm_inst     set SUPPORT_MOBILE_=0   ;

update bpm_inst a   set SUPPORT_MOBILE_=1   where exists (select 1 from bpm_solution b
where b.SOL_ID_=a.SOL_ID_ and b.SUPPORT_MOBILE_=1 )

------------------------------------------add by zhw 20171106 添加新闻公告权限-----------------------------------------------------------------------
ALTER TABLE ins_news
	ADD COLUMN FILES_ VARCHAR(512) NULL DEFAULT NULL COMMENT '附件';

CREATE TABLE INS_NEWS_CTL
(
   CTL_ID_              VARCHAR(64) NOT NULL,
   NEWS_ID_             VARCHAR(64),
   USER_ID_             VARCHAR(512),
   GROUP_ID_            VARCHAR(512),
   RIGHT_               VARCHAR(16) NOT NULL COMMENT '权限分类，CHECK还是DOWN',
   TYPE_                VARCHAR(16) NOT NULL COMMENT '权限的类型，ALL还是LIMIT',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (CTL_ID_)
);

ALTER TABLE INS_NEWS_CTL COMMENT '新闻公告权限表';

--------------------------------------------add by zwc 20171109 新增留言板--------------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: BPM_MESSAGE_BOARD                                     */
/*==============================================================*/
CREATE TABLE BPM_MESSAGE_BOARD
(
   ID_                  VARCHAR(64) NOT NULL,
   INST_ID_             VARCHAR(64) COMMENT '流程实例ID',
   MESSAGE_AUTHOR_      VARCHAR(64) COMMENT '留言用户',
   MESSAGE_AUTHOR_ID_   VARCHAR(64) COMMENT '留言用户ID',
   MESSAGE_CONTENT_     TEXT COMMENT '留言消息',
   FILE_ID_             VARCHAR(64) COMMENT '附件ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATE COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATE COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE BPM_MESSAGE_BOARD COMMENT '流程沟通留言板';

-- 增加手机表单模版
ALTER TABLE sys_bo_list
ADD COLUMN MOBILE_HTML_  text NULL COMMENT '手机表单模版' ;


 alter table sys_bo_list add data_style_ varchar(20);
 alter table sys_bo_list add row_edit_ varchar(20); 

alter table bpm_inst add bill_no_ varchar(255);

-- zyg 2017-11-29 表单方案设定增加手机表单关联配置，在自定义列表中使用 
alter table sys_customform_setting add MOBILE_FORM_ALIAS_ varchar(64) COMMENT '手机表单模版别名';
alter table sys_customform_setting add MOBILE_FORM_NAME_ varchar(64)  COMMENT '手机表单模版名称';
 
-- zyg 2017-11-29 菜单增加关联BO列表字段，方便查找自定义列表。
ALTER TABLE sys_menu
ADD COLUMN BO_LIST_ID_  varchar(255) NULL COMMENT 'BO列表ID' AFTER UPDATE_TIME_;

-- zhy 2017-12-06 删除菜单IS_MGR_。
alter table sys_menu drop column IS_MGR_;

-- zyg 2017-12-07 增加ueditor 图片最大宽度配置。
INSERT INTO sys_properties VALUES ('2400000001561008', ' UEDITOR上传图片最大宽度', 'ueditor_upload_img_maxsize', 'YES', 'NO', '900', '上传参数', '', '1', '1', '2017-12-06 22:58:19', '1', '2017-12-06 23:04:00');
INSERT INTO sys_properties VALUES ('2400000001581001', '功能面板集显示', 'menuDisplay', 'YES', 'NO', 'tab', '系统参数', '显示方式分为tab和block方式', '1', '1', '2017-12-07 11:43:59', '1', '2017-12-07 11:43:59');

-- zhy 2017-12-07 流程产生单号。
INSERT INTO SYS_SEQ_ID (SEQ_ID_, NAME_, ALIAS_, CUR_DATE_, RULE_, RULE_CONF_, INIT_VAL_, GEN_TYPE_, LEN_, CUR_VAL, STEP_, MEMO_, IS_DEFAULT_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2400000001031001', '流程实例单号', 'BPM_INST_BILL_NO', '2017-12-3 12:15:47', '{yyyyMMdd}{NO}', '[{\"_id\":1,\"_uid\":1,\"_state\":\"added\",\"type\":\"{yyyyMMdd}\"},{\"_id\":2,\"_uid\":2,\"_state\":\"added\",\"type\":\"{NO}\"}]', 1, 'DAY', 5, 2, 1, '用于产生流程实例单号，由系统初始化，不允许删除', 'YES', '0', '1', '2017-11-26 13:22:44', '1', '2017-12-3 12:16:19');

alter table act_ru_task add run_path_id_ varchar(64);

-----------------add by cmc 20171205 添加表单方案分类---------------------------------------------------------------
ALTER TABLE sys_customform_setting
	ADD COLUMN TREE_ID_ VARCHAR(64) NOT NULL COMMENT '分类ID' AFTER ID_;
	
INSERT INTO sys_tree_cat (CAT_ID_, KEY_, NAME_, SN_, DESCP_, TENANT_ID_) VALUES ('11', 'CAT_FORMSOLUTION', '表单方案分类', 1, '表单方案分类', '0');


-- zhw 2017-12-11 表单增加PDF模板
ALTER TABLE bpm_form_view
ADD COLUMN PDF_TEMP_  text NULL COMMENT 'PDF模板' AFTER UPDATE_TIME_;

-- zwc 2017-12-11 企业微信同步平台组织架构
ALTER TABLE os_group
ADD COLUMN WX_PARENT_PID_  int(11) NULL COMMENT '微信内部维护父部门ID' AFTER SYNC_WX_,
ADD COLUMN WX_PID_  int(11) NULL COMMENT '微信平台部门唯一ID' AFTER WX_PARENT_PID_;

-------------------add by cmc 20171214 添加初始化数据--------------------------------------------------------------------------------------------------
INSERT INTO sys_tree_cat (CAT_ID_, KEY_, NAME_, SN_, DESCP_, TENANT_ID_, CREATE_BY_) VALUES ('12', 'CAT_CUSTOMATTRIBUTE', '自定义属性分类', 1, '自定义属性分类', '0', '1');

-------------------add by cmc 20171215 添加自定义属性表-------------------------------------------------------------------------
CREATE TABLE OS_CUSTOM_ATTRIBUTE
(
   ID                   VARCHAR(64) NOT NULL COMMENT 'ID_',
   ATTRIBUTE_NAME_      VARCHAR(64) COMMENT '属性名称',
   KEY_                 VARCHAR(64) COMMENT 'KEY_',
   ATTRIBUTE_TYPE_      VARCHAR(64) COMMENT '属性类型',
   TREE_ID_             VARCHAR(64) COMMENT '分类ID_',
   WIDGET_TYPE_         VARCHAR(64) COMMENT '控件类型',
   VALUE_SOURCE_        VARCHAR(64) COMMENT '值来源',
   DIM_ID_              VARCHAR(64) COMMENT '维度ID',
   TENANT_ID_           VARCHAR(64) COMMENT '机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE OS_CUSTOM_ATTRIBUTE COMMENT '自定义属性';


CREATE TABLE OS_ATTRIBUTE_VALUE
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID',
   VALUE_               VARCHAR(256) COMMENT '参数值',
   TARGET_ID_           VARCHAR(64) COMMENT '目标ID',
   TENANT_ID_           VARCHAR(64) COMMENT '机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE OS_ATTRIBUTE_VALUE COMMENT '人员属性值';


-- add by zwc 2017-12-19 机构类型菜单---------------------------------------------------------------
create table SYS_INST_TYPE_MENU
(
   ID_                  varchar(64) not null,
   INST_TYPE_ID_    varchar(64) comment '机构类型ID',
   SYS_ID_              varchar(64) comment '子系统ID',
   MENU_ID_             varchar(64) comment '菜单ID',
   primary key (ID_)
);

alter table SYS_INST_TYPE_MENU comment '机构类型授权菜单';


-------------------------------------add by cmc 20171219 修改属性表-------------------------------------------------------------
ALTER TABLE os_attribute_value
	ADD COLUMN ATTRIBUTE_ID_ VARCHAR(256) NULL DEFAULT NULL COMMENT '属性ID' AFTER VALUE_;
	
ALTER TABLE os_custom_attribute
	ADD COLUMN SOURCE_TYPE_ VARCHAR(64) NULL DEFAULT NULL COMMENT '来源类型' AFTER VALUE_SOURCE_;

ALTER TABLE os_custom_attribute
	CHANGE COLUMN VALUE_SOURCE_ VALUE_SOURCE_ TEXT NULL DEFAULT NULL COMMENT '值来源' AFTER WIDGET_TYPE_;
	
-------------------------------------add by cmc 20171229------------------------------------------------------------------------
ALTER TABLE sys_file
	CHANGE COLUMN TOTAL_BYTES_ TOTAL_BYTES_ BIGINT NULL DEFAULT NULL COMMENT '总字节数' AFTER DESC_;

-- add by zhy 2018-01-08 修改bpm_form_view表DESCP_字段类型---------------------------------------------------------------
alter table bpm_form_view  modify column DESCP_ VARCHAR(500) NULL;

alter table bpm_ru_path add timeout_status_ varchar(20);

alter table act_ru_task add timeout_status_ varchar(20);


-- add by zwc 2018-1-9 签到增加距离
ALTER TABLE hr_duty_register
ADD COLUMN DISTANCE_  int(10) NULL AFTER SIGNREMARK_;

-- add by zwc 2018-1-11 手机目录系统参数
INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('5940000000000251', '手机项目路径', 'mobile.path', 'YES', 'NO', '/jsaas_ent/vuemobile/index.html', '系统参数', '手机编译项目所在路径', '1', '1', '2018-01-11 15:10:05', '1', '2018-01-11 15:12:57');

-------------------------------------add by cmc 20180112 新增自定义表单[常用联系人]-----------------------------------------------------------------
CREATE TABLE w_topcontacts (
	ID_ VARCHAR(64) NOT NULL DEFAULT '' COMMENT '主键',
	REF_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '外键',
	F_LXRFL VARCHAR(50) NULL DEFAULT NULL COMMENT '联系人分类ID',
	F_LXRFL_NAME VARCHAR(50) NULL DEFAULT NULL COMMENT '联系人分类',
	F_LXR VARCHAR(50) NULL DEFAULT NULL COMMENT '联系人ID',
	F_LXR_NAME VARCHAR(50) NULL DEFAULT NULL COMMENT '联系人',
	INST_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '流程实例ID',
	INST_STATUS_ VARCHAR(20) NULL DEFAULT NULL COMMENT '状态',
	CREATE_USER_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '用户ID',
	CREATE_GROUP_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '组ID',
	TENANT_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '租户ID',
	CREATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '创建时间',
	UPDATE_TIME_ DATETIME NULL DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY (ID_)
)
COMMENT='常用联系人'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

-- zyg 2018-1-17 office控件 版本管理
CREATE TABLE sys_office (
  ID_ varchar(64) NOT NULL DEFAULT '',
  NAME_ varchar(200) DEFAULT NULL,
  SUPPORT_VERSION_ varchar(64) DEFAULT NULL,
  VERSION_ int(11) DEFAULT NULL,
  TENANT_ID_ varchar(64) DEFAULT NULL,
  CREATE_BY_ varchar(64) DEFAULT NULL,
  CREATE_TIME_ datetime DEFAULT NULL,
  UPDATE_BY_ varchar(64) DEFAULT NULL,
  UPDATE_TIME_ datetime DEFAULT NULL,
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OFFICE附件';

CREATE TABLE sys_office_ver (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  OFFICE_ID_ varchar(64) DEFAULT NULL COMMENT 'OFFICE主键',
  VERSION_ int(11) DEFAULT NULL COMMENT '版本',
  FILE_ID_ varchar(64) DEFAULT NULL COMMENT '附件ID',
  FILE_NAME_ varchar(200) DEFAULT NULL COMMENT '文件名',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OFFICE版本';

---------------------------------------add by cmc 20180117 新增登录登出日志-----------------------------------------------------------------
/*==============================================================*/
/* Table: SYS_LOG_IN_OUT                                        */
/*==============================================================*/
CREATE TABLE SYS_LOG_IN_OUT
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   OPERATOR_ID_         VARCHAR(64) COMMENT '操作人',
   LOGIN_TIME_          DATETIME COMMENT '登录时间',
   LOGOUT_TIME_         DATETIME COMMENT '登出时间',
   LOG_IP_              VARCHAR(64) COMMENT '登录IP',
   USER_AGENT_          VARCHAR(1024) COMMENT '设备信息',
   MAIN_GROUP_NAME_     VARCHAR(128) COMMENT '主部门',
   DURATION_            BIGINT COMMENT '持续时长',
   TENANT_ID_           VARCHAR(64) COMMENT '租用用户Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_LOG_IN_OUT COMMENT '登录登出日志';

--------------------------------------add by cmc 20180118 添加字段-----------------------------------------------------------
ALTER TABLE sys_log_in_out
	ADD COLUMN MAIN_GROUP_ VARCHAR(128) NULL DEFAULT NULL COMMENT '主部门ID' AFTER MAIN_GROUP_NAME_;
	
--------------------------------------add by cmc 20180120  添加字段将登陆登出日志和操作日志合并-------------------------------
ALTER TABLE log_entity
	ADD COLUMN USER_AGENT_ VARCHAR(1024) NULL DEFAULT NULL COMMENT '设备信息' AFTER IP_;
ALTER TABLE log_entity
	ADD COLUMN MAIN_GROUP_NAME_ VARCHAR(500) NULL COMMENT '主部门名' AFTER TARGET_;
ALTER TABLE log_entity
	ADD COLUMN MAIN_GROUP_ VARCHAR(64) NULL DEFAULT NULL COMMENT '主部门ID' AFTER MAIN_GROUP_NAME_;
ALTER TABLE log_entity
	ADD COLUMN DURATION_ BIGINT NULL DEFAULT NULL COMMENT '持续时长' AFTER MAIN_GROUP_;
	
DROP TABLE sys_log_in_out;

RENAME TABLE log_entity TO sys_audit;



------------------------------------add by mansan 20180122   加上自定义单据的数据权限的配置与控制---------------------------------
ALTER table sys_bo_list add data_right_json_ text  COMMENT '数据权限';
alter table os_rel_inst add path_ varchar(1024) COMMENT '路径';
alter table sys_inst add parent_id_ varchar(64) COMMENT '父ID';
alter table sys_inst add path_ varchar(1024) COMMENT '路径';


alter table bpm_inst add start_dep_id_ varchar(64) comment '发起部门Id';
alter table bpm_inst add start_dep_full_ varchar(300) comment '发起部门全名';

alter table bpm_node_jump add handle_dep_id_ varchar(64) comment '处理部门Id';
alter table bpm_node_jump add handle_dep_full_ varchar(300) comment '处理部门全名';

------------------------------------add by zyg 20180123   实体扩展数据---------------------------------
ALTER TABLE sys_bo_entity
ADD COLUMN EXT_JSON_  varchar(1000) NULL COMMENT '扩展配置数据' ;

------------------------------------add by zyg 20180130   office模板------------------------
CREATE TABLE sys_office_template (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  NAME_ varchar(200) DEFAULT NULL COMMENT '名称',
  TYPE_ varchar(20) DEFAULT NULL COMMENT '类型(normal,red)',
  DOC_ID_ varchar(200) DEFAULT NULL COMMENT '文档ID',
  DOC_NAME_ varchar(200) DEFAULT NULL COMMENT '文件名',
  DESCRIPTION_ varchar(255) DEFAULT NULL COMMENT '描述',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
)  DEFAULT CHARSET=utf8 COMMENT='office模板';


------------------------------------add by zyg 20180131   office模板初始化语句------------------------
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2500000000021001', '210000000418012', 'office模板', 'sysOfficeTemplate', NULL, NULL, NULL, ' icon-dialog-18', '', '1', 2, '210000000418012.1.2500000000021001.', 14, '/sys/core/sysOfficeTemplate/list.do', 'URL', 'NO', '0', '1', 1, NULL, NULL, NULL);

------------------------------------add by 20180201   BPM_node_jump表修改字段类型------------------------
ALTER TABLE BPM_node_jump MODIFY COLUMN DURATION_ BIGINT;

------------------------------------add by zyg 20180201  印章表表修改字段类型------------------------
CREATE TABLE sys_stamp (
  ID_ varchar(64) NOT NULL,
  NAME_ varchar(200) DEFAULT NULL COMMENT '签章名称',
  SIGN_USER_ varchar(64) DEFAULT NULL COMMENT '签章用户',
  PASSWORD_ varchar(64) DEFAULT NULL COMMENT '签章密码',
  STAMP_ID_ varchar(64) DEFAULT NULL COMMENT '印章文件ID',
  DESCRIPTION_ varchar(255) DEFAULT NULL COMMENT '描述',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
)   DEFAULT CHARSET=utf8 COMMENT='office印章';

------------------------------------add by  20180202  修改自定义查询字段长度------------------------
ALTER TABLE sys_custom_query MODIFY COLUMN ORDER_FIELD_ varchar(1024) NULL;

------------------------------------add by zyg  20180206  添加sql字段-------------
ALTER TABLE sys_custom_query
ADD COLUMN SQL_  varchar(2000) NULL COMMENT 'SQL' AFTER UPDATE_TIME_;


ALTER TABLE sys_custom_query
MODIFY COLUMN SQL_BUILD_TYPE_  varchar(20) NULL DEFAULT NULL COMMENT 'SQL构建类型' ;

------------------------------------add by   20180207  更改自定义sql表字段数据-------------
UPDATE sys_custom_query SET sql_build_type_='table' where sql_build_type_='0';

UPDATE sys_custom_query SET sql_build_type_='sql' where sql_build_type_='1';

------------------------------------add by cmc 20180211 超时催办rutask增加超时字段--------------------------------------------------------------------------
ALTER TABLE act_ru_task
	ADD COLUMN OVERTIME_ TIMESTAMP NULL DEFAULT NULL COMMENT '超时时刻' AFTER timeout_status_,
	ADD COLUMN OVERTIME_ZONE_ VARCHAR(64) NULL DEFAULT NULL COMMENT '超时设定的时长' AFTER OVERTIME_;
	

alter table sys_bo_list add  START_FRO_COL_ int ;

alter table sys_bo_list add  END_FRO_COL_ int ;

alter table sys_bo_list add  SHOW_SUMMARY_ROW_ varchar(20) ;

------------------------------------add by cmc 20180226 超时催办rutask修改超时字段--------------------------------------------------------------------------
ALTER TABLE act_ru_task
	CHANGE COLUMN OVERTIME_ OVERTIME_ TEXT NULL DEFAULT NULL COMMENT '超时时刻' AFTER timeout_status_;
ALTER TABLE act_ru_task
	DROP COLUMN OVERTIME_ZONE_;
	

	

------------------------------------add by cmc 20180227 报表修改字段--------------------------------------------------------------------------
ALTER TABLE sys_report
	ALTER DESCP_ DROP DEFAULT;
ALTER TABLE sys_report
	CHANGE COLUMN DESCP_ DESCP_ VARCHAR(500) NULL COMMENT '描述' AFTER KEY_;	
	------------------------------------add by cmc 20180227 超时修改字段--------------------------------------------------------------------------
ALTER TABLE act_ru_task
	DROP COLUMN OVERTIME_;
ALTER TABLE act_ru_task
	ADD COLUMN OVERTIME_ VARCHAR(2000) NULL DEFAULT NULL COMMENT '超时' AFTER timeout_status_;


------------------------------------add by zwc 20180301 修改栏目模板字段长度--------------------------------------------------------------
ALTER TABLE ins_column_def
MODIFY COLUMN TEMPLET_  varchar(8000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板' AFTER IS_DEFAULT_;

------------------------------------add by zec 20180302	修改门户保存HTML长度
ALTER TABLE ins_portal_def
MODIFY COLUMN EDIT_HTML_  mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '编辑界面HTML字段' AFTER PRIORITY_;


------------------------------------add by zyg 20180308 增加是否树形--------------------------------------------------------------------------
ALTER TABLE sys_bo_entity
ADD COLUMN TREE_  varchar(20) NULL COMMENT '是否树形(YES,NO)';

alter table os_group add area_code_ varchar(50);


------------------------------------add by zyg 20180316 增加表单权限--------------------------------------------------------------------------
CREATE TABLE bpm_form_right (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  SOL_ID_ varchar(64) DEFAULT NULL COMMENT '解决方案',
  ACT_DEF_ID_ varchar(64) DEFAULT NULL COMMENT '流程定义ID',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '节点ID',
  FORM_ALIAS_ varchar(64) DEFAULT NULL COMMENT '表单名称',
  JSON_ text COMMENT '权限设定',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  UPDATE_BY_ varchar(255) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) 

------------------------------------add by zyg 20180316 删除之前的表单权限--------------------------------------------------------------------------
drop table bpm_fv_right;
ALTER TABLE bpm_form_right
ADD COLUMN BODEF_ID_  varchar(64) NULL COMMENT '';

------------------------------------add by zwc 2018-4-3 增大解决方案绑定业务模型ID长度
ALTER TABLE bpm_solution
MODIFY COLUMN BO_DEF_ID_  varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'BO定义ID' AFTER FORMAL_;


CREATE TABLE bpm_jump_rule (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  NAME_ varchar(200) DEFAULT NULL COMMENT '规则名',
  SOL_ID_ varchar(64) DEFAULT NULL COMMENT '解决方案ID',
  ACTDEF_ID_ varchar(64) DEFAULT NULL COMMENT '流程定义ID',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '节点ID',
  NODE_NAME_ varchar(200) DEFAULT NULL COMMENT '源节点名称',
  TARGET_ varchar(64) DEFAULT NULL COMMENT '目标节点',
  TARGET_NAME_ varchar(200) DEFAULT NULL COMMENT '目标节点名称',
  RULE_ varchar(4000) DEFAULT NULL,
  SN_ int(11) DEFAULT NULL COMMENT '序号',
  TYPE_ int(11) DEFAULT NULL COMMENT '规则类型(0,配置,1,脚本)',
  DESCRIPTION_ varchar(200) DEFAULT NULL COMMENT '描述',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程跳转规则';

-- 新闻公告栏目--
CREATE TABLE ins_news_column (
  ID_ varchar(64) NOT NULL default '' COMMENT '主键',
  NAME_ varchar(50) default NULL COMMENT '栏目名称',
  DESCRIPTION_ varchar(200) default NULL COMMENT '描述',
  CREATE_BY_ varchar(64) default NULL COMMENT '用户ID',
  TENANT_ID_ varchar(64) default NULL COMMENT '租户ID',
  CREATE_TIME_ datetime default NULL COMMENT '创建时间',
  UPDATE_TIME_ datetime default NULL COMMENT '更新时间',
  UPDATE_BY_ varchar(64) default NULL,
  PRIMARY KEY  (ID_)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='公告栏目管理';
-- 新闻栏目添加字段栏目ID --
ALTER TABLE ins_news
	ADD COLUMN COLUMN_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '栏目id' AFTER CONTENT_;
	
	
-------add by zwc 2018-5-3---------
/*==============================================================*/
/* Table: BPM_MOBILE_TAG      记录CID和机型                                 			     */
/*==============================================================*/
CREATE TABLE bpm_mobile_tag (
  TAGID_ varchar(64) NOT NULL COMMENT '标识ID主键',
  CID_ varchar(64) DEFAULT NULL COMMENT '每台机器每个APP标识码',
  MOBILE_TYPE_ varchar(32) DEFAULT NULL COMMENT '苹果、安卓、其他',
  ISBAN_ varchar(32) DEFAULT NULL COMMENT '是屏蔽则不发',
  ALIAS_ varchar(64) DEFAULT NULL COMMENT 'CID绑定的别名',
  TAG_ varchar(64) DEFAULT NULL COMMENT 'CID归类使用',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租用机构Id',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人ID',
  CREATE_TIME_ date DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人ID',
  UPDATE_TIME_ date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (TAGID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	

-- add by zwc 2018-5-3 个推系统参数 ------------
INSERT INTO sys_properties(PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('2400000005971000', '个推appId', 'getui.appId', 'YES', 'NO', 'wHZ1SgEQfi8btNdyXL0aw5', '个推参数', '个推appid', '1');

INSERT INTO sys_properties(PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('2400000005971001', '个推appkey', 'getui.appkey', 'YES', 'NO', 'BxVNg9Rnj68NpIIahZnRX1', '个推参数', '个推appkey', '1');

INSERT INTO sys_properties(PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('2400000005971002', '个推appsecret', 'getui.appsecret', 'YES', 'NO', 'QJAWMJ9oCf79QYUZWbAc4A', '个推参数', '个推appsecret', '1');

INSERT INTO sys_properties(PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('2400000005971003', '个推mastersecret', 'getui.mastersecret', 'YES', 'NO', 'LnuXWhVkcn8pPD0lcmjKB8', '个推参数', '个推masterSecret', '1');

INSERT INTO sys_properties(PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_)
values ('2400000005971004', '个推api', 'getui.host', 'YES', 'NO', 'http://sdk.open.api.igexin.com/apiex.htm', '个推参数', '个推api', '1');

-- add by zwc 2018-5-4 09:46:27 静态资源版本 ------------
INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000001170004', '静态资源版本号', 'static_res_ver', 'YES', 'NO', '1', '系统参数', 'js资源更新时，版本号需要手动提升，之后无需清缓存则可做到更新。', '1', '1', '2018-05-04 09:16:41', NULL, NULL);

-- add by lyz 2018-5-10 09:46:27 消息提醒管理数据表 ------------
/*==============================================================*/
/* Table: OA_REMIND_DEF                                         */
/*==============================================================*/
CREATE TABLE OA_REMIND_DEF
(
   ID_                  VARCHAR(64) NOT NULL,
   SUBJECT_             VARCHAR(150) COMMENT '主题',
   URL_                 VARCHAR(500) COMMENT '连接地址',
   TYPE_                VARCHAR(64) COMMENT '设置类型
            FUNC:方法,SQL:SQL,GROOVYSQL',
   SETTING_             TEXT COMMENT 'SQL语句或方法',
   DSALIAS_             VARCHAR(100) COMMENT '数据源别名',
   DESCRIPTION_         VARCHAR(200) COMMENT '描述',
   SN_                  INT COMMENT '序号',
   ENABLED_             INT COMMENT '是否有效
            1.有效0.无效',
   TENANT_ID_           VARCHAR(64) COMMENT '租用机构ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE OA_REMIND_DEF COMMENT '消息提醒';

-- add by lyz 2018-5-10 09:46:27 消息提醒权限数据表 ------------
/*==============================================================*/
/* Table: SYS_OBJECT_AUTH                                       */
/*==============================================================*/
CREATE TABLE SYS_OBJECT_AUTH
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID',
   OBJECT_ID_           VARCHAR(64) COMMENT '授权对象ID',
   TYPE_                VARCHAR(50) COMMENT '类型（group,user,everyone)',
   AUTH_TYPE_           VARCHAR(50) COMMENT '授权类型',
   AUTH_ID_             VARCHAR(64) COMMENT '被授权人ID',
   AUTH_NAME_           VARCHAR(64) COMMENT '授权人名称',
   TENANT_ID_           VARCHAR(64) COMMENT '租用用户Id',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_OBJECT_AUTH COMMENT '系统对象授权';

--add by qxh 文档模板编辑
DROP TABLE IF EXISTS sys_word_template;
CREATE TABLE sys_word_template (
  ID_ varchar(20) NOT NULL COMMENT '主键',
  NAME_ varchar(200) DEFAULT NULL COMMENT '名称',
  TYPE_ varchar(20) DEFAULT NULL COMMENT '数据源(SQL/自定义)',
  BO_DEF_ID_ varchar(64) DEFAULT NULL COMMENT '业务对象ID',
  SETTING_ text COMMENT '设定SQL语句，用于自定义数据源操作表单',
  DS_ALIAS_ varchar(64) DEFAULT NULL COMMENT '数据源',
  TEMPLATE_ID_ varchar(64) DEFAULT NULL COMMENT '模板ID',
  TEMPLATE_NAME_ varchar(200) DEFAULT NULL COMMENT '模板名称',
  DESCRIPTION_ varchar(200) DEFAULT NULL COMMENT '描述',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  BO_DEF_NAME_ varchar(100) DEFAULT NULL COMMENT 'BO定义名称',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SYS_WORD_TEMPLATE【模板表】';

--add by pmz 2018-06-01
ALTER TABLE OD_DOCUMENT
	ADD COLUMN FILES_ VARCHAR(512) NULL DEFAULT NULL COMMENT '附件';
	
-- add by zyg 2018-06-04  增加自定义bo 实体。
ALTER TABLE sys_bo_entity ADD COLUMN IS_MAIN_ int NULL DEFAULT NULL COMMENT '是否主实体';
ALTER TABLE sys_bo_entity ADD COLUMN MAIN_ID_ VARCHAR(64) NULL DEFAULT NULL COMMENT '主实体ID';
ALTER TABLE sys_bo_entity ADD COLUMN GEN_MODE_ VARCHAR(10) NULL DEFAULT NULL COMMENT '生成模式(form,create)';

update sys_bo_entity set GEN_MODE_='form';
update sys_bo_relation set RELATION_TYPE_='onetomany' where RELATION_TYPE_='sub';

-- add by zyg 2018-06-12
alter table sys_bo_entity add pk_field_ varchar(100);
alter table sys_bo_entity add parent_field_ varchar(100);
update sys_bo_entity set pk_field_='ID_';
update sys_bo_entity set parent_field_='REF_ID_';
alter table sys_bo_relation add main_field_ varchar(100);
alter table sys_bo_relation add sub_field_ varchar(100);

-- add by zyg 2018-06-14 增加实例指定人员。
CREATE TABLE bpm_inst_user (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  INST_ID_ varchar(64) DEFAULT NULL COMMENT '流程实例ID',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '节点ID',
  USER_IDS_ varchar(300) DEFAULT NULL COMMENT '人员ID',
  USER_NAMES varchar(300) DEFAULT NULL COMMENT '人员名称',
  ACT_DEF_ID_ varchar(64) DEFAULT NULL COMMENT '流程定义ID',
  IS_SUB_ int(11) DEFAULT NULL COMMENT '是否子实例',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程实例用户设置';
	


-- add by zyg 2018-06-15 增加实例分类。
ALTER TABLE sys_bo_entity
ADD COLUMN CATEGORY_ID_  varchar(64) NULL COMMENT '分类ID';

-- add by zyg 2018-06-23 日志记录。
ALTER TABLE sys_audit ADD COLUMN CREATE_USER_  varchar(64) NULL ;

-- add by hj 2018-06-25 增加权限转移日志
CREATE TABLE sys_transfer_log (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  OP_DESCP_ varchar(64) DEFAULT NULL COMMENT '操作描述',
  AUTHOR_PERSON_ varchar(64) DEFAULT NULL COMMENT '权限转移人',
  TARGET_PERSON_ varchar(64) DEFAULT NULL COMMENT '目标转移人',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限转移日志表';

-- add by hj 2018-06-25 增加权限转移设置
CREATE TABLE sys_transfer_setting (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  NAME_ varchar(64) DEFAULT NULL COMMENT '名称',
  STATUS_ varchar(4) DEFAULT NULL COMMENT '状态',
  SELECT_SQL_ varchar(1000) DEFAULT NULL COMMENT 'SELECTSQL语句',
  UPDATE_SQL_ varchar(1000) DEFAULT NULL COMMENT 'UPDATESQL语句',
  LOG_TEMPLET_ varchar(1000) DEFAULT NULL COMMENT '日志内容模板',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '修改人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '修改时间',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限转移设置表';

----add by qiuyishun 20180626 给项目文档增加别名字段------------------------------------------
ALTER TABLE pro_item
	ADD COLUMN ALIAS_ VARCHAR(64) NULL DEFAULT NULL COMMENT '别名' AFTER CREATE_BY_;
	

-- add by hj 2018-06-29 增加批量审批设置
CREATE TABLE bpm_batch_approval (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  SOL_ID_ varchar(64) DEFAULT NULL COMMENT '流程方案ID',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '节点ID',
  TABLE_NAME_ varchar(64) DEFAULT NULL COMMENT '实体表名称',
  FIELD_JSON_ varchar(4000) DEFAULT NULL COMMENT '字段设置',
  STATUS_ varchar(4) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程批量审批设置表';
	
-- add by zyg 2018-06-27 手机端图标。
ALTER TABLE sys_menu
ADD COLUMN MOBILE_ICON_CLS_  varchar(32) NULL COMMENT '手机图标样式';

-- ADD BY ZYG 2018-06-29 流程启动日志
CREATE TABLE bpm_inst_startlog (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  FROM_SOL_ID_ varchar(64) DEFAULT NULL COMMENT '启动方案',
  FROM_NODE_ID_ varchar(64) DEFAULT NULL COMMENT '启动节点',
  FROM_NODE_NAME_ varchar(200) DEFAULT NULL COMMENT '启动节点',
  FROM_INST_ID_ varchar(64) DEFAULT NULL COMMENT '启动实例',
  FROM_SUBJECT_ varchar(200) DEFAULT NULL COMMENT '启动主题',
  FROM_ACT_DEF_ID_ varchar(64) DEFAULT NULL COMMENT '启动流程定义ID',
  TO_SOL_ID_ varchar(64) DEFAULT NULL COMMENT '被启动方案',
  TO_INST_ID_ varchar(64) DEFAULT NULL COMMENT '被启动实例',
  TO_ACT_INST_ID_ varchar(64) DEFAULT NULL COMMENT '被启动ACT实例',
  TO_SUBJECT_ varchar(200) DEFAULT NULL COMMENT '被启动主题',
  TO_ACT_DEF_ID_ varchar(64) DEFAULT NULL COMMENT '被启动定义ID',
  CREATE_USER_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='启动流程日志';

-- ADD BY HJ 2018-07-03 更改机构表域名字段为空
ALTER TABLE sys_inst MODIFY COLUMN DOMAIN_ VARCHAR(100) DEFAULT NULL COMMENT '公司域名   唯一，用户后续的账号均是以此为缀，如公司的域名为abc.com,管理员的账号为admin@abc.com';

-- ADD BY ZYG 2018-7-5 添加token和aeskey
ALTER TABLE wx_ent_agent
	ADD COLUMN TOKEN_ VARCHAR(64) NULL DEFAULT NULL COMMENT '发送消息TOKEN' ;

ALTER TABLE wx_ent_agent
	ADD COLUMN AESKEY_ VARCHAR(64) NULL DEFAULT NULL COMMENT '发送消息AESKEY' ;
	
-- add by zyg 催办时限处理器
ALTER TABLE bpm_remind_def
ADD COLUMN TIME_LIMIT_HANDLER_  varchar(64) NULL COMMENT '时限计算处理器' AFTER TENANT_ID_;


-- add by zyg 2018-7-17 在临时意见 增加索引。
CREATE INDEX  IDX_OPINIONTEMP_INSTID ON bpm_opinion_temp (INST_ID_, TYPE_);

-- add by zyg 2018-7-17 增加索引
CREATE INDEX IDX_BPMINST_ACTINSTID ON bpm_inst(ACT_INST_ID_);

-- add by zyg 2018-7-17 删除外键
ALTER TABLE bpm_inst DROP FOREIGN KEY BPM_INST_R_DEF;

-- add by zyg 2018-7-25 增加BPM_RU_PATH索引。
create index idx_rupath_actinstid on bpm_ru_path (act_inst_id_);

-- add by hj 2018-7-26 栏目增加是否为公共
ALTER TABLE ins_column_def
	ADD COLUMN IS_PUBLIC_ VARCHAR(4) NULL DEFAULT NULL COMMENT '是否公共栏目' ;

-- add by hj 2018-7-27 注册机构报错修复
ALTER TABLE sys_inst
MODIFY COLUMN NAME_EN_ varchar(256) NULL DEFAULT NULL COMMENT '公司英文名' ;

ALTER TABLE sys_inst
MODIFY COLUMN BUS_LICE_NO_ varchar(50) NULL DEFAULT NULL COMMENT '' ;

ALTER TABLE sys_inst
MODIFY COLUMN INST_NO_ varchar(50) NULL DEFAULT NULL COMMENT '机构编码' ;

-- add by zyg  2018-7-27 方案脚本
ALTER TABLE sys_customform_setting
ADD COLUMN CUSTOM_JS_SCRIPT_  text NULL COMMENT '方案脚本';

-- add by hj 2018-8-6 系统自定义业务管理列表实体增加是否初始化数据
ALTER TABLE SYS_BO_LIST
	ADD COLUMN IS_INIT_DATA_ VARCHAR(64) NULL DEFAULT NULL COMMENT '是否初始化数据' ;
	
CREATE TABLE sys_webreq_def (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  NAME_ varchar(200) DEFAULT NULL COMMENT '名称',
  KEY_ varchar(64) DEFAULT NULL COMMENT 'KEY_',
  URL_ varchar(64) DEFAULT NULL COMMENT '请求地址',
  MODE_ varchar(20) DEFAULT NULL COMMENT '请求方式',
  TYPE_ varchar(20) DEFAULT NULL COMMENT '请求类型',
  DATA_TYPE_ varchar(64) DEFAULT NULL COMMENT '数据类型',
  PARAMS_SET_ varchar(400) DEFAULT NULL COMMENT '参数配置',
  DATA_ varchar(200) DEFAULT NULL COMMENT '传递数据',
  TEMP_ varchar(1000) DEFAULT NULL COMMENT '请求报文模板',
  STATUS_ varchar(20) DEFAULT NULL COMMENT '状态',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='WEB请求调用定义';

-- add by hj 2018-8-10 提升url地址长度
alter table sys_webreq_def modify column url_ varchar(1024);



-- add by zwc 2018-8-23 09:29:50 消息盒子脚本长度
ALTER TABLE ins_msg_def
MODIFY COLUMN SQL_FUNC_  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'SQL语句' AFTER DS_ALIAS_;


-- add by zyg 2018-8-23  流程表间公式映射
CREATE TABLE bpm_formula_mapping (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  SOL_ID_ varchar(64) DEFAULT NULL COMMENT '方案ID',
  ACT_DEF_ID_ varchar(64) DEFAULT NULL COMMENT '流程定义ID',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '节点ID',
  FORMULA_NAME varchar(200) DEFAULT NULL COMMENT '公式名',
  FORMULA_ID_ varchar(64) DEFAULT NULL COMMENT '公式ID',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公式映射';

-- add by zyg 2018-8-23 表间公式
CREATE TABLE bpm_table_formula (
  ID_ varchar(64) NOT NULL,
  NAME_ varchar(256) NOT NULL COMMENT '公式名称',
  DESCP_ varchar(512) DEFAULT NULL COMMENT '公式描述',
  FILL_CONF_ text COMMENT '数据填充配置',
  DS_NAME_ varchar(100) DEFAULT NULL COMMENT '数据源',
  BO_DEF_ID_ varchar(64) NOT NULL COMMENT '数据模板ID',
  ACTION_ varchar(80) DEFAULT NULL COMMENT '表单触发时机\r\n            ',
  TYPE_ varchar(20) DEFAULT NULL COMMENT '表单方案=FORM_SOL\r\n            表单=FORM_VIEW\r\n            业务流程方案=BPM_SOL',
  IS_TEST_ varchar(80) DEFAULT NULL COMMENT '是否开启调试模式',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租用机构Id',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人ID',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人ID',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表间公式';

-- add by zyg 2018-8-23 表单方案表间公式映射。
CREATE TABLE sys_formula_mapping (
  ID_ varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  FORM_SOL_ID_ varchar(64) DEFAULT NULL COMMENT '表单方案ID',
  FORMULA_NAME_ varchar(200) DEFAULT NULL COMMENT '公式名称',
  FORMULA_ID_ varchar(64) DEFAULT NULL COMMENT '公式ID',
  BO_DEF_ID_ varchar(64) DEFAULT NULL COMMENT 'BO定义',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单方案公式映射';


update sys_menu set img_=null ;

alter table ins_column_def add type_ varchar(50);

-- add by hj 2018-8-30 栏目模板管理表+多TAB标签优化
ALTER TABLE ins_column_def
ADD COLUMN TABGROUPS_  text NULL COMMENT 'tab标签组';

CREATE TABLE ins_column_temp (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  NAME_ varchar(64) DEFAULT NULL COMMENT '名称',
  KEY_ varchar(64) DEFAULT NULL COMMENT '标识键',
  TEMPLET_ text COMMENT 'HTML模板',
  IS_SYS_ varchar(4) DEFAULT NULL COMMENT '是否系统预设',
  STATUS_ varchar(4) DEFAULT NULL COMMENT '状态',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '修改人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '修改时间',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '机构ID',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目模板管理表';

insert into ins_column_temp(ID_,NAME_,KEY_,IS_SYS_,STATUS_,TENANT_ID_) values('1','新闻公告','newsNotice','1','1','1');
insert into ins_column_temp(ID_,NAME_,KEY_,IS_SYS_,STATUS_,TENANT_ID_) values('2','图表','chart','1','1','1');
insert into ins_column_temp(ID_,NAME_,KEY_,IS_SYS_,STATUS_,TENANT_ID_) values('3','列表','list','1','1','1');
insert into ins_column_temp(ID_,NAME_,KEY_,IS_SYS_,STATUS_,TENANT_ID_) values('4','tab标签页','tabcolumn','1','1','1');


-- add by zyg 2018-9-2 表单方案不传入参数查询
alter table sys_customform_setting add PARAM_DEF_ varchar(500);

-- add by csx 2018-08-31---
alter table os_user add user_type_ varchar(20);


/*==============================================================*/
/* Table: OS_USER_TYPE                                          */
/*==============================================================*/
CREATE TABLE OS_USER_TYPE
(
   ID_                  VARCHAR(64) NOT NULL,
   CODE_                VARCHAR(50) NOT NULL COMMENT '编码',
   NAME_                VARCHAR(50) NOT NULL COMMENT '名称',
   DESCP_               VARCHAR(500) COMMENT '描述',
   GROUP_ID_            VARCHAR(64),
   CREATE_BY_           VARCHAR(64) COMMENT '创建人ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   TENANT_ID_           VARCHAR(64) COMMENT '机构ID',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人ID',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE OS_USER_TYPE COMMENT '用户类型';


/*==============================================================*/
/* add by Louis                                                 */
/* 2018-09-15                                                   */
/* Table: SYS_ECHARTS_CUSTOM      自定义Echarts图形报表                      */
/*==============================================================*/
CREATE TABLE SYS_ECHARTS_CUSTOM (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  NAME_ varchar(64) DEFAULT NULL COMMENT '名称',
  KEY_ varchar(64) DEFAULT NULL COMMENT '标识名 租户中唯一',
  ECHARTS_TYPE_ varchar(66) DEFAULT NULL COMMENT '图表类型',
  TITLE_FIELD_ varchar(2000) DEFAULT NULL COMMENT 'title字段定义',
  LEGEND_FIELD_ varchar(2000) DEFAULT NULL COMMENT '图例字段定义', 
  XAXIS_FIELD_ varchar(2000) DEFAULT NULL COMMENT 'x轴坐标定义', 
  XAXIS_DATA_FIELD_ text COMMENT 'x轴data定义',
  XY_CONVERT_ int(11) DEFAULT NULL COMMENT 'x轴y轴转换',
  DATA_FIELD_ varchar(2000) DEFAULT NULL COMMENT '结果字段定义',
  SERIES_FIELD_ varchar(2000) DEFAULT NULL COMMENT '系列列表字段定义',
  DETAIL_METHOD_ int(11) DEFAULT NULL COMMENT '数据的使用方式 - 为饼图配置',
  WHERE_FIELD_ text COMMENT '条件字段定义',
  ORDER_FIELD_ varchar(1024) DEFAULT NULL COMMENT '排序字段',
  DS_ALIAS_ varchar(64) DEFAULT NULL COMMENT '数据源名称',
  TABLE_ int(11) DEFAULT NULL COMMENT '是否为表(1,表,0视图)',
  SQL_BUILD_TYPE_ varchar(20) DEFAULT NULL COMMENT 'SQL构建类型',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  SQL_ varchar(2000) DEFAULT NULL COMMENT 'SQL',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义Echarts图形报表';

-- add by Louis 2018-09-29 sys_echarts_custom增加栏位
ALTER TABLE SYS_ECHARTS_CUSTOM ADD COLUMN GRID_FIELD_ VARCHAR(2000) NULL DEFAULT NULL COMMENT 'grid字段定义';
ALTER TABLE SYS_ECHARTS_CUSTOM ADD COLUMN DRILL_DOWN_KEY_ VARCHAR(100) NULL DEFAULT NULL COMMENT '下钻key值';
ALTER TABLE SYS_ECHARTS_CUSTOM ADD COLUMN DRILL_DOWN_FIELD_ VARCHAR(2000) NULL DEFAULT NULL COMMENT '下钻字段定义';
ALTER TABLE SYS_ECHARTS_CUSTOM ADD COLUMN THEME_ VARCHAR(50) NULL DEFAULT NULL COMMENT '主题';

-- add by zyg 2018-10-18 脚本调用配置
CREATE TABLE sys_invoke_script (
  ID_ varchar(64) NOT NULL DEFAULT '',
  CATEGROY_ID_ varchar(64) DEFAULT NULL COMMENT '分类ID',
  NAME_ varchar(64) DEFAULT NULL COMMENT ' 名称',
  ALIAS_ varchar(64) DEFAULT NULL COMMENT '别名',
  CONTENT_ text COMMENT '脚本内容',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='执行脚本配置';

-- add by zyg 2018-11-07 添加明细表单
ALTER TABLE sys_bo_list
ADD COLUMN FORM_DETAIL_ALIAS_  varchar(64) NULL COMMENT '明细表单' AFTER IS_INIT_DATA_;

-- add by zyg 2018-11-8 增加文件系统扩展
ALTER TABLE sys_file
ADD COLUMN FILE_SYSTEM_  varchar(20) NULL COMMENT '文件系统' ;

ALTER TABLE sys_file
ADD COLUMN PDF_PATH_  varchar(100) NULL COMMENT 'PDF路径' ;

-- add by zyg 2018-12-2 添加 子应用 token。
ALTER TABLE SYS_SUBSYS
ADD COLUMN TYPE_  varchar(10) NULL COMMENT '类型(内部外部)' ;

ALTER TABLE SYS_SUBSYS
ADD COLUMN SECRET_  varchar(64) NULL COMMENT '密钥' ;


-- add by mfq 2018-12-6 添加 树id
ALTER TABLE BPM_TABLE_FORMULA
ADD COLUMN TREE_ID_  varchar(64) NULL COMMENT '分类ID' ;

-- add by mfq 2018-12-18 添加 自定义sql，系统流水，手机表单，potal栏目，图形报表 的分类树
alter table sys_seq_id add TREE_ID_ varchar(64) NULL COMMENT '分类ID';
alter table ins_column_def add TREE_ID_ varchar(64) NULL COMMENT '分类ID';
alter table sys_echarts_custom add TREE_ID_ varchar(64) NULL COMMENT '分类ID';

INSERT INTO sys_tree_cat VALUES ('2610000000020010', 'CAT_BPM_FROM', '表间公式分类', 1, '表间公式分类', '1', '1', '2018-12-6', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000240002', 'CAT_CUSTOM_SQL', '自定义sql', 1, '', '1', '1', '2018-12-14', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000250002', 'CAT_SERIAL_NUMBER', '系统流水号', 1, '', '1', NULL, NULL, '1', '2018-12-14');
INSERT INTO sys_tree_cat VALUES ('2610000000260004', 'CAT_PHONE_FORM', '手机表单分类', 1, '', '1', '1', '2018-12-14', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000260015', 'CAT_POTAL_COLUMN', 'potal栏目分类', 1, '', '1', '1', '2018-12-14', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000270002', 'CAT_GRAPHIC_REPORT', '图形报表分类', 1, '', '1', '1', '2018-12-14', NULL, NULL);

-- add by mfq 2018-12-19 补 自定义sql 的treeid
alter table SYS_CUSTOM_QUERY add TREE_ID_ varchar(64) NULL COMMENT '分类ID';


-- add by csx ---------------------20190108----------------------------------
ALTER TABLE sys_inst ADD id_sn_ INT;
alter table sys_inst add COMP_ID_ varchar(64);
alter table os_user modify COLUMN mobile_ varchar(32);
alter table ACT_RU_TASK add SOL_KEY_ varchar(100) null comment '业务解决方案KEY' ;
alter table ACT_RU_TASK add INST_ID_ varchar(100) null comment '流程实例ID' ;
alter table BPM_INST add SOL_KEY_ varchar(100) null comment '业务解决方案KEY' ;





-- add by shengzhongwen 2019-01-14 新增权限分级管理菜单 begin----
   -- 菜单：权限分级管理
   -- 菜单key：orgGradeMgr
   -- 菜单URL:/sys/org/sysOrg/mgrGrade.do
   -- os_grade_admin【分级管理员】 
   -- os_grade_role【分级管理员角色】

DROP TABLE IF EXISTS os_grade_admin;
CREATE TABLE os_grade_admin (
ID_ VARCHAR ( 64 ) NOT NULL COMMENT '主键',
GROUP_ID_ VARCHAR ( 64 )  DEFAULT  NULL COMMENT '组织ID',
USER_ID_ VARCHAR ( 64 )   DEFAULT NULL COMMENT '管理员ID',
FULLNAME_ VARCHAR ( 64 )   DEFAULT NULL COMMENT '管理员名字',
PARENT_ID_ VARCHAR ( 64 )   DEFAULT NULL COMMENT '父ID',
DEPTH_ INT ( 11 ) DEFAULT NULL COMMENT '深度',
PATH_ VARCHAR ( 1024 )   DEFAULT NULL COMMENT '路径',
SN_ VARCHAR ( 64 )   DEFAULT NULL COMMENT '序号',
CHILDS_ INT ( 11 ) DEFAULT NULL COMMENT '子节点数量',
TENANT_ID_ VARCHAR ( 64 )   DEFAULT NULL COMMENT '租户ID',
CREATE_BY_ VARCHAR ( 64 )   DEFAULT NULL COMMENT '创建人ID',
CREATE_TIME_ datetime ( 0 ) DEFAULT NULL COMMENT '创建时间',
UPDATE_BY_ VARCHAR ( 64 )   DEFAULT NULL COMMENT '更新人ID',
UPDATE_TIME_ datetime ( 0 ) DEFAULT NULL COMMENT '更新时间',
PRIMARY KEY ( ID_ ) USING BTREE
);

DROP TABLE IF EXISTS os_grade_role;
CREATE TABLE os_grade_role  (
  ID_ varchar(64)  NOT NULL COMMENT '主键',
  ADMIN_ID_ varchar(64)  DEFAULT NULL COMMENT '管理员ID',
  GROUP_ID_ varchar(64)  DEFAULT NULL COMMENT '分组ID',
  NAME_ varchar(200)  DEFAULT NULL COMMENT '名称',
  TENANT_ID_ varchar(64)  DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64)  DEFAULT NULL COMMENT '创建人ID',
  CREATE_TIME_ datetime(0) DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64)  DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_) USING BTREE
);

-- alter table os_group add type_ varchar(64);
-- alter table os_group add STATU_ INTEGER;
-- alter table os_rel_type add dim_id1_grade_ varchar(64);
-- alter table os_group add LAST_UPDATE_TIME_ bigint(20) DEFAULT NULL;
-- alter table OS_USER add  LAST_UPDATE_TIME_ bigint(20) DEFAULT NULL;
-- alter table OS_USER add IS_ADMIN_ int(11) DEFAULT NULL;

-- add by shengzhongwen 2019-01-14 新增权限分级管理菜单 end----

-- add by shenzhongwen 2019-01-21 新增多机构申请及审批功能，涉及到用户登陆，新增功能的修改 begin --

-- 新增用户-租户表（os_inst_users）
CREATE TABLE OS_INST_USERS
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主鍵',
   USER_ID_             VARCHAR(64) COMMENT '账号ID',
   APPROVE_USER_        VARCHAR(64) COMMENT '审批用户',
   IS_ADMIN_            INT COMMENT '是否超管(1,超管,0普通用户)',
   DOMAIN_              VARCHAR(64) COMMENT '域',
   STATUS_              VARCHAR(64) COMMENT '状态           APPLY:申请,DISABLED:禁止,DISCARD:丢弃,ENABLED,正常',
   TENANT_ID_           VARCHAR(64) COMMENT '所属租户',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   CREATE_TYPE_           VARCHAR(64) COMMENT '创建类型   CREATE=创建（不可以删除） APPLY=申请加入（可以删除',
   APPLY_STATUS_           VARCHAR(64) COMMENT '申请加入机构状态：APPLY:申请,DISABLED:禁止,DISCARD:丢弃,ENABLED,正常',
   PRIMARY KEY (ID_)
);

ALTER TABLE OS_INST_USERS COMMENT '用户租户关联表';

-- 版本去掉用户账号升级需要以下五个步骤
-- 1.在用户表增加密码 PWD_字段
alter table OS_USER add PWD_ varchar(64);

-- 2.将账号表的密码更新到用户表
update OS_USER a, sys_account b set a.PWD_= b.PWD_ where a.USER_ID_=b.USER_ID_;

-- 3.用户表中的数据迁移
	INSERT INTO os_inst_users (ID_,USER_ID_,TENANT_ID_,STATUS_,IS_ADMIN_,CREATE_TYPE_,APPLY_STATUS_)
	SELECT USER_ID_,USER_ID_,TENANT_ID_ ,STATUS_,0,'CREATE','ENABLED' FROM OS_USER;

UPDATE os_inst_users A,sys_inst T SET A.DOMAIN_=T.DOMAIN_ WHERE A.TENANT_ID_=T.INST_ID_;

-- 4.删除帐号表
DROP TABLE SYS_ACCOUNT;
	
-- 5.刪除用户表列
alter table os_user drop column IS_ADMIN_;

-- 菜单配置：
-- 申请加入机构：
 -- key:addSysInst
 -- url:/sys/core/sysInst/showCanApplyList.do
 -- jsp：sysInstShowCanAddList.jsp：

-- 机构申请审批：
  -- key:addSysInstMgr
  -- url:/sys/core/sysInst/showApplyInstList.do
  -- jsp:sysInstShowAddInstList.jsp

-- add by shenzhongwen 2019-01-21 新增多机构申请及审批功能，涉及到用户登陆，新增功能的修改 begin --

		
-- add by zyg 2019-01-23 批量审批处理 end----
DROP TABLE IF EXISTS bpm_batch_approval;
CREATE TABLE bpm_batch_approval (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  SOL_ID_ varchar(64) DEFAULT NULL COMMENT '流程方案ID',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '节点ID',
  TABLE_NAME_ varchar(64) DEFAULT NULL COMMENT '实体表名称',
  FIELD_JSON_ varchar(4000) DEFAULT NULL COMMENT '字段设置',
  STATUS_ varchar(4) DEFAULT NULL COMMENT '状态',
  SOL_NAME_ varchar(200) DEFAULT NULL,
  TASK_NAME_ varchar(200) DEFAULT NULL,
  ACT_DEF_ID_ varchar(64) DEFAULT NULL,
  TENANT_ID_ varchar(64) DEFAULT NULL,
  CREATE_TIME_ datetime DEFAULT NULL,
  CREATE_BY_ varchar(64) DEFAULT NULL,
  UPDATE_TIME_ datetime DEFAULT NULL,
  UPDATE_BY_ varchar(64) DEFAULT NULL,
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程批量审批设置表';

/**
 * 批量审批设定
 * 菜单地址
 * /bpm/core/bpmBatchApproval/list.do
 */

-- add by zyg EXCEL模版导入。2019-1-29
CREATE TABLE SYS_EXCEL_TEMPLATE
(
   ID_                  VARCHAR(64) COMMENT '主键',
   TEMPLATE_NAME_       VARCHAR(200) COMMENT '模版名称',
   TEMPLATE_NAME_ALIAS_ VARCHAR(64) COMMENT '模版别名',
   TEMPLATE_TYPE_       VARCHAR(64) COMMENT '模版类型',
   TEMPLATE_COMMENT_    VARCHAR(200) COMMENT '备注',
   TEMPLATE_CONF_       TEXT COMMENT '配置',
   EXCEL_TEMPLATE_FILE_ VARCHAR(64) COMMENT 'EXCEL文件',
   TENANT_ID_           VARCHAR(64) COMMENT '租户',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间'
);

ALTER TABLE SYS_EXCEL_TEMPLATE COMMENT 'EXCEL 导入模版';

-- add by zyg 导入批次。2019-1-29
CREATE TABLE SYS_DATA_BAT
(
   ID_                  VARCHAR(64) NOT NULL COMMENT '主键',
   UPLOAD_ID_           VARCHAR(64) COMMENT '上传批次',
   BAT_ID_              VARCHAR(64) COMMENT '批次ID',
   SERVICE_NAME_        VARCHAR(64) COMMENT '服务名',
   APP_ID_              VARCHAR(64) COMMENT '应用ID',
   TYPE_                VARCHAR(64) COMMENT '类型',
   EXCEL_ID_            VARCHAR(64) COMMENT 'EXCEL文件ID',
   TABLE_NAME_          VARCHAR(64) COMMENT '导入的表名',
   INST_ID_             VARCHAR(64) COMMENT '实例ID',
   INST_STATUS_         VARCHAR(64) COMMENT '实例状态',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_DATA_BAT COMMENT 'EXCEL导入批次';

-- add by Louis 2019-01-29 sys_echarts_custom增加栏位
ALTER TABLE SYS_ECHARTS_CUSTOM ADD COLUMN DATA_ZOOM_ VARCHAR(20) NULL DEFAULT NULL COMMENT '缩放区域';


-- add by csx 2019-02-10 扩展长度，防止发送消息选择人员或组过长出错
alter table inf_inbox modify fullname_ varchar(2000);
alter table inf_inbox modify REC_USER_ID_ varchar(2000);
alter table inf_inbox modify GROUP_ID_ varchar(2000);
alter table inf_inbox modify GROUP_NAME_ varchar(2000);


-- add by shenzhongwen 2019-02-11 用户增加默认登陆机构（域名） 功能
alter table os_user add defaultDomain varchar(64);


ALTER TABLE wx_ent_agent
MODIFY COLUMN HOME_URL_  varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER DOMAIN_;


-- add by zwc 2019-2-12 openOffice配置面板优化
delete from sys_properties where alias_ = 'openOfficeSwitch';
delete from sys_properties where alias_ = 'OpenOffice_HOME';
delete from sys_properties where alias_ = 'openoffice.ip';
delete from sys_properties where alias_ = 'openoffice.port';
delete from sys_properties where alias_ = 'openoffice' ;

INSERT INTO sys_properties (PRO_ID_, NAME_, ALIAS_, GLOBAL_, ENCRYPT_, VALUE_, CATEGORY_, DESCRIPTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2620000000170022', 'openOffice配置', 'openOfficeConfig', 'YES', 'NO', '{\"openOffice_service_ip\":\"127.0.0.1\",\"openOffice_function\":\"NO\",\"openOffice_installPath\":\"C:/Program Files (x86)/OpenOffice 4/\",\"openOffice_service_port\":\"8200\"}', '系统参数', 'openOffice_installPath:安装路径\r\nopenOffice_service_ip：服务IP\r\nopenOffice_service_port：服务端口\r\nopenOffice_function：是否开启openOffice转换功能(YES,NO)\r\nopenOffice_switch：是否开启服务进程(true,false)', '1', '1', '2019-02-12 13:04:37', '1', '2019-02-12 15:12:24');
-- openOffice配置菜单
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2620000000140002', '2520000000360023', 'OpenOffice配置', 'openOfficeConfig', NULL, NULL, NULL, ' icon-xitongpeizhi', NULL, '2510000000020002', NULL, NULL, '0', '/sys/core/openoffice/config.do', 'URL', 'NO', '0', '', NULL, '1', NULL, NULL, '1', '2019-02-01 17:34:56');


-- add by shengzhongwen 2019-02-13 非管理平台的租户登陆默认首页Portal配置页面


  -- ***  注意 这里已经加入 v5.7.3 2-init.sql 里面，无需再次整合  *****---

INSERT INTO INS_PORTAL_DEF (PORT_ID_, NAME_, KEY_, IS_DEFAULT_, USER_ID_, LAYOUT_HTML_, PRIORITY_, EDIT_HTML_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)VALUES ('2400000007019002','机构Port门户','INSTPORT','YES','','<div class="gridster">
	<ul><li class="gs-w" data-col="1" data-row="1" data-sizex="6" data-sizey="1"><div id="msgBox" class="colId_2400000003411003"></div></li><li class="gs-w" data-col="1" data-row="2" data-sizex="2" data-sizey="3"><div id="BpmTask" class="colId_2400000003411004"></div></li><li class="gs-w" data-col="3" data-row="2" data-sizex="2" data-sizey="3"><div id="myMsg" class="colId_2400000004021000"></div></li><li class="gs-w" data-col="5" data-row="2" data-sizex="2" data-sizey="3"><div id="noticeNews" class="colId_2400000004011000"></div></li><li class="gs-w" data-col="1" data-row="5" data-sizex="3" data-sizey="2"><div id="outMail" class="colId_2400000004021001"></div></li><li class="gs-w" data-col="4" data-row="5" data-sizex="3" data-sizey="2"><div id="compNews" class="colId_2520000000390002"></div></li></ul>
</div>','1','
						<ul style="min-width: 100%; max-width: 100%; position: relative; padding: 0px; height: 910px;"><div id="msgBox" colid="2400000003411003" data-col="1" data-row="1" data-sizex="6" data-sizey="1" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>消息盒</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000003411003'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="BpmTask" colid="2400000003411004" data-col="1" data-row="2" data-sizex="2" data-sizey="3" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>待办事项</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000003411004'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="myMsg" colid="2400000004021000" data-col="3" data-row="2" data-sizex="2" data-sizey="3" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>我的消息</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000004021000'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="noticeNews" colid="2400000004011000" data-col="5" data-row="2" data-sizex="2" data-sizey="3" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>公司公告</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000004011000'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="outMail" colid="2400000004021001" data-col="1" data-row="5" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>外部邮件</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000004021001'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="compNews" colid="2520000000390002" data-col="4" data-row="5" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>公司新闻</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2520000000390002'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div></ul>',1,1,NULL,NULL,NULL);

-- 21. 布局权限设置
INSERT INTO INS_PORTAL_PERMISSION (ID_, LAYOUT_ID_, TYPE_, OWNER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000690055', '2400000007579002', 'ALL', 'ALL', '1', '1', NULL, NULL, NULL);
-- add by shengzhongwen 2019-02-13 非管理平台的租户登陆默认首页Portal配置页面


-- 2019-02-14 add zwj
ALTER TABLE sys_bo_entity
ADD COLUMN TREE_ID_  varchar(64) NULL COMMENT '分类ID';

-- 2019-2-19  ADD BY ZYG 在关系类型表中增加 LEVEL_字段 
alter table os_rel_type add LEVEL_ INT;


-- 2019-219 add by zwj 回调新增表

DROP TABLE IF EXISTS bpm_http_invoke_result;

CREATE TABLE bpm_http_invoke_result (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  TASK_ID_ varchar(64) DEFAULT NULL COMMENT '任务ID',
  CONTENT_ varchar(4000) DEFAULT NULL COMMENT '返回结果',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人ID',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '调用时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人ID',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调用结果';




DROP TABLE IF EXISTS bpm_http_task;

CREATE TABLE bpm_http_task (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  KEY_ varchar(64) DEFAULT NULL COMMENT '服务名称',
  PARAMS_DATA_ varchar(2000) DEFAULT NULL COMMENT '参数定义',
  PARAMS_ blob COMMENT '变量',
  INVOKE_TIMES_ int(11) DEFAULT NULL COMMENT '调用次数',
  PERIOD_ int(11) DEFAULT NULL COMMENT '调用间隔',
  RESULT_ int(11) DEFAULT NULL COMMENT '调用结果',
  TIMES_ int(11) DEFAULT NULL COMMENT '实际调用次数',
  FINISH_ int(11) DEFAULT NULL COMMENT '是否完成',
  SCRIPT_ text DEFAULT NULL COMMENT '脚本',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人ID',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人ID',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调用任务';

INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2400000003411004', '待办列表', 'BpmTask', '1', '1', '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n					<dd id=\"modularTitle\">\n						<span class=\"project_01\">\n							<p>审批环节</p>\n						</span>\n						<span class=\"project_02\">\n							<p>事项</p>\n						</span>\n						<span class=\"project_03\">\n							<p>日期</p>\n						</span>\n						<span class=\"project_04\">\n							<p>操作</p>\n						</span>\n						<div class=\"clearfix\"></div>\n					</dd>\n					<#list data.obj as obj>\n						<dd>\n							<span class=\"project_01\">\n								<a href=\"###\">${obj.name}</a>\n							</span>\n							<span class=\"project_02\">\n								<a href=\"${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}\" target=\"_blank\">${obj.description}</a>\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n							<span class=\"project_04\">\n								<a href=\"${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}\" target=\"_blank\">操作</a>\n							</span>\n							<div class=\"clearfix\"></div>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalBpmTask(colId)', '1', '1', NULL, '1', '2019-02-13 14:32:42', NULL, '1', 'list', '', '');
INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2430000000040063', '默认tab栏目', 'default_tab', '', NULL, '<div class=\"mini-tabs\" activeIndex=\"0\"  style=\"width:100%;height:200px;\">\n  	<#list data.obj as d>\n    <div title=\"${d.name}${d.count}\">\n        ${d.templet}\n    </div>\n    </#list>\n</div>', '', '1', '1', '2019-02-12 18:12:00', '1', '2019-02-21 18:06:44', NULL, '1', 'tabcolumn', '2400000003411004,2430000000410492,2430000000410493', '');
INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2430000000410492', '已办列表', 'MyBpmTask', '', NULL, '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n					<dd id=\"modularTitle\">\n						<span class=\"project_01\">\n							<p>状态</p>\n						</span>\n						<span class=\"project_02\">\n							<p>事项</p>\n						</span>\n						<span class=\"project_03\">\n							<p>日期</p>\n						</span>\n						<div class=\"clearfix\"></div>\n					</dd>\n					<#list data.obj as obj>\n						<dd>\n							<span class=\"project_01\">\n								<a href=\"###\">${obj.statusLabel}</a>\n							</span>\n							<span class=\"project_02\">\n								${obj.subject}\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n							<div class=\"clearfix\"></div>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalMyBpmTask(colId)', '1', '1', '2019-02-21 15:55:23', '1', '2019-02-21 18:16:32', NULL, '1', 'list', '', '');
INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2430000000410493', '抄送列表', 'MyChao', '', NULL, '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n					<dd id=\"modularTitle\">\n						<span class=\"project_01\">\n							<p>审批环节</p>\n						</span>\n						<span class=\"project_02\">\n							<p>事项</p>\n						</span>\n						<span class=\"project_03\">\n							<p>日期</p>\n						</span>\n						<div class=\"clearfix\"></div>\n					</dd>\n					<#list data.obj as obj>\n						<dd>\n							<span class=\"project_01\">\n								<a href=\"###\">${obj.nodeName}</a>\n							</span>\n							<span class=\"project_02\">\n								${obj.subject}\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n							<div class=\"clearfix\"></div>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalMyChao(colId)', '1', '1', '2019-02-21 15:56:18', '1', '2019-02-21 18:18:52', NULL, '1', 'list', '', '');

CREATE TABLE sys_es_list (
  ID_ varchar(64) NOT NULL,
  NAME_ varchar(64) DEFAULT NULL,
  ALIAS_ varchar(64) DEFAULT NULL,
  ID_FIELD_ varchar(64) DEFAULT NULL,
  QUERY_TYPE_ int DEFAULT NULL,
  ES_TABLE_ varchar(64) DEFAULT NULL,
  QUERY_ varchar(1000) DEFAULT NULL,
  RETURN_FIELDS_ varchar(2000),
  CONDITION_FIELDS_ varchar(1000),
  SORT_FIELDS_ varchar(200),
  IS_PAGE_ int DEFAULT NULL,
  LIST_HTML_ text,
  TREE_ID_ varchar(64) DEFAULT NULL,
  TENANT_ID_ varchar(64) DEFAULT NULL,
  CREATE_BY_ varchar(64) DEFAULT NULL,
  CREATE_TIME_ date DEFAULT NULL,
  UPDATE_BY_ varchar(64) DEFAULT NULL,
  UPDATE_TIME_ date DEFAULT NULL,
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- add by zwc 2019-2-27 17:43:21 锁定任务
ALTER TABLE act_ru_task ADD COLUMN LOCKED_  int  COMMENT '是否锁定';
UPDATE ACT_RU_TASK SET LOCKED_ = 0 WHERE LOCKED_ IS NULL;

-- add by zwc 2019年3月1日 修改门户待办列表模板html
UPDATE ins_column_def
SET
 NAME_ = '待办事项',
 DATA_URL_ = '/bpm/core/bpmTask/myList.do',
 IS_DEFAULT_ = '1',
 TEMPLET_ = '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1><em class=\"daiban\"></em>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"  title=\"更多\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"  title=\"刷新\"/>\n						</div>\n					</dt>\n					<#list data.obj as obj>\n						<dd>\n                    		    <span class=\"project_01\">\n								<em>■</em>\n                                		<a href=\"javascript:void(0);\" onclick=\"checkAndHandTask(\'${obj.id}\',false,true,\'${colId}\')\" target=\"_blank\">\n                                        			${obj.description}\n                                       	 </a>\n							</span>\n							<span class=\"project_02\">\n								<a href=\"###\">【${obj.name}】</a>\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>',
 FUNCTION_ = 'portalScript.getPortalBpmTask(colId)',
 IS_NEWS_ = 'NO',
 TABGROUPS_ = '',
 TENANT_ID_ = '1',
 CREATE_BY_ = '1',
 CREATE_TIME_ = NULL,
 UPDATE_BY_ = '2610000000000012',
 UPDATE_TIME_ = '2019-03-01 09:12:27',
 IS_PUBLIC_ = '',
 TYPE_ = 'list',
 TREE_ID_ = ''
WHERE
	(
		KEY_ = 'BpmTask'
	);

-- add by Louis 2019-02-28 修改报表栏位的类型
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN TITLE_FIELD_ 		TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN LEGEND_FIELD_ 		TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN XAXIS_FIELD_ 		TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN DATA_FIELD_ 		TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN SERIES_FIELD_ 		TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN ORDER_FIELD_ 		TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN SQL_ 				TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN GRID_FIELD_ 		TEXT NULL;
ALTER TABLE SYS_ECHARTS_CUSTOM MODIFY COLUMN DRILL_DOWN_FIELD_  TEXT NULL;

-- add by mfq 2019-03-4 添加组扩展属性的系统分类
INSERT INTO sys_tree_cat VALUES ('2610000002420004', 'CAT_CUSTOMATTRIBUTE_GROUP', '自定义属性分类（组）', '1', '', '1', '1', '2019-02-27 08:32:45', null, null);

-- add by hj 2019-03-01 修改消息盒的模板html
update ins_column_def set TEMPLET_ = '<div class="card">
		<ol class="cardUl">
			<#list data.obj as d>
			<li class="p_top" style="background-color: ${d.color}">
            	<a href="${ctxPath}${d.url}" target="_blank">
					<div class="cardBox" url="${ctxPath}${d.url}">
                      		 <div class="cardBox_right">
                                       	 <div class="tubiao_right">
                                              <span class="iconfont ${d.icon}"></span>
                                          </div>
                        	</div>
                    		<div class="cardBox_left">
                                    <p class="num">${d.count}</p>
                                	<h5>${d.title}</h5>
                            </div>
					</div>
                </a>
			</li>
			</#list>
			<h1 class="clearfix"></h1>
		</ol>
	</div>' where key_ = 'msgBox';

-- add by zwc 修复班次设置字段
ALTER TABLE ats_shift_info 
CHANGE COLUMN CODM CODE  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码' AFTER ID;


-- add by zwc 2019-3-6 19:58:13 重置openOffice配置数据
UPDATE sys_properties SET NAME_='openOffice配置', ALIAS_='openOfficeConfig', GLOBAL_='YES', ENCRYPT_='NO', VALUE_='{\"service_ip\":\"127.0.0.1\",\"enabled\":\"YES\",\"installPath\":\"C:/Program Files (x86)/OpenOffice 4/\",\"service_port\":\"8200\"}', CATEGORY_='系统参数', DESCRIPTION_='openOffice_installPath:安装路径\r\nopenOffice_service_ip：服务IP\r\nopenOffice_service_port：服务端口\r\nopenOffice_function：是否开启openOffice转换功能(YES,NO)\r\nopenOffice_switch：是否开启服务进程(true,false)', TENANT_ID_='1', CREATE_BY_='1', CREATE_TIME_='2019-02-12 13:04:37', UPDATE_BY_='1', UPDATE_TIME_='2019-02-13 18:36:22' WHERE (ALIAS_='openOfficeConfig');


-- add by zwc 2019-3-7 14:22:20 考勤模块班次类型初始化数据
INSERT INTO ats_shift_type (ID, CODE, NAME, IS_SYS, STATUS, MEMO, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('1', '1', '工作日', '1', '1', '1', '1', '1', '2019-03-06 10:55:57', NULL, NULL);
INSERT INTO ats_shift_type (ID, CODE, NAME, IS_SYS, STATUS, MEMO, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2', '2', '休息日', '1', '1', '1', '1', '1', '2019-03-06 10:55:57', NULL, NULL);
INSERT INTO ats_shift_type (ID, CODE, NAME, IS_SYS, STATUS, MEMO, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('3', '3', '法定假日', '1', '1', '1', '1', '1', '2019-03-06 10:55:57', NULL, NULL);

-- add by hj  2019-3-8 正则表达式表
CREATE TABLE bpm_reg_lib (
  REG_ID_ varchar(64) NOT NULL,
  USER_ID_ varchar(64) NOT NULL,
  REG_TEXT_ varchar(512) NOT NULL,
  TENANT_ID_ varchar(64) DEFAULT NULL,
  CREATE_BY_ varchar(64) DEFAULT NULL,
  CREATE_TIME_ date DEFAULT NULL,
  UPDATE_BY_ varchar(64) DEFAULT NULL,
  UPDATE_TIME_ date DEFAULT NULL,
  NAME_ varchar(64) NOT NULL,
  TYPE_ varchar(4) NOT NULL,
  KEY_ varchar(64) NOT NULL,
  MENT_TEXT_ varchar(512) NOT NULL,
  PRIMARY KEY (REG_ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- add by hj  2019-3-8 表单验证规则
CREATE TABLE form_valid_rule (
  ID_ varchar(64) NOT NULL COMMENT '主键',
  SOL_ID_ varchar(64) DEFAULT NULL COMMENT '解决方案ID',
  FORM_KEY_ varchar(64) DEFAULT NULL COMMENT '表单KEY',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '节点ID',
  ACT_DEF_ID_ varchar(64) DEFAULT NULL COMMENT '流程定义ID',
  JSON_ text COMMENT '表单验证',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '机构ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '修改人',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单验证规则';

update ins_column_temp set TEMPLET_ = '<div class="toolTabs">
				<div class="tabHeader">
                  <#list data.obj as d>
					<span>${d.name}<b>${d.count}</b></span>
				</#list>
				</div>
				<div class="tabContent">
                  <#list data.obj as d>
					<div class="contentBox" > ${d.templet}</div>
                  </#list>
				</div>
			</div>' where id_ ='4';


-- add by shenzhongwen 2019-03-13   脚本调用 菜单------------------------
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_ , BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)
values ('2610000000290037', '210000000418012', '脚本调用', 'invokeScript', NULL, NULL, NULL, ' icon-more', '', '2520000000240005', 1, 'null2610000000290037.', 0, '/sys/core/sysInvokeScript/list.do', 'URL', 'NO', '0', '', NULL, '1', '1', '2019-02-26 10:42:20',NULL,NULL);
-- add by shenzhongwen 2019-03-13   脚本调用 菜单------------------------

/*******************************************************初始化脚本2019-3-15 v5.8**************************************************************************/

-- add by shenzhongwen 2019-03-15 修改属性表，增加下拉框名称------  
ALTER TABLE os_attribute_value
	ADD COLUMN COMBOBOX_NAME_ VARCHAR(64) NULL DEFAULT NULL COMMENT '下拉框名称' AFTER VALUE_;
	

-- add by Louis 2019-03-18 图形报表权限，大屏展示以及测试流程数据
-- 图形报表树权限表
CREATE TABLE SYS_ECHARTS_PREMISSION (
    ID_             VARCHAR(64) NOT NULL     COMMENT 'ID',
    TREE_ID_        VARCHAR(64) NOT NULL     COMMENT '树ID',
    TYPE_           VARCHAR(64) DEFAULT NULL COMMENT '类型',
    OWNER_ID_       VARCHAR(64) DEFAULT NULL COMMENT '用户或组ID',
    OWNER_NAME_     VARCHAR(64) DEFAULT NULL COMMENT '用户名或组名',
    TENANT_ID_      varchar(64) DEFAULT NULL COMMENT '租用机构ID',
    CREATE_BY_      varchar(64) DEFAULT NULL COMMENT '创建人ID',
    CREATE_TIME_    DATETIME    DEFAULT NULL COMMENT '创建时间',
    UPDATE_BY_      VARCHAR(64) DEFAULT NULL COMMENT '更新人ID',
    UPDATE_TIME_    DATETIME    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT='图形报表树权限表';
-- 自定义大屏
CREATE TABLE SYS_DASHBOARD_CUSTOM (
    ID_           VARCHAR(64) NOT NULL     COMMENT 'ID',
    NAME_         VARCHAR(64) DEFAULT NULL COMMENT '名称',
    KEY_          VARCHAR(64) DEFAULT NULL COMMENT 'KEY', 
    TREE_ID_      VARCHAR(64) DEFAULT NULL COMMENT '树ID',
    LAYOUT_HTML_  TEXT        DEFAULT NULL COMMENT '展示布局HTML',
    EDIT_HTML_    TEXT        DEFAULT NULL COMMENT '编辑布局HTML',
    QUERYFILTER_JSONSTR_ TEXT DEFAULT NULL COMMENT '查询条件JSON字符',
    TENANT_ID_    VARCHAR(64) DEFAULT NULL COMMENT '租用机构ID',
    CREATE_BY_    VARCHAR(64) DEFAULT NULL COMMENT '创建人ID',
    CREATE_TIME_  DATETIME    DEFAULT NULL COMMENT '创建时间',
    UPDATE_BY_    VARCHAR(64) DEFAULT NULL COMMENT '更新人ID',
    UPDATE_TIME_  DATETIME    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (ID_)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT='自定义大屏';
-- 展示数据
-- 树：报表：流程统计
INSERT INTO sys_tree (TREE_ID_, NAME_, PATH_, DEPTH_, PARENT_ID_, KEY_, CODE_, DESCP_, CAT_KEY_, SN_, DATA_SHOW_TYPE_, CHILDS_, USER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000001820009', '流程统计', '0.2610000001820009.', '1', '', 'LCTJ', '', '', 'CAT_GRAPHIC_REPORT', '1', 'FLAT', NULL, NULL, '1', '1', '2019-03-08 08:29:47', NULL, NULL);
-- 大屏：流程统计
INSERT INTO sys_tree (TREE_ID_, NAME_, PATH_, DEPTH_, PARENT_ID_, KEY_, CODE_, DESCP_, CAT_KEY_, SN_, DATA_SHOW_TYPE_, CHILDS_, USER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000001820022', '流程常用统计', '0.2610000001820022.', '1', '', 'LCCYTJ', '', '', 'CAT_DASHBOARD', '1', 'FLAT', NULL, NULL, '1', '1', '2019-03-08 09:14:55', NULL, NULL);
-- 报表：流程统计
INSERT INTO sys_echarts_custom (ID_, NAME_, KEY_, ECHARTS_TYPE_, TITLE_FIELD_, LEGEND_FIELD_, XAXIS_FIELD_, XAXIS_DATA_FIELD_, XY_CONVERT_, DATA_FIELD_, SERIES_FIELD_, DETAIL_METHOD_, WHERE_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_BUILD_TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, SQL_, GRID_FIELD_, DRILL_DOWN_KEY_, DRILL_DOWN_FIELD_, THEME_, tree_id_, DATA_ZOOM_) VALUES ('2610000001820011', '使用最多的前十流程(雷达图)', 'BPM_USED_TOP10_RADAR', 'Radar', '{\"subtext\":\"\",\"show\":false,\"x\":\"left\",\"y\":\"top\",\"text\":\"使用最多的前十流程(雷达图)\",\"textStyle\":{\"fontFamily\":\"sans-serif\",\"fontSize\":\"18\",\"fontStyle\":\"normal\"}}', '{\"orient\":\"vertical\",\"selectedMode\":\"multiple\",\"show\":true,\"x\":\"left\",\"y\":\"middle\",\"type\":\"scroll\",\"align\":\"auto\"}', NULL, '[{\"fieldName\":\"NAME_\",\"comment\":\"流程实例\"}]', NULL, '[{\"fieldName\":\"COUNT_\",\"comment\":\"小计\"}]', '{\"selectedMode\":\"1\",\"center\":[\"50%\",\"50%\"],\"type\":\"radar\",\"radius\":[0,\"60\"]}', '0', NULL, NULL, '', '0', 'freeMakerSql', '1', '1', '2019-03-08 08:34:39', '1', '2019-03-08 09:19:39', 'SELECT S.NAME_, COUNT(S.NAME_) AS COUNT_ \nFROM BPM_INST B LEFT JOIN BPM_SOLUTION S ON B.SOL_ID_=S.SOL_ID_ \nWHERE B.TENANT_ID_ =1 GROUP BY S.NAME_ ORDER BY COUNT(S.NAME_) DESC LIMIT 10', NULL, NULL, '{\"openWindowUrl\":\"\",\"openWindowKey\":\"\",\"drillDownMethod\":\"openWindow\",\"drillDownField\":[],\"isDrillDown\":\"0\",\"drillDownKey\":\"\"}', 'shine', '2610000001820009', NULL);
INSERT INTO sys_echarts_custom (ID_, NAME_, KEY_, ECHARTS_TYPE_, TITLE_FIELD_, LEGEND_FIELD_, XAXIS_FIELD_, XAXIS_DATA_FIELD_, XY_CONVERT_, DATA_FIELD_, SERIES_FIELD_, DETAIL_METHOD_, WHERE_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_BUILD_TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, SQL_, GRID_FIELD_, DRILL_DOWN_KEY_, DRILL_DOWN_FIELD_, THEME_, tree_id_, DATA_ZOOM_) VALUES ('2610000001820013', '使用最多的前十流程(饼图)', 'BPM_USERD_TOP10_PIE', 'Pie', '{\"subtext\":\"\",\"show\":false,\"x\":\"left\",\"y\":\"top\",\"text\":\"使用最多的前十流程(饼图)\",\"textStyle\":{\"fontFamily\":\"sans-serif\",\"fontSize\":\"18\",\"fontStyle\":\"normal\"}}', '{\"orient\":\"horizontal\",\"selectedMode\":\"multiple\",\"show\":true,\"x\":\"right\",\"y\":\"bottom\",\"type\":\"scroll\",\"align\":\"auto\"}', NULL, '[{\"fieldName\":\"NAME_\",\"comment\":\"流程实例\"}]', NULL, '[{\"fieldName\":\"COUNT_\",\"comment\":\"小计\"}]', '{\"labelPosition\":\"outside\",\"selectedMode\":\"single\",\"roseType\":false,\"center\":[\"50%\",\"50%\"],\"type\":\"pie\",\"radius\":[\"10\",\"50\"]}', '1', NULL, NULL, '', '0', 'freeMakerSql', '1', '1', '2019-03-08 08:37:02', '1', '2019-03-08 09:24:01', 'SELECT S.NAME_, COUNT(S.NAME_) AS COUNT_ \nFROM BPM_INST B LEFT JOIN BPM_SOLUTION S ON B.SOL_ID_=S.SOL_ID_ \nWHERE B.TENANT_ID_ =1 GROUP BY S.NAME_ ORDER BY COUNT(S.NAME_) DESC LIMIT 10', NULL, NULL, '{\"openWindowUrl\":\"\",\"openWindowKey\":\"\",\"drillDownMethod\":\"openWindow\",\"drillDownField\":[],\"isDrillDown\":\"0\",\"drillDownKey\":\"\"}', 'shine', '2610000001820009', NULL);
INSERT INTO sys_echarts_custom (ID_, NAME_, KEY_, ECHARTS_TYPE_, TITLE_FIELD_, LEGEND_FIELD_, XAXIS_FIELD_, XAXIS_DATA_FIELD_, XY_CONVERT_, DATA_FIELD_, SERIES_FIELD_, DETAIL_METHOD_, WHERE_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_BUILD_TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, SQL_, GRID_FIELD_, DRILL_DOWN_KEY_, DRILL_DOWN_FIELD_, THEME_, tree_id_, DATA_ZOOM_) VALUES ('2610000001820014', '每月使用最多的流程(饼图)', 'BPM_MONTH_USED_TOP1_PIE', 'Pie', '{\"subtext\":\"\",\"show\":false,\"x\":\"left\",\"y\":\"top\",\"text\":\"每月使用最多的流程(饼图)\",\"textStyle\":{\"fontFamily\":\"sans-serif\",\"fontSize\":\"18\",\"fontStyle\":\"normal\"}}', '{\"orient\":\"horizontal\",\"selectedMode\":\"multiple\",\"show\":true,\"x\":\"center\",\"y\":\"bottom\",\"type\":\"scroll\",\"align\":\"auto\"}', NULL, '[{\"fieldName\":\"NAME_\",\"comment\":\"流程名称\"},{\"fieldName\":\"CTIME_\",\"comment\":\"使用年月\"}]', NULL, '[{\"fieldName\":\"COUNT_\",\"comment\":\"小计\"}]', '{\"labelPosition\":\"outside\",\"selectedMode\":\"single\",\"roseType\":false,\"center\":[\"50%\",\"50%\"],\"type\":\"pie\",\"radius\":[\"5\",\"50\"]}', '1', NULL, NULL, '', '0', 'freeMakerSql', '1', '1', '2019-03-08 08:43:49', '1', '2019-03-08 09:23:45', 'SELECT V1.CTIME_, V2.NAME_, V1.COUNT_ FROM \n(SELECT CTIME_, NAME_, MAX(COUNT_) AS COUNT_ FROM (\nSELECT DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') AS CTIME_, S.NAME_ AS NAME_, COUNT(S.NAME_)AS COUNT_\n      FROM BPM_INST B LEFT JOIN BPM_SOLUTION S ON B.SOL_ID_=S.SOL_ID_ \n         WHERE B.TENANT_ID_ =1 GROUP BY S.NAME_, DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ORDER BY DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ASC) V GROUP BY V.CTIME_ HAVING MAX(V.COUNT_)) V1\nLEFT JOIN\n(SELECT DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') AS CTIME_, S.NAME_ AS NAME_, COUNT(S.NAME_)AS COUNT_\n      FROM BPM_INST B LEFT JOIN BPM_SOLUTION S ON B.SOL_ID_=S.SOL_ID_ \n         WHERE B.TENANT_ID_ =1 GROUP BY S.NAME_, DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ORDER BY DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ASC) V2\nON V1.CTIME_ = V2.CTIME_ AND V1.COUNT_ = V2.COUNT_ ORDER BY V1.CTIME_ DESC LIMIT 10', NULL, NULL, '{\"openWindowUrl\":\"\",\"openWindowKey\":\"\",\"drillDownMethod\":\"openWindow\",\"drillDownField\":[],\"isDrillDown\":\"0\",\"drillDownKey\":\"\"}', 'shine', '2610000001820009', NULL);
INSERT INTO sys_echarts_custom (ID_, NAME_, KEY_, ECHARTS_TYPE_, TITLE_FIELD_, LEGEND_FIELD_, XAXIS_FIELD_, XAXIS_DATA_FIELD_, XY_CONVERT_, DATA_FIELD_, SERIES_FIELD_, DETAIL_METHOD_, WHERE_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_BUILD_TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, SQL_, GRID_FIELD_, DRILL_DOWN_KEY_, DRILL_DOWN_FIELD_, THEME_, tree_id_, DATA_ZOOM_) VALUES ('2610000001820015', '每月使用最多的流程(漏斗图)', 'BPM_MONTH_USED_TOP1_FUNNEL', 'Funnel', '{\"subtext\":\"\",\"show\":false,\"x\":\"left\",\"y\":\"top\",\"text\":\"每月使用最多的流程(漏斗图)\",\"textStyle\":{\"fontFamily\":\"sans-serif\",\"fontSize\":\"18\",\"fontStyle\":\"normal\"}}', '{\"orient\":\"horizontal\",\"selectedMode\":\"multiple\",\"show\":true,\"x\":\"center\",\"y\":\"bottom\",\"type\":\"scroll\",\"align\":\"auto\"}', NULL, '[{\"fieldName\":\"NAME_\",\"comment\":\"流程名称\"},{\"fieldName\":\"CTIME_\",\"comment\":\"使用年月\"}]', NULL, '[{\"fieldName\":\"COUNT_\",\"comment\":\"小计\"}]', '{\"labelPosition\":\"outside\",\"type\":\"funnel\"}', '1', NULL, NULL, '', '0', 'freeMakerSql', '1', '1', '2019-03-08 08:50:03', '1', '2019-03-08 08:51:10', 'SELECT V1.CTIME_, V2.NAME_, V1.COUNT_ FROM \n(SELECT CTIME_, NAME_, MAX(COUNT_) AS COUNT_ FROM (\nSELECT DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') AS CTIME_, S.NAME_ AS NAME_, COUNT(S.NAME_)AS COUNT_\n      FROM BPM_INST B LEFT JOIN BPM_SOLUTION S ON B.SOL_ID_=S.SOL_ID_ \n         WHERE B.TENANT_ID_ =1 GROUP BY S.NAME_, DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ORDER BY DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ASC) V GROUP BY V.CTIME_ HAVING MAX(V.COUNT_)) V1\nLEFT JOIN\n(SELECT DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') AS CTIME_, S.NAME_ AS NAME_, COUNT(S.NAME_)AS COUNT_\n      FROM BPM_INST B LEFT JOIN BPM_SOLUTION S ON B.SOL_ID_=S.SOL_ID_ \n         WHERE B.TENANT_ID_ =1 GROUP BY S.NAME_, DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ORDER BY DATE_FORMAT(B.CREATE_TIME_, \'%Y-%m\') ASC) V2\nON V1.CTIME_ = V2.CTIME_ AND V1.COUNT_ = V2.COUNT_ ORDER BY V1.CTIME_ DESC LIMIT 10', '{\"sort\":\"descending\",\"funnelAlign\":\"center\"}', NULL, '{\"openWindowUrl\":\"\",\"openWindowKey\":\"\",\"drillDownMethod\":\"openWindow\",\"drillDownField\":[],\"isDrillDown\":\"0\",\"drillDownKey\":\"\"}', 'essos', '2610000001820009', NULL);
INSERT INTO sys_echarts_custom (ID_, NAME_, KEY_, ECHARTS_TYPE_, TITLE_FIELD_, LEGEND_FIELD_, XAXIS_FIELD_, XAXIS_DATA_FIELD_, XY_CONVERT_, DATA_FIELD_, SERIES_FIELD_, DETAIL_METHOD_, WHERE_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_BUILD_TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, SQL_, GRID_FIELD_, DRILL_DOWN_KEY_, DRILL_DOWN_FIELD_, THEME_, tree_id_, DATA_ZOOM_) VALUES ('2610000001820020', '所有的流程审批效率(表格)', 'ALL_BPM_APPR_EFFIC_TABLE', 'Table', '{\"subtext\":\"\",\"show\":true,\"x\":\"left\",\"y\":\"top\",\"text\":\"所有的流程审批效率(表格)\",\"textStyle\":{\"fontFamily\":\"sans-serif\",\"fontSize\":\"18\",\"fontStyle\":\"normal\"}}', NULL, NULL, '[{\"fieldName\":\"SUBJECT_\",\"comment\":\"标题\"},{\"fieldName\":\"CREATE_TIME_\",\"comment\":\"创建时间\"},{\"fieldName\":\"END_TIME_\",\"comment\":\"结束时间\"}]', NULL, '[{\"fieldName\":\"DIFF_TIME_\",\"comment\":\"审批效率\"}]', NULL, NULL, NULL, NULL, '', '0', 'freeMakerSql', '1', '1', '2019-03-08 09:11:40', '1', '2019-03-08 09:18:26', 'SELECT  B.SUBJECT_, B.CREATE_TIME_, B.END_TIME_,\n				CASE WHEN B.STATUS_ != \'SUCCESS_END\' THEN \'未完成或已取消\' ELSE CONCAT(TIMESTAMPDIFF(SECOND,B.CREATE_TIME_, B.END_TIME_),\'秒\') END AS DIFF_TIME_\n      FROM BPM_INST B LEFT JOIN BPM_SOLUTION S ON B.SOL_ID_=S.SOL_ID_ \n         WHERE B.TENANT_ID_ =1 GROUP BY S.NAME_ ORDER BY COUNT(S.NAME_) DESC', NULL, NULL, NULL, NULL, '2610000001820009', NULL);
-- 图形报表权限
INSERT INTO sys_echarts_premission (ID_, TREE_ID_, TYPE_, OWNER_ID_, OWNER_NAME_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000001820012', '2610000001820009', 'subGroup', '1', '红迅集团', '1', '1', '2019-03-08 08:35:04', NULL, NULL);
-- 大屏：流程统计
INSERT INTO sys_dashboard_custom (ID_, NAME_, KEY_, TREE_ID_, LAYOUT_HTML_, EDIT_HTML_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, QUERYFILTER_JSONSTR_) VALUES ('2610000001820024', '流程常用统计', 'LCCYTJ', '2610000001820022', '<div class=\"gridster\">\n	<ul><li class=\"gs-w\" data-col=\"1\" data-row=\"1\" data-sizex=\"4\" data-sizey=\"2\"><div id=\"ALL_BPM_APPR_EFFIC_TABLE\" class=\"colId_2610000001820020\"></div></li><li class=\"gs-w\" data-col=\"5\" data-row=\"1\" data-sizex=\"2\" data-sizey=\"2\"><div id=\"BPM_MONTH_USED_TOP1_PIE\" class=\"colId_2610000001820014\"></div></li><li class=\"gs-w\" data-col=\"5\" data-row=\"3\" data-sizex=\"2\" data-sizey=\"2\"><div id=\"BPM_MONTH_USED_TOP1_FUNNEL\" class=\"colId_2610000001820015\"></div></li><li class=\"gs-w\" data-col=\"1\" data-row=\"3\" data-sizex=\"2\" data-sizey=\"2\"><div id=\"BPM_USERD_TOP10_PIE\" class=\"colId_2610000001820013\"></div></li><li class=\"gs-w\" data-col=\"3\" data-row=\"3\" data-sizex=\"2\" data-sizey=\"2\"><div id=\"BPM_USED_TOP10_RADAR\" class=\"colId_2610000001820011\"></div></li></ul>\n</div>', '\n					<ul style=\"min-width: 100%; max-width: 100%; position: relative; padding: 0px; height: 610px;\"><div id=\"ALL_BPM_APPR_EFFIC_TABLE\" colid=\"2610000001820020\" data-col=\"1\" data-row=\"1\" data-sizex=\"4\" data-sizey=\"2\" class=\"gs-w\" style=\"display: block;\"><dl class=\"modularBox\"><dt><h1>所有的流程审批效率(表格)</h1><div class=\"icon\"><em class=\"closeThis\">×</em></div><div class=\"clearfix\"></div></dt></dl><span class=\"gs-resize-handle gs-resize-handle-both\"></span></div><div id=\"BPM_MONTH_USED_TOP1_PIE\" colid=\"2610000001820014\" data-col=\"5\" data-row=\"1\" data-sizex=\"2\" data-sizey=\"2\" class=\"gs-w\" style=\"display: block;\"><dl class=\"modularBox\"><dt><h1>每月使用最多的流程(饼图)</h1><div class=\"icon\"><em class=\"closeThis\">×</em></div><div class=\"clearfix\"></div></dt></dl><span class=\"gs-resize-handle gs-resize-handle-both\"></span></div><div id=\"BPM_MONTH_USED_TOP1_FUNNEL\" colid=\"2610000001820015\" data-col=\"5\" data-row=\"3\" data-sizex=\"2\" data-sizey=\"2\" class=\"gs-w\" style=\"display: block;\"><dl class=\"modularBox\"><dt><h1>每月使用最多的流程(漏斗图)</h1><div class=\"icon\"><em class=\"closeThis\">×</em></div><div class=\"clearfix\"></div></dt></dl><span class=\"gs-resize-handle gs-resize-handle-both\"></span></div><div id=\"BPM_USERD_TOP10_PIE\" colid=\"2610000001820013\" data-col=\"1\" data-row=\"3\" data-sizex=\"2\" data-sizey=\"2\" class=\"gs-w\" style=\"display: block;\"><dl class=\"modularBox\"><dt><h1>使用最多的前十流程(饼图)</h1><div class=\"icon\"><em class=\"closeThis\">×</em></div><div class=\"clearfix\"></div></dt></dl><span class=\"gs-resize-handle gs-resize-handle-both\"></span></div><div id=\"BPM_USED_TOP10_RADAR\" colid=\"2610000001820011\" data-col=\"3\" data-row=\"3\" data-sizex=\"2\" data-sizey=\"2\" class=\"gs-w\" style=\"display: block;\"><dl class=\"modularBox\"><dt><h1>使用最多的前十流程(雷达图)</h1><div class=\"icon\"><em class=\"closeThis\">×</em></div><div class=\"clearfix\"></div></dt></dl><span class=\"gs-resize-handle gs-resize-handle-both\"></span></div></ul>\n				', '1', '1', '2019-03-08 09:16:29', '1', '2019-03-08 09:22:41', '');

-- 流程超时节点表
CREATE TABLE bpm_overtime_node (
  ID_ varchar(64) NOT NULL,
  SOL_ID_ varchar(64) DEFAULT NULL COMMENT '解决方案ID',
  INST_ID_ varchar(64) DEFAULT NULL COMMENT '流程实例ID',
  NODE_ID_ varchar(64) DEFAULT NULL COMMENT '流程节点ID',
  OP_TYPE_ varchar(50) NOT NULL COMMENT '操作类型',
  OP_CONTENT_ varchar(512) NOT NULL COMMENT '操作内容',
  OVERTIME_ int(11) DEFAULT NULL COMMENT '超时时间',
  STATUS_ varchar(64) DEFAULT NULL COMMENT '节点状态',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租用机构ID',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人ID',
  CREATE_TIME_ datetime DEFAULT NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人ID',
  UPDATE_TIME_ datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程超时节点表';

-- 增加 数量比较类型 hj
alter table INS_MSG_DEF add COUNT_TYPE_ varchar(64);


-- add by shenzhongwen 2019-04-02 新增 脚本管理菜单--------
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_)
values ('2610000001710002','210000000418012','脚本管理','scriptServiceClass',NULL,NULL,NULL,' icon-database-50','','2520000000240005',1,'null2610000001710002.','0','/sys/org/sysScriptLibary/list.do','URL','NO','0',1,1);

CREATE TABLE sys_script_libary (
  LIB_ID_ varchar(64) NOT NULL COMMENT '脚本id',
  TREE_ID_ varchar(64) DEFAULT NULL COMMENT '分类ID(表：sys_tree)',
  FULL_CLASS_NAME_ varchar(64) DEFAULT NULL COMMENT '脚本全名',
  METHOD_ varchar(64) DEFAULT NULL COMMENT '方法名：别名',
  PARAMS_ varchar(1000) DEFAULT NULL COMMENT '参数：类型为json json{}',
  RETURN_TYPE_ varchar(1000) DEFAULT NULL COMMENT '返回类型：java class type',
  DOS_ varchar(512) DEFAULT NULL COMMENT '说明方法的详细使用',
  CREATE_TIME_ datetime(0) DEFAULT NULL COMMENT '创建时间',
  CREATE_BY_ varchar(64) DEFAULT NULL COMMENT '创建人ID',
  UPDATE_BY_ varchar(64) DEFAULT NULL COMMENT '更新人',
  UPDATE_TIME_ datetime(0) DEFAULT NULL COMMENT '更新时间',
  BEAN_NAME_ varchar(64) DEFAULT NULL COMMENT '类名称',
  TENANT_ID_ varchar(64) DEFAULT NULL COMMENT '租户id',
  EXAMPLE_ varchar(1000) DEFAULT NULL COMMENT '调用脚本',
  PRIMARY KEY (LIB_ID_)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT='脚本定义';
-- add by shenzhongwen 2019-04-09 新增 脚本管理菜单--------

-- add by shenzhongwen 2019-04-15 修改 JSAAS-67：在门户首页增加公司新闻与公告的带有标题图片滚动的栏目 begin--------
alter table INS_COLUMN_DEF add NEW_TYPE_ varchar(30) null comment '新闻类型';
alter table INS_COLUMN_DEF modify TEMPLET_ varchar(6000);
update ins_column_def set TEMPLET_='<div id=\"noticeNews\" class=\"colId_${colId}\" colId=\"${colId}\">
    <input id=\"hideInput\" value=\"${data.type}\" style=\"display: none;\"/>
    <div class=\"widget-box border \">
        <div class=\"widget-body\">
            <div class=\"widget-scroller\">
                <dl class=\"modularBox\">
                    <dt id=\"heardDt\">
                        <h1><em class=\"xiaoxi\"></em>${data.title}</h1>
                        <div class=\"icon\">
                            <input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"
                                   title=\"更多\"/>
                            <input type=\"button\" id=\"Refresh\" onclick=\"refreshRoll(\'${colId}\')\" title=\"刷新\"/>
                        </div>
                        <div class=\"clearfix\"></div>
                    </dt>
					 <#if  \"${data.type}\" ==\"imgAndFont\" || \"${data.type}\" ==\"img\">
						<div class=\"rollBanner\" id=\"rollBanner\" style=\"heigth:100%;display:inline-block;vertical-align: top;\">
							<ul class=\"rollBoxs_szw\">
								<#list data.obj as obj>
									<li>
										<img title=\"${obj.subject}\" src=\"${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=${obj.imgFileId}\"/>
									</li>
								</#list>
							</ul>
							<div class=\"rollBottom\">
								<p id=\"rollText\"></p>
								<ul class=\"circlBox\"></ul>
							</div>
							<div class=\"btns\">
								<div class=\"leftBtn\">
										<span></span>
								</div>
								<div class=\"rightBtn\">
										<span></span>
								</div>
							</div>
						</div>
					 </#if>
					 <#if \"${data.type}\" ==\"imgAndFont\" || \"${data.type}\" ==\"wordsList\">
						<div  id=\"rollFont\" style=\"display:inline-block;vertical-align: top;\">
							<#list data.obj as obj>
								<dd>
									<span class=\"project_01\">
									   <em>■</em>
										<a href=\"${ctxPath}/oa/info/insNews/get.do?pkId=${obj.newId}\" target=\"_blank\">
											${obj.subject}
										</a>
									</span>
									<span class=\"project_02\">
										<a href=\"###\">${obj.author}</a>
									</span>
									<span class=\"project_03\">
										<a title=\"${obj.createTime?string(\'yyyy-MM-dd\')}\" href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>
									</span>
								</dd>
							</#list>
						</div>
					 </#if>
                </dl>
            </div>
        </div>
    </div>
</div>',NEW_TYPE_='imgAndFont' where COL_ID_='2520000000390002';
-- add by shenzhongwen 2019-04-15 修改 JSAAS-67：在门户首页增加公司新闻与公告的带有标题图片滚动的栏目 end--------

-- add by shenzhongwen 2019-04-19 JSAAS-59:表单中的地址控件 begin--------

CREATE TABLE SYS_NATION_AREA
(
   ID_                  VARCHAR(64) NOT NULL,
   NATION_              VARCHAR(10) NOT NULL COMMENT '国家简称',
   AREA_CODE_           VARCHAR(20) NOT NULL COMMENT '地区代码',
   AREA_NAME_           VARCHAR(100) NOT NULL COMMENT '地区名称',
   AREA_NAME_PY_        VARCHAR(200) COMMENT '地区名称拼音',
   AREA_LEVEL_          TINYINT(3) NOT NULL COMMENT '地区级别',
   PROVINCE_            VARCHAR(100) NOT NULL COMMENT '省份',
   CITY_                VARCHAR(100) COMMENT '城市',
   COUNTY_              VARCHAR(100) COMMENT '县级',
   RANK_                INT(10) NOT NULL COMMENT '排序，值越大越前',
   STATUS_              TINYINT(3) NOT NULL COMMENT '状态，[1:显示, 2:隐藏]',
   PARENT_CODE_         VARCHAR(64) NOT NULL COMMENT '所属地区',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_NATION_AREA COMMENT '地区表';

--自定义SQL分类
INSERT INTO sys_tree(TREE_ID_, NAME_, PATH_, DEPTH_, PARENT_ID_, KEY_, CODE_, DESCP_, CAT_KEY_, SN_, DATA_SHOW_TYPE_, CHILDS_, USER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000020', '国家行政区', '0.2610000000000020.', 1, '', 'GJXZQ', '', '', 'CAT_CUSTOM_SQL', 1, 'FLAT', NULL, NULL, '1', '1', '2019-04-16 11:56:51', NULL, NULL);

--自定义SQL
INSERT INTO sys_custom_query(ID_, NAME_, KEY_, TABLE_NAME_, IS_PAGE_, PAGE_SIZE_, WHERE_FIELD_, RESULT_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_DIY_, SQL_, SQL_BUILD_TYPE_, TREE_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000023', '市级', 'CITY_LEVEL', '', 0, 20, '[{\"columnType\":\"varchar\",\"fieldName\":\"PARENT_CODE_\",\"comment\":\"所属地区\",\"valueSource\":\"param\"}]', '[{\"fieldName\":\"AREA_CODE_\",\"comment\":\"地区代码\"},{\"fieldName\":\"AREA_NAME_\",\"comment\":\"地区名称\"}]', NULL, '', 0, 'String parentCode = (String)params.get(\"PARENT_CODE_\");\nString sql=\"select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=2  and na.parent_code_ =\'\"+parentCode+\"\'  ORDER BY na.id_ desc\";\n return sql;', 'select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=2', 'sql', '2610000000000020', '1', '1', '2019-04-16 11:59:09', '1', '2019-04-18 09:23:46');
INSERT INTO sys_custom_query(ID_, NAME_, KEY_, TABLE_NAME_, IS_PAGE_, PAGE_SIZE_, WHERE_FIELD_, RESULT_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_DIY_, SQL_, SQL_BUILD_TYPE_, TREE_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000024', '区级(县)', 'COUNTY_LEVEL', '', 0, 20, '[{\"columnType\":\"varchar\",\"fieldName\":\"PARENT_CODE_\",\"comment\":\"所属地区\",\"valueSource\":\"param\"}]', '[{\"fieldName\":\"AREA_CODE_\",\"comment\":\"地区代码\"},{\"fieldName\":\"AREA_NAME_\",\"comment\":\"地区名称\"}]', NULL, '', 0, 'String parentCode = (String)params.get(\"PARENT_CODE_\");\nString sql=\"select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=3  and na.parent_code_ =\'\"+parentCode+\"\'  ORDER BY na.id_ desc\";\n return sql;', 'select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=3', 'sql', '2610000000000020', '1', '1', '2019-04-16 11:59:41', '1', '2019-04-18 09:23:27');
INSERT INTO sys_custom_query(ID_, NAME_, KEY_, TABLE_NAME_, IS_PAGE_, PAGE_SIZE_, WHERE_FIELD_, RESULT_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_DIY_, SQL_, SQL_BUILD_TYPE_, TREE_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000111', '省级(自治区/直辖市)', 'PROVINCE_LEVEL', '', 0, 20, NULL, '[{\"fieldName\":\"AREA_CODE_\",\"comment\":\"地区代码\"},{\"fieldName\":\"AREA_NAME_\",\"comment\":\"地区名称\"}]', NULL, '', 0, 'String sql=\"select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=1\";\n return sql;', 'select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=1', 'sql', '2610000000000020', '1', '1', '2019-04-16 14:25:08', '1', '2019-04-18 09:22:47');
-- add by shenzhongwen 2019-04-19 JSAAS-59:表单中的地址控件 end--------


-- add by shenzhongwen 2019-04-22 权限批量转移初始化SQL begin--------
INSERT INTO sys_transfer_setting(ID_, NAME_, STATUS_, SELECT_SQL_, UPDATE_SQL_, LOG_TEMPLET_, TENANT_ID_, CREATE_BY_) VALUES ('2610000000220003', '流程待办_执行人（候选人）', '1', 'import com.redxun.saweb.context.ContextUtil;\nString tenantId =ContextUtil.getCurrentTenantId();\nreturn \"SELECT V.ID_ id,V.ID_  \'主键\' ,V.DESCRIPTION_ name,V.DESCRIPTION_ \'流程名称\'  \"+\n           \" FROM \"+\n            \" ( \"+\n            \"    SELECT t.* FROM act_ru_task t WHERE t.ASSIGNEE_ = {authorId}  \"+\n             \"   UNION \"+\n             \"  SELECT a.* FROM act_ru_task a,act_ru_identitylink b WHERE a.ID_ = b.TASK_ID_ AND b.USER_ID_ = {authorId}\"+\n             \"  )  V \"+ \n        \" WHERE V.SUSPENSION_STATE_ != 404 and V.TENANT_ID_=\'\"+tenantId+\"\' \";', 'return \"UPDATE ACT_RU_TASK SET  ASSIGNEE_={targetPersonId} WHERE ID_ IN ({ids})\"', ' 执行人（候选人）{authorName} 的 {names}  待办转给了{targetPersonName}。', '1', '1');
INSERT INTO sys_transfer_setting(ID_, NAME_, STATUS_, SELECT_SQL_, UPDATE_SQL_, LOG_TEMPLET_, TENANT_ID_, CREATE_BY_) VALUES ('2610000000220625', '代理配置_代理人', '1', 'import com.redxun.saweb.context.ContextUtil;\nString tenantId =ContextUtil.getCurrentTenantId();\nreturn \"SELECT t.ID_ id,t.ID_  \'主键\' ,t.DESCRIPTION_ name,t.DESCRIPTION_ \'流程名称\',os.FULLNAME_ \'转办人\' FROM ACT_RU_TASK T,os_user os  \"+\n            \" WHERE T.AGENT_USER_ID_={authorId} AND T.TASK_TYPE_=\'AGENT\' and t.ASSIGNEE_ =os.user_id_ and t.TENANT_ID_=\'\"+tenantId+\"\'\";', 'return \"UPDATE ACT_RU_TASK SET  AGENT_USER_ID_={targetPersonId} WHERE ID_ IN ({ids})\";', '{authorName}代理的流程 {names} 重新转办给了 {targetPersonName}', '1', '1');
INSERT INTO sys_transfer_setting(ID_, NAME_, STATUS_, SELECT_SQL_, UPDATE_SQL_, LOG_TEMPLET_, TENANT_ID_, CREATE_BY_) VALUES ('2610000000220853', '代理配置_转办人', '1', 'import com.redxun.saweb.context.ContextUtil;\nString tenantId =ContextUtil.getCurrentTenantId();\nreturn \"SELECT t.ID_ id,t.ID_  \'主键\' ,t.DESCRIPTION_ name,t.DESCRIPTION_ \'流程名称\',os.FULLNAME_ \'当前代理人\' FROM ACT_RU_TASK T,os_user os WHERE T.ASSIGNEE_={authorId} and T.TASK_TYPE_ =\'AGENT\' and t.AGENT_USER_ID_ =os.user_id_ and t.TENANT_ID_=\'\"+tenantId+\"\' \"', 'return \"UPDATE ACT_RU_TASK SET  AGENT_USER_ID_={targetPersonId} WHERE ID_ IN ({ids})\";', '{authorName} 转办的流程 {names} 重新转办给了 {targetPersonName}', '1', '1');
INSERT INTO sys_transfer_setting(ID_, NAME_, STATUS_, SELECT_SQL_, UPDATE_SQL_, LOG_TEMPLET_, TENANT_ID_, CREATE_BY_) VALUES ('2610000000220876', '角色转移', '1', 'import com.redxun.saweb.context.ContextUtil;\nString tenantId =ContextUtil.getCurrentTenantId();\nreturn \"SELECT ou.NAME_ \'所属角色\',ou.NAME_ name,oi.INST_ID_ id ,oi.INST_ID_ \'主键\' FROM OS_GROUP ou inner JOIN OS_REL_INST oi on ou.GROUP_ID_=oi.PARTY1_  \"+\n           \" WHERE  oi.PARTY2_={authorId} and oi.REL_TYPE_=\'GROUP-USER\' and oi.TENANT_ID_=\'\"+tenantId+\"\' and ou.dim_id_=\'2\'\";', 'return \"UPDATE OS_REL_INST set PARTY2_={targetPersonId} where inst_id_ in({ids})\";', '{authorName} 所属角色：{names} 已经转移给了 {targetPersonName}', '1', '1');

alter table sys_transfer_log modify OP_DESCP_ varchar(2000);

-- add by shenzhongwen 2019-04-22 权限批量转移初始化SQL end--------


-- add by Louis 2019-03-12 增加栏位
ALTER TABLE `ins_portal_def`
	ADD COLUMN `IS_MOBILE_PORTAL_` VARCHAR(64) NULL DEFAULT NULL COMMENT '是否手机门户';
ALTER TABLE `ins_column_def`
	ADD COLUMN `IS_MOBILE_` VARCHAR(64) NULL DEFAULT NULL COMMENT '是否自定义移动栏目';

-- add by Louis 2019-03-12 新增手机门户类别表
CREATE TABLE `wx_mobile_portal` (
  `ID_` varchar(64) NOT NULL,
  `NAME_` varchar(64) DEFAULT NULL COMMENT '手机门户类别名称',
  `TYPE_ID_` varchar(64) DEFAULT NULL COMMENT '手机门户类别ID',
  `TENANT_ID_` varchar(64) DEFAULT NULL,
  `CREATE_BY_` varchar(64) DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `UPDATE_BY_` varchar(64) DEFAULT NULL,
  `UPDATE_TIME_` datetime DEFAULT NULL,
  `BTN_TYPE_` varchar(64) DEFAULT NULL COMMENT '应用类型',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `TYPE_ID_` (`TYPE_ID_`)
);

-- add by Louis 2019-03-12 新增手机门户类别按钮表
CREATE TABLE `wx_mobile_portal_button` (
  `ID_` varchar(64) NOT NULL,
  `KEY_` varchar(64) DEFAULT NULL COMMENT '键值',
  `NAME_` varchar(64) DEFAULT NULL COMMENT '按钮名称',
  `ICON_` varchar(200) DEFAULT NULL COMMENT '按钮图标',
  `URL_` varchar(2000) DEFAULT NULL COMMENT '按钮URL地址',
  `TYPE_ID_` varchar(64) DEFAULT NULL COMMENT '按钮所属类别ID',
  `TENANT_ID_` varchar(64) DEFAULT NULL,
  `CREATE_BY_` varchar(64) DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `UPDATE_BY_` varchar(64) DEFAULT NULL,
  `UPDATE_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `KEY_` (`KEY_`)
);

-- add by Louis 2019-03-12 新增栏位
ALTER TABLE `wx_mobile_portal_button`
	ADD COLUMN `APP_ID_`  varchar(64) NULL COMMENT '应用ID' AFTER `NAME_`;


-- add by zwc 2019-4-23 移动门户应用入口
ALTER TABLE `wx_mobile_portal_button`
ADD COLUMN `APP_TYPE_`  varchar(32) CHARACTER SET utf8 NULL COMMENT '应用类型' AFTER `SN_`,
ADD COLUMN `PORT_ALIAS_`  varchar(32) CHARACTER SET utf8 NULL COMMENT '入口别名' AFTER `APP_TYPE_`;

-- add by zwc 2019年3月15日09:42:05 手机门户应用序号
ALTER TABLE `wx_mobile_portal_button`
ADD COLUMN `SN_`  int NULL DEFAULT 0 COMMENT '序号' AFTER `TYPE_ID_`;


-- add by zwc 2019-4-28 16:12:48 移动门户功能
-- mColumnTypeSet 栏目类别设置url  /wx/portal/wxPortal/list.do
-- mPortalAppSet 门户应用设置url   /wx/portal/wxPortalBtn/list.do
-- mPortalPreview 预览url /oa/info/insPortalDef/mobilePortalIndex.do


-- add by ZYG 2019-04-25 数据库索引优化 end--------
ALTER TABLE bpm_node_jump ADD INDEX IDX_NODEJUMP_TASKID (TASK_ID_);
ALTER TABLE ACT_RU_TASK ADD INDEX IDX_RUTASK_PARENTTASKID (PARENT_TASK_ID_);
ALTER TABLE OS_USER ADD INDEX IDX_OSUSER_USER_NO_ (USER_NO_);
ALTER TABLE os_inst_users ADD INDEX IDX_INSTUSER_UID_ (USER_ID_);
ALTER TABLE OS_REL_INST ADD INDEX IDX_RELINST_PART1 (PARTY1_);
ALTER TABLE OS_REL_INST ADD INDEX IDX_RELINST_PART2 (PARTY2_);
ALTER TABLE BPM_SOL_FV ADD INDEX IDX_SOLFV_SOLDEF (SOL_ID_,ACT_DEF_ID_,NODE_ID_);
ALTER TABLE BPM_SOL_FV ADD INDEX IDX_SOLFV_SOLDEF (SOL_ID_,ACT_DEF_ID_,NODE_ID_);
ALTER TABLE BPM_SOL_USERGROUP ADD INDEX IDX_USERGROUP_SOLDEF (SOL_ID_,ACT_DEF_ID_,NODE_ID_);
ALTER TABLE BPM_REMIND_DEF ADD INDEX IDX_REMINDDEF_SOLDEF (SOL_ID_,ACT_DEF_ID_,NODE_ID_);
ALTER TABLE BPM_SOL_USER ADD INDEX IDX_SOLUSER_GROUPID (GROUP_ID_);
ALTER TABLE BPM_AGENT ADD INDEX IDX_BPMAGENT_USER (AGENT_USER_ID_);
ALTER TABLE bpm_agent_sol ADD INDEX IDX_BPMAGENTSOL_SOL (AGENT_ID_,SOL_ID_);
ALTER TABLE BPM_SOL_VAR ADD INDEX IDX_SOLVAR_SOL (SOL_ID_,ACT_DEF_ID_);
ALTER TABLE sys_seq_id ADD INDEX IDX_SEQID_ALIAS_ (ALIAS_,TENANT_ID_);
ALTER TABLE LOG_MODULE ADD INDEX IDX_LOGMODULE_MODULE_ (MODULE_,SUB_MODULE);
ALTER TABLE BPM_DEF ADD INDEX IDX_BPMDEF_ACTDEF (ACT_DEF_ID_);
ALTER TABLE SYS_INST ADD INDEX IDX_SYSINST_DOMAIN (DOMAIN_);
ALTER TABLE SYS_BO_RELATION ADD INDEX IDX_BORELATION_ENT (BO_ENTID_);
ALTER TABLE SYS_BO_RELATION ADD INDEX IDX_BORELATION_BODEF (BO_DEFID_);


-- 流程模板分类
INSERT INTO sys_tree_cat VALUES ('260000001183000', 'BPM_TEMPLATE_TREE', '流程模板分类树', 1, '', '1', '1', '2018-12-14', NULL, NULL);
INSERT INTO sys_tree (TREE_ID_, NAME_, PATH_, DEPTH_, PARENT_ID_, KEY_, CODE_, DESCP_, CAT_KEY_, SN_, DATA_SHOW_TYPE_, CHILDS_, USER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('260000001183001', '模版分类', '0.260000001183001.', '1', '', 'MBFL', 'tmp', '', 'BPM_TEMPLATE_TREE', '1', 'FLAT', NULL, NULL, '1', '1', '2019-03-08 09:14:55', NULL, NULL);

-- 分类绑定流程ID
alter table sys_tree add BIND_SOL_ID_ varchar(64);

-- 流程模板分类权限
CREATE TABLE bpm_sol_template_right (
  RIGHT_ID_ varchar(64) NOT NULL default '' COMMENT '权限ID',
  TREE_ID_ varchar(64) default NULL COMMENT '分类ID',
  GROUP_IDS_ varchar(512) default NULL COMMENT '组IDS',
  USER_IDS_ varchar(512) default NULL COMMENT '用户IDS',
  TENANT_ID_ varchar(64) default NULL COMMENT '租户机构ID',
  CREATE_BY_ varchar(64) default NULL COMMENT '创建人ID',
  CREATE_TIME_ date default NULL COMMENT '创建时间',
  UPDATE_BY_ varchar(64) default NULL COMMENT '修改人ID',
  UPDATE_TIME_ date default NULL COMMENT '更新时间',
  IS_ALL varchar(64) default NULL,
  PRIMARY KEY  (RIGHT_ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- add by zyg 2019/05/09 索引
ALTER TABLE bpm_node_jump ADD INDEX IDX_NODEJUMP_HANDLER (HANDLER_ID_);
ALTER TABLE act_ru_task ADD INDEX IDX_TASK_ASIGNEE (ASSIGNEE_) ;
ALTER TABLE act_ru_task ADD INDEX IDX_TASK_AGENT (AGENT_USER_ID_) ;

-- add by hj 增加流程方案图标 和流程方案图标颜色
alter table bpm_solution add  ICON_ VARCHAR(64) COMMENT '流程方案图标';
alter table bpm_solution add  COLOR_ VARCHAR(64) COMMENT '流程方案图标颜色';

-- add by hj 常用流程栏目初始化数据
INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TREE_ID_, TABGROUPS_, IS_PUBLIC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, NEW_TYPE_, IS_MOBILE_) VALUES ('2610000000630180', '常用流程', 'cylc', '/oa/personal/bpmSolApply/myList.do', NULL, '<div class=\"process\">\n	<header>\n      	<p>常用流程</p>\n      	<div>\n        	<em onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\">MORE</em>\n     	 </div>\n  	</header>\n    <ol>\n      	<#list data.obj as obj>\n     	 <li onclick=\"startRowBySolId(\'${obj.solId}\')\">\n           		<span>	\n                   <#if  \"${obj.icon}\"??>\n                    	 <i class=\"iconfont ${obj.icon}\" style=\"color:${obj.color}\"></i>\n                    </#if>\n      			<#if  \"${obj.icon}\"== null >\n                    	 <i class=\"iconfont icon-fangyuan-\" style=\"color:#6399fc;\"></i>\n                    </#if>\n           		<p>${obj.solName}</p>\n                  </span>	\n      	</li>\n          </#list>\n    </ol>\n</div>', 'portalScript.getMyCommonInst(colId)', NULL, '', '', '', 'list', '1', '1', '2019-05-14 15:24:13', '1', '2019-05-16 09:49:35', '', '0');


