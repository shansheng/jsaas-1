
/*==============================================================*/
/* Table: SYS_LIST_SOL                                          */
/*==============================================================*/
CREATE TABLE SYS_LIST_SOL
(
   SOL_ID_              VARCHAR(64) NOT NULL COMMENT '解决方案ID',
   KEY_                 VARCHAR(100) NOT NULL COMMENT '标识健',
   NAME_                VARCHAR(128) NOT NULL COMMENT '名称',
   DESCP_               VARCHAR(256) COMMENT '描述',
   RIGHT_CONFIGS_       TEXT NOT NULL COMMENT '权限配置',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (SOL_ID_)
);

ALTER TABLE SYS_LIST_SOL COMMENT '系统列表方案';


/*==============================================================*/
/* Table: SYS_BO_LIST                                           */
/*==============================================================*/
CREATE TABLE SYS_BO_LIST
(
   ID_                  VARCHAR(64) NOT NULL COMMENT 'ID',
   SOL_ID_              VARCHAR(64) COMMENT '解决方案ID',
   NAME_                VARCHAR(200) NOT NULL COMMENT '名称',
   KEY_                 VARCHAR(120) NOT NULL COMMENT '标识键',
   DESCP_               VARCHAR(500) COMMENT '描述',
   ID_FIELD_            VARCHAR(60) COMMENT '主键字段',
   URL_                 VARCHAR(256) COMMENT '数据地址',
   MULTI_SELECT_        VARCHAR(20) COMMENT '是否多选择',
   IS_LEFT_TREE_        VARCHAR(20) COMMENT '是否显示左树',
   LEFT_NAV_            VARCHAR(80) COMMENT '左树SQL，格式如"select * from abc"##"select * from abc2"',
   LEFT_TREE_JSON_      TEXT COMMENT '左树字段映射',
   SQL_                 VARCHAR(512) NOT NULL COMMENT 'SQL语句',
   DB_AS_               VARCHAR(64) COMMENT '数据源ID',
   FIELDS_JSON_         TEXT COMMENT '列字段JSON',
   COLS_JSON_           TEXT COMMENT '列的JSON',
   LIST_HTML_           TEXT COMMENT '列表显示模板',
   SEARCH_JSON_         TEXT COMMENT '搜索条件HTML',
   BPM_SOL_ID_          VARCHAR(64) COMMENT '绑定流程方案',
   FORM_ALIAS_          VARCHAR(64) COMMENT '绑定表单方案',
   TOP_BTNS_JSON_       TEXT COMMENT '头部按钮配置',
   BODY_SCRIPT_         TEXT COMMENT '脚本JS',
   IS_DIALOG_           VARCHAR(20) COMMENT '是否对话框',
   IS_PAGE_             VARCHAR(20) COMMENT '是否分页',
   IS_EXPORT_           VARCHAR(20) COMMENT '是否允许导出',
   HEIGHT_              INT COMMENT '高',
   WIDTH_               INT COMMENT '宽',
   ENABLE_FLOW_         VARCHAR(20) COMMENT '是否启用流程',
   IS_GEN_              VARCHAR(20) COMMENT '是否已产生HTML',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID_)
);

ALTER TABLE SYS_BO_LIST COMMENT '系统自定义业务管理列表';

ALTER TABLE SYS_BO_LIST ADD CONSTRAINT FK_SYS_BO_LIST_R_LIS_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES SYS_LIST_SOL (SOL_ID_) ON DELETE SET NULL ON UPDATE RESTRICT;
