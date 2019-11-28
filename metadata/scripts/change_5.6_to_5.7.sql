	
-------add by zwc 2018-5-3---------
/*==============================================================*/
/* Table: BPM_MOBILE_TAG      记录CID和机型                                 			     */
/*==============================================================*/
CREATE TABLE `bpm_mobile_tag` (
  `TAGID_` varchar(64) NOT NULL COMMENT '标识ID主键',
  `CID_` varchar(64) DEFAULT NULL COMMENT '每台机器每个APP标识码',
  `MOBILE_TYPE_` varchar(32) DEFAULT NULL COMMENT '苹果、安卓、其他',
  `ISBAN_` varchar(32) DEFAULT NULL COMMENT '是屏蔽则不发',
  `ALIAS_` varchar(64) DEFAULT NULL COMMENT 'CID绑定的别名',
  `TAG_` varchar(64) DEFAULT NULL COMMENT 'CID归类使用',
  `TENANT_ID_` varchar(64) DEFAULT NULL COMMENT '租用机构Id',
  `CREATE_BY_` varchar(64) DEFAULT NULL COMMENT '创建人ID',
  `CREATE_TIME_` date DEFAULT NULL COMMENT '创建时间',
  `UPDATE_BY_` varchar(64) DEFAULT NULL COMMENT '更新人ID',
  `UPDATE_TIME_` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`TAGID_`)
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


/*==============================================================*/
/* Table: ATS_ATTENCE_CALCULATE                                 */
/*==============================================================*/
CREATE TABLE ATS_ATTENCE_CALCULATE
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   FILE_ID              VARCHAR(64) COMMENT '考勤档案',
   ATTENCE_TIME         DATETIME COMMENT '考勤日期',
   IS_SCHEDULE_SHIFT    SMALLINT COMMENT '是否排班',
   DATE_TYPE            SMALLINT COMMENT '日期类型',
   HOLIDAY_NAME         VARCHAR(128) COMMENT '假期名称',
   IS_CARD_RECORD       SMALLINT COMMENT '是否有打卡记录',
   SHIFT_TIME           VARCHAR(500) COMMENT '考勤时间',
   SHOULD_ATTENCE_HOURS DECIMAL(10,2) COMMENT '应出勤时数',
   ACTUAL_ATTENCE_HOURS DECIMAL(10,2) COMMENT '实际出勤时数',
   CARD_RECORD          VARCHAR(500) COMMENT '有效打卡记录',
   ABSENT_NUMBER        DECIMAL(10,2) COMMENT '旷工次数',
   ABSENT_TIME          DECIMAL(10,2) COMMENT '旷工小时数',
   ABSENT_RECORD        VARCHAR(500) COMMENT '旷工记录',
   LATE_NUMBER          DECIMAL(10,2) COMMENT '迟到次数',
   LATE_TIME            DECIMAL(10,2) COMMENT '迟到分钟数',
   LATE_RECORD          VARCHAR(500) COMMENT '迟到记录',
   LEAVE_NUMBER         DECIMAL(10,2) COMMENT '早退次数',
   LEAVE_TIME           DECIMAL(10,2) COMMENT '早退分钟数',
   LEAVE_RECORD         VARCHAR(500) COMMENT '早退记录',
   OT_NUMBER            DECIMAL(10,2) COMMENT '加班次数',
   OT_TIME              DECIMAL(10,2) COMMENT '加班分钟数',
   OT_RECORD            VARCHAR(500) COMMENT '加班记录',
   HOLIDAY_NUMBER       DECIMAL(10,2) COMMENT '请假次数',
   HOLIDAY_TIME         DECIMAL(10,2) COMMENT '请假分钟数',
   HOLIDAY_UNIT         SMALLINT COMMENT '请假时间单位',
   HOLIDAY_RECORD       VARCHAR(500) COMMENT '请假记录',
   TRIP_NUMBER          DECIMAL(10,2) COMMENT '出差次数',
   TRIP_TIME            DECIMAL(10,2) COMMENT '出差分钟数',
   TRIP_RECORD          VARCHAR(500) COMMENT '出差记录',
   VALID_CARD_RECORD    VARCHAR(500) COMMENT '有效打卡记录a',
   ATTENCE_TYPE         VARCHAR(500) COMMENT '考勤类型',
   SHIFT_ID             VARCHAR(64) COMMENT '班次',
   ABNORMITY            SMALLINT,
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENCE_CALCULATE COMMENT '考勤计算';

/*==============================================================*/
/* Table: ATS_ATTENCE_CALCULATE_SET                             */
/*==============================================================*/
CREATE TABLE ATS_ATTENCE_CALCULATE_SET
(
   ID                   VARCHAR(64) NOT NULL,
   SUMMARY              VARCHAR(500) COMMENT '汇总设置',
   DETAIL               VARCHAR(500) COMMENT '明细设置',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENCE_CALCULATE_SET COMMENT '考勤计算设置';

/*==============================================================*/
/* Table: ATS_ATTENCE_CYCLE                                     */
/*==============================================================*/
CREATE TABLE ATS_ATTENCE_CYCLE
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   TYPE                 VARCHAR(128) COMMENT '周期类型',
   YEAR                 INT(11) COMMENT '年',
   MONTH                INT(11) COMMENT '月',
   START_MONTH          SMALLINT(6) COMMENT '周期区间-开始月',
   START_DAY            INT(11) COMMENT '周期区间-开始日',
   END_MONTH            SMALLINT(6) COMMENT '周期区间-结束月',
   END_DAY              INT(11) COMMENT '周期区间-结束日',
   IS_DEFAULT           SMALLINT(6) COMMENT '是否默认',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENCE_CYCLE COMMENT '考勤周期';

/*==============================================================*/
/* Table: ATS_LEGAL_HOLIDAY                                     */
/*==============================================================*/
CREATE TABLE ATS_LEGAL_HOLIDAY
(
   ID                   VARCHAR(64) NOT NULL,
   CODE                 VARCHAR(128),
   NAME                 VARCHAR(128),
   YEAR                 INT(11),
   MEMO                 VARCHAR(500),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_LEGAL_HOLIDAY COMMENT '法定节假日';

/*==============================================================*/
/* Table: ATS_LEGAL_HOLIDAY_DETAIL                              */
/*==============================================================*/
CREATE TABLE ATS_LEGAL_HOLIDAY_DETAIL
(
   ID                   VARCHAR(64) NOT NULL,
   HOLIDAY_ID           VARCHAR(64),
   NAME                 VARCHAR(128),
   START_TIME           DATE,
   END_TIME             DATE,
   MEMO                 VARCHAR(500),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_LEGAL_HOLIDAY_DETAIL COMMENT '法定节假日明细';

/*==============================================================*/
/* Table: ATS_OVER_TIME                                         */
/*==============================================================*/
CREATE TABLE ATS_OVER_TIME
(
   ID                   VARCHAR(64) NOT NULL,
   USER_ID              VARCHAR(64),
   OT_TYPE              VARCHAR(128),
   START_TIME           DATETIME,
   END_TIME             DATETIME,
   OT_TIME              DECIMAL(10,2),
   OT_COMPENS           SMALLINT(6),
   RUN_ID               VARCHAR(64),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_OVER_TIME COMMENT '考勤加班单';

/*==============================================================*/
/* Table: ATS_SCHEDULE_SHIFT                                    */
/*==============================================================*/
CREATE TABLE ATS_SCHEDULE_SHIFT
(
   ID                   VARCHAR(64) NOT NULL,
   FILE_ID              VARCHAR(64),
   ATTENCE_TIME         DATE,
   DATE_TYPE            SMALLINT(6),
   SHIFT_ID             VARCHAR(64),
   TITLE                VARCHAR(128),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_SCHEDULE_SHIFT COMMENT '排班列表';

/*==============================================================*/
/* Table: ATS_SHIFT_INFO                                        */
/*==============================================================*/
CREATE TABLE ATS_SHIFT_INFO
(
   ID                   VARCHAR(64) NOT NULL,
   CODE                 VARCHAR(128),
   NAME                 VARCHAR(128),
   STATUS               SMALLINT(6),
   SHIFT_TYPE           VARCHAR(64),
   OT_COMPENS           VARCHAR(64),
   ORG_ID               VARCHAR(64),
   CARD_RULE            VARCHAR(64),
   STANDARD_HOUR        DECIMAL(20,2),
   IS_DEFAULT           SMALLINT(6),
   MEMO                 VARCHAR(500),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_SHIFT_INFO COMMENT '班次设置';

/*==============================================================*/
/* Table: ATS_SHIFT_RULE                                        */
/*==============================================================*/
CREATE TABLE ATS_SHIFT_RULE
(
   ID                   VARCHAR(64) NOT NULL,
   CODE                 VARCHAR(128),
   NAME                 VARCHAR(128),
   STATUS               SMALLINT(6),
   ORG_ID               VARCHAR(64),
   MEMO                 VARCHAR(500),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_SHIFT_RULE COMMENT '轮班规则';

/*==============================================================*/
/* Table: ATS_SHIFT_RULE_DETAIL                                 */
/*==============================================================*/
CREATE TABLE ATS_SHIFT_RULE_DETAIL
(
   ID                   VARCHAR(64) NOT NULL,
   RULE_ID              VARCHAR(64),
   DATE_TYPE            SMALLINT(6),
   SHIFT_ID             VARCHAR(64),
   SHIFT_TIME           VARCHAR(128),
   SN                   INT(11),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_SHIFT_RULE_DETAIL COMMENT '轮班规则明细';

/*==============================================================*/
/* Table: ATS_SHIFT_TIME                                        */
/*==============================================================*/
CREATE TABLE ATS_SHIFT_TIME
(
   ID                   VARCHAR(64) NOT NULL,
   SHIFT_ID             VARCHAR(64),
   SEGMENT              SMALLINT(6),
   ATTENDANCE_TYPE      SMALLINT(6),
   ON_TIME              TIME,
   ON_PUNCH_CARD        SMALLINT(6),
   ON_FLOAT_ADJUST      DECIMAL(20,2),
   SEGMENT_REST         DECIMAL(20,2),
   OFF_TIME             TIME,
   OFF_PUNCH_CARD       SMALLINT(6),
   OFF_FLOAT_ADJUST     DECIMAL(20,2),
   ON_TYPE              SMALLINT(6),
   OFF_TYPE             SMALLINT(6),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_SHIFT_TIME COMMENT '班次时间设置';

/*==============================================================*/
/* Table: ATS_SHIFT_TYPE                                        */
/*==============================================================*/
CREATE TABLE ATS_SHIFT_TYPE
(
   ID                   VARCHAR(64) NOT NULL,
   CODE                 VARCHAR(128),
   NAME                 VARCHAR(128),
   IS_SYS               SMALLINT(6),
   STATUS               SMALLINT(6),
   MEMO                 VARCHAR(500),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_SHIFT_TYPE COMMENT '班次类型';

/*==============================================================*/
/* Table: ATS_TRIP                                              */
/*==============================================================*/
CREATE TABLE ATS_TRIP
(
   ID                   VARCHAR(64) NOT NULL,
   USER_ID              VARCHAR(64),
   TRIP_TYPE            VARCHAR(128),
   START_TIME           DATETIME,
   END_TIME             DATETIME,
   TRIP_TIME            DECIMAL(10,2),
   RUN_ID               BIGINT(20),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_TRIP COMMENT '考勤出差单';

/*==============================================================*/
/* Table: ATS_WORK_CALENDAR                                     */
/*==============================================================*/
CREATE TABLE ATS_WORK_CALENDAR
(
   ID                   VARCHAR(64) NOT NULL COMMENT 'Column_1',
   CODE                 VARCHAR(128),
   NAME                 VARCHAR(128),
   START_TIME           DATETIME,
   END_TIME             DATETIME,
   CALENDAR_TEMPL       VARCHAR(64),
   LEGAL_HOLIDAY        VARCHAR(64),
   IS_DEFAULT           SMALLINT(6),
   MEMO                 VARCHAR(500),
   TENANT_ID_           VARCHAR(64),
   CREATE_BY_           VARCHAR(64),
   CREATE_TIME_         DATETIME,
   UPDATE_BY_           VARCHAR(64),
   UPDATE_TIME_         DATETIME,
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_WORK_CALENDAR COMMENT '工作日历';

/*==============================================================*/
/* Table: ATS_HOLIDAY                                           */
/*==============================================================*/
CREATE TABLE ATS_HOLIDAY
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   USER_ID              VARCHAR(64) COMMENT '用户ID',
   HOLIDAY_TYPE         VARCHAR(128) COMMENT '请假类型',
   START_TIME           DATE COMMENT '开始时间',
   END_TIME             DATE COMMENT '结束时间',
   HOLIDAY_TIME         DECIMAL(10,2) COMMENT '请假时间',
   DURATION             SMALLINT(6) COMMENT '时间长度',
   RUN_ID               BIGINT COMMENT '流程运行ID',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_HOLIDAY COMMENT '考勤请假单';

/*==============================================================*/
/* Table: ATS_HOLIDAY_POLICY                                    */
/*==============================================================*/
CREATE TABLE ATS_HOLIDAY_POLICY
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   ORG_ID               BIGINT(20) COMMENT '所属组织',
   IS_DEFAULT           SMALLINT(6) COMMENT '是否默认',
   IS_HALF_DAY_OFF      SMALLINT(6) COMMENT '是否启动半天假',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_HOLIDAY_POLICY COMMENT '假期制度';

/*==============================================================*/
/* Table: ATS_ATTENCE_CYCLE_DETAIL                              */
/*==============================================================*/
CREATE TABLE ATS_ATTENCE_CYCLE_DETAIL
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CYCLE_ID             VARCHAR(64) COMMENT '考勤周期',
   NAME                 VARCHAR(128) COMMENT '名称',
   START_TIME           DATE COMMENT '开始时间',
   END_TIME             DATE COMMENT '结束时间',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENCE_CYCLE_DETAIL COMMENT '考勤周期明细';

/*==============================================================*/
/* Table: ATS_ATTENCE_GROUP                                     */
/*==============================================================*/
CREATE TABLE ATS_ATTENCE_GROUP
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   ORG_ID               VARCHAR(64) COMMENT '所属组织',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENCE_GROUP COMMENT '考勤组';

/*==============================================================*/
/* Table: ATS_HOLIDAY_TYPE                                      */
/*==============================================================*/
CREATE TABLE ATS_HOLIDAY_TYPE
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   IS_SYS               SMALLINT(6) COMMENT '是否系统预置',
   STATUS               SMALLINT(6) COMMENT '状态',
   MEMO                 VARCHAR(500) COMMENT '描述',
   ABNORMITY            INT(11) COMMENT '是否异常',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_HOLIDAY_TYPE COMMENT '假期类型';

/*==============================================================*/
/* Table: ATS_IMPORT_PLAN                                       */
/*==============================================================*/
CREATE TABLE ATS_IMPORT_PLAN
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   SEPARATE             SMALLINT(6) COMMENT '分割符',
   MEMO                 VARCHAR(500) COMMENT '描述',
   PUSH_CARD_MAP        TEXT COMMENT '打卡对应关系',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_IMPORT_PLAN COMMENT '打卡导入方案';

/*==============================================================*/
/* Table: ATS_CALENDAR_TEMPL                                    */
/*==============================================================*/
CREATE TABLE ATS_CALENDAR_TEMPL
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   IS_SYS               SMALLINT(6) COMMENT '是否系统预置',
   STATUS               SMALLINT(6) COMMENT '状态',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_CALENDAR_TEMPL COMMENT '日历模版';

/*==============================================================*/
/* Table: ATS_ATTENDANCE_FILE                                   */
/*==============================================================*/
CREATE TABLE ATS_ATTENDANCE_FILE
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   USER_ID              VARCHAR(64) COMMENT '用户',
   CARD_NUMBER          VARCHAR(128) COMMENT '考勤卡号',
   IS_ATTENDANCE        SMALLINT(6) COMMENT '是否参与考勤',
   ATTENCE_POLICY       VARCHAR(64) COMMENT '考勤制度',
   HOLIDAY_POLICY       VARCHAR(64) COMMENT '假期制度',
   DEFAULT_SHIFT        VARCHAR(64) COMMENT '默认班次',
   STATUS               SMALLINT(6) COMMENT '状态',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENDANCE_FILE COMMENT '考勤档案';

/*==============================================================*/
/* Table: ATS_ATTENCE_GROUP_DETAIL                              */
/*==============================================================*/
CREATE TABLE ATS_ATTENCE_GROUP_DETAIL
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   GROUP_ID             VARCHAR(64) COMMENT '考勤组',
   FILE_ID              VARCHAR(64) COMMENT '考勤档案',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENCE_GROUP_DETAIL COMMENT '考勤组明细';

/*==============================================================*/
/* Table: ATS_ATTENCE_POLICY                                    */
/*==============================================================*/
CREATE TABLE ATS_ATTENCE_POLICY
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   WORK_CALENDAR        VARCHAR(64) COMMENT '工作日历',
   ATTENCE_CYCLE        VARCHAR(64) COMMENT '考勤周期',
   ORG_ID               VARCHAR(64) COMMENT '所属组织',
   IS_DEFAULT           SMALLINT(6) COMMENT '是否默认',
   MEMO                 VARCHAR(500) COMMENT '描述',
   WEEK_HOUR            DECIMAL(20,2) COMMENT '每周工作时数(小时)',
   DAYS_HOUR            DECIMAL(20,2) COMMENT '每天工作时数(小时)',
   MONTH_DAY            DECIMAL(20,2) COMMENT '月标准工作天数(天)',
   LEAVE_ALLOW          INT(11) COMMENT '每段早退允许值(分钟)',
   LATE_ALLOW           INT(11) COMMENT '每段迟到允许值(分钟)',
   ABSENT_ALLOW         INT(11) COMMENT '旷工起始值(分钟)',
   OT_START             INT(11) COMMENT '加班起始值(分钟)',
   LEAVE_START          INT(11) COMMENT '早退起始值(分钟)',
   OFF_LATER            DATETIME,
   OFF_LATER_ALLOW      INT(11),
   ON_LATER             DATETIME,
   PRE_NOT_BILL         SMALLINT(6) COMMENT '班前无需加班单',
   AFTER_NOT_BILL       SMALLINT(6) COMMENT '班后无需加班单',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_ATTENCE_POLICY COMMENT '考勤制度';

/*==============================================================*/
/* Table: ATS_HOLIDAY_POLICY_DETAIL                             */
/*==============================================================*/
CREATE TABLE ATS_HOLIDAY_POLICY_DETAIL
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   HOLIDAY_ID           VARCHAR(64) COMMENT '假期制度ID',
   HOLIDAY_TYPE         VARCHAR(64) COMMENT '假期类型',
   HOLIDAY_UNIT         SMALLINT(6) COMMENT '假期单位',
   ENABLE_PERIOD        SMALLINT(6) COMMENT '启动周期',
   PERIOD_LENGTH        DECIMAL(5,2) COMMENT '周期长度',
   PERIOD_UNIT          SMALLINT(6) COMMENT '周期单位',
   ENABLE_MIN_AMT       SMALLINT(6) COMMENT '控制单位额度',
   MIN_AMT              DECIMAL(5,2) COMMENT '单位额度',
   IS_FILL_HOLIDAY      SMALLINT(6) COMMENT '是否允许补请假',
   FILL_HOLIDAY         DECIMAL(5,2) COMMENT '补请假期限',
   FILL_HOLIDAY_UNIT    SMALLINT(6) COMMENT '补请假期限单位',
   IS_CANCEL_LEAVE      SMALLINT(6) COMMENT '是否允许销假',
   CANCEL_LEAVE         DECIMAL(5,2) COMMENT '销假期限',
   CANCEL_LEAVE_UNIT    SMALLINT(6) COMMENT '销假期限单位',
   IS_CTRL_LIMIT        SMALLINT(6) COMMENT '是否控制假期额度',
   HOLIDAY_RULE         VARCHAR(64) COMMENT '假期额度规则',
   IS_OVER              SMALLINT(6) COMMENT '是否允许超额请假',
   IS_OVER_AUTO_SUB     SMALLINT(6) COMMENT '超出额度下期扣减',
   IS_CAN_MODIFY_LIMIT  SMALLINT(6) COMMENT '是否允许修改额度',
   IS_INCLUDE_REST      SMALLINT(6) COMMENT '包括公休日',
   IS_INCLUDE_LEGAL     SMALLINT(6) COMMENT '包括法定假日',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_HOLIDAY_POLICY_DETAIL COMMENT '假期制度明细';

/*==============================================================*/
/* Table: ATS_CARD_RULE                                         */
/*==============================================================*/
CREATE TABLE ATS_CARD_RULE
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   START_NUM            DECIMAL(10,2) COMMENT '上班取卡提前(小时)',
   END_NUM              DECIMAL(10,2) COMMENT '下班取卡延后(小时)',
   TIME_INTERVAL        DECIMAL(10,2) COMMENT '最短取卡间隔(分钟）',
   SEGMENT_NUM          INT(11) COMMENT '适用段次',
   IS_DEFAULT           SMALLINT(6) COMMENT '适用段次',
   SEG_BEF_FIR_START_NUM DECIMAL(10,2) COMMENT '第一次上班取卡范围开始时数',
   SEG_BEF_FIR_END_NUM  DECIMAL(10,2) COMMENT '第一次上班取卡范围结束时数',
   SEG_BEF_FIR_TAKE_CARD_TYPE SMALLINT(6) COMMENT '第一次上班取卡方式',
   SEG_AFT_FIR_START_NUM DECIMAL(10,2) COMMENT '第一次下班取卡范围开始时数',
   SEG_AFT_FIR_END_NUM  DECIMAL(10,2) COMMENT '第一次下班取卡范围结束时数',
   SEG_AFT_FIR_TAKE_CARD_TYPE SMALLINT(6) COMMENT '第一次下班取卡方式',
   SEG_BEF_SEC_START_NUM DECIMAL(10,2),
   SEG_BEF_SEC_END_NUM  DECIMAL(10,2) COMMENT '第二次上班取卡范围结束时数',
   SEG_BEF_SEC_TAKE_CARD_TYPE SMALLINT(6) COMMENT '第二次上班取卡方式',
   SEG_AFT_SEC_START_NUM DECIMAL(10,2) COMMENT '第二次下班取卡范围开始时数',
   SEG_AFT_SEC_END_NUM  DECIMAL(10,2) COMMENT '第二次下班取卡范围结束时数',
   SEG_AFT_SEC_TAKE_CARD_TYPE SMALLINT(6) COMMENT '第二次下班取卡方式',
   SEG_FIR_ASSIGN_TYPE  SMALLINT(6) COMMENT '第一段间分配类型',
   SEG_FIR_ASSIGN_SEGMENT SMALLINT(6) COMMENT '第一段间分配段次',
   SEG_SEC_ASSIGN_TYPE  SMALLINT(6) COMMENT '第二段间分配类型',
   SEG_SEC_ASSIGN_SEGMENT SMALLINT(6) COMMENT '第二段间分配段次',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_CARD_RULE COMMENT '取卡规则';

/*==============================================================*/
/* Table: ATS_CARD_RECORD                                       */
/*==============================================================*/
CREATE TABLE ATS_CARD_RECORD
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CARD_NUMBER          VARCHAR(128) COMMENT '考勤卡号',
   CARD_DATE            DATETIME COMMENT '打卡日期',
   CARD_SOURCE          SMALLINT(6) COMMENT '打卡来源',
   CARD_PLACE           VARCHAR(128) COMMENT '打卡位置',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_CARD_RECORD COMMENT '打卡记录';

/*==============================================================*/
/* Table: ATS_CALENDAR_TEMPL_DETAIL                             */
/*==============================================================*/
CREATE TABLE ATS_CALENDAR_TEMPL_DETAIL
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CALENDAR_ID          VARCHAR(64) COMMENT '日历模版',
   WEEK                 SMALLINT(6) COMMENT '星期',
   DAY_TYPE             SMALLINT(6) COMMENT '日期类型',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_CALENDAR_TEMPL_DETAIL COMMENT '日历模版明细';

/*==============================================================*/
/* Table: ATS_BASE_ITEM                                         */
/*==============================================================*/
CREATE TABLE ATS_BASE_ITEM
(
   ID                   VARCHAR(64) NOT NULL COMMENT '主键',
   CODE                 VARCHAR(128) COMMENT '编码',
   NAME                 VARCHAR(128) COMMENT '名称',
   URL                  VARCHAR(128) COMMENT '地址',
   IS_SYS               SMALLINT(6) COMMENT '是否系统预置',
   MEMO                 VARCHAR(500) COMMENT '描述',
   TENANT_ID_           VARCHAR(64) COMMENT '租户ID',
   CREATE_TIME_         DATETIME COMMENT '创建时间',
   CREATE_BY_           VARCHAR(64) COMMENT '创建人',
   UPDATE_BY_           VARCHAR(64) COMMENT '更新人',
   UPDATE_TIME_         DATETIME COMMENT '更新时间',
   PRIMARY KEY (ID)
);

ALTER TABLE ATS_BASE_ITEM COMMENT '基础数据';

