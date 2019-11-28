/*==============================================================*/
/* DBMS name:      ORACLE Version 10gR2                         */
/* Created on:     2017/8/9 星期三 下午 4:32:25                      */
/*==============================================================*/


DROP INDEX IDX_INSTDATA_INSTID;

/*==============================================================*/
/* Table: BPM_AGENT                                             */
/*==============================================================*/
CREATE TABLE BPM_AGENT  (
   AGENT_ID_            VARCHAR2(64)                    NOT NULL,
   SUBJECT_             VARCHAR2(100)                   NOT NULL,
   TO_USER_ID_          VARCHAR2(64)                    NOT NULL,
   AGENT_USER_ID_       VARCHAR2(64)                    NOT NULL,
   START_TIME_          TIMESTAMP                            NOT NULL,
   END_TIME_            TIMESTAMP                            NOT NULL,
   TYPE_                VARCHAR2(20)                    NOT NULL,
   STATUS_              VARCHAR2(20)                    NOT NULL,
   DESCP_               VARCHAR2(300),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_AGENT PRIMARY KEY (AGENT_ID_)
);

COMMENT ON TABLE BPM_AGENT IS
'流程方案代理';

COMMENT ON COLUMN BPM_AGENT.AGENT_ID_ IS
'代理ID';

COMMENT ON COLUMN BPM_AGENT.TO_USER_ID_ IS
'代理人ID';

COMMENT ON COLUMN BPM_AGENT.AGENT_USER_ID_ IS
'被代理人ID';

COMMENT ON COLUMN BPM_AGENT.START_TIME_ IS
'开始时间';

COMMENT ON COLUMN BPM_AGENT.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN BPM_AGENT.TYPE_ IS
'代理类型
ALL=全部代理
PART=部分代理';

COMMENT ON COLUMN BPM_AGENT.STATUS_ IS
'状态
ENABLED
DISABLED';

COMMENT ON COLUMN BPM_AGENT.DESCP_ IS
'描述';

COMMENT ON COLUMN BPM_AGENT.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_AGENT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_AGENT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_AGENT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_AGENT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_AGENT_SOL                                         */
/*==============================================================*/
CREATE TABLE BPM_AGENT_SOL  (
   AS_ID_               VARCHAR2(64)                    NOT NULL,
   AGENT_ID_            VARCHAR2(64),
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   SOL_NAME_            VARCHAR2(100)                   NOT NULL,
   AGENT_TYPE_          VARCHAR2(20),
   CONDITION_           CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_AGENT_SOL PRIMARY KEY (AS_ID_)
);

COMMENT ON TABLE BPM_AGENT_SOL IS
'部分代理的流程方案';

COMMENT ON COLUMN BPM_AGENT_SOL.AS_ID_ IS
'代理方案ID';

COMMENT ON COLUMN BPM_AGENT_SOL.AGENT_ID_ IS
'代理ID';

COMMENT ON COLUMN BPM_AGENT_SOL.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_AGENT_SOL.SOL_NAME_ IS
'解决方案名称';

COMMENT ON COLUMN BPM_AGENT_SOL.AGENT_TYPE_ IS
'代理类型
全部=ALL
条件代理=PART';

COMMENT ON COLUMN BPM_AGENT_SOL.CONDITION_ IS
'代理条件';

COMMENT ON COLUMN BPM_AGENT_SOL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_AGENT_SOL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_AGENT_SOL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_AGENT_SOL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_AGENT_SOL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_AUTH_DEF                                          */
/*==============================================================*/
CREATE TABLE BPM_AUTH_DEF  (
   ID_                  VARCHAR2(50),
   SOL_ID_              VARCHAR2(50),
   RIGHT_JSON_          VARCHAR2(1000),
   SETTING_ID_          VARCHAR2(50),
   TREE_ID_             VARCHAR2(50)
);

COMMENT ON TABLE BPM_AUTH_DEF IS
'授权流程定义';

COMMENT ON COLUMN BPM_AUTH_DEF.ID_ IS
'主键';

COMMENT ON COLUMN BPM_AUTH_DEF.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_AUTH_DEF.RIGHT_JSON_ IS
'权限JSON';

COMMENT ON COLUMN BPM_AUTH_DEF.TREE_ID_ IS
'分类ID';

/*==============================================================*/
/* Table: BPM_AUTH_RIGHTS                                       */
/*==============================================================*/
CREATE TABLE BPM_AUTH_RIGHTS  (
   ID_                  VARCHAR2(50),
   RIGHT_TYPE_          VARCHAR2(50),
   TYPE_                VARCHAR2(50),
   AUTH_ID_             VARCHAR2(50),
   AUTH_NAME_           VARCHAR2(50),
   SETTING_ID_          VARCHAR2(50)
);

COMMENT ON TABLE BPM_AUTH_RIGHTS IS
'流程定义授权';

COMMENT ON COLUMN BPM_AUTH_RIGHTS.ID_ IS
'主键';

COMMENT ON COLUMN BPM_AUTH_RIGHTS.RIGHT_TYPE_ IS
'权限类型(def,流程定义,inst,流程实例,task,待办任务,start,发起流程)';

COMMENT ON COLUMN BPM_AUTH_RIGHTS.TYPE_ IS
'授权类型(all,全部,user,用户,group,用户组)';

COMMENT ON COLUMN BPM_AUTH_RIGHTS.AUTH_ID_ IS
'授权对象ID';

COMMENT ON COLUMN BPM_AUTH_RIGHTS.AUTH_NAME_ IS
'授权对象名称';

/*==============================================================*/
/* Table: BPM_AUTH_SETTING                                      */
/*==============================================================*/
CREATE TABLE BPM_AUTH_SETTING  (
   ID_                  VARCHAR2(50)                    NOT NULL,
   NAME_                VARCHAR2(50),
   ENABLE_              VARCHAR2(10),
   TYPE_                VARCHAR2(10),
   TENANT_ID_           VARCHAR2(50),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(50),
   UPDATE_BY_           VARCHAR2(50),
   CONSTRAINT PK_BPM_AUTH_SETTING PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_AUTH_SETTING IS
'流程定义授权';

COMMENT ON COLUMN BPM_AUTH_SETTING.ID_ IS
'主键';

COMMENT ON COLUMN BPM_AUTH_SETTING.NAME_ IS
'授权名称';

COMMENT ON COLUMN BPM_AUTH_SETTING.ENABLE_ IS
'是否允许';

COMMENT ON COLUMN BPM_AUTH_SETTING.TYPE_ IS
'授权类型(sol,解决方案,form,表单)';

COMMENT ON COLUMN BPM_AUTH_SETTING.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN BPM_AUTH_SETTING.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_AUTH_SETTING.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_AUTH_SETTING.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN BPM_AUTH_SETTING.UPDATE_BY_ IS
'更新人';

/*==============================================================*/
/* Table: BPM_BUS_LINK                                          */
/*==============================================================*/
CREATE TABLE BPM_BUS_LINK  (
   BPM_BUS_LINK_ID_     VARCHAR2(64)                    NOT NULL,
   FORM_INST_ID_        VARCHAR2(64),
   INST_ID_             VARCHAR2(64),
   LINK_PK_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_BUS_LINK PRIMARY KEY (BPM_BUS_LINK_ID_)
);

COMMENT ON TABLE BPM_BUS_LINK IS
'BPM_BUS_LINK第三方业务链接表';

COMMENT ON COLUMN BPM_BUS_LINK.BPM_BUS_LINK_ID_ IS
'主键';

COMMENT ON COLUMN BPM_BUS_LINK.FORM_INST_ID_ IS
'表单实例ID';

COMMENT ON COLUMN BPM_BUS_LINK.INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_BUS_LINK.LINK_PK_ IS
'第三方物理表主键ID';

COMMENT ON COLUMN BPM_BUS_LINK.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN BPM_BUS_LINK.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_BUS_LINK.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_BUS_LINK.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_BUS_LINK.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_CHECK_FILE                                        */
/*==============================================================*/
CREATE TABLE BPM_CHECK_FILE  (
   FILE_ID_             VARCHAR2(64)                    NOT NULL,
   FILE_NAME_           VARCHAR2(255),
   JUMP_ID_             VARCHAR2(64)                    NOT NULL,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_BPM_CHECK_FILE PRIMARY KEY (FILE_ID_, JUMP_ID_)
);

COMMENT ON TABLE BPM_CHECK_FILE IS
'审批意见附件';

COMMENT ON COLUMN BPM_CHECK_FILE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_CHECK_FILE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_CHECK_FILE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_CHECK_FILE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_CHECK_FILE.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: BPM_DEF                                               */
/*==============================================================*/
CREATE TABLE BPM_DEF  (
   DEF_ID_              VARCHAR2(64)                    NOT NULL,
   "TREE_ID_"           VARCHAR2(64),
   SUBJECT_             VARCHAR2(255)                   NOT NULL,
   DESCP_               VARCHAR2(1024),
   KEY_                 VARCHAR2(255)                   NOT NULL,
   ACT_DEF_ID_          VARCHAR2(255),
   ACT_DEP_ID_          VARCHAR2(255),
   STATUS_              VARCHAR2(20)                    NOT NULL,
   VERSION_             INTEGER                         NOT NULL,
   IS_MAIN_             VARCHAR2(20),
   SETTING_             CLOB,
   MODEL_ID_            VARCHAR2(64)                    NOT NULL,
   MAIN_DEF_ID_         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_DEF PRIMARY KEY (DEF_ID_)
);

COMMENT ON TABLE BPM_DEF IS
'流程定义';

COMMENT ON COLUMN BPM_DEF."TREE_ID_" IS
'分类Id';

COMMENT ON COLUMN BPM_DEF.SUBJECT_ IS
'标题';

COMMENT ON COLUMN BPM_DEF.DESCP_ IS
'描述';

COMMENT ON COLUMN BPM_DEF.KEY_ IS
'标识Key';

COMMENT ON COLUMN BPM_DEF.ACT_DEF_ID_ IS
'Activiti流程定义ID';

COMMENT ON COLUMN BPM_DEF.ACT_DEP_ID_ IS
'ACT流程发布ID';

COMMENT ON COLUMN BPM_DEF.STATUS_ IS
'状态';

COMMENT ON COLUMN BPM_DEF.VERSION_ IS
'版本号';

COMMENT ON COLUMN BPM_DEF.IS_MAIN_ IS
'主版本';

COMMENT ON COLUMN BPM_DEF.SETTING_ IS
'定义属性设置';

COMMENT ON COLUMN BPM_DEF.MODEL_ID_ IS
'设计模型ID
关联Activiti中的ACT_RE_MODEL表主键';

COMMENT ON COLUMN BPM_DEF.MAIN_DEF_ID_ IS
'主定义ID';

COMMENT ON COLUMN BPM_DEF.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_DEF.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_DEF.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_DEF.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_DEF.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_FM_ATT                                            */
/*==============================================================*/
CREATE TABLE BPM_FM_ATT  (
   ATT_ID_              VARCHAR2(64)                    NOT NULL,
   TITLE_               VARCHAR2(64)                    NOT NULL,
   KEY_                 VARCHAR2(100)                   NOT NULL,
   DATA_TYPE_           VARCHAR2(64)                    NOT NULL,
   TYPE_                VARCHAR2(64),
   DEF_VAL_             VARCHAR2(255),
   REQUIRED_            VARCHAR2(20)                    NOT NULL,
   LEN_                 INTEGER,
   PREC_                INTEGER,
   SN_                  INTEGER                         NOT NULL,
   GROUP_TITLE_         VARCHAR2(100),
   REMARK_              VARCHAR2(512),
   CTL_TYPE_            VARCHAR2(50),
   CTL_CONFIG_          VARCHAR2(512),
   REF_FM_ID_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_FM_ATT PRIMARY KEY (ATT_ID_)
);

COMMENT ON TABLE BPM_FM_ATT IS
'数据模型属性定义';

COMMENT ON COLUMN BPM_FM_ATT.TITLE_ IS
'属性标签';

COMMENT ON COLUMN BPM_FM_ATT.KEY_ IS
'属性标识';

COMMENT ON COLUMN BPM_FM_ATT.DATA_TYPE_ IS
'属性数据类型
String
Date
Float
Double

元数据类型或外部模型ID';

COMMENT ON COLUMN BPM_FM_ATT.TYPE_ IS
'属性类型
元数据=META
集合=COLLECTION-MODEL
外部数据模型=EXT_MODEL';

COMMENT ON COLUMN BPM_FM_ATT.DEF_VAL_ IS
'默认值';

COMMENT ON COLUMN BPM_FM_ATT.REQUIRED_ IS
'是否必须';

COMMENT ON COLUMN BPM_FM_ATT.LEN_ IS
'长度';

COMMENT ON COLUMN BPM_FM_ATT.PREC_ IS
'精度(小数位)';

COMMENT ON COLUMN BPM_FM_ATT.SN_ IS
'序号';

COMMENT ON COLUMN BPM_FM_ATT.GROUP_TITLE_ IS
'分组标题';

COMMENT ON COLUMN BPM_FM_ATT.REMARK_ IS
'属性帮助描述';

COMMENT ON COLUMN BPM_FM_ATT.CTL_TYPE_ IS
'控件类型
界面绑定的控件类型';

COMMENT ON COLUMN BPM_FM_ATT.CTL_CONFIG_ IS
'控件配置参数(JSON配置)';

COMMENT ON COLUMN BPM_FM_ATT.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_FM_ATT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_FM_ATT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_FM_ATT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_FM_ATT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_FORMBO_SETTING                                    */
/*==============================================================*/
CREATE TABLE BPM_FORMBO_SETTING  (
   ID_                  VARCHAR2(64),
   SOL_ID_              VARCHAR2(64),
   NODE_ID_             VARCHAR2(64),
   ENT_NAME_            VARCHAR2(64),
   ATTR_NAME_           VARCHAR2(64),
   INIT_SETTING_        VARCHAR2(500),
   SAVE_SETTING_        VARCHAR2(500),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64)
);

COMMENT ON TABLE BPM_FORMBO_SETTING IS
'表单数据配置';

COMMENT ON COLUMN BPM_FORMBO_SETTING.ID_ IS
'主键';

COMMENT ON COLUMN BPM_FORMBO_SETTING.SOL_ID_ IS
'节点配置ID';

COMMENT ON COLUMN BPM_FORMBO_SETTING.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_FORMBO_SETTING.ENT_NAME_ IS
'实体名称';

COMMENT ON COLUMN BPM_FORMBO_SETTING.ATTR_NAME_ IS
'属性名称';

COMMENT ON COLUMN BPM_FORMBO_SETTING.INIT_SETTING_ IS
'初始设定';

COMMENT ON COLUMN BPM_FORMBO_SETTING.SAVE_SETTING_ IS
'保存时设定';

COMMENT ON COLUMN BPM_FORMBO_SETTING.CREATE_TIME_ IS
'创建时间';

/*==============================================================*/
/* Table: BPM_FORM_INST                                         */
/*==============================================================*/
CREATE TABLE BPM_FORM_INST  (
   FORM_INST_ID_        VARCHAR2(64)                    NOT NULL,
   SUBJECT_             VARCHAR2(127),
   INST_ID_             VARCHAR2(64),
   ACT_INST_ID_         VARCHAR2(64),
   ACT_DEF_ID_          VARCHAR2(64),
   DEF_ID_              VARCHAR2(64),
   SOL_ID_              VARCHAR2(64),
   FM_ID_               VARCHAR2(64),
   FM_VIEW_ID_          VARCHAR2(64),
   STATUS_              VARCHAR2(20),
   JSON_DATA_           CLOB,
   IS_PERSIST_          VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_FORM_INST PRIMARY KEY (FORM_INST_ID_)
);

COMMENT ON TABLE BPM_FORM_INST IS
'流程数据模型实例';

COMMENT ON COLUMN BPM_FORM_INST.SUBJECT_ IS
'实例标题';

COMMENT ON COLUMN BPM_FORM_INST.INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_FORM_INST.ACT_INST_ID_ IS
'ACT实例ID';

COMMENT ON COLUMN BPM_FORM_INST.ACT_DEF_ID_ IS
'ACT定义ID';

COMMENT ON COLUMN BPM_FORM_INST.DEF_ID_ IS
'流程定义ID';

COMMENT ON COLUMN BPM_FORM_INST.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_FORM_INST.FM_ID_ IS
'数据模型ID';

COMMENT ON COLUMN BPM_FORM_INST.FM_VIEW_ID_ IS
'表单视图ID';

COMMENT ON COLUMN BPM_FORM_INST.STATUS_ IS
'状态';

COMMENT ON COLUMN BPM_FORM_INST.JSON_DATA_ IS
'数据JSON';

COMMENT ON COLUMN BPM_FORM_INST.IS_PERSIST_ IS
'是否持久化';

COMMENT ON COLUMN BPM_FORM_INST.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_FORM_INST.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_FORM_INST.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_FORM_INST.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_FORM_INST.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_FORM_TEMPLATE                                     */
/*==============================================================*/
CREATE TABLE BPM_FORM_TEMPLATE  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(50),
   ALIAS_               VARCHAR2(50),
   TEMPLATE_            CLOB,
   TYPE_                VARCHAR2(50),
   INIT_                SMALLINT,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CATEGORY_            VARCHAR2(50),
   CONSTRAINT PK_BPM_FORM_TEMPLATE PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_FORM_TEMPLATE IS
'表单模版';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.ID_ IS
'主键';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.NAME_ IS
'模版名称';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.ALIAS_ IS
'别名';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.TEMPLATE_ IS
'模版';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.TYPE_ IS
'模版类型 (pc,mobile)';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.INIT_ IS
'初始添加的(1是,0否)';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_FORM_TEMPLATE.CATEGORY_ IS
'类别';

/*==============================================================*/
/* Table: BPM_FORM_VIEW                                         */
/*==============================================================*/
CREATE TABLE BPM_FORM_VIEW  (
   VIEW_ID_             VARCHAR2(64)                    NOT NULL,
   TREE_ID_             VARCHAR2(64),
   NAME_                VARCHAR2(255)                   NOT NULL,
   KEY_                 VARCHAR2(100)                   NOT NULL,
   TYPE_                VARCHAR2(50)                    NOT NULL,
   RENDER_URL_          VARCHAR2(255),
   VERSION_             INTEGER                         NOT NULL,
   IS_MAIN_             VARCHAR2(20)                    NOT NULL,
   MAIN_VIEW_ID_        VARCHAR2(64),
   DESCP_               CLOB,
   STATUS_              VARCHAR2(20)                    NOT NULL,
   IS_BIND_MD_          VARCHAR2(20),
   TEMPLATE_VIEW_       CLOB,
   TEMPLATE_ID_         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   BO_DEFID_            VARCHAR2(20),
   TITLE_               VARCHAR2(1000),
   BUTTON_DEF_          VARCHAR2(1000),
   CONSTRAINT PK_BPM_FORM_VIEW PRIMARY KEY (VIEW_ID_)
);

COMMENT ON TABLE BPM_FORM_VIEW IS
'业务表单视图';

COMMENT ON COLUMN BPM_FORM_VIEW.TREE_ID_ IS
'分类ID';

COMMENT ON COLUMN BPM_FORM_VIEW.NAME_ IS
'名称';

COMMENT ON COLUMN BPM_FORM_VIEW.KEY_ IS
'标识键';

COMMENT ON COLUMN BPM_FORM_VIEW.TYPE_ IS
'类型
ONLINE=在线表单
URL=线下定制表单';

COMMENT ON COLUMN BPM_FORM_VIEW.RENDER_URL_ IS
'表单展示URL';

COMMENT ON COLUMN BPM_FORM_VIEW.IS_MAIN_ IS
'是否为主版本';

COMMENT ON COLUMN BPM_FORM_VIEW.MAIN_VIEW_ID_ IS
'隶属主版本视图ID';

COMMENT ON COLUMN BPM_FORM_VIEW.DESCP_ IS
'视图说明';

COMMENT ON COLUMN BPM_FORM_VIEW.STATUS_ IS
'状态';

COMMENT ON COLUMN BPM_FORM_VIEW.IS_BIND_MD_ IS
'是否绑定业务模型
YES=是
NO=否';

COMMENT ON COLUMN BPM_FORM_VIEW.TEMPLATE_VIEW_ IS
'模板类型ID
用于生成视图的模板类型ID';

COMMENT ON COLUMN BPM_FORM_VIEW.TEMPLATE_ID_ IS
'模板内容';

COMMENT ON COLUMN BPM_FORM_VIEW.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_FORM_VIEW.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_FORM_VIEW.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_FORM_VIEW.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_FORM_VIEW.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_FORM_VIEW.BO_DEFID_ IS
'BO定义ID';

COMMENT ON COLUMN BPM_FORM_VIEW.TITLE_ IS
'标题';

/*==============================================================*/
/* Table: BPM_FV_RIGHT                                          */
/*==============================================================*/
CREATE TABLE BPM_FV_RIGHT  (
   RIGHT_ID_            VARCHAR2(64)                    NOT NULL,
   VIEW_ID_             VARCHAR2(64),
   ACT_DEF_ID_          VARCHAR2(64),
   FIELD_NAME_          VARCHAR2(255)                   NOT NULL,
   FIELD_LABEL_         VARCHAR2(255)                   NOT NULL,
   EDIT_                CLOB,
   EDIT_DF_             CLOB,
   READ_                CLOB,
   READ_DF_             CLOB,
   HIDE_                CLOB,
   HIDE_DF_             CLOB,
   SN_                  INTEGER,
   NODE_ID_             VARCHAR2(64),
   SOL_ID_              VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TYPE_                VARCHAR2(64),
   "FORM_ALIAS_"        VARCHAR2(64),
   CONSTRAINT PK_BPM_FV_RIGHT PRIMARY KEY (RIGHT_ID_)
);

COMMENT ON TABLE BPM_FV_RIGHT IS
'表单视图字段权限';

COMMENT ON COLUMN BPM_FV_RIGHT.RIGHT_ID_ IS
'权限ID';

COMMENT ON COLUMN BPM_FV_RIGHT.VIEW_ID_ IS
'业务表单视图ID';

COMMENT ON COLUMN BPM_FV_RIGHT.ACT_DEF_ID_ IS
'Activiti定义ID';

COMMENT ON COLUMN BPM_FV_RIGHT.FIELD_NAME_ IS
'字段路径';

COMMENT ON COLUMN BPM_FV_RIGHT.EDIT_ IS
'编辑权限描述';

COMMENT ON COLUMN BPM_FV_RIGHT.EDIT_DF_ IS
'编辑权限
格式：
{
all:false,
userIds:'''',
unames:'''',
groupIds:'''',
gnames:''''
}';

COMMENT ON COLUMN BPM_FV_RIGHT.READ_ IS
'只读权限';

COMMENT ON COLUMN BPM_FV_RIGHT.READ_DF_ IS
'只读权限描述';

COMMENT ON COLUMN BPM_FV_RIGHT.HIDE_ IS
'隐藏权限';

COMMENT ON COLUMN BPM_FV_RIGHT.HIDE_DF_ IS
'隐藏权限描述';

COMMENT ON COLUMN BPM_FV_RIGHT.SN_ IS
'序号';

COMMENT ON COLUMN BPM_FV_RIGHT.NODE_ID_ IS
'流程节点ID';

COMMENT ON COLUMN BPM_FV_RIGHT.SOL_ID_ IS
'流程解决方案Id';

COMMENT ON COLUMN BPM_FV_RIGHT.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_FV_RIGHT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_FV_RIGHT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_FV_RIGHT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_FV_RIGHT.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_FV_RIGHT.TYPE_ IS
'权限类型(field:字段,opinion:意见)';

COMMENT ON COLUMN BPM_FV_RIGHT."FORM_ALIAS_" IS
'表单别名';

/*==============================================================*/
/* Table: BPM_GROUP_SCRIPT                                      */
/*==============================================================*/
CREATE TABLE BPM_GROUP_SCRIPT  (
   SCRIPT_ID_           VARCHAR2(64),
   CLASS_NAME_          VARCHAR2(200),
   CLASS_INS_NAME_      VARCHAR2(200),
   METHOD_NAME_         VARCHAR2(64),
   METHOD_DESC_         VARCHAR2(200),
   RETURN_TYPE_         VARCHAR2(64),
   ARGUMENT_            VARCHAR2(1000),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP
);

COMMENT ON TABLE BPM_GROUP_SCRIPT IS
'人员脚本';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.SCRIPT_ID_ IS
'主键';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.CLASS_NAME_ IS
'类名';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.CLASS_INS_NAME_ IS
'类实例名';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.METHOD_NAME_ IS
'方法名';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.METHOD_DESC_ IS
'方法描述';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.RETURN_TYPE_ IS
'返回类型';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.ARGUMENT_ IS
'参数定义';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN BPM_GROUP_SCRIPT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_INST                                              */
/*==============================================================*/
CREATE TABLE BPM_INST  (
   INST_ID_             VARCHAR2(64)                    NOT NULL,
   DEF_ID_              VARCHAR2(64)                    NOT NULL,
   ACT_INST_ID_         VARCHAR2(64),
   ACT_DEF_ID_          VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   INST_NO_             VARCHAR2(50),
   IS_USE_BMODEL_       VARCHAR2(20),
   SUBJECT_             VARCHAR2(255),
   STATUS_              VARCHAR2(20),
   VERSION_             INTEGER,
   BUS_KEY_             VARCHAR2(64),
   CHECK_FILE_ID_       VARCHAR2(64),
   FORM_INST_ID_        VARCHAR2(64),
   IS_TEST_             VARCHAR2(20),
   ERRORS_              CLOB,
   END_TIME_            TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   DATA_SAVE_MODE_      VARCHAR2(10),
   BO_DEF_ID_           VARCHAR2(20),
   CONSTRAINT PK_BPM_INST PRIMARY KEY (INST_ID_)
);

COMMENT ON TABLE BPM_INST IS
'流程实例';

COMMENT ON COLUMN BPM_INST.DEF_ID_ IS
'流程定义ID';

COMMENT ON COLUMN BPM_INST.ACT_INST_ID_ IS
'Activiti实例ID';

COMMENT ON COLUMN BPM_INST.ACT_DEF_ID_ IS
'Activiti定义ID';

COMMENT ON COLUMN BPM_INST.SOL_ID_ IS
'解决方案ID_';

COMMENT ON COLUMN BPM_INST.INST_NO_ IS
'流程实例工单号';

COMMENT ON COLUMN BPM_INST.IS_USE_BMODEL_ IS
'单独使用业务模型
YES=表示不带任何表单视图';

COMMENT ON COLUMN BPM_INST.SUBJECT_ IS
'标题';

COMMENT ON COLUMN BPM_INST.STATUS_ IS
'运行状态';

COMMENT ON COLUMN BPM_INST.VERSION_ IS
'版本';

COMMENT ON COLUMN BPM_INST.BUS_KEY_ IS
'业务键ID';

COMMENT ON COLUMN BPM_INST.CHECK_FILE_ID_ IS
'审批正文依据ID';

COMMENT ON COLUMN BPM_INST.FORM_INST_ID_ IS
'业务表单数据ID';

COMMENT ON COLUMN BPM_INST.IS_TEST_ IS
'是否为测试';

COMMENT ON COLUMN BPM_INST.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN BPM_INST.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_INST.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_INST.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_INST.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_INST.DATA_SAVE_MODE_ IS
'数据保存模式(all,json,db)';

COMMENT ON COLUMN BPM_INST.BO_DEF_ID_ IS
'BO定义ID';

/*==============================================================*/
/* Table: BPM_INST_ATTACH                                       */
/*==============================================================*/
CREATE TABLE BPM_INST_ATTACH  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   INST_ID_             VARCHAR2(64)                    NOT NULL,
   FILE_ID_             VARCHAR2(64)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_INST_ATTACH PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_INST_ATTACH IS
'流程实例附件';

COMMENT ON COLUMN BPM_INST_ATTACH.INST_ID_ IS
'实例Id';

COMMENT ON COLUMN BPM_INST_ATTACH.FILE_ID_ IS
'文件ID';

COMMENT ON COLUMN BPM_INST_ATTACH.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_INST_ATTACH.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_INST_ATTACH.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST_ATTACH.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_INST_ATTACH.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_INST_CC                                           */
/*==============================================================*/
CREATE TABLE BPM_INST_CC  (
   CC_ID_               VARCHAR2(64)                    NOT NULL,
   SUBJECT_             VARCHAR2(255)                   NOT NULL,
   NODE_ID_             VARCHAR2(255),
   NODE_NAME_           VARCHAR2(255),
   FROM_USER_           VARCHAR2(50),
   FROM_USER_ID_        VARCHAR2(255),
   SOL_ID_              VARCHAR2(64),
   TREE_ID_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   INST_ID_             VARCHAR2(64),
   CONSTRAINT PK_BPM_INST_CC PRIMARY KEY (CC_ID_)
);

COMMENT ON TABLE BPM_INST_CC IS
'流程抄送';

COMMENT ON COLUMN BPM_INST_CC.SUBJECT_ IS
'抄送标题';

COMMENT ON COLUMN BPM_INST_CC.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_INST_CC.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_INST_CC.FROM_USER_ IS
'抄送人';

COMMENT ON COLUMN BPM_INST_CC.FROM_USER_ID_ IS
'抄送人ID';

COMMENT ON COLUMN BPM_INST_CC.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_INST_CC.TREE_ID_ IS
'分类ID';

COMMENT ON COLUMN BPM_INST_CC.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_INST_CC.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_INST_CC.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST_CC.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_INST_CC.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_INST_CP                                           */
/*==============================================================*/
CREATE TABLE BPM_INST_CP  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64),
   GROUP_ID_            VARCHAR2(64),
   IS_READ_             VARCHAR2(10),
   CC_ID_               VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_INST_CP PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_INST_CP IS
'流程抄送人员';

COMMENT ON COLUMN BPM_INST_CP.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN BPM_INST_CP.GROUP_ID_ IS
'用户组Id';

COMMENT ON COLUMN BPM_INST_CP.CC_ID_ IS
'抄送ID';

COMMENT ON COLUMN BPM_INST_CP.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_INST_CP.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_INST_CP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST_CP.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_INST_CP.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_INST_CTL                                          */
/*==============================================================*/
CREATE TABLE BPM_INST_CTL  (
   CTL_ID               VARCHAR2(64)                    NOT NULL,
   BPM_INST_ID_         VARCHAR2(64),
   INST_ID_             VARCHAR2(64),
   TYPE_                VARCHAR2(50),
   RIGHT_               VARCHAR2(60),
   ALLOW_ATTEND_        VARCHAR2(20),
   ALLOW_STARTOR_       VARCHAR2(20),
   GROUP_IDS_           CLOB,
   USER_IDS_            CLOB,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_BPM_INST_CTL PRIMARY KEY (CTL_ID)
);

COMMENT ON TABLE BPM_INST_CTL IS
'流程附件权限';

COMMENT ON COLUMN BPM_INST_CTL.INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_INST_CTL.TYPE_ IS
'READ=阅读权限
FILE=附件权限';

COMMENT ON COLUMN BPM_INST_CTL.RIGHT_ IS
'ALL=全部权限
EDIT=编辑
DEL=删除
PRINT=打印
DOWN=下载';

COMMENT ON COLUMN BPM_INST_CTL.ALLOW_STARTOR_ IS
'允许发起人
YES';

COMMENT ON COLUMN BPM_INST_CTL.GROUP_IDS_ IS
'用户组Ids（多个用户组Id用“，”分割）';

COMMENT ON COLUMN BPM_INST_CTL.USER_IDS_ IS
'用户Ids（多个用户Id用“，”分割）';

COMMENT ON COLUMN BPM_INST_CTL.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_INST_CTL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_INST_CTL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST_CTL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_INST_CTL.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: BPM_INST_DATA                                         */
/*==============================================================*/
CREATE TABLE BPM_INST_DATA  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   BO_DEF_ID_           VARCHAR2(64),
   INST_ID_             VARCHAR2(64),
   PK_                  VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_INST_DATA PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_INST_DATA IS
'关联关系';

COMMENT ON COLUMN BPM_INST_DATA.ID_ IS
'主键';

COMMENT ON COLUMN BPM_INST_DATA.BO_DEF_ID_ IS
'业务对象ID';

COMMENT ON COLUMN BPM_INST_DATA.INST_ID_ IS
'实例ID_';

COMMENT ON COLUMN BPM_INST_DATA.PK_ IS
'业务表主键';

COMMENT ON COLUMN BPM_INST_DATA.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN BPM_INST_DATA.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST_DATA.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN BPM_INST_DATA.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN BPM_INST_DATA.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Index: IDX_INSTDATA_INSTID                                   */
/*==============================================================*/
CREATE INDEX IDX_INSTDATA_INSTID ON BPM_INST_DATA (
   INST_ID_ ASC
);

/*==============================================================*/
/* Table: BPM_INST_READ                                         */
/*==============================================================*/
CREATE TABLE BPM_INST_READ  (
   READ_ID_             VARCHAR2(64)                    NOT NULL,
   INST_ID_             VARCHAR2(64),
   USER_ID_             VARCHAR2(64),
   STATE_               VARCHAR2(50),
   DEP_ID_              VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_INST_READ PRIMARY KEY (READ_ID_)
);

COMMENT ON TABLE BPM_INST_READ IS
'流程实例阅读';

COMMENT ON COLUMN BPM_INST_READ.INST_ID_ IS
'实例ID';

COMMENT ON COLUMN BPM_INST_READ.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN BPM_INST_READ.STATE_ IS
'流程阶段';

COMMENT ON COLUMN BPM_INST_READ.DEP_ID_ IS
'部门ID';

COMMENT ON COLUMN BPM_INST_READ.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_INST_READ.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_INST_READ.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST_READ.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_INST_READ.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_INST_TMP                                          */
/*==============================================================*/
CREATE TABLE BPM_INST_TMP  (
   TMP_ID_              VARCHAR2(64)                    NOT NULL,
   BUS_KEY_             VARCHAR2(64),
   INST_ID_             VARCHAR2(64)                    NOT NULL,
   FORM_JSON_           CLOB                            NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_INST_TMP PRIMARY KEY (TMP_ID_)
);

COMMENT ON TABLE BPM_INST_TMP IS
'流程实例启动临时表';

COMMENT ON COLUMN BPM_INST_TMP.TMP_ID_ IS
'临时ID';

COMMENT ON COLUMN BPM_INST_TMP.INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_INST_TMP.FORM_JSON_ IS
'流程JSON';

COMMENT ON COLUMN BPM_INST_TMP.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_INST_TMP.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_INST_TMP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_INST_TMP.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_INST_TMP.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_LIB                                               */
/*==============================================================*/
CREATE TABLE BPM_LIB  (
   LIB_ID_              VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   TREE_ID_             VARCHAR2(64),
   NAME_                VARCHAR2(255)                   NOT NULL,
   STATUS_              VARCHAR2(20)                    NOT NULL,
   DESCP_               VARCHAR2(1024),
   HELP_ID              VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_LIB PRIMARY KEY (LIB_ID_)
);

COMMENT ON TABLE BPM_LIB IS
'业务流程解决方案共享库';

COMMENT ON COLUMN BPM_LIB.LIB_ID_ IS
'共享库ID';

COMMENT ON COLUMN BPM_LIB.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_LIB.TREE_ID_ IS
'共享所属分类ID';

COMMENT ON COLUMN BPM_LIB.NAME_ IS
'解决方案名称';

COMMENT ON COLUMN BPM_LIB.STATUS_ IS
'状态';

COMMENT ON COLUMN BPM_LIB.DESCP_ IS
'描述';

COMMENT ON COLUMN BPM_LIB.HELP_ID IS
'帮助ID';

COMMENT ON COLUMN BPM_LIB.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_LIB.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_LIB.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_LIB.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_LIB.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_LIB_CMT                                           */
/*==============================================================*/
CREATE TABLE BPM_LIB_CMT  (
   CMT_ID_              VARCHAR2(64)                    NOT NULL,
   LIB_ID_              VARCHAR2(64),
   CONTENT_             VARCHAR2(512)                   NOT NULL,
   LEVEL_               INTEGER                         NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_LIB_CMT PRIMARY KEY (CMT_ID_)
);

COMMENT ON TABLE BPM_LIB_CMT IS
'共享库评论';

COMMENT ON COLUMN BPM_LIB_CMT.LIB_ID_ IS
'共享库ID';

COMMENT ON COLUMN BPM_LIB_CMT.CONTENT_ IS
'评论内容';

COMMENT ON COLUMN BPM_LIB_CMT.LEVEL_ IS
'评分(0-100)';

COMMENT ON COLUMN BPM_LIB_CMT.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_LIB_CMT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_LIB_CMT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_LIB_CMT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_LIB_CMT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_LOG                                               */
/*==============================================================*/
CREATE TABLE BPM_LOG  (
   LOG_ID_              VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   INST_ID_             VARCHAR2(64),
   TASK_ID_             VARCHAR2(64),
   LOG_TYPE_            VARCHAR2(50)                    NOT NULL,
   OP_TYPE_             VARCHAR2(50)                    NOT NULL,
   OP_CONTENT_          VARCHAR2(512)                   NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_LOG PRIMARY KEY (LOG_ID_)
);

COMMENT ON TABLE BPM_LOG IS
'流程更新日志
包括流程任务日志、流程解决方案的更新，流程实例的更新日志等。';

COMMENT ON COLUMN BPM_LOG.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_LOG.INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_LOG.TASK_ID_ IS
'流程任务ID';

COMMENT ON COLUMN BPM_LOG.LOG_TYPE_ IS
'日志分类

方案本身信息操作
业务模型
流程表单
测试

流程实例
流程任务';

COMMENT ON COLUMN BPM_LOG.OP_TYPE_ IS
'操作类型

更新
删除
备注
沟通
';

COMMENT ON COLUMN BPM_LOG.OP_CONTENT_ IS
'操作内容';

COMMENT ON COLUMN BPM_LOG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_LOG.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_LOG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_LOG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_LOG.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_MOBILE_FORM                                       */
/*==============================================================*/
CREATE TABLE BPM_MOBILE_FORM  (
   ID_                  VARCHAR2(64),
   NAME_                VARCHAR2(50),
   ALIAS_               VARCHAR2(50),
   FORM_HTML            CLOB,
   TENANT_ID_           VARCHAR2(64),
   TREE_ID_             VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   BO_DEF_ID_           VARCHAR2(64)
);

COMMENT ON TABLE BPM_MOBILE_FORM IS
'手机表单配置表';

COMMENT ON COLUMN BPM_MOBILE_FORM.ID_ IS
'主键';

COMMENT ON COLUMN BPM_MOBILE_FORM.NAME_ IS
'名称';

COMMENT ON COLUMN BPM_MOBILE_FORM.ALIAS_ IS
'别名';

COMMENT ON COLUMN BPM_MOBILE_FORM.FORM_HTML IS
'表单模版';

COMMENT ON COLUMN BPM_MOBILE_FORM.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN BPM_MOBILE_FORM.TREE_ID_ IS
'表单分类ID';

COMMENT ON COLUMN BPM_MOBILE_FORM.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN BPM_MOBILE_FORM.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_MOBILE_FORM.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN BPM_MOBILE_FORM.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_MOBILE_FORM.BO_DEF_ID_ IS
'bo定义ID';

/*==============================================================*/
/* Table: BPM_MODULE_BIND                                       */
/*==============================================================*/
CREATE TABLE BPM_MODULE_BIND  (
   BIND_ID_             VARCHAR2(64)                    NOT NULL,
   MODULE_NAME_         VARCHAR2(50)                    NOT NULL,
   MODULE_KEY_          VARCHAR2(80)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   SOL_KEY_             VARCHAR2(60),
   SOL_NAME_            VARCHAR2(100),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_MODULE_BIND PRIMARY KEY (BIND_ID_)
);

COMMENT ON TABLE BPM_MODULE_BIND IS
'流程模块方案绑定';

COMMENT ON COLUMN BPM_MODULE_BIND.MODULE_NAME_ IS
'模块名称';

COMMENT ON COLUMN BPM_MODULE_BIND.MODULE_KEY_ IS
'模块Key';

COMMENT ON COLUMN BPM_MODULE_BIND.SOL_ID_ IS
'流程解决方案ID';

COMMENT ON COLUMN BPM_MODULE_BIND.SOL_KEY_ IS
'流程解决方案Key';

COMMENT ON COLUMN BPM_MODULE_BIND.SOL_NAME_ IS
'流程解决方案名称';

COMMENT ON COLUMN BPM_MODULE_BIND.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_MODULE_BIND.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_MODULE_BIND.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_MODULE_BIND.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_MODULE_BIND.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_NODE_JUMP                                         */
/*==============================================================*/
CREATE TABLE BPM_NODE_JUMP  (
   JUMP_ID_             VARCHAR2(64)                    NOT NULL,
   ACT_DEF_ID_          VARCHAR2(64),
   ACT_INST_ID_         VARCHAR2(64),
   NODE_NAME_           VARCHAR2(255),
   NODE_ID_             VARCHAR2(255)                   NOT NULL,
   TASK_ID_             VARCHAR2(64),
   COMPLETE_TIME_       TIMESTAMP,
   DURATION_            INTEGER,
   DURATION_VAL_        INTEGER,
   OWNER_ID_            VARCHAR2(64),
   HANDLER_ID_          VARCHAR2(64),
   AGENT_USER_ID_       VARCHAR2(64),
   CHECK_STATUS_        VARCHAR2(50),
   JUMP_TYPE_           VARCHAR2(50),
   REMARK_              VARCHAR2(512),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   ENABLE_MOBILE_       SMALLINT,
   OPINION_NAME_        VARCHAR2(50),
   CONSTRAINT PK_BPM_NODE_JUMP PRIMARY KEY (JUMP_ID_)
);

COMMENT ON TABLE BPM_NODE_JUMP IS
'流程流转记录';

COMMENT ON COLUMN BPM_NODE_JUMP.ACT_DEF_ID_ IS
'ACT流程定义ID';

COMMENT ON COLUMN BPM_NODE_JUMP.ACT_INST_ID_ IS
'ACT流程实例ID';

COMMENT ON COLUMN BPM_NODE_JUMP.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_NODE_JUMP.NODE_ID_ IS
'节点Key';

COMMENT ON COLUMN BPM_NODE_JUMP.TASK_ID_ IS
'任务ID';

COMMENT ON COLUMN BPM_NODE_JUMP.COMPLETE_TIME_ IS
'完成时间';

COMMENT ON COLUMN BPM_NODE_JUMP.DURATION_ IS
'持续时长';

COMMENT ON COLUMN BPM_NODE_JUMP.DURATION_VAL_ IS
'有效审批时长';

COMMENT ON COLUMN BPM_NODE_JUMP.OWNER_ID_ IS
'任务所属人ID';

COMMENT ON COLUMN BPM_NODE_JUMP.HANDLER_ID_ IS
'处理人ID';

COMMENT ON COLUMN BPM_NODE_JUMP.AGENT_USER_ID_ IS
'被代理人';

COMMENT ON COLUMN BPM_NODE_JUMP.CHECK_STATUS_ IS
'审批状态';

COMMENT ON COLUMN BPM_NODE_JUMP.JUMP_TYPE_ IS
'跳转类型';

COMMENT ON COLUMN BPM_NODE_JUMP.REMARK_ IS
'意见备注';

COMMENT ON COLUMN BPM_NODE_JUMP.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_NODE_JUMP.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_NODE_JUMP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_NODE_JUMP.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_NODE_JUMP.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_NODE_JUMP.ENABLE_MOBILE_ IS
'是否支持手机';

COMMENT ON COLUMN BPM_NODE_JUMP.OPINION_NAME_ IS
'字段意见名称';

/*==============================================================*/
/* Table: BPM_NODE_SET                                          */
/*==============================================================*/
CREATE TABLE BPM_NODE_SET  (
   SET_ID_              VARCHAR2(128)                   NOT NULL,
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   ACT_DEF_ID_          VARCHAR2(64),
   NODE_ID_             VARCHAR2(255)                   NOT NULL,
   NAME_                VARCHAR2(255),
   DESCP_               VARCHAR2(255),
   NODE_TYPE_           VARCHAR2(100)                   NOT NULL,
   NODE_CHECK_TIP_      VARCHAR2(1024),
   SETTINGS_            CLOB,
   PRE_HANDLE_          VARCHAR2(255),
   AFTER_HANDLE_        VARCHAR2(255),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_NODE_SET PRIMARY KEY (SET_ID_)
);

COMMENT ON TABLE BPM_NODE_SET IS
'流程定义节点配置';

COMMENT ON COLUMN BPM_NODE_SET.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_NODE_SET.ACT_DEF_ID_ IS
'ACT流程定义ID';

COMMENT ON COLUMN BPM_NODE_SET.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_NODE_SET.NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_NODE_SET.DESCP_ IS
'节点描述';

COMMENT ON COLUMN BPM_NODE_SET.NODE_TYPE_ IS
'节点类型';

COMMENT ON COLUMN BPM_NODE_SET.SETTINGS_ IS
'节点设置';

COMMENT ON COLUMN BPM_NODE_SET.PRE_HANDLE_ IS
'前置处理器';

COMMENT ON COLUMN BPM_NODE_SET.AFTER_HANDLE_ IS
'后置处理器';

COMMENT ON COLUMN BPM_NODE_SET.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_NODE_SET.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_NODE_SET.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_NODE_SET.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_NODE_SET.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_OPINION_LIB                                       */
/*==============================================================*/
CREATE TABLE BPM_OPINION_LIB  (
   OP_ID_               VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   OP_TEXT_             VARCHAR2(512)                   NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_OPINION_LIB PRIMARY KEY (OP_ID_)
);

COMMENT ON TABLE BPM_OPINION_LIB IS
'意见收藏表';

COMMENT ON COLUMN BPM_OPINION_LIB.USER_ID_ IS
'用户ID，为0代表公共的';

COMMENT ON COLUMN BPM_OPINION_LIB.OP_TEXT_ IS
'审批意见';

COMMENT ON COLUMN BPM_OPINION_LIB.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_OPINION_LIB.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_OPINION_LIB.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_OPINION_LIB.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_OPINION_LIB.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_PH_TABLE                                          */
/*==============================================================*/
CREATE TABLE BPM_PH_TABLE  (
   BPM_PH_TABLE_ID_     VARCHAR2(64)                    NOT NULL,
   VIEW_ID_             VARCHAR2(64),
   FM_TREE_ID_          VARCHAR2(64),
   FM_ID_               VARCHAR2(64),
   STATUS_              VARCHAR2(64),
   DS_ID_               VARCHAR2(64),
   DS_NAME_             VARCHAR2(256),
   JSON_DATA_           CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_PH_TABLE PRIMARY KEY (BPM_PH_TABLE_ID_)
);

COMMENT ON TABLE BPM_PH_TABLE IS
'BPM_PH_TABLE物理表';

COMMENT ON COLUMN BPM_PH_TABLE.BPM_PH_TABLE_ID_ IS
'主键';

COMMENT ON COLUMN BPM_PH_TABLE.VIEW_ID_ IS
'表单视图ID';

COMMENT ON COLUMN BPM_PH_TABLE.FM_TREE_ID_ IS
'业务模型树分类ID';

COMMENT ON COLUMN BPM_PH_TABLE.FM_ID_ IS
'模型ID';

COMMENT ON COLUMN BPM_PH_TABLE.STATUS_ IS
'状态';

COMMENT ON COLUMN BPM_PH_TABLE.DS_ID_ IS
'数据源ID';

COMMENT ON COLUMN BPM_PH_TABLE.DS_NAME_ IS
'数据源名称';

COMMENT ON COLUMN BPM_PH_TABLE.JSON_DATA_ IS
'数据JSON映射
';

COMMENT ON COLUMN BPM_PH_TABLE.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN BPM_PH_TABLE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_PH_TABLE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_PH_TABLE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_PH_TABLE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_REMIND_DEF                                        */
/*==============================================================*/
CREATE TABLE BPM_REMIND_DEF  (
   ID_                  VARCHAR2(50)                    NOT NULL,
   SOL_ID_              VARCHAR2(50),
   ACT_DEF_ID_          CHAR(10),
   NODE_ID_             VARCHAR2(50),
   NAME_                VARCHAR2(50),
   ACTION_              VARCHAR2(50),
   REL_NODE_            VARCHAR2(50),
   EVENT_               VARCHAR2(50),
   DATE_TYPE_           VARCHAR2(50),
   EXPIRE_DATE_         VARCHAR2(50),
   CONDITION_           VARCHAR2(1000),
   SCRIPT_              VARCHAR2(1000),
   NOTIFY_TYPE_         VARCHAR2(50),
   TIME_TO_SEND_        VARCHAR2(50),
   SEND_TIMES_          INTEGER,
   SEND_INTERVAL_       VARCHAR2(50),
   SOLUTION_NAME_       VARCHAR2(50),
   NODE_NAME_           VARCHAR2(50),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_BPM_REMIND_DEF PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_REMIND_DEF IS
'催办定义';

COMMENT ON COLUMN BPM_REMIND_DEF.ID_ IS
'主键';

COMMENT ON COLUMN BPM_REMIND_DEF.SOL_ID_ IS
'方案ID';

COMMENT ON COLUMN BPM_REMIND_DEF.ACT_DEF_ID_ IS
'流程定义ID';

COMMENT ON COLUMN BPM_REMIND_DEF.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_REMIND_DEF.NAME_ IS
'名称';

COMMENT ON COLUMN BPM_REMIND_DEF.ACTION_ IS
'到期动作';

COMMENT ON COLUMN BPM_REMIND_DEF.REL_NODE_ IS
'相对节点';

COMMENT ON COLUMN BPM_REMIND_DEF.EVENT_ IS
'事件';

COMMENT ON COLUMN BPM_REMIND_DEF.DATE_TYPE_ IS
'日期类型';

COMMENT ON COLUMN BPM_REMIND_DEF.EXPIRE_DATE_ IS
'期限';

COMMENT ON COLUMN BPM_REMIND_DEF.CONDITION_ IS
'条件';

COMMENT ON COLUMN BPM_REMIND_DEF.SCRIPT_ IS
'到期执行脚本';

COMMENT ON COLUMN BPM_REMIND_DEF.NOTIFY_TYPE_ IS
'通知类型';

COMMENT ON COLUMN BPM_REMIND_DEF.TIME_TO_SEND_ IS
'开始发送消息时间点';

COMMENT ON COLUMN BPM_REMIND_DEF.SEND_TIMES_ IS
'发送次数';

COMMENT ON COLUMN BPM_REMIND_DEF.SEND_INTERVAL_ IS
'发送时间间隔';

COMMENT ON COLUMN BPM_REMIND_DEF.SOLUTION_NAME_ IS
'解决方案名称';

COMMENT ON COLUMN BPM_REMIND_DEF.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_REMIND_DEF.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_REMIND_DEF.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_REMIND_DEF.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_REMIND_DEF.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_REMIND_DEF.TENANT_ID_ IS
'租用用户Id';

/*==============================================================*/
/* Table: BPM_REMIND_HISTORY                                    */
/*==============================================================*/
CREATE TABLE BPM_REMIND_HISTORY  (
   ID_                  VARCHAR2(50)                    NOT NULL,
   REMINDER_INST_ID_    VARCHAR2(50),
   REMIND_TYPE_         VARCHAR2(50),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_BPM_REMIND_HISTORY PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_REMIND_HISTORY IS
'催办历史';

COMMENT ON COLUMN BPM_REMIND_HISTORY.ID_ IS
'主键';

COMMENT ON COLUMN BPM_REMIND_HISTORY.REMINDER_INST_ID_ IS
'催办实例ID';

COMMENT ON COLUMN BPM_REMIND_HISTORY.REMIND_TYPE_ IS
'催办类型';

COMMENT ON COLUMN BPM_REMIND_HISTORY.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_REMIND_HISTORY.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_REMIND_HISTORY.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_REMIND_HISTORY.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_REMIND_HISTORY.TENANT_ID_ IS
'租用用户Id';

/*==============================================================*/
/* Table: BPM_REMIND_INST                                       */
/*==============================================================*/
CREATE TABLE BPM_REMIND_INST  (
   ID_                  VARCHAR2(50)                    NOT NULL,
   SOL_ID_              VARCHAR2(50),
   NODE_ID_             VARCHAR2(50),
   TASK_ID_             VARCHAR2(50),
   NAME_                VARCHAR2(50),
   ACTION_              VARCHAR2(50),
   EXPIRE_DATE_         TIMESTAMP,
   SCRIPT_              VARCHAR2(1000),
   NOTIFY_TYPE_         VARCHAR2(50),
   TIME_TO_SEND_        TIMESTAMP,
   SEND_TIMES_          INTEGER,
   SEND_INTERVAL_       INTEGER,
   STATUS_              VARCHAR2(10),
   SOLUTION_NAME_       VARCHAR2(50),
   NODE_NAME_           VARCHAR2(50),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_BPM_REMIND_INST PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_REMIND_INST IS
'催办实例表';

COMMENT ON COLUMN BPM_REMIND_INST.ID_ IS
'主键';

COMMENT ON COLUMN BPM_REMIND_INST.SOL_ID_ IS
'方案ID';

COMMENT ON COLUMN BPM_REMIND_INST.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_REMIND_INST.TASK_ID_ IS
'任务ID';

COMMENT ON COLUMN BPM_REMIND_INST.NAME_ IS
'名称';

COMMENT ON COLUMN BPM_REMIND_INST.ACTION_ IS
'到期动作';

COMMENT ON COLUMN BPM_REMIND_INST.EXPIRE_DATE_ IS
'期限';

COMMENT ON COLUMN BPM_REMIND_INST.SCRIPT_ IS
'到期执行脚本';

COMMENT ON COLUMN BPM_REMIND_INST.NOTIFY_TYPE_ IS
'通知类型';

COMMENT ON COLUMN BPM_REMIND_INST.TIME_TO_SEND_ IS
'开始发送消息时间点';

COMMENT ON COLUMN BPM_REMIND_INST.SEND_TIMES_ IS
'发送次数';

COMMENT ON COLUMN BPM_REMIND_INST.SEND_INTERVAL_ IS
'发送时间间隔';

COMMENT ON COLUMN BPM_REMIND_INST.STATUS_ IS
'状态(2,完成,0,创建,1,进行中)';

COMMENT ON COLUMN BPM_REMIND_INST.SOLUTION_NAME_ IS
'方案名称';

COMMENT ON COLUMN BPM_REMIND_INST.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_REMIND_INST.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_REMIND_INST.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_REMIND_INST.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_REMIND_INST.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_REMIND_INST.TENANT_ID_ IS
'租用用户Id';

/*==============================================================*/
/* Table: BPM_RU_PATH                                           */
/*==============================================================*/
CREATE TABLE BPM_RU_PATH  (
   PATH_ID_             VARCHAR2(64)                    NOT NULL,
   INST_ID_             VARCHAR2(64)                    NOT NULL,
   ACT_DEF_ID_          VARCHAR2(64)                    NOT NULL,
   ACT_INST_ID_         VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   NODE_ID_             VARCHAR2(255)                   NOT NULL,
   NODE_NAME_           VARCHAR2(255),
   NODE_TYPE_           VARCHAR2(50),
   START_TIME_          TIMESTAMP                            NOT NULL,
   END_TIME_            TIMESTAMP,
   DURATION_            INTEGER,
   DURATION_VAL_        INTEGER,
   ASSIGNEE_            VARCHAR2(64),
   TO_USER_ID_          VARCHAR2(64),
   IS_MULTIPLE_         VARCHAR2(20),
   EXECUTION_ID_        VARCHAR2(64),
   USER_IDS_            VARCHAR2(300),
   PARENT_ID_           VARCHAR2(64),
   LEVEL_               INTEGER,
   OUT_TRAN_ID_         VARCHAR2(255),
   TOKEN_               VARCHAR2(255),
   JUMP_TYPE_           VARCHAR2(50),
   NEXT_JUMP_TYPE_      VARCHAR2(50),
   OPINION_             VARCHAR2(500),
   REF_PATH_ID_         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_RU_PATH PRIMARY KEY (PATH_ID_)
);

COMMENT ON TABLE BPM_RU_PATH IS
'流程实例运行路线';

COMMENT ON COLUMN BPM_RU_PATH.INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_RU_PATH.ACT_DEF_ID_ IS
'Act定义ID';

COMMENT ON COLUMN BPM_RU_PATH.ACT_INST_ID_ IS
'Act实例ID';

COMMENT ON COLUMN BPM_RU_PATH.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_RU_PATH.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_RU_PATH.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_RU_PATH.NODE_TYPE_ IS
'节点类型';

COMMENT ON COLUMN BPM_RU_PATH.START_TIME_ IS
'开始时间';

COMMENT ON COLUMN BPM_RU_PATH.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN BPM_RU_PATH.DURATION_ IS
'持续时长';

COMMENT ON COLUMN BPM_RU_PATH.DURATION_VAL_ IS
'有效审批时长';

COMMENT ON COLUMN BPM_RU_PATH.ASSIGNEE_ IS
'处理人ID';

COMMENT ON COLUMN BPM_RU_PATH.TO_USER_ID_ IS
'代理人ID';

COMMENT ON COLUMN BPM_RU_PATH.IS_MULTIPLE_ IS
'是否为多实例';

COMMENT ON COLUMN BPM_RU_PATH.EXECUTION_ID_ IS
'活动执行ID';

COMMENT ON COLUMN BPM_RU_PATH.USER_IDS_ IS
'原执行人IDS';

COMMENT ON COLUMN BPM_RU_PATH.PARENT_ID_ IS
'父ID';

COMMENT ON COLUMN BPM_RU_PATH.LEVEL_ IS
'层次';

COMMENT ON COLUMN BPM_RU_PATH.OUT_TRAN_ID_ IS
'跳出路线ID';

COMMENT ON COLUMN BPM_RU_PATH.TOKEN_ IS
'路线令牌';

COMMENT ON COLUMN BPM_RU_PATH.JUMP_TYPE_ IS
'跳到该节点的方式
正常跳转
自由跳转
回退跳转';

COMMENT ON COLUMN BPM_RU_PATH.NEXT_JUMP_TYPE_ IS
'下一步跳转方式';

COMMENT ON COLUMN BPM_RU_PATH.OPINION_ IS
'审批意见';

COMMENT ON COLUMN BPM_RU_PATH.REF_PATH_ID_ IS
'引用路径ID
当回退时，重新生成的结点，需要记录引用的回退节点，方便新生成的路径再次回退。';

COMMENT ON COLUMN BPM_RU_PATH.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_RU_PATH.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_RU_PATH.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_RU_PATH.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_RU_PATH.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_SIGN_DATA                                         */
/*==============================================================*/
CREATE TABLE BPM_SIGN_DATA  (
   DATA_ID_             VARCHAR2(64)                    NOT NULL,
   ACT_DEF_ID_          VARCHAR2(64)                    NOT NULL,
   ACT_INST_ID_         VARCHAR2(64)                    NOT NULL,
   NODE_ID_             VARCHAR2(255)                   NOT NULL,
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   VOTE_STATUS_         VARCHAR2(50)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_SIGN_DATA PRIMARY KEY (DATA_ID_)
);

COMMENT ON TABLE BPM_SIGN_DATA IS
'任务会签数据
运行过程中会清空该表，一般为流程实例运行过程中清空';

COMMENT ON COLUMN BPM_SIGN_DATA.DATA_ID_ IS
'主键';

COMMENT ON COLUMN BPM_SIGN_DATA.ACT_DEF_ID_ IS
'流程定义ID';

COMMENT ON COLUMN BPM_SIGN_DATA.ACT_INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_SIGN_DATA.NODE_ID_ IS
'流程节点Id';

COMMENT ON COLUMN BPM_SIGN_DATA.USER_ID_ IS
'投票人ID';

COMMENT ON COLUMN BPM_SIGN_DATA.VOTE_STATUS_ IS
'投票状态
同意
反对
弃权
';

COMMENT ON COLUMN BPM_SIGN_DATA.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_SIGN_DATA.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SIGN_DATA.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SIGN_DATA.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SIGN_DATA.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_SOLUTION                                          */
/*==============================================================*/
CREATE TABLE BPM_SOLUTION  (
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   "TREE_ID_"           VARCHAR2(64),
   TREE_PATH_           VARCHAR2(512),
   NAME_                VARCHAR2(100)                   NOT NULL,
   KEY_                 VARCHAR2(100)                   NOT NULL,
   DEF_KEY_             VARCHAR2(255),
   ACT_DEF_ID_          VARCHAR2(64),
   DESCP_               VARCHAR2(512),
   STEP_                INTEGER                         NOT NULL,
   IS_USE_BMODEL_       VARCHAR2(20),
   STATUS_              VARCHAR2(64)                    NOT NULL,
   SUBJECT_RULE_        VARCHAR2(255),
   HELP_ID_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   GRANT_TYPE_          SMALLINT,
   FORMAL_              VARCHAR2(10),
   BO_DEF_ID_           VARCHAR2(64),
   DATA_SAVE_MODE_      VARCHAR2(10),
   CONSTRAINT PK_BPM_SOLUTION PRIMARY KEY (SOL_ID_)
);

COMMENT ON TABLE BPM_SOLUTION IS
'业务流程方案定义';

COMMENT ON COLUMN BPM_SOLUTION."TREE_ID_" IS
'分类Id';

COMMENT ON COLUMN BPM_SOLUTION.TREE_PATH_ IS
'是否跳过第一步，
代表流程启动后，是否跳过第一步';

COMMENT ON COLUMN BPM_SOLUTION.NAME_ IS
'解决方案名称';

COMMENT ON COLUMN BPM_SOLUTION.KEY_ IS
'标识键';

COMMENT ON COLUMN BPM_SOLUTION.DEF_KEY_ IS
'绑定流程KEY';

COMMENT ON COLUMN BPM_SOLUTION.ACT_DEF_ID_ IS
'ACT流程定义ID';

COMMENT ON COLUMN BPM_SOLUTION.DESCP_ IS
'解决方案描述';

COMMENT ON COLUMN BPM_SOLUTION.STEP_ IS
'完成的步骤';

COMMENT ON COLUMN BPM_SOLUTION.IS_USE_BMODEL_ IS
'单独使用业务模型
YES=表示不带任何表单视图';

COMMENT ON COLUMN BPM_SOLUTION.STATUS_ IS
'状态
INIT =创建状态
DEPLOYED=发布状态
DISABLED=禁用状态';

COMMENT ON COLUMN BPM_SOLUTION.SUBJECT_RULE_ IS
'业务标题规则';

COMMENT ON COLUMN BPM_SOLUTION.HELP_ID_ IS
'帮助ID';

COMMENT ON COLUMN BPM_SOLUTION.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_SOLUTION.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SOLUTION.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SOLUTION.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SOLUTION.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_SOLUTION.GRANT_TYPE_ IS
'授权类型
0=全部
1=部分授权';

COMMENT ON COLUMN BPM_SOLUTION.FORMAL_ IS
'是否正式(yes,no)';

COMMENT ON COLUMN BPM_SOLUTION.BO_DEF_ID_ IS
'BO定义ID';

COMMENT ON COLUMN BPM_SOLUTION.DATA_SAVE_MODE_ IS
'BO数据保存模式';

/*==============================================================*/
/* Table: BPM_SOL_CTL                                           */
/*==============================================================*/
CREATE TABLE BPM_SOL_CTL  (
   RIGHT_ID_            VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   USER_IDS_            CLOB,
   GROUP_IDS_           CLOB,
   ALLOW_STARTOR_       VARCHAR2(20),
   ALLOW_ATTEND_        VARCHAR2(20),
   RIGHT_               VARCHAR2(60),
   TYPE_                VARCHAR2(50),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_SOL_CTL PRIMARY KEY (RIGHT_ID_)
);

COMMENT ON TABLE BPM_SOL_CTL IS
'流程解决方案资源访问权限控制';

COMMENT ON COLUMN BPM_SOL_CTL.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_SOL_CTL.USER_IDS_ IS
'用户Ids（多个用户Id用“，”分割）';

COMMENT ON COLUMN BPM_SOL_CTL.GROUP_IDS_ IS
'用户组Ids（多个用户组Id用“，”分割）';

COMMENT ON COLUMN BPM_SOL_CTL.ALLOW_STARTOR_ IS
'允许发起人
YES';

COMMENT ON COLUMN BPM_SOL_CTL.RIGHT_ IS
'ALL=全部权限
EDIT=编辑
DEL=删除
PRINT=打印
DOWN=下载';

COMMENT ON COLUMN BPM_SOL_CTL.TYPE_ IS
'READ=阅读权限
FILE=附件权限';

COMMENT ON COLUMN BPM_SOL_CTL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_SOL_CTL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SOL_CTL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SOL_CTL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SOL_CTL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_SOL_FM                                            */
/*==============================================================*/
CREATE TABLE BPM_SOL_FM  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   MOD_KEY_             VARCHAR2(100)                   NOT NULL,
   IS_MAIN_             VARCHAR2(20)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_SOL_FM PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_SOL_FM IS
'解决方案关联的业务模型';

COMMENT ON COLUMN BPM_SOL_FM.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_SOL_FM.MOD_KEY_ IS
'业务模型标识键';

COMMENT ON COLUMN BPM_SOL_FM.IS_MAIN_ IS
'是否为主模型';

COMMENT ON COLUMN BPM_SOL_FM.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_SOL_FM.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SOL_FM.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SOL_FM.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SOL_FM.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_SOL_FV                                            */
/*==============================================================*/
CREATE TABLE BPM_SOL_FV  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   ACT_DEF_ID_          VARCHAR2(64),
   NODE_ID_             VARCHAR2(255)                   NOT NULL,
   NODE_TEXT_           VARCHAR2(255),
   FORM_TYPE_           VARCHAR2(30),
   FORM_URI_            VARCHAR2(255),
   FORM_NAME_           VARCHAR2(255),
   PRINT_URI_           VARCHAR2(255),
   PRINT_NAME_          VARCHAR2(255),
   SN_                  INTEGER,
   MOBILE_NAME_         VARCHAR2(50),
   MOBILE_ALIAS_        VARCHAR2(50),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_TIME_         TIMESTAMP,
   TAB_RIGHTS_          CLOB,
   IS_USE_CFORM_        VARCHAR2(20),
   COND_FORMS_          CLOB,
   DATA_CONFS_          CLOB,
   CONSTRAINT PK_BPM_SOL_FV PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_SOL_FV IS
'解决方案关联的表单视图';

COMMENT ON COLUMN BPM_SOL_FV.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_SOL_FV.ACT_DEF_ID_ IS
'ACT流程定义ID';

COMMENT ON COLUMN BPM_SOL_FV.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_SOL_FV.NODE_TEXT_ IS
'节点名称';

COMMENT ON COLUMN BPM_SOL_FV.FORM_TYPE_ IS
'表单类型
ONLINE-DESIGN=在线表单
SEL-DEV=自定义的URL表单';

COMMENT ON COLUMN BPM_SOL_FV.FORM_URI_ IS
'表单地址';

COMMENT ON COLUMN BPM_SOL_FV.FORM_NAME_ IS
'表单名称';

COMMENT ON COLUMN BPM_SOL_FV.PRINT_URI_ IS
'打印表单地址';

COMMENT ON COLUMN BPM_SOL_FV.PRINT_NAME_ IS
'打印表单名称';

COMMENT ON COLUMN BPM_SOL_FV.SN_ IS
'序号';

COMMENT ON COLUMN BPM_SOL_FV.MOBILE_NAME_ IS
'手机表单名称';

COMMENT ON COLUMN BPM_SOL_FV.MOBILE_ALIAS_ IS
'手机表单别名';

COMMENT ON COLUMN BPM_SOL_FV.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_SOL_FV.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SOL_FV.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SOL_FV.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SOL_FV.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_SOL_FV.TAB_RIGHTS_ IS
'表单TAB权限配置';

COMMENT ON COLUMN BPM_SOL_FV.IS_USE_CFORM_ IS
'使用权限表单';

COMMENT ON COLUMN BPM_SOL_FV.COND_FORMS_ IS
'条件表单设置';

COMMENT ON COLUMN BPM_SOL_FV.DATA_CONFS_ IS
'表单数据设定';

/*==============================================================*/
/* Table: BPM_SOL_USER                                          */
/*==============================================================*/
CREATE TABLE BPM_SOL_USER  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   ACT_DEF_ID_          VARCHAR2(64),
   NODE_ID_             VARCHAR2(255)                   NOT NULL,
   NODE_NAME_           VARCHAR2(255),
   USER_TYPE_           VARCHAR2(50)                    NOT NULL,
   USER_TYPE_NAME_      VARCHAR2(100),
   CONFIG_DESCP_        VARCHAR2(512),
   CONFIG_              VARCHAR2(512),
   IS_CAL_              VARCHAR2(20)                    NOT NULL,
   CAL_LOGIC_           VARCHAR2(20)                    NOT NULL,
   SN_                  INTEGER,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_TIME_         TIMESTAMP,
   CATEGORY_            VARCHAR2(20),
   GROUP_ID_            VARCHAR2(50),
   CONSTRAINT PK_BPM_SOL_USER PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_SOL_USER IS
'解决方案关联的人员配置';

COMMENT ON COLUMN BPM_SOL_USER.SOL_ID_ IS
'业务流程解决方案ID';

COMMENT ON COLUMN BPM_SOL_USER.ACT_DEF_ID_ IS
'ACT流程定义ID';

COMMENT ON COLUMN BPM_SOL_USER.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_SOL_USER.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_SOL_USER.USER_TYPE_ IS
'用户类型';

COMMENT ON COLUMN BPM_SOL_USER.USER_TYPE_NAME_ IS
'用户类型名称';

COMMENT ON COLUMN BPM_SOL_USER.CONFIG_DESCP_ IS
'配置显示信息';

COMMENT ON COLUMN BPM_SOL_USER.CONFIG_ IS
'节点配置';

COMMENT ON COLUMN BPM_SOL_USER.IS_CAL_ IS
'是否计算用户';

COMMENT ON COLUMN BPM_SOL_USER.CAL_LOGIC_ IS
'集合的人员运算';

COMMENT ON COLUMN BPM_SOL_USER.SN_ IS
'序号';

COMMENT ON COLUMN BPM_SOL_USER.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_SOL_USER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SOL_USER.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SOL_USER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SOL_USER.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_SOL_USER.CATEGORY_ IS
'类别';

/*==============================================================*/
/* Table: BPM_SOL_USERGROUP                                     */
/*==============================================================*/
CREATE TABLE BPM_SOL_USERGROUP  (
   ID_                  VARCHAR2(50)                    NOT NULL,
   GROUP_NAME_          VARCHAR2(50),
   "ACT_DEF_ID_"        VARCHAR2(50),
   SOL_ID_              VARCHAR2(50),
   GROUP_TYPE_          VARCHAR2(50),
   NODE_ID_             VARCHAR2(50),
   NODE_NAME_           VARCHAR2(50),
   TENANT_ID_           VARCHAR2(50),
   SETTING_             VARCHAR2(2000),
   SN_                  INTEGER,
   NOTIFY_TYPE_         VARCHAR2(50),
   CREATE_BY_           VARCHAR2(50),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(50),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_SOL_USERGROUP PRIMARY KEY (ID_)
);

COMMENT ON TABLE BPM_SOL_USERGROUP IS
'流程配置用户组';

COMMENT ON COLUMN BPM_SOL_USERGROUP.ID_ IS
'主键';

COMMENT ON COLUMN BPM_SOL_USERGROUP.GROUP_NAME_ IS
'名称';

COMMENT ON COLUMN BPM_SOL_USERGROUP."ACT_DEF_ID_" IS
'ACT流程定义ID';

COMMENT ON COLUMN BPM_SOL_USERGROUP.SOL_ID_ IS
'方案ID';

COMMENT ON COLUMN BPM_SOL_USERGROUP.GROUP_TYPE_ IS
'分组类型(flow,copyto)';

COMMENT ON COLUMN BPM_SOL_USERGROUP.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_SOL_USERGROUP.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_SOL_USERGROUP.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN BPM_SOL_USERGROUP.SETTING_ IS
'配置';

COMMENT ON COLUMN BPM_SOL_USERGROUP.SN_ IS
'序号';

COMMENT ON COLUMN BPM_SOL_USERGROUP.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN BPM_SOL_USERGROUP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SOL_USERGROUP.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN BPM_SOL_USERGROUP.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_SOL_VAR                                           */
/*==============================================================*/
CREATE TABLE BPM_SOL_VAR  (
   VAR_ID_              VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   ACT_DEF_ID_          VARCHAR2(64),
   KEY_                 VARCHAR2(255)                   NOT NULL,
   NAME_                VARCHAR2(255)                   NOT NULL,
   TYPE_                VARCHAR2(50)                    NOT NULL,
   SCOPE_               VARCHAR2(128)                   NOT NULL,
   NODE_NAME_           VARCHAR2(255),
   DEF_VAL_             VARCHAR2(100),
   EXPRESS_             VARCHAR2(512),
   IS_REQ_              VARCHAR2(20),
   SN_                  INTEGER,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_TIME_         TIMESTAMP,
   "FORM_FIELD_"        VARCHAR2(100),
   CONSTRAINT PK_BPM_SOL_VAR PRIMARY KEY (VAR_ID_)
);

COMMENT ON TABLE BPM_SOL_VAR IS
'流程解决方案变量';

COMMENT ON COLUMN BPM_SOL_VAR.VAR_ID_ IS
'变量ID';

COMMENT ON COLUMN BPM_SOL_VAR.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_SOL_VAR.ACT_DEF_ID_ IS
'ACT流程定义ID';

COMMENT ON COLUMN BPM_SOL_VAR.KEY_ IS
'变量Key';

COMMENT ON COLUMN BPM_SOL_VAR.NAME_ IS
'变量名称';

COMMENT ON COLUMN BPM_SOL_VAR.TYPE_ IS
'类型';

COMMENT ON COLUMN BPM_SOL_VAR.SCOPE_ IS
'作用域
全局为_PROCESS
节点范围时存储节点ID
';

COMMENT ON COLUMN BPM_SOL_VAR.NODE_NAME_ IS
'节点名称';

COMMENT ON COLUMN BPM_SOL_VAR.DEF_VAL_ IS
'缺省值';

COMMENT ON COLUMN BPM_SOL_VAR.EXPRESS_ IS
'计算表达式';

COMMENT ON COLUMN BPM_SOL_VAR.IS_REQ_ IS
'是否必须';

COMMENT ON COLUMN BPM_SOL_VAR.SN_ IS
'序号';

COMMENT ON COLUMN BPM_SOL_VAR.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN BPM_SOL_VAR.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SOL_VAR.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SOL_VAR.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SOL_VAR.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN BPM_SOL_VAR."FORM_FIELD_" IS
'表单字段';

/*==============================================================*/
/* Table: BPM_SQL_NODE                                          */
/*==============================================================*/
CREATE TABLE BPM_SQL_NODE  (
   BPM_SQL_NODE_ID_     VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   NODE_ID_             VARCHAR2(64),
   NODE_TEXT_           VARCHAR2(256),
   SQL_                 CLOB,
   DS_ID_               VARCHAR2(64),
   DS_NAME_             VARCHAR2(256),
   JSON_DATA_           CLOB,
   JSON_TABLE_          CLOB,
   SQL_TYPE_            SMALLINT,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_SQL_NODE PRIMARY KEY (BPM_SQL_NODE_ID_)
);

COMMENT ON TABLE BPM_SQL_NODE IS
'BPM_SQL_NODE中间表';

COMMENT ON COLUMN BPM_SQL_NODE.BPM_SQL_NODE_ID_ IS
'主键';

COMMENT ON COLUMN BPM_SQL_NODE.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_SQL_NODE.NODE_ID_ IS
'节点ID';

COMMENT ON COLUMN BPM_SQL_NODE.NODE_TEXT_ IS
'节点名称';

COMMENT ON COLUMN BPM_SQL_NODE.SQL_ IS
'SQL语句';

COMMENT ON COLUMN BPM_SQL_NODE.DS_ID_ IS
'数据源ID';

COMMENT ON COLUMN BPM_SQL_NODE.DS_NAME_ IS
'数据源名称';

COMMENT ON COLUMN BPM_SQL_NODE.JSON_DATA_ IS
'数据JSON映射
';

COMMENT ON COLUMN BPM_SQL_NODE.JSON_TABLE_ IS
'表映射数据';

COMMENT ON COLUMN BPM_SQL_NODE.SQL_TYPE_ IS
'SQL类型';

COMMENT ON COLUMN BPM_SQL_NODE.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN BPM_SQL_NODE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_SQL_NODE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_SQL_NODE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_SQL_NODE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_TEST_CASE                                         */
/*==============================================================*/
CREATE TABLE BPM_TEST_CASE  (
   TEST_ID_             VARCHAR2(64)                    NOT NULL,
   TEST_SOL_ID_         VARCHAR2(64)                    NOT NULL,
   ACT_DEF_ID_          VARCHAR2(64),
   CASE_NAME_           VARCHAR2(20)                    NOT NULL,
   PARAMS_CONF_         CLOB,
   START_USER_ID_       VARCHAR2(64),
   USER_CONF_           CLOB,
   INST_ID_             VARCHAR2(64),
   LAST_STATUS_         VARCHAR2(20),
   EXE_EXCEPTIONS_      CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_TEST_CASE PRIMARY KEY (TEST_ID_)
);

COMMENT ON TABLE BPM_TEST_CASE IS
'测试用例';

COMMENT ON COLUMN BPM_TEST_CASE.TEST_ID_ IS
'测试用例ID';

COMMENT ON COLUMN BPM_TEST_CASE.TEST_SOL_ID_ IS
'测试方案ID';

COMMENT ON COLUMN BPM_TEST_CASE.CASE_NAME_ IS
'用例名称';

COMMENT ON COLUMN BPM_TEST_CASE.PARAMS_CONF_ IS
'参数配置';

COMMENT ON COLUMN BPM_TEST_CASE.START_USER_ID_ IS
'发起人';

COMMENT ON COLUMN BPM_TEST_CASE.USER_CONF_ IS
'用户干预配置';

COMMENT ON COLUMN BPM_TEST_CASE.INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN BPM_TEST_CASE.LAST_STATUS_ IS
'执行最终状态';

COMMENT ON COLUMN BPM_TEST_CASE.EXE_EXCEPTIONS_ IS
'执行异常';

COMMENT ON COLUMN BPM_TEST_CASE.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_TEST_CASE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_TEST_CASE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_TEST_CASE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_TEST_CASE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: BPM_TEST_SOL                                          */
/*==============================================================*/
CREATE TABLE BPM_TEST_SOL  (
   TEST_SOL_ID_         VARCHAR2(64)                    NOT NULL,
   TEST_NO_             VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   ACT_DEF_ID_          VARCHAR2(64)                    NOT NULL,
   MEMO_                VARCHAR2(1024),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_BPM_TEST_SOL PRIMARY KEY (TEST_SOL_ID_)
);

COMMENT ON TABLE BPM_TEST_SOL IS
'流程测试方案';

COMMENT ON COLUMN BPM_TEST_SOL.TEST_SOL_ID_ IS
'测试方案ID';

COMMENT ON COLUMN BPM_TEST_SOL.TEST_NO_ IS
'方案编号';

COMMENT ON COLUMN BPM_TEST_SOL.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN BPM_TEST_SOL.ACT_DEF_ID_ IS
'Activiti定义ID';

COMMENT ON COLUMN BPM_TEST_SOL.MEMO_ IS
'测试方案描述';

COMMENT ON COLUMN BPM_TEST_SOL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN BPM_TEST_SOL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN BPM_TEST_SOL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN BPM_TEST_SOL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN BPM_TEST_SOL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: CAL_CALENDAR                                          */
/*==============================================================*/
CREATE TABLE CAL_CALENDAR  (
   CALENDER_ID_         VARCHAR2(64)                    NOT NULL,
   SETTING_ID_          VARCHAR2(64),
   START_TIME_          TIMESTAMP,
   END_TIME_            TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_CAL_CALENDAR PRIMARY KEY (CALENDER_ID_)
);

COMMENT ON TABLE CAL_CALENDAR IS
'工作日历安排';

COMMENT ON COLUMN CAL_CALENDAR.CALENDER_ID_ IS
'日历Id';

COMMENT ON COLUMN CAL_CALENDAR.SETTING_ID_ IS
'设定ID';

COMMENT ON COLUMN CAL_CALENDAR.START_TIME_ IS
'开始时间';

COMMENT ON COLUMN CAL_CALENDAR.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN CAL_CALENDAR.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN CAL_CALENDAR.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN CAL_CALENDAR.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN CAL_CALENDAR.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN CAL_CALENDAR.TENANT_ID_ IS
'租用机构Id';

/*==============================================================*/
/* Table: CAL_GRANT                                             */
/*==============================================================*/
CREATE TABLE CAL_GRANT  (
   GRANT_ID_            VARCHAR2(64)                    NOT NULL,
   SETTING_ID_          VARCHAR2(64),
   GRANT_TYPE_          VARCHAR2(64),
   BELONG_WHO_          VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_CAL_GRANT PRIMARY KEY (GRANT_ID_)
);

COMMENT ON TABLE CAL_GRANT IS
'日历分配';

COMMENT ON COLUMN CAL_GRANT.GRANT_TYPE_ IS
'分配类型 USER/GROUP';

/*==============================================================*/
/* Table: CAL_SETTING                                           */
/*==============================================================*/
CREATE TABLE CAL_SETTING  (
   SETTING_ID_          VARCHAR2(64)                    NOT NULL,
   CAL_NAME_            VARCHAR2(64),
   IS_COMMON_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_CAL_SETTING PRIMARY KEY (SETTING_ID_)
);

COMMENT ON TABLE CAL_SETTING IS
'日历设定';

COMMENT ON COLUMN CAL_SETTING.SETTING_ID_ IS
'设定ID';

COMMENT ON COLUMN CAL_SETTING.CAL_NAME_ IS
'日历名称';

COMMENT ON COLUMN CAL_SETTING.IS_COMMON_ IS
'默认';

COMMENT ON COLUMN CAL_SETTING.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN CAL_SETTING.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN CAL_SETTING.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN CAL_SETTING.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN CAL_SETTING.TENANT_ID_ IS
'租用机构Id';

/*==============================================================*/
/* Table: CAL_TIME_BLOCK                                        */
/*==============================================================*/
CREATE TABLE CAL_TIME_BLOCK  (
   SETTING_ID_          VARCHAR2(64)                    NOT NULL,
   SETTING_NAME_        VARCHAR2(128),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   TIME_INTERVALS_      VARCHAR2(1024),
   CONSTRAINT PK_CAL_TIME_BLOCK PRIMARY KEY (SETTING_ID_)
);

COMMENT ON TABLE CAL_TIME_BLOCK IS
'工作时间段设定';

/*==============================================================*/
/* Table: CRM_PROVIDER                                          */
/*==============================================================*/
CREATE TABLE CRM_PROVIDER  (
   PRO_ID_              VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(80)                    NOT NULL,
   SHORT_DESC_          VARCHAR2(100)                   NOT NULL,
   CMP_LEVEL_           VARCHAR2(20),
   CMP_TYPE_            VARCHAR2(20),
   CREDIT_TYPE_         VARCHAR2(20),
   CREDIT_LIMIT_        INTEGER,
   CREDIT_PERIOD_       INTEGER,
   WEB_SITE_            VARCHAR2(200),
   ADDRESS_             VARCHAR2(200),
   ZIP_                 VARCHAR2(20),
   CONTACTOR_           VARCHAR2(32),
   MOBILE_              VARCHAR2(20),
   PHONE_               VARCHAR2(20),
   WEIXIN_              VARCHAR2(50),
   WEIBO_               VARCHAR2(80),
   MEMO_                CLOB,
   ADDTION_FIDS_        VARCHAR2(512),
   CHARGE_ID_           VARCHAR2(64),
   STATUS_              VARCHAR2(20),
   ACT_INST_ID_         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_CRM_PROVIDER PRIMARY KEY (PRO_ID_)
);

COMMENT ON TABLE CRM_PROVIDER IS
'供应商管理';

COMMENT ON COLUMN CRM_PROVIDER.PRO_ID_ IS
'供应商ID';

COMMENT ON COLUMN CRM_PROVIDER.NAME_ IS
'供应商名';

COMMENT ON COLUMN CRM_PROVIDER.SHORT_DESC_ IS
'供应商简称';

COMMENT ON COLUMN CRM_PROVIDER.CMP_LEVEL_ IS
'单位级别';

COMMENT ON COLUMN CRM_PROVIDER.CMP_TYPE_ IS
'单位类型

来自数据字典';

COMMENT ON COLUMN CRM_PROVIDER.CREDIT_TYPE_ IS
'信用级别
AAAA
AAA
AA
A';

COMMENT ON COLUMN CRM_PROVIDER.CREDIT_LIMIT_ IS
'信用额度
元
';

COMMENT ON COLUMN CRM_PROVIDER.CREDIT_PERIOD_ IS
'信用账期 
 天
';

COMMENT ON COLUMN CRM_PROVIDER.WEB_SITE_ IS
'网站';

COMMENT ON COLUMN CRM_PROVIDER.ADDRESS_ IS
'地址';

COMMENT ON COLUMN CRM_PROVIDER.ZIP_ IS
'邮编';

COMMENT ON COLUMN CRM_PROVIDER.CONTACTOR_ IS
'联系人名';

COMMENT ON COLUMN CRM_PROVIDER.MOBILE_ IS
'联系人手机';

COMMENT ON COLUMN CRM_PROVIDER.PHONE_ IS
'固定电话';

COMMENT ON COLUMN CRM_PROVIDER.WEIXIN_ IS
'微信号';

COMMENT ON COLUMN CRM_PROVIDER.WEIBO_ IS
'微博号';

COMMENT ON COLUMN CRM_PROVIDER.MEMO_ IS
'备注';

COMMENT ON COLUMN CRM_PROVIDER.ADDTION_FIDS_ IS
'附件IDS';

COMMENT ON COLUMN CRM_PROVIDER.CHARGE_ID_ IS
'负责人ID';

COMMENT ON COLUMN CRM_PROVIDER.STATUS_ IS
'状态';

COMMENT ON COLUMN CRM_PROVIDER.ACT_INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN CRM_PROVIDER.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN CRM_PROVIDER.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN CRM_PROVIDER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN CRM_PROVIDER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN CRM_PROVIDER.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: HR_DUTY_INST                                          */
/*==============================================================*/
CREATE TABLE HR_DUTY_INST  (
   DUTY_INST_ID_        VARCHAR2(64)                    NOT NULL,
   HOLIDAY_ID_          VARCHAR2(64),
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   USER_NAME_           VARCHAR2(64),
   DEP_ID_              VARCHAR2(64),
   DEP_NAME_            VARCHAR2(64),
   SECTION_ID_          VARCHAR2(64),
   SECTION_NAME_        VARCHAR2(16),
   SECTION_SHORT_NAME_  VARCHAR2(4),
   SYSTEM_ID_           VARCHAR2(64),
   SYSTEM_NAME_         VARCHAR2(100),
   TYPE_                VARCHAR2(10),
   DATE_                TIMESTAMP,
   VAC_APP_             CLOB,
   OT_APP_              CLOB,
   TR_APP_              CLOB,
   OUT_APP_             CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_DUTY_INST PRIMARY KEY (DUTY_INST_ID_)
);

COMMENT ON TABLE HR_DUTY_INST IS
'排班实例';

COMMENT ON COLUMN HR_DUTY_INST.DUTY_INST_ID_ IS
'排班实例ID';

COMMENT ON COLUMN HR_DUTY_INST.HOLIDAY_ID_ IS
'假期ID';

COMMENT ON COLUMN HR_DUTY_INST.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN HR_DUTY_INST.USER_NAME_ IS
'用户名称';

COMMENT ON COLUMN HR_DUTY_INST.DEP_ID_ IS
'部门ID';

COMMENT ON COLUMN HR_DUTY_INST.DEP_NAME_ IS
'部门名称';

COMMENT ON COLUMN HR_DUTY_INST.SECTION_ID_ IS
'班次ID';

COMMENT ON COLUMN HR_DUTY_INST.SECTION_NAME_ IS
'班次名称';

COMMENT ON COLUMN HR_DUTY_INST.SECTION_SHORT_NAME_ IS
'班次简称';

COMMENT ON COLUMN HR_DUTY_INST.SYSTEM_ID_ IS
'班制ID';

COMMENT ON COLUMN HR_DUTY_INST.SYSTEM_NAME_ IS
'班制名字';

COMMENT ON COLUMN HR_DUTY_INST.TYPE_ IS
'实例类型';

COMMENT ON COLUMN HR_DUTY_INST.DATE_ IS
'日期';

COMMENT ON COLUMN HR_DUTY_INST.VAC_APP_ IS
'请假申请';

COMMENT ON COLUMN HR_DUTY_INST.OT_APP_ IS
'加班申请';

COMMENT ON COLUMN HR_DUTY_INST.TR_APP_ IS
'调休申请';

COMMENT ON COLUMN HR_DUTY_INST.OUT_APP_ IS
'出差申请';

COMMENT ON COLUMN HR_DUTY_INST.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN HR_DUTY_INST.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN HR_DUTY_INST.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN HR_DUTY_INST.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN HR_DUTY_INST.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: HR_DUTY_INST_EXT                                      */
/*==============================================================*/
CREATE TABLE HR_DUTY_INST_EXT  (
   EXT_ID_              VARCHAR2(64)                    NOT NULL,
   DUTY_INST_ID_        VARCHAR2(64),
   START_SIGN_IN_       INTEGER,
   DUTY_START_TIME_     VARCHAR2(20),
   END_SIGN_IN_         INTEGER,
   EARLY_OFF_TIME_      INTEGER,
   DUTY_END_TIME_       VARCHAR2(20),
   SIGN_OUT_TIME_       INTEGER,
   SECTION_ID_          VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_DUTY_INST_EXT PRIMARY KEY (EXT_ID_)
);

COMMENT ON TABLE HR_DUTY_INST_EXT IS
'排班实例扩展表';

COMMENT ON COLUMN HR_DUTY_INST_EXT.EXT_ID_ IS
'排班实例扩展ID';

COMMENT ON COLUMN HR_DUTY_INST_EXT.DUTY_INST_ID_ IS
'排班实例ID';

COMMENT ON COLUMN HR_DUTY_INST_EXT.START_SIGN_IN_ IS
'开始签到';

COMMENT ON COLUMN HR_DUTY_INST_EXT.DUTY_START_TIME_ IS
'上班时间';

COMMENT ON COLUMN HR_DUTY_INST_EXT.END_SIGN_IN_ IS
'签到结束时间';

COMMENT ON COLUMN HR_DUTY_INST_EXT.EARLY_OFF_TIME_ IS
'早退计时';

COMMENT ON COLUMN HR_DUTY_INST_EXT.DUTY_END_TIME_ IS
'下班时间';

COMMENT ON COLUMN HR_DUTY_INST_EXT.SIGN_OUT_TIME_ IS
'签退结束';

COMMENT ON COLUMN HR_DUTY_INST_EXT.SECTION_ID_ IS
'班次ID';

COMMENT ON COLUMN HR_DUTY_INST_EXT.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN HR_DUTY_INST_EXT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN HR_DUTY_INST_EXT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN HR_DUTY_INST_EXT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN HR_DUTY_INST_EXT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_DOC                                               */
/*==============================================================*/
CREATE TABLE INF_DOC  (
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   FOLDER_ID_           VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(100)                   NOT NULL,
   CONTENT_             CLOB,
   SUMMARY_             VARCHAR2(512),
   HAS_ATTACH_          VARCHAR2(8),
   IS_SHARE_            VARCHAR2(8)                     NOT NULL,
   AUTHOR_              VARCHAR2(64),
   KEYWORDS_            VARCHAR2(256),
   DOC_TYPE_            VARCHAR2(64),
   DOC_PATH_            VARCHAR2(255),
   SWF_PATH_            VARCHAR2(256),
   USER_ID_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INF_DOC PRIMARY KEY (DOC_ID_)
);

COMMENT ON TABLE INF_DOC IS
'文档';

COMMENT ON COLUMN INF_DOC.DOC_ID_ IS
'文档ID';

COMMENT ON COLUMN INF_DOC.FOLDER_ID_ IS
'文件夹ID';

COMMENT ON COLUMN INF_DOC.NAME_ IS
'文档名称';

COMMENT ON COLUMN INF_DOC.CONTENT_ IS
'内容';

COMMENT ON COLUMN INF_DOC.SUMMARY_ IS
'摘要';

COMMENT ON COLUMN INF_DOC.HAS_ATTACH_ IS
'是否包括附件';

COMMENT ON COLUMN INF_DOC.IS_SHARE_ IS
'是否共享';

COMMENT ON COLUMN INF_DOC.AUTHOR_ IS
'作者';

COMMENT ON COLUMN INF_DOC.KEYWORDS_ IS
'关键字';

COMMENT ON COLUMN INF_DOC.DOC_TYPE_ IS
'文档类型';

COMMENT ON COLUMN INF_DOC.DOC_PATH_ IS
'文档路径';

COMMENT ON COLUMN INF_DOC.SWF_PATH_ IS
'SWF文件f路径';

COMMENT ON COLUMN INF_DOC.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN INF_DOC.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_DOC.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_DOC.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_DOC.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_DOC.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_DOC_FILE                                          */
/*==============================================================*/
CREATE TABLE INF_DOC_FILE  (
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   FILE_ID_             VARCHAR2(64)                    NOT NULL,
   CONSTRAINT PK_INF_DOC_FILE PRIMARY KEY (DOC_ID_, FILE_ID_)
);

/*==============================================================*/
/* Table: INF_DOC_FOLDER                                        */
/*==============================================================*/
CREATE TABLE INF_DOC_FOLDER  (
   FOLDER_ID_           VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(128)                   NOT NULL,
   PARENT_              VARCHAR2(64),
   PATH_                VARCHAR2(128),
   DEPTH_               INTEGER                         NOT NULL,
   SN_                  INTEGER,
   SHARE_               VARCHAR2(8)                     NOT NULL,
   DESCP                VARCHAR2(256),
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   TYPE_                VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INF_DOC_FOLDER PRIMARY KEY (FOLDER_ID_)
);

COMMENT ON TABLE INF_DOC_FOLDER IS
'文档文件夹';

COMMENT ON COLUMN INF_DOC_FOLDER.NAME_ IS
'目录名称';

COMMENT ON COLUMN INF_DOC_FOLDER.PARENT_ IS
'父目录';

COMMENT ON COLUMN INF_DOC_FOLDER.PATH_ IS
'路径';

COMMENT ON COLUMN INF_DOC_FOLDER.DEPTH_ IS
'层次';

COMMENT ON COLUMN INF_DOC_FOLDER.SN_ IS
'序号';

COMMENT ON COLUMN INF_DOC_FOLDER.SHARE_ IS
'共享';

COMMENT ON COLUMN INF_DOC_FOLDER.DESCP IS
'文档描述';

COMMENT ON COLUMN INF_DOC_FOLDER.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN INF_DOC_FOLDER.TYPE_ IS
'个人文档文件夹=PERSONAL
公共文档文件夹=PUBLIC
默认为PERSONAL';

COMMENT ON COLUMN INF_DOC_FOLDER.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_DOC_FOLDER.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_DOC_FOLDER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_DOC_FOLDER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_DOC_FOLDER.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_DOC_RIGHT                                         */
/*==============================================================*/
CREATE TABLE INF_DOC_RIGHT  (
   RIGHT_ID_            VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   FOLDER_ID_           VARCHAR2(64),
   RIGHTS_              INTEGER                         NOT NULL,
   IDENTITY_TYPE_       VARCHAR2(64),
   IDENTITY_ID_         VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INF_DOC_RIGHT PRIMARY KEY (RIGHT_ID_)
);

COMMENT ON TABLE INF_DOC_RIGHT IS
'文档或目录的权限，只要是针对公共目录下的文档，或个人的文档的共享

某个目录或文档若没有指定某部门或某个人，即在本表中没有记录，
则表示可以进行所有的操作';

COMMENT ON COLUMN INF_DOC_RIGHT.RIGHT_ID_ IS
'权限ID';

COMMENT ON COLUMN INF_DOC_RIGHT.DOC_ID_ IS
'文档ID';

COMMENT ON COLUMN INF_DOC_RIGHT.FOLDER_ID_ IS
'文件夹ID';

COMMENT ON COLUMN INF_DOC_RIGHT.RIGHTS_ IS
'权限
文档或目录的读写修改权限
1=读
2=修改
4=删除

权限值可以为上面的值之和
如：3则代表进行读，修改的操作


';

COMMENT ON COLUMN INF_DOC_RIGHT.IDENTITY_TYPE_ IS
'授权类型';

COMMENT ON COLUMN INF_DOC_RIGHT.IDENTITY_ID_ IS
'用户或组ID';

COMMENT ON COLUMN INF_DOC_RIGHT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_DOC_RIGHT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_DOC_RIGHT.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_DOC_RIGHT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_DOC_RIGHT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_INBOX                                             */
/*==============================================================*/
CREATE TABLE INF_INBOX  (
   REC_ID_              VARCHAR2(64)                    NOT NULL,
   MSG_ID_              VARCHAR2(64)                    NOT NULL,
   REC_USER_ID_         VARCHAR2(64),
   REC_TYPE_            VARCHAR2(20)                    NOT NULL,
   FULLNAME_            VARCHAR2(50),
   GROUP_ID_            VARCHAR2(64),
   GROUP_NAME_          VARCHAR2(64),
   IS_READ_             VARCHAR2(20),
   IS_DEL_              VARCHAR2(20),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64)                    NOT NULL,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_INF_INBOX PRIMARY KEY (REC_ID_)
);

COMMENT ON TABLE INF_INBOX IS
'内部短消息收件箱';

COMMENT ON COLUMN INF_INBOX.REC_ID_ IS
'接收ID';

COMMENT ON COLUMN INF_INBOX.MSG_ID_ IS
'消息ID';

COMMENT ON COLUMN INF_INBOX.REC_USER_ID_ IS
'接收人ID';

COMMENT ON COLUMN INF_INBOX.REC_TYPE_ IS
'收信=REC
发信=SEND';

COMMENT ON COLUMN INF_INBOX.FULLNAME_ IS
'接收人名称';

COMMENT ON COLUMN INF_INBOX.GROUP_ID_ IS
'用户组ID
0代表全公司';

COMMENT ON COLUMN INF_INBOX.GROUP_NAME_ IS
'组名';

COMMENT ON COLUMN INF_INBOX.IS_READ_ IS
'是否阅读';

COMMENT ON COLUMN INF_INBOX.IS_DEL_ IS
'是否删除';

COMMENT ON COLUMN INF_INBOX.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_INBOX.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_INBOX.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN INF_INBOX.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_INBOX.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: INF_INNER_MAIL                                        */
/*==============================================================*/
CREATE TABLE INF_INNER_MAIL  (
   MAIL_ID_             VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   SENDER_              VARCHAR2(32)                    NOT NULL,
   CC_IDS_              CLOB,
   CC_NAMES_            CLOB,
   SUBJECT_             VARCHAR2(256)                   NOT NULL,
   CONTENT_             CLOB                            NOT NULL,
   SENDER_ID_           VARCHAR2(64)                    NOT NULL,
   URGE_                VARCHAR2(32)                    NOT NULL,
   SENDER_TIME_         TIMESTAMP                            NOT NULL,
   REC_NAMES_           CLOB                            NOT NULL,
   REC_IDS_             CLOB                            NOT NULL,
   STATUS_              SMALLINT                        NOT NULL,
   FILE_IDS_            VARCHAR2(500),
   FILE_NAMES_          VARCHAR2(500),
   FOLDER_ID_           VARCHAR2(64),
   DEL_FLAG_            VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INF_INNER_MAIL PRIMARY KEY (MAIL_ID_)
);

COMMENT ON TABLE INF_INNER_MAIL IS
'内部邮件';

COMMENT ON COLUMN INF_INNER_MAIL.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN INF_INNER_MAIL.CC_IDS_ IS
'抄送人ID列表
用'',''分开';

COMMENT ON COLUMN INF_INNER_MAIL.CC_NAMES_ IS
'抄送人姓名列表';

COMMENT ON COLUMN INF_INNER_MAIL.SUBJECT_ IS
'邮件标题';

COMMENT ON COLUMN INF_INNER_MAIL.CONTENT_ IS
'邮件内容';

COMMENT ON COLUMN INF_INNER_MAIL.URGE_ IS
'1=一般
2=重要
3=非常重要';

COMMENT ON COLUMN INF_INNER_MAIL.REC_NAMES_ IS
'收件人姓名列表';

COMMENT ON COLUMN INF_INNER_MAIL.REC_IDS_ IS
'收件人ID列表
用'',''分隔';

COMMENT ON COLUMN INF_INNER_MAIL.STATUS_ IS
'邮件状态
1=正式邮件
0=草稿邮件';

COMMENT ON COLUMN INF_INNER_MAIL.FILE_IDS_ IS
'附件Ids，多个附件的ID，通过,分割';

COMMENT ON COLUMN INF_INNER_MAIL.FILE_NAMES_ IS
'附件名称列表，通过,进行分割';

COMMENT ON COLUMN INF_INNER_MAIL.FOLDER_ID_ IS
'文件夹ID';

COMMENT ON COLUMN INF_INNER_MAIL.DEL_FLAG_ IS
'删除标识
YES
NO';

COMMENT ON COLUMN INF_INNER_MAIL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_INNER_MAIL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_INNER_MAIL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_INNER_MAIL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_INNER_MAIL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_INNER_MSG                                         */
/*==============================================================*/
CREATE TABLE INF_INNER_MSG  (
   MSG_ID_              VARCHAR2(64)                    NOT NULL,
   CONTENT_             VARCHAR2(512)                   NOT NULL,
   LINK_MSG_            VARCHAR2(1024),
   CATEGORY_            VARCHAR2(50),
   SENDER_ID_           VARCHAR2(50),
   SENDER_              VARCHAR2(50),
   DEL_FLAG_            VARCHAR2(20),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64)                    NOT NULL,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_INF_INNER_MSG PRIMARY KEY (MSG_ID_)
);

COMMENT ON TABLE INF_INNER_MSG IS
'内部短消息';

COMMENT ON COLUMN INF_INNER_MSG.MSG_ID_ IS
'消息ID';

COMMENT ON COLUMN INF_INNER_MSG.CONTENT_ IS
'消息内容';

COMMENT ON COLUMN INF_INNER_MSG.LINK_MSG_ IS
'消息携带连接,
生成的消息带有连接，但本地的连接不加contextPath';

COMMENT ON COLUMN INF_INNER_MSG.CATEGORY_ IS
'消息分类';

COMMENT ON COLUMN INF_INNER_MSG.SENDER_ IS
'发送人名';

COMMENT ON COLUMN INF_INNER_MSG.DEL_FLAG_ IS
'删除标识';

COMMENT ON COLUMN INF_INNER_MSG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_INNER_MSG.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_INNER_MSG.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN INF_INNER_MSG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_INNER_MSG.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: INF_MAIL                                              */
/*==============================================================*/
CREATE TABLE INF_MAIL  (
   MAIL_ID_             VARCHAR2(64)                    NOT NULL,
   UID_                 VARCHAR2(512),
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   CONFIG_ID_           VARCHAR2(64)                    NOT NULL,
   FOLDER_ID_           VARCHAR2(64),
   SUBJECT_             VARCHAR2(512)                   NOT NULL,
   CONTENT_             CLOB,
   SENDER_ADDRS_        CLOB                            NOT NULL,
   SENDER_ALIAS_        CLOB,
   REC_ADDRS_           CLOB                            NOT NULL,
   REC_ALIAS_           CLOB,
   CC_ADDRS_            CLOB,
   CC_ALIAS_            CLOB,
   BCC_ADDRS_           CLOB,
   BCC_ALIAS_           CLOB,
   SEND_DATE_           TIMESTAMP                            NOT NULL,
   READ_FLAG_           VARCHAR2(8)                     NOT NULL,
   REPLY_FLAG_          VARCHAR2(8)                     NOT NULL,
   STATUS_              VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INF_MAIL PRIMARY KEY (MAIL_ID_)
);

COMMENT ON TABLE INF_MAIL IS
'外部邮件';

COMMENT ON COLUMN INF_MAIL.UID_ IS
'外部邮箱标识ID';

COMMENT ON COLUMN INF_MAIL.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN INF_MAIL.CONFIG_ID_ IS
'邮箱设置ID';

COMMENT ON COLUMN INF_MAIL.FOLDER_ID_ IS
'文件夹ID';

COMMENT ON COLUMN INF_MAIL.SUBJECT_ IS
'主题';

COMMENT ON COLUMN INF_MAIL.CONTENT_ IS
'内容';

COMMENT ON COLUMN INF_MAIL.SENDER_ADDRS_ IS
'发件人地址';

COMMENT ON COLUMN INF_MAIL.SENDER_ALIAS_ IS
'发件人地址别名';

COMMENT ON COLUMN INF_MAIL.REC_ADDRS_ IS
'收件人地址';

COMMENT ON COLUMN INF_MAIL.REC_ALIAS_ IS
'收件人地址别名';

COMMENT ON COLUMN INF_MAIL.CC_ADDRS_ IS
'抄送人地址';

COMMENT ON COLUMN INF_MAIL.CC_ALIAS_ IS
'抄送人地址别名';

COMMENT ON COLUMN INF_MAIL.BCC_ADDRS_ IS
'暗送人地址';

COMMENT ON COLUMN INF_MAIL.BCC_ALIAS_ IS
'暗送人地址别名';

COMMENT ON COLUMN INF_MAIL.SEND_DATE_ IS
'发送日期';

COMMENT ON COLUMN INF_MAIL.READ_FLAG_ IS
'0:未阅
1:已阅';

COMMENT ON COLUMN INF_MAIL.REPLY_FLAG_ IS
'0:未回复
1;已回复';

COMMENT ON COLUMN INF_MAIL.STATUS_ IS
'状态
COMMON 正常
DELETED 删除';

COMMENT ON COLUMN INF_MAIL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_MAIL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_MAIL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_MAIL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_MAIL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_MAIL_BOX                                          */
/*==============================================================*/
CREATE TABLE INF_MAIL_BOX  (
   BOX_ID_              VARCHAR2(64)                    NOT NULL,
   MAIL_ID_             VARCHAR2(64),
   FOLDER_ID_           VARCHAR2(64),
   USER_ID_             VARCHAR2(64),
   IS_DEL_              VARCHAR2(20)                    NOT NULL,
   IS_READ_             VARCHAR2(20)                    NOT NULL,
   REPLY_               VARCHAR2(20)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INF_MAIL_BOX PRIMARY KEY (BOX_ID_)
);

COMMENT ON TABLE INF_MAIL_BOX IS
'内部邮件收件箱';

COMMENT ON COLUMN INF_MAIL_BOX.MAIL_ID_ IS
'邮件ID';

COMMENT ON COLUMN INF_MAIL_BOX.FOLDER_ID_ IS
'文件夹ID';

COMMENT ON COLUMN INF_MAIL_BOX.USER_ID_ IS
'员工ID';

COMMENT ON COLUMN INF_MAIL_BOX.IS_DEL_ IS
'删除标识=YES';

COMMENT ON COLUMN INF_MAIL_BOX.IS_READ_ IS
'阅读标识';

COMMENT ON COLUMN INF_MAIL_BOX.REPLY_ IS
'回复标识';

COMMENT ON COLUMN INF_MAIL_BOX.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_MAIL_BOX.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_MAIL_BOX.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_MAIL_BOX.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_MAIL_BOX.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_MAIL_CONFIG                                       */
/*==============================================================*/
CREATE TABLE INF_MAIL_CONFIG  (
   CONFIG_ID_           VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   USER_NAME_           VARCHAR2(128),
   ACCOUNT_             VARCHAR2(128),
   MAIL_ACCOUNT_        VARCHAR2(128)                   NOT NULL,
   MAIL_PWD_            VARCHAR2(128)                   NOT NULL,
   PROTOCOL_            VARCHAR2(32)                    NOT NULL,
   SSL_                 VARCHAR2(12),
   SMTP_HOST_           VARCHAR2(128)                   NOT NULL,
   SMTP_PORT_           VARCHAR2(64)                    NOT NULL,
   RECP_HOST_           VARCHAR2(128)                   NOT NULL,
   RECP_PORT_           VARCHAR2(64)                    NOT NULL,
   IS_DEFAULT_          VARCHAR2(20)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INF_MAIL_CONFIG PRIMARY KEY (CONFIG_ID_)
);

COMMENT ON TABLE INF_MAIL_CONFIG IS
'外部邮箱设置';

COMMENT ON COLUMN INF_MAIL_CONFIG.CONFIG_ID_ IS
'配置ID';

COMMENT ON COLUMN INF_MAIL_CONFIG.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN INF_MAIL_CONFIG.USER_NAME_ IS
'用户名称';

COMMENT ON COLUMN INF_MAIL_CONFIG.ACCOUNT_ IS
'帐号名称';

COMMENT ON COLUMN INF_MAIL_CONFIG.MAIL_ACCOUNT_ IS
'外部邮件地址';

COMMENT ON COLUMN INF_MAIL_CONFIG.MAIL_PWD_ IS
'外部邮件密码';

COMMENT ON COLUMN INF_MAIL_CONFIG.PROTOCOL_ IS
'协议类型
IMAP
POP3';

COMMENT ON COLUMN INF_MAIL_CONFIG.SSL_ IS
'启用SSL
true or false';

COMMENT ON COLUMN INF_MAIL_CONFIG.SMTP_HOST_ IS
'邮件发送主机';

COMMENT ON COLUMN INF_MAIL_CONFIG.SMTP_PORT_ IS
'邮件发送端口';

COMMENT ON COLUMN INF_MAIL_CONFIG.RECP_HOST_ IS
'接收主机';

COMMENT ON COLUMN INF_MAIL_CONFIG.RECP_PORT_ IS
'接收端口';

COMMENT ON COLUMN INF_MAIL_CONFIG.IS_DEFAULT_ IS
'是否默认
YES
NO';

COMMENT ON COLUMN INF_MAIL_CONFIG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_MAIL_CONFIG.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_MAIL_CONFIG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_MAIL_CONFIG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_MAIL_CONFIG.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INF_MAIL_FILE                                         */
/*==============================================================*/
CREATE TABLE INF_MAIL_FILE  (
   FILE_ID_             VARCHAR2(64)                    NOT NULL,
   MAIL_ID_             VARCHAR2(64)                    NOT NULL,
   CONSTRAINT PK_INF_MAIL_FILE PRIMARY KEY (FILE_ID_, MAIL_ID_)
);

COMMENT ON TABLE INF_MAIL_FILE IS
'外部邮箱附件';

/*==============================================================*/
/* Table: INF_MAIL_FOLDER                                       */
/*==============================================================*/
CREATE TABLE INF_MAIL_FOLDER  (
   FOLDER_ID_           VARCHAR2(64)                    NOT NULL,
   CONFIG_ID_           VARCHAR2(64),
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(128)                   NOT NULL,
   PARENT_ID_           VARCHAR2(64),
   DEPTH_               INTEGER                         NOT NULL,
   PATH_                VARCHAR2(256),
   TYPE_                VARCHAR2(32)                    NOT NULL,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   IN_OUT_              VARCHAR2(20),
   CONSTRAINT PK_INF_MAIL_FOLDER PRIMARY KEY (FOLDER_ID_)
);

COMMENT ON TABLE INF_MAIL_FOLDER IS
'邮件文件夹';

COMMENT ON COLUMN INF_MAIL_FOLDER.FOLDER_ID_ IS
'文件夹编号';

COMMENT ON COLUMN INF_MAIL_FOLDER.CONFIG_ID_ IS
'配置ID';

COMMENT ON COLUMN INF_MAIL_FOLDER.USER_ID_ IS
'主键';

COMMENT ON COLUMN INF_MAIL_FOLDER.NAME_ IS
'文件夹名称';

COMMENT ON COLUMN INF_MAIL_FOLDER.PARENT_ID_ IS
'父目录';

COMMENT ON COLUMN INF_MAIL_FOLDER.DEPTH_ IS
'目录层';

COMMENT ON COLUMN INF_MAIL_FOLDER.PATH_ IS
'目录路径';

COMMENT ON COLUMN INF_MAIL_FOLDER.TYPE_ IS
'文件夹类型
RECEIVE-FOLDER=收信箱
SENDER-FOLDEr=发信箱
DRAFT-FOLDER=草稿箱
DEL-FOLDER=删除箱
OTHER-FOLDER=其他';

COMMENT ON COLUMN INF_MAIL_FOLDER.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN INF_MAIL_FOLDER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INF_MAIL_FOLDER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INF_MAIL_FOLDER.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INF_MAIL_FOLDER.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INF_MAIL_FOLDER.IN_OUT_ IS
'内部外部邮箱标识
IN=内部
OUT=外部';

/*==============================================================*/
/* Table: INS_COLUMN                                            */
/*==============================================================*/
CREATE TABLE INS_COLUMN  (
   COL_ID_              VARCHAR2(64)                    NOT NULL,
   TYPE_ID_             VARCHAR2(64),
   NAME_                VARCHAR2(80)                    NOT NULL,
   KEY_                 VARCHAR2(50)                    NOT NULL,
   URL_                 VARCHAR2(255),
   ENABLED_             VARCHAR2(20)                    NOT NULL,
   NUMS_OF_PAGE_        INTEGER,
   ALLOW_CLOSE_         VARCHAR2(20),
   COL_TYPE_            VARCHAR2(50),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INS_COLUMN PRIMARY KEY (COL_ID_)
);

COMMENT ON TABLE INS_COLUMN IS
'信息栏目';

COMMENT ON COLUMN INS_COLUMN.COL_ID_ IS
'栏目ID';

COMMENT ON COLUMN INS_COLUMN.NAME_ IS
'栏目名称';

COMMENT ON COLUMN INS_COLUMN.KEY_ IS
'栏目Key';

COMMENT ON COLUMN INS_COLUMN.ENABLED_ IS
'是否启用';

COMMENT ON COLUMN INS_COLUMN.NUMS_OF_PAGE_ IS
'每页记录数';

COMMENT ON COLUMN INS_COLUMN.ALLOW_CLOSE_ IS
'是否允许关闭';

COMMENT ON COLUMN INS_COLUMN.COL_TYPE_ IS
'信息栏目类型
公告
公司或单位新闻
部门新闻';

COMMENT ON COLUMN INS_COLUMN.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INS_COLUMN.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INS_COLUMN.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INS_COLUMN.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INS_COLUMN.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INS_COL_NEW                                           */
/*==============================================================*/
CREATE TABLE INS_COL_NEW  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   COL_ID_              VARCHAR2(64)                    NOT NULL,
   NEW_ID_              VARCHAR2(64)                    NOT NULL,
   SN_                  INTEGER                         NOT NULL,
   START_TIME_          TIMESTAMP                            NOT NULL,
   END_TIME_            TIMESTAMP                            NOT NULL,
   IS_LONG_VALID_       VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INS_COL_NEW PRIMARY KEY (ID_)
);

COMMENT ON TABLE INS_COL_NEW IS
'信息所属栏目';

COMMENT ON COLUMN INS_COL_NEW.ID_ IS
'ID_';

COMMENT ON COLUMN INS_COL_NEW.COL_ID_ IS
'栏目ID';

COMMENT ON COLUMN INS_COL_NEW.NEW_ID_ IS
'新闻ID';

COMMENT ON COLUMN INS_COL_NEW.SN_ IS
'序号';

COMMENT ON COLUMN INS_COL_NEW.START_TIME_ IS
'有效开始时间';

COMMENT ON COLUMN INS_COL_NEW.END_TIME_ IS
'有效结束时间';

COMMENT ON COLUMN INS_COL_NEW.IS_LONG_VALID_ IS
'是否长期有效';

COMMENT ON COLUMN INS_COL_NEW.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INS_COL_NEW.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INS_COL_NEW.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INS_COL_NEW.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INS_COL_NEW.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INS_COL_TYPE                                          */
/*==============================================================*/
CREATE TABLE INS_COL_TYPE  (
   TYPE_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(50)                    NOT NULL,
   KEY_                 VARCHAR2(50)                    NOT NULL,
   URL_                 VARCHAR2(100),
   MORE_URL_            VARCHAR2(100),
   LOAD_TYPE_           VARCHAR2(20),
   TEMP_ID_             VARCHAR2(64),
   TEMP_NAME_           VARCHAR2(64),
   ICON_CLS_            VARCHAR2(20),
   MEMO_                VARCHAR2(512),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64)                    NOT NULL,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_INS_COL_TYPE PRIMARY KEY (TYPE_ID_)
);

COMMENT ON TABLE INS_COL_TYPE IS
'栏目分类表';

COMMENT ON COLUMN INS_COL_TYPE.NAME_ IS
'栏目名称';

COMMENT ON COLUMN INS_COL_TYPE.KEY_ IS
'栏目Key';

COMMENT ON COLUMN INS_COL_TYPE.URL_ IS
'栏目映射URL';

COMMENT ON COLUMN INS_COL_TYPE.LOAD_TYPE_ IS
'加载类型
URL=URL
TEMPLATE=模板';

COMMENT ON COLUMN INS_COL_TYPE.TEMP_ID_ IS
'模板ID';

COMMENT ON COLUMN INS_COL_TYPE.TEMP_NAME_ IS
'模板名称';

COMMENT ON COLUMN INS_COL_TYPE.MEMO_ IS
'栏目分类描述';

COMMENT ON COLUMN INS_COL_TYPE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INS_COL_TYPE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INS_COL_TYPE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN INS_COL_TYPE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INS_COL_TYPE.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: INS_NEWS                                              */
/*==============================================================*/
CREATE TABLE INS_NEWS  (
   NEW_ID_              VARCHAR2(64)                    NOT NULL,
   SUBJECT_             VARCHAR2(120)                   NOT NULL,
   TAG_                 VARCHAR2(80),
   KEYWORDS_            VARCHAR2(255),
   CONTENT_             CLOB,
   IS_IMG_              VARCHAR2(20),
   IMG_FILE_ID_         VARCHAR2(64),
   READ_TIMES_          INTEGER                         NOT NULL,
   AUTHOR_              VARCHAR2(50),
   ALLOW_CMT_           VARCHAR2(20),
   STATUS_              VARCHAR2(20)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INS_NEWS PRIMARY KEY (NEW_ID_)
);

COMMENT ON TABLE INS_NEWS IS
'信息公告';

COMMENT ON COLUMN INS_NEWS.SUBJECT_ IS
'标题';

COMMENT ON COLUMN INS_NEWS.TAG_ IS
'标签';

COMMENT ON COLUMN INS_NEWS.KEYWORDS_ IS
'关键字';

COMMENT ON COLUMN INS_NEWS.CONTENT_ IS
'内容';

COMMENT ON COLUMN INS_NEWS.IS_IMG_ IS
'是否为图片新闻';

COMMENT ON COLUMN INS_NEWS.IMG_FILE_ID_ IS
'图片文件ID';

COMMENT ON COLUMN INS_NEWS.READ_TIMES_ IS
'阅读次数';

COMMENT ON COLUMN INS_NEWS.AUTHOR_ IS
'作者';

COMMENT ON COLUMN INS_NEWS.ALLOW_CMT_ IS
'是否允许评论';

COMMENT ON COLUMN INS_NEWS.STATUS_ IS
'状态';

COMMENT ON COLUMN INS_NEWS.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INS_NEWS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INS_NEWS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INS_NEWS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INS_NEWS.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INS_NEWS_CM                                           */
/*==============================================================*/
CREATE TABLE INS_NEWS_CM  (
   COMM_ID_             VARCHAR2(64)                    NOT NULL,
   NEW_ID_              VARCHAR2(64)                    NOT NULL,
   FULL_NAME_           VARCHAR2(50)                    NOT NULL,
   CONTENT_             VARCHAR2(1024)                  NOT NULL,
   AGREE_NUMS_          INTEGER                         NOT NULL,
   REFUSE_NUMS_         INTEGER                         NOT NULL,
   IS_REPLY_            VARCHAR2(20)                    NOT NULL,
   REP_ID_              VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64)                    NOT NULL,
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INS_NEWS_CM PRIMARY KEY (COMM_ID_)
);

COMMENT ON TABLE INS_NEWS_CM IS
'公司或新闻评论';

COMMENT ON COLUMN INS_NEWS_CM.COMM_ID_ IS
'评论ID';

COMMENT ON COLUMN INS_NEWS_CM.NEW_ID_ IS
'信息ID';

COMMENT ON COLUMN INS_NEWS_CM.FULL_NAME_ IS
'评论人名';

COMMENT ON COLUMN INS_NEWS_CM.CONTENT_ IS
'评论内容';

COMMENT ON COLUMN INS_NEWS_CM.AGREE_NUMS_ IS
'赞同与顶';

COMMENT ON COLUMN INS_NEWS_CM.REFUSE_NUMS_ IS
'反对与鄙视次数';

COMMENT ON COLUMN INS_NEWS_CM.IS_REPLY_ IS
'是否为回复';

COMMENT ON COLUMN INS_NEWS_CM.REP_ID_ IS
'回复评论ID';

COMMENT ON COLUMN INS_NEWS_CM.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INS_NEWS_CM.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INS_NEWS_CM.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INS_NEWS_CM.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INS_NEWS_CM.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INS_PORTAL                                            */
/*==============================================================*/
CREATE TABLE INS_PORTAL  (
   PORT_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(128)                   NOT NULL,
   KEY_                 VARCHAR2(64)                    NOT NULL,
   COL_NUMS_            INTEGER,
   COL_WIDTHS_          VARCHAR2(50),
   IS_DEFAULT_          VARCHAR2(20)                    NOT NULL,
   DESC_                VARCHAR2(512),
   USER_ID_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INS_PORTAL PRIMARY KEY (PORT_ID_)
);

COMMENT ON TABLE INS_PORTAL IS
'PORTAL门户定义';

COMMENT ON COLUMN INS_PORTAL.NAME_ IS
'门户名称';

COMMENT ON COLUMN INS_PORTAL.KEY_ IS
'门户KEY
个人门户
公司门户
部门门户
知识门户';

COMMENT ON COLUMN INS_PORTAL.COL_NUMS_ IS
'列数';

COMMENT ON COLUMN INS_PORTAL.COL_WIDTHS_ IS
'栏目宽
三列格式如250,100%,400';

COMMENT ON COLUMN INS_PORTAL.IS_DEFAULT_ IS
'是否为系统缺省';

COMMENT ON COLUMN INS_PORTAL.DESC_ IS
'描述';

COMMENT ON COLUMN INS_PORTAL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INS_PORTAL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INS_PORTAL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INS_PORTAL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INS_PORTAL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: INS_PORT_COL                                          */
/*==============================================================*/
CREATE TABLE INS_PORT_COL  (
   CONF_ID_             VARCHAR2(64)                    NOT NULL,
   PORT_ID_             VARCHAR2(64)                    NOT NULL,
   COL_ID_              VARCHAR2(64)                    NOT NULL,
   WIDTH_               INTEGER,
   HEIGHT_              INTEGER                         NOT NULL,
   WIDTH_UNIT_          VARCHAR2(8),
   HEIGHT_UNIT_         VARCHAR2(8)                     NOT NULL,
   COL_NUM_             INTEGER,
   SN_                  INTEGER                         NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_INS_PORT_COL PRIMARY KEY (CONF_ID_)
);

COMMENT ON TABLE INS_PORT_COL IS
'门户栏目配置';

COMMENT ON COLUMN INS_PORT_COL.PORT_ID_ IS
'门户ID';

COMMENT ON COLUMN INS_PORT_COL.COL_ID_ IS
'栏目ID';

COMMENT ON COLUMN INS_PORT_COL.WIDTH_ IS
'宽度';

COMMENT ON COLUMN INS_PORT_COL.HEIGHT_ IS
'高度';

COMMENT ON COLUMN INS_PORT_COL.WIDTH_UNIT_ IS
'宽度单位
百份比=%
像数=px';

COMMENT ON COLUMN INS_PORT_COL.HEIGHT_UNIT_ IS
'高度单位
百份比=%
像数=px';

COMMENT ON COLUMN INS_PORT_COL.COL_NUM_ IS
'列号';

COMMENT ON COLUMN INS_PORT_COL.SN_ IS
'列中序号';

COMMENT ON COLUMN INS_PORT_COL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN INS_PORT_COL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN INS_PORT_COL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN INS_PORT_COL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN INS_PORT_COL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: KD_DOC                                                */
/*==============================================================*/
CREATE TABLE KD_DOC  (
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   TREE_ID_             VARCHAR2(64),
   SUBJECT_             VARCHAR2(128)                   NOT NULL,
   TEMP_ID_             VARCHAR2(64),
   IS_ESSENCE_          VARCHAR2(20),
   AUTHOR_              VARCHAR2(64)                    NOT NULL,
   AUTHOR_TYPE_         VARCHAR2(20),
   AUTHOR_POS_          VARCHAR2(64),
   BELONG_DEPID_        VARCHAR2(64),
   KEYWORDS_            VARCHAR2(128),
   APPROVAL_ID_         VARCHAR2(64),
   ISSUED_TIME_         TIMESTAMP,
   VIEW_TIMES_          INTEGER,
   SUMMARY_             VARCHAR2(512),
   CONTENT_             CLOB,
   COMP_SCORE_          NUMBER(8,2),
   TAGS                 VARCHAR2(200),
   STORE_PEROID_        INTEGER,
   COVER_IMG_ID_        VARCHAR2(64),
   IMG_MAPS_            CLOB,
   BPM_INST_ID_         VARCHAR2(64),
   ATT_FILEIDS_         VARCHAR2(512),
   ARCH_CLASS_          VARCHAR2(20),
   STATUS_              VARCHAR2(20)                    NOT NULL,
   DOC_TYPE_            VARCHAR2(20),
   VERSION_             INTEGER,
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC PRIMARY KEY (DOC_ID_)
);

COMMENT ON TABLE KD_DOC IS
'知识文档、地图、词条';

COMMENT ON COLUMN KD_DOC.TREE_ID_ IS
'所属分类';

COMMENT ON COLUMN KD_DOC.SUBJECT_ IS
'文档标题';

COMMENT ON COLUMN KD_DOC.TEMP_ID_ IS
'词条或知识模板ID';

COMMENT ON COLUMN KD_DOC.IS_ESSENCE_ IS
'是否精华';

COMMENT ON COLUMN KD_DOC.AUTHOR_ IS
'作者';

COMMENT ON COLUMN KD_DOC.AUTHOR_TYPE_ IS
'作者类型
内部=INNER
外部=OUTER';

COMMENT ON COLUMN KD_DOC.AUTHOR_POS_ IS
'所属岗位';

COMMENT ON COLUMN KD_DOC.BELONG_DEPID_ IS
'所属部门ID';

COMMENT ON COLUMN KD_DOC.KEYWORDS_ IS
'关键字';

COMMENT ON COLUMN KD_DOC.APPROVAL_ID_ IS
'审批人ID';

COMMENT ON COLUMN KD_DOC.ISSUED_TIME_ IS
'发布日期';

COMMENT ON COLUMN KD_DOC.VIEW_TIMES_ IS
'浏览次数';

COMMENT ON COLUMN KD_DOC.SUMMARY_ IS
'摘要';

COMMENT ON COLUMN KD_DOC.CONTENT_ IS
'知识内容';

COMMENT ON COLUMN KD_DOC.COMP_SCORE_ IS
'综合评分';

COMMENT ON COLUMN KD_DOC.TAGS IS
'标签';

COMMENT ON COLUMN KD_DOC.STORE_PEROID_ IS
'存放年限
单位为年';

COMMENT ON COLUMN KD_DOC.COVER_IMG_ID_ IS
'封面图';

COMMENT ON COLUMN KD_DOC.IMG_MAPS_ IS
'知识地图描点信息';

COMMENT ON COLUMN KD_DOC.BPM_INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN KD_DOC.ATT_FILEIDS_ IS
'文档附件';

COMMENT ON COLUMN KD_DOC.ARCH_CLASS_ IS
'归档分类
知识文档
知识地图
词条';

COMMENT ON COLUMN KD_DOC.STATUS_ IS
'文档状态
废弃=abandon
草稿=draft
驳回=back
待审=pending
发布=issued
过期=overdue
归档=archived';

COMMENT ON COLUMN KD_DOC.DOC_TYPE_ IS
'知识文档=KD_DOC
词条=KD_WORD
知识地图=KD_MAP';

COMMENT ON COLUMN KD_DOC.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN KD_DOC.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: KD_DOC_CMMT                                           */
/*==============================================================*/
CREATE TABLE KD_DOC_CMMT  (
   COMMENT_ID_          VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   SCORE_               INTEGER                         NOT NULL,
   CONTENT_             VARCHAR2(1024),
   LEVEL_               VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_CMMT PRIMARY KEY (COMMENT_ID_)
);

COMMENT ON TABLE KD_DOC_CMMT IS
'知识文档点评';

COMMENT ON COLUMN KD_DOC_CMMT.COMMENT_ID_ IS
'点评ID';

COMMENT ON COLUMN KD_DOC_CMMT.DOC_ID_ IS
'知识ID';

COMMENT ON COLUMN KD_DOC_CMMT.SCORE_ IS
'分数';

COMMENT ON COLUMN KD_DOC_CMMT.CONTENT_ IS
'点评内容';

COMMENT ON COLUMN KD_DOC_CMMT.LEVEL_ IS
'非常好
很好
一般
差
很差';

COMMENT ON COLUMN KD_DOC_CMMT.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_CMMT.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_CMMT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_CMMT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_CMMT.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_DOC_CONTR                                          */
/*==============================================================*/
CREATE TABLE KD_DOC_CONTR  (
   CONT_ID_             VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   MOD_TYPE_            VARCHAR2(50)                    NOT NULL,
   REASON_              VARCHAR2(500),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_CONTR PRIMARY KEY (CONT_ID_)
);

COMMENT ON TABLE KD_DOC_CONTR IS
'知识文档贡献者';

COMMENT ON COLUMN KD_DOC_CONTR.DOC_ID_ IS
'词条';

COMMENT ON COLUMN KD_DOC_CONTR.MOD_TYPE_ IS
'更正错误
内容扩充
删除冗余
目录结构
概述
基本信息栏
内链
排版
参考资料
图片';

COMMENT ON COLUMN KD_DOC_CONTR.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_CONTR.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_CONTR.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_CONTR.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_CONTR.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_DOC_DIR                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_DIR  (
   DIR_ID_              VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   LEVEL_               VARCHAR2(20)                    NOT NULL,
   SUBJECT_             VARCHAR2(120)                   NOT NULL,
   ANCHOR_              VARCHAR2(255),
   PARENT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_DIR PRIMARY KEY (DIR_ID_)
);

COMMENT ON TABLE KD_DOC_DIR IS
'文档索引目录';

COMMENT ON COLUMN KD_DOC_DIR.DOC_ID_ IS
'文档ID';

COMMENT ON COLUMN KD_DOC_DIR.LEVEL_ IS
'标题等级
1级标题
2组标题';

COMMENT ON COLUMN KD_DOC_DIR.SUBJECT_ IS
'标题';

COMMENT ON COLUMN KD_DOC_DIR.ANCHOR_ IS
'标题连接锚点';

COMMENT ON COLUMN KD_DOC_DIR.PARENT_ID_ IS
'上级目录ID';

COMMENT ON COLUMN KD_DOC_DIR.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_DIR.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_DIR.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_DIR.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN KD_DOC_DIR.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: KD_DOC_FAV                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_FAV  (
   FAV_ID_              VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   QUE_ID_              VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_FAV PRIMARY KEY (FAV_ID_)
);

COMMENT ON TABLE KD_DOC_FAV IS
'文档知识收藏';

COMMENT ON COLUMN KD_DOC_FAV.DOC_ID_ IS
'文档ID';

COMMENT ON COLUMN KD_DOC_FAV.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_FAV.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_FAV.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_FAV.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN KD_DOC_FAV.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: KD_DOC_HANDLE                                         */
/*==============================================================*/
CREATE TABLE KD_DOC_HANDLE  (
   HANDLE_ID_           VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   TYPE_                VARCHAR2(20),
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   IS_READ_             SMALLINT,
   OPINION_             VARCHAR2(1024),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_KD_DOC_HANDLE PRIMARY KEY (HANDLE_ID_)
);

COMMENT ON TABLE KD_DOC_HANDLE IS
'公文办理';

COMMENT ON COLUMN KD_DOC_HANDLE.HANDLE_ID_ IS
'办理ID';

COMMENT ON COLUMN KD_DOC_HANDLE.DOC_ID_ IS
'收发文ID';

COMMENT ON COLUMN KD_DOC_HANDLE.TYPE_ IS
'办理类型
分发
传阅
拟办
批办
承办
注办';

COMMENT ON COLUMN KD_DOC_HANDLE.USER_ID_ IS
'办理人ID';

COMMENT ON COLUMN KD_DOC_HANDLE.IS_READ_ IS
'是否已阅';

COMMENT ON COLUMN KD_DOC_HANDLE.OPINION_ IS
'处理意见';

COMMENT ON COLUMN KD_DOC_HANDLE.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN KD_DOC_HANDLE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN KD_DOC_HANDLE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_HANDLE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_HANDLE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: KD_DOC_HIS                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_HIS  (
   HIS_ID_              VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   VERSION_             INTEGER                         NOT NULL,
   SUBJECT_             VARCHAR2(128)                   NOT NULL,
   CONTENT_             CLOB                            NOT NULL,
   AUTHOR_              VARCHAR2(50)                    NOT NULL,
   COVER_FILE_ID_       VARCHAR2(64),
   ATTACH_IDS_          VARCHAR2(512),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_HIS PRIMARY KEY (HIS_ID_)
);

COMMENT ON TABLE KD_DOC_HIS IS
'知识文档历史版本';

COMMENT ON COLUMN KD_DOC_HIS.DOC_ID_ IS
'文档ID';

COMMENT ON COLUMN KD_DOC_HIS.VERSION_ IS
'版本号';

COMMENT ON COLUMN KD_DOC_HIS.SUBJECT_ IS
'文档标题';

COMMENT ON COLUMN KD_DOC_HIS.CONTENT_ IS
'文档内容';

COMMENT ON COLUMN KD_DOC_HIS.AUTHOR_ IS
'文档作者';

COMMENT ON COLUMN KD_DOC_HIS.COVER_FILE_ID_ IS
'文档封面';

COMMENT ON COLUMN KD_DOC_HIS.ATTACH_IDS_ IS
'文档附件IDS';

COMMENT ON COLUMN KD_DOC_HIS.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_HIS.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_HIS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_HIS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_HIS.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_DOC_READ                                           */
/*==============================================================*/
CREATE TABLE KD_DOC_READ  (
   READ_ID_             VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   DOC_STATUS_          VARCHAR2(50),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_READ PRIMARY KEY (READ_ID_)
);

COMMENT ON TABLE KD_DOC_READ IS
'知识文档阅读';

COMMENT ON COLUMN KD_DOC_READ.READ_ID_ IS
'阅读人ID';

COMMENT ON COLUMN KD_DOC_READ.DOC_STATUS_ IS
'阅读文档阶段';

COMMENT ON COLUMN KD_DOC_READ.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_READ.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_READ.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_READ.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_READ.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_DOC_REM                                            */
/*==============================================================*/
CREATE TABLE KD_DOC_REM  (
   REM_ID_              VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   DEP_ID_              VARCHAR2(64),
   USER_ID_             VARCHAR2(64),
   LEVEL_               INTEGER,
   MEMO_                VARCHAR2(1024),
   REC_TREE_ID_         VARCHAR2(64),
   NOTICE_CREATOR_      VARCHAR2(20),
   NOTICE_TYPE_         VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_REM PRIMARY KEY (REM_ID_)
);

COMMENT ON TABLE KD_DOC_REM IS
'文档推荐';

COMMENT ON COLUMN KD_DOC_REM.REM_ID_ IS
'推荐ID';

COMMENT ON COLUMN KD_DOC_REM.REC_TREE_ID_ IS
'推荐精华库分类ID';

COMMENT ON COLUMN KD_DOC_REM.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_REM.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_REM.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_REM.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_REM.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_DOC_RIGHT                                          */
/*==============================================================*/
CREATE TABLE KD_DOC_RIGHT  (
   RIGHT_ID_            VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   IDENTITY_TYPE_       VARCHAR2(20)                    NOT NULL,
   IDENTITY_ID_         VARCHAR2(64)                    NOT NULL,
   RIGHT_               VARCHAR2(60),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_KD_DOC_RIGHT PRIMARY KEY (RIGHT_ID_)
);

COMMENT ON TABLE KD_DOC_RIGHT IS
'文档权限';

COMMENT ON COLUMN KD_DOC_RIGHT.RIGHT_ID_ IS
'权限ID';

COMMENT ON COLUMN KD_DOC_RIGHT.DOC_ID_ IS
'文档ID';

COMMENT ON COLUMN KD_DOC_RIGHT.IDENTITY_TYPE_ IS
'授权类型
USER=用户
GROUP=用户组';

COMMENT ON COLUMN KD_DOC_RIGHT.IDENTITY_ID_ IS
'用户或组ID';

COMMENT ON COLUMN KD_DOC_RIGHT.RIGHT_ IS
'READ=可读
EDIT=可编辑
PRINT=打印
DOWN_FILE=可下载附件';

COMMENT ON COLUMN KD_DOC_RIGHT.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_RIGHT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN KD_DOC_RIGHT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_RIGHT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_RIGHT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: KD_DOC_ROUND                                          */
/*==============================================================*/
CREATE TABLE KD_DOC_ROUND  (
   ROUND_ID_            VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_DOC_ROUND PRIMARY KEY (ROUND_ID_)
);

COMMENT ON TABLE KD_DOC_ROUND IS
'文档传阅';

COMMENT ON COLUMN KD_DOC_ROUND.DOC_ID_ IS
'文档ID';

COMMENT ON COLUMN KD_DOC_ROUND.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_DOC_ROUND.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_ROUND.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_ROUND.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_ROUND.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_DOC_TEMPLATE                                       */
/*==============================================================*/
CREATE TABLE KD_DOC_TEMPLATE  (
   TEMP_ID_             VARCHAR2(64)                    NOT NULL,
   "TREE_ID_"           VARCHAR2(64),
   NAME_                VARCHAR2(80)                    NOT NULL,
   CONTENT_             CLOB,
   TYPE_                VARCHAR2(20),
   STATUS_              VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_KD_DOC_TEMPLATE PRIMARY KEY (TEMP_ID_)
);

COMMENT ON TABLE KD_DOC_TEMPLATE IS
'文档模板';

COMMENT ON COLUMN KD_DOC_TEMPLATE.TEMP_ID_ IS
'模板ID';

COMMENT ON COLUMN KD_DOC_TEMPLATE."TREE_ID_" IS
'模板分类ID';

COMMENT ON COLUMN KD_DOC_TEMPLATE.NAME_ IS
'模板名称';

COMMENT ON COLUMN KD_DOC_TEMPLATE.CONTENT_ IS
'模板内容';

COMMENT ON COLUMN KD_DOC_TEMPLATE.TYPE_ IS
'模板类型
词条模板
文档模板';

COMMENT ON COLUMN KD_DOC_TEMPLATE.STATUS_ IS
'模板状态';

COMMENT ON COLUMN KD_DOC_TEMPLATE.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_DOC_TEMPLATE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN KD_DOC_TEMPLATE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_DOC_TEMPLATE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_DOC_TEMPLATE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: KD_QUESTION                                           */
/*==============================================================*/
CREATE TABLE KD_QUESTION  (
   QUE_ID_              VARCHAR2(64)                    NOT NULL,
   "TREE_ID_"           VARCHAR2(64),
   SUBJECT_             VARCHAR2(80)                    NOT NULL,
   QUESTION_            CLOB,
   FILE_IDS_            VARCHAR2(512),
   TAGS_                VARCHAR2(128),
   REWARD_SCORE_        INTEGER                         NOT NULL,
   REPLY_TYPE_          VARCHAR2(80),
   REPLIER_ID_          VARCHAR2(64),
   STATUS_              VARCHAR2(20),
   REPLY_COUNTS_        INTEGER                         NOT NULL,
   VIEW_TIMES_          INTEGER,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_QUESTION PRIMARY KEY (QUE_ID_)
);

COMMENT ON TABLE KD_QUESTION IS
'文档知识收藏';

COMMENT ON COLUMN KD_QUESTION.QUE_ID_ IS
'问题ID';

COMMENT ON COLUMN KD_QUESTION."TREE_ID_" IS
'分类Id';

COMMENT ON COLUMN KD_QUESTION.SUBJECT_ IS
'问题内容';

COMMENT ON COLUMN KD_QUESTION.QUESTION_ IS
'详细问题';

COMMENT ON COLUMN KD_QUESTION.FILE_IDS_ IS
'附件';

COMMENT ON COLUMN KD_QUESTION.TAGS_ IS
'标签';

COMMENT ON COLUMN KD_QUESTION.REWARD_SCORE_ IS
'悬赏货币';

COMMENT ON COLUMN KD_QUESTION.REPLY_TYPE_ IS
'所有人
专家个人
领域专家';

COMMENT ON COLUMN KD_QUESTION.REPLIER_ID_ IS
'回复人ID';

COMMENT ON COLUMN KD_QUESTION.STATUS_ IS
'待解决=UNSOLVED
已解决=SOLVED';

COMMENT ON COLUMN KD_QUESTION.REPLY_COUNTS_ IS
'回复数';

COMMENT ON COLUMN KD_QUESTION.VIEW_TIMES_ IS
'浏览次数';

COMMENT ON COLUMN KD_QUESTION.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_QUESTION.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_QUESTION.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_QUESTION.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_QUESTION.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_QUES_ANSWER                                        */
/*==============================================================*/
CREATE TABLE KD_QUES_ANSWER  (
   ANSWER_ID_           VARCHAR2(64)                    NOT NULL,
   QUE_ID_              VARCHAR2(64)                    NOT NULL,
   REPLY_CONTENT_       CLOB                            NOT NULL,
   IS_BEST_             VARCHAR2(20),
   AUTHOR_ID_           VARCHAR2(64)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_QUES_ANSWER PRIMARY KEY (ANSWER_ID_)
);

COMMENT ON TABLE KD_QUES_ANSWER IS
'问题答案';

COMMENT ON COLUMN KD_QUES_ANSWER.QUE_ID_ IS
'问题ID';

COMMENT ON COLUMN KD_QUES_ANSWER.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_QUES_ANSWER.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_QUES_ANSWER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_QUES_ANSWER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_QUES_ANSWER.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_USER                                               */
/*==============================================================*/
CREATE TABLE KD_USER  (
   KUSER_ID             VARCHAR2(64)                    NOT NULL,
   POINT_               INTEGER                         NOT NULL,
   DOC_SCORE_           INTEGER,
   GRADE_               VARCHAR2(20),
   USER_TYPE_           VARCHAR2(20),
   FULLNAME_            VARCHAR2(32),
   SN_                  INTEGER,
   KN_SYS_ID_           VARCHAR2(64),
   REQ_SYS_ID_          VARCHAR2(64),
   SIGN_                VARCHAR2(80),
   PROFILE_             VARCHAR2(100),
   HEAD_ID_             VARCHAR2(64),
   SEX_                 VARCHAR2(64),
   OFFICE_PHONE_        VARCHAR2(20),
   MOBILE_              VARCHAR2(16),
   EMAIL_               VARCHAR2(80),
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_USER PRIMARY KEY (KUSER_ID)
);

COMMENT ON TABLE KD_USER IS
'知识用户信息';

COMMENT ON COLUMN KD_USER.KUSER_ID IS
'用户ID';

COMMENT ON COLUMN KD_USER.POINT_ IS
'积分';

COMMENT ON COLUMN KD_USER.USER_TYPE_ IS
'专家个人=PERSON
领域专家=DOMAIN

';

COMMENT ON COLUMN KD_USER.SN_ IS
'序号';

COMMENT ON COLUMN KD_USER.KN_SYS_ID_ IS
'知识领域';

COMMENT ON COLUMN KD_USER.REQ_SYS_ID_ IS
'爱问领域';

COMMENT ON COLUMN KD_USER.SIGN_ IS
'个性签名';

COMMENT ON COLUMN KD_USER.PROFILE_ IS
'个人简介';

COMMENT ON COLUMN KD_USER.HEAD_ID_ IS
'头像';

COMMENT ON COLUMN KD_USER.SEX_ IS
'性别';

COMMENT ON COLUMN KD_USER.OFFICE_PHONE_ IS
'办公电话';

COMMENT ON COLUMN KD_USER.MOBILE_ IS
'手机号码';

COMMENT ON COLUMN KD_USER.EMAIL_ IS
'电子邮箱';

COMMENT ON COLUMN KD_USER.USER_ID_ IS
'从属用户ID';

COMMENT ON COLUMN KD_USER.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_USER.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_USER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_USER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_USER.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: KD_USER_LEVEL                                         */
/*==============================================================*/
CREATE TABLE KD_USER_LEVEL  (
   CONF_ID_             VARCHAR2(32)                    NOT NULL,
   START_VAL_           INTEGER                         NOT NULL,
   END_VAL_             INTEGER                         NOT NULL,
   LEVEL_NAME_          VARCHAR2(100)                   NOT NULL,
   HEADER_ICON_         VARCHAR2(128),
   MEMO_                VARCHAR2(500),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_KD_USER_LEVEL PRIMARY KEY (CONF_ID_)
);

COMMENT ON TABLE KD_USER_LEVEL IS
'用户知识等级配置';

COMMENT ON COLUMN KD_USER_LEVEL.CONF_ID_ IS
'配置ID';

COMMENT ON COLUMN KD_USER_LEVEL.START_VAL_ IS
'起始值';

COMMENT ON COLUMN KD_USER_LEVEL.END_VAL_ IS
'结束值';

COMMENT ON COLUMN KD_USER_LEVEL.LEVEL_NAME_ IS
'等级名称';

COMMENT ON COLUMN KD_USER_LEVEL.HEADER_ICON_ IS
'头像Icon';

COMMENT ON COLUMN KD_USER_LEVEL.MEMO_ IS
'备注';

COMMENT ON COLUMN KD_USER_LEVEL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN KD_USER_LEVEL.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN KD_USER_LEVEL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN KD_USER_LEVEL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN KD_USER_LEVEL.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: MI_DB_ID                                              */
/*==============================================================*/
CREATE TABLE MI_DB_ID  (
   ID_                  INTEGER                         NOT NULL,
   START_               NUMBER(20,0)                    NOT NULL,
   MAX_                 NUMBER(20,0)                    NOT NULL,
   MAC_NAME_            VARCHAR2(256)                   NOT NULL,
   CONSTRAINT PK_MI_DB_ID PRIMARY KEY (ID_)
);

COMMENT ON TABLE MI_DB_ID IS
'系统表主键增长表';

COMMENT ON COLUMN MI_DB_ID.ID_ IS
'机器ID,
默认为1';

COMMENT ON COLUMN MI_DB_ID.START_ IS
'开始值';

COMMENT ON COLUMN MI_DB_ID.MAX_ IS
'增长值';

COMMENT ON COLUMN MI_DB_ID.MAC_NAME_ IS
'服务器的机器名称，由程序启动时自动读取并且加入数据库';

/*==============================================================*/
/* Table: MOBILE_TOKEN                                          */
/*==============================================================*/
CREATE TABLE MOBILE_TOKEN  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   ACCOUNT_             VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64),
   TOKEN                VARCHAR2(64),
   STATUS_              SMALLINT,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   EXPIRED_TIME_        TIMESTAMP,
   CONSTRAINT PK_MOBILE_TOKEN PRIMARY KEY (ID_)
);

COMMENT ON TABLE MOBILE_TOKEN IS
'手机端令牌';

COMMENT ON COLUMN MOBILE_TOKEN.ID_ IS
'主键';

COMMENT ON COLUMN MOBILE_TOKEN.ACCOUNT_ IS
'ACCOUNT';

COMMENT ON COLUMN MOBILE_TOKEN.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN MOBILE_TOKEN.TOKEN IS
'令牌';

COMMENT ON COLUMN MOBILE_TOKEN.STATUS_ IS
'状态';

COMMENT ON COLUMN MOBILE_TOKEN.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN MOBILE_TOKEN.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN MOBILE_TOKEN.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN MOBILE_TOKEN.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN MOBILE_TOKEN.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN MOBILE_TOKEN.EXPIRED_TIME_ IS
'失效时间';

/*==============================================================*/
/* Table: OA_ADDR_BOOK                                          */
/*==============================================================*/
CREATE TABLE OA_ADDR_BOOK  (
   ADDR_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(50)                    NOT NULL,
   COMPANY_             VARCHAR2(120),
   DEP_                 VARCHAR2(50),
   POS_                 VARCHAR2(50),
   MAIL_                VARCHAR2(255),
   COUNTRY_             VARCHAR2(32),
   SATE_                VARCHAR2(32),
   CITY_                VARCHAR2(32),
   STREET_              VARCHAR2(80),
   ZIP_                 VARCHAR2(20),
   BIRTHDAY_            TIMESTAMP,
   MOBILE_              VARCHAR2(16),
   PHONE_               VARCHAR2(16),
   WEIXIN_              VARCHAR2(80),
   QQ_                  VARCHAR2(32),
   PHOTO_ID_            VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OA_ADDR_BOOK PRIMARY KEY (ADDR_ID_)
);

COMMENT ON TABLE OA_ADDR_BOOK IS
'通讯录联系人';

COMMENT ON COLUMN OA_ADDR_BOOK.ADDR_ID_ IS
'联系人ID';

COMMENT ON COLUMN OA_ADDR_BOOK.NAME_ IS
'姓名';

COMMENT ON COLUMN OA_ADDR_BOOK.COMPANY_ IS
'公司';

COMMENT ON COLUMN OA_ADDR_BOOK.DEP_ IS
'部门';

COMMENT ON COLUMN OA_ADDR_BOOK.POS_ IS
'职务';

COMMENT ON COLUMN OA_ADDR_BOOK.MAIL_ IS
'主邮箱';

COMMENT ON COLUMN OA_ADDR_BOOK.COUNTRY_ IS
'国家';

COMMENT ON COLUMN OA_ADDR_BOOK.SATE_ IS
'省份';

COMMENT ON COLUMN OA_ADDR_BOOK.CITY_ IS
'城市';

COMMENT ON COLUMN OA_ADDR_BOOK.STREET_ IS
'街道';

COMMENT ON COLUMN OA_ADDR_BOOK.ZIP_ IS
'邮编';

COMMENT ON COLUMN OA_ADDR_BOOK.BIRTHDAY_ IS
'生日';

COMMENT ON COLUMN OA_ADDR_BOOK.MOBILE_ IS
'主手机';

COMMENT ON COLUMN OA_ADDR_BOOK.PHONE_ IS
'主电话';

COMMENT ON COLUMN OA_ADDR_BOOK.WEIXIN_ IS
'主微信号';

COMMENT ON COLUMN OA_ADDR_BOOK.QQ_ IS
'QQ';

COMMENT ON COLUMN OA_ADDR_BOOK.PHOTO_ID_ IS
'头像文件ID';

COMMENT ON COLUMN OA_ADDR_BOOK.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OA_ADDR_BOOK.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_ADDR_BOOK.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_ADDR_BOOK.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_ADDR_BOOK.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OA_ADDR_CONT                                          */
/*==============================================================*/
CREATE TABLE OA_ADDR_CONT  (
   CONT_ID_             VARCHAR2(64)                    NOT NULL,
   ADDR_ID_             VARCHAR2(64),
   TYPE_                VARCHAR2(50)                    NOT NULL,
   CONTACT_             VARCHAR2(255),
   EXT1_                VARCHAR2(100),
   EXT2_                VARCHAR2(100),
   EXT3_                VARCHAR2(100),
   EXT4_                VARCHAR2(100),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OA_ADDR_CONT PRIMARY KEY (CONT_ID_)
);

COMMENT ON TABLE OA_ADDR_CONT IS
'通讯录联系信息';

COMMENT ON COLUMN OA_ADDR_CONT.CONT_ID_ IS
'联系信息ID';

COMMENT ON COLUMN OA_ADDR_CONT.ADDR_ID_ IS
'联系人ID';

COMMENT ON COLUMN OA_ADDR_CONT.TYPE_ IS
'类型
手机号=MOBILE
家庭地址=HOME_ADDRESS
工作地址=WORK_ADDRESS
QQ=QQ
微信=WEI_XIN
GoogleTalk=GOOGLE-TALK
工作=WORK_INFO
备注=MEMO';

COMMENT ON COLUMN OA_ADDR_CONT.CONTACT_ IS
'联系主信息';

COMMENT ON COLUMN OA_ADDR_CONT.EXT1_ IS
'联系扩展字段1';

COMMENT ON COLUMN OA_ADDR_CONT.EXT2_ IS
'联系扩展字段2';

COMMENT ON COLUMN OA_ADDR_CONT.EXT3_ IS
'联系扩展字段3';

COMMENT ON COLUMN OA_ADDR_CONT.EXT4_ IS
'联系扩展字段4';

COMMENT ON COLUMN OA_ADDR_CONT.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OA_ADDR_CONT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_ADDR_CONT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_ADDR_CONT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_ADDR_CONT.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OA_ADDR_GPB                                           */
/*==============================================================*/
CREATE TABLE OA_ADDR_GPB  (
   GROUP_ID_            VARCHAR2(64)                    NOT NULL,
   ADDR_ID_             VARCHAR2(64)                    NOT NULL,
   CONSTRAINT PK_OA_ADDR_GPB PRIMARY KEY (GROUP_ID_, ADDR_ID_)
);

COMMENT ON TABLE OA_ADDR_GPB IS
'通讯录分组下的联系人';

COMMENT ON COLUMN OA_ADDR_GPB.GROUP_ID_ IS
'分组ID';

COMMENT ON COLUMN OA_ADDR_GPB.ADDR_ID_ IS
'联系人ID';

/*==============================================================*/
/* Table: OA_ADDR_GRP                                           */
/*==============================================================*/
CREATE TABLE OA_ADDR_GRP  (
   GROUP_ID_            VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(50)                    NOT NULL,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OA_ADDR_GRP PRIMARY KEY (GROUP_ID_)
);

COMMENT ON TABLE OA_ADDR_GRP IS
'通讯录分组';

COMMENT ON COLUMN OA_ADDR_GRP.GROUP_ID_ IS
'分组ID';

COMMENT ON COLUMN OA_ADDR_GRP.NAME_ IS
'名字';

COMMENT ON COLUMN OA_ADDR_GRP.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OA_ADDR_GRP.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_ADDR_GRP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_ADDR_GRP.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_ADDR_GRP.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OA_ASSETS                                             */
/*==============================================================*/
CREATE TABLE OA_ASSETS  (
   ASS_ID_              VARCHAR2(64)                    NOT NULL,
   PROD_DEF_ID_         VARCHAR2(64),
   CODE_                VARCHAR2(64),
   NAME_                VARCHAR2(64),
   JSON_                CLOB,
   DESC_                VARCHAR2(256),
   STATUS_              VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_ASSETS PRIMARY KEY (ASS_ID_)
);

COMMENT ON TABLE OA_ASSETS IS
'资产信息';

COMMENT ON COLUMN OA_ASSETS.ASS_ID_ IS
'资产ID';

COMMENT ON COLUMN OA_ASSETS.PROD_DEF_ID_ IS
'参数定义ID';

COMMENT ON COLUMN OA_ASSETS.CODE_ IS
'资产编号';

COMMENT ON COLUMN OA_ASSETS.NAME_ IS
'资产名称';

COMMENT ON COLUMN OA_ASSETS.JSON_ IS
'参数JSON';

COMMENT ON COLUMN OA_ASSETS.DESC_ IS
'描述';

COMMENT ON COLUMN OA_ASSETS.STATUS_ IS
'状态';

COMMENT ON COLUMN OA_ASSETS.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_ASSETS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_ASSETS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_ASSETS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_ASSETS.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_ASSETS_BID                                         */
/*==============================================================*/
CREATE TABLE OA_ASSETS_BID  (
   BID_ID_              VARCHAR2(64)                    NOT NULL,
   ASS_ID_              VARCHAR2(64),
   PARA_ID_             VARCHAR2(64),
   START_               TIMESTAMP                            NOT NULL,
   END_                 TIMESTAMP                            NOT NULL,
   MEMO_                CLOB,
   USE_MANS_            VARCHAR2(20),
   STATUS_              VARCHAR2(20),
   BPM_INST_ID_         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_ASSETS_BID PRIMARY KEY (BID_ID_)
);

COMMENT ON TABLE OA_ASSETS_BID IS
'【资产申请】';

COMMENT ON COLUMN OA_ASSETS_BID.BID_ID_ IS
'申请ID';

COMMENT ON COLUMN OA_ASSETS_BID.ASS_ID_ IS
'资产ID';

COMMENT ON COLUMN OA_ASSETS_BID.PARA_ID_ IS
'参数ID(不做关联)';

COMMENT ON COLUMN OA_ASSETS_BID.START_ IS
'开始时间';

COMMENT ON COLUMN OA_ASSETS_BID.END_ IS
'结束时间';

COMMENT ON COLUMN OA_ASSETS_BID.MEMO_ IS
'申请说明';

COMMENT ON COLUMN OA_ASSETS_BID.USE_MANS_ IS
'申请人员';

COMMENT ON COLUMN OA_ASSETS_BID.STATUS_ IS
'状态';

COMMENT ON COLUMN OA_ASSETS_BID.BPM_INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN OA_ASSETS_BID.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_ASSETS_BID.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_ASSETS_BID.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_ASSETS_BID.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_ASSETS_BID.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_ASS_PARAMETER                                      */
/*==============================================================*/
CREATE TABLE OA_ASS_PARAMETER  (
   PARA_ID_             VARCHAR2(64)                    NOT NULL,
   VALUE_ID_            VARCHAR2(64),
   KEY_ID_              VARCHAR2(64),
   ASS_ID_              VARCHAR2(64),
   CUSTOM_VALUE_NAME_   VARCHAR2(255),
   CUSTOM_KEY_NAME_     VARCHAR2(255),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_ASS_PARAMETER PRIMARY KEY (PARA_ID_)
);

COMMENT ON TABLE OA_ASS_PARAMETER IS
'资产参数';

COMMENT ON COLUMN OA_ASS_PARAMETER.PARA_ID_ IS
'参数ID';

COMMENT ON COLUMN OA_ASS_PARAMETER.VALUE_ID_ IS
'参数VALUE主键';

COMMENT ON COLUMN OA_ASS_PARAMETER.KEY_ID_ IS
'参数KEY主键';

COMMENT ON COLUMN OA_ASS_PARAMETER.ASS_ID_ IS
'资产ID';

COMMENT ON COLUMN OA_ASS_PARAMETER.CUSTOM_VALUE_NAME_ IS
'自定义VALUE名';

COMMENT ON COLUMN OA_ASS_PARAMETER.CUSTOM_KEY_NAME_ IS
'自定义KEY名';

COMMENT ON COLUMN OA_ASS_PARAMETER.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_ASS_PARAMETER.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_ASS_PARAMETER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_ASS_PARAMETER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_ASS_PARAMETER.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_CAR                                                */
/*==============================================================*/
CREATE TABLE OA_CAR  (
   CAR_ID_              VARCHAR2(64)                    NOT NULL,
   SYS_DIC_ID_          VARCHAR2(64),
   NAME_                VARCHAR2(60)                    NOT NULL,
   CAR_NO_              VARCHAR2(20)                    NOT NULL,
   TRAVEL_MILES_        INTEGER,
   ENGINE_NUM_          VARCHAR2(20),
   FRAME_NO_            VARCHAR2(20),
   BRAND_               VARCHAR2(64),
   MODEL_               VARCHAR2(64),
   WEIGHT_              INTEGER,
   SEATS_               INTEGER,
   BUY_DATE_            TIMESTAMP,
   PRICE_               NUMBER(18,4),
   ANNUAL_INSP_         CLOB,
   INSURANCE_           CLOB,
   MAINTENS_            CLOB,
   MEMO_                CLOB,
   PHOTO_IDS_           VARCHAR2(512),
   STATUS_              VARCHAR2(20)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_CAR PRIMARY KEY (CAR_ID_)
);

COMMENT ON TABLE OA_CAR IS
'车辆信息';

COMMENT ON COLUMN OA_CAR.CAR_ID_ IS
'车辆ID';

COMMENT ON COLUMN OA_CAR.NAME_ IS
'车辆名称';

COMMENT ON COLUMN OA_CAR.CAR_NO_ IS
'车牌号';

COMMENT ON COLUMN OA_CAR.TRAVEL_MILES_ IS
'行驶里程';

COMMENT ON COLUMN OA_CAR.ENGINE_NUM_ IS
'发动机号';

COMMENT ON COLUMN OA_CAR.FRAME_NO_ IS
'车辆识别代号';

COMMENT ON COLUMN OA_CAR.BRAND_ IS
'品牌';

COMMENT ON COLUMN OA_CAR.MODEL_ IS
'型号';

COMMENT ON COLUMN OA_CAR.WEIGHT_ IS
'车辆载重';

COMMENT ON COLUMN OA_CAR.SEATS_ IS
'车辆座位';

COMMENT ON COLUMN OA_CAR.BUY_DATE_ IS
'购买日期';

COMMENT ON COLUMN OA_CAR.PRICE_ IS
'购买价格';

COMMENT ON COLUMN OA_CAR.ANNUAL_INSP_ IS
'年检情况';

COMMENT ON COLUMN OA_CAR.INSURANCE_ IS
'保险情况';

COMMENT ON COLUMN OA_CAR.MAINTENS_ IS
'保养维修情况';

COMMENT ON COLUMN OA_CAR.MEMO_ IS
'备注信息';

COMMENT ON COLUMN OA_CAR.PHOTO_IDS_ IS
'车辆照片';

COMMENT ON COLUMN OA_CAR.STATUS_ IS
'车辆状态
IN_USED=在使用
IN_FREE=空闲
SCRAP=报废';

COMMENT ON COLUMN OA_CAR.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_CAR.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_CAR.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_CAR.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_CAR.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_CAR_APP                                            */
/*==============================================================*/
CREATE TABLE OA_CAR_APP  (
   APP_ID_              VARCHAR2(64)                    NOT NULL,
   CAR_CAT_             VARCHAR2(50)                    NOT NULL,
   CAR_ID_              VARCHAR2(64)                    NOT NULL,
   CAR_NAME_            VARCHAR2(50)                    NOT NULL,
   START_TIME_          TIMESTAMP                            NOT NULL,
   END_TIME_            TIMESTAMP                            NOT NULL,
   DRIVER_              VARCHAR2(20),
   CATEGORY_            VARCHAR2(64),
   DEST_LOC_            VARCHAR2(100),
   TRAV_MILES_          INTEGER,
   USE_MANS_            VARCHAR2(20),
   MEMO_                CLOB,
   STATUS_              VARCHAR2(20),
   BPM_INST_            VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_CAR_APP PRIMARY KEY (APP_ID_)
);

COMMENT ON TABLE OA_CAR_APP IS
'车辆申请';

COMMENT ON COLUMN OA_CAR_APP.CAR_CAT_ IS
'汽车类别';

COMMENT ON COLUMN OA_CAR_APP.CAR_ID_ IS
'车辆ID';

COMMENT ON COLUMN OA_CAR_APP.CAR_NAME_ IS
'车辆名称';

COMMENT ON COLUMN OA_CAR_APP.START_TIME_ IS
'起始时间';

COMMENT ON COLUMN OA_CAR_APP.END_TIME_ IS
'终止时间';

COMMENT ON COLUMN OA_CAR_APP.DRIVER_ IS
'驾驶员';

COMMENT ON COLUMN OA_CAR_APP.CATEGORY_ IS
'行程类别';

COMMENT ON COLUMN OA_CAR_APP.DEST_LOC_ IS
'目的地点';

COMMENT ON COLUMN OA_CAR_APP.TRAV_MILES_ IS
'行驶里程';

COMMENT ON COLUMN OA_CAR_APP.USE_MANS_ IS
'使用人员';

COMMENT ON COLUMN OA_CAR_APP.MEMO_ IS
'使用说明';

COMMENT ON COLUMN OA_CAR_APP.STATUS_ IS
'申请状态';

COMMENT ON COLUMN OA_CAR_APP.BPM_INST_ IS
'流程实例ID';

COMMENT ON COLUMN OA_CAR_APP.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_CAR_APP.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_CAR_APP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_CAR_APP.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_CAR_APP.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_COM_BOOK                                           */
/*==============================================================*/
CREATE TABLE OA_COM_BOOK  (
   COM_ID_              VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64)                    NOT NULL,
   FIRST_LETTER_        VARCHAR2(16),
   DEPNAME_             VARCHAR2(64),
   MOBILE_              VARCHAR2(64),
   MOBILE2_             VARCHAR2(64),
   PHONE_               VARCHAR2(64),
   EMAIL_               VARCHAR2(64),
   QQ_                  VARCHAR2(32),
   IS_EMPLOYEE_         VARCHAR2(16)                    NOT NULL,
   REMARK_              VARCHAR2(500),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_COM_BOOK PRIMARY KEY (COM_ID_)
);

COMMENT ON COLUMN OA_COM_BOOK.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_COM_BOOK.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_COM_BOOK.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_COM_BOOK.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_COM_BOOK.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_COM_RIGHT                                          */
/*==============================================================*/
CREATE TABLE OA_COM_RIGHT  (
   RIGHT_ID_            VARCHAR2(64)                    NOT NULL,
   COMBOOK_ID_          VARCHAR2(64)                    NOT NULL,
   IDENTITY_TYPE_       VARCHAR2(20)                    NOT NULL,
   IDENTITY_ID_         VARCHAR2(64)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_COM_RIGHT PRIMARY KEY (RIGHT_ID_)
);

COMMENT ON COLUMN OA_COM_RIGHT.RIGHT_ID_ IS
'权限ID';

COMMENT ON COLUMN OA_COM_RIGHT.COMBOOK_ID_ IS
'文档ID';

COMMENT ON COLUMN OA_COM_RIGHT.IDENTITY_TYPE_ IS
'授权类型
USER=用户
GROUP=用户组';

COMMENT ON COLUMN OA_COM_RIGHT.IDENTITY_ID_ IS
'用户或组ID';

COMMENT ON COLUMN OA_COM_RIGHT.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_COM_RIGHT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_COM_RIGHT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_COM_RIGHT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_COM_RIGHT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_MEETING                                            */
/*==============================================================*/
CREATE TABLE OA_MEETING  (
   MEET_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(255)                   NOT NULL,
   DESCP_               CLOB,
   START_               TIMESTAMP                            NOT NULL,
   END_                 TIMESTAMP                            NOT NULL,
   LOCATION_            VARCHAR2(255),
   ROOM_ID_             VARCHAR2(64),
   BUDGET_              NUMBER(18,4),
   HOST_UID_            VARCHAR2(64),
   RECORD_UID_          VARCHAR2(64),
   IMP_DEGREE_          VARCHAR2(20),
   STATUS_              VARCHAR2(20),
   SUMMARY_             CLOB,
   BPM_INST_ID_         VARCHAR2(64),
   FILE_IDS_            VARCHAR2(512),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_MEETING PRIMARY KEY (MEET_ID_)
);

COMMENT ON TABLE OA_MEETING IS
'会议申请';

COMMENT ON COLUMN OA_MEETING.IMP_DEGREE_ IS
'重要程度';

COMMENT ON COLUMN OA_MEETING.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_MEETING.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_MEETING.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_MEETING.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_MEETING.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_MEET_ATT                                           */
/*==============================================================*/
CREATE TABLE OA_MEET_ATT  (
   ATT_ID_              VARCHAR2(64)                    NOT NULL,
   MEET_ID_             VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   FULLNAME_            VARCHAR2(20),
   SUMMARY_             CLOB,
   STATUS_              VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_MEET_ATT PRIMARY KEY (ATT_ID_)
);

COMMENT ON TABLE OA_MEET_ATT IS
'会议参与人';

COMMENT ON COLUMN OA_MEET_ATT.MEET_ID_ IS
'会议ID';

COMMENT ON COLUMN OA_MEET_ATT.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN OA_MEET_ATT.FULLNAME_ IS
'姓名';

COMMENT ON COLUMN OA_MEET_ATT.SUMMARY_ IS
'总结';

COMMENT ON COLUMN OA_MEET_ATT.STATUS_ IS
'总结状态
INIT
SUBMITED';

COMMENT ON COLUMN OA_MEET_ATT.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_MEET_ATT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_MEET_ATT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_MEET_ATT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_MEET_ATT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_MEET_ROOM                                          */
/*==============================================================*/
CREATE TABLE OA_MEET_ROOM  (
   ROOM_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(100)                   NOT NULL,
   LOCATION_            VARCHAR2(255),
   DESCP_               VARCHAR2(512),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_MEET_ROOM PRIMARY KEY (ROOM_ID_)
);

COMMENT ON TABLE OA_MEET_ROOM IS
'会议室';

COMMENT ON COLUMN OA_MEET_ROOM.NAME_ IS
'会议室名称';

COMMENT ON COLUMN OA_MEET_ROOM.LOCATION_ IS
'地址';

COMMENT ON COLUMN OA_MEET_ROOM.DESCP_ IS
'描述';

COMMENT ON COLUMN OA_MEET_ROOM.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN OA_MEET_ROOM.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_MEET_ROOM.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_MEET_ROOM.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_MEET_ROOM.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_PLAN_TASK                                          */
/*==============================================================*/
CREATE TABLE OA_PLAN_TASK  (
   PLAN_ID_             VARCHAR2(64)                    NOT NULL,
   PROJECT_ID_          VARCHAR2(64),
   REQ_ID_              VARCHAR2(64),
   VERSION_             VARCHAR2(50),
   SUBJECT_             VARCHAR2(128)                   NOT NULL,
   CONTENT_             CLOB,
   PSTART_TIME_         TIMESTAMP                            NOT NULL,
   PEND_TIME_           TIMESTAMP,
   START_TIME_          TIMESTAMP,
   END_TIME_            TIMESTAMP,
   STATUS_              VARCHAR2(20),
   LAST_                INTEGER,
   ASSIGN_ID_           VARCHAR2(64),
   OWNER_ID_            VARCHAR2(64),
   EXE_ID_              VARCHAR2(64),
   BPM_DEF_ID_          VARCHAR2(64),
   BPM_INST_ID_         VARCHAR2(64),
   BPM_TASK_ID_         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_PLAN_TASK PRIMARY KEY (PLAN_ID_)
);

COMMENT ON TABLE OA_PLAN_TASK IS
'工作计划任务';

COMMENT ON COLUMN OA_PLAN_TASK.PROJECT_ID_ IS
'项目或产品ID';

COMMENT ON COLUMN OA_PLAN_TASK.REQ_ID_ IS
'需求ID';

COMMENT ON COLUMN OA_PLAN_TASK.VERSION_ IS
'版本号';

COMMENT ON COLUMN OA_PLAN_TASK.SUBJECT_ IS
'计划标题';

COMMENT ON COLUMN OA_PLAN_TASK.CONTENT_ IS
'计划内容';

COMMENT ON COLUMN OA_PLAN_TASK.PSTART_TIME_ IS
'计划开始时间';

COMMENT ON COLUMN OA_PLAN_TASK.PEND_TIME_ IS
'计划结束时间';

COMMENT ON COLUMN OA_PLAN_TASK.START_TIME_ IS
'实际开始时间';

COMMENT ON COLUMN OA_PLAN_TASK.END_TIME_ IS
'实际结束时间';

COMMENT ON COLUMN OA_PLAN_TASK.STATUS_ IS
'状态
未开始
执行中
延迟
暂停
中止
完成';

COMMENT ON COLUMN OA_PLAN_TASK.LAST_ IS
'耗时(分）';

COMMENT ON COLUMN OA_PLAN_TASK.ASSIGN_ID_ IS
'分配人';

COMMENT ON COLUMN OA_PLAN_TASK.OWNER_ID_ IS
'所属人';

COMMENT ON COLUMN OA_PLAN_TASK.EXE_ID_ IS
'执行人';

COMMENT ON COLUMN OA_PLAN_TASK.BPM_DEF_ID_ IS
'流程定义ID';

COMMENT ON COLUMN OA_PLAN_TASK.BPM_INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN OA_PLAN_TASK.BPM_TASK_ID_ IS
'流程任务ID';

COMMENT ON COLUMN OA_PLAN_TASK.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_PLAN_TASK.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PLAN_TASK.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PLAN_TASK.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PLAN_TASK.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_PRODUCT_DEF                                        */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF  (
   PROD_DEF_ID_         VARCHAR2(64)                    NOT NULL,
   TREE_ID_             VARCHAR2(64),
   NAME_                VARCHAR2(64),
   DESC_                VARCHAR2(256),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OA_PRODUCT_DEF PRIMARY KEY (PROD_DEF_ID_)
);

COMMENT ON TABLE OA_PRODUCT_DEF IS
'产品分类定义';

COMMENT ON COLUMN OA_PRODUCT_DEF.PROD_DEF_ID_ IS
'参数定义ID';

COMMENT ON COLUMN OA_PRODUCT_DEF.TREE_ID_ IS
'分类Id';

COMMENT ON COLUMN OA_PRODUCT_DEF.NAME_ IS
'名称';

COMMENT ON COLUMN OA_PRODUCT_DEF.DESC_ IS
'描述';

COMMENT ON COLUMN OA_PRODUCT_DEF.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PRODUCT_DEF.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OA_PRODUCT_DEF.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OA_PRODUCT_DEF_PARA                                   */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF_PARA  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   KEY_ID_              VARCHAR2(64),
   VALUE_ID_            VARCHAR2(64),
   PROD_DEF_ID_         VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OA_PRODUCT_DEF_PARA PRIMARY KEY (ID_)
);

COMMENT ON TABLE OA_PRODUCT_DEF_PARA IS
'产品定义参数表';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.ID_ IS
'主键';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.KEY_ID_ IS
'参数KEY主键';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.VALUE_ID_ IS
'参数VALUE主键';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.PROD_DEF_ID_ IS
'参数定义ID';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OA_PRODUCT_DEF_PARA_KEY                               */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF_PARA_KEY  (
   KEY_ID_              VARCHAR2(64)                    NOT NULL,
   TREE_ID_             VARCHAR2(64),
   NAME_                VARCHAR2(64),
   CONTROL_TYPE_        VARCHAR2(64),
   DATA_TYPE_           VARCHAR2(20),
   IS_UNIQUE_           SMALLINT,
   DESC_                VARCHAR2(256),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OA_PRODUCT_DEF_PARA_KEY PRIMARY KEY (KEY_ID_)
);

COMMENT ON TABLE OA_PRODUCT_DEF_PARA_KEY IS
'产品定义参数KEY(产品类型)';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.KEY_ID_ IS
'参数KEY主键';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.TREE_ID_ IS
'分类Id';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.NAME_ IS
'名称';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.CONTROL_TYPE_ IS
'类型(radio-list checkbox-list textbox number date textarea)';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.DATA_TYPE_ IS
'数据类型(string number date 大文本)';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.IS_UNIQUE_ IS
'是否唯一属性';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.DESC_ IS
'描述';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_KEY.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OA_PRODUCT_DEF_PARA_VALUE                             */
/*==============================================================*/
CREATE TABLE OA_PRODUCT_DEF_PARA_VALUE  (
   VALUE_ID_            VARCHAR2(64)                    NOT NULL,
   KEY_ID_              VARCHAR2(64),
   TREE_ID_             VARCHAR2(64),
   NAME_                VARCHAR2(64),
   NUMBER_              BINARY_DOUBLE,
   STRING_              VARCHAR2(20),
   TEXT_                VARCHAR2(4000),
   DATETIME__           TIMESTAMP,
   DESC_                VARCHAR2(256),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OA_PRODUCT_DEF_PARA_VALUE PRIMARY KEY (VALUE_ID_)
);

COMMENT ON TABLE OA_PRODUCT_DEF_PARA_VALUE IS
'产品定义参数VALUE(产品属性)';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.VALUE_ID_ IS
'参数VALUE主键';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.KEY_ID_ IS
'参数KEY主键';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.TREE_ID_ IS
'分类Id';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.NAME_ IS
'名称';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.NUMBER_ IS
'数字类型';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.STRING_ IS
'字符串类型';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.TEXT_ IS
'文本类型';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.DATETIME__ IS
'时间类型';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.DESC_ IS
'描述';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OA_PRODUCT_DEF_PARA_VALUE.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OA_PROJECT                                            */
/*==============================================================*/
CREATE TABLE OA_PROJECT  (
   PROJECT_ID_          VARCHAR2(64)                    NOT NULL,
   "TREE_ID_"           VARCHAR2(64),
   PRO_NO_              VARCHAR2(50)                    NOT NULL,
   TAG_                 VARCHAR2(50),
   NAME_                VARCHAR2(100)                   NOT NULL,
   DESCP_               CLOB,
   REPOR_ID_            VARCHAR2(64)                    NOT NULL,
   COSTS_               NUMBER(16,4),
   START_TIME_          TIMESTAMP,
   END_TIME_            TIMESTAMP,
   STATUS_              VARCHAR2(20),
   VERSION_             VARCHAR2(50),
   TYPE_                VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_PROJECT PRIMARY KEY (PROJECT_ID_)
);

COMMENT ON TABLE OA_PROJECT IS
'项目或产品';

COMMENT ON COLUMN OA_PROJECT."TREE_ID_" IS
'分类Id';

COMMENT ON COLUMN OA_PROJECT.PRO_NO_ IS
'编号';

COMMENT ON COLUMN OA_PROJECT.TAG_ IS
'标签名称';

COMMENT ON COLUMN OA_PROJECT.NAME_ IS
'名称';

COMMENT ON COLUMN OA_PROJECT.DESCP_ IS
'描述';

COMMENT ON COLUMN OA_PROJECT.REPOR_ID_ IS
'负责人';

COMMENT ON COLUMN OA_PROJECT.COSTS_ IS
'预计费用';

COMMENT ON COLUMN OA_PROJECT.START_TIME_ IS
'启动时间';

COMMENT ON COLUMN OA_PROJECT.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN OA_PROJECT.STATUS_ IS
'状态
未开始=UNSTART
暂停中=SUSPEND
已延迟=DELAYED
已取消=CANCELED
进行中=UNDERWAY
已完成=FINISHED';

COMMENT ON COLUMN OA_PROJECT.VERSION_ IS
'当前版本';

COMMENT ON COLUMN OA_PROJECT.TYPE_ IS
'类型
PROJECT=项目
PRODUCT=产品';

COMMENT ON COLUMN OA_PROJECT.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_PROJECT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PROJECT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PROJECT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PROJECT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_PRO_ATTEND                                         */
/*==============================================================*/
CREATE TABLE OA_PRO_ATTEND  (
   ATT_ID_              VARCHAR2(64)                    NOT NULL,
   PROJECT_ID_          VARCHAR2(64),
   USER_ID_             VARCHAR2(64),
   GROUP_ID_            VARCHAR2(64),
   PART_TYPE_           VARCHAR2(20)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_PRO_ATTEND PRIMARY KEY (ATT_ID_)
);

COMMENT ON TABLE OA_PRO_ATTEND IS
'项目或产品参与人、负责人、关注人';

COMMENT ON COLUMN OA_PRO_ATTEND.USER_ID_ IS
'参与人ID';

COMMENT ON COLUMN OA_PRO_ATTEND.GROUP_ID_ IS
'参与组ID';

COMMENT ON COLUMN OA_PRO_ATTEND.PART_TYPE_ IS
'参与类型
Participate

      JOIN=参与
      RESPONSE=负责
      APPROVE=审批
      PAY_ATT=关注';

COMMENT ON COLUMN OA_PRO_ATTEND.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_PRO_ATTEND.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PRO_ATTEND.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PRO_ATTEND.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PRO_ATTEND.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_PRO_VERS                                           */
/*==============================================================*/
CREATE TABLE OA_PRO_VERS  (
   VERSION_ID_          VARCHAR2(64)                    NOT NULL,
   PROJECT_ID_          VARCHAR2(64),
   START_TIME_          TIMESTAMP,
   END_TIME_            TIMESTAMP,
   STATUS_              VARCHAR2(20),
   VERSION_             VARCHAR2(50)                    NOT NULL,
   DESCP_               CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_PRO_VERS PRIMARY KEY (VERSION_ID_)
);

COMMENT ON TABLE OA_PRO_VERS IS
'项目或产品版本';

COMMENT ON COLUMN OA_PRO_VERS.PROJECT_ID_ IS
'项目或产品ID';

COMMENT ON COLUMN OA_PRO_VERS.START_TIME_ IS
'开始时间';

COMMENT ON COLUMN OA_PRO_VERS.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN OA_PRO_VERS.STATUS_ IS
'状态
DRAFTED=草稿
DEPLOYED=发布
RUNNING=进行中
FINISHED=完成
';

COMMENT ON COLUMN OA_PRO_VERS.VERSION_ IS
'版本号';

COMMENT ON COLUMN OA_PRO_VERS.DESCP_ IS
'描述';

COMMENT ON COLUMN OA_PRO_VERS.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_PRO_VERS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_PRO_VERS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_PRO_VERS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_PRO_VERS.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_REQ_MGR                                            */
/*==============================================================*/
CREATE TABLE OA_REQ_MGR  (
   REQ_ID_              VARCHAR2(64)                    NOT NULL,
   PROJECT_ID_          VARCHAR2(64),
   REQ_CODE_            VARCHAR2(50)                    NOT NULL,
   SUBJECT_             VARCHAR2(128)                   NOT NULL,
   PATH_                VARCHAR2(512),
   DESCP_               CLOB,
   PARENT_ID_           VARCHAR2(64),
   STATUS_              VARCHAR2(50),
   LEVEL_               INTEGER,
   CHECKER_ID_          VARCHAR2(64),
   REP_ID_              VARCHAR2(64),
   EXE_ID_              VARCHAR2(64),
   VERSION_             VARCHAR2(20)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_REQ_MGR PRIMARY KEY (REQ_ID_)
);

COMMENT ON TABLE OA_REQ_MGR IS
'产品或项目需求';

COMMENT ON COLUMN OA_REQ_MGR.REQ_CODE_ IS
'需求编码';

COMMENT ON COLUMN OA_REQ_MGR.SUBJECT_ IS
'标题';

COMMENT ON COLUMN OA_REQ_MGR.DESCP_ IS
'描述';

COMMENT ON COLUMN OA_REQ_MGR.PARENT_ID_ IS
'父需求ID';

COMMENT ON COLUMN OA_REQ_MGR.STATUS_ IS
'状态';

COMMENT ON COLUMN OA_REQ_MGR.LEVEL_ IS
'层次';

COMMENT ON COLUMN OA_REQ_MGR.CHECKER_ID_ IS
'审批人';

COMMENT ON COLUMN OA_REQ_MGR.REP_ID_ IS
'负责人';

COMMENT ON COLUMN OA_REQ_MGR.EXE_ID_ IS
'执行人';

COMMENT ON COLUMN OA_REQ_MGR.VERSION_ IS
'版本号';

COMMENT ON COLUMN OA_REQ_MGR.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_REQ_MGR.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_REQ_MGR.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_REQ_MGR.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_REQ_MGR.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_WORK_ATT                                           */
/*==============================================================*/
CREATE TABLE OA_WORK_ATT  (
   ATT_ID_              VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   ATT_TIME_            TIMESTAMP,
   NOTICE_TYPE_         VARCHAR2(50)                    NOT NULL,
   TYPE_                VARCHAR2(50)                    NOT NULL,
   TYPE_PK_             VARCHAR2(64)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_WORK_ATT PRIMARY KEY (ATT_ID_)
);

COMMENT ON TABLE OA_WORK_ATT IS
'工作动态关注';

COMMENT ON COLUMN OA_WORK_ATT.USER_ID_ IS
'关注人ID';

COMMENT ON COLUMN OA_WORK_ATT.ATT_TIME_ IS
'关注时间';

COMMENT ON COLUMN OA_WORK_ATT.NOTICE_TYPE_ IS
'通知方式
Mail,ShortMsg,WeiXin';

COMMENT ON COLUMN OA_WORK_ATT.TYPE_ IS
'关注类型
项目=PROJECT
工作计划=PLAN
需求=REQ';

COMMENT ON COLUMN OA_WORK_ATT.TYPE_PK_ IS
'类型主键ID
当类型主键为需求类型时，即存入需求ID';

COMMENT ON COLUMN OA_WORK_ATT.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_WORK_ATT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_WORK_ATT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_WORK_ATT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_WORK_ATT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_WORK_LOG                                           */
/*==============================================================*/
CREATE TABLE OA_WORK_LOG  (
   LOG_ID_              VARCHAR2(64)                    NOT NULL,
   PLAN_ID_             VARCHAR2(64),
   CONTENT_             VARCHAR2(1024)                  NOT NULL,
   START_TIME_          TIMESTAMP                            NOT NULL,
   END_TIME_            TIMESTAMP                            NOT NULL,
   STATUS_              VARCHAR2(20),
   LAST_                INTEGER,
   CHECKER_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_WORK_LOG PRIMARY KEY (LOG_ID_)
);

COMMENT ON TABLE OA_WORK_LOG IS
'工作日志';

COMMENT ON COLUMN OA_WORK_LOG.PLAN_ID_ IS
'计划任务ID';

COMMENT ON COLUMN OA_WORK_LOG.CONTENT_ IS
'内容';

COMMENT ON COLUMN OA_WORK_LOG.START_TIME_ IS
'开始时间';

COMMENT ON COLUMN OA_WORK_LOG.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN OA_WORK_LOG.STATUS_ IS
'状态';

COMMENT ON COLUMN OA_WORK_LOG.LAST_ IS
'耗时';

COMMENT ON COLUMN OA_WORK_LOG.CHECKER_ IS
'审批人';

COMMENT ON COLUMN OA_WORK_LOG.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_WORK_LOG.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_WORK_LOG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_WORK_LOG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_WORK_LOG.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OA_WORK_MAT                                           */
/*==============================================================*/
CREATE TABLE OA_WORK_MAT  (
   ACTION_ID_           VARCHAR2(64)                    NOT NULL,
   CONTENT_             VARCHAR2(512)                   NOT NULL,
   TYPE_                VARCHAR2(50)                    NOT NULL,
   TYPE_PK_             VARCHAR2(64)                    NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OA_WORK_MAT PRIMARY KEY (ACTION_ID_)
);

COMMENT ON TABLE OA_WORK_MAT IS
'工作动态';

COMMENT ON COLUMN OA_WORK_MAT.CONTENT_ IS
'评论内容';

COMMENT ON COLUMN OA_WORK_MAT.TYPE_ IS
'类型
项目=PROJECT
工作计划=PLAN
需求=REQ';

COMMENT ON COLUMN OA_WORK_MAT.TYPE_PK_ IS
'类型主键ID
当类型主键为需求类型时，即存入需求ID';

COMMENT ON COLUMN OA_WORK_MAT.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN OA_WORK_MAT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OA_WORK_MAT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OA_WORK_MAT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OA_WORK_MAT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OD_DOCUMENT                                           */
/*==============================================================*/
CREATE TABLE OD_DOCUMENT  (
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   TREE_ID_             VARCHAR2(64),
   ISSUE_NO_            VARCHAR2(100)                   NOT NULL,
   ISSUE_DEP_ID_        VARCHAR2(64),
   IS_JOIN_ISSUE_       VARCHAR2(20),
   JOIN_DEP_IDS_        VARCHAR2(512),
   MAIN_DEP_ID_         VARCHAR2(64),
   CC_DEP_ID_           VARCHAR2(64),
   TAKE_DEP_ID_         VARCHAR2(64),
   ASS_DEP_ID_          VARCHAR2(64),
   SUBJECT_             VARCHAR2(200)                   NOT NULL,
   PRIVACY_LEVEL_       VARCHAR2(50),
   SECRECY_TERM_        INTEGER,
   PRINT_COUNT_         INTEGER,
   KEYWORDS_            VARCHAR2(256),
   URGENT_LEVEL_        VARCHAR2(50),
   SUMMARY_             VARCHAR2(1024),
   BODY_FILE_PATH_      VARCHAR2(255),
   FILE_IDS_            VARCHAR2(512),
   FILE_NAMES_          VARCHAR2(512),
   ISSUE_USR_ID_        VARCHAR2(64),
   ARCH_TYPE_           SMALLINT                        NOT NULL,
   ORG_ARCH_ID_         VARCHAR2(64),
   SELF_NO_             VARCHAR2(100),
   STATUS_              VARCHAR2(256)                   NOT NULL,
   BPM_INST_ID_         VARCHAR2(64),
   BPM_SOL_ID_          VARCHAR2(64),
   DOC_TYPE_            VARCHAR2(20),
   ISSUED_DATE_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OD_DOCUMENT PRIMARY KEY (DOC_ID_)
);

COMMENT ON COLUMN OD_DOCUMENT.TREE_ID_ IS
'发文分类ID';

COMMENT ON COLUMN OD_DOCUMENT.ISSUE_NO_ IS
'发文字号';

COMMENT ON COLUMN OD_DOCUMENT.ISSUE_DEP_ID_ IS
'发文机关或部门';

COMMENT ON COLUMN OD_DOCUMENT.IS_JOIN_ISSUE_ IS
'是否联合发文件';

COMMENT ON COLUMN OD_DOCUMENT.JOIN_DEP_IDS_ IS
'联合发文单位或部门';

COMMENT ON COLUMN OD_DOCUMENT.MAIN_DEP_ID_ IS
'主送单位';

COMMENT ON COLUMN OD_DOCUMENT.CC_DEP_ID_ IS
'抄送单位或部门';

COMMENT ON COLUMN OD_DOCUMENT.TAKE_DEP_ID_ IS
'承办部门ID';

COMMENT ON COLUMN OD_DOCUMENT.ASS_DEP_ID_ IS
'协办部门ID';

COMMENT ON COLUMN OD_DOCUMENT.SUBJECT_ IS
'文件标题';

COMMENT ON COLUMN OD_DOCUMENT.PRIVACY_LEVEL_ IS
'秘密等级
普通=COMMON
秘密=SECURITY
机密=MIDDLE-SECURITY
绝密=TOP SECURITY
';

COMMENT ON COLUMN OD_DOCUMENT.SECRECY_TERM_ IS
'保密期限(年)
';

COMMENT ON COLUMN OD_DOCUMENT.PRINT_COUNT_ IS
'打印份数';

COMMENT ON COLUMN OD_DOCUMENT.KEYWORDS_ IS
'主题词';

COMMENT ON COLUMN OD_DOCUMENT.URGENT_LEVEL_ IS
'紧急程度
普通=COMMON
紧急=URGENT
特急=URGENTEST
特提=MORE_URGENT';

COMMENT ON COLUMN OD_DOCUMENT.SUMMARY_ IS
'内容简介';

COMMENT ON COLUMN OD_DOCUMENT.BODY_FILE_PATH_ IS
'正文路径';

COMMENT ON COLUMN OD_DOCUMENT.FILE_IDS_ IS
'附件IDs';

COMMENT ON COLUMN OD_DOCUMENT.FILE_NAMES_ IS
'附件名称';

COMMENT ON COLUMN OD_DOCUMENT.ISSUE_USR_ID_ IS
'发文人ID';

COMMENT ON COLUMN OD_DOCUMENT.ARCH_TYPE_ IS
'0=发文
1=收文';

COMMENT ON COLUMN OD_DOCUMENT.ORG_ARCH_ID_ IS
'用于收文时使用，指向原公文ID';

COMMENT ON COLUMN OD_DOCUMENT.SELF_NO_ IS
'用于收文时，部门对自身的公文自编号';

COMMENT ON COLUMN OD_DOCUMENT.STATUS_ IS
'公文状态
0=拟稿、修改状态
1=发文状态
2=归档状态';

COMMENT ON COLUMN OD_DOCUMENT.BPM_INST_ID_ IS
'流程运行id
通过该id可以查看该公文的审批历史';

COMMENT ON COLUMN OD_DOCUMENT.BPM_SOL_ID_ IS
'流程方案ID';

COMMENT ON COLUMN OD_DOCUMENT.DOC_TYPE_ IS
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
 函';

COMMENT ON COLUMN OD_DOCUMENT.ISSUED_DATE_ IS
'发布日期';

COMMENT ON COLUMN OD_DOCUMENT.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN OD_DOCUMENT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OD_DOCUMENT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OD_DOCUMENT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OD_DOCUMENT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OD_DOC_FLOW                                           */
/*==============================================================*/
CREATE TABLE OD_DOC_FLOW  (
   SCHEME_ID_           VARCHAR2(64)                    NOT NULL,
   DEP_ID_              VARCHAR2(64)                    NOT NULL,
   SEND_SOL_ID_         VARCHAR2(64),
   SEND_SOL_NAME_       VARCHAR2(128),
   REC_SOL_ID_          VARCHAR2(64),
   REC_SOL_NAME_        VARCHAR2(128),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OD_DOC_FLOW PRIMARY KEY (SCHEME_ID_)
);

COMMENT ON TABLE OD_DOC_FLOW IS
'收发文流程方案';

COMMENT ON COLUMN OD_DOC_FLOW.SCHEME_ID_ IS
'方案ID';

COMMENT ON COLUMN OD_DOC_FLOW.DEP_ID_ IS
'部门ID';

COMMENT ON COLUMN OD_DOC_FLOW.SEND_SOL_ID_ IS
'发文流程方案ID';

COMMENT ON COLUMN OD_DOC_FLOW.SEND_SOL_NAME_ IS
'发文流程方案名称';

COMMENT ON COLUMN OD_DOC_FLOW.REC_SOL_ID_ IS
'收文流程方案ID';

COMMENT ON COLUMN OD_DOC_FLOW.REC_SOL_NAME_ IS
'收文流程方案名称';

COMMENT ON COLUMN OD_DOC_FLOW.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN OD_DOC_FLOW.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OD_DOC_FLOW.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OD_DOC_FLOW.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OD_DOC_FLOW.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OD_DOC_REC                                            */
/*==============================================================*/
CREATE TABLE OD_DOC_REC  (
   REC_ID_              VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64)                    NOT NULL,
   REC_DEP_ID_          VARCHAR2(64)                    NOT NULL,
   REC_DTYPE_           VARCHAR2(20),
   IS_READ_             VARCHAR2(20),
   READ_TIME_           TIMESTAMP,
   FEED_BACK_           VARCHAR2(200),
   SIGN_USR_ID_         VARCHAR2(64),
   SIGN_STATUS_         VARCHAR2(20),
   SIGN_TIME_           TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OD_DOC_REC PRIMARY KEY (REC_ID_)
);

COMMENT ON COLUMN OD_DOC_REC.REC_ID_ IS
'接收ID';

COMMENT ON COLUMN OD_DOC_REC.DOC_ID_ IS
'收发文ID';

COMMENT ON COLUMN OD_DOC_REC.REC_DEP_ID_ IS
'收文部门ID';

COMMENT ON COLUMN OD_DOC_REC.REC_DTYPE_ IS
'收文单位类型
接收单位
抄送单位
';

COMMENT ON COLUMN OD_DOC_REC.IS_READ_ IS
'是否阅读';

COMMENT ON COLUMN OD_DOC_REC.READ_TIME_ IS
'阅读时间';

COMMENT ON COLUMN OD_DOC_REC.FEED_BACK_ IS
'反馈意见';

COMMENT ON COLUMN OD_DOC_REC.SIGN_USR_ID_ IS
'签收人ID';

COMMENT ON COLUMN OD_DOC_REC.SIGN_STATUS_ IS
'签收状态';

COMMENT ON COLUMN OD_DOC_REC.SIGN_TIME_ IS
'签收时间';

COMMENT ON COLUMN OD_DOC_REC.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN OD_DOC_REC.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OD_DOC_REC.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OD_DOC_REC.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OD_DOC_REC.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OD_DOC_REMIND_                                        */
/*==============================================================*/
CREATE TABLE OD_DOC_REMIND_  (
   REMIND_ID_           VARCHAR2(64)                    NOT NULL,
   DOC_ID_              VARCHAR2(64),
   CONTENT_             VARCHAR2(1024),
   MIND_USR_ID_         VARCHAR2(64),
   TAKE_USR_ID_         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OD_DOC_REMIND_ PRIMARY KEY (REMIND_ID_)
);

COMMENT ON TABLE OD_DOC_REMIND_ IS
'收发文办理催办';

COMMENT ON COLUMN OD_DOC_REMIND_.DOC_ID_ IS
'收发文ID';

COMMENT ON COLUMN OD_DOC_REMIND_.CONTENT_ IS
'催办内容';

COMMENT ON COLUMN OD_DOC_REMIND_.MIND_USR_ID_ IS
'催办人';

COMMENT ON COLUMN OD_DOC_REMIND_.TAKE_USR_ID_ IS
'承办人';

COMMENT ON COLUMN OD_DOC_REMIND_.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN OD_DOC_REMIND_.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OD_DOC_REMIND_.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OD_DOC_REMIND_.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OD_DOC_REMIND_.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OD_DOC_TEMPLATE                                       */
/*==============================================================*/
CREATE TABLE OD_DOC_TEMPLATE  (
   TEMP_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(20)                    NOT NULL,
   DESCP_               VARCHAR2(512),
   STATUS_              VARCHAR2(20)                    NOT NULL,
   TREE_ID_             VARCHAR2(64),
   FILE_ID_             VARCHAR2(64),
   FILE_PATH_           VARCHAR2(255),
   TEMP_TYPE_           VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OD_DOC_TEMPLATE PRIMARY KEY (TEMP_ID_)
);

COMMENT ON TABLE OD_DOC_TEMPLATE IS
'公文模板';

COMMENT ON COLUMN OD_DOC_TEMPLATE.NAME_ IS
'模板名称';

COMMENT ON COLUMN OD_DOC_TEMPLATE.DESCP_ IS
'模板描述';

COMMENT ON COLUMN OD_DOC_TEMPLATE.STATUS_ IS
'模板状态
启用=ENABLED
禁用=DISABLED';

COMMENT ON COLUMN OD_DOC_TEMPLATE.TREE_ID_ IS
'模板分类ID';

COMMENT ON COLUMN OD_DOC_TEMPLATE.FILE_ID_ IS
'文件ID';

COMMENT ON COLUMN OD_DOC_TEMPLATE.FILE_PATH_ IS
'模板文件路径';

COMMENT ON COLUMN OD_DOC_TEMPLATE.TEMP_TYPE_ IS
'套红模板
公文发文模板
收文模板';

COMMENT ON COLUMN OD_DOC_TEMPLATE.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN OD_DOC_TEMPLATE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OD_DOC_TEMPLATE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OD_DOC_TEMPLATE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OD_DOC_TEMPLATE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OS_DIMENSION                                          */
/*==============================================================*/
CREATE TABLE OS_DIMENSION  (
   DIM_ID_              VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(40)                    NOT NULL,
   DIM_KEY_             VARCHAR2(64)                    NOT NULL,
   IS_COMPOSE_          VARCHAR2(10)                    NOT NULL,
   IS_SYSTEM_           VARCHAR2(10)                    NOT NULL,
   STATUS_              VARCHAR2(40)                    NOT NULL,
   SN_                  INTEGER                         NOT NULL,
   SHOW_TYPE_           VARCHAR2(40)                    NOT NULL,
   IS_GRANT_            VARCHAR2(10),
   DESC_                VARCHAR2(255),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OS_DIMENSION PRIMARY KEY (DIM_ID_)
);

COMMENT ON TABLE OS_DIMENSION IS
'组织维度';

COMMENT ON COLUMN OS_DIMENSION.DIM_ID_ IS
'维度ID';

COMMENT ON COLUMN OS_DIMENSION.NAME_ IS
'维度名称';

COMMENT ON COLUMN OS_DIMENSION.DIM_KEY_ IS
'维度业务主键';

COMMENT ON COLUMN OS_DIMENSION.IS_COMPOSE_ IS
'是否组合维度';

COMMENT ON COLUMN OS_DIMENSION.IS_SYSTEM_ IS
'是否系统预设维度';

COMMENT ON COLUMN OS_DIMENSION.STATUS_ IS
'状态
actived 已激活；locked 锁定（禁用）；deleted 已删除';

COMMENT ON COLUMN OS_DIMENSION.SN_ IS
'排序号';

COMMENT ON COLUMN OS_DIMENSION.SHOW_TYPE_ IS
'数据展示类型
tree=树型数据。flat=平铺数据';

COMMENT ON COLUMN OS_DIMENSION.IS_GRANT_ IS
'是否参与授权';

COMMENT ON COLUMN OS_DIMENSION.DESC_ IS
'描述';

COMMENT ON COLUMN OS_DIMENSION.TENANT_ID_ IS
'机构ID';

COMMENT ON COLUMN OS_DIMENSION.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OS_DIMENSION.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OS_DIMENSION.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OS_DIMENSION.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OS_DIMENSION_RIGHT                                    */
/*==============================================================*/
CREATE TABLE OS_DIMENSION_RIGHT  (
   RIGHT_ID_            VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64),
   GROUP_ID_            VARCHAR2(64),
   DIM_ID_              VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OS_DIMENSION_RIGHT PRIMARY KEY (RIGHT_ID_)
);

COMMENT ON TABLE OS_DIMENSION_RIGHT IS
'维度授权';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.RIGHT_ID_ IS
'主键ID';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.GROUP_ID_ IS
'组ID';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.DIM_ID_ IS
'维度ID';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.TENANT_ID_ IS
'机构ID';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OS_DIMENSION_RIGHT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OS_GROUP                                              */
/*==============================================================*/
CREATE TABLE OS_GROUP  (
   GROUP_ID_            VARCHAR2(64)                    NOT NULL,
   DIM_ID_              VARCHAR2(64),
   NAME_                VARCHAR2(64)                    NOT NULL,
   KEY_                 VARCHAR2(64)                    NOT NULL,
   RANK_LEVEL_          INTEGER,
   STATUS_              VARCHAR2(40)                    NOT NULL,
   DESCP_               VARCHAR2(255),
   SN_                  INTEGER                         NOT NULL,
   PARENT_ID_           VARCHAR2(64),
   DEPTH_               INTEGER,
   PATH_                VARCHAR2(1024),
   CHILDS_              INTEGER,
   FORM_                VARCHAR2(20),
   SYNC_WX_             INTEGER,
   IS_DEFAULT_          VARCHAR2(40),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OS_GROUP PRIMARY KEY (GROUP_ID_)
);

COMMENT ON TABLE OS_GROUP IS
'系统用户组';

COMMENT ON COLUMN OS_GROUP.GROUP_ID_ IS
'用户组ID';

COMMENT ON COLUMN OS_GROUP.DIM_ID_ IS
'维度ID';

COMMENT ON COLUMN OS_GROUP.NAME_ IS
'用户组名称';

COMMENT ON COLUMN OS_GROUP.KEY_ IS
'用户组业务主键';

COMMENT ON COLUMN OS_GROUP.RANK_LEVEL_ IS
'所属用户组等级值';

COMMENT ON COLUMN OS_GROUP.STATUS_ IS
'状态
inactive 未激活；actived 已激活；locked 锁定；deleted 已删除';

COMMENT ON COLUMN OS_GROUP.DESCP_ IS
'描述';

COMMENT ON COLUMN OS_GROUP.SN_ IS
'排序号';

COMMENT ON COLUMN OS_GROUP.PARENT_ID_ IS
'父用户组ID';

COMMENT ON COLUMN OS_GROUP.DEPTH_ IS
'层次';

COMMENT ON COLUMN OS_GROUP.PATH_ IS
'路径';

COMMENT ON COLUMN OS_GROUP.CHILDS_ IS
'下级数量';

COMMENT ON COLUMN OS_GROUP.FORM_ IS
'来源
sysem,系统添加,import导入,grade,分级添加的';

COMMENT ON COLUMN OS_GROUP.SYNC_WX_ IS
'同步到微信';

COMMENT ON COLUMN OS_GROUP.IS_DEFAULT_ IS
'是否默认，代表系统自带，不允许删除';

COMMENT ON COLUMN OS_GROUP.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN OS_GROUP.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OS_GROUP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OS_GROUP.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OS_GROUP.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OS_GROUP_MENU                                         */
/*==============================================================*/
CREATE TABLE OS_GROUP_MENU  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   "MENU_ID_"           VARCHAR2(64)                    NOT NULL,
   GROUP_ID_            VARCHAR2(64)                    NOT NULL,
   SYS_ID_              VARCHAR2(64)                    NOT NULL,
   CONSTRAINT PK_OS_GROUP_MENU PRIMARY KEY (ID_)
);

COMMENT ON TABLE OS_GROUP_MENU IS
'用户组下的授权菜单';

COMMENT ON COLUMN OS_GROUP_MENU."MENU_ID_" IS
'菜单ID';

COMMENT ON COLUMN OS_GROUP_MENU.GROUP_ID_ IS
'用户组ID';

/*==============================================================*/
/* Table: OS_GROUP_SYS                                          */
/*==============================================================*/
CREATE TABLE OS_GROUP_SYS  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   GROUP_ID_            VARCHAR2(64)                    NOT NULL,
   SYS_ID_              VARCHAR2(64),
   CONSTRAINT PK_OS_GROUP_SYS PRIMARY KEY (ID_)
);

COMMENT ON COLUMN OS_GROUP_SYS.GROUP_ID_ IS
'用户组ID';

/*==============================================================*/
/* Table: OS_RANK_TYPE                                          */
/*==============================================================*/
CREATE TABLE OS_RANK_TYPE  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   DIM_ID_              VARCHAR2(64),
   NAME_                VARCHAR2(255)                   NOT NULL,
   KEY_                 VARCHAR2(64)                    NOT NULL,
   LEVEL_               INTEGER                         NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OS_RANK_TYPE PRIMARY KEY (ID_)
);

COMMENT ON TABLE OS_RANK_TYPE IS
'用户组等级分类，放置组织的等级分类定义
如集团，分公司，部门等级别';

COMMENT ON COLUMN OS_RANK_TYPE.ID_ IS
'主键';

COMMENT ON COLUMN OS_RANK_TYPE.DIM_ID_ IS
'维度ID';

COMMENT ON COLUMN OS_RANK_TYPE.NAME_ IS
'名称';

COMMENT ON COLUMN OS_RANK_TYPE.KEY_ IS
'分类业务键';

COMMENT ON COLUMN OS_RANK_TYPE.LEVEL_ IS
'级别数值';

COMMENT ON COLUMN OS_RANK_TYPE.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN OS_RANK_TYPE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OS_RANK_TYPE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OS_RANK_TYPE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OS_RANK_TYPE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OS_REL_INST                                           */
/*==============================================================*/
CREATE TABLE OS_REL_INST  (
   INST_ID_             VARCHAR2(64)                    NOT NULL,
   REL_TYPE_ID_         VARCHAR2(64),
   REL_TYPE_KEY_        VARCHAR2(64),
   PARTY1_              VARCHAR2(64)                    NOT NULL,
   PARTY2_              VARCHAR2(64)                    NOT NULL,
   DIM1_                VARCHAR2(64),
   DIM2_                VARCHAR2(64),
   IS_MAIN_             VARCHAR2(20)                    NOT NULL,
   STATUS_              VARCHAR2(40)                    NOT NULL,
   ALIAS_               VARCHAR2(80),
   REL_TYPE_            VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_OS_REL_INST PRIMARY KEY (INST_ID_)
);

COMMENT ON TABLE OS_REL_INST IS
'关系实例';

COMMENT ON COLUMN OS_REL_INST.INST_ID_ IS
'用户组关系ID';

COMMENT ON COLUMN OS_REL_INST.REL_TYPE_ID_ IS
'关系类型ID';

COMMENT ON COLUMN OS_REL_INST.REL_TYPE_KEY_ IS
'关系类型KEY_
';

COMMENT ON COLUMN OS_REL_INST.PARTY1_ IS
'当前方ID';

COMMENT ON COLUMN OS_REL_INST.PARTY2_ IS
'关联方ID';

COMMENT ON COLUMN OS_REL_INST.DIM1_ IS
'当前方维度ID';

COMMENT ON COLUMN OS_REL_INST.DIM2_ IS
'关联方维度ID';

COMMENT ON COLUMN OS_REL_INST.IS_MAIN_ IS
'IS_MAIN_';

COMMENT ON COLUMN OS_REL_INST.STATUS_ IS
'状态
ENABLED
DISABLED';

COMMENT ON COLUMN OS_REL_INST.ALIAS_ IS
'别名';

COMMENT ON COLUMN OS_REL_INST.REL_TYPE_ IS
'关系类型';

COMMENT ON COLUMN OS_REL_INST.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OS_REL_INST.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OS_REL_INST.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OS_REL_INST.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN OS_REL_INST.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: OS_REL_TYPE                                           */
/*==============================================================*/
CREATE TABLE OS_REL_TYPE  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64)                    NOT NULL,
   KEY_                 VARCHAR2(64)                    NOT NULL,
   REL_TYPE_            VARCHAR2(40)                    NOT NULL,
   CONST_TYPE_          VARCHAR2(40)                    NOT NULL,
   PARTY1_              VARCHAR2(128)                   NOT NULL,
   PARTY2_              VARCHAR2(128)                   NOT NULL,
   DIM_ID1_             VARCHAR2(64),
   DIM_ID2_             VARCHAR2(64),
   STATUS_              VARCHAR2(40)                    NOT NULL,
   IS_SYSTEM_           VARCHAR2(10)                    NOT NULL,
   IS_DEFAULT_          VARCHAR2(10)                    NOT NULL,
   IS_TWO_WAY_          VARCHAR2(10)                    NOT NULL,
   MEMO_                VARCHAR2(255),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OS_REL_TYPE PRIMARY KEY (ID_)
);

COMMENT ON TABLE OS_REL_TYPE IS
'关系类型定义';

COMMENT ON COLUMN OS_REL_TYPE.ID_ IS
'关系类型ID';

COMMENT ON COLUMN OS_REL_TYPE.NAME_ IS
'关系名';

COMMENT ON COLUMN OS_REL_TYPE.KEY_ IS
'关系业务主键';

COMMENT ON COLUMN OS_REL_TYPE.REL_TYPE_ IS
'关系类型。用户关系=USER-USER；用户组关系=GROUP-GROUP；用户与组关系=USER-GROUP；组与用户关系=GROUP-USER';

COMMENT ON COLUMN OS_REL_TYPE.CONST_TYPE_ IS
'关系约束类型。1对1=one2one；1对多=one2many；多对1=many2one；多对多=many2many';

COMMENT ON COLUMN OS_REL_TYPE.PARTY1_ IS
'关系当前方名称';

COMMENT ON COLUMN OS_REL_TYPE.PARTY2_ IS
'关系关联方名称';

COMMENT ON COLUMN OS_REL_TYPE.DIM_ID1_ IS
'当前方维度ID（仅对用户组关系）';

COMMENT ON COLUMN OS_REL_TYPE.DIM_ID2_ IS
'关联方维度ID（用户关系忽略此值）';

COMMENT ON COLUMN OS_REL_TYPE.STATUS_ IS
'状态。actived 已激活；locked 锁定；deleted 已删除';

COMMENT ON COLUMN OS_REL_TYPE.IS_SYSTEM_ IS
'是否系统预设';

COMMENT ON COLUMN OS_REL_TYPE.IS_DEFAULT_ IS
'是否默认';

COMMENT ON COLUMN OS_REL_TYPE.IS_TWO_WAY_ IS
'是否是双向';

COMMENT ON COLUMN OS_REL_TYPE.MEMO_ IS
'关系备注';

COMMENT ON COLUMN OS_REL_TYPE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OS_REL_TYPE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OS_REL_TYPE.TENANT_ID_ IS
'公共 - 创建者所属SAAS ID';

COMMENT ON COLUMN OS_REL_TYPE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OS_REL_TYPE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: OS_USER                                               */
/*==============================================================*/
CREATE TABLE OS_USER  (
   USER_ID_             VARCHAR2(64)                    NOT NULL,
   FULLNAME_            VARCHAR2(64)                    NOT NULL,
   USER_NO_             VARCHAR2(64)                    NOT NULL,
   ENTRY_TIME_          TIMESTAMP,
   QUIT_TIME_           TIMESTAMP,
   STATUS_              VARCHAR2(20)                    NOT NULL,
   FROM_                VARCHAR2(20),
   BIRTHDAY_            TIMESTAMP,
   SEX_                 VARCHAR2(10),
   MOBILE_              VARCHAR2(20),
   EMAIL_               VARCHAR2(100),
   ADDRESS_             VARCHAR2(255),
   URGENT_              VARCHAR2(64),
   SYNC_WX_             INTEGER,
   URGENT_MOBILE_       VARCHAR2(20),
   QQ_                  VARCHAR2(20),
   PHOTO_               VARCHAR2(255),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_OS_USER PRIMARY KEY (USER_ID_)
);

COMMENT ON TABLE OS_USER IS
'用户信息表';

COMMENT ON COLUMN OS_USER.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN OS_USER.FULLNAME_ IS
'姓名';

COMMENT ON COLUMN OS_USER.ENTRY_TIME_ IS
'入职时间';

COMMENT ON COLUMN OS_USER.QUIT_TIME_ IS
'离职时间';

COMMENT ON COLUMN OS_USER.STATUS_ IS
'状态

在职=ON_JOB
离职=OUT_JOB
';

COMMENT ON COLUMN OS_USER.FROM_ IS
'来源
system,系统添加,import,导入,grade,分级添加的';

COMMENT ON COLUMN OS_USER.BIRTHDAY_ IS
'出生日期';

COMMENT ON COLUMN OS_USER.SEX_ IS
'姓别';

COMMENT ON COLUMN OS_USER.MOBILE_ IS
'手机';

COMMENT ON COLUMN OS_USER.EMAIL_ IS
'邮件';

COMMENT ON COLUMN OS_USER.ADDRESS_ IS
'地址';

COMMENT ON COLUMN OS_USER.URGENT_ IS
'紧急联系人';

COMMENT ON COLUMN OS_USER.SYNC_WX_ IS
'是否同步到微信';

COMMENT ON COLUMN OS_USER.URGENT_MOBILE_ IS
'紧急联系人手机';

COMMENT ON COLUMN OS_USER.QQ_ IS
'QQ号';

COMMENT ON COLUMN OS_USER.PHOTO_ IS
'照片';

COMMENT ON COLUMN OS_USER.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN OS_USER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN OS_USER.TENANT_ID_ IS
'机构ID';

COMMENT ON COLUMN OS_USER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN OS_USER.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SMS_MSG_INFO                                          */
/*==============================================================*/
CREATE TABLE SMS_MSG_INFO  (
   SMS_ID_              VARCHAR2(64)                    NOT NULL,
   SEND_USER_           VARCHAR2(64),
   RECEIVE_USER_        VARCHAR2(64),
   MOBILE_              VARCHAR2(20),
   CONTENT_             CLOB,
   TENANT_ID_           VARCHAR2(64),
   STATUS_              SMALLINT,
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_SMS_MSG_INFO PRIMARY KEY (SMS_ID_)
);

COMMENT ON TABLE SMS_MSG_INFO IS
'短信信息表';

COMMENT ON COLUMN SMS_MSG_INFO.SMS_ID_ IS
'主键';

COMMENT ON COLUMN SMS_MSG_INFO.RECEIVE_USER_ IS
'用户ID';

COMMENT ON COLUMN SMS_MSG_INFO.MOBILE_ IS
'手机';

COMMENT ON COLUMN SMS_MSG_INFO.CONTENT_ IS
'内容';

COMMENT ON COLUMN SMS_MSG_INFO.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN SMS_MSG_INFO.STATUS_ IS
'1保存2未发送3发送成功4发送失败';

COMMENT ON COLUMN SMS_MSG_INFO.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SMS_MSG_INFO.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SMS_MSG_INFO.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SMS_MSG_INFO.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: SMS_MSG_SEND                                          */
/*==============================================================*/
CREATE TABLE SMS_MSG_SEND  (
   SEND_ID_             VARCHAR2(64)                    NOT NULL,
   GATEWAY_ID_          VARCHAR2(64),
   SEND_USER_           VARCHAR2(64),
   RECEIVE_USER_        VARCHAR2(64),
   MOBILE_              VARCHAR2(20),
   MSG_ID_              VARCHAR2(64),
   CONTENT_             CLOB,
   RECEIPT_ID_          VARCHAR2(512),
   STATUS_              SMALLINT,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_SMS_MSG_SEND PRIMARY KEY (SEND_ID_)
);

COMMENT ON TABLE SMS_MSG_SEND IS
'短信发送表';

COMMENT ON COLUMN SMS_MSG_SEND.SEND_ID_ IS
'主键';

COMMENT ON COLUMN SMS_MSG_SEND.GATEWAY_ID_ IS
'代理应用ID';

COMMENT ON COLUMN SMS_MSG_SEND.RECEIVE_USER_ IS
'用户ID';

COMMENT ON COLUMN SMS_MSG_SEND.MOBILE_ IS
'手机';

COMMENT ON COLUMN SMS_MSG_SEND.CONTENT_ IS
'内容';

COMMENT ON COLUMN SMS_MSG_SEND.STATUS_ IS
'1保存2未发送3发送成功4发送失败';

COMMENT ON COLUMN SMS_MSG_SEND.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN SMS_MSG_SEND.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SMS_MSG_SEND.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SMS_MSG_SEND.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SMS_MSG_SEND.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: SYS_ACCOUNT                                           */
/*==============================================================*/
CREATE TABLE SYS_ACCOUNT  (
   ACCOUNT_ID_          VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(50)                    NOT NULL,
   PWD_                 VARCHAR2(64)                    NOT NULL,
   ENC_TYPE_            VARCHAR2(20),
   FULLNAME_            VARCHAR2(32)                    NOT NULL,
   USER_ID_             VARCHAR2(64),
   REMARK_              VARCHAR2(200),
   STATUS_              VARCHAR2(20)                    NOT NULL,
   DOMAIN_              VARCHAR2(64),
   CREAT_ORG_ID_        VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_ACCOUNT PRIMARY KEY (ACCOUNT_ID_)
);

COMMENT ON TABLE SYS_ACCOUNT IS
'登录账号';

COMMENT ON COLUMN SYS_ACCOUNT.NAME_ IS
'账号名称';

COMMENT ON COLUMN SYS_ACCOUNT.PWD_ IS
'密码';

COMMENT ON COLUMN SYS_ACCOUNT.ENC_TYPE_ IS
'加密算法
MD5
SHA-256
PLAINTEXT';

COMMENT ON COLUMN SYS_ACCOUNT.FULLNAME_ IS
'用户名';

COMMENT ON COLUMN SYS_ACCOUNT.USER_ID_ IS
'绑定用户ID';

COMMENT ON COLUMN SYS_ACCOUNT.REMARK_ IS
'备注';

COMMENT ON COLUMN SYS_ACCOUNT.STATUS_ IS
'状态
ENABLED=可用
DISABLED=禁用
DELETED=删除';

COMMENT ON COLUMN SYS_ACCOUNT.DOMAIN_ IS
'域名';

COMMENT ON COLUMN SYS_ACCOUNT.CREAT_ORG_ID_ IS
'创建人组织ID';

COMMENT ON COLUMN SYS_ACCOUNT.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_ACCOUNT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_ACCOUNT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_ACCOUNT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_ACCOUNT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_BO_ATTR                                           */
/*==============================================================*/
CREATE TABLE SYS_BO_ATTR  (
   ID_                  VARCHAR2(20)                    NOT NULL,
   ENT_ID_              VARCHAR2(20),
   NAME_                VARCHAR2(64),
   FIELD_NAME_          VARCHAR2(64),
   COMMENT_             VARCHAR2(100),
   DATA_TYPE_           VARCHAR2(10),
   LENGTH_              INTEGER,
   DECIMAL_LENGTH_      INTEGER,
   CONTROL_             VARCHAR2(30),
   EXT_JSON_            VARCHAR2(1000),
   HAS_GEN_             VARCHAR2(10),
   STATUS_              VARCHAR2(10),
   IS_SINGLE_           INTEGER,
   TENANT_ID_           VARCHAR2(20),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_BO_ATTR PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_BO_ATTR IS
'业务实体属性定义';

COMMENT ON COLUMN SYS_BO_ATTR.ID_ IS
'主键';

COMMENT ON COLUMN SYS_BO_ATTR.ENT_ID_ IS
'实体ID';

COMMENT ON COLUMN SYS_BO_ATTR.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_BO_ATTR.FIELD_NAME_ IS
'字段名';

COMMENT ON COLUMN SYS_BO_ATTR.COMMENT_ IS
'备注';

COMMENT ON COLUMN SYS_BO_ATTR.DATA_TYPE_ IS
'类型';

COMMENT ON COLUMN SYS_BO_ATTR.LENGTH_ IS
'数据长度';

COMMENT ON COLUMN SYS_BO_ATTR.DECIMAL_LENGTH_ IS
'数据精度';

COMMENT ON COLUMN SYS_BO_ATTR.CONTROL_ IS
'控件类型';

COMMENT ON COLUMN SYS_BO_ATTR.EXT_JSON_ IS
'扩展JSON';

COMMENT ON COLUMN SYS_BO_ATTR.HAS_GEN_ IS
'是否生成字段';

COMMENT ON COLUMN SYS_BO_ATTR.STATUS_ IS
'状态';

COMMENT ON COLUMN SYS_BO_ATTR.IS_SINGLE_ IS
'是否单个属性字段';

COMMENT ON COLUMN SYS_BO_ATTR.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_BO_ATTR.CREATE_BY_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_ATTR.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_ATTR.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_BO_ATTR.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_BO_DEFINITION                                     */
/*==============================================================*/
CREATE TABLE SYS_BO_DEFINITION  (
   ID_                  VARCHAR2(20)                    NOT NULL,
   NAME_                VARCHAR2(64),
   ALAIS_               VARCHAR2(64),
   COMMENT_             VARCHAR2(200),
   SUPPORT_DB_          VARCHAR2(20),
   GEN_MODE_            VARCHAR2(20),
   TREE_ID_             VARCHAR2(20),
   TENANT_ID_           VARCHAR2(20),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   OPINION_DEF_         VARCHAR2(2000),
   CONSTRAINT PK_SYS_BO_DEFINITION PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_BO_DEFINITION IS
'业务对象定义';

COMMENT ON COLUMN SYS_BO_DEFINITION.ID_ IS
'主键';

COMMENT ON COLUMN SYS_BO_DEFINITION.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_BO_DEFINITION.ALAIS_ IS
'别名';

COMMENT ON COLUMN SYS_BO_DEFINITION.COMMENT_ IS
'备注';

COMMENT ON COLUMN SYS_BO_DEFINITION.SUPPORT_DB_ IS
'是否支持数据库';

COMMENT ON COLUMN SYS_BO_DEFINITION.GEN_MODE_ IS
'生成模式';

COMMENT ON COLUMN SYS_BO_DEFINITION.TREE_ID_ IS
'分类ID';

COMMENT ON COLUMN SYS_BO_DEFINITION.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_BO_DEFINITION.CREATE_BY_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_DEFINITION.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_DEFINITION.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_BO_DEFINITION.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_BO_DEFINITION.OPINION_DEF_ IS
'表单意见定义';

/*==============================================================*/
/* Table: SYS_BO_ENTITY                                         */
/*==============================================================*/
CREATE TABLE SYS_BO_ENTITY  (
   ID_                  VARCHAR2(20)                    NOT NULL,
   NAME_                VARCHAR2(64),
   COMMENT_             VARCHAR2(64),
   TABLE_NAME_          VARCHAR2(64),
   DS_NAME_             VARCHAR2(64),
   GEN_TABLE_           VARCHAR2(20),
   TENANT_ID_           VARCHAR2(20),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_BO_ENTITY PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_BO_ENTITY IS
'业务实体对象';

COMMENT ON COLUMN SYS_BO_ENTITY.ID_ IS
'主键';

COMMENT ON COLUMN SYS_BO_ENTITY.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_BO_ENTITY.COMMENT_ IS
'注释';

COMMENT ON COLUMN SYS_BO_ENTITY.TABLE_NAME_ IS
'表名';

COMMENT ON COLUMN SYS_BO_ENTITY.DS_NAME_ IS
'数据源名称';

COMMENT ON COLUMN SYS_BO_ENTITY.GEN_TABLE_ IS
'是否生成物理表';

COMMENT ON COLUMN SYS_BO_ENTITY.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_BO_ENTITY.CREATE_BY_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_ENTITY.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_ENTITY.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_BO_ENTITY.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_BO_LIST                                           */
/*==============================================================*/
CREATE TABLE SYS_BO_LIST  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   SOL_ID_              VARCHAR2(64),
   NAME_                VARCHAR2(200)                   NOT NULL,
   KEY_                 VARCHAR2(120)                   NOT NULL,
   DESCP_               VARCHAR2(500),
   ID_FIELD_            VARCHAR2(60),
   URL_                 VARCHAR2(256),
   MULTI_SELECT_        VARCHAR2(20),
   IS_LEFT_TREE_        VARCHAR2(20),
   LEFT_NAV_            VARCHAR2(80),
   LEFT_TREE_JSON_      CLOB,
   SQL_                 VARCHAR2(512)                   NOT NULL,
   USE_COND_SQL_        VARCHAR2(20),
   COND_SQLS_           CLOB,
   DB_AS_               VARCHAR2(64),
   FIELDS_JSON_         CLOB,
   COLS_JSON_           CLOB,
   LIST_HTML_           CLOB,
   SEARCH_JSON_         CLOB,
   BPM_SOL_ID_          VARCHAR2(64),
   FORM_ALIAS_          VARCHAR2(64),
   TOP_BTNS_JSON_       CLOB,
   BODY_SCRIPT_         CLOB,
   IS_DIALOG_           VARCHAR2(20),
   IS_PAGE_             VARCHAR2(20),
   IS_EXPORT_           VARCHAR2(20),
   HEIGHT_              INTEGER,
   WIDTH_               INTEGER,
   ENABLE_FLOW_         VARCHAR2(20),
   IS_GEN_              VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   "IS_SHARE_"          VARCHAR2(20),
   CONSTRAINT PK_SYS_BO_LIST PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_BO_LIST IS
'系统自定义业务管理列表';

COMMENT ON COLUMN SYS_BO_LIST.ID_ IS
'ID';

COMMENT ON COLUMN SYS_BO_LIST.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN SYS_BO_LIST.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_BO_LIST.KEY_ IS
'标识键';

COMMENT ON COLUMN SYS_BO_LIST.DESCP_ IS
'描述';

COMMENT ON COLUMN SYS_BO_LIST.ID_FIELD_ IS
'主键字段';

COMMENT ON COLUMN SYS_BO_LIST.URL_ IS
'数据地址';

COMMENT ON COLUMN SYS_BO_LIST.MULTI_SELECT_ IS
'是否多选择';

COMMENT ON COLUMN SYS_BO_LIST.IS_LEFT_TREE_ IS
'是否显示左树';

COMMENT ON COLUMN SYS_BO_LIST.LEFT_NAV_ IS
'左树SQL，格式如"select * from abc"##"select * from abc2"';

COMMENT ON COLUMN SYS_BO_LIST.LEFT_TREE_JSON_ IS
'左树字段映射';

COMMENT ON COLUMN SYS_BO_LIST.SQL_ IS
'SQL语句';

COMMENT ON COLUMN SYS_BO_LIST.DB_AS_ IS
'数据源ID';

COMMENT ON COLUMN SYS_BO_LIST.FIELDS_JSON_ IS
'列字段JSON';

COMMENT ON COLUMN SYS_BO_LIST.COLS_JSON_ IS
'列的JSON';

COMMENT ON COLUMN SYS_BO_LIST.LIST_HTML_ IS
'列表显示模板';

COMMENT ON COLUMN SYS_BO_LIST.SEARCH_JSON_ IS
'搜索条件HTML';

COMMENT ON COLUMN SYS_BO_LIST.BPM_SOL_ID_ IS
'绑定流程方案';

COMMENT ON COLUMN SYS_BO_LIST.FORM_ALIAS_ IS
'绑定表单方案';

COMMENT ON COLUMN SYS_BO_LIST.TOP_BTNS_JSON_ IS
'头部按钮配置';

COMMENT ON COLUMN SYS_BO_LIST.BODY_SCRIPT_ IS
'脚本JS';

COMMENT ON COLUMN SYS_BO_LIST.IS_DIALOG_ IS
'是否对话框';

COMMENT ON COLUMN SYS_BO_LIST.IS_PAGE_ IS
'是否分页';

COMMENT ON COLUMN SYS_BO_LIST.IS_EXPORT_ IS
'是否允许导出';

COMMENT ON COLUMN SYS_BO_LIST.HEIGHT_ IS
'高';

COMMENT ON COLUMN SYS_BO_LIST.WIDTH_ IS
'宽';

COMMENT ON COLUMN SYS_BO_LIST.ENABLE_FLOW_ IS
'是否启用流程';

COMMENT ON COLUMN SYS_BO_LIST.IS_GEN_ IS
'是否已产生HTML';

COMMENT ON COLUMN SYS_BO_LIST.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_BO_LIST.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN SYS_BO_LIST.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_LIST.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_BO_LIST.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_BO_LIST."IS_SHARE_" IS
'是否共享';

/*==============================================================*/
/* Table: SYS_BO_RELATION                                       */
/*==============================================================*/
CREATE TABLE SYS_BO_RELATION  (
   ID_                  VARCHAR2(20)                    NOT NULL,
   BO_DEFID_            VARCHAR2(20),
   RELATION_TYPE_       VARCHAR2(20),
   FORM_ALIAS_          VARCHAR2(64),
   IS_REF_              INTEGER,
   BO_ENTID_            VARCHAR2(20),
   TENANT_ID_           VARCHAR2(20),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_BO_RELATION PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_BO_RELATION IS
'业务对象定义';

COMMENT ON COLUMN SYS_BO_RELATION.ID_ IS
'主键';

COMMENT ON COLUMN SYS_BO_RELATION.BO_DEFID_ IS
'BO定义ID';

COMMENT ON COLUMN SYS_BO_RELATION.RELATION_TYPE_ IS
'关系类型(main,sub)';

COMMENT ON COLUMN SYS_BO_RELATION.FORM_ALIAS_ IS
'表单别名';

COMMENT ON COLUMN SYS_BO_RELATION.IS_REF_ IS
'是否引用实体';

COMMENT ON COLUMN SYS_BO_RELATION.BO_ENTID_ IS
'BO实体ID';

COMMENT ON COLUMN SYS_BO_RELATION.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_BO_RELATION.CREATE_BY_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_RELATION.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_BO_RELATION.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_BO_RELATION.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_BUTTON                                            */
/*==============================================================*/
CREATE TABLE SYS_BUTTON  (
   BUTTON_ID_           VARCHAR2(64)                    NOT NULL,
   "MODULE_ID_"         VARCHAR2(64),
   NAME_                VARCHAR2(50)                    NOT NULL,
   ICON_CLS_            VARCHAR2(50),
   GLYPH_               VARCHAR2(50),
   SN_                  INTEGER                         NOT NULL,
   BTN_TYPE_            VARCHAR2(20)                    NOT NULL,
   KEY_                 VARCHAR2(50)                    NOT NULL,
   POS_                 VARCHAR2(50)                    NOT NULL,
   CUSTOM_HANDLER_      CLOB,
   LINK_MODULE_ID_      VARCHAR2(64),
   CONSTRAINT PK_SYS_BUTTON PRIMARY KEY (BUTTON_ID_)
);

COMMENT ON TABLE SYS_BUTTON IS
'系统功能按钮管理
包括列表表头的按钮、管理列的按钮、表单按钮、子模块（明细）按钮';

COMMENT ON COLUMN SYS_BUTTON.BUTTON_ID_ IS
'按钮ID';

COMMENT ON COLUMN SYS_BUTTON."MODULE_ID_" IS
'模块ID';

COMMENT ON COLUMN SYS_BUTTON.NAME_ IS
'按钮名称';

COMMENT ON COLUMN SYS_BUTTON.ICON_CLS_ IS
'按钮ICONCLS';

COMMENT ON COLUMN SYS_BUTTON.GLYPH_ IS
'GLYPH';

COMMENT ON COLUMN SYS_BUTTON.SN_ IS
'序号';

COMMENT ON COLUMN SYS_BUTTON.BTN_TYPE_ IS
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
自定义=CUSTOM';

COMMENT ON COLUMN SYS_BUTTON.KEY_ IS
'按钮Key';

COMMENT ON COLUMN SYS_BUTTON.POS_ IS
'按钮位置
TOP=表头工具栏
MANAGE=管理列
FORM_BOTTOM=表单底部按钮栏
FORM_TOP=表单的头部
DETAIL_TOP=明细的头部
DETAIL_BOTTOM=表单底部明细

';

COMMENT ON COLUMN SYS_BUTTON.CUSTOM_HANDLER_ IS
'自定义执行处理';

COMMENT ON COLUMN SYS_BUTTON.LINK_MODULE_ID_ IS
'关联模块ID';

/*==============================================================*/
/* Table: SYS_CUSTOMFORM_SETTING                                */
/*==============================================================*/
CREATE TABLE SYS_CUSTOMFORM_SETTING  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64),
   ALIAS_               VARCHAR2(64),
   PRE_JS_SCRIPT_       VARCHAR2(1000),
   AFTER_JS_SCRIPT_     VARCHAR2(1000),
   PRE_JAVA_SCRIPT_     VARCHAR2(1000),
   AFTER_JAVA_SCRIPT_   VARCHAR2(1000),
   SOL_NAME_            VARCHAR2(64),
   SOL_ID_              VARCHAR2(64),
   FORM_NAME_           VARCHAR2(100),
   FORM_ALIAS_          VARCHAR2(64),
   BODEF_ID_            VARCHAR2(64),
   BODEF_NAME_          VARCHAR2(100),
   IS_TREE_             INTEGER,
   TENANT_ID_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   EXPAND_LEVEL_        INTEGER,
   LOAD_MODE_           INTEGER,
   DISPLAY_FIELDS_      VARCHAR2(64),
   BUTTON_DEF_          VARCHAR2(1000),
   DATA_HANDLER_        CHAR(10),
   CONSTRAINT PK_SYS_CUSTOMFORM_SETTING PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_CUSTOMFORM_SETTING IS
'自定义表单设定';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.ID_ IS
'主键';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.ALIAS_ IS
'别名';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.PRE_JS_SCRIPT_ IS
'前置JS';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.AFTER_JS_SCRIPT_ IS
'后置JS';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.PRE_JAVA_SCRIPT_ IS
'前置JAVA脚本';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.AFTER_JAVA_SCRIPT_ IS
'后置JAVA脚本';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.SOL_NAME_ IS
'解决方案';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.FORM_NAME_ IS
'表单名称';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.FORM_ALIAS_ IS
'表单别名';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.BODEF_ID_ IS
'业务模型ID';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.BODEF_NAME_ IS
'业务模型';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.IS_TREE_ IS
'树形表单(0,普通表单,1,树形表单)';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.EXPAND_LEVEL_ IS
'展开级别';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.LOAD_MODE_ IS
'树形加载方式0,一次性加载,1,懒加载';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.DISPLAY_FIELDS_ IS
'显示字段';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.BUTTON_DEF_ IS
'自定义按钮';

COMMENT ON COLUMN SYS_CUSTOMFORM_SETTING.DATA_HANDLER_ IS
'数据处理器';

/*==============================================================*/
/* Table: SYS_CUSTOM_QUERY                                      */
/*==============================================================*/
CREATE TABLE SYS_CUSTOM_QUERY  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64),
   KEY_                 VARCHAR2(64),
   TABLE_NAME_          VARCHAR2(64),
   IS_PAGE_             INTEGER,
   PAGE_SIZE_           INTEGER,
   WHERE_FIELD_         CLOB,
   RESULT_FIELD_        VARCHAR2(2000),
   ORDER_FIELD_         VARCHAR2(100),
   DS_ALIAS_            VARCHAR2(64),
   TABLE_               INTEGER,
   SQL_DIY_             CLOB,
   SQL_BUILD_TYPE_      INTEGER,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_CUSTOM_QUERY PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_CUSTOM_QUERY IS
'自定查询';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.ID_ IS
'主键';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.KEY_ IS
'标识名 租户中唯一';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.TABLE_NAME_ IS
'对象名称(表名或视图名)';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.IS_PAGE_ IS
'支持分页(1,支持,0不支持)';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.PAGE_SIZE_ IS
'分页大小';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.WHERE_FIELD_ IS
'条件字段定义';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.RESULT_FIELD_ IS
'结果字段定义';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.ORDER_FIELD_ IS
'排序字段';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.DS_ALIAS_ IS
'数据源名称';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.TABLE_ IS
'是否为表(1,表,0视图)';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.SQL_DIY_ IS
'自定sql';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.SQL_BUILD_TYPE_ IS
'SQL类型';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_CUSTOM_QUERY.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_DATASOURCE_DEF                                    */
/*==============================================================*/
CREATE TABLE SYS_DATASOURCE_DEF  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64),
   ALIAS_               VARCHAR2(64),
   ENABLE_              VARCHAR2(10),
   SETTING_             VARCHAR2(2000),
   DB_TYPE_             VARCHAR2(10),
   INIT_ON_START_       VARCHAR2(10),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_DATASOURCE_DEF PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_DATASOURCE_DEF IS
'数据源定义管理';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.ID_ IS
'主键';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.NAME_ IS
'数据源名称';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.ALIAS_ IS
'别名';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.ENABLE_ IS
'是否使用';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.SETTING_ IS
'数据源设定';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.DB_TYPE_ IS
'数据库类型';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.INIT_ON_START_ IS
'启动时初始化';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_DATASOURCE_DEF.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_DB_SQL                                            */
/*==============================================================*/
CREATE TABLE SYS_DB_SQL  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   KEY_                 VARCHAR2(256)                   NOT NULL,
   NAME_                VARCHAR2(256)                   NOT NULL,
   HEADER_              CLOB                            NOT NULL,
   DS_NAME_             VARCHAR2(256),
   DS_ID_               VARCHAR2(64),
   SQL_                 CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_DB_SQL PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_DB_SQL IS
'自定义SQL';

COMMENT ON COLUMN SYS_DB_SQL.ID_ IS
'ID_';

COMMENT ON COLUMN SYS_DB_SQL.KEY_ IS
'KEY_';

COMMENT ON COLUMN SYS_DB_SQL.NAME_ IS
'公司英文名';

COMMENT ON COLUMN SYS_DB_SQL.HEADER_ IS
'表头中文名称,以JSON存储';

COMMENT ON COLUMN SYS_DB_SQL.DS_NAME_ IS
'数据源名称';

COMMENT ON COLUMN SYS_DB_SQL.DS_ID_ IS
'数据源ID';

COMMENT ON COLUMN SYS_DB_SQL.SQL_ IS
'SQL语句';

COMMENT ON COLUMN SYS_DB_SQL.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_DB_SQL.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_DB_SQL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_DB_SQL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_DB_SQL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_DIC                                               */
/*==============================================================*/
CREATE TABLE SYS_DIC  (
   "DIC_ID_"            VARCHAR2(64)                    NOT NULL,
   "TYPE_ID_"           VARCHAR2(64),
   "KEY_"               VARCHAR2(64),
   "NAME_"              VARCHAR2(64)                    NOT NULL,
   "VALUE_"             VARCHAR2(100)                   NOT NULL,
   "DESCP_"             VARCHAR2(256),
   "SN_"                INTEGER,
   "PATH_"              VARCHAR2(256),
   "PARENT_ID_"         VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_DIC PRIMARY KEY ("DIC_ID_")
);

COMMENT ON COLUMN SYS_DIC."DIC_ID_" IS
'主键';

COMMENT ON COLUMN SYS_DIC."TYPE_ID_" IS
'分类Id';

COMMENT ON COLUMN SYS_DIC."KEY_" IS
'项Key';

COMMENT ON COLUMN SYS_DIC."NAME_" IS
'项名';

COMMENT ON COLUMN SYS_DIC."VALUE_" IS
'项值';

COMMENT ON COLUMN SYS_DIC."DESCP_" IS
'描述';

COMMENT ON COLUMN SYS_DIC."SN_" IS
'序号';

COMMENT ON COLUMN SYS_DIC."PATH_" IS
'路径';

COMMENT ON COLUMN SYS_DIC."PARENT_ID_" IS
'父ID';

COMMENT ON COLUMN SYS_DIC.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_DIC.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_DIC.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_DIC.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_DIC.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_ELEM_RIGHT                                        */
/*==============================================================*/
CREATE TABLE SYS_ELEM_RIGHT  (
   RIGHT_ID_            VARCHAR2(64)                    NOT NULL,
   COMP_ID_             VARCHAR2(64)                    NOT NULL,
   COMP_TYPE_           VARCHAR2(20)                    NOT NULL,
   RIGHT_TYPE_          VARCHAR2(20)                    NOT NULL,
   IDENTITY_ID_         VARCHAR2(64)                    NOT NULL,
   IDENTITY_TYPE_       VARCHAR2(20)                    NOT NULL,
   CONSTRAINT PK_SYS_ELEM_RIGHT PRIMARY KEY (RIGHT_ID_)
);

COMMENT ON TABLE SYS_ELEM_RIGHT IS
'系统元素权限
表单、组、字段、按钮权限';

COMMENT ON COLUMN SYS_ELEM_RIGHT.RIGHT_ID_ IS
'权限ID';

COMMENT ON COLUMN SYS_ELEM_RIGHT.COMP_ID_ IS
'组件ID
表单ID/组/字段ID/按钮ID';

COMMENT ON COLUMN SYS_ELEM_RIGHT.COMP_TYPE_ IS
'组件类型
Form=表单
Group=组
Field=字段
Button=按钮
';

COMMENT ON COLUMN SYS_ELEM_RIGHT.RIGHT_TYPE_ IS
'权限类型
ReadOnly=只读
Edit=可用
Hidden=隐藏';

COMMENT ON COLUMN SYS_ELEM_RIGHT.IDENTITY_ID_ IS
'用户标识ID';

COMMENT ON COLUMN SYS_ELEM_RIGHT.IDENTITY_TYPE_ IS
'用户=User
用户组=Group';

/*==============================================================*/
/* Table: SYS_FIELD                                             */
/*==============================================================*/
CREATE TABLE SYS_FIELD  (
   "FIELD_ID_"          VARCHAR2(64)                    NOT NULL,
   "MODULE_ID_"         VARCHAR2(64)                    NOT NULL,
   "TITLE_"             VARCHAR2(50)                    NOT NULL,
   "ATTR_NAME_"         VARCHAR2(50)                    NOT NULL,
   "LINK_MOD_ID_"       VARCHAR2(64),
   "FIELD_TYPE_"        VARCHAR2(50)                    NOT NULL,
   "FIELD_GROUP_"       VARCHAR2(50),
   "FIELD_LENGTH_"      INTEGER,
   "PRECISION_"         INTEGER,
   "SN_"                INTEGER,
   "COLSPAN_"           INTEGER,
   "FIELD_CAT_"         VARCHAR2(20),
   "RELATION_TYPE_"     VARCHAR2(20),
   EDIT_RIGHT_          VARCHAR2(20),
   ADD_RIGHT_           VARCHAR2(20),
   "IS_HIDDEN_"         VARCHAR2(6),
   "IS_READABLE_"       VARCHAR2(6),
   "IS_REQUIRED_"       VARCHAR2(6),
   "IS_DISABLED_"       VARCHAR2(6),
   "ALLOW_GROUP_"       VARCHAR2(6),
   "ALLOW_SORT_"        VARCHAR2(6),
   "ALLOW_SUM_"         VARCHAR2(6),
   "IS_DEFAULT_COL_"    VARCHAR2(8),
   "IS_QUERY_COL_"      VARCHAR2(8),
   "DEF_VALUE_"         VARCHAR2(50),
   "REMARK_"            CLOB,
   "SHOW_NAV_TREE_"     VARCHAR2(6),
   "DB_FIELD_NAME_"     VARCHAR2(50),
   "DB_FIELD_FORMULA_"  CLOB,
   "ALLOW_EXCEL_INSERT_" VARCHAR2(6),
   "ALLOW_EXCEL_EDIT_"  VARCHAR2(6),
   "HAS_ATTACH_"        VARCHAR2(6),
   "IS_CHAR_CAT_"       VARCHAR2(6),
   "RENDERER_"          VARCHAR2(512),
   "IS_USER_DEF_"       VARCHAR2(6),
   "COMP_TYPE_"         VARCHAR2(50),
   "JSON_CONFIG_"       CLOB,
   "LINK_ADD_MODE_"     VARCHAR2(16),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_FIELD PRIMARY KEY ("FIELD_ID_")
);

COMMENT ON TABLE SYS_FIELD IS
'功能模块字段';

COMMENT ON COLUMN SYS_FIELD."FIELD_ID_" IS
'字段ID';

COMMENT ON COLUMN SYS_FIELD."MODULE_ID_" IS
'模块ID';

COMMENT ON COLUMN SYS_FIELD."TITLE_" IS
'标题';

COMMENT ON COLUMN SYS_FIELD."ATTR_NAME_" IS
'字段名称';

COMMENT ON COLUMN SYS_FIELD."LINK_MOD_ID_" IS
'关联模块ID';

COMMENT ON COLUMN SYS_FIELD."FIELD_TYPE_" IS
'字段类型';

COMMENT ON COLUMN SYS_FIELD."FIELD_GROUP_" IS
'字段分组';

COMMENT ON COLUMN SYS_FIELD."FIELD_LENGTH_" IS
'字段长度';

COMMENT ON COLUMN SYS_FIELD."PRECISION_" IS
'字段精度';

COMMENT ON COLUMN SYS_FIELD."SN_" IS
'字段序号';

COMMENT ON COLUMN SYS_FIELD."COLSPAN_" IS
'跨列数';

COMMENT ON COLUMN SYS_FIELD."FIELD_CAT_" IS
'字段分类
FIELD_COMMON=普通字段
FIELD_PK=主键字段
FIELD_RELATION=关系字段
';

COMMENT ON COLUMN SYS_FIELD."RELATION_TYPE_" IS
'OneToMany
ManyToOne
OneToOne
ManyToMany';

COMMENT ON COLUMN SYS_FIELD.EDIT_RIGHT_ IS
'编辑权限';

COMMENT ON COLUMN SYS_FIELD.ADD_RIGHT_ IS
'添加权限';

COMMENT ON COLUMN SYS_FIELD."IS_HIDDEN_" IS
'是否隐藏';

COMMENT ON COLUMN SYS_FIELD."IS_READABLE_" IS
'是否只读';

COMMENT ON COLUMN SYS_FIELD."IS_REQUIRED_" IS
'是否必须';

COMMENT ON COLUMN SYS_FIELD."IS_DISABLED_" IS
'是否禁用';

COMMENT ON COLUMN SYS_FIELD."ALLOW_GROUP_" IS
'是否允许分组';

COMMENT ON COLUMN SYS_FIELD."ALLOW_SUM_" IS
'是否允许统计';

COMMENT ON COLUMN SYS_FIELD."IS_DEFAULT_COL_" IS
'是否缺省显示列';

COMMENT ON COLUMN SYS_FIELD."IS_QUERY_COL_" IS
'是否缺省查询列';

COMMENT ON COLUMN SYS_FIELD."DEF_VALUE_" IS
'缺省值';

COMMENT ON COLUMN SYS_FIELD."REMARK_" IS
'备注';

COMMENT ON COLUMN SYS_FIELD."SHOW_NAV_TREE_" IS
'是否在导航树上展示';

COMMENT ON COLUMN SYS_FIELD."DB_FIELD_NAME_" IS
'数据库字段名';

COMMENT ON COLUMN SYS_FIELD."DB_FIELD_FORMULA_" IS
'数据库字段公式';

COMMENT ON COLUMN SYS_FIELD."ALLOW_EXCEL_INSERT_" IS
'是否允许Excel插入';

COMMENT ON COLUMN SYS_FIELD."ALLOW_EXCEL_EDIT_" IS
'是否允许Excel编辑';

COMMENT ON COLUMN SYS_FIELD."HAS_ATTACH_" IS
'是否允许有附件';

COMMENT ON COLUMN SYS_FIELD."IS_CHAR_CAT_" IS
'是否图表分类';

COMMENT ON COLUMN SYS_FIELD."IS_USER_DEF_" IS
'用户定义字段
当为用户定义字段时，其展示方式则由JS上的字段展示控制';

COMMENT ON COLUMN SYS_FIELD."LINK_ADD_MODE_" IS
'关联字段值新增方式，只对关联的字段才有效
有三种值，
WINDOW=通过弹出对话框进行新增加
SELECT=通过弹出窗口进行选择
INNER=通过在列表中进行编辑增加处理';

COMMENT ON COLUMN SYS_FIELD.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_FIELD.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_FIELD.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_FIELD.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_FILE                                              */
/*==============================================================*/
CREATE TABLE SYS_FILE  (
   FILE_ID_             VARCHAR2(64)                    NOT NULL,
   TYPE_ID_             VARCHAR2(64),
   FILE_NAME_           VARCHAR2(100)                   NOT NULL,
   NEW_FNAME_           VARCHAR2(100),
   PATH_                VARCHAR2(255)                   NOT NULL,
   THUMBNAIL_           VARCHAR2(120),
   EXT_                 VARCHAR2(20),
   MINE_TYPE_           VARCHAR2(50),
   DESC_                VARCHAR2(255),
   TOTAL_BYTES_         INTEGER,
   DEL_STATUS_          VARCHAR2(20),
   MODULE_ID_           VARCHAR2(64),
   RECORD_ID_           VARCHAR2(64),
   FROM_                VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_FILE PRIMARY KEY (FILE_ID_)
);

COMMENT ON TABLE SYS_FILE IS
'系统附件';

COMMENT ON COLUMN SYS_FILE.TYPE_ID_ IS
'分类ID';

COMMENT ON COLUMN SYS_FILE.FILE_NAME_ IS
'文件名';

COMMENT ON COLUMN SYS_FILE.NEW_FNAME_ IS
'新文件名';

COMMENT ON COLUMN SYS_FILE.PATH_ IS
'文件路径';

COMMENT ON COLUMN SYS_FILE.THUMBNAIL_ IS
'图片缩略图';

COMMENT ON COLUMN SYS_FILE.EXT_ IS
'扩展名';

COMMENT ON COLUMN SYS_FILE.MINE_TYPE_ IS
'附件类型';

COMMENT ON COLUMN SYS_FILE.DESC_ IS
'说明';

COMMENT ON COLUMN SYS_FILE.TOTAL_BYTES_ IS
'总字节数';

COMMENT ON COLUMN SYS_FILE.DEL_STATUS_ IS
'删除标识';

COMMENT ON COLUMN SYS_FILE.MODULE_ID_ IS
'模块ID';

COMMENT ON COLUMN SYS_FILE.RECORD_ID_ IS
'记录ID';

COMMENT ON COLUMN SYS_FILE.FROM_ IS
'来源类型
APPLICATION=应用级上传类型
SELF=个性上传';

COMMENT ON COLUMN SYS_FILE.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_FILE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_FILE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_FILE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_FILE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_FORM_FIELD                                        */
/*==============================================================*/
CREATE TABLE SYS_FORM_FIELD  (
   FORM_FIELD_ID_       VARCHAR2(64)                    NOT NULL,
   GROUP_ID_            VARCHAR2(64),
   "FIELD_ID_"          VARCHAR2(64),
   "FIELD_NAME_"        VARCHAR2(50)                    NOT NULL,
   "FIELD_LABEL_"       VARCHAR2(64)                    NOT NULL,
   SN_                  INTEGER                         NOT NULL,
   HEIGHT_              INTEGER,
   WIDTH_               INTEGER,
   COLSPAN_             INTEGER,
   JSON_CONF_           CLOB,
   COMP_TYPE_           VARCHAR2(50),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_FORM_FIELD PRIMARY KEY (FORM_FIELD_ID_)
);

COMMENT ON TABLE SYS_FORM_FIELD IS
'表单组内字段';

COMMENT ON COLUMN SYS_FORM_FIELD.FORM_FIELD_ID_ IS
'表单字段ID';

COMMENT ON COLUMN SYS_FORM_FIELD.GROUP_ID_ IS
'分组ID';

COMMENT ON COLUMN SYS_FORM_FIELD."FIELD_ID_" IS
'字段ID';

COMMENT ON COLUMN SYS_FORM_FIELD.SN_ IS
'序号';

COMMENT ON COLUMN SYS_FORM_FIELD.HEIGHT_ IS
'高';

COMMENT ON COLUMN SYS_FORM_FIELD.WIDTH_ IS
'宽';

COMMENT ON COLUMN SYS_FORM_FIELD.COLSPAN_ IS
'列跨度';

COMMENT ON COLUMN SYS_FORM_FIELD.JSON_CONF_ IS
'其他JSON设置';

COMMENT ON COLUMN SYS_FORM_FIELD.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_FORM_FIELD.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_FORM_FIELD.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_FORM_FIELD.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_FORM_FIELD.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_FORM_GROUP                                        */
/*==============================================================*/
CREATE TABLE SYS_FORM_GROUP  (
   GROUP_ID_            VARCHAR2(64)                    NOT NULL,
   "FORM_SCHEMA_ID_"    VARCHAR2(64),
   "TITLE_"             VARCHAR2(50)                    NOT NULL,
   "SN_"                INTEGER                         NOT NULL,
   "DISPLAY_MODE_"      VARCHAR2(50),
   "COLLAPSIBLE_"       VARCHAR2(8),
   "COLLAPSED_"         VARCHAR2(8),
   "SUB_MODEL_ID_"      VARCHAR2(64),
   "JSON_CONFIG_"       CLOB,
   "COL_NUMS_"          INTEGER,
   CONSTRAINT PK_SYS_FORM_GROUP PRIMARY KEY (GROUP_ID_)
);

COMMENT ON TABLE SYS_FORM_GROUP IS
'系统表单字段分组';

COMMENT ON COLUMN SYS_FORM_GROUP."FORM_SCHEMA_ID_" IS
'表单方案ID';

COMMENT ON COLUMN SYS_FORM_GROUP."TITLE_" IS
'组标题';

COMMENT ON COLUMN SYS_FORM_GROUP."SN_" IS
'序号';

COMMENT ON COLUMN SYS_FORM_GROUP."DISPLAY_MODE_" IS
'显示模式';

COMMENT ON COLUMN SYS_FORM_GROUP."COLLAPSIBLE_" IS
'是否可收缩';

COMMENT ON COLUMN SYS_FORM_GROUP."COLLAPSED_" IS
'默认收缩';

COMMENT ON COLUMN SYS_FORM_GROUP."SUB_MODEL_ID_" IS
'子模块ID';

COMMENT ON COLUMN SYS_FORM_GROUP."JSON_CONFIG_" IS
'其他JSON配置';

COMMENT ON COLUMN SYS_FORM_GROUP."COL_NUMS_" IS
'列数';

/*==============================================================*/
/* Table: SYS_FORM_SCHEMA                                       */
/*==============================================================*/
CREATE TABLE SYS_FORM_SCHEMA  (
   "FORM_SCHEMA_ID_"    VARCHAR2(64)                    NOT NULL,
   "MODULE_ID_"         VARCHAR2(64),
   "SCHEMA_NAME_"       VARCHAR2(64)                    NOT NULL,
   "TITLE_"             VARCHAR2(50),
   "SN_"                INTEGER                         NOT NULL,
   "IS_SYSTEM_"         VARCHAR2(8)                     NOT NULL,
   "SCHEMA_KEY_"        VARCHAR2(50)                    NOT NULL,
   "WIN_WIDTH_"         INTEGER                         NOT NULL,
   "WIN_HEIGHT_"        INTEGER                         NOT NULL,
   "COL_NUMS_"          INTEGER                         NOT NULL,
   "DISPLAY_MODE_"      VARCHAR2(50)                    NOT NULL,
   "JSON_CONFIG_"       CLOB,
   CONSTRAINT PK_SYS_FORM_SCHEMA PRIMARY KEY ("FORM_SCHEMA_ID_")
);

COMMENT ON TABLE SYS_FORM_SCHEMA IS
'表单方案';

COMMENT ON COLUMN SYS_FORM_SCHEMA."FORM_SCHEMA_ID_" IS
'表单方案ID';

COMMENT ON COLUMN SYS_FORM_SCHEMA."MODULE_ID_" IS
'模块ID';

COMMENT ON COLUMN SYS_FORM_SCHEMA."SCHEMA_NAME_" IS
'方案名称';

COMMENT ON COLUMN SYS_FORM_SCHEMA."TITLE_" IS
'表单标题';

COMMENT ON COLUMN SYS_FORM_SCHEMA."SN_" IS
'方案排序';

COMMENT ON COLUMN SYS_FORM_SCHEMA."IS_SYSTEM_" IS
'是否为系统默认';

COMMENT ON COLUMN SYS_FORM_SCHEMA."SCHEMA_KEY_" IS
'方案Key';

COMMENT ON COLUMN SYS_FORM_SCHEMA."WIN_WIDTH_" IS
'窗口宽';

COMMENT ON COLUMN SYS_FORM_SCHEMA."WIN_HEIGHT_" IS
'窗口高';

COMMENT ON COLUMN SYS_FORM_SCHEMA."COL_NUMS_" IS
'列数';

COMMENT ON COLUMN SYS_FORM_SCHEMA."DISPLAY_MODE_" IS
'显示模式';

COMMENT ON COLUMN SYS_FORM_SCHEMA."JSON_CONFIG_" IS
'其他JSON配置';

/*==============================================================*/
/* Table: SYS_GRID_FIELD                                        */
/*==============================================================*/
CREATE TABLE SYS_GRID_FIELD  (
   "GD_FIELD_ID_"       VARCHAR2(64)                    NOT NULL,
   "FIELD_ID_"          VARCHAR2(64),
   "FIELD_NAME_"        VARCHAR2(50),
   "FIELD_TITLE_"       VARCHAR2(50)                    NOT NULL,
   "GRID_VIEW_ID_"      VARCHAR2(64),
   "PARENT_ID_"         VARCHAR2(64),
   "PATH_"              VARCHAR2(255),
   "ITEM_TYPE_"         VARCHAR2(20),
   "SN_"                INTEGER                         NOT NULL,
   "IS_LOCK_"           VARCHAR2(8),
   "ALLOW_SORT_"        VARCHAR2(8),
   "IS_HIDDEN_"         VARCHAR2(8),
   "ALLOW_SUM_"         VARCHAR2(8),
   "COL_WIDTH_"         INTEGER,
   "IS_EXPORT_"         VARCHAR2(8),
   "FOMART_"            VARCHAR2(250),
   "REMARK_"            CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_GRID_FIELD PRIMARY KEY ("GD_FIELD_ID_")
);

COMMENT ON TABLE SYS_GRID_FIELD IS
'列表视图分组及字段';

COMMENT ON COLUMN SYS_GRID_FIELD."FIELD_ID_" IS
'字段ID';

COMMENT ON COLUMN SYS_GRID_FIELD."GRID_VIEW_ID_" IS
'所属图视图ID
当不属于任何分组时，需要填写该值';

COMMENT ON COLUMN SYS_GRID_FIELD."ITEM_TYPE_" IS
'项类型
GROUP=分组
FIELD=字段';

COMMENT ON COLUMN SYS_GRID_FIELD."SN_" IS
'序号';

COMMENT ON COLUMN SYS_GRID_FIELD."IS_LOCK_" IS
'是否锁定';

COMMENT ON COLUMN SYS_GRID_FIELD."ALLOW_SORT_" IS
'是否允许排序';

COMMENT ON COLUMN SYS_GRID_FIELD."IS_HIDDEN_" IS
'是否隐藏';

COMMENT ON COLUMN SYS_GRID_FIELD."ALLOW_SUM_" IS
'是否允许总计';

COMMENT ON COLUMN SYS_GRID_FIELD."COL_WIDTH_" IS
'列宽';

COMMENT ON COLUMN SYS_GRID_FIELD."IS_EXPORT_" IS
'是否允许导出';

COMMENT ON COLUMN SYS_GRID_FIELD."FOMART_" IS
'格式化';

COMMENT ON COLUMN SYS_GRID_FIELD."REMARK_" IS
'备注';

COMMENT ON COLUMN SYS_GRID_FIELD.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_GRID_FIELD.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_GRID_FIELD.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_GRID_FIELD.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_GRID_FIELD.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_GRID_VIEW                                         */
/*==============================================================*/
CREATE TABLE SYS_GRID_VIEW  (
   "GRID_VIEW_ID_"      VARCHAR2(64)                    NOT NULL,
   "MODULE_ID_"         VARCHAR2(64),
   "NAME_"              VARCHAR2(60)                    NOT NULL,
   "IS_SYSTEM_"         VARCHAR2(8),
   "IS_DEFAULT_"        VARCHAR2(8),
   "ALLOW_EDIT_"        VARCHAR2(8),
   "CLICK_ROW_ACTION_"  VARCHAR2(120),
   "DEF_SORT_FIELD_"    VARCHAR2(50),
   "SN_"                INTEGER                         NOT NULL,
   "REMARK_"            CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_GRID_VIEW PRIMARY KEY ("GRID_VIEW_ID_")
);

COMMENT ON TABLE SYS_GRID_VIEW IS
'列表展示视图';

COMMENT ON COLUMN SYS_GRID_VIEW."MODULE_ID_" IS
'模块ID';

COMMENT ON COLUMN SYS_GRID_VIEW."NAME_" IS
'名称';

COMMENT ON COLUMN SYS_GRID_VIEW."IS_SYSTEM_" IS
'是否系统默认';

COMMENT ON COLUMN SYS_GRID_VIEW."ALLOW_EDIT_" IS
'是否在表格中编辑';

COMMENT ON COLUMN SYS_GRID_VIEW."CLICK_ROW_ACTION_" IS
'点击行动作';

COMMENT ON COLUMN SYS_GRID_VIEW."DEF_SORT_FIELD_" IS
'默认排序';

COMMENT ON COLUMN SYS_GRID_VIEW."SN_" IS
'序号';

COMMENT ON COLUMN SYS_GRID_VIEW."REMARK_" IS
'备注';

COMMENT ON COLUMN SYS_GRID_VIEW.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_GRID_VIEW.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_GRID_VIEW.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_GRID_VIEW.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_GRID_VIEW.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_INST                                              */
/*==============================================================*/
CREATE TABLE SYS_INST  (
   INST_ID_             VARCHAR2(64)                    NOT NULL,
   "NAME_CN_"           VARCHAR2(256)                   NOT NULL,
   "NAME_EN_"           VARCHAR2(256)                   NOT NULL,
   BUS_LICE_NO_         VARCHAR2(50)                    NOT NULL,
   INST_NO_             VARCHAR2(50)                    NOT NULL,
   BUS_LICE_FILE_ID_    VARCHAR2(64),
   "REG_CODE_FILE_ID_"  VARCHAR2(64),
   "DOMAIN_"            VARCHAR2(100)                   NOT NULL,
   "NAME_CN_S_"         VARCHAR2(80),
   "NAME_EN_S_"         VARCHAR2(80),
   "LEGAL_MAN_"         VARCHAR2(64),
   "DESCP_"             CLOB,
   "ADDRESS_"           VARCHAR2(128),
   "PHONE_"             VARCHAR2(30),
   "EMAIL_"             VARCHAR2(255),
   "FAX_"               VARCHAR2(30),
   "CONTRACTOR_"        VARCHAR2(30),
   DS_NAME_             VARCHAR2(64),
   DS_ALIAS_            VARCHAR2(64),
   "HOME_URL_"          VARCHAR2(120),
   "INST_TYPE_"         VARCHAR2(50),
   "STATUS_"            VARCHAR2(30),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_INST PRIMARY KEY (INST_ID_)
);

COMMENT ON TABLE SYS_INST IS
'注册机构';

COMMENT ON COLUMN SYS_INST."NAME_CN_" IS
'公司中文名';

COMMENT ON COLUMN SYS_INST."NAME_EN_" IS
'公司英文名';

COMMENT ON COLUMN SYS_INST.INST_NO_ IS
'机构编码';

COMMENT ON COLUMN SYS_INST.BUS_LICE_FILE_ID_ IS
'公司营业执照图片';

COMMENT ON COLUMN SYS_INST."REG_CODE_FILE_ID_" IS
'组织机构代码证图';

COMMENT ON COLUMN SYS_INST."DOMAIN_" IS
'公司域名
唯一，用户后续的账号均是以此为缀，如公司的域名为abc.com,管理员的账号为admin@abc.com';

COMMENT ON COLUMN SYS_INST."NAME_CN_S_" IS
'公司简称(中文)';

COMMENT ON COLUMN SYS_INST."NAME_EN_S_" IS
'公司简称(英文)';

COMMENT ON COLUMN SYS_INST."LEGAL_MAN_" IS
'公司法人';

COMMENT ON COLUMN SYS_INST."DESCP_" IS
'公司描述';

COMMENT ON COLUMN SYS_INST."ADDRESS_" IS
'地址';

COMMENT ON COLUMN SYS_INST."PHONE_" IS
'联系电话';

COMMENT ON COLUMN SYS_INST."FAX_" IS
'传真';

COMMENT ON COLUMN SYS_INST."CONTRACTOR_" IS
'联系人';

COMMENT ON COLUMN SYS_INST.DS_NAME_ IS
'数据源名称';

COMMENT ON COLUMN SYS_INST.DS_ALIAS_ IS
'数据源别名';

COMMENT ON COLUMN SYS_INST."INST_TYPE_" IS
'机构类型';

COMMENT ON COLUMN SYS_INST."STATUS_" IS
'状态';

COMMENT ON COLUMN SYS_INST.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_INST.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_INST.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_INST.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_INST.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_INST_TYPE                                         */
/*==============================================================*/
CREATE TABLE SYS_INST_TYPE  (
   TYPE_ID_             VARCHAR2(64)                    NOT NULL,
   TYPE_CODE_           VARCHAR2(50),
   TYPE_NAME_           VARCHAR2(100),
   ENABLED_             VARCHAR2(20),
   IS_DEFAULT_          VARCHAR2(20),
   "HOME_URL_"          VARCHAR2(200),
   DESCP_               VARCHAR2(500),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_INST_TYPE PRIMARY KEY (TYPE_ID_)
);

COMMENT ON TABLE SYS_INST_TYPE IS
'机构类型';

COMMENT ON COLUMN SYS_INST_TYPE.TYPE_ID_ IS
'类型';

COMMENT ON COLUMN SYS_INST_TYPE.TYPE_CODE_ IS
'类型编码';

COMMENT ON COLUMN SYS_INST_TYPE.TYPE_NAME_ IS
'类型名称';

COMMENT ON COLUMN SYS_INST_TYPE.ENABLED_ IS
'是否启用';

COMMENT ON COLUMN SYS_INST_TYPE.IS_DEFAULT_ IS
'是否系统缺省';

COMMENT ON COLUMN SYS_INST_TYPE.DESCP_ IS
'描述';

COMMENT ON COLUMN SYS_INST_TYPE.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_INST_TYPE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_INST_TYPE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_INST_TYPE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_INST_TYPE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_LDAP_CN                                           */
/*==============================================================*/
CREATE TABLE SYS_LDAP_CN  (
   SYS_LDAP_USER_ID_    VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64),
   SYS_LDAP_OU_ID_      VARCHAR2(64),
   USER_ACCOUNT_        VARCHAR2(64),
   USER_CODE_           VARCHAR2(64),
   NAME_                VARCHAR2(64),
   TEL_                 VARCHAR2(64),
   MAIL_                VARCHAR2(512),
   USN_CREATED_         VARCHAR2(64),
   USN_CHANGED_         VARCHAR2(64),
   WHEN_CREATED_        VARCHAR2(64),
   WHEN_CHANGED_        VARCHAR2(64),
   STATUS_              VARCHAR2(64),
   USER_PRINCIPAL_NAME_ VARCHAR2(512),
   DN_                  VARCHAR2(512),
   OC_                  VARCHAR2(512),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_SYS_LDAP_CN PRIMARY KEY (SYS_LDAP_USER_ID_)
);

COMMENT ON TABLE SYS_LDAP_CN IS
'SYS_LDAP_CN【LADP用户】';

COMMENT ON COLUMN SYS_LDAP_CN.SYS_LDAP_USER_ID_ IS
'LDAP用户（主键）';

COMMENT ON COLUMN SYS_LDAP_CN.SYS_LDAP_OU_ID_ IS
'组织单元（主键）';

COMMENT ON COLUMN SYS_LDAP_CN.USER_ACCOUNT_ IS
'账户';

COMMENT ON COLUMN SYS_LDAP_CN.USER_CODE_ IS
'用户编号';

COMMENT ON COLUMN SYS_LDAP_CN.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_LDAP_CN.TEL_ IS
'电话';

COMMENT ON COLUMN SYS_LDAP_CN.MAIL_ IS
'邮件';

COMMENT ON COLUMN SYS_LDAP_CN.USN_CREATED_ IS
'USN_CREATED';

COMMENT ON COLUMN SYS_LDAP_CN.USN_CHANGED_ IS
'USN_CHANGED';

COMMENT ON COLUMN SYS_LDAP_CN.WHEN_CREATED_ IS
'LDAP创建时间';

COMMENT ON COLUMN SYS_LDAP_CN.WHEN_CHANGED_ IS
'LDAP更新时间';

COMMENT ON COLUMN SYS_LDAP_CN.STATUS_ IS
'状态';

COMMENT ON COLUMN SYS_LDAP_CN.USER_PRINCIPAL_NAME_ IS
'用户主要名称';

COMMENT ON COLUMN SYS_LDAP_CN.DN_ IS
'区分名';

COMMENT ON COLUMN SYS_LDAP_CN.OC_ IS
'对象类型';

COMMENT ON COLUMN SYS_LDAP_CN.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN SYS_LDAP_CN.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_LDAP_CN.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_LDAP_CN.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_LDAP_CN.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: SYS_LDAP_CONFIG                                       */
/*==============================================================*/
CREATE TABLE SYS_LDAP_CONFIG  (
   SYS_LDAP_CONFIG_ID_  VARCHAR2(64)                    NOT NULL,
   STATUS_              VARCHAR2(64),
   STATUS_CN_           VARCHAR2(64),
   DN_BASE_             VARCHAR2(1024),
   DN_DATUM_            VARCHAR2(1024),
   URL_                 VARCHAR2(1024),
   ACCOUNT_             VARCHAR2(64),
   PASSWORD_            VARCHAR2(64),
   DEPT_FILTER_         VARCHAR2(1024),
   USER_FILTER_         VARCHAR2(1024),
   ATT_USER_NO_         VARCHAR2(64),
   ATT_USER_ACC_        VARCHAR2(64),
   ATT_USER_NAME_       VARCHAR2(64),
   ATT_USER_PWD_        VARCHAR2(1024),
   ATT_USER_TEL_        VARCHAR2(64),
   ATT_USER_MAIL_       VARCHAR2(64),
   ATT_DEPT_NAME_       VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_SYS_LDAP_CONFIG PRIMARY KEY (SYS_LDAP_CONFIG_ID_)
);

COMMENT ON COLUMN SYS_LDAP_CONFIG.SYS_LDAP_CONFIG_ID_ IS
'LDAP配置(主键)';

COMMENT ON COLUMN SYS_LDAP_CONFIG.STATUS_ IS
'状态';

COMMENT ON COLUMN SYS_LDAP_CONFIG.STATUS_CN_ IS
'状态';

COMMENT ON COLUMN SYS_LDAP_CONFIG.DN_BASE_ IS
'基本DN';

COMMENT ON COLUMN SYS_LDAP_CONFIG.DN_DATUM_ IS
'基准DN';

COMMENT ON COLUMN SYS_LDAP_CONFIG.URL_ IS
'地址';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ACCOUNT_ IS
'账号名称';

COMMENT ON COLUMN SYS_LDAP_CONFIG.PASSWORD_ IS
'密码';

COMMENT ON COLUMN SYS_LDAP_CONFIG.DEPT_FILTER_ IS
'部门过滤器';

COMMENT ON COLUMN SYS_LDAP_CONFIG.USER_FILTER_ IS
'用户过滤器';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ATT_USER_NO_ IS
'用户编号属性';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ATT_USER_ACC_ IS
'用户账户属性';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ATT_USER_NAME_ IS
'用户名称属性';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ATT_USER_PWD_ IS
'用户密码属性';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ATT_USER_TEL_ IS
'用户电话属性';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ATT_USER_MAIL_ IS
'用户邮件属性';

COMMENT ON COLUMN SYS_LDAP_CONFIG.ATT_DEPT_NAME_ IS
'部门名称属性';

COMMENT ON COLUMN SYS_LDAP_CONFIG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN SYS_LDAP_CONFIG.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_LDAP_CONFIG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_LDAP_CONFIG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_LDAP_CONFIG.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: SYS_LDAP_LOG                                          */
/*==============================================================*/
CREATE TABLE SYS_LDAP_LOG  (
   LOG_ID_              VARCHAR2(64)                    NOT NULL,
   LOG_NAME_            VARCHAR2(256),
   CONTENT_             CLOB,
   START_TIME_          TIMESTAMP,
   END_TIME_            TIMESTAMP,
   RUN_TIME_            INTEGER,
   STATUS_              VARCHAR2(64),
   SYNC_TYPE_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_SYS_LDAP_LOG PRIMARY KEY (LOG_ID_)
);

COMMENT ON TABLE SYS_LDAP_LOG IS
'SYS_LDAP_LOG【LDAP同步日志】
';

COMMENT ON COLUMN SYS_LDAP_LOG.LOG_ID_ IS
'日志主键';

COMMENT ON COLUMN SYS_LDAP_LOG.LOG_NAME_ IS
'日志名称';

COMMENT ON COLUMN SYS_LDAP_LOG.CONTENT_ IS
'日志内容';

COMMENT ON COLUMN SYS_LDAP_LOG.START_TIME_ IS
'开始时间';

COMMENT ON COLUMN SYS_LDAP_LOG.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN SYS_LDAP_LOG.RUN_TIME_ IS
'持续时间';

COMMENT ON COLUMN SYS_LDAP_LOG.STATUS_ IS
'状态';

COMMENT ON COLUMN SYS_LDAP_LOG.SYNC_TYPE_ IS
'同步类型';

COMMENT ON COLUMN SYS_LDAP_LOG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN SYS_LDAP_LOG.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_LDAP_LOG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_LDAP_LOG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_LDAP_LOG.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: SYS_LDAP_OU                                           */
/*==============================================================*/
CREATE TABLE SYS_LDAP_OU  (
   SYS_LDAP_OU_ID_      VARCHAR2(64)                    NOT NULL,
   GROUP_ID_            VARCHAR2(64),
   SN_                  INTEGER,
   DEPTH_               INTEGER,
   PATH_                VARCHAR2(1024),
   PARENT_ID_           VARCHAR2(64),
   STATUS_              VARCHAR2(64),
   OU_                  VARCHAR2(512),
   NAME_                VARCHAR2(512),
   DN_                  VARCHAR2(512),
   OC_                  VARCHAR2(512),
   USN_CREATED_         VARCHAR2(64),
   USN_CHANGED_         VARCHAR2(64),
   WHEN_CREATED_        VARCHAR2(64),
   WHEN_CHANGED_        VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_SYS_LDAP_OU PRIMARY KEY (SYS_LDAP_OU_ID_)
);

COMMENT ON TABLE SYS_LDAP_OU IS
'SYS_LDAP_OU【LDAP组织单元】';

COMMENT ON COLUMN SYS_LDAP_OU.SYS_LDAP_OU_ID_ IS
'组织单元（主键）';

COMMENT ON COLUMN SYS_LDAP_OU.GROUP_ID_ IS
'用户组ID';

COMMENT ON COLUMN SYS_LDAP_OU.SN_ IS
'序号';

COMMENT ON COLUMN SYS_LDAP_OU.DEPTH_ IS
'层次';

COMMENT ON COLUMN SYS_LDAP_OU.PATH_ IS
'路径';

COMMENT ON COLUMN SYS_LDAP_OU.PARENT_ID_ IS
'父目录';

COMMENT ON COLUMN SYS_LDAP_OU.STATUS_ IS
'状态';

COMMENT ON COLUMN SYS_LDAP_OU.OU_ IS
'组织单元';

COMMENT ON COLUMN SYS_LDAP_OU.NAME_ IS
'组织单元名称';

COMMENT ON COLUMN SYS_LDAP_OU.DN_ IS
'区分名';

COMMENT ON COLUMN SYS_LDAP_OU.OC_ IS
'对象类型';

COMMENT ON COLUMN SYS_LDAP_OU.USN_CREATED_ IS
'USN_CREATED';

COMMENT ON COLUMN SYS_LDAP_OU.USN_CHANGED_ IS
'USN_CHANGED';

COMMENT ON COLUMN SYS_LDAP_OU.WHEN_CREATED_ IS
'LDAP创建时间';

COMMENT ON COLUMN SYS_LDAP_OU.WHEN_CHANGED_ IS
'LDAP更新时间';

COMMENT ON COLUMN SYS_LDAP_OU.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN SYS_LDAP_OU.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_LDAP_OU.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_LDAP_OU.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_LDAP_OU.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: SYS_LIST_SOL                                          */
/*==============================================================*/
CREATE TABLE SYS_LIST_SOL  (
   SOL_ID_              VARCHAR2(64)                    NOT NULL,
   KEY_                 VARCHAR2(100)                   NOT NULL,
   NAME_                VARCHAR2(128)                   NOT NULL,
   DESCP_               VARCHAR2(256),
   RIGHT_CONFIGS_       CLOB                            NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_LIST_SOL PRIMARY KEY (SOL_ID_)
);

COMMENT ON TABLE SYS_LIST_SOL IS
'系统列表方案';

COMMENT ON COLUMN SYS_LIST_SOL.SOL_ID_ IS
'解决方案ID';

COMMENT ON COLUMN SYS_LIST_SOL.KEY_ IS
'标识健';

COMMENT ON COLUMN SYS_LIST_SOL.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_LIST_SOL.DESCP_ IS
'描述';

COMMENT ON COLUMN SYS_LIST_SOL.RIGHT_CONFIGS_ IS
'权限配置';

COMMENT ON COLUMN SYS_LIST_SOL.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_LIST_SOL.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN SYS_LIST_SOL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_LIST_SOL.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_LIST_SOL.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_LOG                                               */
/*==============================================================*/
CREATE TABLE SYS_LOG  (
   LOG_ID_              VARCHAR2(64)                    NOT NULL,
   OP_SUBJECT_          VARCHAR2(256)                   NOT NULL,
   OP_DESCP_            CLOB,
   OP_USID_             VARCHAR2(64)                    NOT NULL,
   EXE_CLS_METHOD_      VARCHAR2(256)                   NOT NULL,
   ERR_LOG_             CLOB                            NOT NULL,
   CREATE_TIME_         TIMESTAMP                            NOT NULL,
   CONSTRAINT PK_SYS_LOG PRIMARY KEY (LOG_ID_)
);

COMMENT ON TABLE SYS_LOG IS
'系统日志';

COMMENT ON COLUMN SYS_LOG.LOG_ID_ IS
'日志ID';

COMMENT ON COLUMN SYS_LOG.OP_SUBJECT_ IS
'操作描述';

COMMENT ON COLUMN SYS_LOG.OP_DESCP_ IS
'操作详述';

COMMENT ON COLUMN SYS_LOG.OP_USID_ IS
'操作人ID';

COMMENT ON COLUMN SYS_LOG.EXE_CLS_METHOD_ IS
'执行的详细类及方法';

COMMENT ON COLUMN SYS_LOG.ERR_LOG_ IS
'出错详细日志';

COMMENT ON COLUMN SYS_LOG.CREATE_TIME_ IS
'创建时间';

/*==============================================================*/
/* Table: SYS_LOG_CONF                                          */
/*==============================================================*/
CREATE TABLE SYS_LOG_CONF  (
   CONF_ID_             VARCHAR2(64)                    NOT NULL,
   LEVEL_               VARCHAR2(30)                    NOT NULL,
   PATH_                VARCHAR2(255)                   NOT NULL,
   IS_ENABLED_          VARCHAR2(20)                    NOT NULL,
   CAT_                 VARCHAR2(100)                   NOT NULL,
   CONSTRAINT PK_SYS_LOG_CONF PRIMARY KEY (CONF_ID_)
);

COMMENT ON TABLE SYS_LOG_CONF IS
'日志配置';

COMMENT ON COLUMN SYS_LOG_CONF.CONF_ID_ IS
'配置ID';

COMMENT ON COLUMN SYS_LOG_CONF.LEVEL_ IS
'等级';

COMMENT ON COLUMN SYS_LOG_CONF.PATH_ IS
'包名路径';

COMMENT ON COLUMN SYS_LOG_CONF.IS_ENABLED_ IS
'是否开启';

COMMENT ON COLUMN SYS_LOG_CONF.CAT_ IS
'日志分类';

/*==============================================================*/
/* Table: SYS_MENU                                              */
/*==============================================================*/
CREATE TABLE SYS_MENU  (
   "MENU_ID_"           VARCHAR2(64)                    NOT NULL,
   "SYS_ID_"            VARCHAR2(64),
   "NAME_"              VARCHAR2(60)                    NOT NULL,
   "KEY_"               VARCHAR2(80),
   "FORM_"              VARCHAR2(80),
   "ENTITY_NAME_"       VARCHAR2(100),
   "MODULE_ID_"         VARCHAR2(64),
   "ICON_CLS_"          VARCHAR2(32),
   "IMG_"               VARCHAR2(50),
   "PARENT_ID_"         VARCHAR2(64)                    NOT NULL,
   "DEPTH_"             INTEGER,
   "PATH_"              VARCHAR2(256),
   "SN_"                INTEGER,
   "IS_MGR_"            VARCHAR2(10)                    NOT NULL,
   "URL_"               VARCHAR2(256),
   "SHOW_TYPE_"         VARCHAR2(20),
   "IS_BTN_MENU_"       VARCHAR2(20)                    NOT NULL,
   "CHILDS_"            INTEGER,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_MENU PRIMARY KEY ("MENU_ID_")
);

COMMENT ON TABLE SYS_MENU IS
'菜单项目';

COMMENT ON COLUMN SYS_MENU."SYS_ID_" IS
'所属子系统';

COMMENT ON COLUMN SYS_MENU."NAME_" IS
'菜单名称';

COMMENT ON COLUMN SYS_MENU."KEY_" IS
'菜单Key';

COMMENT ON COLUMN SYS_MENU."FORM_" IS
'实体表单';

COMMENT ON COLUMN SYS_MENU."ENTITY_NAME_" IS
'模块实体名';

COMMENT ON COLUMN SYS_MENU."MODULE_ID_" IS
'模块ID';

COMMENT ON COLUMN SYS_MENU."ICON_CLS_" IS
'图标样式';

COMMENT ON COLUMN SYS_MENU."IMG_" IS
'图标';

COMMENT ON COLUMN SYS_MENU."PARENT_ID_" IS
'上级父ID';

COMMENT ON COLUMN SYS_MENU."DEPTH_" IS
'层次';

COMMENT ON COLUMN SYS_MENU."PATH_" IS
'路径';

COMMENT ON COLUMN SYS_MENU."SN_" IS
'序号';

COMMENT ON COLUMN SYS_MENU."IS_MGR_" IS
'是否为管理菜单，
NO=为租户可访问的菜单 
YES=为平台管理员可访问的菜单';

COMMENT ON COLUMN SYS_MENU."URL_" IS
'访问地址URL';

COMMENT ON COLUMN SYS_MENU."SHOW_TYPE_" IS
'访问方式
 缺省打开
在新窗口打开';

COMMENT ON COLUMN SYS_MENU."IS_BTN_MENU_" IS
'表示是否为按钮菜单
YES=为按钮菜单
NO=非按钮菜单';

COMMENT ON COLUMN SYS_MENU.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_MENU.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_MENU.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_MENU.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_MENU.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_MODULE                                            */
/*==============================================================*/
CREATE TABLE SYS_MODULE  (
   "MODULE_ID_"         VARCHAR2(64)                    NOT NULL,
   "TITLE_"             VARCHAR2(50)                    NOT NULL,
   "DESCP_"             VARCHAR2(50),
   "REQ_URL_"           VARCHAR2(150),
   "ICON_CLS_"          VARCHAR2(20),
   "SHORT_NAME_"        VARCHAR2(20),
   "SYS_ID_"            VARCHAR2(64),
   "TABLE_NAME_"        VARCHAR2(50),
   "ENTITY_NAME_"       VARCHAR2(100),
   "NAMESPACE_"         VARCHAR2(100),
   "PK_FIELD_"          VARCHAR2(50)                    NOT NULL,
   "PK_DB_FIELD_"       VARCHAR2(50),
   "CODE_FIELD_"        VARCHAR2(50),
   "ORDER_FIELD_"       VARCHAR2(50),
   "DATE_FIELD_"        VARCHAR2(50),
   "YEAR_FIELD_"        VARCHAR2(50),
   "MONTH_FIELD_"       VARCHAR2(50),
   "SENSON_FIELD_"      VARCHAR2(50),
   "FILE_FIELD_"        VARCHAR2(50),
   "IS_ENABLED_"        VARCHAR2(6)                     NOT NULL,
   "ALLOW_AUDIT_"       VARCHAR2(6)                     NOT NULL,
   "ALLOW_APPROVE_"     VARCHAR2(6)                     NOT NULL,
   "HAS_ATTACHS_"       VARCHAR2(6)                     NOT NULL,
   "DEF_ORDER_FIELD_"   VARCHAR2(50),
   "SEQ_CODE_"          VARCHAR2(50),
   "HAS_CHART_"         VARCHAR2(6)                     NOT NULL,
   "HELP_HTML_"         CLOB,
   IS_DEFAULT_          VARCHAR2(8),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_MODULE PRIMARY KEY ("MODULE_ID_")
);

COMMENT ON TABLE SYS_MODULE IS
'系统功能模块';

COMMENT ON COLUMN SYS_MODULE."MODULE_ID_" IS
'模块ID';

COMMENT ON COLUMN SYS_MODULE."TITLE_" IS
'模块标题';

COMMENT ON COLUMN SYS_MODULE."DESCP_" IS
'描述';

COMMENT ON COLUMN SYS_MODULE."REQ_URL_" IS
'映射URL地址';

COMMENT ON COLUMN SYS_MODULE."ICON_CLS_" IS
'icon地址样式';

COMMENT ON COLUMN SYS_MODULE."SHORT_NAME_" IS
'简称';

COMMENT ON COLUMN SYS_MODULE."SYS_ID_" IS
'所属子系统';

COMMENT ON COLUMN SYS_MODULE."TABLE_NAME_" IS
'表名';

COMMENT ON COLUMN SYS_MODULE."ENTITY_NAME_" IS
'实体名';

COMMENT ON COLUMN SYS_MODULE."NAMESPACE_" IS
'命名空间';

COMMENT ON COLUMN SYS_MODULE."PK_FIELD_" IS
'主键字段名';

COMMENT ON COLUMN SYS_MODULE."CODE_FIELD_" IS
'编码字段名';

COMMENT ON COLUMN SYS_MODULE."ORDER_FIELD_" IS
'排序字段名';

COMMENT ON COLUMN SYS_MODULE."DATE_FIELD_" IS
'日期字段';

COMMENT ON COLUMN SYS_MODULE."YEAR_FIELD_" IS
'年份字段';

COMMENT ON COLUMN SYS_MODULE."MONTH_FIELD_" IS
'月份字段';

COMMENT ON COLUMN SYS_MODULE."SENSON_FIELD_" IS
'季度字段';

COMMENT ON COLUMN SYS_MODULE."FILE_FIELD_" IS
'文件字段';

COMMENT ON COLUMN SYS_MODULE."IS_ENABLED_" IS
'是否启用';

COMMENT ON COLUMN SYS_MODULE."ALLOW_AUDIT_" IS
'是否审计执行日记';

COMMENT ON COLUMN SYS_MODULE."ALLOW_APPROVE_" IS
'是否启动审批';

COMMENT ON COLUMN SYS_MODULE."HAS_ATTACHS_" IS
'是否有附件';

COMMENT ON COLUMN SYS_MODULE."DEF_ORDER_FIELD_" IS
'缺省排序字段';

COMMENT ON COLUMN SYS_MODULE."SEQ_CODE_" IS
'编码流水键';

COMMENT ON COLUMN SYS_MODULE."HAS_CHART_" IS
'是否有图表';

COMMENT ON COLUMN SYS_MODULE."HELP_HTML_" IS
'帮助内容';

COMMENT ON COLUMN SYS_MODULE.IS_DEFAULT_ IS
'是否系统默认
YES
NO';

COMMENT ON COLUMN SYS_MODULE.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_MODULE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_MODULE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_MODULE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_MODULE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_PRIVATE_PROPERTIES                                */
/*==============================================================*/
CREATE TABLE SYS_PRIVATE_PROPERTIES  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   PRO_ID_              VARCHAR2(64),
   PRI_VALUE_           VARCHAR2(2000),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_PRIVATE_PROPERTIES PRIMARY KEY (ID_)
);

COMMENT ON TABLE SYS_PRIVATE_PROPERTIES IS
'租户参数';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.ID_ IS
'主键';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.PRO_ID_ IS
'参数主键';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.PRI_VALUE_ IS
'参数值';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_PRIVATE_PROPERTIES.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_PROPERTIES                                        */
/*==============================================================*/
CREATE TABLE SYS_PROPERTIES  (
   PRO_ID_              VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64),
   ALIAS_               VARCHAR2(64),
   GLOBAL_              VARCHAR2(64),
   ENCRYPT_             VARCHAR2(64),
   VALUE_               VARCHAR2(2000),
   CATEGORY_            VARCHAR2(100),
   DESCRIPTION_         VARCHAR2(200),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_PROPERTIES PRIMARY KEY (PRO_ID_)
);

COMMENT ON TABLE SYS_PROPERTIES IS
'系统属性表';

COMMENT ON COLUMN SYS_PROPERTIES.PRO_ID_ IS
'属性ID';

COMMENT ON COLUMN SYS_PROPERTIES.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_PROPERTIES.ALIAS_ IS
'别名';

COMMENT ON COLUMN SYS_PROPERTIES.GLOBAL_ IS
'是否全局';

COMMENT ON COLUMN SYS_PROPERTIES.ENCRYPT_ IS
'是否加密';

COMMENT ON COLUMN SYS_PROPERTIES.VALUE_ IS
'属性值';

COMMENT ON COLUMN SYS_PROPERTIES.CATEGORY_ IS
'分类';

COMMENT ON COLUMN SYS_PROPERTIES.DESCRIPTION_ IS
'描述';

COMMENT ON COLUMN SYS_PROPERTIES.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN SYS_PROPERTIES.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN SYS_PROPERTIES.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_PROPERTIES.UPDATE_BY_ IS
'更新人';

COMMENT ON COLUMN SYS_PROPERTIES.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_QUARTZ_LOG                                        */
/*==============================================================*/
CREATE TABLE SYS_QUARTZ_LOG  (
   LOG_ID_              VARCHAR2(64)                    NOT NULL,
   ALIAS_               VARCHAR2(256),
   JOB_NAME_            VARCHAR2(256),
   TRIGGER_NAME_        VARCHAR2(256),
   CONTENT_             CLOB,
   START_TIME_          TIMESTAMP,
   END_TIME_            TIMESTAMP,
   RUN_TIME_            INTEGER,
   STATUS_              VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_QUARTZ_LOG PRIMARY KEY (LOG_ID_)
);

COMMENT ON TABLE SYS_QUARTZ_LOG IS
'定时器日志
';

COMMENT ON COLUMN SYS_QUARTZ_LOG.LOG_ID_ IS
'日志??键ID';

COMMENT ON COLUMN SYS_QUARTZ_LOG.ALIAS_ IS
'任务别名';

COMMENT ON COLUMN SYS_QUARTZ_LOG.JOB_NAME_ IS
'任务名称';

COMMENT ON COLUMN SYS_QUARTZ_LOG.TRIGGER_NAME_ IS
'计划名称';

COMMENT ON COLUMN SYS_QUARTZ_LOG.CONTENT_ IS
'日志内容';

COMMENT ON COLUMN SYS_QUARTZ_LOG.START_TIME_ IS
'开始时间';

COMMENT ON COLUMN SYS_QUARTZ_LOG.END_TIME_ IS
'结束时间';

COMMENT ON COLUMN SYS_QUARTZ_LOG.RUN_TIME_ IS
'持续时间';

COMMENT ON COLUMN SYS_QUARTZ_LOG.STATUS_ IS
'状态STATUS_';

COMMENT ON COLUMN SYS_QUARTZ_LOG.TENANT_ID_ IS
'租用ID';

COMMENT ON COLUMN SYS_QUARTZ_LOG.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_QUARTZ_LOG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_QUARTZ_LOG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_QUARTZ_LOG.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_REPORT                                            */
/*==============================================================*/
CREATE TABLE SYS_REPORT  (
   REP_ID_              VARCHAR2(64)                    NOT NULL,
   "TREE_ID_"           VARCHAR2(64),
   SUBJECT_             VARCHAR2(128)                   NOT NULL,
   KEY_                 VARCHAR2(128),
   DESCP_               VARCHAR2(500)                   NOT NULL,
   FILE_PATH_           VARCHAR2(128)                   NOT NULL,
   SELF_HANDLE_BEAN_    VARCHAR2(100),
   FILE_ID_             VARCHAR2(64),
   IS_DEFAULT_          VARCHAR2(20),
   PARAM_CONFIG_        CLOB,
   ENGINE_              VARCHAR2(30),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   DS_ALIAS_            VARCHAR2(64),
   CONSTRAINT PK_SYS_REPORT PRIMARY KEY (REP_ID_)
);

COMMENT ON TABLE SYS_REPORT IS
'系统报表';

COMMENT ON COLUMN SYS_REPORT.REP_ID_ IS
'报表ID';

COMMENT ON COLUMN SYS_REPORT."TREE_ID_" IS
'分类Id';

COMMENT ON COLUMN SYS_REPORT.SUBJECT_ IS
'标题';

COMMENT ON COLUMN SYS_REPORT.KEY_ IS
'标识key';

COMMENT ON COLUMN SYS_REPORT.DESCP_ IS
'描述';

COMMENT ON COLUMN SYS_REPORT.FILE_PATH_ IS
'报表模块的jasper文件的路径';

COMMENT ON COLUMN SYS_REPORT.SELF_HANDLE_BEAN_ IS
'报表参数自定义处理Bean';

COMMENT ON COLUMN SYS_REPORT.IS_DEFAULT_ IS
'是否缺省
1=缺省
0=非缺省';

COMMENT ON COLUMN SYS_REPORT.PARAM_CONFIG_ IS
'参数配置';

COMMENT ON COLUMN SYS_REPORT.ENGINE_ IS
'报表解析引擎，可同时支持多种报表引擎类型，如
JasperReport
FineReport';

COMMENT ON COLUMN SYS_REPORT.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_REPORT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_REPORT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_REPORT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_REPORT.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN SYS_REPORT.DS_ALIAS_ IS
'数据源';

/*==============================================================*/
/* Table: SYS_RES_AUTH                                          */
/*==============================================================*/
CREATE TABLE SYS_RES_AUTH  (
   AUTH_ID_             VARCHAR2(64)                    NOT NULL,
   RES_ID_              VARCHAR2(64)                    NOT NULL,
   GROUP_ID_            VARCHAR2(64)                    NOT NULL,
   RES_TYPE_            VARCHAR2(80)                    NOT NULL,
   RIGHT_               VARCHAR2(20)                    NOT NULL,
   VISIT_SUB_           VARCHAR2(20),
   CONSTRAINT PK_SYS_RES_AUTH PRIMARY KEY (AUTH_ID_)
);

COMMENT ON TABLE SYS_RES_AUTH IS
'系统资源权限表';

COMMENT ON COLUMN SYS_RES_AUTH.AUTH_ID_ IS
'授权ID';

COMMENT ON COLUMN SYS_RES_AUTH.RES_ID_ IS
'资源主键，其值为不同表的主键';

COMMENT ON COLUMN SYS_RES_AUTH.GROUP_ID_ IS
'用户组ID';

COMMENT ON COLUMN SYS_RES_AUTH.RES_TYPE_ IS
'资源类型
暂时使用表名';

COMMENT ON COLUMN SYS_RES_AUTH.RIGHT_ IS
'权限
ALL=所有权限
GET=查看
DEL=删除
EDIT=编辑
QERY=查询
';

COMMENT ON COLUMN SYS_RES_AUTH.VISIT_SUB_ IS
'YES
NO';

/*==============================================================*/
/* Table: SYS_SEARCH                                            */
/*==============================================================*/
CREATE TABLE SYS_SEARCH  (
   SEARCH_ID_           VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(100)                   NOT NULL,
   ENTITY_NAME_         VARCHAR2(100)                   NOT NULL,
   ENABLED_             VARCHAR2(8)                     NOT NULL,
   IS_DEFAULT_          VARCHAR2(8),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_SEARCH PRIMARY KEY (SEARCH_ID_)
);

COMMENT ON TABLE SYS_SEARCH IS
'高级搜索';

COMMENT ON COLUMN SYS_SEARCH.NAME_ IS
'搜索名称';

COMMENT ON COLUMN SYS_SEARCH.ENTITY_NAME_ IS
'实体名称';

COMMENT ON COLUMN SYS_SEARCH.ENABLED_ IS
'是否启用';

COMMENT ON COLUMN SYS_SEARCH.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_SEARCH.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_SEARCH.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_SEARCH.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_SEARCH.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_SEARCH_ITEM                                       */
/*==============================================================*/
CREATE TABLE SYS_SEARCH_ITEM  (
   ITEM_ID_             VARCHAR2(64)                    NOT NULL,
   SEARCH_ID_           VARCHAR2(64)                    NOT NULL,
   NODE_TYPE_           VARCHAR2(20)                    NOT NULL,
   NODE_TYPE_LABEL_     VARCHAR2(20),
   PARENT_ID_           VARCHAR2(64)                    NOT NULL,
   PATH_                VARCHAR2(256),
   SN_                  INTEGER,
   FIELD_TYPE_          VARCHAR2(20),
   LABEL_               VARCHAR2(100)                   NOT NULL,
   FIELD_OP_            VARCHAR2(20),
   FIELD_OP_LABEL_      VARCHAR2(32),
   FIELD_TITLE_         VARCHAR2(50),
   FIELD_ID_            VARCHAR2(64),
   FIELD_NAME_          VARCHAR2(64),
   FIELD_VAL_           VARCHAR2(80),
   CTL_TYPE_            VARCHAR2(50),
   FORMAT_              VARCHAR2(50),
   PRE_HANDLE_          CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_SEARCH_ITEM PRIMARY KEY (ITEM_ID_)
);

COMMENT ON TABLE SYS_SEARCH_ITEM IS
'搜索条件项';

COMMENT ON COLUMN SYS_SEARCH_ITEM.NODE_TYPE_ IS
'条件类型';

COMMENT ON COLUMN SYS_SEARCH_ITEM.PARENT_ID_ IS
'父ID';

COMMENT ON COLUMN SYS_SEARCH_ITEM.PATH_ IS
'路径';

COMMENT ON COLUMN SYS_SEARCH_ITEM.FIELD_TYPE_ IS
'字段类型';

COMMENT ON COLUMN SYS_SEARCH_ITEM.LABEL_ IS
'条件标签';

COMMENT ON COLUMN SYS_SEARCH_ITEM.FIELD_TITLE_ IS
'字段标签';

COMMENT ON COLUMN SYS_SEARCH_ITEM.FIELD_ID_ IS
'字段ID';

COMMENT ON COLUMN SYS_SEARCH_ITEM.FIELD_NAME_ IS
'字段名称';

COMMENT ON COLUMN SYS_SEARCH_ITEM.FIELD_VAL_ IS
'字段值';

COMMENT ON COLUMN SYS_SEARCH_ITEM.CTL_TYPE_ IS
'控件类型';

COMMENT ON COLUMN SYS_SEARCH_ITEM.FORMAT_ IS
'值格式';

COMMENT ON COLUMN SYS_SEARCH_ITEM.PRE_HANDLE_ IS
'预处理';

COMMENT ON COLUMN SYS_SEARCH_ITEM.TENANT_ID_ IS
'租用ID';

COMMENT ON COLUMN SYS_SEARCH_ITEM.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_SEARCH_ITEM.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_SEARCH_ITEM.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_SEARCH_ITEM.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_SEQ_ID                                            */
/*==============================================================*/
CREATE TABLE SYS_SEQ_ID  (
   SEQ_ID_              VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(80)                    NOT NULL,
   ALIAS_               VARCHAR2(50),
   CUR_DATE_            TIMESTAMP,
   RULE_                VARCHAR2(100)                   NOT NULL,
   RULE_CONF_           VARCHAR2(512),
   INIT_VAL_            INTEGER,
   GEN_TYPE_            VARCHAR2(20),
   LEN_                 INTEGER,
   CUR_VAL              INTEGER,
   STEP_                SMALLINT,
   MEMO_                VARCHAR2(512),
   IS_DEFAULT_          VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_SEQ_ID PRIMARY KEY (SEQ_ID_)
);

COMMENT ON TABLE SYS_SEQ_ID IS
'系统流水号';

COMMENT ON COLUMN SYS_SEQ_ID.SEQ_ID_ IS
'流水号ID';

COMMENT ON COLUMN SYS_SEQ_ID.NAME_ IS
'名称';

COMMENT ON COLUMN SYS_SEQ_ID.ALIAS_ IS
'别名';

COMMENT ON COLUMN SYS_SEQ_ID.CUR_DATE_ IS
'当前日期';

COMMENT ON COLUMN SYS_SEQ_ID.RULE_ IS
'规则';

COMMENT ON COLUMN SYS_SEQ_ID.RULE_CONF_ IS
'规则配置';

COMMENT ON COLUMN SYS_SEQ_ID.INIT_VAL_ IS
'初始值';

COMMENT ON COLUMN SYS_SEQ_ID.GEN_TYPE_ IS
'生成方式
DAY=每天
WEEK=每周
MONTH=每月
YEAR=每年
AUTO=一直增长';

COMMENT ON COLUMN SYS_SEQ_ID.LEN_ IS
'流水号长度';

COMMENT ON COLUMN SYS_SEQ_ID.CUR_VAL IS
'当前值';

COMMENT ON COLUMN SYS_SEQ_ID.STEP_ IS
'步长';

COMMENT ON COLUMN SYS_SEQ_ID.MEMO_ IS
'备注';

COMMENT ON COLUMN SYS_SEQ_ID.IS_DEFAULT_ IS
'系统缺省
YES
NO';

COMMENT ON COLUMN SYS_SEQ_ID.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_SEQ_ID.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_SEQ_ID.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_SEQ_ID.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_SEQ_ID.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_SUBSYS                                            */
/*==============================================================*/
CREATE TABLE SYS_SUBSYS  (
   "SYS_ID_"            VARCHAR2(64)                    NOT NULL,
   "NAME_"              VARCHAR2(80)                    NOT NULL,
   "KEY_"               VARCHAR2(64)                    NOT NULL,
   "LOGO_"              VARCHAR2(120),
   "IS_DEFAULT_"        VARCHAR2(12)                    NOT NULL,
   "HOME_URL_"          VARCHAR2(120),
   "STATUS_"            VARCHAR2(20)                    NOT NULL,
   "DESCP_"             VARCHAR2(256),
   ICON_CLS_            VARCHAR2(50),
   SN_                  INTEGER,
   "INST_TYPE_"         VARCHAR2(50),
   IS_SAAS_             VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_SUBSYS PRIMARY KEY ("SYS_ID_")
);

COMMENT ON TABLE SYS_SUBSYS IS
'子系统';

COMMENT ON COLUMN SYS_SUBSYS."NAME_" IS
'系统名称';

COMMENT ON COLUMN SYS_SUBSYS."KEY_" IS
'系统Key';

COMMENT ON COLUMN SYS_SUBSYS."LOGO_" IS
'系统Logo';

COMMENT ON COLUMN SYS_SUBSYS."IS_DEFAULT_" IS
'是否缺省';

COMMENT ON COLUMN SYS_SUBSYS."HOME_URL_" IS
'首页地址';

COMMENT ON COLUMN SYS_SUBSYS."STATUS_" IS
'状态
YES/NO';

COMMENT ON COLUMN SYS_SUBSYS."DESCP_" IS
'描述';

COMMENT ON COLUMN SYS_SUBSYS.ICON_CLS_ IS
'图标样式';

COMMENT ON COLUMN SYS_SUBSYS.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_SUBSYS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_SUBSYS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_SUBSYS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_SUBSYS.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_TEMPLATE                                          */
/*==============================================================*/
CREATE TABLE SYS_TEMPLATE  (
   TEMP_ID_             VARCHAR2(64)                    NOT NULL,
   "TREE_ID_"           VARCHAR2(64),
   NAME_                VARCHAR2(80)                    NOT NULL,
   KEY_                 VARCHAR2(50)                    NOT NULL,
   CAT_KEY_             VARCHAR2(64)                    NOT NULL,
   IS_DEFAULT_          VARCHAR2(20)                    NOT NULL,
   CONTENT_             CLOB                            NOT NULL,
   DESCP                VARCHAR2(500),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_TEMPLATE PRIMARY KEY (TEMP_ID_)
);

COMMENT ON TABLE SYS_TEMPLATE IS
'系统模板';

COMMENT ON COLUMN SYS_TEMPLATE.TEMP_ID_ IS
'模板ID';

COMMENT ON COLUMN SYS_TEMPLATE."TREE_ID_" IS
'分类Id';

COMMENT ON COLUMN SYS_TEMPLATE.NAME_ IS
'模板名称';

COMMENT ON COLUMN SYS_TEMPLATE.KEY_ IS
'模板KEY';

COMMENT ON COLUMN SYS_TEMPLATE.CAT_KEY_ IS
'模板分类Key';

COMMENT ON COLUMN SYS_TEMPLATE.IS_DEFAULT_ IS
'是否系统缺省';

COMMENT ON COLUMN SYS_TEMPLATE.CONTENT_ IS
'模板内容';

COMMENT ON COLUMN SYS_TEMPLATE.DESCP IS
'模板描述';

COMMENT ON COLUMN SYS_TEMPLATE.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_TEMPLATE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_TEMPLATE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_TEMPLATE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_TEMPLATE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_TREE                                              */
/*==============================================================*/
CREATE TABLE SYS_TREE  (
   "TREE_ID_"           VARCHAR2(64)                    NOT NULL,
   "NAME_"              VARCHAR2(128)                   NOT NULL,
   "PATH_"              VARCHAR2(1024),
   "DEPTH_"             INTEGER                         NOT NULL,
   "PARENT_ID_"         VARCHAR2(64),
   "KEY_"               VARCHAR2(64)                    NOT NULL,
   "CODE_"              VARCHAR2(50),
   "DESCP_"             VARCHAR2(512),
   "CAT_KEY_"           VARCHAR2(64)                    NOT NULL,
   "SN_"                INTEGER                         NOT NULL,
   "DATA_SHOW_TYPE_"    VARCHAR2(20),
   CHILDS_              INTEGER,
   USER_ID_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_TREE PRIMARY KEY ("TREE_ID_")
);

COMMENT ON TABLE SYS_TREE IS
'系统分类树
用于显示树层次结构的分类
可以允许任何层次结构';

COMMENT ON COLUMN SYS_TREE."TREE_ID_" IS
'分类Id';

COMMENT ON COLUMN SYS_TREE."NAME_" IS
'名称';

COMMENT ON COLUMN SYS_TREE."PATH_" IS
'路径';

COMMENT ON COLUMN SYS_TREE."DEPTH_" IS
'层次';

COMMENT ON COLUMN SYS_TREE."PARENT_ID_" IS
'父节点';

COMMENT ON COLUMN SYS_TREE."KEY_" IS
'节点的分类Key';

COMMENT ON COLUMN SYS_TREE."CODE_" IS
'同级编码';

COMMENT ON COLUMN SYS_TREE."DESCP_" IS
'描述';

COMMENT ON COLUMN SYS_TREE."CAT_KEY_" IS
'系统树分类key';

COMMENT ON COLUMN SYS_TREE."SN_" IS
'序号';

COMMENT ON COLUMN SYS_TREE."DATA_SHOW_TYPE_" IS
'数据项展示类型
默认为:FLAT=平铺类型
TREE=树类型';

COMMENT ON COLUMN SYS_TREE.USER_ID_ IS
'用户ID
树所属的用户ID,可空';

COMMENT ON COLUMN SYS_TREE.TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN SYS_TREE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_TREE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_TREE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_TREE.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: SYS_TREE_CAT                                          */
/*==============================================================*/
CREATE TABLE SYS_TREE_CAT  (
   "CAT_ID_"            VARCHAR2(64)                    NOT NULL,
   "KEY_"               VARCHAR2(64)                    NOT NULL,
   "NAME_"              VARCHAR2(64)                    NOT NULL,
   "SN_"                INTEGER,
   "DESCP_"             VARCHAR2(255),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_SYS_TREE_CAT PRIMARY KEY ("CAT_ID_")
);

COMMENT ON TABLE SYS_TREE_CAT IS
'系统树分类类型';

COMMENT ON COLUMN SYS_TREE_CAT."KEY_" IS
'分类Key';

COMMENT ON COLUMN SYS_TREE_CAT."NAME_" IS
'分类名称';

COMMENT ON COLUMN SYS_TREE_CAT."SN_" IS
'序号';

COMMENT ON COLUMN SYS_TREE_CAT."DESCP_" IS
'描述';

COMMENT ON COLUMN SYS_TREE_CAT.TENANT_ID_ IS
'租用用户Id';

COMMENT ON COLUMN SYS_TREE_CAT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN SYS_TREE_CAT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN SYS_TREE_CAT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN SYS_TREE_CAT.UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: TASK_NODE_MSG                                         */
/*==============================================================*/
CREATE TABLE TASK_NODE_MSG  (
   MSG_ID_              VARCHAR2(64)                    NOT NULL,
   SUBJECT_             VARCHAR2(128),
   CONTENT_             VARCHAR2(4000),
   LINKED_              VARCHAR2(512),
   TASK_ID_             VARCHAR2(64),
   TASK_NODE_NAME_      VARCHAR2(128),
   DEPLOY_ID_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_TASK_NODE_MSG PRIMARY KEY (MSG_ID_)
);

COMMENT ON TABLE TASK_NODE_MSG IS
'任务节点消息表(用于第三方接收)

';

COMMENT ON COLUMN TASK_NODE_MSG.MSG_ID_ IS
'消息ID';

COMMENT ON COLUMN TASK_NODE_MSG.SUBJECT_ IS
'主题';

COMMENT ON COLUMN TASK_NODE_MSG.CONTENT_ IS
'内容';

COMMENT ON COLUMN TASK_NODE_MSG.LINKED_ IS
'链接';

COMMENT ON COLUMN TASK_NODE_MSG.TASK_ID_ IS
'任务ID';

COMMENT ON COLUMN TASK_NODE_MSG.TASK_NODE_NAME_ IS
'任务节点名称';

COMMENT ON COLUMN TASK_NODE_MSG.DEPLOY_ID_ IS
'部署ID';

COMMENT ON COLUMN TASK_NODE_MSG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN TASK_NODE_MSG.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN TASK_NODE_MSG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN TASK_NODE_MSG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN TASK_NODE_MSG.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: TASK_TIP_MSG                                          */
/*==============================================================*/
CREATE TABLE TASK_TIP_MSG  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   TASK_ID_             VARCHAR2(64),
   SENDER_ID_           VARCHAR2(64),
   SENDER_TIME_         TIMESTAMP,
   RECEIVER_ID_         VARCHAR2(64),
   SUBJECT_             VARCHAR2(256),
   CONTENT_             VARCHAR2(4000),
   LINKED_              VARCHAR2(512),
   SENDBACK_STATUS_     VARCHAR2(2),
   SHORT_CONTENT_       VARCHAR2(128),
   STATUS_              VARCHAR2(2),
   IMPORTANT_STATUS_    VARCHAR2(2),
   MSG_STATUS_          VARCHAR2(32),
   READ_TIME_           TIMESTAMP,
   GEN_TIME_            TIMESTAMP,
   ISINVALID_           VARCHAR2(64),
   INCALID_TIME_        TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_TASK_TIP_MSG PRIMARY KEY (ID_)
);

COMMENT ON TABLE TASK_TIP_MSG IS
'任务提示消息表(用于第三方接收)

';

COMMENT ON COLUMN TASK_TIP_MSG.ID_ IS
'提示ID';

COMMENT ON COLUMN TASK_TIP_MSG.TASK_ID_ IS
'任务ID';

COMMENT ON COLUMN TASK_TIP_MSG.SENDER_ID_ IS
'发送者ID';

COMMENT ON COLUMN TASK_TIP_MSG.SENDER_TIME_ IS
'发送时间';

COMMENT ON COLUMN TASK_TIP_MSG.RECEIVER_ID_ IS
'接收者ID';

COMMENT ON COLUMN TASK_TIP_MSG.SUBJECT_ IS
'主题';

COMMENT ON COLUMN TASK_TIP_MSG.CONTENT_ IS
'内容';

COMMENT ON COLUMN TASK_TIP_MSG.LINKED_ IS
'链接';

COMMENT ON COLUMN TASK_TIP_MSG.SENDBACK_STATUS_ IS
'返回状态';

COMMENT ON COLUMN TASK_TIP_MSG.SHORT_CONTENT_ IS
'简介';

COMMENT ON COLUMN TASK_TIP_MSG.STATUS_ IS
'状态';

COMMENT ON COLUMN TASK_TIP_MSG.IMPORTANT_STATUS_ IS
'主要状态';

COMMENT ON COLUMN TASK_TIP_MSG.MSG_STATUS_ IS
'消息状态';

COMMENT ON COLUMN TASK_TIP_MSG.READ_TIME_ IS
'阅读时间';

COMMENT ON COLUMN TASK_TIP_MSG.GEN_TIME_ IS
'资料时间';

COMMENT ON COLUMN TASK_TIP_MSG.ISINVALID_ IS
'撤销';

COMMENT ON COLUMN TASK_TIP_MSG.INCALID_TIME_ IS
'撤销时间';

COMMENT ON COLUMN TASK_TIP_MSG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN TASK_TIP_MSG.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN TASK_TIP_MSG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN TASK_TIP_MSG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN TASK_TIP_MSG.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_ENT_AGENT                                          */
/*==============================================================*/
CREATE TABLE WX_ENT_AGENT  (
   ID_                  VARCHAR2(64),
   NAME_                VARCHAR2(100),
   DESCRIPTION_         VARCHAR2(200),
   DOMAIN_              VARCHAR2(64),
   HOME_URL_            VARCHAR2(100),
   ENT_ID_              VARCHAR2(64),
   CORP_ID_             VARCHAR2(64),
   AGENT_ID_            VARCHAR2(64),
   SECRET_              VARCHAR2(64),
   DEFAULT_AGENT_       INTEGER,
   TENANT_ID_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64)
);

COMMENT ON TABLE WX_ENT_AGENT IS
'微信应用';

COMMENT ON COLUMN WX_ENT_AGENT.ID_ IS
'主键';

COMMENT ON COLUMN WX_ENT_AGENT.DOMAIN_ IS
'信任域名';

COMMENT ON COLUMN WX_ENT_AGENT.ENT_ID_ IS
'企业主键';

COMMENT ON COLUMN WX_ENT_AGENT.CORP_ID_ IS
'企业ID';

COMMENT ON COLUMN WX_ENT_AGENT.AGENT_ID_ IS
'应用ID';

COMMENT ON COLUMN WX_ENT_AGENT.SECRET_ IS
'密钥';

COMMENT ON COLUMN WX_ENT_AGENT.DEFAULT_AGENT_ IS
'是否默认';

COMMENT ON COLUMN WX_ENT_AGENT.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN WX_ENT_AGENT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_ENT_AGENT.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN WX_ENT_AGENT.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_ENT_AGENT.UPDATE_BY_ IS
'更新人';

/*==============================================================*/
/* Table: WX_ENT_CORP                                           */
/*==============================================================*/
CREATE TABLE WX_ENT_CORP  (
   ID_                  VARCHAR2(64),
   CORP_ID_             VARCHAR2(64),
   SECRET_              VARCHAR2(64),
   ENABLE_              INTEGER,
   TENANT_ID_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64)
);

COMMENT ON TABLE WX_ENT_CORP IS
'微信企业配置';

COMMENT ON COLUMN WX_ENT_CORP.ID_ IS
'主键';

COMMENT ON COLUMN WX_ENT_CORP.CORP_ID_ IS
'企业ID';

COMMENT ON COLUMN WX_ENT_CORP.SECRET_ IS
'通讯录密钥';

COMMENT ON COLUMN WX_ENT_CORP.ENABLE_ IS
'是否启用企业微信';

COMMENT ON COLUMN WX_ENT_CORP.TENANT_ID_ IS
'租户ID';

COMMENT ON COLUMN WX_ENT_CORP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_ENT_CORP.CREATE_BY_ IS
'创建人';

COMMENT ON COLUMN WX_ENT_CORP.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_ENT_CORP.UPDATE_BY_ IS
'更新人';

/*==============================================================*/
/* Table: WX_P_ARTICLE                                          */
/*==============================================================*/
CREATE TABLE WX_P_ARTICLE  (
   ARTICLE_ID_          VARCHAR2(64)                    NOT NULL,
   AUTHOR_              VARCHAR2(255),
   TITLE_               VARCHAR2(255),
   CONTENT_SOURCE_URL_  VARCHAR2(255),
   CONTENT_             CLOB,
   DIGEST_              VARCHAR2(255),
   SHOW_COVER_PIC_      VARCHAR2(64),
   MATERIAL_ID_         VARCHAR2(64),
   FILE_ID_             VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_ARTICLE PRIMARY KEY (ARTICLE_ID_)
);

COMMENT ON TABLE WX_P_ARTICLE IS
'非SAAS微信文章';

COMMENT ON COLUMN WX_P_ARTICLE.ARTICLE_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_ARTICLE.AUTHOR_ IS
'作者';

COMMENT ON COLUMN WX_P_ARTICLE.TITLE_ IS
'标题';

COMMENT ON COLUMN WX_P_ARTICLE.CONTENT_SOURCE_URL_ IS
'原文章地址';

COMMENT ON COLUMN WX_P_ARTICLE.CONTENT_ IS
'图文消息页面的内容';

COMMENT ON COLUMN WX_P_ARTICLE.DIGEST_ IS
'图文消息的描述';

COMMENT ON COLUMN WX_P_ARTICLE.SHOW_COVER_PIC_ IS
'是否显示封面';

COMMENT ON COLUMN WX_P_ARTICLE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_ARTICLE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_ARTICLE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_ARTICLE.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_ARTICLE.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_CONFIG                                           */
/*==============================================================*/
CREATE TABLE WX_P_CONFIG  (
   CONFIG_ID_           VARCHAR2(64)                    NOT NULL,
   INIT_ID_             VARCHAR2(256),
   TENANT_NAME_CN_      VARCHAR2(256),
   APP_TOKEN_           VARCHAR2(256),
   APP_ID_              VARCHAR2(256),
   APP_SECRET_          VARCHAR2(256),
   ACCESS_TOKEN_        VARCHAR2(256),
   EXPIRES_IN_          VARCHAR2(256),
   EXPIRES_TIME_        INTEGER,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_CONFIG PRIMARY KEY (CONFIG_ID_)
);

COMMENT ON COLUMN WX_P_CONFIG.CONFIG_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_CONFIG.INIT_ID_ IS
'原始ID';

COMMENT ON COLUMN WX_P_CONFIG.TENANT_NAME_CN_ IS
'租户名称';

COMMENT ON COLUMN WX_P_CONFIG.APP_TOKEN_ IS
'应用凭证';

COMMENT ON COLUMN WX_P_CONFIG.APP_ID_ IS
'应用ID';

COMMENT ON COLUMN WX_P_CONFIG.APP_SECRET_ IS
'应用密钥';

COMMENT ON COLUMN WX_P_CONFIG.ACCESS_TOKEN_ IS
'获取到的凭证(访问凭证)';

COMMENT ON COLUMN WX_P_CONFIG.EXPIRES_IN_ IS
'凭证有效时间，单位：秒';

COMMENT ON COLUMN WX_P_CONFIG.EXPIRES_TIME_ IS
'凭证过期时间';

COMMENT ON COLUMN WX_P_CONFIG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_CONFIG.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_CONFIG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_CONFIG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_CONFIG.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_MATERIAL                                         */
/*==============================================================*/
CREATE TABLE WX_P_MATERIAL  (
   MATERIAL_ID_         VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64),
   TYPE_                VARCHAR2(128),
   FILE_ID_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MATERIAL PRIMARY KEY (MATERIAL_ID_)
);

COMMENT ON TABLE WX_P_MATERIAL IS
'非SAAS微信素材';

COMMENT ON COLUMN WX_P_MATERIAL.MATERIAL_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MATERIAL.NAME_ IS
'名称';

COMMENT ON COLUMN WX_P_MATERIAL.TYPE_ IS
'媒体文件类型';

COMMENT ON COLUMN WX_P_MATERIAL.FILE_ID_ IS
'文件id';

COMMENT ON COLUMN WX_P_MATERIAL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_MATERIAL.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MATERIAL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MATERIAL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MATERIAL.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_MENU                                             */
/*==============================================================*/
CREATE TABLE WX_P_MENU  (
   MENU_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64)                    NOT NULL,
   KEY_                 VARCHAR2(80),
   PARENT_ID_           VARCHAR2(64)                    NOT NULL,
   SN_                  INTEGER,
   URL_                 VARCHAR2(256),
   TYPE_                VARCHAR2(20),
   TREE_CODE_           VARCHAR2(256),
   PATH_                VARCHAR2(1000),
   CHILDS_              INTEGER,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MENU PRIMARY KEY (MENU_ID_)
);

COMMENT ON COLUMN WX_P_MENU.MENU_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MENU.NAME_ IS
'菜单名称';

COMMENT ON COLUMN WX_P_MENU.KEY_ IS
'菜单Key';

COMMENT ON COLUMN WX_P_MENU.PARENT_ID_ IS
'上级父ID';

COMMENT ON COLUMN WX_P_MENU.SN_ IS
'序号';

COMMENT ON COLUMN WX_P_MENU.URL_ IS
'访???地址URL';

COMMENT ON COLUMN WX_P_MENU.TYPE_ IS
'访问方式\r\n';

COMMENT ON COLUMN WX_P_MENU.TREE_CODE_ IS
'树的编码';

COMMENT ON COLUMN WX_P_MENU.PATH_ IS
'path';

COMMENT ON COLUMN WX_P_MENU.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_MENU.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MENU.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MENU.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MENU.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_MO_TEXT                                          */
/*==============================================================*/
CREATE TABLE WX_P_MO_TEXT  (
   TEXT_ID_             VARCHAR2(64)                    NOT NULL,
   TO_USER_NAEM__       VARCHAR2(256),
   FROM_USER_NAME_      VARCHAR2(256),
   MSG_TYPE_            VARCHAR2(256),
   CONTENT_             CLOB,
   MSGID_               VARCHAR2(256),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MO_TEXT PRIMARY KEY (TEXT_ID_)
);

COMMENT ON COLUMN WX_P_MO_TEXT.TEXT_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MO_TEXT.TO_USER_NAEM__ IS
'接收?????户openID';

COMMENT ON COLUMN WX_P_MO_TEXT.FROM_USER_NAME_ IS
'发送的用???openID';

COMMENT ON COLUMN WX_P_MO_TEXT.MSG_TYPE_ IS
'消息类型';

COMMENT ON COLUMN WX_P_MO_TEXT.CONTENT_ IS
'内容';

COMMENT ON COLUMN WX_P_MO_TEXT.MSGID_ IS
'消息id';

COMMENT ON COLUMN WX_P_MO_TEXT.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_MO_TEXT.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MO_TEXT.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MO_TEXT.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MO_TEXT.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: WX_P_MSG                                              */
/*==============================================================*/
CREATE TABLE WX_P_MSG  (
   MSG_ID_              VARCHAR2(64)                    NOT NULL,
   AGENTID_             VARCHAR2(64),
   USER_ID_             VARCHAR2(64),
   CONTENT_             CLOB,
   STATUS_              SMALLINT,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MSG PRIMARY KEY (MSG_ID_)
);

COMMENT ON TABLE WX_P_MSG IS
'微信公共号信息';

COMMENT ON COLUMN WX_P_MSG.MSG_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MSG.AGENTID_ IS
'代理应用ID';

COMMENT ON COLUMN WX_P_MSG.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN WX_P_MSG.CONTENT_ IS
'内容';

COMMENT ON COLUMN WX_P_MSG.STATUS_ IS
'状态';

COMMENT ON COLUMN WX_P_MSG.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_MSG.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MSG.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MSG.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MSG.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_MT_ARTICLE                                       */
/*==============================================================*/
CREATE TABLE WX_P_MT_ARTICLE  (
   MT_ARTICLE_ID_       VARCHAR2(64)                    NOT NULL,
   ARTICLE_ID_          VARCHAR2(64),
   THUMB_MEDIA_ID_      VARCHAR2(255),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MT_ARTICLE PRIMARY KEY (MT_ARTICLE_ID_)
);

COMMENT ON TABLE WX_P_MT_ARTICLE IS
'微信下的文章';

COMMENT ON COLUMN WX_P_MT_ARTICLE.MT_ARTICLE_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MT_ARTICLE.THUMB_MEDIA_ID_ IS
'素材ID';

COMMENT ON COLUMN WX_P_MT_ARTICLE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_MT_ARTICLE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MT_ARTICLE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MT_ARTICLE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MT_ARTICLE.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: WX_P_MT_MATERIAL_TEMP                                 */
/*==============================================================*/
CREATE TABLE WX_P_MT_MATERIAL_TEMP  (
   MT_MATERIAL_TEMP_ID_ VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64),
   TYPE_                VARCHAR2(128),
   MEDIA_ID_            VARCHAR2(512),
   CREATED_AT_          VARCHAR2(256),
   MATERIAL_ID_         VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MT_MATERIAL_TEMP PRIMARY KEY (MT_MATERIAL_TEMP_ID_)
);

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.MT_MATERIAL_TEMP_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.NAME_ IS
'名称';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.TYPE_ IS
'???体文件类型';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.MEDIA_ID_ IS
'媒体id';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.CREATED_AT_ IS
'微信创建时间';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.MATERIAL_ID_ IS
'文件id';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MT_MATERIAL_TEMP.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: WX_P_MT_NEWS                                          */
/*==============================================================*/
CREATE TABLE WX_P_MT_NEWS  (
   MT_NEWS_ID_          VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(256),
   MEDIA_ID_            VARCHAR2(256),
   TYPE_                VARCHAR2(128),
   CREATED_AT_          VARCHAR2(256),
   NEWS_ID_             VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MT_NEWS PRIMARY KEY (MT_NEWS_ID_)
);

COMMENT ON COLUMN WX_P_MT_NEWS.MT_NEWS_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MT_NEWS.NAME_ IS
'名称';

COMMENT ON COLUMN WX_P_MT_NEWS.MEDIA_ID_ IS
'媒体文章ID';

COMMENT ON COLUMN WX_P_MT_NEWS.TYPE_ IS
'类型';

COMMENT ON COLUMN WX_P_MT_NEWS.CREATED_AT_ IS
'微信创建时间';

COMMENT ON COLUMN WX_P_MT_NEWS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_MT_NEWS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MT_NEWS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MT_NEWS.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MT_NEWS.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: WX_P_MT_USER_NEWS                                     */
/*==============================================================*/
CREATE TABLE WX_P_MT_USER_NEWS  (
   MT_USER_NEWS_ID_     VARCHAR2(64)                    NOT NULL,
   MEDIA_ID_            VARCHAR2(256),
   USER_NEWS_ID_        VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_MT_USER_NEWS PRIMARY KEY (MT_USER_NEWS_ID_)
);

COMMENT ON COLUMN WX_P_MT_USER_NEWS.MT_USER_NEWS_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_MT_USER_NEWS.MEDIA_ID_ IS
'用于群发的??文消息的media_id';

COMMENT ON COLUMN WX_P_MT_USER_NEWS.USER_NEWS_ID_ IS
'群发的消息类型';

COMMENT ON COLUMN WX_P_MT_USER_NEWS.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_MT_USER_NEWS.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_MT_USER_NEWS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_MT_USER_NEWS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_MT_USER_NEWS.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_NEWS                                             */
/*==============================================================*/
CREATE TABLE WX_P_NEWS  (
   NEWS_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(256),
   TYPE_                VARCHAR2(128),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_WX_P_NEWS PRIMARY KEY (NEWS_ID_)
);

COMMENT ON TABLE WX_P_NEWS IS
'非SAAS微信图文';

COMMENT ON COLUMN WX_P_NEWS.NEWS_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_NEWS.NAME_ IS
'??称';

COMMENT ON COLUMN WX_P_NEWS.TYPE_ IS
'类型';

COMMENT ON COLUMN WX_P_NEWS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_NEWS.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_NEWS.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_NEWS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_NEWS.CREATE_TIME_ IS
'创建时间';

/*==============================================================*/
/* Table: WX_P_NEWS_ARTICLE                                     */
/*==============================================================*/
CREATE TABLE WX_P_NEWS_ARTICLE  (
   NEWS_ARTICLE_ID_     VARCHAR2(64)                    NOT NULL,
   SN_                  INTEGER,
   NEWS_ID_             VARCHAR2(64),
   ARTICLE_ID_          VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_NEWS_ARTICLE PRIMARY KEY (NEWS_ARTICLE_ID_)
);

COMMENT ON TABLE WX_P_NEWS_ARTICLE IS
'非SAAS微信图文与文章';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.NEWS_ARTICLE_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.SN_ IS
'序号';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.NEWS_ID_ IS
'图文ID';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.ARTICLE_ID_ IS
'文章ID';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_NEWS_ARTICLE.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: WX_P_SAAS_ARTICLE                                     */
/*==============================================================*/
CREATE TABLE WX_P_SAAS_ARTICLE  (
   ARTICLE_ID_          VARCHAR2(64)                    NOT NULL,
   AUTHOR_              VARCHAR2(255),
   TITLE_               VARCHAR2(255),
   CONTENT_SOURCE_URL_  VARCHAR2(255),
   CONTENT_             CLOB,
   DIGEST_              VARCHAR2(255),
   SHOW_COVER_PIC_      VARCHAR2(64),
   MATERIAL_ID_         VARCHAR2(64),
   FILE_ID_             VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_SAAS_ARTICLE PRIMARY KEY (ARTICLE_ID_)
);

COMMENT ON TABLE WX_P_SAAS_ARTICLE IS
'微信文章(SAAS功能)';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.ARTICLE_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.AUTHOR_ IS
'作者';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.TITLE_ IS
'标题';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.CONTENT_SOURCE_URL_ IS
'原文章地址';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.CONTENT_ IS
'图文消息页面的内容';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.DIGEST_ IS
'图文消息的描述';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.SHOW_COVER_PIC_ IS
'是否显示封面';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_SAAS_ARTICLE.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_SAAS_MATERIAL                                    */
/*==============================================================*/
CREATE TABLE WX_P_SAAS_MATERIAL  (
   MATERIAL_ID_         VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(64),
   TYPE_                VARCHAR2(128),
   FILE_ID_             VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_SAAS_MATERIAL PRIMARY KEY (MATERIAL_ID_)
);

COMMENT ON TABLE WX_P_SAAS_MATERIAL IS
'微信素材(SAAS功能)';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.MATERIAL_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.NAME_ IS
'名称';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.TYPE_ IS
'媒体文件类型';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.FILE_ID_ IS
'文件id';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_SAAS_MATERIAL.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_SAAS_NEWS                                        */
/*==============================================================*/
CREATE TABLE WX_P_SAAS_NEWS  (
   NEWS_ID_             VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(256),
   TYPE_                VARCHAR2(128),
   TENANT_ID_           VARCHAR2(64),
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_WX_P_SAAS_NEWS PRIMARY KEY (NEWS_ID_)
);

COMMENT ON TABLE WX_P_SAAS_NEWS IS
'微信消息(SAAS功能)';

COMMENT ON COLUMN WX_P_SAAS_NEWS.NEWS_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_SAAS_NEWS.NAME_ IS
'??称';

COMMENT ON COLUMN WX_P_SAAS_NEWS.TYPE_ IS
'类型';

COMMENT ON COLUMN WX_P_SAAS_NEWS.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_SAAS_NEWS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_SAAS_NEWS.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_SAAS_NEWS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_SAAS_NEWS.CREATE_TIME_ IS
'创建时间';

/*==============================================================*/
/* Table: WX_P_SAAS_NEWS_ARTICLE                                */
/*==============================================================*/
CREATE TABLE WX_P_SAAS_NEWS_ARTICLE  (
   NEWS_ARTICLE_ID_     VARCHAR2(64)                    NOT NULL,
   SN_                  INTEGER,
   NEWS_ID_             VARCHAR2(64),
   ARTICLE_ID_          VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_SAAS_NEWS_ARTICLE PRIMARY KEY (NEWS_ARTICLE_ID_)
);

COMMENT ON TABLE WX_P_SAAS_NEWS_ARTICLE IS
'微信消息与文章(SAAS功能)';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.NEWS_ARTICLE_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.SN_ IS
'序号';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.NEWS_ID_ IS
'图文ID';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.ARTICLE_ID_ IS
'文章ID';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_SAAS_NEWS_ARTICLE.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: WX_P_SAAS_USER_NEWS                                   */
/*==============================================================*/
CREATE TABLE WX_P_SAAS_USER_NEWS  (
   USER_NEWS_ID_        VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(256),
   IS_MASS_             VARCHAR2(64),
   TOUSER_              CLOB,
   FULLNAME_            VARCHAR2(64),
   NEWS_ID_             VARCHAR2(64),
   MSGTYPE_             VARCHAR2(128),
   ERRCODE_             VARCHAR2(64),
   STATUS_              SMALLINT,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_SAAS_USER_NEWS PRIMARY KEY (USER_NEWS_ID_)
);

COMMENT ON TABLE WX_P_SAAS_USER_NEWS IS
'微信用户消息(SAAS功能)';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.USER_NEWS_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.NAME_ IS
'图文名称';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.IS_MASS_ IS
'是否群发';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.TOUSER_ IS
'填写图文消息的接收者';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.FULLNAME_ IS
'姓名';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.NEWS_ID_ IS
'图文ID';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.MSGTYPE_ IS
'群发的消息类型';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.ERRCODE_ IS
'错误码';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.STATUS_ IS
'状态';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_SAAS_USER_NEWS.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_USER                                             */
/*==============================================================*/
CREATE TABLE WX_P_USER  (
   ID_                  VARCHAR2(64)                    NOT NULL,
   USER_ID_             VARCHAR2(64),
   FULLNAME_            VARCHAR2(64),
   WEIXIN_ID_           VARCHAR2(64),
   NICK_NAME_           VARCHAR2(64),
   STATUS_              SMALLINT,
   TENANT_ID_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_USER PRIMARY KEY (ID_)
);

COMMENT ON TABLE WX_P_USER IS
'微信公众号用户';

COMMENT ON COLUMN WX_P_USER.ID_ IS
'主键';

COMMENT ON COLUMN WX_P_USER.USER_ID_ IS
'用户ID';

COMMENT ON COLUMN WX_P_USER.FULLNAME_ IS
'姓名';

COMMENT ON COLUMN WX_P_USER.WEIXIN_ID_ IS
'微信号ID';

COMMENT ON COLUMN WX_P_USER.NICK_NAME_ IS
'微信用户昵称';

COMMENT ON COLUMN WX_P_USER.STATUS_ IS
'状态';

COMMENT ON COLUMN WX_P_USER.TENANT_ID_ IS
'租用机构ID';

COMMENT ON COLUMN WX_P_USER.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_USER.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_USER.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_USER.CREATE_BY_ IS
'创建人ID';

/*==============================================================*/
/* Table: WX_P_USER_NEWS                                        */
/*==============================================================*/
CREATE TABLE WX_P_USER_NEWS  (
   USER_NEWS_ID_        VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(256),
   TOUSER_              CLOB,
   NEWS_ID_             VARCHAR2(64),
   MSGTYPE_             VARCHAR2(128),
   UPDATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   CREATE_BY_           VARCHAR2(64),
   TENANT_ID_           VARCHAR2(64),
   CONSTRAINT PK_WX_P_USER_NEWS PRIMARY KEY (USER_NEWS_ID_)
);

COMMENT ON TABLE WX_P_USER_NEWS IS
'非SAAS微信用户图文';

COMMENT ON COLUMN WX_P_USER_NEWS.USER_NEWS_ID_ IS
'主键';

COMMENT ON COLUMN WX_P_USER_NEWS.NAME_ IS
'图文名称';

COMMENT ON COLUMN WX_P_USER_NEWS.TOUSER_ IS
'填写图文消息的接收者';

COMMENT ON COLUMN WX_P_USER_NEWS.NEWS_ID_ IS
'图文ID';

COMMENT ON COLUMN WX_P_USER_NEWS.MSGTYPE_ IS
'群发的消息类型';

COMMENT ON COLUMN WX_P_USER_NEWS.UPDATE_TIME_ IS
'更新时间';

COMMENT ON COLUMN WX_P_USER_NEWS.UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN WX_P_USER_NEWS.CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN WX_P_USER_NEWS.CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN WX_P_USER_NEWS.TENANT_ID_ IS
'租用机构ID';

/*==============================================================*/
/* Table: "HR_DUTY"                                             */
/*==============================================================*/
CREATE TABLE "HR_DUTY"  (
   DUTY_ID_             VARCHAR2(64)                    NOT NULL,
   DUTY_NAME_           VARCHAR2(50)                    NOT NULL,
   SYSTEM_ID_           VARCHAR2(64),
   START_TIME_          TIMESTAMP                            NOT NULL,
   END_TIME_            TIMESTAMP                            NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   USER_ID_             CLOB,
   GROUP_ID_            CLOB,
   USER_NAME_           CLOB,
   GROUP_NAME_          CLOB,
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_DUTY PRIMARY KEY (DUTY_ID_)
);

COMMENT ON TABLE "HR_DUTY" IS
'排班';

COMMENT ON COLUMN "HR_DUTY".DUTY_ID_ IS
'排班ID';

COMMENT ON COLUMN "HR_DUTY".DUTY_NAME_ IS
'排班名称';

COMMENT ON COLUMN "HR_DUTY".SYSTEM_ID_ IS
'班制编号';

COMMENT ON COLUMN "HR_DUTY".START_TIME_ IS
'开始时间';

COMMENT ON COLUMN "HR_DUTY".END_TIME_ IS
'结束时间';

COMMENT ON COLUMN "HR_DUTY".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_DUTY".USER_ID_ IS
'使用者ID';

COMMENT ON COLUMN "HR_DUTY".GROUP_ID_ IS
'用户组ID';

COMMENT ON COLUMN "HR_DUTY".USER_NAME_ IS
'使用者名字';

COMMENT ON COLUMN "HR_DUTY".GROUP_NAME_ IS
'用户组名字';

COMMENT ON COLUMN "HR_DUTY".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_DUTY".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_DUTY".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_DUTY".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_DUTY_REGISTER"                                    */
/*==============================================================*/
CREATE TABLE "HR_DUTY_REGISTER"  (
   REGISTER_ID_         VARCHAR2(64)                    NOT NULL,
   REGISTER_TIME_       TIMESTAMP                            NOT NULL,
   REG_FLAG_            SMALLINT                        NOT NULL,
   REG_MINS_            INTEGER                         NOT NULL,
   REASON_              VARCHAR2(128),
   DAYOFWEEK_           INTEGER                         NOT NULL,
   IN_OFF_FLAG_         VARCHAR2(8)                     NOT NULL,
   USER_NAME_           VARCHAR2(64),
   SYSTEM_ID_           VARCHAR2(64),
   SECTION_ID_          VARCHAR2(64),
   DATE_                TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_DUTY_REGISTER PRIMARY KEY (REGISTER_ID_)
);

COMMENT ON TABLE "HR_DUTY_REGISTER" IS
'考勤登记记录';

COMMENT ON COLUMN "HR_DUTY_REGISTER".REGISTER_ID_ IS
'登记ID';

COMMENT ON COLUMN "HR_DUTY_REGISTER".REGISTER_TIME_ IS
'登记时间';

COMMENT ON COLUMN "HR_DUTY_REGISTER".REG_FLAG_ IS
'登记标识
1=正常登记（上班，下班）
2＝迟到
3=早退
4＝休息
5＝旷工
6=放假

';

COMMENT ON COLUMN "HR_DUTY_REGISTER".REG_MINS_ IS
'迟到或早退分钟
正常上班时为0';

COMMENT ON COLUMN "HR_DUTY_REGISTER".REASON_ IS
'迟到原因';

COMMENT ON COLUMN "HR_DUTY_REGISTER".DAYOFWEEK_ IS
'周几
1=星期日
..
7=日期六';

COMMENT ON COLUMN "HR_DUTY_REGISTER".IN_OFF_FLAG_ IS
'上下班标识
1=签到
2=签退';

COMMENT ON COLUMN "HR_DUTY_REGISTER".USER_NAME_ IS
'用户名';

COMMENT ON COLUMN "HR_DUTY_REGISTER".SYSTEM_ID_ IS
'班制ID';

COMMENT ON COLUMN "HR_DUTY_REGISTER".SECTION_ID_ IS
'班次ID';

COMMENT ON COLUMN "HR_DUTY_REGISTER".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_DUTY_REGISTER".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_DUTY_REGISTER".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_DUTY_REGISTER".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_DUTY_REGISTER".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_DUTY_SECTION"                                     */
/*==============================================================*/
CREATE TABLE "HR_DUTY_SECTION"  (
   SECTION_ID_          VARCHAR2(64)                    NOT NULL,
   SECTION_NAME_        VARCHAR2(16)                    NOT NULL,
   SECTION_SHORT_NAME_  VARCHAR2(4)                     NOT NULL,
   START_SIGN_IN_       INTEGER,
   DUTY_START_TIME_     VARCHAR2(20),
   END_SIGN_IN_         INTEGER,
   EARLY_OFF_TIME_      INTEGER,
   DUTY_END_TIME_       VARCHAR2(20),
   SIGN_OUT_TIME_       INTEGER,
   IS_TWO_DAY_          VARCHAR2(8),
   GROUP_LIST_          CLOB,
   IS_GROUP_            VARCHAR2(8)                     NOT NULL,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_DUTY_SECTION PRIMARY KEY (SECTION_ID_)
);

COMMENT ON TABLE "HR_DUTY_SECTION" IS
'班次
';

COMMENT ON COLUMN "HR_DUTY_SECTION".SECTION_ID_ IS
'班次编号';

COMMENT ON COLUMN "HR_DUTY_SECTION".SECTION_NAME_ IS
'班次名称';

COMMENT ON COLUMN "HR_DUTY_SECTION".SECTION_SHORT_NAME_ IS
'班次简称';

COMMENT ON COLUMN "HR_DUTY_SECTION".START_SIGN_IN_ IS
'开始签到';

COMMENT ON COLUMN "HR_DUTY_SECTION".DUTY_START_TIME_ IS
'上班时间';

COMMENT ON COLUMN "HR_DUTY_SECTION".END_SIGN_IN_ IS
'签到结束时间';

COMMENT ON COLUMN "HR_DUTY_SECTION".EARLY_OFF_TIME_ IS
'早退计时';

COMMENT ON COLUMN "HR_DUTY_SECTION".DUTY_END_TIME_ IS
'下班时间';

COMMENT ON COLUMN "HR_DUTY_SECTION".SIGN_OUT_TIME_ IS
'签退结束';

COMMENT ON COLUMN "HR_DUTY_SECTION".IS_TWO_DAY_ IS
'是否跨日';

COMMENT ON COLUMN "HR_DUTY_SECTION".GROUP_LIST_ IS
'组合班次列表';

COMMENT ON COLUMN "HR_DUTY_SECTION".IS_GROUP_ IS
'是否组合班次';

COMMENT ON COLUMN "HR_DUTY_SECTION".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_DUTY_SECTION".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_DUTY_SECTION".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_DUTY_SECTION".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_DUTY_SECTION".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_DUTY_SYSTEM"                                      */
/*==============================================================*/
CREATE TABLE "HR_DUTY_SYSTEM"  (
   SYSTEM_ID_           VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(100)                   NOT NULL,
   IS_DEFAULT           VARCHAR2(8)                     NOT NULL,
   TYPE_                VARCHAR2(20),
   WORK_SECTION_        VARCHAR2(64),
   WK_REST_SECTION_     VARCHAR2(64),
   REST_SECTION_        VARCHAR2(100),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_DUTY_SYSTEM PRIMARY KEY (SYSTEM_ID_)
);

COMMENT ON TABLE "HR_DUTY_SYSTEM" IS
'班制
';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".SYSTEM_ID_ IS
'班制编号';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".NAME_ IS
'名称';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".IS_DEFAULT IS
'是否缺省
1＝缺省
0＝非缺省';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".TYPE_ IS
'分类
一周=WEEKLY
周期性=PERIODIC';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".WORK_SECTION_ IS
'作息班次';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".WK_REST_SECTION_ IS
'休息日加班班次';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".REST_SECTION_ IS
'休息日';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_DUTY_SYSTEM".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_ERRANDS_REGISTER"                                 */
/*==============================================================*/
CREATE TABLE "HR_ERRANDS_REGISTER"  (
   ER_ID_               VARCHAR2(64)                    NOT NULL,
   REASON_              VARCHAR2(500),
   START_TIME_          TIMESTAMP                            NOT NULL,
   END_TIME_            TIMESTAMP                            NOT NULL,
   FLAG_                SMALLINT,
   BPM_INST_ID_         VARCHAR2(64),
   TYPE_                VARCHAR2(20)                    NOT NULL,
   STATUS_              VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_ERRANDS_REGISTER PRIMARY KEY (ER_ID_)
);

COMMENT ON TABLE "HR_ERRANDS_REGISTER" IS
'请假、加班、外出登记';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".ER_ID_ IS
'erID';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".START_TIME_ IS
'开始日期';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".END_TIME_ IS
'结束日期';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".FLAG_ IS
'标识
0=加班
1=请假
2=外出';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".BPM_INST_ID_ IS
'流程实例ID';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".TYPE_ IS
'类型';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_ERRANDS_REGISTER".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_HOLIDAY"                                          */
/*==============================================================*/
CREATE TABLE "HR_HOLIDAY"  (
   HOLIDAY_ID_          VARCHAR2(64)                    NOT NULL,
   NAME_                VARCHAR2(32)                    NOT NULL,
   START_DAY_           TIMESTAMP                            NOT NULL,
   END_DAY_             TIMESTAMP                            NOT NULL,
   DESC_                VARCHAR2(512),
   SYSTEM_ID_           CLOB,
   USER_ID_             CLOB,
   USER_NAME_           CLOB,
   GROUP_ID_            CLOB,
   GROUP_NAME_          CLOB,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_HOLIDAY PRIMARY KEY (HOLIDAY_ID_)
);

COMMENT ON TABLE "HR_HOLIDAY" IS
'放假记录';

COMMENT ON COLUMN "HR_HOLIDAY".HOLIDAY_ID_ IS
'假期ID';

COMMENT ON COLUMN "HR_HOLIDAY".NAME_ IS
'假期名称';

COMMENT ON COLUMN "HR_HOLIDAY".START_DAY_ IS
'开始日期';

COMMENT ON COLUMN "HR_HOLIDAY".END_DAY_ IS
'结束日期';

COMMENT ON COLUMN "HR_HOLIDAY".DESC_ IS
'假期描述';

COMMENT ON COLUMN "HR_HOLIDAY".SYSTEM_ID_ IS
'班次ID';

COMMENT ON COLUMN "HR_HOLIDAY".USER_ID_ IS
'所属用户
若为某员工的假期，则为员工自己的id';

COMMENT ON COLUMN "HR_HOLIDAY".USER_NAME_ IS
'用户名';

COMMENT ON COLUMN "HR_HOLIDAY".GROUP_ID_ IS
'所属用户组';

COMMENT ON COLUMN "HR_HOLIDAY".GROUP_NAME_ IS
'用户组名';

COMMENT ON COLUMN "HR_HOLIDAY".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_HOLIDAY".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_HOLIDAY".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_HOLIDAY".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_HOLIDAY".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_OVERTIME_EXT"                                     */
/*==============================================================*/
CREATE TABLE "HR_OVERTIME_EXT"  (
   OT_ID_               VARCHAR2(64)                    NOT NULL,
   ER_ID_               VARCHAR2(64),
   TYPE_                VARCHAR2(20),
   TITLE_               VARCHAR2(50),
   DESC_                VARCHAR2(500),
   PAY_                 VARCHAR2(20),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_OVERTIME_EXT PRIMARY KEY (OT_ID_)
);

COMMENT ON TABLE "HR_OVERTIME_EXT" IS
'加班';

COMMENT ON COLUMN "HR_OVERTIME_EXT".OT_ID_ IS
'加班ID';

COMMENT ON COLUMN "HR_OVERTIME_EXT".TYPE_ IS
'加班类型';

COMMENT ON COLUMN "HR_OVERTIME_EXT".TITLE_ IS
'标题';

COMMENT ON COLUMN "HR_OVERTIME_EXT".DESC_ IS
'备注';

COMMENT ON COLUMN "HR_OVERTIME_EXT".PAY_ IS
'结算';

COMMENT ON COLUMN "HR_OVERTIME_EXT".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_OVERTIME_EXT".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_OVERTIME_EXT".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_OVERTIME_EXT".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_OVERTIME_EXT".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_SECTION_CONFIG"                                   */
/*==============================================================*/
CREATE TABLE "HR_SECTION_CONFIG"  (
   CONFIG_ID_           VARCHAR2(64)                    NOT NULL,
   IN_START_TIME_       INTEGER,
   IN_END_TIME_         INTEGER,
   OUT_START_TIME_      INTEGER,
   OUT_END_TIME_        INTEGER,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_SECTION_CONFIG PRIMARY KEY (CONFIG_ID_)
);

COMMENT ON COLUMN "HR_SECTION_CONFIG".CONFIG_ID_ IS
'参数标号';

COMMENT ON COLUMN "HR_SECTION_CONFIG".IN_START_TIME_ IS
'上班开始签到时间';

COMMENT ON COLUMN "HR_SECTION_CONFIG".IN_END_TIME_ IS
'上班结束签到时间';

COMMENT ON COLUMN "HR_SECTION_CONFIG".OUT_START_TIME_ IS
'下班开始签到时间';

COMMENT ON COLUMN "HR_SECTION_CONFIG".OUT_END_TIME_ IS
'下班结束签到时间';

COMMENT ON COLUMN "HR_SECTION_CONFIG".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_SECTION_CONFIG".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_SECTION_CONFIG".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_SECTION_CONFIG".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_SECTION_CONFIG".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_SYSTEM_SECTION"                                   */
/*==============================================================*/
CREATE TABLE "HR_SYSTEM_SECTION"  (
   SYSTEM_SECTION_ID_   VARCHAR2(64)                    NOT NULL,
   SECTION_ID_          VARCHAR2(64),
   SYSTEM_ID_           VARCHAR2(64),
   WORKDAY_             INTEGER,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_SYSTEM_SECTION PRIMARY KEY (SYSTEM_SECTION_ID_)
);

COMMENT ON TABLE "HR_SYSTEM_SECTION" IS
'班制班次表';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".SYSTEM_SECTION_ID_ IS
'主键';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".SECTION_ID_ IS
'班次ID';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".SYSTEM_ID_ IS
'班制ID';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_SYSTEM_SECTION".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_TRANS_REST_EXT"                                   */
/*==============================================================*/
CREATE TABLE "HR_TRANS_REST_EXT"  (
   TR_ID_               VARCHAR2(64)                    NOT NULL,
   ER_ID_               VARCHAR2(64),
   TYPE_                VARCHAR2(20),
   WORK_                TIMESTAMP,
   REST_                TIMESTAMP,
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_TRANS_REST_EXT PRIMARY KEY (TR_ID_)
);

COMMENT ON TABLE "HR_TRANS_REST_EXT" IS
'调休扩展表';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".TR_ID_ IS
'调休ID';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".TYPE_ IS
'调休类型';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".WORK_ IS
'上班时间';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".REST_ IS
'休息时间';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_TRANS_REST_EXT".UPDATE_TIME_ IS
'更新时间';

/*==============================================================*/
/* Table: "HR_VACATION_EXT"                                     */
/*==============================================================*/
CREATE TABLE "HR_VACATION_EXT"  (
   VAC_ID_              VARCHAR2(64)                    NOT NULL,
   ER_ID_               VARCHAR2(64),
   TYPE_                VARCHAR2(20),
   WORK_PLAN_           VARCHAR2(500),
   TENANT_ID_           VARCHAR2(64),
   CREATE_BY_           VARCHAR2(64),
   CREATE_TIME_         TIMESTAMP,
   UPDATE_BY_           VARCHAR2(64),
   UPDATE_TIME_         TIMESTAMP,
   CONSTRAINT PK_HR_VACATION_EXT PRIMARY KEY (VAC_ID_)
);

COMMENT ON TABLE "HR_VACATION_EXT" IS
'请假扩展表';

COMMENT ON COLUMN "HR_VACATION_EXT".VAC_ID_ IS
'请假扩展ID';

COMMENT ON COLUMN "HR_VACATION_EXT".TYPE_ IS
'请假类型';

COMMENT ON COLUMN "HR_VACATION_EXT".WORK_PLAN_ IS
'工作安排';

COMMENT ON COLUMN "HR_VACATION_EXT".TENANT_ID_ IS
'租用机构Id';

COMMENT ON COLUMN "HR_VACATION_EXT".CREATE_BY_ IS
'创建人ID';

COMMENT ON COLUMN "HR_VACATION_EXT".CREATE_TIME_ IS
'创建时间';

COMMENT ON COLUMN "HR_VACATION_EXT".UPDATE_BY_ IS
'更新人ID';

COMMENT ON COLUMN "HR_VACATION_EXT".UPDATE_TIME_ IS
'更新时间';

ALTER TABLE BPM_AGENT_SOL
   ADD CONSTRAINT AGT_SOL_R_AGT FOREIGN KEY (AGENT_ID_)
      REFERENCES BPM_AGENT (AGENT_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_AGENT_SOL
   ADD CONSTRAINT BPM_AGENT_R_BSOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_CHECK_FILE
   ADD CONSTRAINT FK_CKFILE_R_NODE_JUMP FOREIGN KEY (JUMP_ID_)
      REFERENCES BPM_NODE_JUMP (JUMP_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_DEF
   ADD CONSTRAINT BPM_DEF_R_SYSTREE FOREIGN KEY ("TREE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE BPM_FV_RIGHT
   ADD CONSTRAINT BPM_FVR_R_BFV FOREIGN KEY (VIEW_ID_)
      REFERENCES BPM_FORM_VIEW (VIEW_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_INST
   ADD CONSTRAINT BPM_INST_R_DEF FOREIGN KEY (DEF_ID_)
      REFERENCES BPM_DEF (DEF_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_INST_ATTACH
   ADD CONSTRAINT FK_BPM_INST_ATT_R_BPM_INST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_INST_CP
   ADD CONSTRAINT FK_INST_CP_R_INSTCC FOREIGN KEY (CC_ID_)
      REFERENCES BPM_INST_CC (CC_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_INST_CTL
   ADD CONSTRAINT FK_BPM_INST_FK_BPM_IN_BPM_INST FOREIGN KEY (BPM_INST_ID_)
      REFERENCES BPM_INST (INST_ID_);

ALTER TABLE BPM_INST_READ
   ADD CONSTRAINT FK_BPM_INS_RD_R_BPM_INST FOREIGN KEY (INST_ID_)
      REFERENCES BPM_INST (INST_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_LIB
   ADD CONSTRAINT BM_LIB_R_SOLUT FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_LIB
   ADD CONSTRAINT BPM_LIB_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE BPM_LIB_CMT
   ADD CONSTRAINT BPM_LIBCMT_R_LIB FOREIGN KEY (LIB_ID_)
      REFERENCES BPM_LIB (LIB_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_NODE_SET
   ADD CONSTRAINT NODE_SET_R_BPMSOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_SOLUTION
   ADD CONSTRAINT BM_SON_R_SYS_TREE FOREIGN KEY ("TREE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE BPM_SOL_CTL
   ADD CONSTRAINT FK_BPM_SOL_CTL_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_SOL_FM
   ADD CONSTRAINT SOL_FM_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_SOL_FV
   ADD CONSTRAINT SOL_FV_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_SOL_USER
   ADD CONSTRAINT FK_BPM_SOL_USR_R_BPM_SOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE BPM_SOL_VAR
   ADD CONSTRAINT BPM_SOL_VAR_R_BPMSOL FOREIGN KEY (SOL_ID_)
      REFERENCES BPM_SOLUTION (SOL_ID_)
      ON DELETE SET NULL;

ALTER TABLE BPM_TEST_CASE
   ADD CONSTRAINT FK_TEST_CASE_R_TESTSOL FOREIGN KEY (TEST_SOL_ID_)
      REFERENCES BPM_TEST_SOL (TEST_SOL_ID_)
      ON DELETE CASCADE;

ALTER TABLE CAL_CALENDAR
   ADD CONSTRAINT FK_CAL_CALE_REFERENCE_CAL_SETT FOREIGN KEY (SETTING_ID_)
      REFERENCES CAL_SETTING (SETTING_ID_);

ALTER TABLE CAL_GRANT
   ADD CONSTRAINT FK_CAL_GRAN_REFERENCE_CAL_SETT FOREIGN KEY (SETTING_ID_)
      REFERENCES CAL_SETTING (SETTING_ID_);

ALTER TABLE HR_DUTY_INST
   ADD CONSTRAINT INST_R_HOLIDAY FOREIGN KEY (HOLIDAY_ID_)
      REFERENCES "HR_HOLIDAY" (HOLIDAY_ID_);

ALTER TABLE HR_DUTY_INST_EXT
   ADD CONSTRAINT INSTEXT_R_INST FOREIGN KEY (DUTY_INST_ID_)
      REFERENCES HR_DUTY_INST (DUTY_INST_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_DOC
   ADD CONSTRAINT FK_INF_DOC_DT_R_DF_INF_DOC_ FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_DOC_FOLDER (FOLDER_ID_);

ALTER TABLE INF_DOC_FILE
   ADD CONSTRAINT FK_INF_DOC__DF_F_DT_INF_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES INF_DOC (DOC_ID_);

ALTER TABLE INF_DOC_FILE
   ADD CONSTRAINT FK_DOC_FILE_R_SYSFILE FOREIGN KEY (FILE_ID_)
      REFERENCES SYS_FILE (FILE_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_DOC_RIGHT
   ADD CONSTRAINT FK_INF_DOC__DP_R_DF_INF_DOC_ FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_DOC_FOLDER (FOLDER_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_DOC_RIGHT
   ADD CONSTRAINT FK_INF_DOC__DP_R_DT_INF_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES INF_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_INBOX
   ADD CONSTRAINT FK_INF_INBOX_R_INMSG FOREIGN KEY (MSG_ID_)
      REFERENCES INF_INNER_MSG (MSG_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_MAIL
   ADD CONSTRAINT FK_OUT_MAIL_R_MAIL_CFG FOREIGN KEY (CONFIG_ID_)
      REFERENCES INF_MAIL_CONFIG (CONFIG_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_MAIL
   ADD CONSTRAINT FK_INF_MAIL_R_FOLDER FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_MAIL_FOLDER (FOLDER_ID_)
      ON DELETE SET NULL;

ALTER TABLE INF_MAIL_BOX
   ADD CONSTRAINT FK_MAILBOX_R_INMAIL FOREIGN KEY (MAIL_ID_)
      REFERENCES INF_INNER_MAIL (MAIL_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_MAIL_BOX
   ADD CONSTRAINT FK_MAILBOX_R_MAILFOLDER FOREIGN KEY (FOLDER_ID_)
      REFERENCES INF_MAIL_FOLDER (FOLDER_ID_)
      ON DELETE SET NULL;

ALTER TABLE INF_MAIL_FILE
   ADD CONSTRAINT FK_MAIL_FILE_R_OUT_MAIL FOREIGN KEY (MAIL_ID_)
      REFERENCES INF_MAIL (MAIL_ID_)
      ON DELETE CASCADE;

ALTER TABLE INF_MAIL_FOLDER
   ADD CONSTRAINT FK_MAIL_FO_R_MAIL_CFG FOREIGN KEY (CONFIG_ID_)
      REFERENCES INF_MAIL_CONFIG (CONFIG_ID_)
      ON DELETE SET NULL;

ALTER TABLE INS_COLUMN
   ADD CONSTRAINT COLMN_R_COL_TYPE FOREIGN KEY (TYPE_ID_)
      REFERENCES INS_COL_TYPE (TYPE_ID_)
      ON DELETE CASCADE;

ALTER TABLE INS_COL_NEW
   ADD CONSTRAINT COL_NEW_R_COLMN FOREIGN KEY (COL_ID_)
      REFERENCES INS_COLUMN (COL_ID_)
      ON DELETE CASCADE;

ALTER TABLE INS_COL_NEW
   ADD CONSTRAINT IS_CN_R_NEWS FOREIGN KEY (NEW_ID_)
      REFERENCES INS_NEWS (NEW_ID_)
      ON DELETE CASCADE;

ALTER TABLE INS_NEWS_CM
   ADD CONSTRAINT FK_INS_NEWCM_R_INS_NEW FOREIGN KEY (NEW_ID_)
      REFERENCES INS_NEWS (NEW_ID_)
      ON DELETE CASCADE;

ALTER TABLE INS_PORT_COL
   ADD CONSTRAINT PORT_COL_R_INS_COL FOREIGN KEY (COL_ID_)
      REFERENCES INS_COLUMN (COL_ID_)
      ON DELETE CASCADE;

ALTER TABLE INS_PORT_COL
   ADD CONSTRAINT PORT_COL_R_INS_PORAL FOREIGN KEY (PORT_ID_)
      REFERENCES INS_PORTAL (PORT_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC
   ADD CONSTRAINT DOC_R_DOC_TMP FOREIGN KEY (TEMP_ID_)
      REFERENCES KD_DOC_TEMPLATE (TEMP_ID_)
      ON DELETE SET NULL;

ALTER TABLE KD_DOC
   ADD CONSTRAINT KD_DOC_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_");

ALTER TABLE KD_DOC_CMMT
   ADD CONSTRAINT DOCMT_R_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_CONTR
   ADD CONSTRAINT DOC_CONT_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_DIR
   ADD CONSTRAINT KD_DOCDIR_R_KDDOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_FAV
   ADD CONSTRAINT DOC_FAV_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_FAV
   ADD CONSTRAINT KD_DOC_FAV_R_QUE FOREIGN KEY (QUE_ID_)
      REFERENCES KD_QUESTION (QUE_ID_);

ALTER TABLE KD_DOC_HANDLE
   ADD CONSTRAINT FK_KD_DOC_H_REFERENCE_OD_DOCUM FOREIGN KEY (DOC_ID_)
      REFERENCES OD_DOCUMENT (DOC_ID_);

ALTER TABLE KD_DOC_HIS
   ADD CONSTRAINT DOCVER_R_KDDOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_READ
   ADD CONSTRAINT DOC_RD_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_REM
   ADD CONSTRAINT DOC_REM_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_RIGHT
   ADD CONSTRAINT DOC_RHT_R_KD_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_ROUND
   ADD CONSTRAINT DOC_ROUND_R_DOC FOREIGN KEY (DOC_ID_)
      REFERENCES KD_DOC (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE KD_DOC_TEMPLATE
   ADD CONSTRAINT DOC_TMPL_R_SYSTREE FOREIGN KEY ("TREE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE KD_QUESTION
   ADD CONSTRAINT QUES_R_SYSTREE FOREIGN KEY ("TREE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE KD_QUES_ANSWER
   ADD CONSTRAINT QUE_AW_R_QUES FOREIGN KEY (QUE_ID_)
      REFERENCES KD_QUESTION (QUE_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_ADDR_CONT
   ADD CONSTRAINT FK_ADD_CNT_R_ADD_BK FOREIGN KEY (ADDR_ID_)
      REFERENCES OA_ADDR_BOOK (ADDR_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_ADDR_GPB
   ADD CONSTRAINT FK_ADD_GPB_R_ADD_GRP FOREIGN KEY (GROUP_ID_)
      REFERENCES OA_ADDR_GRP (GROUP_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_ADDR_GPB
   ADD CONSTRAINT FK_ADD_GPB_R_ADD_BK FOREIGN KEY (ADDR_ID_)
      REFERENCES OA_ADDR_BOOK (ADDR_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_ASSETS
   ADD CONSTRAINT FK_OA_ASSET_ASSERTS_R_OA_PRODU FOREIGN KEY (PROD_DEF_ID_)
      REFERENCES OA_PRODUCT_DEF (PROD_DEF_ID_);

ALTER TABLE OA_ASSETS_BID
   ADD CONSTRAINT ASSETS_BID_R_ASSETS FOREIGN KEY (ASS_ID_)
      REFERENCES OA_ASSETS (ASS_ID_);

ALTER TABLE OA_ASS_PARAMETER
   ADD CONSTRAINT ASSPARA_R_PK FOREIGN KEY (KEY_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_KEY (KEY_ID_);

ALTER TABLE OA_ASS_PARAMETER
   ADD CONSTRAINT ASSPARA_R_PV FOREIGN KEY (VALUE_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_VALUE (VALUE_ID_);

ALTER TABLE OA_ASS_PARAMETER
   ADD CONSTRAINT ASS_PARA_R_ASS FOREIGN KEY (ASS_ID_)
      REFERENCES OA_ASSETS (ASS_ID_);

ALTER TABLE OA_CAR_APP
   ADD CONSTRAINT CAR_APP_R_CAR FOREIGN KEY (CAR_ID_)
      REFERENCES OA_CAR (CAR_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_COM_RIGHT
   ADD CONSTRAINT COM_RT_R_COM_BK FOREIGN KEY (COMBOOK_ID_)
      REFERENCES OA_COM_BOOK (COM_ID_);

ALTER TABLE OA_MEETING
   ADD CONSTRAINT OA_MET_R_ROOM FOREIGN KEY (ROOM_ID_)
      REFERENCES OA_MEET_ROOM (ROOM_ID_)
      ON DELETE SET NULL;

ALTER TABLE OA_MEET_ATT
   ADD CONSTRAINT MEET_ATT_R_MEET FOREIGN KEY (MEET_ID_)
      REFERENCES OA_MEETING (MEET_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_PLAN_TASK
   ADD CONSTRAINT PLAN_R_PROJ FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
      ON DELETE SET NULL;

ALTER TABLE OA_PLAN_TASK
   ADD CONSTRAINT PLAN_R_REQ_MGR FOREIGN KEY (REQ_ID_)
      REFERENCES OA_REQ_MGR (REQ_ID_)
      ON DELETE SET NULL;

ALTER TABLE OA_PRODUCT_DEF
   ADD CONSTRAINT PRODUCTDEF_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_");

ALTER TABLE OA_PRODUCT_DEF_PARA
   ADD CONSTRAINT PRODDEFPPARA_R_PRODDEF FOREIGN KEY (PROD_DEF_ID_)
      REFERENCES OA_PRODUCT_DEF (PROD_DEF_ID_);

ALTER TABLE OA_PRODUCT_DEF_PARA
   ADD CONSTRAINT PRODUCTDEFPARA_R_PK FOREIGN KEY (KEY_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_KEY (KEY_ID_);

ALTER TABLE OA_PRODUCT_DEF_PARA
   ADD CONSTRAINT PRODUCTDEFPARA_R_PV FOREIGN KEY (VALUE_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_VALUE (VALUE_ID_);

ALTER TABLE OA_PRODUCT_DEF_PARA_KEY
   ADD CONSTRAINT PRODUCTDEF_PK_R_ST FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_");

ALTER TABLE OA_PRODUCT_DEF_PARA_VALUE
   ADD CONSTRAINT FK_OA_PRODU_PRODUCTDE_OA_PRODU FOREIGN KEY (KEY_ID_)
      REFERENCES OA_PRODUCT_DEF_PARA_KEY (KEY_ID_);

ALTER TABLE OA_PRODUCT_DEF_PARA_VALUE
   ADD CONSTRAINT PRODUCTDEF_PV_R_ST FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_");

ALTER TABLE OA_PROJECT
   ADD CONSTRAINT PROJ_R_SYSTREE FOREIGN KEY ("TREE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE OA_PRO_ATTEND
   ADD CONSTRAINT PRO_ATT_R_PROJ FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_PRO_VERS
   ADD CONSTRAINT PRO_VER_R_PROJECT FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
      ON DELETE CASCADE;

ALTER TABLE OA_REQ_MGR
   ADD CONSTRAINT REQ_MGR_R_PROJECT FOREIGN KEY (PROJECT_ID_)
      REFERENCES OA_PROJECT (PROJECT_ID_)
      ON DELETE SET NULL;

ALTER TABLE OA_WORK_LOG
   ADD CONSTRAINT WORKLOG_R_PLANTASK FOREIGN KEY (PLAN_ID_)
      REFERENCES OA_PLAN_TASK (PLAN_ID_)
      ON DELETE SET NULL;

ALTER TABLE OD_DOCUMENT
   ADD CONSTRAINT FK_OD_DOC_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE OD_DOC_REC
   ADD CONSTRAINT FK_DOC_REC_R_ODDOC FOREIGN KEY (DOC_ID_)
      REFERENCES OD_DOCUMENT (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE OD_DOC_REMIND_
   ADD CONSTRAINT FK_DOC_RM_R_ODDOC FOREIGN KEY (DOC_ID_)
      REFERENCES OD_DOCUMENT (DOC_ID_)
      ON DELETE CASCADE;

ALTER TABLE OD_DOC_TEMPLATE
   ADD CONSTRAINT FK_DOC_TMP_R_SYSTREE FOREIGN KEY (TREE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE OS_GROUP
   ADD CONSTRAINT FK_GP_R_DMN FOREIGN KEY (DIM_ID_)
      REFERENCES OS_DIMENSION (DIM_ID_)
      ON DELETE CASCADE;

ALTER TABLE OS_GROUP_MENU
   ADD CONSTRAINT FK_OS_GROUP_FK_GRP_MN_OS_GROUP FOREIGN KEY (GROUP_ID_)
      REFERENCES OS_GROUP (GROUP_ID_)
      ON DELETE CASCADE;

ALTER TABLE OS_GROUP_MENU
   ADD CONSTRAINT FK_GRP_MN_R_SYS_MENU FOREIGN KEY ("MENU_ID_")
      REFERENCES SYS_MENU ("MENU_ID_")
      ON DELETE CASCADE;

ALTER TABLE OS_GROUP_SYS
   ADD CONSTRAINT FK_GRP_SYS_R_GRP FOREIGN KEY (GROUP_ID_)
      REFERENCES OS_GROUP (GROUP_ID_)
      ON DELETE CASCADE;

ALTER TABLE OS_RANK_TYPE
   ADD CONSTRAINT FK_ORK_TYPE_R_OSDIM FOREIGN KEY (DIM_ID_)
      REFERENCES OS_DIMENSION (DIM_ID_)
      ON DELETE CASCADE;

ALTER TABLE OS_REL_INST
   ADD CONSTRAINT FK_OS_REL_I_OS_RIST_R_OS_REL_T FOREIGN KEY (REL_TYPE_ID_)
      REFERENCES OS_REL_TYPE (ID_);

ALTER TABLE OS_REL_TYPE
   ADD CONSTRAINT FK_OS_REL_T_REL_PAR1__OS_DIMEN FOREIGN KEY (DIM_ID1_)
      REFERENCES OS_DIMENSION (DIM_ID_)
      ON DELETE CASCADE;

ALTER TABLE OS_REL_TYPE
   ADD CONSTRAINT FK_OS_REL_T_REFERENCE_OS_DIMEN FOREIGN KEY (DIM_ID2_)
      REFERENCES OS_DIMENSION (DIM_ID_);

ALTER TABLE SYS_BO_LIST
   ADD CONSTRAINT FK_SYS_BO_L_SYS_BO_LI_SYS_LIST FOREIGN KEY (SOL_ID_)
      REFERENCES SYS_LIST_SOL (SOL_ID_)
      ON DELETE SET NULL;

ALTER TABLE SYS_BUTTON
   ADD CONSTRAINT SYS_BTN_R_SYS_MOD FOREIGN KEY ("MODULE_ID_")
      REFERENCES SYS_MODULE ("MODULE_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_DIC
   ADD CONSTRAINT GL_TP_R_DIC FOREIGN KEY ("TYPE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_FIELD
   ADD CONSTRAINT FK_SYS_FIEL_SYS_FIELD_SYS_MODU FOREIGN KEY ("MODULE_ID_")
      REFERENCES SYS_MODULE ("MODULE_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_FILE
   ADD CONSTRAINT SYS_FILE_TREE FOREIGN KEY (TYPE_ID_)
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_FORM_FIELD
   ADD CONSTRAINT FORM_FD_R_FORM_GP FOREIGN KEY (GROUP_ID_)
      REFERENCES SYS_FORM_GROUP (GROUP_ID_)
      ON DELETE CASCADE;

ALTER TABLE SYS_FORM_FIELD
   ADD CONSTRAINT ORM_FD_R_FIELD FOREIGN KEY ("FIELD_ID_")
      REFERENCES SYS_FIELD ("FIELD_ID_")
      ON DELETE SET NULL;

ALTER TABLE SYS_FORM_GROUP
   ADD CONSTRAINT FORM_GP_R_FORM_SMA FOREIGN KEY ("FORM_SCHEMA_ID_")
      REFERENCES SYS_FORM_SCHEMA ("FORM_SCHEMA_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_FORM_SCHEMA
   ADD CONSTRAINT FORM_SM_R_SYS_MOD FOREIGN KEY ("MODULE_ID_")
      REFERENCES SYS_MODULE ("MODULE_ID_")
      ON DELETE SET NULL;

ALTER TABLE SYS_GRID_FIELD
   ADD CONSTRAINT SGF_R_SFD FOREIGN KEY ("FIELD_ID_")
      REFERENCES SYS_FIELD ("FIELD_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_GRID_FIELD
   ADD CONSTRAINT SGF_R_SGV FOREIGN KEY ("GRID_VIEW_ID_")
      REFERENCES SYS_GRID_VIEW ("GRID_VIEW_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_GRID_VIEW
   ADD CONSTRAINT GV_R_SM FOREIGN KEY ("MODULE_ID_")
      REFERENCES SYS_MODULE ("MODULE_ID_")
      ON DELETE SET NULL;

ALTER TABLE SYS_LDAP_CN
   ADD CONSTRAINT FK_SYS_LDAP_LDAP_CN_R_SYS_LDAP FOREIGN KEY (SYS_LDAP_OU_ID_)
      REFERENCES SYS_LDAP_OU (SYS_LDAP_OU_ID_)
      ON DELETE SET NULL;

ALTER TABLE SYS_LDAP_CN
   ADD CONSTRAINT FK_SYS_LDAP_SYS_LDAP__OS_USER FOREIGN KEY (USER_ID_)
      REFERENCES OS_USER (USER_ID_)
      ON DELETE SET NULL;

ALTER TABLE SYS_LDAP_OU
   ADD CONSTRAINT LADP_OU_R_OS_GROUP FOREIGN KEY (GROUP_ID_)
      REFERENCES OS_GROUP (GROUP_ID_)
      ON DELETE SET NULL;

ALTER TABLE SYS_MENU
   ADD CONSTRAINT SYS_MENU_R_SUBS FOREIGN KEY ("SYS_ID_")
      REFERENCES SYS_SUBSYS ("SYS_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_MODULE
   ADD CONSTRAINT SYS_R_MODULE FOREIGN KEY ("SYS_ID_")
      REFERENCES SYS_SUBSYS ("SYS_ID_")
      ON DELETE SET NULL;

ALTER TABLE SYS_REPORT
   ADD CONSTRAINT REP_R_SYSTREE FOREIGN KEY ("TREE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE SYS_SEARCH_ITEM
   ADD CONSTRAINT SEARCH_ITM_R_SF FOREIGN KEY (FIELD_ID_)
      REFERENCES SYS_FIELD ("FIELD_ID_")
      ON DELETE CASCADE;

ALTER TABLE SYS_SEARCH_ITEM
   ADD CONSTRAINT SFIELD_R_SEARCH FOREIGN KEY (SEARCH_ID_)
      REFERENCES SYS_SEARCH (SEARCH_ID_)
      ON DELETE CASCADE;

ALTER TABLE SYS_TEMPLATE
   ADD CONSTRAINT SYS_TMP_R_SYSTREE FOREIGN KEY ("TREE_ID_")
      REFERENCES SYS_TREE ("TREE_ID_")
      ON DELETE SET NULL;

ALTER TABLE "HR_DUTY"
   ADD CONSTRAINT DUY_R_DS FOREIGN KEY (SYSTEM_ID_)
      REFERENCES "HR_DUTY_SYSTEM" (SYSTEM_ID_);

ALTER TABLE "HR_OVERTIME_EXT"
   ADD CONSTRAINT OTEXT_R_ERRREG FOREIGN KEY (ER_ID_)
      REFERENCES "HR_ERRANDS_REGISTER" (ER_ID_);

ALTER TABLE "HR_SYSTEM_SECTION"
   ADD CONSTRAINT SYSSEC_R_SEC FOREIGN KEY (SECTION_ID_)
      REFERENCES "HR_DUTY_SECTION" (SECTION_ID_);

ALTER TABLE "HR_SYSTEM_SECTION"
   ADD CONSTRAINT SYSSEC_R_SYS FOREIGN KEY (SYSTEM_ID_)
      REFERENCES "HR_DUTY_SYSTEM" (SYSTEM_ID_);

ALTER TABLE "HR_TRANS_REST_EXT"
   ADD CONSTRAINT TSEXT_R_ERRREG FOREIGN KEY (ER_ID_)
      REFERENCES "HR_ERRANDS_REGISTER" (ER_ID_);

ALTER TABLE "HR_VACATION_EXT"
   ADD CONSTRAINT VAC_R_ERRREG FOREIGN KEY (ER_ID_)
      REFERENCES "HR_ERRANDS_REGISTER" (ER_ID_);

