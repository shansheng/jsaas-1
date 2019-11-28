-- add by mfq 2018-12-18 添加 自定义sql，系统流水，手机表单，potal栏目，图形报表 的分类树
INSERT INTO sys_tree_cat VALUES ('2610000000020010', 'CAT_BPM_FROM', '表间公式分类', 1, '表间公式分类', '1', '1', '2018-12-6', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000240002', 'CAT_CUSTOM_SQL', '自定义sql', 1, '', '1', '1', '2018-12-14', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000250002', 'CAT_SERIAL_NUMBER', '系统流水号', 1, '', '1', NULL, NULL, '1', '2018-12-14');
INSERT INTO sys_tree_cat VALUES ('2610000000260004', 'CAT_PHONE_FORM', '手机表单分类', 1, '', '1', '1', '2018-12-14', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000260015', 'CAT_POTAL_COLUMN', 'potal栏目分类', 1, '', '1', '1', '2018-12-14', NULL, NULL);
INSERT INTO sys_tree_cat VALUES ('2610000000270002', 'CAT_GRAPHIC_REPORT', '图形报表分类', 1, '', '1', '1', '2018-12-14', NULL, NULL);


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

-- 备份用户表和账号表
CREATE TABLE os_user_back SELECT * FROM os_user;

CREATE TABLE SYS_ACCOUNT_back SELECT * FROM SYS_ACCOUNT;

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
-- alter table os_user drop column IS_ADMIN_;
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

-- add by hujun 2019-03-28
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


-- add by shengzhongwen 2019-02-13 非管理平台的租户登陆默认首页Portal配置页面
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


-- add by shenzhongwen 2019-04-19 JSAAS-59:表单中的地址控件 begin--------
-- 自定义SQL分类
INSERT INTO sys_tree(TREE_ID_, NAME_, PATH_, DEPTH_, PARENT_ID_, KEY_, CODE_, DESCP_, CAT_KEY_, SN_, DATA_SHOW_TYPE_, CHILDS_, USER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000020', '国家行政区', '0.2610000000000020.', 1, '', 'GJXZQ', '', '', 'CAT_CUSTOM_SQL', 1, 'FLAT', NULL, NULL, '1', '1', '2019-04-16 11:56:51', NULL, NULL);

-- 自定义SQL
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






DROP TABLE IF EXISTS SYS_NATION_AREA;
CREATE TABLE SYS_NATION_AREA  (
  ID_ varchar(64) NOT NULL,
  NATION_ varchar(10) NOT NULL DEFAULT 'cn' COMMENT '国家简称',
  AREA_CODE_ varchar(20) NOT NULL COMMENT '地区代码',
  AREA_NAME_ varchar(100) NOT NULL COMMENT '地区名称',
  AREA_NAME_PY_ varchar(200) NOT NULL COMMENT '地区名称拼音',
  AREA_LEVEL_ tinyint(3) NOT NULL DEFAULT 1 COMMENT '地区级别',
  PROVINCE_ varchar(100) NOT NULL COMMENT '省份',
  CITY_ varchar(100) NOT NULL COMMENT '城市',
  COUNTY_ varchar(100) NOT NULL COMMENT '县级',
  RANK_ int(10) NOT NULL DEFAULT 0 COMMENT '排序，值越大越前',
  STATUS_ tinyint(3) NOT NULL DEFAULT 1 COMMENT '状态，[1:显示, 2:隐藏]',
  PARENT_CODE_ varchar(64) NOT NULL COMMENT '所属地区',
	PRIMARY KEY (ID_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地区表';


INSERT INTO SYS_NATION_AREA VALUES ('1', 'cn', '110000000000', '北京市', '', 1, '北京市', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('10', 'cn', '320000000000', '江苏省', '', 1, '江苏省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('100', 'cn', '231000000000', '牡丹江市', '', 2, '黑龙江省', '牡丹江市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1000', 'cn', '220273000000', '吉林中国新加坡食品区', '', 3, '吉林省', '吉林市', '吉林中国新加坡食品区', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1001', 'cn', '220281000000', '蛟河市', '', 3, '吉林省', '吉林市', '蛟河市', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1002', 'cn', '220282000000', '桦甸市', '', 3, '吉林省', '吉林市', '桦甸市', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1003', 'cn', '220283000000', '舒兰市', '', 3, '吉林省', '吉林市', '舒兰市', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1004', 'cn', '220284000000', '磐石市', '', 3, '吉林省', '吉林市', '磐石市', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1005', 'cn', '220301000000', '市辖区', '', 3, '吉林省', '四平市', '市辖区', 0, 1, '220300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1006', 'cn', '220302000000', '铁西区', '', 3, '吉林省', '四平市', '铁西区', 0, 1, '220300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1007', 'cn', '220303000000', '铁东区', '', 3, '吉林省', '四平市', '铁东区', 0, 1, '220300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1008', 'cn', '220322000000', '梨树县', '', 3, '吉林省', '四平市', '梨树县', 0, 1, '220300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1009', 'cn', '220323000000', '伊通满族自治县', '', 3, '吉林省', '四平市', '伊通满族自治县', 0, 1, '220300000000');
INSERT INTO SYS_NATION_AREA VALUES ('101', 'cn', '231100000000', '黑河市', '', 2, '黑龙江省', '黑河市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1010', 'cn', '220381000000', '公主岭市', '', 3, '吉林省', '四平市', '公主岭市', 0, 1, '220300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1011', 'cn', '220382000000', '双辽市', '', 3, '吉林省', '四平市', '双辽市', 0, 1, '220300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1012', 'cn', '220401000000', '市辖区', '', 3, '吉林省', '辽源市', '市辖区', 0, 1, '220400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1013', 'cn', '220402000000', '龙山区', '', 3, '吉林省', '辽源市', '龙山区', 0, 1, '220400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1014', 'cn', '220403000000', '西安区', '', 3, '吉林省', '辽源市', '西安区', 0, 1, '220400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1015', 'cn', '220421000000', '东丰县', '', 3, '吉林省', '辽源市', '东丰县', 0, 1, '220400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1016', 'cn', '220422000000', '东辽县', '', 3, '吉林省', '辽源市', '东辽县', 0, 1, '220400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1017', 'cn', '220501000000', '市辖区', '', 3, '吉林省', '通化市', '市辖区', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1018', 'cn', '220502000000', '东昌区', '', 3, '吉林省', '通化市', '东昌区', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1019', 'cn', '220503000000', '二道江区', '', 3, '吉林省', '通化市', '二道江区', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('102', 'cn', '231200000000', '绥化市', '', 2, '黑龙江省', '绥化市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1020', 'cn', '220521000000', '通化县', '', 3, '吉林省', '通化市', '通化县', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1021', 'cn', '220523000000', '辉南县', '', 3, '吉林省', '通化市', '辉南县', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1022', 'cn', '220524000000', '柳河县', '', 3, '吉林省', '通化市', '柳河县', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1023', 'cn', '220581000000', '梅河口市', '', 3, '吉林省', '通化市', '梅河口市', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1024', 'cn', '220582000000', '集安市', '', 3, '吉林省', '通化市', '集安市', 0, 1, '220500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1025', 'cn', '220601000000', '市辖区', '', 3, '吉林省', '白山市', '市辖区', 0, 1, '220600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1026', 'cn', '220602000000', '浑江区', '', 3, '吉林省', '白山市', '浑江区', 0, 1, '220600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1027', 'cn', '220605000000', '江源区', '', 3, '吉林省', '白山市', '江源区', 0, 1, '220600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1028', 'cn', '220621000000', '抚松县', '', 3, '吉林省', '白山市', '抚松县', 0, 1, '220600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1029', 'cn', '220622000000', '靖宇县', '', 3, '吉林省', '白山市', '靖宇县', 0, 1, '220600000000');
INSERT INTO SYS_NATION_AREA VALUES ('103', 'cn', '232700000000', '大兴安岭地区', '', 2, '黑龙江省', '大兴安岭地区', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1030', 'cn', '220623000000', '长白朝鲜族自治县', '', 3, '吉林省', '白山市', '长白朝鲜族自治县', 0, 1, '220600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1031', 'cn', '220681000000', '临江市', '', 3, '吉林省', '白山市', '临江市', 0, 1, '220600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1032', 'cn', '220701000000', '市辖区', '', 3, '吉林省', '松原市', '市辖区', 0, 1, '220700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1033', 'cn', '220702000000', '宁江区', '', 3, '吉林省', '松原市', '宁江区', 0, 1, '220700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1034', 'cn', '220721000000', '前郭尔罗斯蒙古族自治县', '', 3, '吉林省', '松原市', '前郭尔罗斯蒙古族自治县', 0, 1, '220700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1035', 'cn', '220722000000', '长岭县', '', 3, '吉林省', '松原市', '长岭县', 0, 1, '220700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1036', 'cn', '220723000000', '乾安县', '', 3, '吉林省', '松原市', '乾安县', 0, 1, '220700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1037', 'cn', '220771000000', '吉林松原经济开发区', '', 3, '吉林省', '松原市', '吉林松原经济开发区', 0, 1, '220700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1038', 'cn', '220781000000', '扶余市', '', 3, '吉林省', '松原市', '扶余市', 0, 1, '220700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1039', 'cn', '220801000000', '市辖区', '', 3, '吉林省', '白城市', '市辖区', 0, 1, '220800000000');
INSERT INTO SYS_NATION_AREA VALUES ('104', 'cn', '310100000000', '市辖区', '', 2, '上海市', '市辖区', '', 0, 1, '310000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1040', 'cn', '220802000000', '洮北区', '', 3, '吉林省', '白城市', '洮北区', 0, 1, '220800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1041', 'cn', '220821000000', '镇赉县', '', 3, '吉林省', '白城市', '镇赉县', 0, 1, '220800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1042', 'cn', '220822000000', '通榆县', '', 3, '吉林省', '白城市', '通榆县', 0, 1, '220800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1043', 'cn', '220871000000', '吉林白城经济开发区', '', 3, '吉林省', '白城市', '吉林白城经济开发区', 0, 1, '220800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1044', 'cn', '220881000000', '洮南市', '', 3, '吉林省', '白城市', '洮南市', 0, 1, '220800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1045', 'cn', '220882000000', '大安市', '', 3, '吉林省', '白城市', '大安市', 0, 1, '220800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1046', 'cn', '222401000000', '延吉市', '', 3, '吉林省', '延边朝鲜族自治州', '延吉市', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1047', 'cn', '222402000000', '图们市', '', 3, '吉林省', '延边朝鲜族自治州', '图们市', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1048', 'cn', '222403000000', '敦化市', '', 3, '吉林省', '延边朝鲜族自治州', '敦化市', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1049', 'cn', '222404000000', '珲春市', '', 3, '吉林省', '延边朝鲜族自治州', '珲春市', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('105', 'cn', '320100000000', '南京市', '', 2, '江苏省', '南京市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1050', 'cn', '222405000000', '龙井市', '', 3, '吉林省', '延边朝鲜族自治州', '龙井市', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1051', 'cn', '222406000000', '和龙市', '', 3, '吉林省', '延边朝鲜族自治州', '和龙市', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1052', 'cn', '222424000000', '汪清县', '', 3, '吉林省', '延边朝鲜族自治州', '汪清县', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1053', 'cn', '222426000000', '安图县', '', 3, '吉林省', '延边朝鲜族自治州', '安图县', 0, 1, '222400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1054', 'cn', '230101000000', '市辖区', '', 3, '黑龙江省', '哈尔滨市', '市辖区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1055', 'cn', '230102000000', '道里区', '', 3, '黑龙江省', '哈尔滨市', '道里区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1056', 'cn', '230103000000', '南岗区', '', 3, '黑龙江省', '哈尔滨市', '南岗区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1057', 'cn', '230104000000', '道外区', '', 3, '黑龙江省', '哈尔滨市', '道外区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1058', 'cn', '230108000000', '平房区', '', 3, '黑龙江省', '哈尔滨市', '平房区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1059', 'cn', '230109000000', '松北区', '', 3, '黑龙江省', '哈尔滨市', '松北区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('106', 'cn', '320200000000', '无锡市', '', 2, '江苏省', '无锡市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1060', 'cn', '230110000000', '香坊区', '', 3, '黑龙江省', '哈尔滨市', '香坊区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1061', 'cn', '230111000000', '呼兰区', '', 3, '黑龙江省', '哈尔滨市', '呼兰区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1062', 'cn', '230112000000', '阿城区', '', 3, '黑龙江省', '哈尔滨市', '阿城区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1063', 'cn', '230113000000', '双城区', '', 3, '黑龙江省', '哈尔滨市', '双城区', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1064', 'cn', '230123000000', '依兰县', '', 3, '黑龙江省', '哈尔滨市', '依兰县', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1065', 'cn', '230124000000', '方正县', '', 3, '黑龙江省', '哈尔滨市', '方正县', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1066', 'cn', '230125000000', '宾县', '', 3, '黑龙江省', '哈尔滨市', '宾县', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1067', 'cn', '230126000000', '巴彦县', '', 3, '黑龙江省', '哈尔滨市', '巴彦县', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1068', 'cn', '230127000000', '木兰县', '', 3, '黑龙江省', '哈尔滨市', '木兰县', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1069', 'cn', '230128000000', '通河县', '', 3, '黑龙江省', '哈尔滨市', '通河县', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('107', 'cn', '320300000000', '徐州市', '', 2, '江苏省', '徐州市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1070', 'cn', '230129000000', '延寿县', '', 3, '黑龙江省', '哈尔滨市', '延寿县', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1071', 'cn', '230183000000', '尚志市', '', 3, '黑龙江省', '哈尔滨市', '尚志市', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1072', 'cn', '230184000000', '五常市', '', 3, '黑龙江省', '哈尔滨市', '五常市', 0, 1, '230100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1073', 'cn', '230201000000', '市辖区', '', 3, '黑龙江省', '齐齐哈尔市', '市辖区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1074', 'cn', '230202000000', '龙沙区', '', 3, '黑龙江省', '齐齐哈尔市', '龙沙区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1075', 'cn', '230203000000', '建华区', '', 3, '黑龙江省', '齐齐哈尔市', '建华区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1076', 'cn', '230204000000', '铁锋区', '', 3, '黑龙江省', '齐齐哈尔市', '铁锋区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1077', 'cn', '230205000000', '昂昂溪区', '', 3, '黑龙江省', '齐齐哈尔市', '昂昂溪区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1078', 'cn', '230206000000', '富拉尔基区', '', 3, '黑龙江省', '齐齐哈尔市', '富拉尔基区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1079', 'cn', '230207000000', '碾子山区', '', 3, '黑龙江省', '齐齐哈尔市', '碾子山区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('108', 'cn', '320400000000', '常州市', '', 2, '江苏省', '常州市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1080', 'cn', '230208000000', '梅里斯达斡尔族区', '', 3, '黑龙江省', '齐齐哈尔市', '梅里斯达斡尔族区', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1081', 'cn', '230221000000', '龙江县', '', 3, '黑龙江省', '齐齐哈尔市', '龙江县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1082', 'cn', '230223000000', '依安县', '', 3, '黑龙江省', '齐齐哈尔市', '依安县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1083', 'cn', '230224000000', '泰来县', '', 3, '黑龙江省', '齐齐哈尔市', '泰来县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1084', 'cn', '230225000000', '甘南县', '', 3, '黑龙江省', '齐齐哈尔市', '甘南县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1085', 'cn', '230227000000', '富裕县', '', 3, '黑龙江省', '齐齐哈尔市', '富裕县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1086', 'cn', '230229000000', '克山县', '', 3, '黑龙江省', '齐齐哈尔市', '克山县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1087', 'cn', '230230000000', '克东县', '', 3, '黑龙江省', '齐齐哈尔市', '克东县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1088', 'cn', '230231000000', '拜泉县', '', 3, '黑龙江省', '齐齐哈尔市', '拜泉县', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1089', 'cn', '230281000000', '讷河市', '', 3, '黑龙江省', '齐齐哈尔市', '讷河市', 0, 1, '230200000000');
INSERT INTO SYS_NATION_AREA VALUES ('109', 'cn', '320500000000', '苏州市', '', 2, '江苏省', '苏州市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1090', 'cn', '230301000000', '市辖区', '', 3, '黑龙江省', '鸡西市', '市辖区', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1091', 'cn', '230302000000', '鸡冠区', '', 3, '黑龙江省', '鸡西市', '鸡冠区', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1092', 'cn', '230303000000', '恒山区', '', 3, '黑龙江省', '鸡西市', '恒山区', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1093', 'cn', '230304000000', '滴道区', '', 3, '黑龙江省', '鸡西市', '滴道区', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1094', 'cn', '230305000000', '梨树区', '', 3, '黑龙江省', '鸡西市', '梨树区', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1095', 'cn', '230306000000', '城子河区', '', 3, '黑龙江省', '鸡西市', '城子河区', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1096', 'cn', '230307000000', '麻山区', '', 3, '黑龙江省', '鸡西市', '麻山区', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1097', 'cn', '230321000000', '鸡东县', '', 3, '黑龙江省', '鸡西市', '鸡东县', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1098', 'cn', '230381000000', '虎林市', '', 3, '黑龙江省', '鸡西市', '虎林市', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1099', 'cn', '230382000000', '密山市', '', 3, '黑龙江省', '鸡西市', '密山市', 0, 1, '230300000000');
INSERT INTO SYS_NATION_AREA VALUES ('11', 'cn', '330000000000', '浙江省', '', 1, '浙江省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('110', 'cn', '320600000000', '南通市', '', 2, '江苏省', '南通市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1100', 'cn', '230401000000', '市辖区', '', 3, '黑龙江省', '鹤岗市', '市辖区', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1101', 'cn', '230402000000', '向阳区', '', 3, '黑龙江省', '鹤岗市', '向阳区', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1102', 'cn', '230403000000', '工农区', '', 3, '黑龙江省', '鹤岗市', '工农区', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1103', 'cn', '230404000000', '南山区', '', 3, '黑龙江省', '鹤岗市', '南山区', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1104', 'cn', '230405000000', '兴安区', '', 3, '黑龙江省', '鹤岗市', '兴安区', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1105', 'cn', '230406000000', '东山区', '', 3, '黑龙江省', '鹤岗市', '东山区', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1106', 'cn', '230407000000', '兴山区', '', 3, '黑龙江省', '鹤岗市', '兴山区', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1107', 'cn', '230421000000', '萝北县', '', 3, '黑龙江省', '鹤岗市', '萝北县', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1108', 'cn', '230422000000', '绥滨县', '', 3, '黑龙江省', '鹤岗市', '绥滨县', 0, 1, '230400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1109', 'cn', '230501000000', '市辖区', '', 3, '黑龙江省', '双鸭山市', '市辖区', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('111', 'cn', '320700000000', '连云港市', '', 2, '江苏省', '连云港市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1110', 'cn', '230502000000', '尖山区', '', 3, '黑龙江省', '双鸭山市', '尖山区', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1111', 'cn', '230503000000', '岭东区', '', 3, '黑龙江省', '双鸭山市', '岭东区', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1112', 'cn', '230505000000', '四方台区', '', 3, '黑龙江省', '双鸭山市', '四方台区', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1113', 'cn', '230506000000', '宝山区', '', 3, '黑龙江省', '双鸭山市', '宝山区', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1114', 'cn', '230521000000', '集贤县', '', 3, '黑龙江省', '双鸭山市', '集贤县', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1115', 'cn', '230522000000', '友谊县', '', 3, '黑龙江省', '双鸭山市', '友谊县', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1116', 'cn', '230523000000', '宝清县', '', 3, '黑龙江省', '双鸭山市', '宝清县', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1117', 'cn', '230524000000', '饶河县', '', 3, '黑龙江省', '双鸭山市', '饶河县', 0, 1, '230500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1118', 'cn', '230601000000', '市辖区', '', 3, '黑龙江省', '大庆市', '市辖区', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1119', 'cn', '230602000000', '萨尔图区', '', 3, '黑龙江省', '大庆市', '萨尔图区', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('112', 'cn', '320800000000', '淮安市', '', 2, '江苏省', '淮安市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1120', 'cn', '230603000000', '龙凤区', '', 3, '黑龙江省', '大庆市', '龙凤区', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1121', 'cn', '230604000000', '让胡路区', '', 3, '黑龙江省', '大庆市', '让胡路区', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1122', 'cn', '230605000000', '红岗区', '', 3, '黑龙江省', '大庆市', '红岗区', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1123', 'cn', '230606000000', '大同区', '', 3, '黑龙江省', '大庆市', '大同区', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1124', 'cn', '230621000000', '肇州县', '', 3, '黑龙江省', '大庆市', '肇州县', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1125', 'cn', '230622000000', '肇源县', '', 3, '黑龙江省', '大庆市', '肇源县', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1126', 'cn', '230623000000', '林甸县', '', 3, '黑龙江省', '大庆市', '林甸县', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1127', 'cn', '230624000000', '杜尔伯特蒙古族自治县', '', 3, '黑龙江省', '大庆市', '杜尔伯特蒙古族自治县', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1128', 'cn', '230671000000', '大庆高新技术产业开发区', '', 3, '黑龙江省', '大庆市', '大庆高新技术产业开发区', 0, 1, '230600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1129', 'cn', '230701000000', '市辖区', '', 3, '黑龙江省', '伊春市', '市辖区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('113', 'cn', '320900000000', '盐城市', '', 2, '江苏省', '盐城市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1130', 'cn', '230702000000', '伊春区', '', 3, '黑龙江省', '伊春市', '伊春区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1131', 'cn', '230703000000', '南岔区', '', 3, '黑龙江省', '伊春市', '南岔区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1132', 'cn', '230704000000', '友好区', '', 3, '黑龙江省', '伊春市', '友好区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1133', 'cn', '230705000000', '西林区', '', 3, '黑龙江省', '伊春市', '西林区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1134', 'cn', '230706000000', '翠峦区', '', 3, '黑龙江省', '伊春市', '翠峦区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1135', 'cn', '230707000000', '新青区', '', 3, '黑龙江省', '伊春市', '新青区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1136', 'cn', '230708000000', '美溪区', '', 3, '黑龙江省', '伊春市', '美溪区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1137', 'cn', '230709000000', '金山屯区', '', 3, '黑龙江省', '伊春市', '金山屯区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1138', 'cn', '230710000000', '五营区', '', 3, '黑龙江省', '伊春市', '五营区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1139', 'cn', '230711000000', '乌马河区', '', 3, '黑龙江省', '伊春市', '乌马河区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('114', 'cn', '321000000000', '扬州市', '', 2, '江苏省', '扬州市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1140', 'cn', '230712000000', '汤旺河区', '', 3, '黑龙江省', '伊春市', '汤旺河区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1141', 'cn', '230713000000', '带岭区', '', 3, '黑龙江省', '伊春市', '带岭区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1142', 'cn', '230714000000', '乌伊岭区', '', 3, '黑龙江省', '伊春市', '乌伊岭区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1143', 'cn', '230715000000', '红星区', '', 3, '黑龙江省', '伊春市', '红星区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1144', 'cn', '230716000000', '上甘岭区', '', 3, '黑龙江省', '伊春市', '上甘岭区', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1145', 'cn', '230722000000', '嘉荫县', '', 3, '黑龙江省', '伊春市', '嘉荫县', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1146', 'cn', '230781000000', '铁力市', '', 3, '黑龙江省', '伊春市', '铁力市', 0, 1, '230700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1147', 'cn', '230801000000', '市辖区', '', 3, '黑龙江省', '佳木斯市', '市辖区', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1148', 'cn', '230803000000', '向阳区', '', 3, '黑龙江省', '佳木斯市', '向阳区', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1149', 'cn', '230804000000', '前进区', '', 3, '黑龙江省', '佳木斯市', '前进区', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('115', 'cn', '321100000000', '镇江市', '', 2, '江苏省', '镇江市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1150', 'cn', '230805000000', '东风区', '', 3, '黑龙江省', '佳木斯市', '东风区', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1151', 'cn', '230811000000', '郊区', '', 3, '黑龙江省', '佳木斯市', '郊区', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1152', 'cn', '230822000000', '桦南县', '', 3, '黑龙江省', '佳木斯市', '桦南县', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1153', 'cn', '230826000000', '桦川县', '', 3, '黑龙江省', '佳木斯市', '桦川县', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1154', 'cn', '230828000000', '汤原县', '', 3, '黑龙江省', '佳木斯市', '汤原县', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1155', 'cn', '230881000000', '同江市', '', 3, '黑龙江省', '佳木斯市', '同江市', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1156', 'cn', '230882000000', '富锦市', '', 3, '黑龙江省', '佳木斯市', '富锦市', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1157', 'cn', '230883000000', '抚远市', '', 3, '黑龙江省', '佳木斯市', '抚远市', 0, 1, '230800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1158', 'cn', '230901000000', '市辖区', '', 3, '黑龙江省', '七台河市', '市辖区', 0, 1, '230900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1159', 'cn', '230902000000', '新兴区', '', 3, '黑龙江省', '七台河市', '新兴区', 0, 1, '230900000000');
INSERT INTO SYS_NATION_AREA VALUES ('116', 'cn', '321200000000', '泰州市', '', 2, '江苏省', '泰州市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1160', 'cn', '230903000000', '桃山区', '', 3, '黑龙江省', '七台河市', '桃山区', 0, 1, '230900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1161', 'cn', '230904000000', '茄子河区', '', 3, '黑龙江省', '七台河市', '茄子河区', 0, 1, '230900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1162', 'cn', '230921000000', '勃利县', '', 3, '黑龙江省', '七台河市', '勃利县', 0, 1, '230900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1163', 'cn', '231001000000', '市辖区', '', 3, '黑龙江省', '牡丹江市', '市辖区', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1164', 'cn', '231002000000', '东安区', '', 3, '黑龙江省', '牡丹江市', '东安区', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1165', 'cn', '231003000000', '阳明区', '', 3, '黑龙江省', '牡丹江市', '阳明区', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1166', 'cn', '231004000000', '爱民区', '', 3, '黑龙江省', '牡丹江市', '爱民区', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1167', 'cn', '231005000000', '西安区', '', 3, '黑龙江省', '牡丹江市', '西安区', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1168', 'cn', '231025000000', '林口县', '', 3, '黑龙江省', '牡丹江市', '林口县', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1169', 'cn', '231071000000', '牡丹江经济技术开发区', '', 3, '黑龙江省', '牡丹江市', '牡丹江经济技术开发区', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('117', 'cn', '321300000000', '宿迁市', '', 2, '江苏省', '宿迁市', '', 0, 1, '320000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1170', 'cn', '231081000000', '绥芬河市', '', 3, '黑龙江省', '牡丹江市', '绥芬河市', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1171', 'cn', '231083000000', '海林市', '', 3, '黑龙江省', '牡丹江市', '海林市', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1172', 'cn', '231084000000', '宁安市', '', 3, '黑龙江省', '牡丹江市', '宁安市', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1173', 'cn', '231085000000', '穆棱市', '', 3, '黑龙江省', '牡丹江市', '穆棱市', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1174', 'cn', '231086000000', '东宁市', '', 3, '黑龙江省', '牡丹江市', '东宁市', 0, 1, '231000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1175', 'cn', '231101000000', '市辖区', '', 3, '黑龙江省', '黑河市', '市辖区', 0, 1, '231100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1176', 'cn', '231102000000', '爱辉区', '', 3, '黑龙江省', '黑河市', '爱辉区', 0, 1, '231100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1177', 'cn', '231121000000', '嫩江县', '', 3, '黑龙江省', '黑河市', '嫩江县', 0, 1, '231100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1178', 'cn', '231123000000', '逊克县', '', 3, '黑龙江省', '黑河市', '逊克县', 0, 1, '231100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1179', 'cn', '231124000000', '孙吴县', '', 3, '黑龙江省', '黑河市', '孙吴县', 0, 1, '231100000000');
INSERT INTO SYS_NATION_AREA VALUES ('118', 'cn', '330100000000', '杭州市', '', 2, '浙江省', '杭州市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1180', 'cn', '231181000000', '北安市', '', 3, '黑龙江省', '黑河市', '北安市', 0, 1, '231100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1181', 'cn', '231182000000', '五大连池市', '', 3, '黑龙江省', '黑河市', '五大连池市', 0, 1, '231100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1182', 'cn', '231201000000', '市辖区', '', 3, '黑龙江省', '绥化市', '市辖区', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1183', 'cn', '231202000000', '北林区', '', 3, '黑龙江省', '绥化市', '北林区', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1184', 'cn', '231221000000', '望奎县', '', 3, '黑龙江省', '绥化市', '望奎县', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1185', 'cn', '231222000000', '兰西县', '', 3, '黑龙江省', '绥化市', '兰西县', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1186', 'cn', '231223000000', '青冈县', '', 3, '黑龙江省', '绥化市', '青冈县', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1187', 'cn', '231224000000', '庆安县', '', 3, '黑龙江省', '绥化市', '庆安县', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1188', 'cn', '231225000000', '明水县', '', 3, '黑龙江省', '绥化市', '明水县', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1189', 'cn', '231226000000', '绥棱县', '', 3, '黑龙江省', '绥化市', '绥棱县', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('119', 'cn', '330200000000', '宁波市', '', 2, '浙江省', '宁波市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1190', 'cn', '231281000000', '安达市', '', 3, '黑龙江省', '绥化市', '安达市', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1191', 'cn', '231282000000', '肇东市', '', 3, '黑龙江省', '绥化市', '肇东市', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1192', 'cn', '231283000000', '海伦市', '', 3, '黑龙江省', '绥化市', '海伦市', 0, 1, '231200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1193', 'cn', '232701000000', '加格达奇区', '', 3, '黑龙江省', '大兴安岭地区', '加格达奇区', 0, 1, '232700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1194', 'cn', '232702000000', '松岭区', '', 3, '黑龙江省', '大兴安岭地区', '松岭区', 0, 1, '232700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1195', 'cn', '232703000000', '新林区', '', 3, '黑龙江省', '大兴安岭地区', '新林区', 0, 1, '232700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1196', 'cn', '232704000000', '呼中区', '', 3, '黑龙江省', '大兴安岭地区', '呼中区', 0, 1, '232700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1197', 'cn', '232721000000', '呼玛县', '', 3, '黑龙江省', '大兴安岭地区', '呼玛县', 0, 1, '232700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1198', 'cn', '232722000000', '塔河县', '', 3, '黑龙江省', '大兴安岭地区', '塔河县', 0, 1, '232700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1199', 'cn', '232723000000', '漠河县', '', 3, '黑龙江省', '大兴安岭地区', '漠河县', 0, 1, '232700000000');
INSERT INTO SYS_NATION_AREA VALUES ('12', 'cn', '340000000000', '安徽省', '', 1, '安徽省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('120', 'cn', '330300000000', '温州市', '', 2, '浙江省', '温州市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1200', 'cn', '310101000000', '黄浦区', '', 3, '上海市', '市辖区', '黄浦区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1201', 'cn', '310104000000', '徐汇区', '', 3, '上海市', '市辖区', '徐汇区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1202', 'cn', '310105000000', '长宁区', '', 3, '上海市', '市辖区', '长宁区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1203', 'cn', '310106000000', '静安区', '', 3, '上海市', '市辖区', '静安区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1204', 'cn', '310107000000', '普陀区', '', 3, '上海市', '市辖区', '普陀区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1205', 'cn', '310109000000', '虹口区', '', 3, '上海市', '市辖区', '虹口区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1206', 'cn', '310110000000', '杨浦区', '', 3, '上海市', '市辖区', '杨浦区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1207', 'cn', '310112000000', '闵行区', '', 3, '上海市', '市辖区', '闵行区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1208', 'cn', '310113000000', '宝山区', '', 3, '上海市', '市辖区', '宝山区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1209', 'cn', '310114000000', '嘉定区', '', 3, '上海市', '市辖区', '嘉定区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('121', 'cn', '330400000000', '嘉兴市', '', 2, '浙江省', '嘉兴市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1210', 'cn', '310115000000', '浦东新区', '', 3, '上海市', '市辖区', '浦东新区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1211', 'cn', '310116000000', '金山区', '', 3, '上海市', '市辖区', '金山区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1212', 'cn', '310117000000', '松江区', '', 3, '上海市', '市辖区', '松江区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1213', 'cn', '310118000000', '青浦区', '', 3, '上海市', '市辖区', '青浦区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1214', 'cn', '310120000000', '奉贤区', '', 3, '上海市', '市辖区', '奉贤区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1215', 'cn', '310151000000', '崇明区', '', 3, '上海市', '市辖区', '崇明区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1216', 'cn', '320101000000', '市辖区', '', 3, '江苏省', '南京市', '市辖区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1217', 'cn', '320102000000', '玄武区', '', 3, '江苏省', '南京市', '玄武区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1218', 'cn', '320104000000', '秦淮区', '', 3, '江苏省', '南京市', '秦淮区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1219', 'cn', '320105000000', '建邺区', '', 3, '江苏省', '南京市', '建邺区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('122', 'cn', '330500000000', '湖州市', '', 2, '浙江省', '湖州市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1220', 'cn', '320106000000', '鼓楼区', '', 3, '江苏省', '南京市', '鼓楼区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1221', 'cn', '320111000000', '浦口区', '', 3, '江苏省', '南京市', '浦口区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1222', 'cn', '320113000000', '栖霞区', '', 3, '江苏省', '南京市', '栖霞区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1223', 'cn', '320114000000', '雨花台区', '', 3, '江苏省', '南京市', '雨花台区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1224', 'cn', '320115000000', '江宁区', '', 3, '江苏省', '南京市', '江宁区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1225', 'cn', '320116000000', '六合区', '', 3, '江苏省', '南京市', '六合区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1226', 'cn', '320117000000', '溧水区', '', 3, '江苏省', '南京市', '溧水区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1227', 'cn', '320118000000', '高淳区', '', 3, '江苏省', '南京市', '高淳区', 0, 1, '320100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1228', 'cn', '320201000000', '市辖区', '', 3, '江苏省', '无锡市', '市辖区', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1229', 'cn', '320205000000', '锡山区', '', 3, '江苏省', '无锡市', '锡山区', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('123', 'cn', '330600000000', '绍兴市', '', 2, '浙江省', '绍兴市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1230', 'cn', '320206000000', '惠山区', '', 3, '江苏省', '无锡市', '惠山区', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1231', 'cn', '320211000000', '滨湖区', '', 3, '江苏省', '无锡市', '滨湖区', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1232', 'cn', '320213000000', '梁溪区', '', 3, '江苏省', '无锡市', '梁溪区', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1233', 'cn', '320214000000', '新吴区', '', 3, '江苏省', '无锡市', '新吴区', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1234', 'cn', '320281000000', '江阴市', '', 3, '江苏省', '无锡市', '江阴市', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1235', 'cn', '320282000000', '宜兴市', '', 3, '江苏省', '无锡市', '宜兴市', 0, 1, '320200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1236', 'cn', '320301000000', '市辖区', '', 3, '江苏省', '徐州市', '市辖区', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1237', 'cn', '320302000000', '鼓楼区', '', 3, '江苏省', '徐州市', '鼓楼区', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1238', 'cn', '320303000000', '云龙区', '', 3, '江苏省', '徐州市', '云龙区', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1239', 'cn', '320305000000', '贾汪区', '', 3, '江苏省', '徐州市', '贾汪区', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('124', 'cn', '330700000000', '金华市', '', 2, '浙江省', '金华市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1240', 'cn', '320311000000', '泉山区', '', 3, '江苏省', '徐州市', '泉山区', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1241', 'cn', '320312000000', '铜山区', '', 3, '江苏省', '徐州市', '铜山区', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1242', 'cn', '320321000000', '丰县', '', 3, '江苏省', '徐州市', '丰县', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1243', 'cn', '320322000000', '沛县', '', 3, '江苏省', '徐州市', '沛县', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1244', 'cn', '320324000000', '睢宁县', '', 3, '江苏省', '徐州市', '睢宁县', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1245', 'cn', '320371000000', '徐州经济技术开发区', '', 3, '江苏省', '徐州市', '徐州经济技术开发区', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1246', 'cn', '320381000000', '新沂市', '', 3, '江苏省', '徐州市', '新沂市', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1247', 'cn', '320382000000', '邳州市', '', 3, '江苏省', '徐州市', '邳州市', 0, 1, '320300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1248', 'cn', '320401000000', '市辖区', '', 3, '江苏省', '常州市', '市辖区', 0, 1, '320400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1249', 'cn', '320402000000', '天宁区', '', 3, '江苏省', '常州市', '天宁区', 0, 1, '320400000000');
INSERT INTO SYS_NATION_AREA VALUES ('125', 'cn', '330800000000', '衢州市', '', 2, '浙江省', '衢州市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1250', 'cn', '320404000000', '钟楼区', '', 3, '江苏省', '常州市', '钟楼区', 0, 1, '320400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1251', 'cn', '320411000000', '新北区', '', 3, '江苏省', '常州市', '新北区', 0, 1, '320400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1252', 'cn', '320412000000', '武进区', '', 3, '江苏省', '常州市', '武进区', 0, 1, '320400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1253', 'cn', '320413000000', '金坛区', '', 3, '江苏省', '常州市', '金坛区', 0, 1, '320400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1254', 'cn', '320481000000', '溧阳市', '', 3, '江苏省', '常州市', '溧阳市', 0, 1, '320400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1255', 'cn', '320501000000', '市辖区', '', 3, '江苏省', '苏州市', '市辖区', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1256', 'cn', '320505000000', '虎丘区', '', 3, '江苏省', '苏州市', '虎丘区', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1257', 'cn', '320506000000', '吴中区', '', 3, '江苏省', '苏州市', '吴中区', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1258', 'cn', '320507000000', '相城区', '', 3, '江苏省', '苏州市', '相城区', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1259', 'cn', '320508000000', '姑苏区', '', 3, '江苏省', '苏州市', '姑苏区', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('126', 'cn', '330900000000', '舟山市', '', 2, '浙江省', '舟山市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1260', 'cn', '320509000000', '吴江区', '', 3, '江苏省', '苏州市', '吴江区', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1261', 'cn', '320571000000', '苏州工业园区', '', 3, '江苏省', '苏州市', '苏州工业园区', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1262', 'cn', '320581000000', '常熟市', '', 3, '江苏省', '苏州市', '常熟市', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1263', 'cn', '320582000000', '张家港市', '', 3, '江苏省', '苏州市', '张家港市', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1264', 'cn', '320583000000', '昆山市', '', 3, '江苏省', '苏州市', '昆山市', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1265', 'cn', '320585000000', '太仓市', '', 3, '江苏省', '苏州市', '太仓市', 0, 1, '320500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1266', 'cn', '320601000000', '市辖区', '', 3, '江苏省', '南通市', '市辖区', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1267', 'cn', '320602000000', '崇川区', '', 3, '江苏省', '南通市', '崇川区', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1268', 'cn', '320611000000', '港闸区', '', 3, '江苏省', '南通市', '港闸区', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1269', 'cn', '320612000000', '通州区', '', 3, '江苏省', '南通市', '通州区', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('127', 'cn', '331000000000', '台州市', '', 2, '浙江省', '台州市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1270', 'cn', '320621000000', '海安县', '', 3, '江苏省', '南通市', '海安县', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1271', 'cn', '320623000000', '如东县', '', 3, '江苏省', '南通市', '如东县', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1272', 'cn', '320671000000', '南通经济技术开发区', '', 3, '江苏省', '南通市', '南通经济技术开发区', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1273', 'cn', '320681000000', '启东市', '', 3, '江苏省', '南通市', '启东市', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1274', 'cn', '320682000000', '如皋市', '', 3, '江苏省', '南通市', '如皋市', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1275', 'cn', '320684000000', '海门市', '', 3, '江苏省', '南通市', '海门市', 0, 1, '320600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1276', 'cn', '320701000000', '市辖区', '', 3, '江苏省', '连云港市', '市辖区', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1277', 'cn', '320703000000', '连云区', '', 3, '江苏省', '连云港市', '连云区', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1278', 'cn', '320706000000', '海州区', '', 3, '江苏省', '连云港市', '海州区', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1279', 'cn', '320707000000', '赣榆区', '', 3, '江苏省', '连云港市', '赣榆区', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('128', 'cn', '331100000000', '丽水市', '', 2, '浙江省', '丽水市', '', 0, 1, '330000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1280', 'cn', '320722000000', '东海县', '', 3, '江苏省', '连云港市', '东海县', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1281', 'cn', '320723000000', '灌云县', '', 3, '江苏省', '连云港市', '灌云县', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1282', 'cn', '320724000000', '灌南县', '', 3, '江苏省', '连云港市', '灌南县', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1283', 'cn', '320771000000', '连云港经济技术开发区', '', 3, '江苏省', '连云港市', '连云港经济技术开发区', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1284', 'cn', '320772000000', '连云港高新技术产业开发区', '', 3, '江苏省', '连云港市', '连云港高新技术产业开发区', 0, 1, '320700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1285', 'cn', '320801000000', '市辖区', '', 3, '江苏省', '淮安市', '市辖区', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1286', 'cn', '320803000000', '淮安区', '', 3, '江苏省', '淮安市', '淮安区', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1287', 'cn', '320804000000', '淮阴区', '', 3, '江苏省', '淮安市', '淮阴区', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1288', 'cn', '320812000000', '清江浦区', '', 3, '江苏省', '淮安市', '清江浦区', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1289', 'cn', '320813000000', '洪泽区', '', 3, '江苏省', '淮安市', '洪泽区', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('129', 'cn', '340100000000', '合肥市', '', 2, '安徽省', '合肥市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1290', 'cn', '320826000000', '涟水县', '', 3, '江苏省', '淮安市', '涟水县', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1291', 'cn', '320830000000', '盱眙县', '', 3, '江苏省', '淮安市', '盱眙县', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1292', 'cn', '320831000000', '金湖县', '', 3, '江苏省', '淮安市', '金湖县', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1293', 'cn', '320871000000', '淮安经济技术开发区', '', 3, '江苏省', '淮安市', '淮安经济技术开发区', 0, 1, '320800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1294', 'cn', '320901000000', '市辖区', '', 3, '江苏省', '盐城市', '市辖区', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1295', 'cn', '320902000000', '亭湖区', '', 3, '江苏省', '盐城市', '亭湖区', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1296', 'cn', '320903000000', '盐都区', '', 3, '江苏省', '盐城市', '盐都区', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1297', 'cn', '320904000000', '大丰区', '', 3, '江苏省', '盐城市', '大丰区', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1298', 'cn', '320921000000', '响水县', '', 3, '江苏省', '盐城市', '响水县', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1299', 'cn', '320922000000', '滨海县', '', 3, '江苏省', '盐城市', '滨海县', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('13', 'cn', '350000000000', '福建省', '', 1, '福建省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('130', 'cn', '340200000000', '芜湖市', '', 2, '安徽省', '芜湖市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1300', 'cn', '320923000000', '阜宁县', '', 3, '江苏省', '盐城市', '阜宁县', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1301', 'cn', '320924000000', '射阳县', '', 3, '江苏省', '盐城市', '射阳县', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1302', 'cn', '320925000000', '建湖县', '', 3, '江苏省', '盐城市', '建湖县', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1303', 'cn', '320971000000', '盐城经济技术开发区', '', 3, '江苏省', '盐城市', '盐城经济技术开发区', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1304', 'cn', '320981000000', '东台市', '', 3, '江苏省', '盐城市', '东台市', 0, 1, '320900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1305', 'cn', '321001000000', '市辖区', '', 3, '江苏省', '扬州市', '市辖区', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1306', 'cn', '321002000000', '广陵区', '', 3, '江苏省', '扬州市', '广陵区', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1307', 'cn', '321003000000', '邗江区', '', 3, '江苏省', '扬州市', '邗江区', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1308', 'cn', '321012000000', '江都区', '', 3, '江苏省', '扬州市', '江都区', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1309', 'cn', '321023000000', '宝应县', '', 3, '江苏省', '扬州市', '宝应县', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('131', 'cn', '340300000000', '蚌埠市', '', 2, '安徽省', '蚌埠市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1310', 'cn', '321071000000', '扬州经济技术开发区', '', 3, '江苏省', '扬州市', '扬州经济技术开发区', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1311', 'cn', '321081000000', '仪征市', '', 3, '江苏省', '扬州市', '仪征市', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1312', 'cn', '321084000000', '高邮市', '', 3, '江苏省', '扬州市', '高邮市', 0, 1, '321000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1313', 'cn', '321101000000', '市辖区', '', 3, '江苏省', '镇江市', '市辖区', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1314', 'cn', '321102000000', '京口区', '', 3, '江苏省', '镇江市', '京口区', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1315', 'cn', '321111000000', '润州区', '', 3, '江苏省', '镇江市', '润州区', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1316', 'cn', '321112000000', '丹徒区', '', 3, '江苏省', '镇江市', '丹徒区', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1317', 'cn', '321171000000', '镇江新区', '', 3, '江苏省', '镇江市', '镇江新区', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1318', 'cn', '321181000000', '丹阳市', '', 3, '江苏省', '镇江市', '丹阳市', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1319', 'cn', '321182000000', '扬中市', '', 3, '江苏省', '镇江市', '扬中市', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('132', 'cn', '340400000000', '淮南市', '', 2, '安徽省', '淮南市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1320', 'cn', '321183000000', '句容市', '', 3, '江苏省', '镇江市', '句容市', 0, 1, '321100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1321', 'cn', '321201000000', '市辖区', '', 3, '江苏省', '泰州市', '市辖区', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1322', 'cn', '321202000000', '海陵区', '', 3, '江苏省', '泰州市', '海陵区', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1323', 'cn', '321203000000', '高港区', '', 3, '江苏省', '泰州市', '高港区', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1324', 'cn', '321204000000', '姜堰区', '', 3, '江苏省', '泰州市', '姜堰区', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1325', 'cn', '321271000000', '泰州医药高新技术产业开发区', '', 3, '江苏省', '泰州市', '泰州医药高新技术产业开发区', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1326', 'cn', '321281000000', '兴化市', '', 3, '江苏省', '泰州市', '兴化市', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1327', 'cn', '321282000000', '靖江市', '', 3, '江苏省', '泰州市', '靖江市', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1328', 'cn', '321283000000', '泰兴市', '', 3, '江苏省', '泰州市', '泰兴市', 0, 1, '321200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1329', 'cn', '321301000000', '市辖区', '', 3, '江苏省', '宿迁市', '市辖区', 0, 1, '321300000000');
INSERT INTO SYS_NATION_AREA VALUES ('133', 'cn', '340500000000', '马鞍山市', '', 2, '安徽省', '马鞍山市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1330', 'cn', '321302000000', '宿城区', '', 3, '江苏省', '宿迁市', '宿城区', 0, 1, '321300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1331', 'cn', '321311000000', '宿豫区', '', 3, '江苏省', '宿迁市', '宿豫区', 0, 1, '321300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1332', 'cn', '321322000000', '沭阳县', '', 3, '江苏省', '宿迁市', '沭阳县', 0, 1, '321300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1333', 'cn', '321323000000', '泗阳县', '', 3, '江苏省', '宿迁市', '泗阳县', 0, 1, '321300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1334', 'cn', '321324000000', '泗洪县', '', 3, '江苏省', '宿迁市', '泗洪县', 0, 1, '321300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1335', 'cn', '321371000000', '宿迁经济技术开发区', '', 3, '江苏省', '宿迁市', '宿迁经济技术开发区', 0, 1, '321300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1336', 'cn', '330101000000', '市辖区', '', 3, '浙江省', '杭州市', '市辖区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1337', 'cn', '330102000000', '上城区', '', 3, '浙江省', '杭州市', '上城区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1338', 'cn', '330103000000', '下城区', '', 3, '浙江省', '杭州市', '下城区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1339', 'cn', '330104000000', '江干区', '', 3, '浙江省', '杭州市', '江干区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('134', 'cn', '340600000000', '淮北市', '', 2, '安徽省', '淮北市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1340', 'cn', '330105000000', '拱墅区', '', 3, '浙江省', '杭州市', '拱墅区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1341', 'cn', '330106000000', '西湖区', '', 3, '浙江省', '杭州市', '西湖区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1342', 'cn', '330108000000', '滨江区', '', 3, '浙江省', '杭州市', '滨江区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1343', 'cn', '330109000000', '萧山区', '', 3, '浙江省', '杭州市', '萧山区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1344', 'cn', '330110000000', '余杭区', '', 3, '浙江省', '杭州市', '余杭区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1345', 'cn', '330111000000', '富阳区', '', 3, '浙江省', '杭州市', '富阳区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1346', 'cn', '330112000000', '临安区', '', 3, '浙江省', '杭州市', '临安区', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1347', 'cn', '330122000000', '桐庐县', '', 3, '浙江省', '杭州市', '桐庐县', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1348', 'cn', '330127000000', '淳安县', '', 3, '浙江省', '杭州市', '淳安县', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1349', 'cn', '330182000000', '建德市', '', 3, '浙江省', '杭州市', '建德市', 0, 1, '330100000000');
INSERT INTO SYS_NATION_AREA VALUES ('135', 'cn', '340700000000', '铜陵市', '', 2, '安徽省', '铜陵市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1350', 'cn', '330201000000', '市辖区', '', 3, '浙江省', '宁波市', '市辖区', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1351', 'cn', '330203000000', '海曙区', '', 3, '浙江省', '宁波市', '海曙区', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1352', 'cn', '330205000000', '江北区', '', 3, '浙江省', '宁波市', '江北区', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1353', 'cn', '330206000000', '北仑区', '', 3, '浙江省', '宁波市', '北仑区', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1354', 'cn', '330211000000', '镇海区', '', 3, '浙江省', '宁波市', '镇海区', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1355', 'cn', '330212000000', '鄞州区', '', 3, '浙江省', '宁波市', '鄞州区', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1356', 'cn', '330213000000', '奉化区', '', 3, '浙江省', '宁波市', '奉化区', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1357', 'cn', '330225000000', '象山县', '', 3, '浙江省', '宁波市', '象山县', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1358', 'cn', '330226000000', '宁海县', '', 3, '浙江省', '宁波市', '宁海县', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1359', 'cn', '330281000000', '余姚市', '', 3, '浙江省', '宁波市', '余姚市', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('136', 'cn', '340800000000', '安庆市', '', 2, '安徽省', '安庆市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1360', 'cn', '330282000000', '慈溪市', '', 3, '浙江省', '宁波市', '慈溪市', 0, 1, '330200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1361', 'cn', '330301000000', '市辖区', '', 3, '浙江省', '温州市', '市辖区', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1362', 'cn', '330302000000', '鹿城区', '', 3, '浙江省', '温州市', '鹿城区', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1363', 'cn', '330303000000', '龙湾区', '', 3, '浙江省', '温州市', '龙湾区', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1364', 'cn', '330304000000', '瓯海区', '', 3, '浙江省', '温州市', '瓯海区', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1365', 'cn', '330305000000', '洞头区', '', 3, '浙江省', '温州市', '洞头区', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1366', 'cn', '330324000000', '永嘉县', '', 3, '浙江省', '温州市', '永嘉县', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1367', 'cn', '330326000000', '平阳县', '', 3, '浙江省', '温州市', '平阳县', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1368', 'cn', '330327000000', '苍南县', '', 3, '浙江省', '温州市', '苍南县', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1369', 'cn', '330328000000', '文成县', '', 3, '浙江省', '温州市', '文成县', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('137', 'cn', '341000000000', '黄山市', '', 2, '安徽省', '黄山市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1370', 'cn', '330329000000', '泰顺县', '', 3, '浙江省', '温州市', '泰顺县', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1371', 'cn', '330371000000', '温州经济技术开发区', '', 3, '浙江省', '温州市', '温州经济技术开发区', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1372', 'cn', '330381000000', '瑞安市', '', 3, '浙江省', '温州市', '瑞安市', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1373', 'cn', '330382000000', '乐清市', '', 3, '浙江省', '温州市', '乐清市', 0, 1, '330300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1374', 'cn', '330401000000', '市辖区', '', 3, '浙江省', '嘉兴市', '市辖区', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1375', 'cn', '330402000000', '南湖区', '', 3, '浙江省', '嘉兴市', '南湖区', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1376', 'cn', '330411000000', '秀洲区', '', 3, '浙江省', '嘉兴市', '秀洲区', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1377', 'cn', '330421000000', '嘉善县', '', 3, '浙江省', '嘉兴市', '嘉善县', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1378', 'cn', '330424000000', '海盐县', '', 3, '浙江省', '嘉兴市', '海盐县', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1379', 'cn', '330481000000', '海宁市', '', 3, '浙江省', '嘉兴市', '海宁市', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('138', 'cn', '341100000000', '滁州市', '', 2, '安徽省', '滁州市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1380', 'cn', '330482000000', '平湖市', '', 3, '浙江省', '嘉兴市', '平湖市', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1381', 'cn', '330483000000', '桐乡市', '', 3, '浙江省', '嘉兴市', '桐乡市', 0, 1, '330400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1382', 'cn', '330501000000', '市辖区', '', 3, '浙江省', '湖州市', '市辖区', 0, 1, '330500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1383', 'cn', '330502000000', '吴兴区', '', 3, '浙江省', '湖州市', '吴兴区', 0, 1, '330500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1384', 'cn', '330503000000', '南浔区', '', 3, '浙江省', '湖州市', '南浔区', 0, 1, '330500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1385', 'cn', '330521000000', '德清县', '', 3, '浙江省', '湖州市', '德清县', 0, 1, '330500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1386', 'cn', '330522000000', '长兴县', '', 3, '浙江省', '湖州市', '长兴县', 0, 1, '330500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1387', 'cn', '330523000000', '安吉县', '', 3, '浙江省', '湖州市', '安吉县', 0, 1, '330500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1388', 'cn', '330601000000', '市辖区', '', 3, '浙江省', '绍兴市', '市辖区', 0, 1, '330600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1389', 'cn', '330602000000', '越城区', '', 3, '浙江省', '绍兴市', '越城区', 0, 1, '330600000000');
INSERT INTO SYS_NATION_AREA VALUES ('139', 'cn', '341200000000', '阜阳市', '', 2, '安徽省', '阜阳市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1390', 'cn', '330603000000', '柯桥区', '', 3, '浙江省', '绍兴市', '柯桥区', 0, 1, '330600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1391', 'cn', '330604000000', '上虞区', '', 3, '浙江省', '绍兴市', '上虞区', 0, 1, '330600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1392', 'cn', '330624000000', '新昌县', '', 3, '浙江省', '绍兴市', '新昌县', 0, 1, '330600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1393', 'cn', '330681000000', '诸暨市', '', 3, '浙江省', '绍兴市', '诸暨市', 0, 1, '330600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1394', 'cn', '330683000000', '嵊州市', '', 3, '浙江省', '绍兴市', '嵊州市', 0, 1, '330600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1395', 'cn', '330701000000', '市辖区', '', 3, '浙江省', '金华市', '市辖区', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1396', 'cn', '330702000000', '婺城区', '', 3, '浙江省', '金华市', '婺城区', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1397', 'cn', '330703000000', '金东区', '', 3, '浙江省', '金华市', '金东区', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1398', 'cn', '330723000000', '武义县', '', 3, '浙江省', '金华市', '武义县', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1399', 'cn', '330726000000', '浦江县', '', 3, '浙江省', '金华市', '浦江县', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('14', 'cn', '360000000000', '江西省', '', 1, '江西省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('140', 'cn', '341300000000', '宿州市', '', 2, '安徽省', '宿州市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1400', 'cn', '330727000000', '磐安县', '', 3, '浙江省', '金华市', '磐安县', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1401', 'cn', '330781000000', '兰溪市', '', 3, '浙江省', '金华市', '兰溪市', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1402', 'cn', '330782000000', '义乌市', '', 3, '浙江省', '金华市', '义乌市', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1403', 'cn', '330783000000', '东阳市', '', 3, '浙江省', '金华市', '东阳市', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1404', 'cn', '330784000000', '永康市', '', 3, '浙江省', '金华市', '永康市', 0, 1, '330700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1405', 'cn', '330801000000', '市辖区', '', 3, '浙江省', '衢州市', '市辖区', 0, 1, '330800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1406', 'cn', '330802000000', '柯城区', '', 3, '浙江省', '衢州市', '柯城区', 0, 1, '330800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1407', 'cn', '330803000000', '衢江区', '', 3, '浙江省', '衢州市', '衢江区', 0, 1, '330800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1408', 'cn', '330822000000', '常山县', '', 3, '浙江省', '衢州市', '常山县', 0, 1, '330800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1409', 'cn', '330824000000', '开化县', '', 3, '浙江省', '衢州市', '开化县', 0, 1, '330800000000');
INSERT INTO SYS_NATION_AREA VALUES ('141', 'cn', '341500000000', '六安市', '', 2, '安徽省', '六安市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1410', 'cn', '330825000000', '龙游县', '', 3, '浙江省', '衢州市', '龙游县', 0, 1, '330800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1411', 'cn', '330881000000', '江山市', '', 3, '浙江省', '衢州市', '江山市', 0, 1, '330800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1412', 'cn', '330901000000', '市辖区', '', 3, '浙江省', '舟山市', '市辖区', 0, 1, '330900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1413', 'cn', '330902000000', '定海区', '', 3, '浙江省', '舟山市', '定海区', 0, 1, '330900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1414', 'cn', '330903000000', '普陀区', '', 3, '浙江省', '舟山市', '普陀区', 0, 1, '330900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1415', 'cn', '330921000000', '岱山县', '', 3, '浙江省', '舟山市', '岱山县', 0, 1, '330900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1416', 'cn', '330922000000', '嵊泗县', '', 3, '浙江省', '舟山市', '嵊泗县', 0, 1, '330900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1417', 'cn', '331001000000', '市辖区', '', 3, '浙江省', '台州市', '市辖区', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1418', 'cn', '331002000000', '椒江区', '', 3, '浙江省', '台州市', '椒江区', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1419', 'cn', '331003000000', '黄岩区', '', 3, '浙江省', '台州市', '黄岩区', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('142', 'cn', '341600000000', '亳州市', '', 2, '安徽省', '亳州市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1420', 'cn', '331004000000', '路桥区', '', 3, '浙江省', '台州市', '路桥区', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1421', 'cn', '331022000000', '三门县', '', 3, '浙江省', '台州市', '三门县', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1422', 'cn', '331023000000', '天台县', '', 3, '浙江省', '台州市', '天台县', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1423', 'cn', '331024000000', '仙居县', '', 3, '浙江省', '台州市', '仙居县', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1424', 'cn', '331081000000', '温岭市', '', 3, '浙江省', '台州市', '温岭市', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1425', 'cn', '331082000000', '临海市', '', 3, '浙江省', '台州市', '临海市', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1426', 'cn', '331083000000', '玉环市', '', 3, '浙江省', '台州市', '玉环市', 0, 1, '331000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1427', 'cn', '331101000000', '市辖区', '', 3, '浙江省', '丽水市', '市辖区', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1428', 'cn', '331102000000', '莲都区', '', 3, '浙江省', '丽水市', '莲都区', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1429', 'cn', '331121000000', '青田县', '', 3, '浙江省', '丽水市', '青田县', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('143', 'cn', '341700000000', '池州市', '', 2, '安徽省', '池州市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1430', 'cn', '331122000000', '缙云县', '', 3, '浙江省', '丽水市', '缙云县', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1431', 'cn', '331123000000', '遂昌县', '', 3, '浙江省', '丽水市', '遂昌县', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1432', 'cn', '331124000000', '松阳县', '', 3, '浙江省', '丽水市', '松阳县', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1433', 'cn', '331125000000', '云和县', '', 3, '浙江省', '丽水市', '云和县', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1434', 'cn', '331126000000', '庆元县', '', 3, '浙江省', '丽水市', '庆元县', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1435', 'cn', '331127000000', '景宁畲族自治县', '', 3, '浙江省', '丽水市', '景宁畲族自治县', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1436', 'cn', '331181000000', '龙泉市', '', 3, '浙江省', '丽水市', '龙泉市', 0, 1, '331100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1437', 'cn', '340101000000', '市辖区', '', 3, '安徽省', '合肥市', '市辖区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1438', 'cn', '340102000000', '瑶海区', '', 3, '安徽省', '合肥市', '瑶海区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1439', 'cn', '340103000000', '庐阳区', '', 3, '安徽省', '合肥市', '庐阳区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('144', 'cn', '341800000000', '宣城市', '', 2, '安徽省', '宣城市', '', 0, 1, '340000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1440', 'cn', '340104000000', '蜀山区', '', 3, '安徽省', '合肥市', '蜀山区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1441', 'cn', '340111000000', '包河区', '', 3, '安徽省', '合肥市', '包河区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1442', 'cn', '340121000000', '长丰县', '', 3, '安徽省', '合肥市', '长丰县', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1443', 'cn', '340122000000', '肥东县', '', 3, '安徽省', '合肥市', '肥东县', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1444', 'cn', '340123000000', '肥西县', '', 3, '安徽省', '合肥市', '肥西县', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1445', 'cn', '340124000000', '庐江县', '', 3, '安徽省', '合肥市', '庐江县', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1446', 'cn', '340171000000', '合肥高新技术产业开发区', '', 3, '安徽省', '合肥市', '合肥高新技术产业开发区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1447', 'cn', '340172000000', '合肥经济技术开发区', '', 3, '安徽省', '合肥市', '合肥经济技术开发区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1448', 'cn', '340173000000', '合肥新站高新技术产业开发区', '', 3, '安徽省', '合肥市', '合肥新站高新技术产业开发区', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1449', 'cn', '340181000000', '巢湖市', '', 3, '安徽省', '合肥市', '巢湖市', 0, 1, '340100000000');
INSERT INTO SYS_NATION_AREA VALUES ('145', 'cn', '350100000000', '福州市', '', 2, '福建省', '福州市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1450', 'cn', '340201000000', '市辖区', '', 3, '安徽省', '芜湖市', '市辖区', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1451', 'cn', '340202000000', '镜湖区', '', 3, '安徽省', '芜湖市', '镜湖区', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1452', 'cn', '340203000000', '弋江区', '', 3, '安徽省', '芜湖市', '弋江区', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1453', 'cn', '340207000000', '鸠江区', '', 3, '安徽省', '芜湖市', '鸠江区', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1454', 'cn', '340208000000', '三山区', '', 3, '安徽省', '芜湖市', '三山区', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1455', 'cn', '340221000000', '芜湖县', '', 3, '安徽省', '芜湖市', '芜湖县', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1456', 'cn', '340222000000', '繁昌县', '', 3, '安徽省', '芜湖市', '繁昌县', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1457', 'cn', '340223000000', '南陵县', '', 3, '安徽省', '芜湖市', '南陵县', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1458', 'cn', '340225000000', '无为县', '', 3, '安徽省', '芜湖市', '无为县', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1459', 'cn', '340271000000', '芜湖经济技术开发区', '', 3, '安徽省', '芜湖市', '芜湖经济技术开发区', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('146', 'cn', '350200000000', '厦门市', '', 2, '福建省', '厦门市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1460', 'cn', '340272000000', '安徽芜湖长江大桥经济开发区', '', 3, '安徽省', '芜湖市', '安徽芜湖长江大桥经济开发区', 0, 1, '340200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1461', 'cn', '340301000000', '市辖区', '', 3, '安徽省', '蚌埠市', '市辖区', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1462', 'cn', '340302000000', '龙子湖区', '', 3, '安徽省', '蚌埠市', '龙子湖区', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1463', 'cn', '340303000000', '蚌山区', '', 3, '安徽省', '蚌埠市', '蚌山区', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1464', 'cn', '340304000000', '禹会区', '', 3, '安徽省', '蚌埠市', '禹会区', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1465', 'cn', '340311000000', '淮上区', '', 3, '安徽省', '蚌埠市', '淮上区', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1466', 'cn', '340321000000', '怀远县', '', 3, '安徽省', '蚌埠市', '怀远县', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1467', 'cn', '340322000000', '五河县', '', 3, '安徽省', '蚌埠市', '五河县', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1468', 'cn', '340323000000', '固镇县', '', 3, '安徽省', '蚌埠市', '固镇县', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1469', 'cn', '340371000000', '蚌埠市高新技术开发区', '', 3, '安徽省', '蚌埠市', '蚌埠市高新技术开发区', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('147', 'cn', '350300000000', '莆田市', '', 2, '福建省', '莆田市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1470', 'cn', '340372000000', '蚌埠市经济开发区', '', 3, '安徽省', '蚌埠市', '蚌埠市经济开发区', 0, 1, '340300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1471', 'cn', '340401000000', '市辖区', '', 3, '安徽省', '淮南市', '市辖区', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1472', 'cn', '340402000000', '大通区', '', 3, '安徽省', '淮南市', '大通区', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1473', 'cn', '340403000000', '田家庵区', '', 3, '安徽省', '淮南市', '田家庵区', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1474', 'cn', '340404000000', '谢家集区', '', 3, '安徽省', '淮南市', '谢家集区', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1475', 'cn', '340405000000', '八公山区', '', 3, '安徽省', '淮南市', '八公山区', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1476', 'cn', '340406000000', '潘集区', '', 3, '安徽省', '淮南市', '潘集区', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1477', 'cn', '340421000000', '凤台县', '', 3, '安徽省', '淮南市', '凤台县', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1478', 'cn', '340422000000', '寿县', '', 3, '安徽省', '淮南市', '寿县', 0, 1, '340400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1479', 'cn', '340501000000', '市辖区', '', 3, '安徽省', '马鞍山市', '市辖区', 0, 1, '340500000000');
INSERT INTO SYS_NATION_AREA VALUES ('148', 'cn', '350400000000', '三明市', '', 2, '福建省', '三明市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1480', 'cn', '340503000000', '花山区', '', 3, '安徽省', '马鞍山市', '花山区', 0, 1, '340500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1481', 'cn', '340504000000', '雨山区', '', 3, '安徽省', '马鞍山市', '雨山区', 0, 1, '340500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1482', 'cn', '340506000000', '博望区', '', 3, '安徽省', '马鞍山市', '博望区', 0, 1, '340500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1483', 'cn', '340521000000', '当涂县', '', 3, '安徽省', '马鞍山市', '当涂县', 0, 1, '340500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1484', 'cn', '340522000000', '含山县', '', 3, '安徽省', '马鞍山市', '含山县', 0, 1, '340500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1485', 'cn', '340523000000', '和县', '', 3, '安徽省', '马鞍山市', '和县', 0, 1, '340500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1486', 'cn', '340601000000', '市辖区', '', 3, '安徽省', '淮北市', '市辖区', 0, 1, '340600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1487', 'cn', '340602000000', '杜集区', '', 3, '安徽省', '淮北市', '杜集区', 0, 1, '340600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1488', 'cn', '340603000000', '相山区', '', 3, '安徽省', '淮北市', '相山区', 0, 1, '340600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1489', 'cn', '340604000000', '烈山区', '', 3, '安徽省', '淮北市', '烈山区', 0, 1, '340600000000');
INSERT INTO SYS_NATION_AREA VALUES ('149', 'cn', '350500000000', '泉州市', '', 2, '福建省', '泉州市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1490', 'cn', '340621000000', '濉溪县', '', 3, '安徽省', '淮北市', '濉溪县', 0, 1, '340600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1491', 'cn', '340701000000', '市辖区', '', 3, '安徽省', '铜陵市', '市辖区', 0, 1, '340700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1492', 'cn', '340705000000', '铜官区', '', 3, '安徽省', '铜陵市', '铜官区', 0, 1, '340700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1493', 'cn', '340706000000', '义安区', '', 3, '安徽省', '铜陵市', '义安区', 0, 1, '340700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1494', 'cn', '340711000000', '郊区', '', 3, '安徽省', '铜陵市', '郊区', 0, 1, '340700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1495', 'cn', '340722000000', '枞阳县', '', 3, '安徽省', '铜陵市', '枞阳县', 0, 1, '340700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1496', 'cn', '340801000000', '市辖区', '', 3, '安徽省', '安庆市', '市辖区', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1497', 'cn', '340802000000', '迎江区', '', 3, '安徽省', '安庆市', '迎江区', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1498', 'cn', '340803000000', '大观区', '', 3, '安徽省', '安庆市', '大观区', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1499', 'cn', '340811000000', '宜秀区', '', 3, '安徽省', '安庆市', '宜秀区', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('15', 'cn', '370000000000', '山东省', '', 1, '山东省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('150', 'cn', '350600000000', '漳州市', '', 2, '福建省', '漳州市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1500', 'cn', '340822000000', '怀宁县', '', 3, '安徽省', '安庆市', '怀宁县', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1501', 'cn', '340824000000', '潜山县', '', 3, '安徽省', '安庆市', '潜山县', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1502', 'cn', '340825000000', '太湖县', '', 3, '安徽省', '安庆市', '太湖县', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1503', 'cn', '340826000000', '宿松县', '', 3, '安徽省', '安庆市', '宿松县', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1504', 'cn', '340827000000', '望江县', '', 3, '安徽省', '安庆市', '望江县', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1505', 'cn', '340828000000', '岳西县', '', 3, '安徽省', '安庆市', '岳西县', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1506', 'cn', '340871000000', '安徽安庆经济开发区', '', 3, '安徽省', '安庆市', '安徽安庆经济开发区', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1507', 'cn', '340881000000', '桐城市', '', 3, '安徽省', '安庆市', '桐城市', 0, 1, '340800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1508', 'cn', '341001000000', '市辖区', '', 3, '安徽省', '黄山市', '市辖区', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1509', 'cn', '341002000000', '屯溪区', '', 3, '安徽省', '黄山市', '屯溪区', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('151', 'cn', '350700000000', '南平市', '', 2, '福建省', '南平市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1510', 'cn', '341003000000', '黄山区', '', 3, '安徽省', '黄山市', '黄山区', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1511', 'cn', '341004000000', '徽州区', '', 3, '安徽省', '黄山市', '徽州区', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1512', 'cn', '341021000000', '歙县', '', 3, '安徽省', '黄山市', '歙县', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1513', 'cn', '341022000000', '休宁县', '', 3, '安徽省', '黄山市', '休宁县', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1514', 'cn', '341023000000', '黟县', '', 3, '安徽省', '黄山市', '黟县', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1515', 'cn', '341024000000', '祁门县', '', 3, '安徽省', '黄山市', '祁门县', 0, 1, '341000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1516', 'cn', '341101000000', '市辖区', '', 3, '安徽省', '滁州市', '市辖区', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1517', 'cn', '341102000000', '琅琊区', '', 3, '安徽省', '滁州市', '琅琊区', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1518', 'cn', '341103000000', '南谯区', '', 3, '安徽省', '滁州市', '南谯区', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1519', 'cn', '341122000000', '来安县', '', 3, '安徽省', '滁州市', '来安县', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('152', 'cn', '350800000000', '龙岩市', '', 2, '福建省', '龙岩市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1520', 'cn', '341124000000', '全椒县', '', 3, '安徽省', '滁州市', '全椒县', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1521', 'cn', '341125000000', '定远县', '', 3, '安徽省', '滁州市', '定远县', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1522', 'cn', '341126000000', '凤阳县', '', 3, '安徽省', '滁州市', '凤阳县', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1523', 'cn', '341171000000', '苏滁现代产业园', '', 3, '安徽省', '滁州市', '苏滁现代产业园', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1524', 'cn', '341172000000', '滁州经济技术开发区', '', 3, '安徽省', '滁州市', '滁州经济技术开发区', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1525', 'cn', '341181000000', '天长市', '', 3, '安徽省', '滁州市', '天长市', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1526', 'cn', '341182000000', '明光市', '', 3, '安徽省', '滁州市', '明光市', 0, 1, '341100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1527', 'cn', '341201000000', '市辖区', '', 3, '安徽省', '阜阳市', '市辖区', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1528', 'cn', '341202000000', '颍州区', '', 3, '安徽省', '阜阳市', '颍州区', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1529', 'cn', '341203000000', '颍东区', '', 3, '安徽省', '阜阳市', '颍东区', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('153', 'cn', '350900000000', '宁德市', '', 2, '福建省', '宁德市', '', 0, 1, '350000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1530', 'cn', '341204000000', '颍泉区', '', 3, '安徽省', '阜阳市', '颍泉区', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1531', 'cn', '341221000000', '临泉县', '', 3, '安徽省', '阜阳市', '临泉县', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1532', 'cn', '341222000000', '太和县', '', 3, '安徽省', '阜阳市', '太和县', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1533', 'cn', '341225000000', '阜南县', '', 3, '安徽省', '阜阳市', '阜南县', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1534', 'cn', '341226000000', '颍上县', '', 3, '安徽省', '阜阳市', '颍上县', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1535', 'cn', '341271000000', '阜阳合肥现代产业园区', '', 3, '安徽省', '阜阳市', '阜阳合肥现代产业园区', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1536', 'cn', '341272000000', '阜阳经济技术开发区', '', 3, '安徽省', '阜阳市', '阜阳经济技术开发区', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1537', 'cn', '341282000000', '界首市', '', 3, '安徽省', '阜阳市', '界首市', 0, 1, '341200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1538', 'cn', '341301000000', '市辖区', '', 3, '安徽省', '宿州市', '市辖区', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1539', 'cn', '341302000000', '埇桥区', '', 3, '安徽省', '宿州市', '埇桥区', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('154', 'cn', '360100000000', '南昌市', '', 2, '江西省', '南昌市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1540', 'cn', '341321000000', '砀山县', '', 3, '安徽省', '宿州市', '砀山县', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1541', 'cn', '341322000000', '萧县', '', 3, '安徽省', '宿州市', '萧县', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1542', 'cn', '341323000000', '灵璧县', '', 3, '安徽省', '宿州市', '灵璧县', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1543', 'cn', '341324000000', '泗县', '', 3, '安徽省', '宿州市', '泗县', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1544', 'cn', '341371000000', '宿州马鞍山现代产业园区', '', 3, '安徽省', '宿州市', '宿州马鞍山现代产业园区', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1545', 'cn', '341372000000', '宿州经济技术开发区', '', 3, '安徽省', '宿州市', '宿州经济技术开发区', 0, 1, '341300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1546', 'cn', '341501000000', '市辖区', '', 3, '安徽省', '六安市', '市辖区', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1547', 'cn', '341502000000', '金安区', '', 3, '安徽省', '六安市', '金安区', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1548', 'cn', '341503000000', '裕安区', '', 3, '安徽省', '六安市', '裕安区', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1549', 'cn', '341504000000', '叶集区', '', 3, '安徽省', '六安市', '叶集区', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('155', 'cn', '360200000000', '景德镇市', '', 2, '江西省', '景德镇市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1550', 'cn', '341522000000', '霍邱县', '', 3, '安徽省', '六安市', '霍邱县', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1551', 'cn', '341523000000', '舒城县', '', 3, '安徽省', '六安市', '舒城县', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1552', 'cn', '341524000000', '金寨县', '', 3, '安徽省', '六安市', '金寨县', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1553', 'cn', '341525000000', '霍山县', '', 3, '安徽省', '六安市', '霍山县', 0, 1, '341500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1554', 'cn', '341601000000', '市辖区', '', 3, '安徽省', '亳州市', '市辖区', 0, 1, '341600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1555', 'cn', '341602000000', '谯城区', '', 3, '安徽省', '亳州市', '谯城区', 0, 1, '341600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1556', 'cn', '341621000000', '涡阳县', '', 3, '安徽省', '亳州市', '涡阳县', 0, 1, '341600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1557', 'cn', '341622000000', '蒙城县', '', 3, '安徽省', '亳州市', '蒙城县', 0, 1, '341600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1558', 'cn', '341623000000', '利辛县', '', 3, '安徽省', '亳州市', '利辛县', 0, 1, '341600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1559', 'cn', '341701000000', '市辖区', '', 3, '安徽省', '池州市', '市辖区', 0, 1, '341700000000');
INSERT INTO SYS_NATION_AREA VALUES ('156', 'cn', '360300000000', '萍乡市', '', 2, '江西省', '萍乡市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1560', 'cn', '341702000000', '贵池区', '', 3, '安徽省', '池州市', '贵池区', 0, 1, '341700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1561', 'cn', '341721000000', '东至县', '', 3, '安徽省', '池州市', '东至县', 0, 1, '341700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1562', 'cn', '341722000000', '石台县', '', 3, '安徽省', '池州市', '石台县', 0, 1, '341700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1563', 'cn', '341723000000', '青阳县', '', 3, '安徽省', '池州市', '青阳县', 0, 1, '341700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1564', 'cn', '341801000000', '市辖区', '', 3, '安徽省', '宣城市', '市辖区', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1565', 'cn', '341802000000', '宣州区', '', 3, '安徽省', '宣城市', '宣州区', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1566', 'cn', '341821000000', '郎溪县', '', 3, '安徽省', '宣城市', '郎溪县', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1567', 'cn', '341822000000', '广德县', '', 3, '安徽省', '宣城市', '广德县', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1568', 'cn', '341823000000', '泾县', '', 3, '安徽省', '宣城市', '泾县', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1569', 'cn', '341824000000', '绩溪县', '', 3, '安徽省', '宣城市', '绩溪县', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('157', 'cn', '360400000000', '九江市', '', 2, '江西省', '九江市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1570', 'cn', '341825000000', '旌德县', '', 3, '安徽省', '宣城市', '旌德县', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1571', 'cn', '341871000000', '宣城市经济开发区', '', 3, '安徽省', '宣城市', '宣城市经济开发区', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1572', 'cn', '341881000000', '宁国市', '', 3, '安徽省', '宣城市', '宁国市', 0, 1, '341800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1573', 'cn', '350101000000', '市辖区', '', 3, '福建省', '福州市', '市辖区', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1574', 'cn', '350102000000', '鼓楼区', '', 3, '福建省', '福州市', '鼓楼区', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1575', 'cn', '350103000000', '台江区', '', 3, '福建省', '福州市', '台江区', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1576', 'cn', '350104000000', '仓山区', '', 3, '福建省', '福州市', '仓山区', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1577', 'cn', '350105000000', '马尾区', '', 3, '福建省', '福州市', '马尾区', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1578', 'cn', '350111000000', '晋安区', '', 3, '福建省', '福州市', '晋安区', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1579', 'cn', '350121000000', '闽侯县', '', 3, '福建省', '福州市', '闽侯县', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('158', 'cn', '360500000000', '新余市', '', 2, '江西省', '新余市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1580', 'cn', '350122000000', '连江县', '', 3, '福建省', '福州市', '连江县', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1581', 'cn', '350123000000', '罗源县', '', 3, '福建省', '福州市', '罗源县', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1582', 'cn', '350124000000', '闽清县', '', 3, '福建省', '福州市', '闽清县', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1583', 'cn', '350125000000', '永泰县', '', 3, '福建省', '福州市', '永泰县', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1584', 'cn', '350128000000', '平潭县', '', 3, '福建省', '福州市', '平潭县', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1585', 'cn', '350181000000', '福清市', '', 3, '福建省', '福州市', '福清市', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1586', 'cn', '350182000000', '长乐市', '', 3, '福建省', '福州市', '长乐市', 0, 1, '350100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1587', 'cn', '350201000000', '市辖区', '', 3, '福建省', '厦门市', '市辖区', 0, 1, '350200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1588', 'cn', '350203000000', '思明区', '', 3, '福建省', '厦门市', '思明区', 0, 1, '350200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1589', 'cn', '350205000000', '海沧区', '', 3, '福建省', '厦门市', '海沧区', 0, 1, '350200000000');
INSERT INTO SYS_NATION_AREA VALUES ('159', 'cn', '360600000000', '鹰潭市', '', 2, '江西省', '鹰潭市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1590', 'cn', '350206000000', '湖里区', '', 3, '福建省', '厦门市', '湖里区', 0, 1, '350200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1591', 'cn', '350211000000', '集美区', '', 3, '福建省', '厦门市', '集美区', 0, 1, '350200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1592', 'cn', '350212000000', '同安区', '', 3, '福建省', '厦门市', '同安区', 0, 1, '350200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1593', 'cn', '350213000000', '翔安区', '', 3, '福建省', '厦门市', '翔安区', 0, 1, '350200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1594', 'cn', '350301000000', '市辖区', '', 3, '福建省', '莆田市', '市辖区', 0, 1, '350300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1595', 'cn', '350302000000', '城厢区', '', 3, '福建省', '莆田市', '城厢区', 0, 1, '350300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1596', 'cn', '350303000000', '涵江区', '', 3, '福建省', '莆田市', '涵江区', 0, 1, '350300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1597', 'cn', '350304000000', '荔城区', '', 3, '福建省', '莆田市', '荔城区', 0, 1, '350300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1598', 'cn', '350305000000', '秀屿区', '', 3, '福建省', '莆田市', '秀屿区', 0, 1, '350300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1599', 'cn', '350322000000', '仙游县', '', 3, '福建省', '莆田市', '仙游县', 0, 1, '350300000000');
INSERT INTO SYS_NATION_AREA VALUES ('16', 'cn', '410000000000', '河南省', '', 1, '河南省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('160', 'cn', '360700000000', '赣州市', '', 2, '江西省', '赣州市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1600', 'cn', '350401000000', '市辖区', '', 3, '福建省', '三明市', '市辖区', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1601', 'cn', '350402000000', '梅列区', '', 3, '福建省', '三明市', '梅列区', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1602', 'cn', '350403000000', '三元区', '', 3, '福建省', '三明市', '三元区', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1603', 'cn', '350421000000', '明溪县', '', 3, '福建省', '三明市', '明溪县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1604', 'cn', '350423000000', '清流县', '', 3, '福建省', '三明市', '清流县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1605', 'cn', '350424000000', '宁化县', '', 3, '福建省', '三明市', '宁化县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1606', 'cn', '350425000000', '大田县', '', 3, '福建省', '三明市', '大田县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1607', 'cn', '350426000000', '尤溪县', '', 3, '福建省', '三明市', '尤溪县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1608', 'cn', '350427000000', '沙县', '', 3, '福建省', '三明市', '沙县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1609', 'cn', '350428000000', '将乐县', '', 3, '福建省', '三明市', '将乐县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('161', 'cn', '360800000000', '吉安市', '', 2, '江西省', '吉安市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1610', 'cn', '350429000000', '泰宁县', '', 3, '福建省', '三明市', '泰宁县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1611', 'cn', '350430000000', '建宁县', '', 3, '福建省', '三明市', '建宁县', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1612', 'cn', '350481000000', '永安市', '', 3, '福建省', '三明市', '永安市', 0, 1, '350400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1613', 'cn', '350501000000', '市辖区', '', 3, '福建省', '泉州市', '市辖区', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1614', 'cn', '350502000000', '鲤城区', '', 3, '福建省', '泉州市', '鲤城区', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1615', 'cn', '350503000000', '丰泽区', '', 3, '福建省', '泉州市', '丰泽区', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1616', 'cn', '350504000000', '洛江区', '', 3, '福建省', '泉州市', '洛江区', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1617', 'cn', '350505000000', '泉港区', '', 3, '福建省', '泉州市', '泉港区', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1618', 'cn', '350521000000', '惠安县', '', 3, '福建省', '泉州市', '惠安县', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1619', 'cn', '350524000000', '安溪县', '', 3, '福建省', '泉州市', '安溪县', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('162', 'cn', '360900000000', '宜春市', '', 2, '江西省', '宜春市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1620', 'cn', '350525000000', '永春县', '', 3, '福建省', '泉州市', '永春县', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1621', 'cn', '350526000000', '德化县', '', 3, '福建省', '泉州市', '德化县', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1622', 'cn', '350527000000', '金门县', '', 3, '福建省', '泉州市', '金门县', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1623', 'cn', '350581000000', '石狮市', '', 3, '福建省', '泉州市', '石狮市', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1624', 'cn', '350582000000', '晋江市', '', 3, '福建省', '泉州市', '晋江市', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1625', 'cn', '350583000000', '南安市', '', 3, '福建省', '泉州市', '南安市', 0, 1, '350500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1626', 'cn', '350601000000', '市辖区', '', 3, '福建省', '漳州市', '市辖区', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1627', 'cn', '350602000000', '芗城区', '', 3, '福建省', '漳州市', '芗城区', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1628', 'cn', '350603000000', '龙文区', '', 3, '福建省', '漳州市', '龙文区', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1629', 'cn', '350622000000', '云霄县', '', 3, '福建省', '漳州市', '云霄县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('163', 'cn', '361000000000', '抚州市', '', 2, '江西省', '抚州市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1630', 'cn', '350623000000', '漳浦县', '', 3, '福建省', '漳州市', '漳浦县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1631', 'cn', '350624000000', '诏安县', '', 3, '福建省', '漳州市', '诏安县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1632', 'cn', '350625000000', '长泰县', '', 3, '福建省', '漳州市', '长泰县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1633', 'cn', '350626000000', '东山县', '', 3, '福建省', '漳州市', '东山县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1634', 'cn', '350627000000', '南靖县', '', 3, '福建省', '漳州市', '南靖县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1635', 'cn', '350628000000', '平和县', '', 3, '福建省', '漳州市', '平和县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1636', 'cn', '350629000000', '华安县', '', 3, '福建省', '漳州市', '华安县', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1637', 'cn', '350681000000', '龙海市', '', 3, '福建省', '漳州市', '龙海市', 0, 1, '350600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1638', 'cn', '350701000000', '市辖区', '', 3, '福建省', '南平市', '市辖区', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1639', 'cn', '350702000000', '延平区', '', 3, '福建省', '南平市', '延平区', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('164', 'cn', '361100000000', '上饶市', '', 2, '江西省', '上饶市', '', 0, 1, '360000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1640', 'cn', '350703000000', '建阳区', '', 3, '福建省', '南平市', '建阳区', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1641', 'cn', '350721000000', '顺昌县', '', 3, '福建省', '南平市', '顺昌县', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1642', 'cn', '350722000000', '浦城县', '', 3, '福建省', '南平市', '浦城县', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1643', 'cn', '350723000000', '光泽县', '', 3, '福建省', '南平市', '光泽县', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1644', 'cn', '350724000000', '松溪县', '', 3, '福建省', '南平市', '松溪县', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1645', 'cn', '350725000000', '政和县', '', 3, '福建省', '南平市', '政和县', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1646', 'cn', '350781000000', '邵武市', '', 3, '福建省', '南平市', '邵武市', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1647', 'cn', '350782000000', '武夷山市', '', 3, '福建省', '南平市', '武夷山市', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1648', 'cn', '350783000000', '建瓯市', '', 3, '福建省', '南平市', '建瓯市', 0, 1, '350700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1649', 'cn', '350801000000', '市辖区', '', 3, '福建省', '龙岩市', '市辖区', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('165', 'cn', '370100000000', '济南市', '', 2, '山东省', '济南市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1650', 'cn', '350802000000', '新罗区', '', 3, '福建省', '龙岩市', '新罗区', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1651', 'cn', '350803000000', '永定区', '', 3, '福建省', '龙岩市', '永定区', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1652', 'cn', '350821000000', '长汀县', '', 3, '福建省', '龙岩市', '长汀县', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1653', 'cn', '350823000000', '上杭县', '', 3, '福建省', '龙岩市', '上杭县', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1654', 'cn', '350824000000', '武平县', '', 3, '福建省', '龙岩市', '武平县', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1655', 'cn', '350825000000', '连城县', '', 3, '福建省', '龙岩市', '连城县', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1656', 'cn', '350881000000', '漳平市', '', 3, '福建省', '龙岩市', '漳平市', 0, 1, '350800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1657', 'cn', '350901000000', '市辖区', '', 3, '福建省', '宁德市', '市辖区', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1658', 'cn', '350902000000', '蕉城区', '', 3, '福建省', '宁德市', '蕉城区', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1659', 'cn', '350921000000', '霞浦县', '', 3, '福建省', '宁德市', '霞浦县', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('166', 'cn', '370200000000', '青岛市', '', 2, '山东省', '青岛市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1660', 'cn', '350922000000', '古田县', '', 3, '福建省', '宁德市', '古田县', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1661', 'cn', '350923000000', '屏南县', '', 3, '福建省', '宁德市', '屏南县', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1662', 'cn', '350924000000', '寿宁县', '', 3, '福建省', '宁德市', '寿宁县', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1663', 'cn', '350925000000', '周宁县', '', 3, '福建省', '宁德市', '周宁县', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1664', 'cn', '350926000000', '柘荣县', '', 3, '福建省', '宁德市', '柘荣县', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1665', 'cn', '350981000000', '福安市', '', 3, '福建省', '宁德市', '福安市', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1666', 'cn', '350982000000', '福鼎市', '', 3, '福建省', '宁德市', '福鼎市', 0, 1, '350900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1667', 'cn', '360101000000', '市辖区', '', 3, '江西省', '南昌市', '市辖区', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1668', 'cn', '360102000000', '东湖区', '', 3, '江西省', '南昌市', '东湖区', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1669', 'cn', '360103000000', '西湖区', '', 3, '江西省', '南昌市', '西湖区', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('167', 'cn', '370300000000', '淄博市', '', 2, '山东省', '淄博市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1670', 'cn', '360104000000', '青云谱区', '', 3, '江西省', '南昌市', '青云谱区', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1671', 'cn', '360105000000', '湾里区', '', 3, '江西省', '南昌市', '湾里区', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1672', 'cn', '360111000000', '青山湖区', '', 3, '江西省', '南昌市', '青山湖区', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1673', 'cn', '360112000000', '新建区', '', 3, '江西省', '南昌市', '新建区', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1674', 'cn', '360121000000', '南昌县', '', 3, '江西省', '南昌市', '南昌县', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1675', 'cn', '360123000000', '安义县', '', 3, '江西省', '南昌市', '安义县', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1676', 'cn', '360124000000', '进贤县', '', 3, '江西省', '南昌市', '进贤县', 0, 1, '360100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1677', 'cn', '360201000000', '市辖区', '', 3, '江西省', '景德镇市', '市辖区', 0, 1, '360200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1678', 'cn', '360202000000', '昌江区', '', 3, '江西省', '景德镇市', '昌江区', 0, 1, '360200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1679', 'cn', '360203000000', '珠山区', '', 3, '江西省', '景德镇市', '珠山区', 0, 1, '360200000000');
INSERT INTO SYS_NATION_AREA VALUES ('168', 'cn', '370400000000', '枣庄市', '', 2, '山东省', '枣庄市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1680', 'cn', '360222000000', '浮梁县', '', 3, '江西省', '景德镇市', '浮梁县', 0, 1, '360200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1681', 'cn', '360281000000', '乐平市', '', 3, '江西省', '景德镇市', '乐平市', 0, 1, '360200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1682', 'cn', '360301000000', '市辖区', '', 3, '江西省', '萍乡市', '市辖区', 0, 1, '360300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1683', 'cn', '360302000000', '安源区', '', 3, '江西省', '萍乡市', '安源区', 0, 1, '360300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1684', 'cn', '360313000000', '湘东区', '', 3, '江西省', '萍乡市', '湘东区', 0, 1, '360300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1685', 'cn', '360321000000', '莲花县', '', 3, '江西省', '萍乡市', '莲花县', 0, 1, '360300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1686', 'cn', '360322000000', '上栗县', '', 3, '江西省', '萍乡市', '上栗县', 0, 1, '360300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1687', 'cn', '360323000000', '芦溪县', '', 3, '江西省', '萍乡市', '芦溪县', 0, 1, '360300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1688', 'cn', '360401000000', '市辖区', '', 3, '江西省', '九江市', '市辖区', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1689', 'cn', '360402000000', '濂溪区', '', 3, '江西省', '九江市', '濂溪区', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('169', 'cn', '370500000000', '东营市', '', 2, '山东省', '东营市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1690', 'cn', '360403000000', '浔阳区', '', 3, '江西省', '九江市', '浔阳区', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1691', 'cn', '360404000000', '柴桑区', '', 3, '江西省', '九江市', '柴桑区', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1692', 'cn', '360423000000', '武宁县', '', 3, '江西省', '九江市', '武宁县', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1693', 'cn', '360424000000', '修水县', '', 3, '江西省', '九江市', '修水县', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1694', 'cn', '360425000000', '永修县', '', 3, '江西省', '九江市', '永修县', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1695', 'cn', '360426000000', '德安县', '', 3, '江西省', '九江市', '德安县', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1696', 'cn', '360428000000', '都昌县', '', 3, '江西省', '九江市', '都昌县', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1697', 'cn', '360429000000', '湖口县', '', 3, '江西省', '九江市', '湖口县', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1698', 'cn', '360430000000', '彭泽县', '', 3, '江西省', '九江市', '彭泽县', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1699', 'cn', '360481000000', '瑞昌市', '', 3, '江西省', '九江市', '瑞昌市', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('17', 'cn', '420000000000', '湖北省', '', 1, '湖北省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('170', 'cn', '370600000000', '烟台市', '', 2, '山东省', '烟台市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1700', 'cn', '360482000000', '共青城市', '', 3, '江西省', '九江市', '共青城市', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1701', 'cn', '360483000000', '庐山市', '', 3, '江西省', '九江市', '庐山市', 0, 1, '360400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1702', 'cn', '360501000000', '市辖区', '', 3, '江西省', '新余市', '市辖区', 0, 1, '360500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1703', 'cn', '360502000000', '渝水区', '', 3, '江西省', '新余市', '渝水区', 0, 1, '360500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1704', 'cn', '360521000000', '分宜县', '', 3, '江西省', '新余市', '分宜县', 0, 1, '360500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1705', 'cn', '360601000000', '市辖区', '', 3, '江西省', '鹰潭市', '市辖区', 0, 1, '360600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1706', 'cn', '360602000000', '月湖区', '', 3, '江西省', '鹰潭市', '月湖区', 0, 1, '360600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1707', 'cn', '360622000000', '余江县', '', 3, '江西省', '鹰潭市', '余江县', 0, 1, '360600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1708', 'cn', '360681000000', '贵溪市', '', 3, '江西省', '鹰潭市', '贵溪市', 0, 1, '360600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1709', 'cn', '360701000000', '市辖区', '', 3, '江西省', '赣州市', '市辖区', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('171', 'cn', '370700000000', '潍坊市', '', 2, '山东省', '潍坊市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1710', 'cn', '360702000000', '章贡区', '', 3, '江西省', '赣州市', '章贡区', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1711', 'cn', '360703000000', '南康区', '', 3, '江西省', '赣州市', '南康区', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1712', 'cn', '360704000000', '赣县区', '', 3, '江西省', '赣州市', '赣县区', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1713', 'cn', '360722000000', '信丰县', '', 3, '江西省', '赣州市', '信丰县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1714', 'cn', '360723000000', '大余县', '', 3, '江西省', '赣州市', '大余县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1715', 'cn', '360724000000', '上犹县', '', 3, '江西省', '赣州市', '上犹县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1716', 'cn', '360725000000', '崇义县', '', 3, '江西省', '赣州市', '崇义县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1717', 'cn', '360726000000', '安远县', '', 3, '江西省', '赣州市', '安远县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1718', 'cn', '360727000000', '龙南县', '', 3, '江西省', '赣州市', '龙南县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1719', 'cn', '360728000000', '定南县', '', 3, '江西省', '赣州市', '定南县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('172', 'cn', '370800000000', '济宁市', '', 2, '山东省', '济宁市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1720', 'cn', '360729000000', '全南县', '', 3, '江西省', '赣州市', '全南县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1721', 'cn', '360730000000', '宁都县', '', 3, '江西省', '赣州市', '宁都县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1722', 'cn', '360731000000', '于都县', '', 3, '江西省', '赣州市', '于都县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1723', 'cn', '360732000000', '兴国县', '', 3, '江西省', '赣州市', '兴国县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1724', 'cn', '360733000000', '会昌县', '', 3, '江西省', '赣州市', '会昌县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1725', 'cn', '360734000000', '寻乌县', '', 3, '江西省', '赣州市', '寻乌县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1726', 'cn', '360735000000', '石城县', '', 3, '江西省', '赣州市', '石城县', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1727', 'cn', '360781000000', '瑞金市', '', 3, '江西省', '赣州市', '瑞金市', 0, 1, '360700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1728', 'cn', '360801000000', '市辖区', '', 3, '江西省', '吉安市', '市辖区', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1729', 'cn', '360802000000', '吉州区', '', 3, '江西省', '吉安市', '吉州区', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('173', 'cn', '370900000000', '泰安市', '', 2, '山东省', '泰安市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1730', 'cn', '360803000000', '青原区', '', 3, '江西省', '吉安市', '青原区', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1731', 'cn', '360821000000', '吉安县', '', 3, '江西省', '吉安市', '吉安县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1732', 'cn', '360822000000', '吉水县', '', 3, '江西省', '吉安市', '吉水县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1733', 'cn', '360823000000', '峡江县', '', 3, '江西省', '吉安市', '峡江县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1734', 'cn', '360824000000', '新干县', '', 3, '江西省', '吉安市', '新干县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1735', 'cn', '360825000000', '永丰县', '', 3, '江西省', '吉安市', '永丰县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1736', 'cn', '360826000000', '泰和县', '', 3, '江西省', '吉安市', '泰和县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1737', 'cn', '360827000000', '遂川县', '', 3, '江西省', '吉安市', '遂川县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1738', 'cn', '360828000000', '万安县', '', 3, '江西省', '吉安市', '万安县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1739', 'cn', '360829000000', '安福县', '', 3, '江西省', '吉安市', '安福县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('174', 'cn', '371000000000', '威海市', '', 2, '山东省', '威海市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1740', 'cn', '360830000000', '永新县', '', 3, '江西省', '吉安市', '永新县', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1741', 'cn', '360881000000', '井冈山市', '', 3, '江西省', '吉安市', '井冈山市', 0, 1, '360800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1742', 'cn', '360901000000', '市辖区', '', 3, '江西省', '宜春市', '市辖区', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1743', 'cn', '360902000000', '袁州区', '', 3, '江西省', '宜春市', '袁州区', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1744', 'cn', '360921000000', '奉新县', '', 3, '江西省', '宜春市', '奉新县', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1745', 'cn', '360922000000', '万载县', '', 3, '江西省', '宜春市', '万载县', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1746', 'cn', '360923000000', '上高县', '', 3, '江西省', '宜春市', '上高县', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1747', 'cn', '360924000000', '宜丰县', '', 3, '江西省', '宜春市', '宜丰县', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1748', 'cn', '360925000000', '靖安县', '', 3, '江西省', '宜春市', '靖安县', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1749', 'cn', '360926000000', '铜鼓县', '', 3, '江西省', '宜春市', '铜鼓县', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('175', 'cn', '371100000000', '日照市', '', 2, '山东省', '日照市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1750', 'cn', '360981000000', '丰城市', '', 3, '江西省', '宜春市', '丰城市', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1751', 'cn', '360982000000', '樟树市', '', 3, '江西省', '宜春市', '樟树市', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1752', 'cn', '360983000000', '高安市', '', 3, '江西省', '宜春市', '高安市', 0, 1, '360900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1753', 'cn', '361001000000', '市辖区', '', 3, '江西省', '抚州市', '市辖区', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1754', 'cn', '361002000000', '临川区', '', 3, '江西省', '抚州市', '临川区', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1755', 'cn', '361003000000', '东乡区', '', 3, '江西省', '抚州市', '东乡区', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1756', 'cn', '361021000000', '南城县', '', 3, '江西省', '抚州市', '南城县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1757', 'cn', '361022000000', '黎川县', '', 3, '江西省', '抚州市', '黎川县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1758', 'cn', '361023000000', '南丰县', '', 3, '江西省', '抚州市', '南丰县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1759', 'cn', '361024000000', '崇仁县', '', 3, '江西省', '抚州市', '崇仁县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('176', 'cn', '371200000000', '莱芜市', '', 2, '山东省', '莱芜市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1760', 'cn', '361025000000', '乐安县', '', 3, '江西省', '抚州市', '乐安县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1761', 'cn', '361026000000', '宜黄县', '', 3, '江西省', '抚州市', '宜黄县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1762', 'cn', '361027000000', '金溪县', '', 3, '江西省', '抚州市', '金溪县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1763', 'cn', '361028000000', '资溪县', '', 3, '江西省', '抚州市', '资溪县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1764', 'cn', '361030000000', '广昌县', '', 3, '江西省', '抚州市', '广昌县', 0, 1, '361000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1765', 'cn', '361101000000', '市辖区', '', 3, '江西省', '上饶市', '市辖区', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1766', 'cn', '361102000000', '信州区', '', 3, '江西省', '上饶市', '信州区', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1767', 'cn', '361103000000', '广丰区', '', 3, '江西省', '上饶市', '广丰区', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1768', 'cn', '361121000000', '上饶县', '', 3, '江西省', '上饶市', '上饶县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1769', 'cn', '361123000000', '玉山县', '', 3, '江西省', '上饶市', '玉山县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('177', 'cn', '371300000000', '临沂市', '', 2, '山东省', '临沂市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1770', 'cn', '361124000000', '铅山县', '', 3, '江西省', '上饶市', '铅山县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1771', 'cn', '361125000000', '横峰县', '', 3, '江西省', '上饶市', '横峰县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1772', 'cn', '361126000000', '弋阳县', '', 3, '江西省', '上饶市', '弋阳县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1773', 'cn', '361127000000', '余干县', '', 3, '江西省', '上饶市', '余干县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1774', 'cn', '361128000000', '鄱阳县', '', 3, '江西省', '上饶市', '鄱阳县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1775', 'cn', '361129000000', '万年县', '', 3, '江西省', '上饶市', '万年县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1776', 'cn', '361130000000', '婺源县', '', 3, '江西省', '上饶市', '婺源县', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1777', 'cn', '361181000000', '德兴市', '', 3, '江西省', '上饶市', '德兴市', 0, 1, '361100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1778', 'cn', '370101000000', '市辖区', '', 3, '山东省', '济南市', '市辖区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1779', 'cn', '370102000000', '历下区', '', 3, '山东省', '济南市', '历下区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('178', 'cn', '371400000000', '德州市', '', 2, '山东省', '德州市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1780', 'cn', '370103000000', '市中区', '', 3, '山东省', '济南市', '市中区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1781', 'cn', '370104000000', '槐荫区', '', 3, '山东省', '济南市', '槐荫区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1782', 'cn', '370105000000', '天桥区', '', 3, '山东省', '济南市', '天桥区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1783', 'cn', '370112000000', '历城区', '', 3, '山东省', '济南市', '历城区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1784', 'cn', '370113000000', '长清区', '', 3, '山东省', '济南市', '长清区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1785', 'cn', '370114000000', '章丘区', '', 3, '山东省', '济南市', '章丘区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1786', 'cn', '370124000000', '平阴县', '', 3, '山东省', '济南市', '平阴县', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1787', 'cn', '370125000000', '济阳县', '', 3, '山东省', '济南市', '济阳县', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1788', 'cn', '370126000000', '商河县', '', 3, '山东省', '济南市', '商河县', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1789', 'cn', '370171000000', '济南高新技术产业开发区', '', 3, '山东省', '济南市', '济南高新技术产业开发区', 0, 1, '370100000000');
INSERT INTO SYS_NATION_AREA VALUES ('179', 'cn', '371500000000', '聊城市', '', 2, '山东省', '聊城市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1790', 'cn', '370201000000', '市辖区', '', 3, '山东省', '青岛市', '市辖区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1791', 'cn', '370202000000', '市南区', '', 3, '山东省', '青岛市', '市南区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1792', 'cn', '370203000000', '市北区', '', 3, '山东省', '青岛市', '市北区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1793', 'cn', '370211000000', '黄岛区', '', 3, '山东省', '青岛市', '黄岛区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1794', 'cn', '370212000000', '崂山区', '', 3, '山东省', '青岛市', '崂山区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1795', 'cn', '370213000000', '李沧区', '', 3, '山东省', '青岛市', '李沧区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1796', 'cn', '370214000000', '城阳区', '', 3, '山东省', '青岛市', '城阳区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1797', 'cn', '370215000000', '即墨区', '', 3, '山东省', '青岛市', '即墨区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1798', 'cn', '370271000000', '青岛高新技术产业开发区', '', 3, '山东省', '青岛市', '青岛高新技术产业开发区', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1799', 'cn', '370281000000', '胶州市', '', 3, '山东省', '青岛市', '胶州市', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('18', 'cn', '430000000000', '湖南省', '', 1, '湖南省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('180', 'cn', '371600000000', '滨州市', '', 2, '山东省', '滨州市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1800', 'cn', '370283000000', '平度市', '', 3, '山东省', '青岛市', '平度市', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1801', 'cn', '370285000000', '莱西市', '', 3, '山东省', '青岛市', '莱西市', 0, 1, '370200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1802', 'cn', '370301000000', '市辖区', '', 3, '山东省', '淄博市', '市辖区', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1803', 'cn', '370302000000', '淄川区', '', 3, '山东省', '淄博市', '淄川区', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1804', 'cn', '370303000000', '张店区', '', 3, '山东省', '淄博市', '张店区', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1805', 'cn', '370304000000', '博山区', '', 3, '山东省', '淄博市', '博山区', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1806', 'cn', '370305000000', '临淄区', '', 3, '山东省', '淄博市', '临淄区', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1807', 'cn', '370306000000', '周村区', '', 3, '山东省', '淄博市', '周村区', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1808', 'cn', '370321000000', '桓台县', '', 3, '山东省', '淄博市', '桓台县', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1809', 'cn', '370322000000', '高青县', '', 3, '山东省', '淄博市', '高青县', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('181', 'cn', '371700000000', '菏泽市', '', 2, '山东省', '菏泽市', '', 0, 1, '370000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1810', 'cn', '370323000000', '沂源县', '', 3, '山东省', '淄博市', '沂源县', 0, 1, '370300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1811', 'cn', '370401000000', '市辖区', '', 3, '山东省', '枣庄市', '市辖区', 0, 1, '370400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1812', 'cn', '370402000000', '市中区', '', 3, '山东省', '枣庄市', '市中区', 0, 1, '370400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1813', 'cn', '370403000000', '薛城区', '', 3, '山东省', '枣庄市', '薛城区', 0, 1, '370400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1814', 'cn', '370404000000', '峄城区', '', 3, '山东省', '枣庄市', '峄城区', 0, 1, '370400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1815', 'cn', '370405000000', '台儿庄区', '', 3, '山东省', '枣庄市', '台儿庄区', 0, 1, '370400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1816', 'cn', '370406000000', '山亭区', '', 3, '山东省', '枣庄市', '山亭区', 0, 1, '370400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1817', 'cn', '370481000000', '滕州市', '', 3, '山东省', '枣庄市', '滕州市', 0, 1, '370400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1818', 'cn', '370501000000', '市辖区', '', 3, '山东省', '东营市', '市辖区', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1819', 'cn', '370502000000', '东营区', '', 3, '山东省', '东营市', '东营区', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('182', 'cn', '410100000000', '郑州市', '', 2, '河南省', '郑州市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1820', 'cn', '370503000000', '河口区', '', 3, '山东省', '东营市', '河口区', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1821', 'cn', '370505000000', '垦利区', '', 3, '山东省', '东营市', '垦利区', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1822', 'cn', '370522000000', '利津县', '', 3, '山东省', '东营市', '利津县', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1823', 'cn', '370523000000', '广饶县', '', 3, '山东省', '东营市', '广饶县', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1824', 'cn', '370571000000', '东营经济技术开发区', '', 3, '山东省', '东营市', '东营经济技术开发区', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1825', 'cn', '370572000000', '东营港经济开发区', '', 3, '山东省', '东营市', '东营港经济开发区', 0, 1, '370500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1826', 'cn', '370601000000', '市辖区', '', 3, '山东省', '烟台市', '市辖区', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1827', 'cn', '370602000000', '芝罘区', '', 3, '山东省', '烟台市', '芝罘区', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1828', 'cn', '370611000000', '福山区', '', 3, '山东省', '烟台市', '福山区', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1829', 'cn', '370612000000', '牟平区', '', 3, '山东省', '烟台市', '牟平区', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('183', 'cn', '410200000000', '开封市', '', 2, '河南省', '开封市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1830', 'cn', '370613000000', '莱山区', '', 3, '山东省', '烟台市', '莱山区', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1831', 'cn', '370634000000', '长岛县', '', 3, '山东省', '烟台市', '长岛县', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1832', 'cn', '370671000000', '烟台高新技术产业开发区', '', 3, '山东省', '烟台市', '烟台高新技术产业开发区', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1833', 'cn', '370672000000', '烟台经济技术开发区', '', 3, '山东省', '烟台市', '烟台经济技术开发区', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1834', 'cn', '370681000000', '龙口市', '', 3, '山东省', '烟台市', '龙口市', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1835', 'cn', '370682000000', '莱阳市', '', 3, '山东省', '烟台市', '莱阳市', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1836', 'cn', '370683000000', '莱州市', '', 3, '山东省', '烟台市', '莱州市', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1837', 'cn', '370684000000', '蓬莱市', '', 3, '山东省', '烟台市', '蓬莱市', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1838', 'cn', '370685000000', '招远市', '', 3, '山东省', '烟台市', '招远市', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1839', 'cn', '370686000000', '栖霞市', '', 3, '山东省', '烟台市', '栖霞市', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('184', 'cn', '410300000000', '洛阳市', '', 2, '河南省', '洛阳市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1840', 'cn', '370687000000', '海阳市', '', 3, '山东省', '烟台市', '海阳市', 0, 1, '370600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1841', 'cn', '370701000000', '市辖区', '', 3, '山东省', '潍坊市', '市辖区', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1842', 'cn', '370702000000', '潍城区', '', 3, '山东省', '潍坊市', '潍城区', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1843', 'cn', '370703000000', '寒亭区', '', 3, '山东省', '潍坊市', '寒亭区', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1844', 'cn', '370704000000', '坊子区', '', 3, '山东省', '潍坊市', '坊子区', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1845', 'cn', '370705000000', '奎文区', '', 3, '山东省', '潍坊市', '奎文区', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1846', 'cn', '370724000000', '临朐县', '', 3, '山东省', '潍坊市', '临朐县', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1847', 'cn', '370725000000', '昌乐县', '', 3, '山东省', '潍坊市', '昌乐县', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1848', 'cn', '370772000000', '潍坊滨海经济技术开发区', '', 3, '山东省', '潍坊市', '潍坊滨海经济技术开发区', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1849', 'cn', '370781000000', '青州市', '', 3, '山东省', '潍坊市', '青州市', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('185', 'cn', '410400000000', '平顶山市', '', 2, '河南省', '平顶山市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1850', 'cn', '370782000000', '诸城市', '', 3, '山东省', '潍坊市', '诸城市', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1851', 'cn', '370783000000', '寿光市', '', 3, '山东省', '潍坊市', '寿光市', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1852', 'cn', '370784000000', '安丘市', '', 3, '山东省', '潍坊市', '安丘市', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1853', 'cn', '370785000000', '高密市', '', 3, '山东省', '潍坊市', '高密市', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1854', 'cn', '370786000000', '昌邑市', '', 3, '山东省', '潍坊市', '昌邑市', 0, 1, '370700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1855', 'cn', '370801000000', '市辖区', '', 3, '山东省', '济宁市', '市辖区', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1856', 'cn', '370811000000', '任城区', '', 3, '山东省', '济宁市', '任城区', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1857', 'cn', '370812000000', '兖州区', '', 3, '山东省', '济宁市', '兖州区', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1858', 'cn', '370826000000', '微山县', '', 3, '山东省', '济宁市', '微山县', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1859', 'cn', '370827000000', '鱼台县', '', 3, '山东省', '济宁市', '鱼台县', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('186', 'cn', '410500000000', '安阳市', '', 2, '河南省', '安阳市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1860', 'cn', '370828000000', '金乡县', '', 3, '山东省', '济宁市', '金乡县', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1861', 'cn', '370829000000', '嘉祥县', '', 3, '山东省', '济宁市', '嘉祥县', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1862', 'cn', '370830000000', '汶上县', '', 3, '山东省', '济宁市', '汶上县', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1863', 'cn', '370831000000', '泗水县', '', 3, '山东省', '济宁市', '泗水县', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1864', 'cn', '370832000000', '梁山县', '', 3, '山东省', '济宁市', '梁山县', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1865', 'cn', '370871000000', '济宁高新技术产业开发区', '', 3, '山东省', '济宁市', '济宁高新技术产业开发区', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1866', 'cn', '370881000000', '曲阜市', '', 3, '山东省', '济宁市', '曲阜市', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1867', 'cn', '370883000000', '邹城市', '', 3, '山东省', '济宁市', '邹城市', 0, 1, '370800000000');
INSERT INTO SYS_NATION_AREA VALUES ('1868', 'cn', '370901000000', '市辖区', '', 3, '山东省', '泰安市', '市辖区', 0, 1, '370900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1869', 'cn', '370902000000', '泰山区', '', 3, '山东省', '泰安市', '泰山区', 0, 1, '370900000000');
INSERT INTO SYS_NATION_AREA VALUES ('187', 'cn', '410600000000', '鹤壁市', '', 2, '河南省', '鹤壁市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1870', 'cn', '370911000000', '岱岳区', '', 3, '山东省', '泰安市', '岱岳区', 0, 1, '370900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1871', 'cn', '370921000000', '宁阳县', '', 3, '山东省', '泰安市', '宁阳县', 0, 1, '370900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1872', 'cn', '370923000000', '东平县', '', 3, '山东省', '泰安市', '东平县', 0, 1, '370900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1873', 'cn', '370982000000', '新泰市', '', 3, '山东省', '泰安市', '新泰市', 0, 1, '370900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1874', 'cn', '370983000000', '肥城市', '', 3, '山东省', '泰安市', '肥城市', 0, 1, '370900000000');
INSERT INTO SYS_NATION_AREA VALUES ('1875', 'cn', '371001000000', '市辖区', '', 3, '山东省', '威海市', '市辖区', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1876', 'cn', '371002000000', '环翠区', '', 3, '山东省', '威海市', '环翠区', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1877', 'cn', '371003000000', '文登区', '', 3, '山东省', '威海市', '文登区', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1878', 'cn', '371071000000', '威海火炬高技术产业开发区', '', 3, '山东省', '威海市', '威海火炬高技术产业开发区', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1879', 'cn', '371072000000', '威海经济技术开发区', '', 3, '山东省', '威海市', '威海经济技术开发区', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('188', 'cn', '410700000000', '新乡市', '', 2, '河南省', '新乡市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1880', 'cn', '371073000000', '威海临港经济技术开发区', '', 3, '山东省', '威海市', '威海临港经济技术开发区', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1881', 'cn', '371082000000', '荣成市', '', 3, '山东省', '威海市', '荣成市', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1882', 'cn', '371083000000', '乳山市', '', 3, '山东省', '威海市', '乳山市', 0, 1, '371000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1883', 'cn', '371101000000', '市辖区', '', 3, '山东省', '日照市', '市辖区', 0, 1, '371100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1884', 'cn', '371102000000', '东港区', '', 3, '山东省', '日照市', '东港区', 0, 1, '371100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1885', 'cn', '371103000000', '岚山区', '', 3, '山东省', '日照市', '岚山区', 0, 1, '371100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1886', 'cn', '371121000000', '五莲县', '', 3, '山东省', '日照市', '五莲县', 0, 1, '371100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1887', 'cn', '371122000000', '莒县', '', 3, '山东省', '日照市', '莒县', 0, 1, '371100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1888', 'cn', '371171000000', '日照经济技术开发区', '', 3, '山东省', '日照市', '日照经济技术开发区', 0, 1, '371100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1889', 'cn', '371172000000', '日照国际海洋城', '', 3, '山东省', '日照市', '日照国际海洋城', 0, 1, '371100000000');
INSERT INTO SYS_NATION_AREA VALUES ('189', 'cn', '410800000000', '焦作市', '', 2, '河南省', '焦作市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1890', 'cn', '371201000000', '市辖区', '', 3, '山东省', '莱芜市', '市辖区', 0, 1, '371200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1891', 'cn', '371202000000', '莱城区', '', 3, '山东省', '莱芜市', '莱城区', 0, 1, '371200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1892', 'cn', '371203000000', '钢城区', '', 3, '山东省', '莱芜市', '钢城区', 0, 1, '371200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1893', 'cn', '371301000000', '市辖区', '', 3, '山东省', '临沂市', '市辖区', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1894', 'cn', '371302000000', '兰山区', '', 3, '山东省', '临沂市', '兰山区', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1895', 'cn', '371311000000', '罗庄区', '', 3, '山东省', '临沂市', '罗庄区', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1896', 'cn', '371312000000', '河东区', '', 3, '山东省', '临沂市', '河东区', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1897', 'cn', '371321000000', '沂南县', '', 3, '山东省', '临沂市', '沂南县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1898', 'cn', '371322000000', '郯城县', '', 3, '山东省', '临沂市', '郯城县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1899', 'cn', '371323000000', '沂水县', '', 3, '山东省', '临沂市', '沂水县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('19', 'cn', '440000000000', '广东省', '', 1, '广东省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('190', 'cn', '410900000000', '濮阳市', '', 2, '河南省', '濮阳市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1900', 'cn', '371324000000', '兰陵县', '', 3, '山东省', '临沂市', '兰陵县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1901', 'cn', '371325000000', '费县', '', 3, '山东省', '临沂市', '费县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1902', 'cn', '371326000000', '平邑县', '', 3, '山东省', '临沂市', '平邑县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1903', 'cn', '371327000000', '莒南县', '', 3, '山东省', '临沂市', '莒南县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1904', 'cn', '371328000000', '蒙阴县', '', 3, '山东省', '临沂市', '蒙阴县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1905', 'cn', '371329000000', '临沭县', '', 3, '山东省', '临沂市', '临沭县', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1906', 'cn', '371371000000', '临沂高新技术产业开发区', '', 3, '山东省', '临沂市', '临沂高新技术产业开发区', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1907', 'cn', '371372000000', '临沂经济技术开发区', '', 3, '山东省', '临沂市', '临沂经济技术开发区', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1908', 'cn', '371373000000', '临沂临港经济开发区', '', 3, '山东省', '临沂市', '临沂临港经济开发区', 0, 1, '371300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1909', 'cn', '371401000000', '市辖区', '', 3, '山东省', '德州市', '市辖区', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('191', 'cn', '411000000000', '许昌市', '', 2, '河南省', '许昌市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1910', 'cn', '371402000000', '德城区', '', 3, '山东省', '德州市', '德城区', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1911', 'cn', '371403000000', '陵城区', '', 3, '山东省', '德州市', '陵城区', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1912', 'cn', '371422000000', '宁津县', '', 3, '山东省', '德州市', '宁津县', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1913', 'cn', '371423000000', '庆云县', '', 3, '山东省', '德州市', '庆云县', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1914', 'cn', '371424000000', '临邑县', '', 3, '山东省', '德州市', '临邑县', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1915', 'cn', '371425000000', '齐河县', '', 3, '山东省', '德州市', '齐河县', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1916', 'cn', '371426000000', '平原县', '', 3, '山东省', '德州市', '平原县', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1917', 'cn', '371427000000', '夏津县', '', 3, '山东省', '德州市', '夏津县', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1918', 'cn', '371428000000', '武城县', '', 3, '山东省', '德州市', '武城县', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1919', 'cn', '371471000000', '德州经济技术开发区', '', 3, '山东省', '德州市', '德州经济技术开发区', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('192', 'cn', '411100000000', '漯河市', '', 2, '河南省', '漯河市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1920', 'cn', '371472000000', '德州运河经济开发区', '', 3, '山东省', '德州市', '德州运河经济开发区', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1921', 'cn', '371481000000', '乐陵市', '', 3, '山东省', '德州市', '乐陵市', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1922', 'cn', '371482000000', '禹城市', '', 3, '山东省', '德州市', '禹城市', 0, 1, '371400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1923', 'cn', '371501000000', '市辖区', '', 3, '山东省', '聊城市', '市辖区', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1924', 'cn', '371502000000', '东昌府区', '', 3, '山东省', '聊城市', '东昌府区', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1925', 'cn', '371521000000', '阳谷县', '', 3, '山东省', '聊城市', '阳谷县', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1926', 'cn', '371522000000', '莘县', '', 3, '山东省', '聊城市', '莘县', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1927', 'cn', '371523000000', '茌平县', '', 3, '山东省', '聊城市', '茌平县', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1928', 'cn', '371524000000', '东阿县', '', 3, '山东省', '聊城市', '东阿县', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1929', 'cn', '371525000000', '冠县', '', 3, '山东省', '聊城市', '冠县', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('193', 'cn', '411200000000', '三门峡市', '', 2, '河南省', '三门峡市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1930', 'cn', '371526000000', '高唐县', '', 3, '山东省', '聊城市', '高唐县', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1931', 'cn', '371581000000', '临清市', '', 3, '山东省', '聊城市', '临清市', 0, 1, '371500000000');
INSERT INTO SYS_NATION_AREA VALUES ('1932', 'cn', '371601000000', '市辖区', '', 3, '山东省', '滨州市', '市辖区', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1933', 'cn', '371602000000', '滨城区', '', 3, '山东省', '滨州市', '滨城区', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1934', 'cn', '371603000000', '沾化区', '', 3, '山东省', '滨州市', '沾化区', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1935', 'cn', '371621000000', '惠民县', '', 3, '山东省', '滨州市', '惠民县', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1936', 'cn', '371622000000', '阳信县', '', 3, '山东省', '滨州市', '阳信县', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1937', 'cn', '371623000000', '无棣县', '', 3, '山东省', '滨州市', '无棣县', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1938', 'cn', '371625000000', '博兴县', '', 3, '山东省', '滨州市', '博兴县', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('1939', 'cn', '371626000000', '邹平县', '', 3, '山东省', '滨州市', '邹平县', 0, 1, '371600000000');
INSERT INTO SYS_NATION_AREA VALUES ('194', 'cn', '411300000000', '南阳市', '', 2, '河南省', '南阳市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1940', 'cn', '371701000000', '市辖区', '', 3, '山东省', '菏泽市', '市辖区', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1941', 'cn', '371702000000', '牡丹区', '', 3, '山东省', '菏泽市', '牡丹区', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1942', 'cn', '371703000000', '定陶区', '', 3, '山东省', '菏泽市', '定陶区', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1943', 'cn', '371721000000', '曹县', '', 3, '山东省', '菏泽市', '曹县', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1944', 'cn', '371722000000', '单县', '', 3, '山东省', '菏泽市', '单县', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1945', 'cn', '371723000000', '成武县', '', 3, '山东省', '菏泽市', '成武县', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1946', 'cn', '371724000000', '巨野县', '', 3, '山东省', '菏泽市', '巨野县', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1947', 'cn', '371725000000', '郓城县', '', 3, '山东省', '菏泽市', '郓城县', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1948', 'cn', '371726000000', '鄄城县', '', 3, '山东省', '菏泽市', '鄄城县', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1949', 'cn', '371728000000', '东明县', '', 3, '山东省', '菏泽市', '东明县', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('195', 'cn', '411400000000', '商丘市', '', 2, '河南省', '商丘市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1950', 'cn', '371771000000', '菏泽经济技术开发区', '', 3, '山东省', '菏泽市', '菏泽经济技术开发区', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1951', 'cn', '371772000000', '菏泽高新技术开发区', '', 3, '山东省', '菏泽市', '菏泽高新技术开发区', 0, 1, '371700000000');
INSERT INTO SYS_NATION_AREA VALUES ('1952', 'cn', '410101000000', '市辖区', '', 3, '河南省', '郑州市', '市辖区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1953', 'cn', '410102000000', '中原区', '', 3, '河南省', '郑州市', '中原区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1954', 'cn', '410103000000', '二七区', '', 3, '河南省', '郑州市', '二七区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1955', 'cn', '410104000000', '管城回族区', '', 3, '河南省', '郑州市', '管城回族区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1956', 'cn', '410105000000', '金水区', '', 3, '河南省', '郑州市', '金水区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1957', 'cn', '410106000000', '上街区', '', 3, '河南省', '郑州市', '上街区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1958', 'cn', '410108000000', '惠济区', '', 3, '河南省', '郑州市', '惠济区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1959', 'cn', '410122000000', '中牟县', '', 3, '河南省', '郑州市', '中牟县', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('196', 'cn', '411500000000', '信阳市', '', 2, '河南省', '信阳市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1960', 'cn', '410171000000', '郑州经济技术开发区', '', 3, '河南省', '郑州市', '郑州经济技术开发区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1961', 'cn', '410172000000', '郑州高新技术产业开发区', '', 3, '河南省', '郑州市', '郑州高新技术产业开发区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1962', 'cn', '410173000000', '郑州航空港经济综合实验区', '', 3, '河南省', '郑州市', '郑州航空港经济综合实验区', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1963', 'cn', '410181000000', '巩义市', '', 3, '河南省', '郑州市', '巩义市', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1964', 'cn', '410182000000', '荥阳市', '', 3, '河南省', '郑州市', '荥阳市', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1965', 'cn', '410183000000', '新密市', '', 3, '河南省', '郑州市', '新密市', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1966', 'cn', '410184000000', '新郑市', '', 3, '河南省', '郑州市', '新郑市', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1967', 'cn', '410185000000', '登封市', '', 3, '河南省', '郑州市', '登封市', 0, 1, '410100000000');
INSERT INTO SYS_NATION_AREA VALUES ('1968', 'cn', '410201000000', '市辖区', '', 3, '河南省', '开封市', '市辖区', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1969', 'cn', '410202000000', '龙亭区', '', 3, '河南省', '开封市', '龙亭区', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('197', 'cn', '411600000000', '周口市', '', 2, '河南省', '周口市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1970', 'cn', '410203000000', '顺河回族区', '', 3, '河南省', '开封市', '顺河回族区', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1971', 'cn', '410204000000', '鼓楼区', '', 3, '河南省', '开封市', '鼓楼区', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1972', 'cn', '410205000000', '禹王台区', '', 3, '河南省', '开封市', '禹王台区', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1973', 'cn', '410212000000', '祥符区', '', 3, '河南省', '开封市', '祥符区', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1974', 'cn', '410221000000', '杞县', '', 3, '河南省', '开封市', '杞县', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1975', 'cn', '410222000000', '通许县', '', 3, '河南省', '开封市', '通许县', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1976', 'cn', '410223000000', '尉氏县', '', 3, '河南省', '开封市', '尉氏县', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1977', 'cn', '410225000000', '兰考县', '', 3, '河南省', '开封市', '兰考县', 0, 1, '410200000000');
INSERT INTO SYS_NATION_AREA VALUES ('1978', 'cn', '410301000000', '市辖区', '', 3, '河南省', '洛阳市', '市辖区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1979', 'cn', '410302000000', '老城区', '', 3, '河南省', '洛阳市', '老城区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('198', 'cn', '411700000000', '驻马店市', '', 2, '河南省', '驻马店市', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1980', 'cn', '410303000000', '西工区', '', 3, '河南省', '洛阳市', '西工区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1981', 'cn', '410304000000', '瀍河回族区', '', 3, '河南省', '洛阳市', '瀍河回族区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1982', 'cn', '410305000000', '涧西区', '', 3, '河南省', '洛阳市', '涧西区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1983', 'cn', '410306000000', '吉利区', '', 3, '河南省', '洛阳市', '吉利区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1984', 'cn', '410311000000', '洛龙区', '', 3, '河南省', '洛阳市', '洛龙区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1985', 'cn', '410322000000', '孟津县', '', 3, '河南省', '洛阳市', '孟津县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1986', 'cn', '410323000000', '新安县', '', 3, '河南省', '洛阳市', '新安县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1987', 'cn', '410324000000', '栾川县', '', 3, '河南省', '洛阳市', '栾川县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1988', 'cn', '410325000000', '嵩县', '', 3, '河南省', '洛阳市', '嵩县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1989', 'cn', '410326000000', '汝阳县', '', 3, '河南省', '洛阳市', '汝阳县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('199', 'cn', '419000000000', '省直辖县级行政区划', '', 2, '河南省', '省直辖县级行政区划', '', 0, 1, '410000000000');
INSERT INTO SYS_NATION_AREA VALUES ('1990', 'cn', '410327000000', '宜阳县', '', 3, '河南省', '洛阳市', '宜阳县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1991', 'cn', '410328000000', '洛宁县', '', 3, '河南省', '洛阳市', '洛宁县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1992', 'cn', '410329000000', '伊川县', '', 3, '河南省', '洛阳市', '伊川县', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1993', 'cn', '410371000000', '洛阳高新技术产业开发区', '', 3, '河南省', '洛阳市', '洛阳高新技术产业开发区', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1994', 'cn', '410381000000', '偃师市', '', 3, '河南省', '洛阳市', '偃师市', 0, 1, '410300000000');
INSERT INTO SYS_NATION_AREA VALUES ('1995', 'cn', '410401000000', '市辖区', '', 3, '河南省', '平顶山市', '市辖区', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1996', 'cn', '410402000000', '新华区', '', 3, '河南省', '平顶山市', '新华区', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1997', 'cn', '410403000000', '卫东区', '', 3, '河南省', '平顶山市', '卫东区', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1998', 'cn', '410404000000', '石龙区', '', 3, '河南省', '平顶山市', '石龙区', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('1999', 'cn', '410411000000', '湛河区', '', 3, '河南省', '平顶山市', '湛河区', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2', 'cn', '120000000000', '天津市', '', 1, '天津市', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('20', 'cn', '450000000000', '广西壮族自治区', '', 1, '广西壮族自治区', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('200', 'cn', '420100000000', '武汉市', '', 2, '湖北省', '武汉市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2000', 'cn', '410421000000', '宝丰县', '', 3, '河南省', '平顶山市', '宝丰县', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2001', 'cn', '410422000000', '叶县', '', 3, '河南省', '平顶山市', '叶县', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2002', 'cn', '410423000000', '鲁山县', '', 3, '河南省', '平顶山市', '鲁山县', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2003', 'cn', '410425000000', '郏县', '', 3, '河南省', '平顶山市', '郏县', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2004', 'cn', '410471000000', '平顶山高新技术产业开发区', '', 3, '河南省', '平顶山市', '平顶山高新技术产业开发区', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2005', 'cn', '410472000000', '平顶山市新城区', '', 3, '河南省', '平顶山市', '平顶山市新城区', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2006', 'cn', '410481000000', '舞钢市', '', 3, '河南省', '平顶山市', '舞钢市', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2007', 'cn', '410482000000', '汝州市', '', 3, '河南省', '平顶山市', '汝州市', 0, 1, '410400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2008', 'cn', '410501000000', '市辖区', '', 3, '河南省', '安阳市', '市辖区', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2009', 'cn', '410502000000', '文峰区', '', 3, '河南省', '安阳市', '文峰区', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('201', 'cn', '420200000000', '黄石市', '', 2, '湖北省', '黄石市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2010', 'cn', '410503000000', '北关区', '', 3, '河南省', '安阳市', '北关区', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2011', 'cn', '410505000000', '殷都区', '', 3, '河南省', '安阳市', '殷都区', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2012', 'cn', '410506000000', '龙安区', '', 3, '河南省', '安阳市', '龙安区', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2013', 'cn', '410522000000', '安阳县', '', 3, '河南省', '安阳市', '安阳县', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2014', 'cn', '410523000000', '汤阴县', '', 3, '河南省', '安阳市', '汤阴县', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2015', 'cn', '410526000000', '滑县', '', 3, '河南省', '安阳市', '滑县', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2016', 'cn', '410527000000', '内黄县', '', 3, '河南省', '安阳市', '内黄县', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2017', 'cn', '410571000000', '安阳高新技术产业开发区', '', 3, '河南省', '安阳市', '安阳高新技术产业开发区', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2018', 'cn', '410581000000', '林州市', '', 3, '河南省', '安阳市', '林州市', 0, 1, '410500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2019', 'cn', '410601000000', '市辖区', '', 3, '河南省', '鹤壁市', '市辖区', 0, 1, '410600000000');
INSERT INTO SYS_NATION_AREA VALUES ('202', 'cn', '420300000000', '十堰市', '', 2, '湖北省', '十堰市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2020', 'cn', '410602000000', '鹤山区', '', 3, '河南省', '鹤壁市', '鹤山区', 0, 1, '410600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2021', 'cn', '410603000000', '山城区', '', 3, '河南省', '鹤壁市', '山城区', 0, 1, '410600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2022', 'cn', '410611000000', '淇滨区', '', 3, '河南省', '鹤壁市', '淇滨区', 0, 1, '410600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2023', 'cn', '410621000000', '浚县', '', 3, '河南省', '鹤壁市', '浚县', 0, 1, '410600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2024', 'cn', '410622000000', '淇县', '', 3, '河南省', '鹤壁市', '淇县', 0, 1, '410600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2025', 'cn', '410671000000', '鹤壁经济技术开发区', '', 3, '河南省', '鹤壁市', '鹤壁经济技术开发区', 0, 1, '410600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2026', 'cn', '410701000000', '市辖区', '', 3, '河南省', '新乡市', '市辖区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2027', 'cn', '410702000000', '红旗区', '', 3, '河南省', '新乡市', '红旗区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2028', 'cn', '410703000000', '卫滨区', '', 3, '河南省', '新乡市', '卫滨区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2029', 'cn', '410704000000', '凤泉区', '', 3, '河南省', '新乡市', '凤泉区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('203', 'cn', '420500000000', '宜昌市', '', 2, '湖北省', '宜昌市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2030', 'cn', '410711000000', '牧野区', '', 3, '河南省', '新乡市', '牧野区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2031', 'cn', '410721000000', '新乡县', '', 3, '河南省', '新乡市', '新乡县', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2032', 'cn', '410724000000', '获嘉县', '', 3, '河南省', '新乡市', '获嘉县', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2033', 'cn', '410725000000', '原阳县', '', 3, '河南省', '新乡市', '原阳县', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2034', 'cn', '410726000000', '延津县', '', 3, '河南省', '新乡市', '延津县', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2035', 'cn', '410727000000', '封丘县', '', 3, '河南省', '新乡市', '封丘县', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2036', 'cn', '410728000000', '长垣县', '', 3, '河南省', '新乡市', '长垣县', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2037', 'cn', '410771000000', '新乡高新技术产业开发区', '', 3, '河南省', '新乡市', '新乡高新技术产业开发区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2038', 'cn', '410772000000', '新乡经济技术开发区', '', 3, '河南省', '新乡市', '新乡经济技术开发区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2039', 'cn', '410773000000', '新乡市平原城乡一体化示范区', '', 3, '河南省', '新乡市', '新乡市平原城乡一体化示范区', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('204', 'cn', '420600000000', '襄阳市', '', 2, '湖北省', '襄阳市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2040', 'cn', '410781000000', '卫辉市', '', 3, '河南省', '新乡市', '卫辉市', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2041', 'cn', '410782000000', '辉县市', '', 3, '河南省', '新乡市', '辉县市', 0, 1, '410700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2042', 'cn', '410801000000', '市辖区', '', 3, '河南省', '焦作市', '市辖区', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2043', 'cn', '410802000000', '解放区', '', 3, '河南省', '焦作市', '解放区', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2044', 'cn', '410803000000', '中站区', '', 3, '河南省', '焦作市', '中站区', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2045', 'cn', '410804000000', '马村区', '', 3, '河南省', '焦作市', '马村区', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2046', 'cn', '410811000000', '山阳区', '', 3, '河南省', '焦作市', '山阳区', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2047', 'cn', '410821000000', '修武县', '', 3, '河南省', '焦作市', '修武县', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2048', 'cn', '410822000000', '博爱县', '', 3, '河南省', '焦作市', '博爱县', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2049', 'cn', '410823000000', '武陟县', '', 3, '河南省', '焦作市', '武陟县', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('205', 'cn', '420700000000', '鄂州市', '', 2, '湖北省', '鄂州市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2050', 'cn', '410825000000', '温县', '', 3, '河南省', '焦作市', '温县', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2051', 'cn', '410871000000', '焦作城乡一体化示范区', '', 3, '河南省', '焦作市', '焦作城乡一体化示范区', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2052', 'cn', '410882000000', '沁阳市', '', 3, '河南省', '焦作市', '沁阳市', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2053', 'cn', '410883000000', '孟州市', '', 3, '河南省', '焦作市', '孟州市', 0, 1, '410800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2054', 'cn', '410901000000', '市辖区', '', 3, '河南省', '濮阳市', '市辖区', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2055', 'cn', '410902000000', '华龙区', '', 3, '河南省', '濮阳市', '华龙区', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2056', 'cn', '410922000000', '清丰县', '', 3, '河南省', '濮阳市', '清丰县', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2057', 'cn', '410923000000', '南乐县', '', 3, '河南省', '濮阳市', '南乐县', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2058', 'cn', '410926000000', '范县', '', 3, '河南省', '濮阳市', '范县', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2059', 'cn', '410927000000', '台前县', '', 3, '河南省', '濮阳市', '台前县', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('206', 'cn', '420800000000', '荆门市', '', 2, '湖北省', '荆门市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2060', 'cn', '410928000000', '濮阳县', '', 3, '河南省', '濮阳市', '濮阳县', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2061', 'cn', '410971000000', '河南濮阳工业园区', '', 3, '河南省', '濮阳市', '河南濮阳工业园区', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2062', 'cn', '410972000000', '濮阳经济技术开发区', '', 3, '河南省', '濮阳市', '濮阳经济技术开发区', 0, 1, '410900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2063', 'cn', '411001000000', '市辖区', '', 3, '河南省', '许昌市', '市辖区', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2064', 'cn', '411002000000', '魏都区', '', 3, '河南省', '许昌市', '魏都区', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2065', 'cn', '411003000000', '建安区', '', 3, '河南省', '许昌市', '建安区', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2066', 'cn', '411024000000', '鄢陵县', '', 3, '河南省', '许昌市', '鄢陵县', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2067', 'cn', '411025000000', '襄城县', '', 3, '河南省', '许昌市', '襄城县', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2068', 'cn', '411071000000', '许昌经济技术开发区', '', 3, '河南省', '许昌市', '许昌经济技术开发区', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2069', 'cn', '411081000000', '禹州市', '', 3, '河南省', '许昌市', '禹州市', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('207', 'cn', '420900000000', '孝感市', '', 2, '湖北省', '孝感市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2070', 'cn', '411082000000', '长葛市', '', 3, '河南省', '许昌市', '长葛市', 0, 1, '411000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2071', 'cn', '411101000000', '市辖区', '', 3, '河南省', '漯河市', '市辖区', 0, 1, '411100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2072', 'cn', '411102000000', '源汇区', '', 3, '河南省', '漯河市', '源汇区', 0, 1, '411100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2073', 'cn', '411103000000', '郾城区', '', 3, '河南省', '漯河市', '郾城区', 0, 1, '411100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2074', 'cn', '411104000000', '召陵区', '', 3, '河南省', '漯河市', '召陵区', 0, 1, '411100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2075', 'cn', '411121000000', '舞阳县', '', 3, '河南省', '漯河市', '舞阳县', 0, 1, '411100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2076', 'cn', '411122000000', '临颍县', '', 3, '河南省', '漯河市', '临颍县', 0, 1, '411100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2077', 'cn', '411171000000', '漯河经济技术开发区', '', 3, '河南省', '漯河市', '漯河经济技术开发区', 0, 1, '411100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2078', 'cn', '411201000000', '市辖区', '', 3, '河南省', '三门峡市', '市辖区', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2079', 'cn', '411202000000', '湖滨区', '', 3, '河南省', '三门峡市', '湖滨区', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('208', 'cn', '421000000000', '荆州市', '', 2, '湖北省', '荆州市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2080', 'cn', '411203000000', '陕州区', '', 3, '河南省', '三门峡市', '陕州区', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2081', 'cn', '411221000000', '渑池县', '', 3, '河南省', '三门峡市', '渑池县', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2082', 'cn', '411224000000', '卢氏县', '', 3, '河南省', '三门峡市', '卢氏县', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2083', 'cn', '411271000000', '河南三门峡经济开发区', '', 3, '河南省', '三门峡市', '河南三门峡经济开发区', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2084', 'cn', '411281000000', '义马市', '', 3, '河南省', '三门峡市', '义马市', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2085', 'cn', '411282000000', '灵宝市', '', 3, '河南省', '三门峡市', '灵宝市', 0, 1, '411200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2086', 'cn', '411301000000', '市辖区', '', 3, '河南省', '南阳市', '市辖区', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2087', 'cn', '411302000000', '宛城区', '', 3, '河南省', '南阳市', '宛城区', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2088', 'cn', '411303000000', '卧龙区', '', 3, '河南省', '南阳市', '卧龙区', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2089', 'cn', '411321000000', '南召县', '', 3, '河南省', '南阳市', '南召县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('209', 'cn', '421100000000', '黄冈市', '', 2, '湖北省', '黄冈市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2090', 'cn', '411322000000', '方城县', '', 3, '河南省', '南阳市', '方城县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2091', 'cn', '411323000000', '西峡县', '', 3, '河南省', '南阳市', '西峡县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2092', 'cn', '411324000000', '镇平县', '', 3, '河南省', '南阳市', '镇平县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2093', 'cn', '411325000000', '内乡县', '', 3, '河南省', '南阳市', '内乡县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2094', 'cn', '411326000000', '淅川县', '', 3, '河南省', '南阳市', '淅川县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2095', 'cn', '411327000000', '社旗县', '', 3, '河南省', '南阳市', '社旗县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2096', 'cn', '411328000000', '唐河县', '', 3, '河南省', '南阳市', '唐河县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2097', 'cn', '411329000000', '新野县', '', 3, '河南省', '南阳市', '新野县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2098', 'cn', '411330000000', '桐柏县', '', 3, '河南省', '南阳市', '桐柏县', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2099', 'cn', '411371000000', '南阳高新技术产业开发区', '', 3, '河南省', '南阳市', '南阳高新技术产业开发区', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('21', 'cn', '460000000000', '海南省', '', 1, '海南省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('210', 'cn', '421200000000', '咸宁市', '', 2, '湖北省', '咸宁市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2100', 'cn', '411372000000', '南阳市城乡一体化示范区', '', 3, '河南省', '南阳市', '南阳市城乡一体化示范区', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2101', 'cn', '411381000000', '邓州市', '', 3, '河南省', '南阳市', '邓州市', 0, 1, '411300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2102', 'cn', '411401000000', '市辖区', '', 3, '河南省', '商丘市', '市辖区', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2103', 'cn', '411402000000', '梁园区', '', 3, '河南省', '商丘市', '梁园区', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2104', 'cn', '411403000000', '睢阳区', '', 3, '河南省', '商丘市', '睢阳区', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2105', 'cn', '411421000000', '民权县', '', 3, '河南省', '商丘市', '民权县', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2106', 'cn', '411422000000', '睢县', '', 3, '河南省', '商丘市', '睢县', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2107', 'cn', '411423000000', '宁陵县', '', 3, '河南省', '商丘市', '宁陵县', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2108', 'cn', '411424000000', '柘城县', '', 3, '河南省', '商丘市', '柘城县', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2109', 'cn', '411425000000', '虞城县', '', 3, '河南省', '商丘市', '虞城县', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('211', 'cn', '421300000000', '随州市', '', 2, '湖北省', '随州市', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2110', 'cn', '411426000000', '夏邑县', '', 3, '河南省', '商丘市', '夏邑县', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2111', 'cn', '411471000000', '豫东综合物流产业聚集区', '', 3, '河南省', '商丘市', '豫东综合物流产业聚集区', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2112', 'cn', '411472000000', '河南商丘经济开发区', '', 3, '河南省', '商丘市', '河南商丘经济开发区', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2113', 'cn', '411481000000', '永城市', '', 3, '河南省', '商丘市', '永城市', 0, 1, '411400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2114', 'cn', '411501000000', '市辖区', '', 3, '河南省', '信阳市', '市辖区', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2115', 'cn', '411502000000', '浉河区', '', 3, '河南省', '信阳市', '浉河区', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2116', 'cn', '411503000000', '平桥区', '', 3, '河南省', '信阳市', '平桥区', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2117', 'cn', '411521000000', '罗山县', '', 3, '河南省', '信阳市', '罗山县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2118', 'cn', '411522000000', '光山县', '', 3, '河南省', '信阳市', '光山县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2119', 'cn', '411523000000', '新县', '', 3, '河南省', '信阳市', '新县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('212', 'cn', '422800000000', '恩施土家族苗族自治州', '', 2, '湖北省', '恩施土家族苗族自治州', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2120', 'cn', '411524000000', '商城县', '', 3, '河南省', '信阳市', '商城县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2121', 'cn', '411525000000', '固始县', '', 3, '河南省', '信阳市', '固始县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2122', 'cn', '411526000000', '潢川县', '', 3, '河南省', '信阳市', '潢川县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2123', 'cn', '411527000000', '淮滨县', '', 3, '河南省', '信阳市', '淮滨县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2124', 'cn', '411528000000', '息县', '', 3, '河南省', '信阳市', '息县', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2125', 'cn', '411571000000', '信阳高新技术产业开发区', '', 3, '河南省', '信阳市', '信阳高新技术产业开发区', 0, 1, '411500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2126', 'cn', '411601000000', '市辖区', '', 3, '河南省', '周口市', '市辖区', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2127', 'cn', '411602000000', '川汇区', '', 3, '河南省', '周口市', '川汇区', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2128', 'cn', '411621000000', '扶沟县', '', 3, '河南省', '周口市', '扶沟县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2129', 'cn', '411622000000', '西华县', '', 3, '河南省', '周口市', '西华县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('213', 'cn', '429000000000', '省直辖县级行政区划', '', 2, '湖北省', '省直辖县级行政区划', '', 0, 1, '420000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2130', 'cn', '411623000000', '商水县', '', 3, '河南省', '周口市', '商水县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2131', 'cn', '411624000000', '沈丘县', '', 3, '河南省', '周口市', '沈丘县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2132', 'cn', '411625000000', '郸城县', '', 3, '河南省', '周口市', '郸城县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2133', 'cn', '411626000000', '淮阳县', '', 3, '河南省', '周口市', '淮阳县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2134', 'cn', '411627000000', '太康县', '', 3, '河南省', '周口市', '太康县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2135', 'cn', '411628000000', '鹿邑县', '', 3, '河南省', '周口市', '鹿邑县', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2136', 'cn', '411671000000', '河南周口经济开发区', '', 3, '河南省', '周口市', '河南周口经济开发区', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2137', 'cn', '411681000000', '项城市', '', 3, '河南省', '周口市', '项城市', 0, 1, '411600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2138', 'cn', '411701000000', '市辖区', '', 3, '河南省', '驻马店市', '市辖区', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2139', 'cn', '411702000000', '驿城区', '', 3, '河南省', '驻马店市', '驿城区', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('214', 'cn', '430100000000', '长沙市', '', 2, '湖南省', '长沙市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2140', 'cn', '411721000000', '西平县', '', 3, '河南省', '驻马店市', '西平县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2141', 'cn', '411722000000', '上蔡县', '', 3, '河南省', '驻马店市', '上蔡县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2142', 'cn', '411723000000', '平舆县', '', 3, '河南省', '驻马店市', '平舆县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2143', 'cn', '411724000000', '正阳县', '', 3, '河南省', '驻马店市', '正阳县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2144', 'cn', '411725000000', '确山县', '', 3, '河南省', '驻马店市', '确山县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2145', 'cn', '411726000000', '泌阳县', '', 3, '河南省', '驻马店市', '泌阳县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2146', 'cn', '411727000000', '汝南县', '', 3, '河南省', '驻马店市', '汝南县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2147', 'cn', '411728000000', '遂平县', '', 3, '河南省', '驻马店市', '遂平县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2148', 'cn', '411729000000', '新蔡县', '', 3, '河南省', '驻马店市', '新蔡县', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2149', 'cn', '411771000000', '河南驻马店经济开发区', '', 3, '河南省', '驻马店市', '河南驻马店经济开发区', 0, 1, '411700000000');
INSERT INTO SYS_NATION_AREA VALUES ('215', 'cn', '430200000000', '株洲市', '', 2, '湖南省', '株洲市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2150', 'cn', '419001000000', '济源市', '', 3, '河南省', '省直辖县级行政区划', '济源市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2151', 'cn', '420101000000', '市辖区', '', 3, '湖北省', '武汉市', '市辖区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2152', 'cn', '420102000000', '江岸区', '', 3, '湖北省', '武汉市', '江岸区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2153', 'cn', '420103000000', '江汉区', '', 3, '湖北省', '武汉市', '江汉区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2154', 'cn', '420104000000', '硚口区', '', 3, '湖北省', '武汉市', '硚口区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2155', 'cn', '420105000000', '汉阳区', '', 3, '湖北省', '武汉市', '汉阳区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2156', 'cn', '420106000000', '武昌区', '', 3, '湖北省', '武汉市', '武昌区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2157', 'cn', '420107000000', '青山区', '', 3, '湖北省', '武汉市', '青山区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2158', 'cn', '420111000000', '洪山区', '', 3, '湖北省', '武汉市', '洪山区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2159', 'cn', '420112000000', '东西湖区', '', 3, '湖北省', '武汉市', '东西湖区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('216', 'cn', '430300000000', '湘潭市', '', 2, '湖南省', '湘潭市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2160', 'cn', '420113000000', '汉南区', '', 3, '湖北省', '武汉市', '汉南区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2161', 'cn', '420114000000', '蔡甸区', '', 3, '湖北省', '武汉市', '蔡甸区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2162', 'cn', '420115000000', '江夏区', '', 3, '湖北省', '武汉市', '江夏区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2163', 'cn', '420116000000', '黄陂区', '', 3, '湖北省', '武汉市', '黄陂区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2164', 'cn', '420117000000', '新洲区', '', 3, '湖北省', '武汉市', '新洲区', 0, 1, '420100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2165', 'cn', '420201000000', '市辖区', '', 3, '湖北省', '黄石市', '市辖区', 0, 1, '420200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2166', 'cn', '420202000000', '黄石港区', '', 3, '湖北省', '黄石市', '黄石港区', 0, 1, '420200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2167', 'cn', '420203000000', '西塞山区', '', 3, '湖北省', '黄石市', '西塞山区', 0, 1, '420200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2168', 'cn', '420204000000', '下陆区', '', 3, '湖北省', '黄石市', '下陆区', 0, 1, '420200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2169', 'cn', '420205000000', '铁山区', '', 3, '湖北省', '黄石市', '铁山区', 0, 1, '420200000000');
INSERT INTO SYS_NATION_AREA VALUES ('217', 'cn', '430400000000', '衡阳市', '', 2, '湖南省', '衡阳市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2170', 'cn', '420222000000', '阳新县', '', 3, '湖北省', '黄石市', '阳新县', 0, 1, '420200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2171', 'cn', '420281000000', '大冶市', '', 3, '湖北省', '黄石市', '大冶市', 0, 1, '420200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2172', 'cn', '420301000000', '市辖区', '', 3, '湖北省', '十堰市', '市辖区', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2173', 'cn', '420302000000', '茅箭区', '', 3, '湖北省', '十堰市', '茅箭区', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2174', 'cn', '420303000000', '张湾区', '', 3, '湖北省', '十堰市', '张湾区', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2175', 'cn', '420304000000', '郧阳区', '', 3, '湖北省', '十堰市', '郧阳区', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2176', 'cn', '420322000000', '郧西县', '', 3, '湖北省', '十堰市', '郧西县', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2177', 'cn', '420323000000', '竹山县', '', 3, '湖北省', '十堰市', '竹山县', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2178', 'cn', '420324000000', '竹溪县', '', 3, '湖北省', '十堰市', '竹溪县', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2179', 'cn', '420325000000', '房县', '', 3, '湖北省', '十堰市', '房县', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('218', 'cn', '430500000000', '邵阳市', '', 2, '湖南省', '邵阳市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2180', 'cn', '420381000000', '丹江口市', '', 3, '湖北省', '十堰市', '丹江口市', 0, 1, '420300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2181', 'cn', '420501000000', '市辖区', '', 3, '湖北省', '宜昌市', '市辖区', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2182', 'cn', '420502000000', '西陵区', '', 3, '湖北省', '宜昌市', '西陵区', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2183', 'cn', '420503000000', '伍家岗区', '', 3, '湖北省', '宜昌市', '伍家岗区', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2184', 'cn', '420504000000', '点军区', '', 3, '湖北省', '宜昌市', '点军区', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2185', 'cn', '420505000000', '猇亭区', '', 3, '湖北省', '宜昌市', '猇亭区', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2186', 'cn', '420506000000', '夷陵区', '', 3, '湖北省', '宜昌市', '夷陵区', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2187', 'cn', '420525000000', '远安县', '', 3, '湖北省', '宜昌市', '远安县', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2188', 'cn', '420526000000', '兴山县', '', 3, '湖北省', '宜昌市', '兴山县', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2189', 'cn', '420527000000', '秭归县', '', 3, '湖北省', '宜昌市', '秭归县', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('219', 'cn', '430600000000', '岳阳市', '', 2, '湖南省', '岳阳市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2190', 'cn', '420528000000', '长阳土家族自治县', '', 3, '湖北省', '宜昌市', '长阳土家族自治县', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2191', 'cn', '420529000000', '五峰土家族自治县', '', 3, '湖北省', '宜昌市', '五峰土家族自治县', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2192', 'cn', '420581000000', '宜都市', '', 3, '湖北省', '宜昌市', '宜都市', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2193', 'cn', '420582000000', '当阳市', '', 3, '湖北省', '宜昌市', '当阳市', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2194', 'cn', '420583000000', '枝江市', '', 3, '湖北省', '宜昌市', '枝江市', 0, 1, '420500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2195', 'cn', '420601000000', '市辖区', '', 3, '湖北省', '襄阳市', '市辖区', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2196', 'cn', '420602000000', '襄城区', '', 3, '湖北省', '襄阳市', '襄城区', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2197', 'cn', '420606000000', '樊城区', '', 3, '湖北省', '襄阳市', '樊城区', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2198', 'cn', '420607000000', '襄州区', '', 3, '湖北省', '襄阳市', '襄州区', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2199', 'cn', '420624000000', '南漳县', '', 3, '湖北省', '襄阳市', '南漳县', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('22', 'cn', '500000000000', '重庆市', '', 1, '重庆市', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('220', 'cn', '430700000000', '常德市', '', 2, '湖南省', '常德市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2200', 'cn', '420625000000', '谷城县', '', 3, '湖北省', '襄阳市', '谷城县', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2201', 'cn', '420626000000', '保康县', '', 3, '湖北省', '襄阳市', '保康县', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2202', 'cn', '420682000000', '老河口市', '', 3, '湖北省', '襄阳市', '老河口市', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2203', 'cn', '420683000000', '枣阳市', '', 3, '湖北省', '襄阳市', '枣阳市', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2204', 'cn', '420684000000', '宜城市', '', 3, '湖北省', '襄阳市', '宜城市', 0, 1, '420600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2205', 'cn', '420701000000', '市辖区', '', 3, '湖北省', '鄂州市', '市辖区', 0, 1, '420700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2206', 'cn', '420702000000', '梁子湖区', '', 3, '湖北省', '鄂州市', '梁子湖区', 0, 1, '420700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2207', 'cn', '420703000000', '华容区', '', 3, '湖北省', '鄂州市', '华容区', 0, 1, '420700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2208', 'cn', '420704000000', '鄂城区', '', 3, '湖北省', '鄂州市', '鄂城区', 0, 1, '420700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2209', 'cn', '420801000000', '市辖区', '', 3, '湖北省', '荆门市', '市辖区', 0, 1, '420800000000');
INSERT INTO SYS_NATION_AREA VALUES ('221', 'cn', '430800000000', '张家界市', '', 2, '湖南省', '张家界市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2210', 'cn', '420802000000', '东宝区', '', 3, '湖北省', '荆门市', '东宝区', 0, 1, '420800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2211', 'cn', '420804000000', '掇刀区', '', 3, '湖北省', '荆门市', '掇刀区', 0, 1, '420800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2212', 'cn', '420821000000', '京山县', '', 3, '湖北省', '荆门市', '京山县', 0, 1, '420800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2213', 'cn', '420822000000', '沙洋县', '', 3, '湖北省', '荆门市', '沙洋县', 0, 1, '420800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2214', 'cn', '420881000000', '钟祥市', '', 3, '湖北省', '荆门市', '钟祥市', 0, 1, '420800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2215', 'cn', '420901000000', '市辖区', '', 3, '湖北省', '孝感市', '市辖区', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2216', 'cn', '420902000000', '孝南区', '', 3, '湖北省', '孝感市', '孝南区', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2217', 'cn', '420921000000', '孝昌县', '', 3, '湖北省', '孝感市', '孝昌县', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2218', 'cn', '420922000000', '大悟县', '', 3, '湖北省', '孝感市', '大悟县', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2219', 'cn', '420923000000', '云梦县', '', 3, '湖北省', '孝感市', '云梦县', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('222', 'cn', '430900000000', '益阳市', '', 2, '湖南省', '益阳市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2220', 'cn', '420981000000', '应城市', '', 3, '湖北省', '孝感市', '应城市', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2221', 'cn', '420982000000', '安陆市', '', 3, '湖北省', '孝感市', '安陆市', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2222', 'cn', '420984000000', '汉川市', '', 3, '湖北省', '孝感市', '汉川市', 0, 1, '420900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2223', 'cn', '421001000000', '市辖区', '', 3, '湖北省', '荆州市', '市辖区', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2224', 'cn', '421002000000', '沙市区', '', 3, '湖北省', '荆州市', '沙市区', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2225', 'cn', '421003000000', '荆州区', '', 3, '湖北省', '荆州市', '荆州区', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2226', 'cn', '421022000000', '公安县', '', 3, '湖北省', '荆州市', '公安县', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2227', 'cn', '421023000000', '监利县', '', 3, '湖北省', '荆州市', '监利县', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2228', 'cn', '421024000000', '江陵县', '', 3, '湖北省', '荆州市', '江陵县', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2229', 'cn', '421071000000', '荆州经济技术开发区', '', 3, '湖北省', '荆州市', '荆州经济技术开发区', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('223', 'cn', '431000000000', '郴州市', '', 2, '湖南省', '郴州市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2230', 'cn', '421081000000', '石首市', '', 3, '湖北省', '荆州市', '石首市', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2231', 'cn', '421083000000', '洪湖市', '', 3, '湖北省', '荆州市', '洪湖市', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2232', 'cn', '421087000000', '松滋市', '', 3, '湖北省', '荆州市', '松滋市', 0, 1, '421000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2233', 'cn', '421101000000', '市辖区', '', 3, '湖北省', '黄冈市', '市辖区', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2234', 'cn', '421102000000', '黄州区', '', 3, '湖北省', '黄冈市', '黄州区', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2235', 'cn', '421121000000', '团风县', '', 3, '湖北省', '黄冈市', '团风县', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2236', 'cn', '421122000000', '红安县', '', 3, '湖北省', '黄冈市', '红安县', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2237', 'cn', '421123000000', '罗田县', '', 3, '湖北省', '黄冈市', '罗田县', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2238', 'cn', '421124000000', '英山县', '', 3, '湖北省', '黄冈市', '英山县', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2239', 'cn', '421125000000', '浠水县', '', 3, '湖北省', '黄冈市', '浠水县', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('224', 'cn', '431100000000', '永州市', '', 2, '湖南省', '永州市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2240', 'cn', '421126000000', '蕲春县', '', 3, '湖北省', '黄冈市', '蕲春县', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2241', 'cn', '421127000000', '黄梅县', '', 3, '湖北省', '黄冈市', '黄梅县', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2242', 'cn', '421171000000', '龙感湖管理区', '', 3, '湖北省', '黄冈市', '龙感湖管理区', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2243', 'cn', '421181000000', '麻城市', '', 3, '湖北省', '黄冈市', '麻城市', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2244', 'cn', '421182000000', '武穴市', '', 3, '湖北省', '黄冈市', '武穴市', 0, 1, '421100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2245', 'cn', '421201000000', '市辖区', '', 3, '湖北省', '咸宁市', '市辖区', 0, 1, '421200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2246', 'cn', '421202000000', '咸安区', '', 3, '湖北省', '咸宁市', '咸安区', 0, 1, '421200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2247', 'cn', '421221000000', '嘉鱼县', '', 3, '湖北省', '咸宁市', '嘉鱼县', 0, 1, '421200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2248', 'cn', '421222000000', '通城县', '', 3, '湖北省', '咸宁市', '通城县', 0, 1, '421200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2249', 'cn', '421223000000', '崇阳县', '', 3, '湖北省', '咸宁市', '崇阳县', 0, 1, '421200000000');
INSERT INTO SYS_NATION_AREA VALUES ('225', 'cn', '431200000000', '怀化市', '', 2, '湖南省', '怀化市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2250', 'cn', '421224000000', '通山县', '', 3, '湖北省', '咸宁市', '通山县', 0, 1, '421200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2251', 'cn', '421281000000', '赤壁市', '', 3, '湖北省', '咸宁市', '赤壁市', 0, 1, '421200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2252', 'cn', '421301000000', '市辖区', '', 3, '湖北省', '随州市', '市辖区', 0, 1, '421300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2253', 'cn', '421303000000', '曾都区', '', 3, '湖北省', '随州市', '曾都区', 0, 1, '421300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2254', 'cn', '421321000000', '随县', '', 3, '湖北省', '随州市', '随县', 0, 1, '421300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2255', 'cn', '421381000000', '广水市', '', 3, '湖北省', '随州市', '广水市', 0, 1, '421300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2256', 'cn', '422801000000', '恩施市', '', 3, '湖北省', '恩施土家族苗族自治州', '恩施市', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2257', 'cn', '422802000000', '利川市', '', 3, '湖北省', '恩施土家族苗族自治州', '利川市', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2258', 'cn', '422822000000', '建始县', '', 3, '湖北省', '恩施土家族苗族自治州', '建始县', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2259', 'cn', '422823000000', '巴东县', '', 3, '湖北省', '恩施土家族苗族自治州', '巴东县', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('226', 'cn', '431300000000', '娄底市', '', 2, '湖南省', '娄底市', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2260', 'cn', '422825000000', '宣恩县', '', 3, '湖北省', '恩施土家族苗族自治州', '宣恩县', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2261', 'cn', '422826000000', '咸丰县', '', 3, '湖北省', '恩施土家族苗族自治州', '咸丰县', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2262', 'cn', '422827000000', '来凤县', '', 3, '湖北省', '恩施土家族苗族自治州', '来凤县', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2263', 'cn', '422828000000', '鹤峰县', '', 3, '湖北省', '恩施土家族苗族自治州', '鹤峰县', 0, 1, '422800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2264', 'cn', '429004000000', '仙桃市', '', 3, '湖北省', '省直辖县级行政区划', '仙桃市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2265', 'cn', '429005000000', '潜江市', '', 3, '湖北省', '省直辖县级行政区划', '潜江市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2266', 'cn', '429006000000', '天门市', '', 3, '湖北省', '省直辖县级行政区划', '天门市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2267', 'cn', '429021000000', '神农架林区', '', 3, '湖北省', '省直辖县级行政区划', '神农架林区', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2268', 'cn', '430101000000', '市辖区', '', 3, '湖南省', '长沙市', '市辖区', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2269', 'cn', '430102000000', '芙蓉区', '', 3, '湖南省', '长沙市', '芙蓉区', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('227', 'cn', '433100000000', '湘西土家族苗族自治州', '', 2, '湖南省', '湘西土家族苗族自治州', '', 0, 1, '430000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2270', 'cn', '430103000000', '天心区', '', 3, '湖南省', '长沙市', '天心区', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2271', 'cn', '430104000000', '岳麓区', '', 3, '湖南省', '长沙市', '岳麓区', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2272', 'cn', '430105000000', '开福区', '', 3, '湖南省', '长沙市', '开福区', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2273', 'cn', '430111000000', '雨花区', '', 3, '湖南省', '长沙市', '雨花区', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2274', 'cn', '430112000000', '望城区', '', 3, '湖南省', '长沙市', '望城区', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2275', 'cn', '430121000000', '长沙县', '', 3, '湖南省', '长沙市', '长沙县', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2276', 'cn', '430181000000', '浏阳市', '', 3, '湖南省', '长沙市', '浏阳市', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2277', 'cn', '430182000000', '宁乡市', '', 3, '湖南省', '长沙市', '宁乡市', 0, 1, '430100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2278', 'cn', '430201000000', '市辖区', '', 3, '湖南省', '株洲市', '市辖区', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2279', 'cn', '430202000000', '荷塘区', '', 3, '湖南省', '株洲市', '荷塘区', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('228', 'cn', '440100000000', '广州市', '', 2, '广东省', '广州市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2280', 'cn', '430203000000', '芦淞区', '', 3, '湖南省', '株洲市', '芦淞区', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2281', 'cn', '430204000000', '石峰区', '', 3, '湖南省', '株洲市', '石峰区', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2282', 'cn', '430211000000', '天元区', '', 3, '湖南省', '株洲市', '天元区', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2283', 'cn', '430221000000', '株洲县', '', 3, '湖南省', '株洲市', '株洲县', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2284', 'cn', '430223000000', '攸县', '', 3, '湖南省', '株洲市', '攸县', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2285', 'cn', '430224000000', '茶陵县', '', 3, '湖南省', '株洲市', '茶陵县', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2286', 'cn', '430225000000', '炎陵县', '', 3, '湖南省', '株洲市', '炎陵县', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2287', 'cn', '430271000000', '云龙示范区', '', 3, '湖南省', '株洲市', '云龙示范区', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2288', 'cn', '430281000000', '醴陵市', '', 3, '湖南省', '株洲市', '醴陵市', 0, 1, '430200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2289', 'cn', '430301000000', '市辖区', '', 3, '湖南省', '湘潭市', '市辖区', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('229', 'cn', '440200000000', '韶关市', '', 2, '广东省', '韶关市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2290', 'cn', '430302000000', '雨湖区', '', 3, '湖南省', '湘潭市', '雨湖区', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2291', 'cn', '430304000000', '岳塘区', '', 3, '湖南省', '湘潭市', '岳塘区', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2292', 'cn', '430321000000', '湘潭县', '', 3, '湖南省', '湘潭市', '湘潭县', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2293', 'cn', '430371000000', '湖南湘潭高新技术产业园区', '', 3, '湖南省', '湘潭市', '湖南湘潭高新技术产业园区', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2294', 'cn', '430372000000', '湘潭昭山示范区', '', 3, '湖南省', '湘潭市', '湘潭昭山示范区', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2295', 'cn', '430373000000', '湘潭九华示范区', '', 3, '湖南省', '湘潭市', '湘潭九华示范区', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2296', 'cn', '430381000000', '湘乡市', '', 3, '湖南省', '湘潭市', '湘乡市', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2297', 'cn', '430382000000', '韶山市', '', 3, '湖南省', '湘潭市', '韶山市', 0, 1, '430300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2298', 'cn', '430401000000', '市辖区', '', 3, '湖南省', '衡阳市', '市辖区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2299', 'cn', '430405000000', '珠晖区', '', 3, '湖南省', '衡阳市', '珠晖区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('23', 'cn', '510000000000', '四川省', '', 1, '四川省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('230', 'cn', '440300000000', '深圳市', '', 2, '广东省', '深圳市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2300', 'cn', '430406000000', '雁峰区', '', 3, '湖南省', '衡阳市', '雁峰区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2301', 'cn', '430407000000', '石鼓区', '', 3, '湖南省', '衡阳市', '石鼓区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2302', 'cn', '430408000000', '蒸湘区', '', 3, '湖南省', '衡阳市', '蒸湘区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2303', 'cn', '430412000000', '南岳区', '', 3, '湖南省', '衡阳市', '南岳区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2304', 'cn', '430421000000', '衡阳县', '', 3, '湖南省', '衡阳市', '衡阳县', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2305', 'cn', '430422000000', '衡南县', '', 3, '湖南省', '衡阳市', '衡南县', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2306', 'cn', '430423000000', '衡山县', '', 3, '湖南省', '衡阳市', '衡山县', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2307', 'cn', '430424000000', '衡东县', '', 3, '湖南省', '衡阳市', '衡东县', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2308', 'cn', '430426000000', '祁东县', '', 3, '湖南省', '衡阳市', '祁东县', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2309', 'cn', '430471000000', '衡阳综合保税区', '', 3, '湖南省', '衡阳市', '衡阳综合保税区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('231', 'cn', '440400000000', '珠海市', '', 2, '广东省', '珠海市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2310', 'cn', '430472000000', '湖南衡阳高新技术产业园区', '', 3, '湖南省', '衡阳市', '湖南衡阳高新技术产业园区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2311', 'cn', '430473000000', '湖南衡阳松木经济开发区', '', 3, '湖南省', '衡阳市', '湖南衡阳松木经济开发区', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2312', 'cn', '430481000000', '耒阳市', '', 3, '湖南省', '衡阳市', '耒阳市', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2313', 'cn', '430482000000', '常宁市', '', 3, '湖南省', '衡阳市', '常宁市', 0, 1, '430400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2314', 'cn', '430501000000', '市辖区', '', 3, '湖南省', '邵阳市', '市辖区', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2315', 'cn', '430502000000', '双清区', '', 3, '湖南省', '邵阳市', '双清区', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2316', 'cn', '430503000000', '大祥区', '', 3, '湖南省', '邵阳市', '大祥区', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2317', 'cn', '430511000000', '北塔区', '', 3, '湖南省', '邵阳市', '北塔区', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2318', 'cn', '430521000000', '邵东县', '', 3, '湖南省', '邵阳市', '邵东县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2319', 'cn', '430522000000', '新邵县', '', 3, '湖南省', '邵阳市', '新邵县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('232', 'cn', '440500000000', '汕头市', '', 2, '广东省', '汕头市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2320', 'cn', '430523000000', '邵阳县', '', 3, '湖南省', '邵阳市', '邵阳县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2321', 'cn', '430524000000', '隆回县', '', 3, '湖南省', '邵阳市', '隆回县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2322', 'cn', '430525000000', '洞口县', '', 3, '湖南省', '邵阳市', '洞口县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2323', 'cn', '430527000000', '绥宁县', '', 3, '湖南省', '邵阳市', '绥宁县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2324', 'cn', '430528000000', '新宁县', '', 3, '湖南省', '邵阳市', '新宁县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2325', 'cn', '430529000000', '城步苗族自治县', '', 3, '湖南省', '邵阳市', '城步苗族自治县', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2326', 'cn', '430581000000', '武冈市', '', 3, '湖南省', '邵阳市', '武冈市', 0, 1, '430500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2327', 'cn', '430601000000', '市辖区', '', 3, '湖南省', '岳阳市', '市辖区', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2328', 'cn', '430602000000', '岳阳楼区', '', 3, '湖南省', '岳阳市', '岳阳楼区', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2329', 'cn', '430603000000', '云溪区', '', 3, '湖南省', '岳阳市', '云溪区', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('233', 'cn', '440600000000', '佛山市', '', 2, '广东省', '佛山市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2330', 'cn', '430611000000', '君山区', '', 3, '湖南省', '岳阳市', '君山区', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2331', 'cn', '430621000000', '岳阳县', '', 3, '湖南省', '岳阳市', '岳阳县', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2332', 'cn', '430623000000', '华容县', '', 3, '湖南省', '岳阳市', '华容县', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2333', 'cn', '430624000000', '湘阴县', '', 3, '湖南省', '岳阳市', '湘阴县', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2334', 'cn', '430626000000', '平江县', '', 3, '湖南省', '岳阳市', '平江县', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2335', 'cn', '430671000000', '岳阳市屈原管理区', '', 3, '湖南省', '岳阳市', '岳阳市屈原管理区', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2336', 'cn', '430681000000', '汨罗市', '', 3, '湖南省', '岳阳市', '汨罗市', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2337', 'cn', '430682000000', '临湘市', '', 3, '湖南省', '岳阳市', '临湘市', 0, 1, '430600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2338', 'cn', '430701000000', '市辖区', '', 3, '湖南省', '常德市', '市辖区', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2339', 'cn', '430702000000', '武陵区', '', 3, '湖南省', '常德市', '武陵区', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('234', 'cn', '440700000000', '江门市', '', 2, '广东省', '江门市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2340', 'cn', '430703000000', '鼎城区', '', 3, '湖南省', '常德市', '鼎城区', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2341', 'cn', '430721000000', '安乡县', '', 3, '湖南省', '常德市', '安乡县', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2342', 'cn', '430722000000', '汉寿县', '', 3, '湖南省', '常德市', '汉寿县', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2343', 'cn', '430723000000', '澧县', '', 3, '湖南省', '常德市', '澧县', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2344', 'cn', '430724000000', '临澧县', '', 3, '湖南省', '常德市', '临澧县', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2345', 'cn', '430725000000', '桃源县', '', 3, '湖南省', '常德市', '桃源县', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2346', 'cn', '430726000000', '石门县', '', 3, '湖南省', '常德市', '石门县', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2347', 'cn', '430771000000', '常德市西洞庭管理区', '', 3, '湖南省', '常德市', '常德市西洞庭管理区', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2348', 'cn', '430781000000', '津市市', '', 3, '湖南省', '常德市', '津市市', 0, 1, '430700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2349', 'cn', '430801000000', '市辖区', '', 3, '湖南省', '张家界市', '市辖区', 0, 1, '430800000000');
INSERT INTO SYS_NATION_AREA VALUES ('235', 'cn', '440800000000', '湛江市', '', 2, '广东省', '湛江市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2350', 'cn', '430802000000', '永定区', '', 3, '湖南省', '张家界市', '永定区', 0, 1, '430800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2351', 'cn', '430811000000', '武陵源区', '', 3, '湖南省', '张家界市', '武陵源区', 0, 1, '430800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2352', 'cn', '430821000000', '慈利县', '', 3, '湖南省', '张家界市', '慈利县', 0, 1, '430800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2353', 'cn', '430822000000', '桑植县', '', 3, '湖南省', '张家界市', '桑植县', 0, 1, '430800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2354', 'cn', '430901000000', '市辖区', '', 3, '湖南省', '益阳市', '市辖区', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2355', 'cn', '430902000000', '资阳区', '', 3, '湖南省', '益阳市', '资阳区', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2356', 'cn', '430903000000', '赫山区', '', 3, '湖南省', '益阳市', '赫山区', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2357', 'cn', '430921000000', '南县', '', 3, '湖南省', '益阳市', '南县', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2358', 'cn', '430922000000', '桃江县', '', 3, '湖南省', '益阳市', '桃江县', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2359', 'cn', '430923000000', '安化县', '', 3, '湖南省', '益阳市', '安化县', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('236', 'cn', '440900000000', '茂名市', '', 2, '广东省', '茂名市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2360', 'cn', '430971000000', '益阳市大通湖管理区', '', 3, '湖南省', '益阳市', '益阳市大通湖管理区', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2361', 'cn', '430972000000', '湖南益阳高新技术产业园区', '', 3, '湖南省', '益阳市', '湖南益阳高新技术产业园区', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2362', 'cn', '430981000000', '沅江市', '', 3, '湖南省', '益阳市', '沅江市', 0, 1, '430900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2363', 'cn', '431001000000', '市辖区', '', 3, '湖南省', '郴州市', '市辖区', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2364', 'cn', '431002000000', '北湖区', '', 3, '湖南省', '郴州市', '北湖区', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2365', 'cn', '431003000000', '苏仙区', '', 3, '湖南省', '郴州市', '苏仙区', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2366', 'cn', '431021000000', '桂阳县', '', 3, '湖南省', '郴州市', '桂阳县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2367', 'cn', '431022000000', '宜章县', '', 3, '湖南省', '郴州市', '宜章县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2368', 'cn', '431023000000', '永兴县', '', 3, '湖南省', '郴州市', '永兴县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2369', 'cn', '431024000000', '嘉禾县', '', 3, '湖南省', '郴州市', '嘉禾县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('237', 'cn', '441200000000', '肇庆市', '', 2, '广东省', '肇庆市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2370', 'cn', '431025000000', '临武县', '', 3, '湖南省', '郴州市', '临武县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2371', 'cn', '431026000000', '汝城县', '', 3, '湖南省', '郴州市', '汝城县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2372', 'cn', '431027000000', '桂东县', '', 3, '湖南省', '郴州市', '桂东县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2373', 'cn', '431028000000', '安仁县', '', 3, '湖南省', '郴州市', '安仁县', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2374', 'cn', '431081000000', '资兴市', '', 3, '湖南省', '郴州市', '资兴市', 0, 1, '431000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2375', 'cn', '431101000000', '市辖区', '', 3, '湖南省', '永州市', '市辖区', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2376', 'cn', '431102000000', '零陵区', '', 3, '湖南省', '永州市', '零陵区', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2377', 'cn', '431103000000', '冷水滩区', '', 3, '湖南省', '永州市', '冷水滩区', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2378', 'cn', '431121000000', '祁阳县', '', 3, '湖南省', '永州市', '祁阳县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2379', 'cn', '431122000000', '东安县', '', 3, '湖南省', '永州市', '东安县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('238', 'cn', '441300000000', '惠州市', '', 2, '广东省', '惠州市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2380', 'cn', '431123000000', '双牌县', '', 3, '湖南省', '永州市', '双牌县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2381', 'cn', '431124000000', '道县', '', 3, '湖南省', '永州市', '道县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2382', 'cn', '431125000000', '江永县', '', 3, '湖南省', '永州市', '江永县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2383', 'cn', '431126000000', '宁远县', '', 3, '湖南省', '永州市', '宁远县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2384', 'cn', '431127000000', '蓝山县', '', 3, '湖南省', '永州市', '蓝山县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2385', 'cn', '431128000000', '新田县', '', 3, '湖南省', '永州市', '新田县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2386', 'cn', '431129000000', '江华瑶族自治县', '', 3, '湖南省', '永州市', '江华瑶族自治县', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2387', 'cn', '431171000000', '永州经济技术开发区', '', 3, '湖南省', '永州市', '永州经济技术开发区', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2388', 'cn', '431172000000', '永州市金洞管理区', '', 3, '湖南省', '永州市', '永州市金洞管理区', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2389', 'cn', '431173000000', '永州市回龙圩管理区', '', 3, '湖南省', '永州市', '永州市回龙圩管理区', 0, 1, '431100000000');
INSERT INTO SYS_NATION_AREA VALUES ('239', 'cn', '441400000000', '梅州市', '', 2, '广东省', '梅州市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2390', 'cn', '431201000000', '市辖区', '', 3, '湖南省', '怀化市', '市辖区', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2391', 'cn', '431202000000', '鹤城区', '', 3, '湖南省', '怀化市', '鹤城区', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2392', 'cn', '431221000000', '中方县', '', 3, '湖南省', '怀化市', '中方县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2393', 'cn', '431222000000', '沅陵县', '', 3, '湖南省', '怀化市', '沅陵县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2394', 'cn', '431223000000', '辰溪县', '', 3, '湖南省', '怀化市', '辰溪县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2395', 'cn', '431224000000', '溆浦县', '', 3, '湖南省', '怀化市', '溆浦县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2396', 'cn', '431225000000', '会同县', '', 3, '湖南省', '怀化市', '会同县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2397', 'cn', '431226000000', '麻阳苗族自治县', '', 3, '湖南省', '怀化市', '麻阳苗族自治县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2398', 'cn', '431227000000', '新晃侗族自治县', '', 3, '湖南省', '怀化市', '新晃侗族自治县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2399', 'cn', '431228000000', '芷江侗族自治县', '', 3, '湖南省', '怀化市', '芷江侗族自治县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('24', 'cn', '520000000000', '贵州省', '', 1, '贵州省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('240', 'cn', '441500000000', '汕尾市', '', 2, '广东省', '汕尾市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2400', 'cn', '431229000000', '靖州苗族侗族自治县', '', 3, '湖南省', '怀化市', '靖州苗族侗族自治县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2401', 'cn', '431230000000', '通道侗族自治县', '', 3, '湖南省', '怀化市', '通道侗族自治县', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2402', 'cn', '431271000000', '怀化市洪江管理区', '', 3, '湖南省', '怀化市', '怀化市洪江管理区', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2403', 'cn', '431281000000', '洪江市', '', 3, '湖南省', '怀化市', '洪江市', 0, 1, '431200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2404', 'cn', '431301000000', '市辖区', '', 3, '湖南省', '娄底市', '市辖区', 0, 1, '431300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2405', 'cn', '431302000000', '娄星区', '', 3, '湖南省', '娄底市', '娄星区', 0, 1, '431300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2406', 'cn', '431321000000', '双峰县', '', 3, '湖南省', '娄底市', '双峰县', 0, 1, '431300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2407', 'cn', '431322000000', '新化县', '', 3, '湖南省', '娄底市', '新化县', 0, 1, '431300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2408', 'cn', '431381000000', '冷水江市', '', 3, '湖南省', '娄底市', '冷水江市', 0, 1, '431300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2409', 'cn', '431382000000', '涟源市', '', 3, '湖南省', '娄底市', '涟源市', 0, 1, '431300000000');
INSERT INTO SYS_NATION_AREA VALUES ('241', 'cn', '441600000000', '河源市', '', 2, '广东省', '河源市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2410', 'cn', '433101000000', '吉首市', '', 3, '湖南省', '湘西土家族苗族自治州', '吉首市', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2411', 'cn', '433122000000', '泸溪县', '', 3, '湖南省', '湘西土家族苗族自治州', '泸溪县', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2412', 'cn', '433123000000', '凤凰县', '', 3, '湖南省', '湘西土家族苗族自治州', '凤凰县', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2413', 'cn', '433124000000', '花垣县', '', 3, '湖南省', '湘西土家族苗族自治州', '花垣县', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2414', 'cn', '433125000000', '保靖县', '', 3, '湖南省', '湘西土家族苗族自治州', '保靖县', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2415', 'cn', '433126000000', '古丈县', '', 3, '湖南省', '湘西土家族苗族自治州', '古丈县', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2416', 'cn', '433127000000', '永顺县', '', 3, '湖南省', '湘西土家族苗族自治州', '永顺县', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2417', 'cn', '433130000000', '龙山县', '', 3, '湖南省', '湘西土家族苗族自治州', '龙山县', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2418', 'cn', '433172000000', '湖南吉首经济开发区', '', 3, '湖南省', '湘西土家族苗族自治州', '湖南吉首经济开发区', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2419', 'cn', '433173000000', '湖南永顺经济开发区', '', 3, '湖南省', '湘西土家族苗族自治州', '湖南永顺经济开发区', 0, 1, '433100000000');
INSERT INTO SYS_NATION_AREA VALUES ('242', 'cn', '441700000000', '阳江市', '', 2, '广东省', '阳江市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2420', 'cn', '440101000000', '市辖区', '', 3, '广东省', '广州市', '市辖区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2421', 'cn', '440103000000', '荔湾区', '', 3, '广东省', '广州市', '荔湾区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2422', 'cn', '440104000000', '越秀区', '', 3, '广东省', '广州市', '越秀区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2423', 'cn', '440105000000', '海珠区', '', 3, '广东省', '广州市', '海珠区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2424', 'cn', '440106000000', '天河区', '', 3, '广东省', '广州市', '天河区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2425', 'cn', '440111000000', '白云区', '', 3, '广东省', '广州市', '白云区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2426', 'cn', '440112000000', '黄埔区', '', 3, '广东省', '广州市', '黄埔区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2427', 'cn', '440113000000', '番禺区', '', 3, '广东省', '广州市', '番禺区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2428', 'cn', '440114000000', '花都区', '', 3, '广东省', '广州市', '花都区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2429', 'cn', '440115000000', '南沙区', '', 3, '广东省', '广州市', '南沙区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('243', 'cn', '441800000000', '清远市', '', 2, '广东省', '清远市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2430', 'cn', '440117000000', '从化区', '', 3, '广东省', '广州市', '从化区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2431', 'cn', '440118000000', '增城区', '', 3, '广东省', '广州市', '增城区', 0, 1, '440100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2432', 'cn', '440201000000', '市辖区', '', 3, '广东省', '韶关市', '市辖区', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2433', 'cn', '440203000000', '武江区', '', 3, '广东省', '韶关市', '武江区', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2434', 'cn', '440204000000', '浈江区', '', 3, '广东省', '韶关市', '浈江区', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2435', 'cn', '440205000000', '曲江区', '', 3, '广东省', '韶关市', '曲江区', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2436', 'cn', '440222000000', '始兴县', '', 3, '广东省', '韶关市', '始兴县', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2437', 'cn', '440224000000', '仁化县', '', 3, '广东省', '韶关市', '仁化县', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2438', 'cn', '440229000000', '翁源县', '', 3, '广东省', '韶关市', '翁源县', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2439', 'cn', '440232000000', '乳源瑶族自治县', '', 3, '广东省', '韶关市', '乳源瑶族自治县', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('244', 'cn', '441900000000', '东莞市', '', 2, '广东省', '东莞市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2440', 'cn', '440233000000', '新丰县', '', 3, '广东省', '韶关市', '新丰县', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2441', 'cn', '440281000000', '乐昌市', '', 3, '广东省', '韶关市', '乐昌市', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2442', 'cn', '440282000000', '南雄市', '', 3, '广东省', '韶关市', '南雄市', 0, 1, '440200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2443', 'cn', '440301000000', '市辖区', '', 3, '广东省', '深圳市', '市辖区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2444', 'cn', '440303000000', '罗湖区', '', 3, '广东省', '深圳市', '罗湖区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2445', 'cn', '440304000000', '福田区', '', 3, '广东省', '深圳市', '福田区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2446', 'cn', '440305000000', '南山区', '', 3, '广东省', '深圳市', '南山区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2447', 'cn', '440306000000', '宝安区', '', 3, '广东省', '深圳市', '宝安区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2448', 'cn', '440307000000', '龙岗区', '', 3, '广东省', '深圳市', '龙岗区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2449', 'cn', '440308000000', '盐田区', '', 3, '广东省', '深圳市', '盐田区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('245', 'cn', '442000000000', '中山市', '', 2, '广东省', '中山市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2450', 'cn', '440309000000', '龙华区', '', 3, '广东省', '深圳市', '龙华区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2451', 'cn', '440310000000', '坪山区', '', 3, '广东省', '深圳市', '坪山区', 0, 1, '440300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2452', 'cn', '440401000000', '市辖区', '', 3, '广东省', '珠海市', '市辖区', 0, 1, '440400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2453', 'cn', '440402000000', '香洲区', '', 3, '广东省', '珠海市', '香洲区', 0, 1, '440400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2454', 'cn', '440403000000', '斗门区', '', 3, '广东省', '珠海市', '斗门区', 0, 1, '440400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2455', 'cn', '440404000000', '金湾区', '', 3, '广东省', '珠海市', '金湾区', 0, 1, '440400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2456', 'cn', '440501000000', '市辖区', '', 3, '广东省', '汕头市', '市辖区', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2457', 'cn', '440507000000', '龙湖区', '', 3, '广东省', '汕头市', '龙湖区', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2458', 'cn', '440511000000', '金平区', '', 3, '广东省', '汕头市', '金平区', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2459', 'cn', '440512000000', '濠江区', '', 3, '广东省', '汕头市', '濠江区', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('246', 'cn', '445100000000', '潮州市', '', 2, '广东省', '潮州市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2460', 'cn', '440513000000', '潮阳区', '', 3, '广东省', '汕头市', '潮阳区', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2461', 'cn', '440514000000', '潮南区', '', 3, '广东省', '汕头市', '潮南区', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2462', 'cn', '440515000000', '澄海区', '', 3, '广东省', '汕头市', '澄海区', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2463', 'cn', '440523000000', '南澳县', '', 3, '广东省', '汕头市', '南澳县', 0, 1, '440500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2464', 'cn', '440601000000', '市辖区', '', 3, '广东省', '佛山市', '市辖区', 0, 1, '440600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2465', 'cn', '440604000000', '禅城区', '', 3, '广东省', '佛山市', '禅城区', 0, 1, '440600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2466', 'cn', '440605000000', '南海区', '', 3, '广东省', '佛山市', '南海区', 0, 1, '440600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2467', 'cn', '440606000000', '顺德区', '', 3, '广东省', '佛山市', '顺德区', 0, 1, '440600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2468', 'cn', '440607000000', '三水区', '', 3, '广东省', '佛山市', '三水区', 0, 1, '440600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2469', 'cn', '440608000000', '高明区', '', 3, '广东省', '佛山市', '高明区', 0, 1, '440600000000');
INSERT INTO SYS_NATION_AREA VALUES ('247', 'cn', '445200000000', '揭阳市', '', 2, '广东省', '揭阳市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2470', 'cn', '440701000000', '市辖区', '', 3, '广东省', '江门市', '市辖区', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2471', 'cn', '440703000000', '蓬江区', '', 3, '广东省', '江门市', '蓬江区', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2472', 'cn', '440704000000', '江海区', '', 3, '广东省', '江门市', '江海区', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2473', 'cn', '440705000000', '新会区', '', 3, '广东省', '江门市', '新会区', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2474', 'cn', '440781000000', '台山市', '', 3, '广东省', '江门市', '台山市', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2475', 'cn', '440783000000', '开平市', '', 3, '广东省', '江门市', '开平市', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2476', 'cn', '440784000000', '鹤山市', '', 3, '广东省', '江门市', '鹤山市', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2477', 'cn', '440785000000', '恩平市', '', 3, '广东省', '江门市', '恩平市', 0, 1, '440700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2478', 'cn', '440801000000', '市辖区', '', 3, '广东省', '湛江市', '市辖区', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2479', 'cn', '440802000000', '赤坎区', '', 3, '广东省', '湛江市', '赤坎区', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('248', 'cn', '445300000000', '云浮市', '', 2, '广东省', '云浮市', '', 0, 1, '440000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2480', 'cn', '440803000000', '霞山区', '', 3, '广东省', '湛江市', '霞山区', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2481', 'cn', '440804000000', '坡头区', '', 3, '广东省', '湛江市', '坡头区', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2482', 'cn', '440811000000', '麻章区', '', 3, '广东省', '湛江市', '麻章区', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2483', 'cn', '440823000000', '遂溪县', '', 3, '广东省', '湛江市', '遂溪县', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2484', 'cn', '440825000000', '徐闻县', '', 3, '广东省', '湛江市', '徐闻县', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2485', 'cn', '440881000000', '廉江市', '', 3, '广东省', '湛江市', '廉江市', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2486', 'cn', '440882000000', '雷州市', '', 3, '广东省', '湛江市', '雷州市', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2487', 'cn', '440883000000', '吴川市', '', 3, '广东省', '湛江市', '吴川市', 0, 1, '440800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2488', 'cn', '440901000000', '市辖区', '', 3, '广东省', '茂名市', '市辖区', 0, 1, '440900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2489', 'cn', '440902000000', '茂南区', '', 3, '广东省', '茂名市', '茂南区', 0, 1, '440900000000');
INSERT INTO SYS_NATION_AREA VALUES ('249', 'cn', '450100000000', '南宁市', '', 2, '广西壮族自治区', '南宁市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2490', 'cn', '440904000000', '电白区', '', 3, '广东省', '茂名市', '电白区', 0, 1, '440900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2491', 'cn', '440981000000', '高州市', '', 3, '广东省', '茂名市', '高州市', 0, 1, '440900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2492', 'cn', '440982000000', '化州市', '', 3, '广东省', '茂名市', '化州市', 0, 1, '440900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2493', 'cn', '440983000000', '信宜市', '', 3, '广东省', '茂名市', '信宜市', 0, 1, '440900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2494', 'cn', '441201000000', '市辖区', '', 3, '广东省', '肇庆市', '市辖区', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2495', 'cn', '441202000000', '端州区', '', 3, '广东省', '肇庆市', '端州区', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2496', 'cn', '441203000000', '鼎湖区', '', 3, '广东省', '肇庆市', '鼎湖区', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2497', 'cn', '441204000000', '高要区', '', 3, '广东省', '肇庆市', '高要区', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2498', 'cn', '441223000000', '广宁县', '', 3, '广东省', '肇庆市', '广宁县', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2499', 'cn', '441224000000', '怀集县', '', 3, '广东省', '肇庆市', '怀集县', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('25', 'cn', '530000000000', '云南省', '', 1, '云南省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('250', 'cn', '450200000000', '柳州市', '', 2, '广西壮族自治区', '柳州市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2500', 'cn', '441225000000', '封开县', '', 3, '广东省', '肇庆市', '封开县', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2501', 'cn', '441226000000', '德庆县', '', 3, '广东省', '肇庆市', '德庆县', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2502', 'cn', '441284000000', '四会市', '', 3, '广东省', '肇庆市', '四会市', 0, 1, '441200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2503', 'cn', '441301000000', '市辖区', '', 3, '广东省', '惠州市', '市辖区', 0, 1, '441300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2504', 'cn', '441302000000', '惠城区', '', 3, '广东省', '惠州市', '惠城区', 0, 1, '441300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2505', 'cn', '441303000000', '惠阳区', '', 3, '广东省', '惠州市', '惠阳区', 0, 1, '441300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2506', 'cn', '441322000000', '博罗县', '', 3, '广东省', '惠州市', '博罗县', 0, 1, '441300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2507', 'cn', '441323000000', '惠东县', '', 3, '广东省', '惠州市', '惠东县', 0, 1, '441300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2508', 'cn', '441324000000', '龙门县', '', 3, '广东省', '惠州市', '龙门县', 0, 1, '441300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2509', 'cn', '441401000000', '市辖区', '', 3, '广东省', '梅州市', '市辖区', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('251', 'cn', '450300000000', '桂林市', '', 2, '广西壮族自治区', '桂林市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2510', 'cn', '441402000000', '梅江区', '', 3, '广东省', '梅州市', '梅江区', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2511', 'cn', '441403000000', '梅县区', '', 3, '广东省', '梅州市', '梅县区', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2512', 'cn', '441422000000', '大埔县', '', 3, '广东省', '梅州市', '大埔县', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2513', 'cn', '441423000000', '丰顺县', '', 3, '广东省', '梅州市', '丰顺县', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2514', 'cn', '441424000000', '五华县', '', 3, '广东省', '梅州市', '五华县', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2515', 'cn', '441426000000', '平远县', '', 3, '广东省', '梅州市', '平远县', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2516', 'cn', '441427000000', '蕉岭县', '', 3, '广东省', '梅州市', '蕉岭县', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2517', 'cn', '441481000000', '兴宁市', '', 3, '广东省', '梅州市', '兴宁市', 0, 1, '441400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2518', 'cn', '441501000000', '市辖区', '', 3, '广东省', '汕尾市', '市辖区', 0, 1, '441500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2519', 'cn', '441502000000', '城区', '', 3, '广东省', '汕尾市', '城区', 0, 1, '441500000000');
INSERT INTO SYS_NATION_AREA VALUES ('252', 'cn', '450400000000', '梧州市', '', 2, '广西壮族自治区', '梧州市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2520', 'cn', '441521000000', '海丰县', '', 3, '广东省', '汕尾市', '海丰县', 0, 1, '441500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2521', 'cn', '441523000000', '陆河县', '', 3, '广东省', '汕尾市', '陆河县', 0, 1, '441500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2522', 'cn', '441581000000', '陆丰市', '', 3, '广东省', '汕尾市', '陆丰市', 0, 1, '441500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2523', 'cn', '441601000000', '市辖区', '', 3, '广东省', '河源市', '市辖区', 0, 1, '441600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2524', 'cn', '441602000000', '源城区', '', 3, '广东省', '河源市', '源城区', 0, 1, '441600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2525', 'cn', '441621000000', '紫金县', '', 3, '广东省', '河源市', '紫金县', 0, 1, '441600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2526', 'cn', '441622000000', '龙川县', '', 3, '广东省', '河源市', '龙川县', 0, 1, '441600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2527', 'cn', '441623000000', '连平县', '', 3, '广东省', '河源市', '连平县', 0, 1, '441600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2528', 'cn', '441624000000', '和平县', '', 3, '广东省', '河源市', '和平县', 0, 1, '441600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2529', 'cn', '441625000000', '东源县', '', 3, '广东省', '河源市', '东源县', 0, 1, '441600000000');
INSERT INTO SYS_NATION_AREA VALUES ('253', 'cn', '450500000000', '北海市', '', 2, '广西壮族自治区', '北海市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2530', 'cn', '441701000000', '市辖区', '', 3, '广东省', '阳江市', '市辖区', 0, 1, '441700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2531', 'cn', '441702000000', '江城区', '', 3, '广东省', '阳江市', '江城区', 0, 1, '441700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2532', 'cn', '441704000000', '阳东区', '', 3, '广东省', '阳江市', '阳东区', 0, 1, '441700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2533', 'cn', '441721000000', '阳西县', '', 3, '广东省', '阳江市', '阳西县', 0, 1, '441700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2534', 'cn', '441781000000', '阳春市', '', 3, '广东省', '阳江市', '阳春市', 0, 1, '441700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2535', 'cn', '441801000000', '市辖区', '', 3, '广东省', '清远市', '市辖区', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2536', 'cn', '441802000000', '清城区', '', 3, '广东省', '清远市', '清城区', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2537', 'cn', '441803000000', '清新区', '', 3, '广东省', '清远市', '清新区', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2538', 'cn', '441821000000', '佛冈县', '', 3, '广东省', '清远市', '佛冈县', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2539', 'cn', '441823000000', '阳山县', '', 3, '广东省', '清远市', '阳山县', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('254', 'cn', '450600000000', '防城港市', '', 2, '广西壮族自治区', '防城港市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2540', 'cn', '441825000000', '连山壮族瑶族自治县', '', 3, '广东省', '清远市', '连山壮族瑶族自治县', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2541', 'cn', '441826000000', '连南瑶族自治县', '', 3, '广东省', '清远市', '连南瑶族自治县', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2542', 'cn', '441881000000', '英德市', '', 3, '广东省', '清远市', '英德市', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2543', 'cn', '441882000000', '连州市', '', 3, '广东省', '清远市', '连州市', 0, 1, '441800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2544', 'cn', '441900003000', '东城街道办事处', '', 3, '广东省', '东莞市', '东城街道办事处', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2545', 'cn', '441900004000', '南城街道办事处', '', 3, '广东省', '东莞市', '南城街道办事处', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2546', 'cn', '441900005000', '万江街道办事处', '', 3, '广东省', '东莞市', '万江街道办事处', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2547', 'cn', '441900006000', '莞城街道办事处', '', 3, '广东省', '东莞市', '莞城街道办事处', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2548', 'cn', '441900101000', '石碣镇', '', 3, '广东省', '东莞市', '石碣镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2549', 'cn', '441900102000', '石龙镇', '', 3, '广东省', '东莞市', '石龙镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('255', 'cn', '450700000000', '钦州市', '', 2, '广西壮族自治区', '钦州市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2550', 'cn', '441900103000', '茶山镇', '', 3, '广东省', '东莞市', '茶山镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2551', 'cn', '441900104000', '石排镇', '', 3, '广东省', '东莞市', '石排镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2552', 'cn', '441900105000', '企石镇', '', 3, '广东省', '东莞市', '企石镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2553', 'cn', '441900106000', '横沥镇', '', 3, '广东省', '东莞市', '横沥镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2554', 'cn', '441900107000', '桥头镇', '', 3, '广东省', '东莞市', '桥头镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2555', 'cn', '441900108000', '谢岗镇', '', 3, '广东省', '东莞市', '谢岗镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2556', 'cn', '441900109000', '东坑镇', '', 3, '广东省', '东莞市', '东坑镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2557', 'cn', '441900110000', '常平镇', '', 3, '广东省', '东莞市', '常平镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2558', 'cn', '441900111000', '寮步镇', '', 3, '广东省', '东莞市', '寮步镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2559', 'cn', '441900112000', '樟木头镇', '', 3, '广东省', '东莞市', '樟木头镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('256', 'cn', '450800000000', '贵港市', '', 2, '广西壮族自治区', '贵港市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2560', 'cn', '441900113000', '大朗镇', '', 3, '广东省', '东莞市', '大朗镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2561', 'cn', '441900114000', '黄江镇', '', 3, '广东省', '东莞市', '黄江镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2562', 'cn', '441900115000', '清溪镇', '', 3, '广东省', '东莞市', '清溪镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2563', 'cn', '441900116000', '塘厦镇', '', 3, '广东省', '东莞市', '塘厦镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2564', 'cn', '441900117000', '凤岗镇', '', 3, '广东省', '东莞市', '凤岗镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2565', 'cn', '441900118000', '大岭山镇', '', 3, '广东省', '东莞市', '大岭山镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2566', 'cn', '441900119000', '长安镇', '', 3, '广东省', '东莞市', '长安镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2567', 'cn', '441900121000', '虎门镇', '', 3, '广东省', '东莞市', '虎门镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2568', 'cn', '441900122000', '厚街镇', '', 3, '广东省', '东莞市', '厚街镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2569', 'cn', '441900123000', '沙田镇', '', 3, '广东省', '东莞市', '沙田镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('257', 'cn', '450900000000', '玉林市', '', 2, '广西壮族自治区', '玉林市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2570', 'cn', '441900124000', '道滘镇', '', 3, '广东省', '东莞市', '道滘镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2571', 'cn', '441900125000', '洪梅镇', '', 3, '广东省', '东莞市', '洪梅镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2572', 'cn', '441900126000', '麻涌镇', '', 3, '广东省', '东莞市', '麻涌镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2573', 'cn', '441900127000', '望牛墩镇', '', 3, '广东省', '东莞市', '望牛墩镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2574', 'cn', '441900128000', '中堂镇', '', 3, '广东省', '东莞市', '中堂镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2575', 'cn', '441900129000', '高埗镇', '', 3, '广东省', '东莞市', '高埗镇', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2576', 'cn', '441900401000', '松山湖管委会', '', 3, '广东省', '东莞市', '松山湖管委会', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2577', 'cn', '441900402000', '东莞港', '', 3, '广东省', '东莞市', '东莞港', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2578', 'cn', '441900403000', '东莞生态园', '', 3, '广东省', '东莞市', '东莞生态园', 0, 1, '441900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2579', 'cn', '442000001000', '石岐区街道办事处', '', 3, '广东省', '中山市', '石岐区街道办事处', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('258', 'cn', '451000000000', '百色市', '', 2, '广西壮族自治区', '百色市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2580', 'cn', '442000002000', '东区街道办事处', '', 3, '广东省', '中山市', '东区街道办事处', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2581', 'cn', '442000003000', '火炬开发区街道办事处', '', 3, '广东省', '中山市', '火炬开发区街道办事处', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2582', 'cn', '442000004000', '西区街道办事处', '', 3, '广东省', '中山市', '西区街道办事处', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2583', 'cn', '442000005000', '南区街道办事处', '', 3, '广东省', '中山市', '南区街道办事处', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2584', 'cn', '442000006000', '五桂山街道办事处', '', 3, '广东省', '中山市', '五桂山街道办事处', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2585', 'cn', '442000100000', '小榄镇', '', 3, '广东省', '中山市', '小榄镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2586', 'cn', '442000101000', '黄圃镇', '', 3, '广东省', '中山市', '黄圃镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2587', 'cn', '442000102000', '民众镇', '', 3, '广东省', '中山市', '民众镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2588', 'cn', '442000103000', '东凤镇', '', 3, '广东省', '中山市', '东凤镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2589', 'cn', '442000104000', '东升镇', '', 3, '广东省', '中山市', '东升镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('259', 'cn', '451100000000', '贺州市', '', 2, '广西壮族自治区', '贺州市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2590', 'cn', '442000105000', '古镇镇', '', 3, '广东省', '中山市', '古镇镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2591', 'cn', '442000106000', '沙溪镇', '', 3, '广东省', '中山市', '沙溪镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2592', 'cn', '442000107000', '坦洲镇', '', 3, '广东省', '中山市', '坦洲镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2593', 'cn', '442000108000', '港口镇', '', 3, '广东省', '中山市', '港口镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2594', 'cn', '442000109000', '三角镇', '', 3, '广东省', '中山市', '三角镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2595', 'cn', '442000110000', '横栏镇', '', 3, '广东省', '中山市', '横栏镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2596', 'cn', '442000111000', '南头镇', '', 3, '广东省', '中山市', '南头镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2597', 'cn', '442000112000', '阜沙镇', '', 3, '广东省', '中山市', '阜沙镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2598', 'cn', '442000113000', '南朗镇', '', 3, '广东省', '中山市', '南朗镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2599', 'cn', '442000114000', '三乡镇', '', 3, '广东省', '中山市', '三乡镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('26', 'cn', '540000000000', '西藏自治区', '', 1, '西藏自治区', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('260', 'cn', '451200000000', '河池市', '', 2, '广西壮族自治区', '河池市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2600', 'cn', '442000115000', '板芙镇', '', 3, '广东省', '中山市', '板芙镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2601', 'cn', '442000116000', '大涌镇', '', 3, '广东省', '中山市', '大涌镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2602', 'cn', '442000117000', '神湾镇', '', 3, '广东省', '中山市', '神湾镇', 0, 1, '442000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2603', 'cn', '445101000000', '市辖区', '', 3, '广东省', '潮州市', '市辖区', 0, 1, '445100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2604', 'cn', '445102000000', '湘桥区', '', 3, '广东省', '潮州市', '湘桥区', 0, 1, '445100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2605', 'cn', '445103000000', '潮安区', '', 3, '广东省', '潮州市', '潮安区', 0, 1, '445100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2606', 'cn', '445122000000', '饶平县', '', 3, '广东省', '潮州市', '饶平县', 0, 1, '445100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2607', 'cn', '445201000000', '市辖区', '', 3, '广东省', '揭阳市', '市辖区', 0, 1, '445200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2608', 'cn', '445202000000', '榕城区', '', 3, '广东省', '揭阳市', '榕城区', 0, 1, '445200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2609', 'cn', '445203000000', '揭东区', '', 3, '广东省', '揭阳市', '揭东区', 0, 1, '445200000000');
INSERT INTO SYS_NATION_AREA VALUES ('261', 'cn', '451300000000', '来宾市', '', 2, '广西壮族自治区', '来宾市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2610', 'cn', '445222000000', '揭西县', '', 3, '广东省', '揭阳市', '揭西县', 0, 1, '445200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2611', 'cn', '445224000000', '惠来县', '', 3, '广东省', '揭阳市', '惠来县', 0, 1, '445200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2612', 'cn', '445281000000', '普宁市', '', 3, '广东省', '揭阳市', '普宁市', 0, 1, '445200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2613', 'cn', '445301000000', '市辖区', '', 3, '广东省', '云浮市', '市辖区', 0, 1, '445300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2614', 'cn', '445302000000', '云城区', '', 3, '广东省', '云浮市', '云城区', 0, 1, '445300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2615', 'cn', '445303000000', '云安区', '', 3, '广东省', '云浮市', '云安区', 0, 1, '445300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2616', 'cn', '445321000000', '新兴县', '', 3, '广东省', '云浮市', '新兴县', 0, 1, '445300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2617', 'cn', '445322000000', '郁南县', '', 3, '广东省', '云浮市', '郁南县', 0, 1, '445300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2618', 'cn', '445381000000', '罗定市', '', 3, '广东省', '云浮市', '罗定市', 0, 1, '445300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2619', 'cn', '450101000000', '市辖区', '', 3, '广西壮族自治区', '南宁市', '市辖区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('262', 'cn', '451400000000', '崇左市', '', 2, '广西壮族自治区', '崇左市', '', 0, 1, '450000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2620', 'cn', '450102000000', '兴宁区', '', 3, '广西壮族自治区', '南宁市', '兴宁区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2621', 'cn', '450103000000', '青秀区', '', 3, '广西壮族自治区', '南宁市', '青秀区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2622', 'cn', '450105000000', '江南区', '', 3, '广西壮族自治区', '南宁市', '江南区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2623', 'cn', '450107000000', '西乡塘区', '', 3, '广西壮族自治区', '南宁市', '西乡塘区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2624', 'cn', '450108000000', '良庆区', '', 3, '广西壮族自治区', '南宁市', '良庆区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2625', 'cn', '450109000000', '邕宁区', '', 3, '广西壮族自治区', '南宁市', '邕宁区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2626', 'cn', '450110000000', '武鸣区', '', 3, '广西壮族自治区', '南宁市', '武鸣区', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2627', 'cn', '450123000000', '隆安县', '', 3, '广西壮族自治区', '南宁市', '隆安县', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2628', 'cn', '450124000000', '马山县', '', 3, '广西壮族自治区', '南宁市', '马山县', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2629', 'cn', '450125000000', '上林县', '', 3, '广西壮族自治区', '南宁市', '上林县', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('263', 'cn', '460100000000', '海口市', '', 2, '海南省', '海口市', '', 0, 1, '460000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2630', 'cn', '450126000000', '宾阳县', '', 3, '广西壮族自治区', '南宁市', '宾阳县', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2631', 'cn', '450127000000', '横县', '', 3, '广西壮族自治区', '南宁市', '横县', 0, 1, '450100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2632', 'cn', '450201000000', '市辖区', '', 3, '广西壮族自治区', '柳州市', '市辖区', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2633', 'cn', '450202000000', '城中区', '', 3, '广西壮族自治区', '柳州市', '城中区', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2634', 'cn', '450203000000', '鱼峰区', '', 3, '广西壮族自治区', '柳州市', '鱼峰区', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2635', 'cn', '450204000000', '柳南区', '', 3, '广西壮族自治区', '柳州市', '柳南区', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2636', 'cn', '450205000000', '柳北区', '', 3, '广西壮族自治区', '柳州市', '柳北区', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2637', 'cn', '450206000000', '柳江区', '', 3, '广西壮族自治区', '柳州市', '柳江区', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2638', 'cn', '450222000000', '柳城县', '', 3, '广西壮族自治区', '柳州市', '柳城县', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2639', 'cn', '450223000000', '鹿寨县', '', 3, '广西壮族自治区', '柳州市', '鹿寨县', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('264', 'cn', '460200000000', '三亚市', '', 2, '海南省', '三亚市', '', 0, 1, '460000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2640', 'cn', '450224000000', '融安县', '', 3, '广西壮族自治区', '柳州市', '融安县', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2641', 'cn', '450225000000', '融水苗族自治县', '', 3, '广西壮族自治区', '柳州市', '融水苗族自治县', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2642', 'cn', '450226000000', '三江侗族自治县', '', 3, '广西壮族自治区', '柳州市', '三江侗族自治县', 0, 1, '450200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2643', 'cn', '450301000000', '市辖区', '', 3, '广西壮族自治区', '桂林市', '市辖区', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2644', 'cn', '450302000000', '秀峰区', '', 3, '广西壮族自治区', '桂林市', '秀峰区', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2645', 'cn', '450303000000', '叠彩区', '', 3, '广西壮族自治区', '桂林市', '叠彩区', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2646', 'cn', '450304000000', '象山区', '', 3, '广西壮族自治区', '桂林市', '象山区', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2647', 'cn', '450305000000', '七星区', '', 3, '广西壮族自治区', '桂林市', '七星区', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2648', 'cn', '450311000000', '雁山区', '', 3, '广西壮族自治区', '桂林市', '雁山区', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2649', 'cn', '450312000000', '临桂区', '', 3, '广西壮族自治区', '桂林市', '临桂区', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('265', 'cn', '460300000000', '三沙市', '', 2, '海南省', '三沙市', '', 0, 1, '460000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2650', 'cn', '450321000000', '阳朔县', '', 3, '广西壮族自治区', '桂林市', '阳朔县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2651', 'cn', '450323000000', '灵川县', '', 3, '广西壮族自治区', '桂林市', '灵川县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2652', 'cn', '450324000000', '全州县', '', 3, '广西壮族自治区', '桂林市', '全州县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2653', 'cn', '450325000000', '兴安县', '', 3, '广西壮族自治区', '桂林市', '兴安县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2654', 'cn', '450326000000', '永福县', '', 3, '广西壮族自治区', '桂林市', '永福县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2655', 'cn', '450327000000', '灌阳县', '', 3, '广西壮族自治区', '桂林市', '灌阳县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2656', 'cn', '450328000000', '龙胜各族自治县', '', 3, '广西壮族自治区', '桂林市', '龙胜各族自治县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2657', 'cn', '450329000000', '资源县', '', 3, '广西壮族自治区', '桂林市', '资源县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2658', 'cn', '450330000000', '平乐县', '', 3, '广西壮族自治区', '桂林市', '平乐县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2659', 'cn', '450331000000', '荔浦县', '', 3, '广西壮族自治区', '桂林市', '荔浦县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('266', 'cn', '460400000000', '儋州市', '', 2, '海南省', '儋州市', '', 0, 1, '460000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2660', 'cn', '450332000000', '恭城瑶族自治县', '', 3, '广西壮族自治区', '桂林市', '恭城瑶族自治县', 0, 1, '450300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2661', 'cn', '450401000000', '市辖区', '', 3, '广西壮族自治区', '梧州市', '市辖区', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2662', 'cn', '450403000000', '万秀区', '', 3, '广西壮族自治区', '梧州市', '万秀区', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2663', 'cn', '450405000000', '长洲区', '', 3, '广西壮族自治区', '梧州市', '长洲区', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2664', 'cn', '450406000000', '龙圩区', '', 3, '广西壮族自治区', '梧州市', '龙圩区', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2665', 'cn', '450421000000', '苍梧县', '', 3, '广西壮族自治区', '梧州市', '苍梧县', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2666', 'cn', '450422000000', '藤县', '', 3, '广西壮族自治区', '梧州市', '藤县', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2667', 'cn', '450423000000', '蒙山县', '', 3, '广西壮族自治区', '梧州市', '蒙山县', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2668', 'cn', '450481000000', '岑溪市', '', 3, '广西壮族自治区', '梧州市', '岑溪市', 0, 1, '450400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2669', 'cn', '450501000000', '市辖区', '', 3, '广西壮族自治区', '北海市', '市辖区', 0, 1, '450500000000');
INSERT INTO SYS_NATION_AREA VALUES ('267', 'cn', '469000000000', '省直辖县级行政区划', '', 2, '海南省', '省直辖县级行政区划', '', 0, 1, '460000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2670', 'cn', '450502000000', '海城区', '', 3, '广西壮族自治区', '北海市', '海城区', 0, 1, '450500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2671', 'cn', '450503000000', '银海区', '', 3, '广西壮族自治区', '北海市', '银海区', 0, 1, '450500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2672', 'cn', '450512000000', '铁山港区', '', 3, '广西壮族自治区', '北海市', '铁山港区', 0, 1, '450500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2673', 'cn', '450521000000', '合浦县', '', 3, '广西壮族自治区', '北海市', '合浦县', 0, 1, '450500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2674', 'cn', '450601000000', '市辖区', '', 3, '广西壮族自治区', '防城港市', '市辖区', 0, 1, '450600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2675', 'cn', '450602000000', '港口区', '', 3, '广西壮族自治区', '防城港市', '港口区', 0, 1, '450600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2676', 'cn', '450603000000', '防城区', '', 3, '广西壮族自治区', '防城港市', '防城区', 0, 1, '450600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2677', 'cn', '450621000000', '上思县', '', 3, '广西壮族自治区', '防城港市', '上思县', 0, 1, '450600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2678', 'cn', '450681000000', '东兴市', '', 3, '广西壮族自治区', '防城港市', '东兴市', 0, 1, '450600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2679', 'cn', '450701000000', '市辖区', '', 3, '广西壮族自治区', '钦州市', '市辖区', 0, 1, '450700000000');
INSERT INTO SYS_NATION_AREA VALUES ('268', 'cn', '500100000000', '市辖区', '', 2, '重庆市', '市辖区', '', 0, 1, '500000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2680', 'cn', '450702000000', '钦南区', '', 3, '广西壮族自治区', '钦州市', '钦南区', 0, 1, '450700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2681', 'cn', '450703000000', '钦北区', '', 3, '广西壮族自治区', '钦州市', '钦北区', 0, 1, '450700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2682', 'cn', '450721000000', '灵山县', '', 3, '广西壮族自治区', '钦州市', '灵山县', 0, 1, '450700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2683', 'cn', '450722000000', '浦北县', '', 3, '广西壮族自治区', '钦州市', '浦北县', 0, 1, '450700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2684', 'cn', '450801000000', '市辖区', '', 3, '广西壮族自治区', '贵港市', '市辖区', 0, 1, '450800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2685', 'cn', '450802000000', '港北区', '', 3, '广西壮族自治区', '贵港市', '港北区', 0, 1, '450800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2686', 'cn', '450803000000', '港南区', '', 3, '广西壮族自治区', '贵港市', '港南区', 0, 1, '450800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2687', 'cn', '450804000000', '覃塘区', '', 3, '广西壮族自治区', '贵港市', '覃塘区', 0, 1, '450800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2688', 'cn', '450821000000', '平南县', '', 3, '广西壮族自治区', '贵港市', '平南县', 0, 1, '450800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2689', 'cn', '450881000000', '桂平市', '', 3, '广西壮族自治区', '贵港市', '桂平市', 0, 1, '450800000000');
INSERT INTO SYS_NATION_AREA VALUES ('269', 'cn', '500200000000', '县', '', 2, '重庆市', '县', '', 0, 1, '500000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2690', 'cn', '450901000000', '市辖区', '', 3, '广西壮族自治区', '玉林市', '市辖区', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2691', 'cn', '450902000000', '玉州区', '', 3, '广西壮族自治区', '玉林市', '玉州区', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2692', 'cn', '450903000000', '福绵区', '', 3, '广西壮族自治区', '玉林市', '福绵区', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2693', 'cn', '450921000000', '容县', '', 3, '广西壮族自治区', '玉林市', '容县', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2694', 'cn', '450922000000', '陆川县', '', 3, '广西壮族自治区', '玉林市', '陆川县', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2695', 'cn', '450923000000', '博白县', '', 3, '广西壮族自治区', '玉林市', '博白县', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2696', 'cn', '450924000000', '兴业县', '', 3, '广西壮族自治区', '玉林市', '兴业县', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2697', 'cn', '450981000000', '北流市', '', 3, '广西壮族自治区', '玉林市', '北流市', 0, 1, '450900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2698', 'cn', '451001000000', '市辖区', '', 3, '广西壮族自治区', '百色市', '市辖区', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2699', 'cn', '451002000000', '右江区', '', 3, '广西壮族自治区', '百色市', '右江区', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('27', 'cn', '610000000000', '陕西省', '', 1, '陕西省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('270', 'cn', '510100000000', '成都市', '', 2, '四川省', '成都市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2700', 'cn', '451021000000', '田阳县', '', 3, '广西壮族自治区', '百色市', '田阳县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2701', 'cn', '451022000000', '田东县', '', 3, '广西壮族自治区', '百色市', '田东县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2702', 'cn', '451023000000', '平果县', '', 3, '广西壮族自治区', '百色市', '平果县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2703', 'cn', '451024000000', '德保县', '', 3, '广西壮族自治区', '百色市', '德保县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2704', 'cn', '451026000000', '那坡县', '', 3, '广西壮族自治区', '百色市', '那坡县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2705', 'cn', '451027000000', '凌云县', '', 3, '广西壮族自治区', '百色市', '凌云县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2706', 'cn', '451028000000', '乐业县', '', 3, '广西壮族自治区', '百色市', '乐业县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2707', 'cn', '451029000000', '田林县', '', 3, '广西壮族自治区', '百色市', '田林县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2708', 'cn', '451030000000', '西林县', '', 3, '广西壮族自治区', '百色市', '西林县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2709', 'cn', '451031000000', '隆林各族自治县', '', 3, '广西壮族自治区', '百色市', '隆林各族自治县', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('271', 'cn', '510300000000', '自贡市', '', 2, '四川省', '自贡市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2710', 'cn', '451081000000', '靖西市', '', 3, '广西壮族自治区', '百色市', '靖西市', 0, 1, '451000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2711', 'cn', '451101000000', '市辖区', '', 3, '广西壮族自治区', '贺州市', '市辖区', 0, 1, '451100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2712', 'cn', '451102000000', '八步区', '', 3, '广西壮族自治区', '贺州市', '八步区', 0, 1, '451100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2713', 'cn', '451103000000', '平桂区', '', 3, '广西壮族自治区', '贺州市', '平桂区', 0, 1, '451100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2714', 'cn', '451121000000', '昭平县', '', 3, '广西壮族自治区', '贺州市', '昭平县', 0, 1, '451100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2715', 'cn', '451122000000', '钟山县', '', 3, '广西壮族自治区', '贺州市', '钟山县', 0, 1, '451100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2716', 'cn', '451123000000', '富川瑶族自治县', '', 3, '广西壮族自治区', '贺州市', '富川瑶族自治县', 0, 1, '451100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2717', 'cn', '451201000000', '市辖区', '', 3, '广西壮族自治区', '河池市', '市辖区', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2718', 'cn', '451202000000', '金城江区', '', 3, '广西壮族自治区', '河池市', '金城江区', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2719', 'cn', '451203000000', '宜州区', '', 3, '广西壮族自治区', '河池市', '宜州区', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('272', 'cn', '510400000000', '攀枝花市', '', 2, '四川省', '攀枝花市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2720', 'cn', '451221000000', '南丹县', '', 3, '广西壮族自治区', '河池市', '南丹县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2721', 'cn', '451222000000', '天峨县', '', 3, '广西壮族自治区', '河池市', '天峨县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2722', 'cn', '451223000000', '凤山县', '', 3, '广西壮族自治区', '河池市', '凤山县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2723', 'cn', '451224000000', '东兰县', '', 3, '广西壮族自治区', '河池市', '东兰县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2724', 'cn', '451225000000', '罗城仫佬族自治县', '', 3, '广西壮族自治区', '河池市', '罗城仫佬族自治县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2725', 'cn', '451226000000', '环江毛南族自治县', '', 3, '广西壮族自治区', '河池市', '环江毛南族自治县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2726', 'cn', '451227000000', '巴马瑶族自治县', '', 3, '广西壮族自治区', '河池市', '巴马瑶族自治县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2727', 'cn', '451228000000', '都安瑶族自治县', '', 3, '广西壮族自治区', '河池市', '都安瑶族自治县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2728', 'cn', '451229000000', '大化瑶族自治县', '', 3, '广西壮族自治区', '河池市', '大化瑶族自治县', 0, 1, '451200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2729', 'cn', '451301000000', '市辖区', '', 3, '广西壮族自治区', '来宾市', '市辖区', 0, 1, '451300000000');
INSERT INTO SYS_NATION_AREA VALUES ('273', 'cn', '510500000000', '泸州市', '', 2, '四川省', '泸州市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2730', 'cn', '451302000000', '兴宾区', '', 3, '广西壮族自治区', '来宾市', '兴宾区', 0, 1, '451300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2731', 'cn', '451321000000', '忻城县', '', 3, '广西壮族自治区', '来宾市', '忻城县', 0, 1, '451300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2732', 'cn', '451322000000', '象州县', '', 3, '广西壮族自治区', '来宾市', '象州县', 0, 1, '451300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2733', 'cn', '451323000000', '武宣县', '', 3, '广西壮族自治区', '来宾市', '武宣县', 0, 1, '451300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2734', 'cn', '451324000000', '金秀瑶族自治县', '', 3, '广西壮族自治区', '来宾市', '金秀瑶族自治县', 0, 1, '451300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2735', 'cn', '451381000000', '合山市', '', 3, '广西壮族自治区', '来宾市', '合山市', 0, 1, '451300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2736', 'cn', '451401000000', '市辖区', '', 3, '广西壮族自治区', '崇左市', '市辖区', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2737', 'cn', '451402000000', '江州区', '', 3, '广西壮族自治区', '崇左市', '江州区', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2738', 'cn', '451421000000', '扶绥县', '', 3, '广西壮族自治区', '崇左市', '扶绥县', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2739', 'cn', '451422000000', '宁明县', '', 3, '广西壮族自治区', '崇左市', '宁明县', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('274', 'cn', '510600000000', '德阳市', '', 2, '四川省', '德阳市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2740', 'cn', '451423000000', '龙州县', '', 3, '广西壮族自治区', '崇左市', '龙州县', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2741', 'cn', '451424000000', '大新县', '', 3, '广西壮族自治区', '崇左市', '大新县', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2742', 'cn', '451425000000', '天等县', '', 3, '广西壮族自治区', '崇左市', '天等县', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2743', 'cn', '451481000000', '凭祥市', '', 3, '广西壮族自治区', '崇左市', '凭祥市', 0, 1, '451400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2744', 'cn', '460101000000', '市辖区', '', 3, '海南省', '海口市', '市辖区', 0, 1, '460100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2745', 'cn', '460105000000', '秀英区', '', 3, '海南省', '海口市', '秀英区', 0, 1, '460100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2746', 'cn', '460106000000', '龙华区', '', 3, '海南省', '海口市', '龙华区', 0, 1, '460100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2747', 'cn', '460107000000', '琼山区', '', 3, '海南省', '海口市', '琼山区', 0, 1, '460100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2748', 'cn', '460108000000', '美兰区', '', 3, '海南省', '海口市', '美兰区', 0, 1, '460100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2749', 'cn', '460201000000', '市辖区', '', 3, '海南省', '三亚市', '市辖区', 0, 1, '460200000000');
INSERT INTO SYS_NATION_AREA VALUES ('275', 'cn', '510700000000', '绵阳市', '', 2, '四川省', '绵阳市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2750', 'cn', '460202000000', '海棠区', '', 3, '海南省', '三亚市', '海棠区', 0, 1, '460200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2751', 'cn', '460203000000', '吉阳区', '', 3, '海南省', '三亚市', '吉阳区', 0, 1, '460200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2752', 'cn', '460204000000', '天涯区', '', 3, '海南省', '三亚市', '天涯区', 0, 1, '460200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2753', 'cn', '460205000000', '崖州区', '', 3, '海南省', '三亚市', '崖州区', 0, 1, '460200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2754', 'cn', '460321000000', '西沙群岛', '', 3, '海南省', '三沙市', '西沙群岛', 0, 1, '460300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2755', 'cn', '460322000000', '南沙群岛', '', 3, '海南省', '三沙市', '南沙群岛', 0, 1, '460300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2756', 'cn', '460323000000', '中沙群岛的岛礁及其海域', '', 3, '海南省', '三沙市', '中沙群岛的岛礁及其海域', 0, 1, '460300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2757', 'cn', '460400100000', '那大镇', '', 3, '海南省', '儋州市', '那大镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2758', 'cn', '460400101000', '和庆镇', '', 3, '海南省', '儋州市', '和庆镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2759', 'cn', '460400102000', '南丰镇', '', 3, '海南省', '儋州市', '南丰镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('276', 'cn', '510800000000', '广元市', '', 2, '四川省', '广元市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2760', 'cn', '460400103000', '大成镇', '', 3, '海南省', '儋州市', '大成镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2761', 'cn', '460400104000', '雅星镇', '', 3, '海南省', '儋州市', '雅星镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2762', 'cn', '460400105000', '兰洋镇', '', 3, '海南省', '儋州市', '兰洋镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2763', 'cn', '460400106000', '光村镇', '', 3, '海南省', '儋州市', '光村镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2764', 'cn', '460400107000', '木棠镇', '', 3, '海南省', '儋州市', '木棠镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2765', 'cn', '460400108000', '海头镇', '', 3, '海南省', '儋州市', '海头镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2766', 'cn', '460400109000', '峨蔓镇', '', 3, '海南省', '儋州市', '峨蔓镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2767', 'cn', '460400111000', '王五镇', '', 3, '海南省', '儋州市', '王五镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2768', 'cn', '460400112000', '白马井镇', '', 3, '海南省', '儋州市', '白马井镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2769', 'cn', '460400113000', '中和镇', '', 3, '海南省', '儋州市', '中和镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('277', 'cn', '510900000000', '遂宁市', '', 2, '四川省', '遂宁市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2770', 'cn', '460400114000', '排浦镇', '', 3, '海南省', '儋州市', '排浦镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2771', 'cn', '460400115000', '东成镇', '', 3, '海南省', '儋州市', '东成镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2772', 'cn', '460400116000', '新州镇', '', 3, '海南省', '儋州市', '新州镇', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2773', 'cn', '460400499000', '洋浦经济开发区', '', 3, '海南省', '儋州市', '洋浦经济开发区', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2774', 'cn', '460400500000', '华南热作学院', '', 3, '海南省', '儋州市', '华南热作学院', 0, 1, '460400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2775', 'cn', '469001000000', '五指山市', '', 3, '海南省', '省直辖县级行政区划', '五指山市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2776', 'cn', '469002000000', '琼海市', '', 3, '海南省', '省直辖县级行政区划', '琼海市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2777', 'cn', '469005000000', '文昌市', '', 3, '海南省', '省直辖县级行政区划', '文昌市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2778', 'cn', '469006000000', '万宁市', '', 3, '海南省', '省直辖县级行政区划', '万宁市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2779', 'cn', '469007000000', '东方市', '', 3, '海南省', '省直辖县级行政区划', '东方市', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('278', 'cn', '511000000000', '内江市', '', 2, '四川省', '内江市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2780', 'cn', '469021000000', '定安县', '', 3, '海南省', '省直辖县级行政区划', '定安县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2781', 'cn', '469022000000', '屯昌县', '', 3, '海南省', '省直辖县级行政区划', '屯昌县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2782', 'cn', '469023000000', '澄迈县', '', 3, '海南省', '省直辖县级行政区划', '澄迈县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2783', 'cn', '469024000000', '临高县', '', 3, '海南省', '省直辖县级行政区划', '临高县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2784', 'cn', '469025000000', '白沙黎族自治县', '', 3, '海南省', '省直辖县级行政区划', '白沙黎族自治县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2785', 'cn', '469026000000', '昌江黎族自治县', '', 3, '海南省', '省直辖县级行政区划', '昌江黎族自治县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2786', 'cn', '469027000000', '乐东黎族自治县', '', 3, '海南省', '省直辖县级行政区划', '乐东黎族自治县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2787', 'cn', '469028000000', '陵水黎族自治县', '', 3, '海南省', '省直辖县级行政区划', '陵水黎族自治县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2788', 'cn', '469029000000', '保亭黎族苗族自治县', '', 3, '海南省', '省直辖县级行政区划', '保亭黎族苗族自治县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2789', 'cn', '469030000000', '琼中黎族苗族自治县', '', 3, '海南省', '省直辖县级行政区划', '琼中黎族苗族自治县', 0, 1, '419000000000');
INSERT INTO SYS_NATION_AREA VALUES ('279', 'cn', '511100000000', '乐山市', '', 2, '四川省', '乐山市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2790', 'cn', '500101000000', '万州区', '', 3, '重庆市', '市辖区', '万州区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2791', 'cn', '500102000000', '涪陵区', '', 3, '重庆市', '市辖区', '涪陵区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2792', 'cn', '500103000000', '渝中区', '', 3, '重庆市', '市辖区', '渝中区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2793', 'cn', '500104000000', '大渡口区', '', 3, '重庆市', '市辖区', '大渡口区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2794', 'cn', '500105000000', '江北区', '', 3, '重庆市', '市辖区', '江北区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2795', 'cn', '500106000000', '沙坪坝区', '', 3, '重庆市', '市辖区', '沙坪坝区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2796', 'cn', '500107000000', '九龙坡区', '', 3, '重庆市', '市辖区', '九龙坡区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2797', 'cn', '500108000000', '南岸区', '', 3, '重庆市', '市辖区', '南岸区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2798', 'cn', '500109000000', '北碚区', '', 3, '重庆市', '市辖区', '北碚区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2799', 'cn', '500110000000', '綦江区', '', 3, '重庆市', '市辖区', '綦江区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('28', 'cn', '620000000000', '甘肃省', '', 1, '甘肃省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('280', 'cn', '511300000000', '南充市', '', 2, '四川省', '南充市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2800', 'cn', '500111000000', '大足区', '', 3, '重庆市', '市辖区', '大足区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2801', 'cn', '500112000000', '渝北区', '', 3, '重庆市', '市辖区', '渝北区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2802', 'cn', '500113000000', '巴南区', '', 3, '重庆市', '市辖区', '巴南区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2803', 'cn', '500114000000', '黔江区', '', 3, '重庆市', '市辖区', '黔江区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2804', 'cn', '500115000000', '长寿区', '', 3, '重庆市', '市辖区', '长寿区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2805', 'cn', '500116000000', '江津区', '', 3, '重庆市', '市辖区', '江津区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2806', 'cn', '500117000000', '合川区', '', 3, '重庆市', '市辖区', '合川区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2807', 'cn', '500118000000', '永川区', '', 3, '重庆市', '市辖区', '永川区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2808', 'cn', '500119000000', '南川区', '', 3, '重庆市', '市辖区', '南川区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2809', 'cn', '500120000000', '璧山区', '', 3, '重庆市', '市辖区', '璧山区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('281', 'cn', '511400000000', '眉山市', '', 2, '四川省', '眉山市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2810', 'cn', '500151000000', '铜梁区', '', 3, '重庆市', '市辖区', '铜梁区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2811', 'cn', '500152000000', '潼南区', '', 3, '重庆市', '市辖区', '潼南区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2812', 'cn', '500153000000', '荣昌区', '', 3, '重庆市', '市辖区', '荣昌区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2813', 'cn', '500154000000', '开州区', '', 3, '重庆市', '市辖区', '开州区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2814', 'cn', '500155000000', '梁平区', '', 3, '重庆市', '市辖区', '梁平区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2815', 'cn', '500156000000', '武隆区', '', 3, '重庆市', '市辖区', '武隆区', 0, 1, '500100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2816', 'cn', '500229000000', '城口县', '', 3, '重庆市', '县', '城口县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2817', 'cn', '500230000000', '丰都县', '', 3, '重庆市', '县', '丰都县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2818', 'cn', '500231000000', '垫江县', '', 3, '重庆市', '县', '垫江县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2819', 'cn', '500233000000', '忠县', '', 3, '重庆市', '县', '忠县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('282', 'cn', '511500000000', '宜宾市', '', 2, '四川省', '宜宾市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2820', 'cn', '500235000000', '云阳县', '', 3, '重庆市', '县', '云阳县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2821', 'cn', '500236000000', '奉节县', '', 3, '重庆市', '县', '奉节县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2822', 'cn', '500237000000', '巫山县', '', 3, '重庆市', '县', '巫山县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2823', 'cn', '500238000000', '巫溪县', '', 3, '重庆市', '县', '巫溪县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2824', 'cn', '500240000000', '石柱土家族自治县', '', 3, '重庆市', '县', '石柱土家族自治县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2825', 'cn', '500241000000', '秀山土家族苗族自治县', '', 3, '重庆市', '县', '秀山土家族苗族自治县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2826', 'cn', '500242000000', '酉阳土家族苗族自治县', '', 3, '重庆市', '县', '酉阳土家族苗族自治县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2827', 'cn', '500243000000', '彭水苗族土家族自治县', '', 3, '重庆市', '县', '彭水苗族土家族自治县', 0, 1, '500200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2828', 'cn', '510101000000', '市辖区', '', 3, '四川省', '成都市', '市辖区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2829', 'cn', '510104000000', '锦江区', '', 3, '四川省', '成都市', '锦江区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('283', 'cn', '511600000000', '广安市', '', 2, '四川省', '广安市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2830', 'cn', '510105000000', '青羊区', '', 3, '四川省', '成都市', '青羊区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2831', 'cn', '510106000000', '金牛区', '', 3, '四川省', '成都市', '金牛区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2832', 'cn', '510107000000', '武侯区', '', 3, '四川省', '成都市', '武侯区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2833', 'cn', '510108000000', '成华区', '', 3, '四川省', '成都市', '成华区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2834', 'cn', '510112000000', '龙泉驿区', '', 3, '四川省', '成都市', '龙泉驿区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2835', 'cn', '510113000000', '青白江区', '', 3, '四川省', '成都市', '青白江区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2836', 'cn', '510114000000', '新都区', '', 3, '四川省', '成都市', '新都区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2837', 'cn', '510115000000', '温江区', '', 3, '四川省', '成都市', '温江区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2838', 'cn', '510116000000', '双流区', '', 3, '四川省', '成都市', '双流区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2839', 'cn', '510117000000', '郫都区', '', 3, '四川省', '成都市', '郫都区', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('284', 'cn', '511700000000', '达州市', '', 2, '四川省', '达州市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2840', 'cn', '510121000000', '金堂县', '', 3, '四川省', '成都市', '金堂县', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2841', 'cn', '510129000000', '大邑县', '', 3, '四川省', '成都市', '大邑县', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2842', 'cn', '510131000000', '蒲江县', '', 3, '四川省', '成都市', '蒲江县', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2843', 'cn', '510132000000', '新津县', '', 3, '四川省', '成都市', '新津县', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2844', 'cn', '510181000000', '都江堰市', '', 3, '四川省', '成都市', '都江堰市', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2845', 'cn', '510182000000', '彭州市', '', 3, '四川省', '成都市', '彭州市', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2846', 'cn', '510183000000', '邛崃市', '', 3, '四川省', '成都市', '邛崃市', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2847', 'cn', '510184000000', '崇州市', '', 3, '四川省', '成都市', '崇州市', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2848', 'cn', '510185000000', '简阳市', '', 3, '四川省', '成都市', '简阳市', 0, 1, '510100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2849', 'cn', '510301000000', '市辖区', '', 3, '四川省', '自贡市', '市辖区', 0, 1, '510300000000');
INSERT INTO SYS_NATION_AREA VALUES ('285', 'cn', '511800000000', '雅安市', '', 2, '四川省', '雅安市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2850', 'cn', '510302000000', '自流井区', '', 3, '四川省', '自贡市', '自流井区', 0, 1, '510300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2851', 'cn', '510303000000', '贡井区', '', 3, '四川省', '自贡市', '贡井区', 0, 1, '510300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2852', 'cn', '510304000000', '大安区', '', 3, '四川省', '自贡市', '大安区', 0, 1, '510300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2853', 'cn', '510311000000', '沿滩区', '', 3, '四川省', '自贡市', '沿滩区', 0, 1, '510300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2854', 'cn', '510321000000', '荣县', '', 3, '四川省', '自贡市', '荣县', 0, 1, '510300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2855', 'cn', '510322000000', '富顺县', '', 3, '四川省', '自贡市', '富顺县', 0, 1, '510300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2856', 'cn', '510401000000', '市辖区', '', 3, '四川省', '攀枝花市', '市辖区', 0, 1, '510400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2857', 'cn', '510402000000', '东区', '', 3, '四川省', '攀枝花市', '东区', 0, 1, '510400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2858', 'cn', '510403000000', '西区', '', 3, '四川省', '攀枝花市', '西区', 0, 1, '510400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2859', 'cn', '510411000000', '仁和区', '', 3, '四川省', '攀枝花市', '仁和区', 0, 1, '510400000000');
INSERT INTO SYS_NATION_AREA VALUES ('286', 'cn', '511900000000', '巴中市', '', 2, '四川省', '巴中市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2860', 'cn', '510421000000', '米易县', '', 3, '四川省', '攀枝花市', '米易县', 0, 1, '510400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2861', 'cn', '510422000000', '盐边县', '', 3, '四川省', '攀枝花市', '盐边县', 0, 1, '510400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2862', 'cn', '510501000000', '市辖区', '', 3, '四川省', '泸州市', '市辖区', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2863', 'cn', '510502000000', '江阳区', '', 3, '四川省', '泸州市', '江阳区', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2864', 'cn', '510503000000', '纳溪区', '', 3, '四川省', '泸州市', '纳溪区', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2865', 'cn', '510504000000', '龙马潭区', '', 3, '四川省', '泸州市', '龙马潭区', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2866', 'cn', '510521000000', '泸县', '', 3, '四川省', '泸州市', '泸县', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2867', 'cn', '510522000000', '合江县', '', 3, '四川省', '泸州市', '合江县', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2868', 'cn', '510524000000', '叙永县', '', 3, '四川省', '泸州市', '叙永县', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2869', 'cn', '510525000000', '古蔺县', '', 3, '四川省', '泸州市', '古蔺县', 0, 1, '510500000000');
INSERT INTO SYS_NATION_AREA VALUES ('287', 'cn', '512000000000', '资阳市', '', 2, '四川省', '资阳市', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2870', 'cn', '510601000000', '市辖区', '', 3, '四川省', '德阳市', '市辖区', 0, 1, '510600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2871', 'cn', '510603000000', '旌阳区', '', 3, '四川省', '德阳市', '旌阳区', 0, 1, '510600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2872', 'cn', '510604000000', '罗江区', '', 3, '四川省', '德阳市', '罗江区', 0, 1, '510600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2873', 'cn', '510623000000', '中江县', '', 3, '四川省', '德阳市', '中江县', 0, 1, '510600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2874', 'cn', '510681000000', '广汉市', '', 3, '四川省', '德阳市', '广汉市', 0, 1, '510600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2875', 'cn', '510682000000', '什邡市', '', 3, '四川省', '德阳市', '什邡市', 0, 1, '510600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2876', 'cn', '510683000000', '绵竹市', '', 3, '四川省', '德阳市', '绵竹市', 0, 1, '510600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2877', 'cn', '510701000000', '市辖区', '', 3, '四川省', '绵阳市', '市辖区', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2878', 'cn', '510703000000', '涪城区', '', 3, '四川省', '绵阳市', '涪城区', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2879', 'cn', '510704000000', '游仙区', '', 3, '四川省', '绵阳市', '游仙区', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('288', 'cn', '513200000000', '阿坝藏族羌族自治州', '', 2, '四川省', '阿坝藏族羌族自治州', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2880', 'cn', '510705000000', '安州区', '', 3, '四川省', '绵阳市', '安州区', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2881', 'cn', '510722000000', '三台县', '', 3, '四川省', '绵阳市', '三台县', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2882', 'cn', '510723000000', '盐亭县', '', 3, '四川省', '绵阳市', '盐亭县', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2883', 'cn', '510725000000', '梓潼县', '', 3, '四川省', '绵阳市', '梓潼县', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2884', 'cn', '510726000000', '北川羌族自治县', '', 3, '四川省', '绵阳市', '北川羌族自治县', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2885', 'cn', '510727000000', '平武县', '', 3, '四川省', '绵阳市', '平武县', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2886', 'cn', '510781000000', '江油市', '', 3, '四川省', '绵阳市', '江油市', 0, 1, '510700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2887', 'cn', '510801000000', '市辖区', '', 3, '四川省', '广元市', '市辖区', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2888', 'cn', '510802000000', '利州区', '', 3, '四川省', '广元市', '利州区', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2889', 'cn', '510811000000', '昭化区', '', 3, '四川省', '广元市', '昭化区', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('289', 'cn', '513300000000', '甘孜藏族自治州', '', 2, '四川省', '甘孜藏族自治州', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2890', 'cn', '510812000000', '朝天区', '', 3, '四川省', '广元市', '朝天区', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2891', 'cn', '510821000000', '旺苍县', '', 3, '四川省', '广元市', '旺苍县', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2892', 'cn', '510822000000', '青川县', '', 3, '四川省', '广元市', '青川县', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2893', 'cn', '510823000000', '剑阁县', '', 3, '四川省', '广元市', '剑阁县', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2894', 'cn', '510824000000', '苍溪县', '', 3, '四川省', '广元市', '苍溪县', 0, 1, '510800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2895', 'cn', '510901000000', '市辖区', '', 3, '四川省', '遂宁市', '市辖区', 0, 1, '510900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2896', 'cn', '510903000000', '船山区', '', 3, '四川省', '遂宁市', '船山区', 0, 1, '510900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2897', 'cn', '510904000000', '安居区', '', 3, '四川省', '遂宁市', '安居区', 0, 1, '510900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2898', 'cn', '510921000000', '蓬溪县', '', 3, '四川省', '遂宁市', '蓬溪县', 0, 1, '510900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2899', 'cn', '510922000000', '射洪县', '', 3, '四川省', '遂宁市', '射洪县', 0, 1, '510900000000');
INSERT INTO SYS_NATION_AREA VALUES ('29', 'cn', '630000000000', '青海省', '', 1, '青海省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('290', 'cn', '513400000000', '凉山彝族自治州', '', 2, '四川省', '凉山彝族自治州', '', 0, 1, '510000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2900', 'cn', '510923000000', '大英县', '', 3, '四川省', '遂宁市', '大英县', 0, 1, '510900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2901', 'cn', '511001000000', '市辖区', '', 3, '四川省', '内江市', '市辖区', 0, 1, '511000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2902', 'cn', '511002000000', '市中区', '', 3, '四川省', '内江市', '市中区', 0, 1, '511000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2903', 'cn', '511011000000', '东兴区', '', 3, '四川省', '内江市', '东兴区', 0, 1, '511000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2904', 'cn', '511024000000', '威远县', '', 3, '四川省', '内江市', '威远县', 0, 1, '511000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2905', 'cn', '511025000000', '资中县', '', 3, '四川省', '内江市', '资中县', 0, 1, '511000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2906', 'cn', '511071000000', '内江经济开发区', '', 3, '四川省', '内江市', '内江经济开发区', 0, 1, '511000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2907', 'cn', '511083000000', '隆昌市', '', 3, '四川省', '内江市', '隆昌市', 0, 1, '511000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2908', 'cn', '511101000000', '市辖区', '', 3, '四川省', '乐山市', '市辖区', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2909', 'cn', '511102000000', '市中区', '', 3, '四川省', '乐山市', '市中区', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('291', 'cn', '520100000000', '贵阳市', '', 2, '贵州省', '贵阳市', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2910', 'cn', '511111000000', '沙湾区', '', 3, '四川省', '乐山市', '沙湾区', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2911', 'cn', '511112000000', '五通桥区', '', 3, '四川省', '乐山市', '五通桥区', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2912', 'cn', '511113000000', '金口河区', '', 3, '四川省', '乐山市', '金口河区', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2913', 'cn', '511123000000', '犍为县', '', 3, '四川省', '乐山市', '犍为县', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2914', 'cn', '511124000000', '井研县', '', 3, '四川省', '乐山市', '井研县', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2915', 'cn', '511126000000', '夹江县', '', 3, '四川省', '乐山市', '夹江县', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2916', 'cn', '511129000000', '沐川县', '', 3, '四川省', '乐山市', '沐川县', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2917', 'cn', '511132000000', '峨边彝族自治县', '', 3, '四川省', '乐山市', '峨边彝族自治县', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2918', 'cn', '511133000000', '马边彝族自治县', '', 3, '四川省', '乐山市', '马边彝族自治县', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('2919', 'cn', '511181000000', '峨眉山市', '', 3, '四川省', '乐山市', '峨眉山市', 0, 1, '511100000000');
INSERT INTO SYS_NATION_AREA VALUES ('292', 'cn', '520200000000', '六盘水市', '', 2, '贵州省', '六盘水市', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2920', 'cn', '511301000000', '市辖区', '', 3, '四川省', '南充市', '市辖区', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2921', 'cn', '511302000000', '顺庆区', '', 3, '四川省', '南充市', '顺庆区', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2922', 'cn', '511303000000', '高坪区', '', 3, '四川省', '南充市', '高坪区', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2923', 'cn', '511304000000', '嘉陵区', '', 3, '四川省', '南充市', '嘉陵区', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2924', 'cn', '511321000000', '南部县', '', 3, '四川省', '南充市', '南部县', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2925', 'cn', '511322000000', '营山县', '', 3, '四川省', '南充市', '营山县', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2926', 'cn', '511323000000', '蓬安县', '', 3, '四川省', '南充市', '蓬安县', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2927', 'cn', '511324000000', '仪陇县', '', 3, '四川省', '南充市', '仪陇县', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2928', 'cn', '511325000000', '西充县', '', 3, '四川省', '南充市', '西充县', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2929', 'cn', '511381000000', '阆中市', '', 3, '四川省', '南充市', '阆中市', 0, 1, '511300000000');
INSERT INTO SYS_NATION_AREA VALUES ('293', 'cn', '520300000000', '遵义市', '', 2, '贵州省', '遵义市', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2930', 'cn', '511401000000', '市辖区', '', 3, '四川省', '眉山市', '市辖区', 0, 1, '511400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2931', 'cn', '511402000000', '东坡区', '', 3, '四川省', '眉山市', '东坡区', 0, 1, '511400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2932', 'cn', '511403000000', '彭山区', '', 3, '四川省', '眉山市', '彭山区', 0, 1, '511400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2933', 'cn', '511421000000', '仁寿县', '', 3, '四川省', '眉山市', '仁寿县', 0, 1, '511400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2934', 'cn', '511423000000', '洪雅县', '', 3, '四川省', '眉山市', '洪雅县', 0, 1, '511400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2935', 'cn', '511424000000', '丹棱县', '', 3, '四川省', '眉山市', '丹棱县', 0, 1, '511400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2936', 'cn', '511425000000', '青神县', '', 3, '四川省', '眉山市', '青神县', 0, 1, '511400000000');
INSERT INTO SYS_NATION_AREA VALUES ('2937', 'cn', '511501000000', '市辖区', '', 3, '四川省', '宜宾市', '市辖区', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2938', 'cn', '511502000000', '翠屏区', '', 3, '四川省', '宜宾市', '翠屏区', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2939', 'cn', '511503000000', '南溪区', '', 3, '四川省', '宜宾市', '南溪区', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('294', 'cn', '520400000000', '安顺市', '', 2, '贵州省', '安顺市', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2940', 'cn', '511521000000', '宜宾县', '', 3, '四川省', '宜宾市', '宜宾县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2941', 'cn', '511523000000', '江安县', '', 3, '四川省', '宜宾市', '江安县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2942', 'cn', '511524000000', '长宁县', '', 3, '四川省', '宜宾市', '长宁县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2943', 'cn', '511525000000', '高县', '', 3, '四川省', '宜宾市', '高县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2944', 'cn', '511526000000', '珙县', '', 3, '四川省', '宜宾市', '珙县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2945', 'cn', '511527000000', '筠连县', '', 3, '四川省', '宜宾市', '筠连县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2946', 'cn', '511528000000', '兴文县', '', 3, '四川省', '宜宾市', '兴文县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2947', 'cn', '511529000000', '屏山县', '', 3, '四川省', '宜宾市', '屏山县', 0, 1, '511500000000');
INSERT INTO SYS_NATION_AREA VALUES ('2948', 'cn', '511601000000', '市辖区', '', 3, '四川省', '广安市', '市辖区', 0, 1, '511600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2949', 'cn', '511602000000', '广安区', '', 3, '四川省', '广安市', '广安区', 0, 1, '511600000000');
INSERT INTO SYS_NATION_AREA VALUES ('295', 'cn', '520500000000', '毕节市', '', 2, '贵州省', '毕节市', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2950', 'cn', '511603000000', '前锋区', '', 3, '四川省', '广安市', '前锋区', 0, 1, '511600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2951', 'cn', '511621000000', '岳池县', '', 3, '四川省', '广安市', '岳池县', 0, 1, '511600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2952', 'cn', '511622000000', '武胜县', '', 3, '四川省', '广安市', '武胜县', 0, 1, '511600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2953', 'cn', '511623000000', '邻水县', '', 3, '四川省', '广安市', '邻水县', 0, 1, '511600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2954', 'cn', '511681000000', '华蓥市', '', 3, '四川省', '广安市', '华蓥市', 0, 1, '511600000000');
INSERT INTO SYS_NATION_AREA VALUES ('2955', 'cn', '511701000000', '市辖区', '', 3, '四川省', '达州市', '市辖区', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2956', 'cn', '511702000000', '通川区', '', 3, '四川省', '达州市', '通川区', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2957', 'cn', '511703000000', '达川区', '', 3, '四川省', '达州市', '达川区', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2958', 'cn', '511722000000', '宣汉县', '', 3, '四川省', '达州市', '宣汉县', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2959', 'cn', '511723000000', '开江县', '', 3, '四川省', '达州市', '开江县', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('296', 'cn', '520600000000', '铜仁市', '', 2, '贵州省', '铜仁市', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2960', 'cn', '511724000000', '大竹县', '', 3, '四川省', '达州市', '大竹县', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2961', 'cn', '511725000000', '渠县', '', 3, '四川省', '达州市', '渠县', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2962', 'cn', '511771000000', '达州经济开发区', '', 3, '四川省', '达州市', '达州经济开发区', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2963', 'cn', '511781000000', '万源市', '', 3, '四川省', '达州市', '万源市', 0, 1, '511700000000');
INSERT INTO SYS_NATION_AREA VALUES ('2964', 'cn', '511801000000', '市辖区', '', 3, '四川省', '雅安市', '市辖区', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2965', 'cn', '511802000000', '雨城区', '', 3, '四川省', '雅安市', '雨城区', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2966', 'cn', '511803000000', '名山区', '', 3, '四川省', '雅安市', '名山区', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2967', 'cn', '511822000000', '荥经县', '', 3, '四川省', '雅安市', '荥经县', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2968', 'cn', '511823000000', '汉源县', '', 3, '四川省', '雅安市', '汉源县', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2969', 'cn', '511824000000', '石棉县', '', 3, '四川省', '雅安市', '石棉县', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('297', 'cn', '522300000000', '黔西南布依族苗族自治州', '', 2, '贵州省', '黔西南布依族苗族自治州', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2970', 'cn', '511825000000', '天全县', '', 3, '四川省', '雅安市', '天全县', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2971', 'cn', '511826000000', '芦山县', '', 3, '四川省', '雅安市', '芦山县', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2972', 'cn', '511827000000', '宝兴县', '', 3, '四川省', '雅安市', '宝兴县', 0, 1, '511800000000');
INSERT INTO SYS_NATION_AREA VALUES ('2973', 'cn', '511901000000', '市辖区', '', 3, '四川省', '巴中市', '市辖区', 0, 1, '511900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2974', 'cn', '511902000000', '巴州区', '', 3, '四川省', '巴中市', '巴州区', 0, 1, '511900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2975', 'cn', '511903000000', '恩阳区', '', 3, '四川省', '巴中市', '恩阳区', 0, 1, '511900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2976', 'cn', '511921000000', '通江县', '', 3, '四川省', '巴中市', '通江县', 0, 1, '511900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2977', 'cn', '511922000000', '南江县', '', 3, '四川省', '巴中市', '南江县', 0, 1, '511900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2978', 'cn', '511923000000', '平昌县', '', 3, '四川省', '巴中市', '平昌县', 0, 1, '511900000000');
INSERT INTO SYS_NATION_AREA VALUES ('2979', 'cn', '511971000000', '巴中经济开发区', '', 3, '四川省', '巴中市', '巴中经济开发区', 0, 1, '511900000000');
INSERT INTO SYS_NATION_AREA VALUES ('298', 'cn', '522600000000', '黔东南苗族侗族自治州', '', 2, '贵州省', '黔东南苗族侗族自治州', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2980', 'cn', '512001000000', '市辖区', '', 3, '四川省', '资阳市', '市辖区', 0, 1, '512000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2981', 'cn', '512002000000', '雁江区', '', 3, '四川省', '资阳市', '雁江区', 0, 1, '512000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2982', 'cn', '512021000000', '安岳县', '', 3, '四川省', '资阳市', '安岳县', 0, 1, '512000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2983', 'cn', '512022000000', '乐至县', '', 3, '四川省', '资阳市', '乐至县', 0, 1, '512000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2984', 'cn', '513201000000', '马尔康市', '', 3, '四川省', '阿坝藏族羌族自治州', '马尔康市', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2985', 'cn', '513221000000', '汶川县', '', 3, '四川省', '阿坝藏族羌族自治州', '汶川县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2986', 'cn', '513222000000', '理县', '', 3, '四川省', '阿坝藏族羌族自治州', '理县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2987', 'cn', '513223000000', '茂县', '', 3, '四川省', '阿坝藏族羌族自治州', '茂县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2988', 'cn', '513224000000', '松潘县', '', 3, '四川省', '阿坝藏族羌族自治州', '松潘县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2989', 'cn', '513225000000', '九寨沟县', '', 3, '四川省', '阿坝藏族羌族自治州', '九寨沟县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('299', 'cn', '522700000000', '黔南布依族苗族自治州', '', 2, '贵州省', '黔南布依族苗族自治州', '', 0, 1, '520000000000');
INSERT INTO SYS_NATION_AREA VALUES ('2990', 'cn', '513226000000', '金川县', '', 3, '四川省', '阿坝藏族羌族自治州', '金川县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2991', 'cn', '513227000000', '小金县', '', 3, '四川省', '阿坝藏族羌族自治州', '小金县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2992', 'cn', '513228000000', '黑水县', '', 3, '四川省', '阿坝藏族羌族自治州', '黑水县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2993', 'cn', '513230000000', '壤塘县', '', 3, '四川省', '阿坝藏族羌族自治州', '壤塘县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2994', 'cn', '513231000000', '阿坝县', '', 3, '四川省', '阿坝藏族羌族自治州', '阿坝县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2995', 'cn', '513232000000', '若尔盖县', '', 3, '四川省', '阿坝藏族羌族自治州', '若尔盖县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2996', 'cn', '513233000000', '红原县', '', 3, '四川省', '阿坝藏族羌族自治州', '红原县', 0, 1, '513200000000');
INSERT INTO SYS_NATION_AREA VALUES ('2997', 'cn', '513301000000', '康定市', '', 3, '四川省', '甘孜藏族自治州', '康定市', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2998', 'cn', '513322000000', '泸定县', '', 3, '四川省', '甘孜藏族自治州', '泸定县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('2999', 'cn', '513323000000', '丹巴县', '', 3, '四川省', '甘孜藏族自治州', '丹巴县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3', 'cn', '130000000000', '河北省', '', 1, '河北省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('30', 'cn', '640000000000', '宁夏回族自治区', '', 1, '宁夏回族自治区', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('300', 'cn', '530100000000', '昆明市', '', 2, '云南省', '昆明市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3000', 'cn', '513324000000', '九龙县', '', 3, '四川省', '甘孜藏族自治州', '九龙县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3001', 'cn', '513325000000', '雅江县', '', 3, '四川省', '甘孜藏族自治州', '雅江县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3002', 'cn', '513326000000', '道孚县', '', 3, '四川省', '甘孜藏族自治州', '道孚县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3003', 'cn', '513327000000', '炉霍县', '', 3, '四川省', '甘孜藏族自治州', '炉霍县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3004', 'cn', '513328000000', '甘孜县', '', 3, '四川省', '甘孜藏族自治州', '甘孜县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3005', 'cn', '513329000000', '新龙县', '', 3, '四川省', '甘孜藏族自治州', '新龙县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3006', 'cn', '513330000000', '德格县', '', 3, '四川省', '甘孜藏族自治州', '德格县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3007', 'cn', '513331000000', '白玉县', '', 3, '四川省', '甘孜藏族自治州', '白玉县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3008', 'cn', '513332000000', '石渠县', '', 3, '四川省', '甘孜藏族自治州', '石渠县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3009', 'cn', '513333000000', '色达县', '', 3, '四川省', '甘孜藏族自治州', '色达县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('301', 'cn', '530300000000', '曲靖市', '', 2, '云南省', '曲靖市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3010', 'cn', '513334000000', '理塘县', '', 3, '四川省', '甘孜藏族自治州', '理塘县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3011', 'cn', '513335000000', '巴塘县', '', 3, '四川省', '甘孜藏族自治州', '巴塘县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3012', 'cn', '513336000000', '乡城县', '', 3, '四川省', '甘孜藏族自治州', '乡城县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3013', 'cn', '513337000000', '稻城县', '', 3, '四川省', '甘孜藏族自治州', '稻城县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3014', 'cn', '513338000000', '得荣县', '', 3, '四川省', '甘孜藏族自治州', '得荣县', 0, 1, '513300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3015', 'cn', '513401000000', '西昌市', '', 3, '四川省', '凉山彝族自治州', '西昌市', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3016', 'cn', '513422000000', '木里藏族自治县', '', 3, '四川省', '凉山彝族自治州', '木里藏族自治县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3017', 'cn', '513423000000', '盐源县', '', 3, '四川省', '凉山彝族自治州', '盐源县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3018', 'cn', '513424000000', '德昌县', '', 3, '四川省', '凉山彝族自治州', '德昌县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3019', 'cn', '513425000000', '会理县', '', 3, '四川省', '凉山彝族自治州', '会理县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('302', 'cn', '530400000000', '玉溪市', '', 2, '云南省', '玉溪市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3020', 'cn', '513426000000', '会东县', '', 3, '四川省', '凉山彝族自治州', '会东县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3021', 'cn', '513427000000', '宁南县', '', 3, '四川省', '凉山彝族自治州', '宁南县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3022', 'cn', '513428000000', '普格县', '', 3, '四川省', '凉山彝族自治州', '普格县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3023', 'cn', '513429000000', '布拖县', '', 3, '四川省', '凉山彝族自治州', '布拖县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3024', 'cn', '513430000000', '金阳县', '', 3, '四川省', '凉山彝族自治州', '金阳县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3025', 'cn', '513431000000', '昭觉县', '', 3, '四川省', '凉山彝族自治州', '昭觉县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3026', 'cn', '513432000000', '喜德县', '', 3, '四川省', '凉山彝族自治州', '喜德县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3027', 'cn', '513433000000', '冕宁县', '', 3, '四川省', '凉山彝族自治州', '冕宁县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3028', 'cn', '513434000000', '越西县', '', 3, '四川省', '凉山彝族自治州', '越西县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3029', 'cn', '513435000000', '甘洛县', '', 3, '四川省', '凉山彝族自治州', '甘洛县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('303', 'cn', '530500000000', '保山市', '', 2, '云南省', '保山市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3030', 'cn', '513436000000', '美姑县', '', 3, '四川省', '凉山彝族自治州', '美姑县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3031', 'cn', '513437000000', '雷波县', '', 3, '四川省', '凉山彝族自治州', '雷波县', 0, 1, '513400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3032', 'cn', '520101000000', '市辖区', '', 3, '贵州省', '贵阳市', '市辖区', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3033', 'cn', '520102000000', '南明区', '', 3, '贵州省', '贵阳市', '南明区', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3034', 'cn', '520103000000', '云岩区', '', 3, '贵州省', '贵阳市', '云岩区', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3035', 'cn', '520111000000', '花溪区', '', 3, '贵州省', '贵阳市', '花溪区', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3036', 'cn', '520112000000', '乌当区', '', 3, '贵州省', '贵阳市', '乌当区', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3037', 'cn', '520113000000', '白云区', '', 3, '贵州省', '贵阳市', '白云区', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3038', 'cn', '520115000000', '观山湖区', '', 3, '贵州省', '贵阳市', '观山湖区', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3039', 'cn', '520121000000', '开阳县', '', 3, '贵州省', '贵阳市', '开阳县', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('304', 'cn', '530600000000', '昭通市', '', 2, '云南省', '昭通市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3040', 'cn', '520122000000', '息烽县', '', 3, '贵州省', '贵阳市', '息烽县', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3041', 'cn', '520123000000', '修文县', '', 3, '贵州省', '贵阳市', '修文县', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3042', 'cn', '520181000000', '清镇市', '', 3, '贵州省', '贵阳市', '清镇市', 0, 1, '520100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3043', 'cn', '520201000000', '钟山区', '', 3, '贵州省', '六盘水市', '钟山区', 0, 1, '520200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3044', 'cn', '520203000000', '六枝特区', '', 3, '贵州省', '六盘水市', '六枝特区', 0, 1, '520200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3045', 'cn', '520221000000', '水城县', '', 3, '贵州省', '六盘水市', '水城县', 0, 1, '520200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3046', 'cn', '520281000000', '盘州市', '', 3, '贵州省', '六盘水市', '盘州市', 0, 1, '520200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3047', 'cn', '520301000000', '市辖区', '', 3, '贵州省', '遵义市', '市辖区', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3048', 'cn', '520302000000', '红花岗区', '', 3, '贵州省', '遵义市', '红花岗区', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3049', 'cn', '520303000000', '汇川区', '', 3, '贵州省', '遵义市', '汇川区', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('305', 'cn', '530700000000', '丽江市', '', 2, '云南省', '丽江市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3050', 'cn', '520304000000', '播州区', '', 3, '贵州省', '遵义市', '播州区', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3051', 'cn', '520322000000', '桐梓县', '', 3, '贵州省', '遵义市', '桐梓县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3052', 'cn', '520323000000', '绥阳县', '', 3, '贵州省', '遵义市', '绥阳县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3053', 'cn', '520324000000', '正安县', '', 3, '贵州省', '遵义市', '正安县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3054', 'cn', '520325000000', '道真仡佬族苗族自治县', '', 3, '贵州省', '遵义市', '道真仡佬族苗族自治县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3055', 'cn', '520326000000', '务川仡佬族苗族自治县', '', 3, '贵州省', '遵义市', '务川仡佬族苗族自治县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3056', 'cn', '520327000000', '凤冈县', '', 3, '贵州省', '遵义市', '凤冈县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3057', 'cn', '520328000000', '湄潭县', '', 3, '贵州省', '遵义市', '湄潭县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3058', 'cn', '520329000000', '余庆县', '', 3, '贵州省', '遵义市', '余庆县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3059', 'cn', '520330000000', '习水县', '', 3, '贵州省', '遵义市', '习水县', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('306', 'cn', '530800000000', '普洱市', '', 2, '云南省', '普洱市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3060', 'cn', '520381000000', '赤水市', '', 3, '贵州省', '遵义市', '赤水市', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3061', 'cn', '520382000000', '仁怀市', '', 3, '贵州省', '遵义市', '仁怀市', 0, 1, '520300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3062', 'cn', '520401000000', '市辖区', '', 3, '贵州省', '安顺市', '市辖区', 0, 1, '520400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3063', 'cn', '520402000000', '西秀区', '', 3, '贵州省', '安顺市', '西秀区', 0, 1, '520400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3064', 'cn', '520403000000', '平坝区', '', 3, '贵州省', '安顺市', '平坝区', 0, 1, '520400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3065', 'cn', '520422000000', '普定县', '', 3, '贵州省', '安顺市', '普定县', 0, 1, '520400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3066', 'cn', '520423000000', '镇宁布依族苗族自治县', '', 3, '贵州省', '安顺市', '镇宁布依族苗族自治县', 0, 1, '520400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3067', 'cn', '520424000000', '关岭布依族苗族自治县', '', 3, '贵州省', '安顺市', '关岭布依族苗族自治县', 0, 1, '520400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3068', 'cn', '520425000000', '紫云苗族布依族自治县', '', 3, '贵州省', '安顺市', '紫云苗族布依族自治县', 0, 1, '520400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3069', 'cn', '520501000000', '市辖区', '', 3, '贵州省', '毕节市', '市辖区', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('307', 'cn', '530900000000', '临沧市', '', 2, '云南省', '临沧市', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3070', 'cn', '520502000000', '七星关区', '', 3, '贵州省', '毕节市', '七星关区', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3071', 'cn', '520521000000', '大方县', '', 3, '贵州省', '毕节市', '大方县', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3072', 'cn', '520522000000', '黔西县', '', 3, '贵州省', '毕节市', '黔西县', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3073', 'cn', '520523000000', '金沙县', '', 3, '贵州省', '毕节市', '金沙县', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3074', 'cn', '520524000000', '织金县', '', 3, '贵州省', '毕节市', '织金县', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3075', 'cn', '520525000000', '纳雍县', '', 3, '贵州省', '毕节市', '纳雍县', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3076', 'cn', '520526000000', '威宁彝族回族苗族自治县', '', 3, '贵州省', '毕节市', '威宁彝族回族苗族自治县', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3077', 'cn', '520527000000', '赫章县', '', 3, '贵州省', '毕节市', '赫章县', 0, 1, '520500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3078', 'cn', '520601000000', '市辖区', '', 3, '贵州省', '铜仁市', '市辖区', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3079', 'cn', '520602000000', '碧江区', '', 3, '贵州省', '铜仁市', '碧江区', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('308', 'cn', '532300000000', '楚雄彝族自治州', '', 2, '云南省', '楚雄彝族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3080', 'cn', '520603000000', '万山区', '', 3, '贵州省', '铜仁市', '万山区', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3081', 'cn', '520621000000', '江口县', '', 3, '贵州省', '铜仁市', '江口县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3082', 'cn', '520622000000', '玉屏侗族自治县', '', 3, '贵州省', '铜仁市', '玉屏侗族自治县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3083', 'cn', '520623000000', '石阡县', '', 3, '贵州省', '铜仁市', '石阡县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3084', 'cn', '520624000000', '思南县', '', 3, '贵州省', '铜仁市', '思南县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3085', 'cn', '520625000000', '印江土家族苗族自治县', '', 3, '贵州省', '铜仁市', '印江土家族苗族自治县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3086', 'cn', '520626000000', '德江县', '', 3, '贵州省', '铜仁市', '德江县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3087', 'cn', '520627000000', '沿河土家族自治县', '', 3, '贵州省', '铜仁市', '沿河土家族自治县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3088', 'cn', '520628000000', '松桃苗族自治县', '', 3, '贵州省', '铜仁市', '松桃苗族自治县', 0, 1, '520600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3089', 'cn', '522301000000', '兴义市', '', 3, '贵州省', '黔西南布依族苗族自治州', '兴义市', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('309', 'cn', '532500000000', '红河哈尼族彝族自治州', '', 2, '云南省', '红河哈尼族彝族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3090', 'cn', '522322000000', '兴仁县', '', 3, '贵州省', '黔西南布依族苗族自治州', '兴仁县', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3091', 'cn', '522323000000', '普安县', '', 3, '贵州省', '黔西南布依族苗族自治州', '普安县', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3092', 'cn', '522324000000', '晴隆县', '', 3, '贵州省', '黔西南布依族苗族自治州', '晴隆县', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3093', 'cn', '522325000000', '贞丰县', '', 3, '贵州省', '黔西南布依族苗族自治州', '贞丰县', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3094', 'cn', '522326000000', '望谟县', '', 3, '贵州省', '黔西南布依族苗族自治州', '望谟县', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3095', 'cn', '522327000000', '册亨县', '', 3, '贵州省', '黔西南布依族苗族自治州', '册亨县', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3096', 'cn', '522328000000', '安龙县', '', 3, '贵州省', '黔西南布依族苗族自治州', '安龙县', 0, 1, '522300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3097', 'cn', '522601000000', '凯里市', '', 3, '贵州省', '黔东南苗族侗族自治州', '凯里市', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3098', 'cn', '522622000000', '黄平县', '', 3, '贵州省', '黔东南苗族侗族自治州', '黄平县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3099', 'cn', '522623000000', '施秉县', '', 3, '贵州省', '黔东南苗族侗族自治州', '施秉县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('31', 'cn', '650000000000', '新疆维吾尔自治区', '', 1, '新疆维吾尔自治区', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('310', 'cn', '532600000000', '文山壮族苗族自治州', '', 2, '云南省', '文山壮族苗族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3100', 'cn', '522624000000', '三穗县', '', 3, '贵州省', '黔东南苗族侗族自治州', '三穗县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3101', 'cn', '522625000000', '镇远县', '', 3, '贵州省', '黔东南苗族侗族自治州', '镇远县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3102', 'cn', '522626000000', '岑巩县', '', 3, '贵州省', '黔东南苗族侗族自治州', '岑巩县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3103', 'cn', '522627000000', '天柱县', '', 3, '贵州省', '黔东南苗族侗族自治州', '天柱县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3104', 'cn', '522628000000', '锦屏县', '', 3, '贵州省', '黔东南苗族侗族自治州', '锦屏县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3105', 'cn', '522629000000', '剑河县', '', 3, '贵州省', '黔东南苗族侗族自治州', '剑河县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3106', 'cn', '522630000000', '台江县', '', 3, '贵州省', '黔东南苗族侗族自治州', '台江县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3107', 'cn', '522631000000', '黎平县', '', 3, '贵州省', '黔东南苗族侗族自治州', '黎平县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3108', 'cn', '522632000000', '榕江县', '', 3, '贵州省', '黔东南苗族侗族自治州', '榕江县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3109', 'cn', '522633000000', '从江县', '', 3, '贵州省', '黔东南苗族侗族自治州', '从江县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('311', 'cn', '532800000000', '西双版纳傣族自治州', '', 2, '云南省', '西双版纳傣族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3110', 'cn', '522634000000', '雷山县', '', 3, '贵州省', '黔东南苗族侗族自治州', '雷山县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3111', 'cn', '522635000000', '麻江县', '', 3, '贵州省', '黔东南苗族侗族自治州', '麻江县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3112', 'cn', '522636000000', '丹寨县', '', 3, '贵州省', '黔东南苗族侗族自治州', '丹寨县', 0, 1, '522600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3113', 'cn', '522701000000', '都匀市', '', 3, '贵州省', '黔南布依族苗族自治州', '都匀市', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3114', 'cn', '522702000000', '福泉市', '', 3, '贵州省', '黔南布依族苗族自治州', '福泉市', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3115', 'cn', '522722000000', '荔波县', '', 3, '贵州省', '黔南布依族苗族自治州', '荔波县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3116', 'cn', '522723000000', '贵定县', '', 3, '贵州省', '黔南布依族苗族自治州', '贵定县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3117', 'cn', '522725000000', '瓮安县', '', 3, '贵州省', '黔南布依族苗族自治州', '瓮安县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3118', 'cn', '522726000000', '独山县', '', 3, '贵州省', '黔南布依族苗族自治州', '独山县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3119', 'cn', '522727000000', '平塘县', '', 3, '贵州省', '黔南布依族苗族自治州', '平塘县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('312', 'cn', '532900000000', '大理白族自治州', '', 2, '云南省', '大理白族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3120', 'cn', '522728000000', '罗甸县', '', 3, '贵州省', '黔南布依族苗族自治州', '罗甸县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3121', 'cn', '522729000000', '长顺县', '', 3, '贵州省', '黔南布依族苗族自治州', '长顺县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3122', 'cn', '522730000000', '龙里县', '', 3, '贵州省', '黔南布依族苗族自治州', '龙里县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3123', 'cn', '522731000000', '惠水县', '', 3, '贵州省', '黔南布依族苗族自治州', '惠水县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3124', 'cn', '522732000000', '三都水族自治县', '', 3, '贵州省', '黔南布依族苗族自治州', '三都水族自治县', 0, 1, '522700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3125', 'cn', '530101000000', '市辖区', '', 3, '云南省', '昆明市', '市辖区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3126', 'cn', '530102000000', '五华区', '', 3, '云南省', '昆明市', '五华区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3127', 'cn', '530103000000', '盘龙区', '', 3, '云南省', '昆明市', '盘龙区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3128', 'cn', '530111000000', '官渡区', '', 3, '云南省', '昆明市', '官渡区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3129', 'cn', '530112000000', '西山区', '', 3, '云南省', '昆明市', '西山区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('313', 'cn', '533100000000', '德宏傣族景颇族自治州', '', 2, '云南省', '德宏傣族景颇族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3130', 'cn', '530113000000', '东川区', '', 3, '云南省', '昆明市', '东川区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3131', 'cn', '530114000000', '呈贡区', '', 3, '云南省', '昆明市', '呈贡区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3132', 'cn', '530115000000', '晋宁区', '', 3, '云南省', '昆明市', '晋宁区', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3133', 'cn', '530124000000', '富民县', '', 3, '云南省', '昆明市', '富民县', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3134', 'cn', '530125000000', '宜良县', '', 3, '云南省', '昆明市', '宜良县', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3135', 'cn', '530126000000', '石林彝族自治县', '', 3, '云南省', '昆明市', '石林彝族自治县', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3136', 'cn', '530127000000', '嵩明县', '', 3, '云南省', '昆明市', '嵩明县', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3137', 'cn', '530128000000', '禄劝彝族苗族自治县', '', 3, '云南省', '昆明市', '禄劝彝族苗族自治县', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3138', 'cn', '530129000000', '寻甸回族彝族自治县', '', 3, '云南省', '昆明市', '寻甸回族彝族自治县', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3139', 'cn', '530181000000', '安宁市', '', 3, '云南省', '昆明市', '安宁市', 0, 1, '530100000000');
INSERT INTO SYS_NATION_AREA VALUES ('314', 'cn', '533300000000', '怒江傈僳族自治州', '', 2, '云南省', '怒江傈僳族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3140', 'cn', '530301000000', '市辖区', '', 3, '云南省', '曲靖市', '市辖区', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3141', 'cn', '530302000000', '麒麟区', '', 3, '云南省', '曲靖市', '麒麟区', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3142', 'cn', '530303000000', '沾益区', '', 3, '云南省', '曲靖市', '沾益区', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3143', 'cn', '530321000000', '马龙县', '', 3, '云南省', '曲靖市', '马龙县', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3144', 'cn', '530322000000', '陆良县', '', 3, '云南省', '曲靖市', '陆良县', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3145', 'cn', '530323000000', '师宗县', '', 3, '云南省', '曲靖市', '师宗县', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3146', 'cn', '530324000000', '罗平县', '', 3, '云南省', '曲靖市', '罗平县', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3147', 'cn', '530325000000', '富源县', '', 3, '云南省', '曲靖市', '富源县', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3148', 'cn', '530326000000', '会泽县', '', 3, '云南省', '曲靖市', '会泽县', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3149', 'cn', '530381000000', '宣威市', '', 3, '云南省', '曲靖市', '宣威市', 0, 1, '530300000000');
INSERT INTO SYS_NATION_AREA VALUES ('315', 'cn', '533400000000', '迪庆藏族自治州', '', 2, '云南省', '迪庆藏族自治州', '', 0, 1, '530000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3150', 'cn', '530401000000', '市辖区', '', 3, '云南省', '玉溪市', '市辖区', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3151', 'cn', '530402000000', '红塔区', '', 3, '云南省', '玉溪市', '红塔区', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3152', 'cn', '530403000000', '江川区', '', 3, '云南省', '玉溪市', '江川区', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3153', 'cn', '530422000000', '澄江县', '', 3, '云南省', '玉溪市', '澄江县', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3154', 'cn', '530423000000', '通海县', '', 3, '云南省', '玉溪市', '通海县', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3155', 'cn', '530424000000', '华宁县', '', 3, '云南省', '玉溪市', '华宁县', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3156', 'cn', '530425000000', '易门县', '', 3, '云南省', '玉溪市', '易门县', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3157', 'cn', '530426000000', '峨山彝族自治县', '', 3, '云南省', '玉溪市', '峨山彝族自治县', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3158', 'cn', '530427000000', '新平彝族傣族自治县', '', 3, '云南省', '玉溪市', '新平彝族傣族自治县', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3159', 'cn', '530428000000', '元江哈尼族彝族傣族自治县', '', 3, '云南省', '玉溪市', '元江哈尼族彝族傣族自治县', 0, 1, '530400000000');
INSERT INTO SYS_NATION_AREA VALUES ('316', 'cn', '540100000000', '拉萨市', '', 2, '西藏自治区', '拉萨市', '', 0, 1, '540000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3160', 'cn', '530501000000', '市辖区', '', 3, '云南省', '保山市', '市辖区', 0, 1, '530500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3161', 'cn', '530502000000', '隆阳区', '', 3, '云南省', '保山市', '隆阳区', 0, 1, '530500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3162', 'cn', '530521000000', '施甸县', '', 3, '云南省', '保山市', '施甸县', 0, 1, '530500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3163', 'cn', '530523000000', '龙陵县', '', 3, '云南省', '保山市', '龙陵县', 0, 1, '530500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3164', 'cn', '530524000000', '昌宁县', '', 3, '云南省', '保山市', '昌宁县', 0, 1, '530500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3165', 'cn', '530581000000', '腾冲市', '', 3, '云南省', '保山市', '腾冲市', 0, 1, '530500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3166', 'cn', '530601000000', '市辖区', '', 3, '云南省', '昭通市', '市辖区', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3167', 'cn', '530602000000', '昭阳区', '', 3, '云南省', '昭通市', '昭阳区', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3168', 'cn', '530621000000', '鲁甸县', '', 3, '云南省', '昭通市', '鲁甸县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3169', 'cn', '530622000000', '巧家县', '', 3, '云南省', '昭通市', '巧家县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('317', 'cn', '540200000000', '日喀则市', '', 2, '西藏自治区', '日喀则市', '', 0, 1, '540000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3170', 'cn', '530623000000', '盐津县', '', 3, '云南省', '昭通市', '盐津县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3171', 'cn', '530624000000', '大关县', '', 3, '云南省', '昭通市', '大关县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3172', 'cn', '530625000000', '永善县', '', 3, '云南省', '昭通市', '永善县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3173', 'cn', '530626000000', '绥江县', '', 3, '云南省', '昭通市', '绥江县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3174', 'cn', '530627000000', '镇雄县', '', 3, '云南省', '昭通市', '镇雄县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3175', 'cn', '530628000000', '彝良县', '', 3, '云南省', '昭通市', '彝良县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3176', 'cn', '530629000000', '威信县', '', 3, '云南省', '昭通市', '威信县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3177', 'cn', '530630000000', '水富县', '', 3, '云南省', '昭通市', '水富县', 0, 1, '530600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3178', 'cn', '530701000000', '市辖区', '', 3, '云南省', '丽江市', '市辖区', 0, 1, '530700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3179', 'cn', '530702000000', '古城区', '', 3, '云南省', '丽江市', '古城区', 0, 1, '530700000000');
INSERT INTO SYS_NATION_AREA VALUES ('318', 'cn', '540300000000', '昌都市', '', 2, '西藏自治区', '昌都市', '', 0, 1, '540000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3180', 'cn', '530721000000', '玉龙纳西族自治县', '', 3, '云南省', '丽江市', '玉龙纳西族自治县', 0, 1, '530700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3181', 'cn', '530722000000', '永胜县', '', 3, '云南省', '丽江市', '永胜县', 0, 1, '530700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3182', 'cn', '530723000000', '华坪县', '', 3, '云南省', '丽江市', '华坪县', 0, 1, '530700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3183', 'cn', '530724000000', '宁蒗彝族自治县', '', 3, '云南省', '丽江市', '宁蒗彝族自治县', 0, 1, '530700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3184', 'cn', '530801000000', '市辖区', '', 3, '云南省', '普洱市', '市辖区', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3185', 'cn', '530802000000', '思茅区', '', 3, '云南省', '普洱市', '思茅区', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3186', 'cn', '530821000000', '宁洱哈尼族彝族自治县', '', 3, '云南省', '普洱市', '宁洱哈尼族彝族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3187', 'cn', '530822000000', '墨江哈尼族自治县', '', 3, '云南省', '普洱市', '墨江哈尼族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3188', 'cn', '530823000000', '景东彝族自治县', '', 3, '云南省', '普洱市', '景东彝族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3189', 'cn', '530824000000', '景谷傣族彝族自治县', '', 3, '云南省', '普洱市', '景谷傣族彝族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('319', 'cn', '540400000000', '林芝市', '', 2, '西藏自治区', '林芝市', '', 0, 1, '540000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3190', 'cn', '530825000000', '镇沅彝族哈尼族拉祜族自治县', '', 3, '云南省', '普洱市', '镇沅彝族哈尼族拉祜族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3191', 'cn', '530826000000', '江城哈尼族彝族自治县', '', 3, '云南省', '普洱市', '江城哈尼族彝族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3192', 'cn', '530827000000', '孟连傣族拉祜族佤族自治县', '', 3, '云南省', '普洱市', '孟连傣族拉祜族佤族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3193', 'cn', '530828000000', '澜沧拉祜族自治县', '', 3, '云南省', '普洱市', '澜沧拉祜族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3194', 'cn', '530829000000', '西盟佤族自治县', '', 3, '云南省', '普洱市', '西盟佤族自治县', 0, 1, '530800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3195', 'cn', '530901000000', '市辖区', '', 3, '云南省', '临沧市', '市辖区', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3196', 'cn', '530902000000', '临翔区', '', 3, '云南省', '临沧市', '临翔区', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3197', 'cn', '530921000000', '凤庆县', '', 3, '云南省', '临沧市', '凤庆县', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3198', 'cn', '530922000000', '云县', '', 3, '云南省', '临沧市', '云县', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3199', 'cn', '530923000000', '永德县', '', 3, '云南省', '临沧市', '永德县', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('32', 'cn', '110100000000', '市辖区', '', 2, '北京市', '市辖区', '', 0, 1, '110000000000');
INSERT INTO SYS_NATION_AREA VALUES ('320', 'cn', '540500000000', '山南市', '', 2, '西藏自治区', '山南市', '', 0, 1, '540000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3200', 'cn', '530924000000', '镇康县', '', 3, '云南省', '临沧市', '镇康县', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3201', 'cn', '530925000000', '双江拉祜族佤族布朗族傣族自治县', '', 3, '云南省', '临沧市', '双江拉祜族佤族布朗族傣族自治县', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3202', 'cn', '530926000000', '耿马傣族佤族自治县', '', 3, '云南省', '临沧市', '耿马傣族佤族自治县', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3203', 'cn', '530927000000', '沧源佤族自治县', '', 3, '云南省', '临沧市', '沧源佤族自治县', 0, 1, '530900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3204', 'cn', '532301000000', '楚雄市', '', 3, '云南省', '楚雄彝族自治州', '楚雄市', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3205', 'cn', '532322000000', '双柏县', '', 3, '云南省', '楚雄彝族自治州', '双柏县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3206', 'cn', '532323000000', '牟定县', '', 3, '云南省', '楚雄彝族自治州', '牟定县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3207', 'cn', '532324000000', '南华县', '', 3, '云南省', '楚雄彝族自治州', '南华县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3208', 'cn', '532325000000', '姚安县', '', 3, '云南省', '楚雄彝族自治州', '姚安县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3209', 'cn', '532326000000', '大姚县', '', 3, '云南省', '楚雄彝族自治州', '大姚县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('321', 'cn', '542400000000', '那曲地区', '', 2, '西藏自治区', '那曲地区', '', 0, 1, '540000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3210', 'cn', '532327000000', '永仁县', '', 3, '云南省', '楚雄彝族自治州', '永仁县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3211', 'cn', '532328000000', '元谋县', '', 3, '云南省', '楚雄彝族自治州', '元谋县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3212', 'cn', '532329000000', '武定县', '', 3, '云南省', '楚雄彝族自治州', '武定县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3213', 'cn', '532331000000', '禄丰县', '', 3, '云南省', '楚雄彝族自治州', '禄丰县', 0, 1, '532300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3214', 'cn', '532501000000', '个旧市', '', 3, '云南省', '红河哈尼族彝族自治州', '个旧市', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3215', 'cn', '532502000000', '开远市', '', 3, '云南省', '红河哈尼族彝族自治州', '开远市', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3216', 'cn', '532503000000', '蒙自市', '', 3, '云南省', '红河哈尼族彝族自治州', '蒙自市', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3217', 'cn', '532504000000', '弥勒市', '', 3, '云南省', '红河哈尼族彝族自治州', '弥勒市', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3218', 'cn', '532523000000', '屏边苗族自治县', '', 3, '云南省', '红河哈尼族彝族自治州', '屏边苗族自治县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3219', 'cn', '532524000000', '建水县', '', 3, '云南省', '红河哈尼族彝族自治州', '建水县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('322', 'cn', '542500000000', '阿里地区', '', 2, '西藏自治区', '阿里地区', '', 0, 1, '540000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3220', 'cn', '532525000000', '石屏县', '', 3, '云南省', '红河哈尼族彝族自治州', '石屏县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3221', 'cn', '532527000000', '泸西县', '', 3, '云南省', '红河哈尼族彝族自治州', '泸西县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3222', 'cn', '532528000000', '元阳县', '', 3, '云南省', '红河哈尼族彝族自治州', '元阳县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3223', 'cn', '532529000000', '红河县', '', 3, '云南省', '红河哈尼族彝族自治州', '红河县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3224', 'cn', '532530000000', '金平苗族瑶族傣族自治县', '', 3, '云南省', '红河哈尼族彝族自治州', '金平苗族瑶族傣族自治县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3225', 'cn', '532531000000', '绿春县', '', 3, '云南省', '红河哈尼族彝族自治州', '绿春县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3226', 'cn', '532532000000', '河口瑶族自治县', '', 3, '云南省', '红河哈尼族彝族自治州', '河口瑶族自治县', 0, 1, '532500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3227', 'cn', '532601000000', '文山市', '', 3, '云南省', '文山壮族苗族自治州', '文山市', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3228', 'cn', '532622000000', '砚山县', '', 3, '云南省', '文山壮族苗族自治州', '砚山县', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3229', 'cn', '532623000000', '西畴县', '', 3, '云南省', '文山壮族苗族自治州', '西畴县', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('323', 'cn', '610100000000', '西安市', '', 2, '陕西省', '西安市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3230', 'cn', '532624000000', '麻栗坡县', '', 3, '云南省', '文山壮族苗族自治州', '麻栗坡县', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3231', 'cn', '532625000000', '马关县', '', 3, '云南省', '文山壮族苗族自治州', '马关县', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3232', 'cn', '532626000000', '丘北县', '', 3, '云南省', '文山壮族苗族自治州', '丘北县', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3233', 'cn', '532627000000', '广南县', '', 3, '云南省', '文山壮族苗族自治州', '广南县', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3234', 'cn', '532628000000', '富宁县', '', 3, '云南省', '文山壮族苗族自治州', '富宁县', 0, 1, '532600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3235', 'cn', '532801000000', '景洪市', '', 3, '云南省', '西双版纳傣族自治州', '景洪市', 0, 1, '532800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3236', 'cn', '532822000000', '勐海县', '', 3, '云南省', '西双版纳傣族自治州', '勐海县', 0, 1, '532800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3237', 'cn', '532823000000', '勐腊县', '', 3, '云南省', '西双版纳傣族自治州', '勐腊县', 0, 1, '532800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3238', 'cn', '532901000000', '大理市', '', 3, '云南省', '大理白族自治州', '大理市', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3239', 'cn', '532922000000', '漾濞彝族自治县', '', 3, '云南省', '大理白族自治州', '漾濞彝族自治县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('324', 'cn', '610200000000', '铜川市', '', 2, '陕西省', '铜川市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3240', 'cn', '532923000000', '祥云县', '', 3, '云南省', '大理白族自治州', '祥云县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3241', 'cn', '532924000000', '宾川县', '', 3, '云南省', '大理白族自治州', '宾川县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3242', 'cn', '532925000000', '弥渡县', '', 3, '云南省', '大理白族自治州', '弥渡县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3243', 'cn', '532926000000', '南涧彝族自治县', '', 3, '云南省', '大理白族自治州', '南涧彝族自治县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3244', 'cn', '532927000000', '巍山彝族回族自治县', '', 3, '云南省', '大理白族自治州', '巍山彝族回族自治县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3245', 'cn', '532928000000', '永平县', '', 3, '云南省', '大理白族自治州', '永平县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3246', 'cn', '532929000000', '云龙县', '', 3, '云南省', '大理白族自治州', '云龙县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3247', 'cn', '532930000000', '洱源县', '', 3, '云南省', '大理白族自治州', '洱源县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3248', 'cn', '532931000000', '剑川县', '', 3, '云南省', '大理白族自治州', '剑川县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3249', 'cn', '532932000000', '鹤庆县', '', 3, '云南省', '大理白族自治州', '鹤庆县', 0, 1, '532900000000');
INSERT INTO SYS_NATION_AREA VALUES ('325', 'cn', '610300000000', '宝鸡市', '', 2, '陕西省', '宝鸡市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3250', 'cn', '533102000000', '瑞丽市', '', 3, '云南省', '德宏傣族景颇族自治州', '瑞丽市', 0, 1, '533100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3251', 'cn', '533103000000', '芒市', '', 3, '云南省', '德宏傣族景颇族自治州', '芒市', 0, 1, '533100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3252', 'cn', '533122000000', '梁河县', '', 3, '云南省', '德宏傣族景颇族自治州', '梁河县', 0, 1, '533100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3253', 'cn', '533123000000', '盈江县', '', 3, '云南省', '德宏傣族景颇族自治州', '盈江县', 0, 1, '533100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3254', 'cn', '533124000000', '陇川县', '', 3, '云南省', '德宏傣族景颇族自治州', '陇川县', 0, 1, '533100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3255', 'cn', '533301000000', '泸水市', '', 3, '云南省', '怒江傈僳族自治州', '泸水市', 0, 1, '533300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3256', 'cn', '533323000000', '福贡县', '', 3, '云南省', '怒江傈僳族自治州', '福贡县', 0, 1, '533300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3257', 'cn', '533324000000', '贡山独龙族怒族自治县', '', 3, '云南省', '怒江傈僳族自治州', '贡山独龙族怒族自治县', 0, 1, '533300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3258', 'cn', '533325000000', '兰坪白族普米族自治县', '', 3, '云南省', '怒江傈僳族自治州', '兰坪白族普米族自治县', 0, 1, '533300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3259', 'cn', '533401000000', '香格里拉市', '', 3, '云南省', '迪庆藏族自治州', '香格里拉市', 0, 1, '533400000000');
INSERT INTO SYS_NATION_AREA VALUES ('326', 'cn', '610400000000', '咸阳市', '', 2, '陕西省', '咸阳市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3260', 'cn', '533422000000', '德钦县', '', 3, '云南省', '迪庆藏族自治州', '德钦县', 0, 1, '533400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3261', 'cn', '533423000000', '维西傈僳族自治县', '', 3, '云南省', '迪庆藏族自治州', '维西傈僳族自治县', 0, 1, '533400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3262', 'cn', '540101000000', '市辖区', '', 3, '西藏自治区', '拉萨市', '市辖区', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3263', 'cn', '540102000000', '城关区', '', 3, '西藏自治区', '拉萨市', '城关区', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3264', 'cn', '540103000000', '堆龙德庆区', '', 3, '西藏自治区', '拉萨市', '堆龙德庆区', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3265', 'cn', '540121000000', '林周县', '', 3, '西藏自治区', '拉萨市', '林周县', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3266', 'cn', '540122000000', '当雄县', '', 3, '西藏自治区', '拉萨市', '当雄县', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3267', 'cn', '540123000000', '尼木县', '', 3, '西藏自治区', '拉萨市', '尼木县', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3268', 'cn', '540124000000', '曲水县', '', 3, '西藏自治区', '拉萨市', '曲水县', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3269', 'cn', '540126000000', '达孜县', '', 3, '西藏自治区', '拉萨市', '达孜县', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('327', 'cn', '610500000000', '渭南市', '', 2, '陕西省', '渭南市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3270', 'cn', '540127000000', '墨竹工卡县', '', 3, '西藏自治区', '拉萨市', '墨竹工卡县', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3271', 'cn', '540171000000', '格尔木藏青工业园区', '', 3, '西藏自治区', '拉萨市', '格尔木藏青工业园区', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3272', 'cn', '540172000000', '拉萨经济技术开发区', '', 3, '西藏自治区', '拉萨市', '拉萨经济技术开发区', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3273', 'cn', '540173000000', '西藏文化旅游创意园区', '', 3, '西藏自治区', '拉萨市', '西藏文化旅游创意园区', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3274', 'cn', '540174000000', '达孜工业园区', '', 3, '西藏自治区', '拉萨市', '达孜工业园区', 0, 1, '540100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3275', 'cn', '540202000000', '桑珠孜区', '', 3, '西藏自治区', '日喀则市', '桑珠孜区', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3276', 'cn', '540221000000', '南木林县', '', 3, '西藏自治区', '日喀则市', '南木林县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3277', 'cn', '540222000000', '江孜县', '', 3, '西藏自治区', '日喀则市', '江孜县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3278', 'cn', '540223000000', '定日县', '', 3, '西藏自治区', '日喀则市', '定日县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3279', 'cn', '540224000000', '萨迦县', '', 3, '西藏自治区', '日喀则市', '萨迦县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('328', 'cn', '610600000000', '延安市', '', 2, '陕西省', '延安市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3280', 'cn', '540225000000', '拉孜县', '', 3, '西藏自治区', '日喀则市', '拉孜县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3281', 'cn', '540226000000', '昂仁县', '', 3, '西藏自治区', '日喀则市', '昂仁县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3282', 'cn', '540227000000', '谢通门县', '', 3, '西藏自治区', '日喀则市', '谢通门县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3283', 'cn', '540228000000', '白朗县', '', 3, '西藏自治区', '日喀则市', '白朗县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3284', 'cn', '540229000000', '仁布县', '', 3, '西藏自治区', '日喀则市', '仁布县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3285', 'cn', '540230000000', '康马县', '', 3, '西藏自治区', '日喀则市', '康马县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3286', 'cn', '540231000000', '定结县', '', 3, '西藏自治区', '日喀则市', '定结县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3287', 'cn', '540232000000', '仲巴县', '', 3, '西藏自治区', '日喀则市', '仲巴县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3288', 'cn', '540233000000', '亚东县', '', 3, '西藏自治区', '日喀则市', '亚东县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3289', 'cn', '540234000000', '吉隆县', '', 3, '西藏自治区', '日喀则市', '吉隆县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('329', 'cn', '610700000000', '汉中市', '', 2, '陕西省', '汉中市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3290', 'cn', '540235000000', '聂拉木县', '', 3, '西藏自治区', '日喀则市', '聂拉木县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3291', 'cn', '540236000000', '萨嘎县', '', 3, '西藏自治区', '日喀则市', '萨嘎县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3292', 'cn', '540237000000', '岗巴县', '', 3, '西藏自治区', '日喀则市', '岗巴县', 0, 1, '540200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3293', 'cn', '540302000000', '卡若区', '', 3, '西藏自治区', '昌都市', '卡若区', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3294', 'cn', '540321000000', '江达县', '', 3, '西藏自治区', '昌都市', '江达县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3295', 'cn', '540322000000', '贡觉县', '', 3, '西藏自治区', '昌都市', '贡觉县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3296', 'cn', '540323000000', '类乌齐县', '', 3, '西藏自治区', '昌都市', '类乌齐县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3297', 'cn', '540324000000', '丁青县', '', 3, '西藏自治区', '昌都市', '丁青县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3298', 'cn', '540325000000', '察雅县', '', 3, '西藏自治区', '昌都市', '察雅县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3299', 'cn', '540326000000', '八宿县', '', 3, '西藏自治区', '昌都市', '八宿县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('33', 'cn', '120100000000', '市辖区', '', 2, '天津市', '市辖区', '', 0, 1, '120000000000');
INSERT INTO SYS_NATION_AREA VALUES ('330', 'cn', '610800000000', '榆林市', '', 2, '陕西省', '榆林市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3300', 'cn', '540327000000', '左贡县', '', 3, '西藏自治区', '昌都市', '左贡县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3301', 'cn', '540328000000', '芒康县', '', 3, '西藏自治区', '昌都市', '芒康县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3302', 'cn', '540329000000', '洛隆县', '', 3, '西藏自治区', '昌都市', '洛隆县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3303', 'cn', '540330000000', '边坝县', '', 3, '西藏自治区', '昌都市', '边坝县', 0, 1, '540300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3304', 'cn', '540402000000', '巴宜区', '', 3, '西藏自治区', '林芝市', '巴宜区', 0, 1, '540400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3305', 'cn', '540421000000', '工布江达县', '', 3, '西藏自治区', '林芝市', '工布江达县', 0, 1, '540400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3306', 'cn', '540422000000', '米林县', '', 3, '西藏自治区', '林芝市', '米林县', 0, 1, '540400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3307', 'cn', '540423000000', '墨脱县', '', 3, '西藏自治区', '林芝市', '墨脱县', 0, 1, '540400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3308', 'cn', '540424000000', '波密县', '', 3, '西藏自治区', '林芝市', '波密县', 0, 1, '540400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3309', 'cn', '540425000000', '察隅县', '', 3, '西藏自治区', '林芝市', '察隅县', 0, 1, '540400000000');
INSERT INTO SYS_NATION_AREA VALUES ('331', 'cn', '610900000000', '安康市', '', 2, '陕西省', '安康市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3310', 'cn', '540426000000', '朗县', '', 3, '西藏自治区', '林芝市', '朗县', 0, 1, '540400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3311', 'cn', '540501000000', '市辖区', '', 3, '西藏自治区', '山南市', '市辖区', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3312', 'cn', '540502000000', '乃东区', '', 3, '西藏自治区', '山南市', '乃东区', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3313', 'cn', '540521000000', '扎囊县', '', 3, '西藏自治区', '山南市', '扎囊县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3314', 'cn', '540522000000', '贡嘎县', '', 3, '西藏自治区', '山南市', '贡嘎县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3315', 'cn', '540523000000', '桑日县', '', 3, '西藏自治区', '山南市', '桑日县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3316', 'cn', '540524000000', '琼结县', '', 3, '西藏自治区', '山南市', '琼结县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3317', 'cn', '540525000000', '曲松县', '', 3, '西藏自治区', '山南市', '曲松县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3318', 'cn', '540526000000', '措美县', '', 3, '西藏自治区', '山南市', '措美县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3319', 'cn', '540527000000', '洛扎县', '', 3, '西藏自治区', '山南市', '洛扎县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('332', 'cn', '611000000000', '商洛市', '', 2, '陕西省', '商洛市', '', 0, 1, '610000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3320', 'cn', '540528000000', '加查县', '', 3, '西藏自治区', '山南市', '加查县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3321', 'cn', '540529000000', '隆子县', '', 3, '西藏自治区', '山南市', '隆子县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3322', 'cn', '540530000000', '错那县', '', 3, '西藏自治区', '山南市', '错那县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3323', 'cn', '540531000000', '浪卡子县', '', 3, '西藏自治区', '山南市', '浪卡子县', 0, 1, '540500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3324', 'cn', '542421000000', '那曲县', '', 3, '西藏自治区', '那曲地区', '那曲县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3325', 'cn', '542422000000', '嘉黎县', '', 3, '西藏自治区', '那曲地区', '嘉黎县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3326', 'cn', '542423000000', '比如县', '', 3, '西藏自治区', '那曲地区', '比如县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3327', 'cn', '542424000000', '聂荣县', '', 3, '西藏自治区', '那曲地区', '聂荣县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3328', 'cn', '542425000000', '安多县', '', 3, '西藏自治区', '那曲地区', '安多县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3329', 'cn', '542426000000', '申扎县', '', 3, '西藏自治区', '那曲地区', '申扎县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('333', 'cn', '620100000000', '兰州市', '', 2, '甘肃省', '兰州市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3330', 'cn', '542427000000', '索县', '', 3, '西藏自治区', '那曲地区', '索县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3331', 'cn', '542428000000', '班戈县', '', 3, '西藏自治区', '那曲地区', '班戈县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3332', 'cn', '542429000000', '巴青县', '', 3, '西藏自治区', '那曲地区', '巴青县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3333', 'cn', '542430000000', '尼玛县', '', 3, '西藏自治区', '那曲地区', '尼玛县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3334', 'cn', '542431000000', '双湖县', '', 3, '西藏自治区', '那曲地区', '双湖县', 0, 1, '542400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3335', 'cn', '542521000000', '普兰县', '', 3, '西藏自治区', '阿里地区', '普兰县', 0, 1, '542500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3336', 'cn', '542522000000', '札达县', '', 3, '西藏自治区', '阿里地区', '札达县', 0, 1, '542500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3337', 'cn', '542523000000', '噶尔县', '', 3, '西藏自治区', '阿里地区', '噶尔县', 0, 1, '542500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3338', 'cn', '542524000000', '日土县', '', 3, '西藏自治区', '阿里地区', '日土县', 0, 1, '542500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3339', 'cn', '542525000000', '革吉县', '', 3, '西藏自治区', '阿里地区', '革吉县', 0, 1, '542500000000');
INSERT INTO SYS_NATION_AREA VALUES ('334', 'cn', '620200000000', '嘉峪关市', '', 2, '甘肃省', '嘉峪关市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3340', 'cn', '542526000000', '改则县', '', 3, '西藏自治区', '阿里地区', '改则县', 0, 1, '542500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3341', 'cn', '542527000000', '措勤县', '', 3, '西藏自治区', '阿里地区', '措勤县', 0, 1, '542500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3342', 'cn', '610101000000', '市辖区', '', 3, '陕西省', '西安市', '市辖区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3343', 'cn', '610102000000', '新城区', '', 3, '陕西省', '西安市', '新城区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3344', 'cn', '610103000000', '碑林区', '', 3, '陕西省', '西安市', '碑林区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3345', 'cn', '610104000000', '莲湖区', '', 3, '陕西省', '西安市', '莲湖区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3346', 'cn', '610111000000', '灞桥区', '', 3, '陕西省', '西安市', '灞桥区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3347', 'cn', '610112000000', '未央区', '', 3, '陕西省', '西安市', '未央区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3348', 'cn', '610113000000', '雁塔区', '', 3, '陕西省', '西安市', '雁塔区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3349', 'cn', '610114000000', '阎良区', '', 3, '陕西省', '西安市', '阎良区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('335', 'cn', '620300000000', '金昌市', '', 2, '甘肃省', '金昌市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3350', 'cn', '610115000000', '临潼区', '', 3, '陕西省', '西安市', '临潼区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3351', 'cn', '610116000000', '长安区', '', 3, '陕西省', '西安市', '长安区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3352', 'cn', '610117000000', '高陵区', '', 3, '陕西省', '西安市', '高陵区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3353', 'cn', '610118000000', '鄠邑区', '', 3, '陕西省', '西安市', '鄠邑区', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3354', 'cn', '610122000000', '蓝田县', '', 3, '陕西省', '西安市', '蓝田县', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3355', 'cn', '610124000000', '周至县', '', 3, '陕西省', '西安市', '周至县', 0, 1, '610100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3356', 'cn', '610201000000', '市辖区', '', 3, '陕西省', '铜川市', '市辖区', 0, 1, '610200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3357', 'cn', '610202000000', '王益区', '', 3, '陕西省', '铜川市', '王益区', 0, 1, '610200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3358', 'cn', '610203000000', '印台区', '', 3, '陕西省', '铜川市', '印台区', 0, 1, '610200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3359', 'cn', '610204000000', '耀州区', '', 3, '陕西省', '铜川市', '耀州区', 0, 1, '610200000000');
INSERT INTO SYS_NATION_AREA VALUES ('336', 'cn', '620400000000', '白银市', '', 2, '甘肃省', '白银市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3360', 'cn', '610222000000', '宜君县', '', 3, '陕西省', '铜川市', '宜君县', 0, 1, '610200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3361', 'cn', '610301000000', '市辖区', '', 3, '陕西省', '宝鸡市', '市辖区', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3362', 'cn', '610302000000', '渭滨区', '', 3, '陕西省', '宝鸡市', '渭滨区', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3363', 'cn', '610303000000', '金台区', '', 3, '陕西省', '宝鸡市', '金台区', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3364', 'cn', '610304000000', '陈仓区', '', 3, '陕西省', '宝鸡市', '陈仓区', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3365', 'cn', '610322000000', '凤翔县', '', 3, '陕西省', '宝鸡市', '凤翔县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3366', 'cn', '610323000000', '岐山县', '', 3, '陕西省', '宝鸡市', '岐山县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3367', 'cn', '610324000000', '扶风县', '', 3, '陕西省', '宝鸡市', '扶风县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3368', 'cn', '610326000000', '眉县', '', 3, '陕西省', '宝鸡市', '眉县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3369', 'cn', '610327000000', '陇县', '', 3, '陕西省', '宝鸡市', '陇县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('337', 'cn', '620500000000', '天水市', '', 2, '甘肃省', '天水市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3370', 'cn', '610328000000', '千阳县', '', 3, '陕西省', '宝鸡市', '千阳县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3371', 'cn', '610329000000', '麟游县', '', 3, '陕西省', '宝鸡市', '麟游县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3372', 'cn', '610330000000', '凤县', '', 3, '陕西省', '宝鸡市', '凤县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3373', 'cn', '610331000000', '太白县', '', 3, '陕西省', '宝鸡市', '太白县', 0, 1, '610300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3374', 'cn', '610401000000', '市辖区', '', 3, '陕西省', '咸阳市', '市辖区', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3375', 'cn', '610402000000', '秦都区', '', 3, '陕西省', '咸阳市', '秦都区', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3376', 'cn', '610403000000', '杨陵区', '', 3, '陕西省', '咸阳市', '杨陵区', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3377', 'cn', '610404000000', '渭城区', '', 3, '陕西省', '咸阳市', '渭城区', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3378', 'cn', '610422000000', '三原县', '', 3, '陕西省', '咸阳市', '三原县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3379', 'cn', '610423000000', '泾阳县', '', 3, '陕西省', '咸阳市', '泾阳县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('338', 'cn', '620600000000', '武威市', '', 2, '甘肃省', '武威市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3380', 'cn', '610424000000', '乾县', '', 3, '陕西省', '咸阳市', '乾县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3381', 'cn', '610425000000', '礼泉县', '', 3, '陕西省', '咸阳市', '礼泉县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3382', 'cn', '610426000000', '永寿县', '', 3, '陕西省', '咸阳市', '永寿县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3383', 'cn', '610427000000', '彬县', '', 3, '陕西省', '咸阳市', '彬县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3384', 'cn', '610428000000', '长武县', '', 3, '陕西省', '咸阳市', '长武县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3385', 'cn', '610429000000', '旬邑县', '', 3, '陕西省', '咸阳市', '旬邑县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3386', 'cn', '610430000000', '淳化县', '', 3, '陕西省', '咸阳市', '淳化县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3387', 'cn', '610431000000', '武功县', '', 3, '陕西省', '咸阳市', '武功县', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3388', 'cn', '610481000000', '兴平市', '', 3, '陕西省', '咸阳市', '兴平市', 0, 1, '610400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3389', 'cn', '610501000000', '市辖区', '', 3, '陕西省', '渭南市', '市辖区', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('339', 'cn', '620700000000', '张掖市', '', 2, '甘肃省', '张掖市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3390', 'cn', '610502000000', '临渭区', '', 3, '陕西省', '渭南市', '临渭区', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3391', 'cn', '610503000000', '华州区', '', 3, '陕西省', '渭南市', '华州区', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3392', 'cn', '610522000000', '潼关县', '', 3, '陕西省', '渭南市', '潼关县', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3393', 'cn', '610523000000', '大荔县', '', 3, '陕西省', '渭南市', '大荔县', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3394', 'cn', '610524000000', '合阳县', '', 3, '陕西省', '渭南市', '合阳县', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3395', 'cn', '610525000000', '澄城县', '', 3, '陕西省', '渭南市', '澄城县', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3396', 'cn', '610526000000', '蒲城县', '', 3, '陕西省', '渭南市', '蒲城县', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3397', 'cn', '610527000000', '白水县', '', 3, '陕西省', '渭南市', '白水县', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3398', 'cn', '610528000000', '富平县', '', 3, '陕西省', '渭南市', '富平县', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3399', 'cn', '610581000000', '韩城市', '', 3, '陕西省', '渭南市', '韩城市', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('34', 'cn', '130100000000', '石家庄市', '', 2, '河北省', '石家庄市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('340', 'cn', '620800000000', '平凉市', '', 2, '甘肃省', '平凉市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3400', 'cn', '610582000000', '华阴市', '', 3, '陕西省', '渭南市', '华阴市', 0, 1, '610500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3401', 'cn', '610601000000', '市辖区', '', 3, '陕西省', '延安市', '市辖区', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3402', 'cn', '610602000000', '宝塔区', '', 3, '陕西省', '延安市', '宝塔区', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3403', 'cn', '610603000000', '安塞区', '', 3, '陕西省', '延安市', '安塞区', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3404', 'cn', '610621000000', '延长县', '', 3, '陕西省', '延安市', '延长县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3405', 'cn', '610622000000', '延川县', '', 3, '陕西省', '延安市', '延川县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3406', 'cn', '610623000000', '子长县', '', 3, '陕西省', '延安市', '子长县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3407', 'cn', '610625000000', '志丹县', '', 3, '陕西省', '延安市', '志丹县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3408', 'cn', '610626000000', '吴起县', '', 3, '陕西省', '延安市', '吴起县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3409', 'cn', '610627000000', '甘泉县', '', 3, '陕西省', '延安市', '甘泉县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('341', 'cn', '620900000000', '酒泉市', '', 2, '甘肃省', '酒泉市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3410', 'cn', '610628000000', '富县', '', 3, '陕西省', '延安市', '富县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3411', 'cn', '610629000000', '洛川县', '', 3, '陕西省', '延安市', '洛川县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3412', 'cn', '610630000000', '宜川县', '', 3, '陕西省', '延安市', '宜川县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3413', 'cn', '610631000000', '黄龙县', '', 3, '陕西省', '延安市', '黄龙县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3414', 'cn', '610632000000', '黄陵县', '', 3, '陕西省', '延安市', '黄陵县', 0, 1, '610600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3415', 'cn', '610701000000', '市辖区', '', 3, '陕西省', '汉中市', '市辖区', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3416', 'cn', '610702000000', '汉台区', '', 3, '陕西省', '汉中市', '汉台区', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3417', 'cn', '610703000000', '南郑区', '', 3, '陕西省', '汉中市', '南郑区', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3418', 'cn', '610722000000', '城固县', '', 3, '陕西省', '汉中市', '城固县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3419', 'cn', '610723000000', '洋县', '', 3, '陕西省', '汉中市', '洋县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('342', 'cn', '621000000000', '庆阳市', '', 2, '甘肃省', '庆阳市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3420', 'cn', '610724000000', '西乡县', '', 3, '陕西省', '汉中市', '西乡县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3421', 'cn', '610725000000', '勉县', '', 3, '陕西省', '汉中市', '勉县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3422', 'cn', '610726000000', '宁强县', '', 3, '陕西省', '汉中市', '宁强县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3423', 'cn', '610727000000', '略阳县', '', 3, '陕西省', '汉中市', '略阳县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3424', 'cn', '610728000000', '镇巴县', '', 3, '陕西省', '汉中市', '镇巴县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3425', 'cn', '610729000000', '留坝县', '', 3, '陕西省', '汉中市', '留坝县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3426', 'cn', '610730000000', '佛坪县', '', 3, '陕西省', '汉中市', '佛坪县', 0, 1, '610700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3427', 'cn', '610801000000', '市辖区', '', 3, '陕西省', '榆林市', '市辖区', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3428', 'cn', '610802000000', '榆阳区', '', 3, '陕西省', '榆林市', '榆阳区', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3429', 'cn', '610803000000', '横山区', '', 3, '陕西省', '榆林市', '横山区', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('343', 'cn', '621100000000', '定西市', '', 2, '甘肃省', '定西市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3430', 'cn', '610822000000', '府谷县', '', 3, '陕西省', '榆林市', '府谷县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3431', 'cn', '610824000000', '靖边县', '', 3, '陕西省', '榆林市', '靖边县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3432', 'cn', '610825000000', '定边县', '', 3, '陕西省', '榆林市', '定边县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3433', 'cn', '610826000000', '绥德县', '', 3, '陕西省', '榆林市', '绥德县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3434', 'cn', '610827000000', '米脂县', '', 3, '陕西省', '榆林市', '米脂县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3435', 'cn', '610828000000', '佳县', '', 3, '陕西省', '榆林市', '佳县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3436', 'cn', '610829000000', '吴堡县', '', 3, '陕西省', '榆林市', '吴堡县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3437', 'cn', '610830000000', '清涧县', '', 3, '陕西省', '榆林市', '清涧县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3438', 'cn', '610831000000', '子洲县', '', 3, '陕西省', '榆林市', '子洲县', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3439', 'cn', '610881000000', '神木市', '', 3, '陕西省', '榆林市', '神木市', 0, 1, '610800000000');
INSERT INTO SYS_NATION_AREA VALUES ('344', 'cn', '621200000000', '陇南市', '', 2, '甘肃省', '陇南市', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3440', 'cn', '610901000000', '市辖区', '', 3, '陕西省', '安康市', '市辖区', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3441', 'cn', '610902000000', '汉滨区', '', 3, '陕西省', '安康市', '汉滨区', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3442', 'cn', '610921000000', '汉阴县', '', 3, '陕西省', '安康市', '汉阴县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3443', 'cn', '610922000000', '石泉县', '', 3, '陕西省', '安康市', '石泉县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3444', 'cn', '610923000000', '宁陕县', '', 3, '陕西省', '安康市', '宁陕县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3445', 'cn', '610924000000', '紫阳县', '', 3, '陕西省', '安康市', '紫阳县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3446', 'cn', '610925000000', '岚皋县', '', 3, '陕西省', '安康市', '岚皋县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3447', 'cn', '610926000000', '平利县', '', 3, '陕西省', '安康市', '平利县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3448', 'cn', '610927000000', '镇坪县', '', 3, '陕西省', '安康市', '镇坪县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3449', 'cn', '610928000000', '旬阳县', '', 3, '陕西省', '安康市', '旬阳县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('345', 'cn', '622900000000', '临夏回族自治州', '', 2, '甘肃省', '临夏回族自治州', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3450', 'cn', '610929000000', '白河县', '', 3, '陕西省', '安康市', '白河县', 0, 1, '610900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3451', 'cn', '611001000000', '市辖区', '', 3, '陕西省', '商洛市', '市辖区', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3452', 'cn', '611002000000', '商州区', '', 3, '陕西省', '商洛市', '商州区', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3453', 'cn', '611021000000', '洛南县', '', 3, '陕西省', '商洛市', '洛南县', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3454', 'cn', '611022000000', '丹凤县', '', 3, '陕西省', '商洛市', '丹凤县', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3455', 'cn', '611023000000', '商南县', '', 3, '陕西省', '商洛市', '商南县', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3456', 'cn', '611024000000', '山阳县', '', 3, '陕西省', '商洛市', '山阳县', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3457', 'cn', '611025000000', '镇安县', '', 3, '陕西省', '商洛市', '镇安县', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3458', 'cn', '611026000000', '柞水县', '', 3, '陕西省', '商洛市', '柞水县', 0, 1, '611000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3459', 'cn', '620101000000', '市辖区', '', 3, '甘肃省', '兰州市', '市辖区', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('346', 'cn', '623000000000', '甘南藏族自治州', '', 2, '甘肃省', '甘南藏族自治州', '', 0, 1, '620000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3460', 'cn', '620102000000', '城关区', '', 3, '甘肃省', '兰州市', '城关区', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3461', 'cn', '620103000000', '七里河区', '', 3, '甘肃省', '兰州市', '七里河区', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3462', 'cn', '620104000000', '西固区', '', 3, '甘肃省', '兰州市', '西固区', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3463', 'cn', '620105000000', '安宁区', '', 3, '甘肃省', '兰州市', '安宁区', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3464', 'cn', '620111000000', '红古区', '', 3, '甘肃省', '兰州市', '红古区', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3465', 'cn', '620121000000', '永登县', '', 3, '甘肃省', '兰州市', '永登县', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3466', 'cn', '620122000000', '皋兰县', '', 3, '甘肃省', '兰州市', '皋兰县', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3467', 'cn', '620123000000', '榆中县', '', 3, '甘肃省', '兰州市', '榆中县', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3468', 'cn', '620171000000', '兰州新区', '', 3, '甘肃省', '兰州市', '兰州新区', 0, 1, '620100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3469', 'cn', '620201000000', '市辖区', '', 3, '甘肃省', '嘉峪关市', '市辖区', 0, 1, '620200000000');
INSERT INTO SYS_NATION_AREA VALUES ('347', 'cn', '630100000000', '西宁市', '', 2, '青海省', '西宁市', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3470', 'cn', '620301000000', '市辖区', '', 3, '甘肃省', '金昌市', '市辖区', 0, 1, '620300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3471', 'cn', '620302000000', '金川区', '', 3, '甘肃省', '金昌市', '金川区', 0, 1, '620300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3472', 'cn', '620321000000', '永昌县', '', 3, '甘肃省', '金昌市', '永昌县', 0, 1, '620300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3473', 'cn', '620401000000', '市辖区', '', 3, '甘肃省', '白银市', '市辖区', 0, 1, '620400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3474', 'cn', '620402000000', '白银区', '', 3, '甘肃省', '白银市', '白银区', 0, 1, '620400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3475', 'cn', '620403000000', '平川区', '', 3, '甘肃省', '白银市', '平川区', 0, 1, '620400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3476', 'cn', '620421000000', '靖远县', '', 3, '甘肃省', '白银市', '靖远县', 0, 1, '620400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3477', 'cn', '620422000000', '会宁县', '', 3, '甘肃省', '白银市', '会宁县', 0, 1, '620400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3478', 'cn', '620423000000', '景泰县', '', 3, '甘肃省', '白银市', '景泰县', 0, 1, '620400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3479', 'cn', '620501000000', '市辖区', '', 3, '甘肃省', '天水市', '市辖区', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('348', 'cn', '630200000000', '海东市', '', 2, '青海省', '海东市', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3480', 'cn', '620502000000', '秦州区', '', 3, '甘肃省', '天水市', '秦州区', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3481', 'cn', '620503000000', '麦积区', '', 3, '甘肃省', '天水市', '麦积区', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3482', 'cn', '620521000000', '清水县', '', 3, '甘肃省', '天水市', '清水县', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3483', 'cn', '620522000000', '秦安县', '', 3, '甘肃省', '天水市', '秦安县', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3484', 'cn', '620523000000', '甘谷县', '', 3, '甘肃省', '天水市', '甘谷县', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3485', 'cn', '620524000000', '武山县', '', 3, '甘肃省', '天水市', '武山县', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3486', 'cn', '620525000000', '张家川回族自治县', '', 3, '甘肃省', '天水市', '张家川回族自治县', 0, 1, '620500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3487', 'cn', '620601000000', '市辖区', '', 3, '甘肃省', '武威市', '市辖区', 0, 1, '620600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3488', 'cn', '620602000000', '凉州区', '', 3, '甘肃省', '武威市', '凉州区', 0, 1, '620600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3489', 'cn', '620621000000', '民勤县', '', 3, '甘肃省', '武威市', '民勤县', 0, 1, '620600000000');
INSERT INTO SYS_NATION_AREA VALUES ('349', 'cn', '632200000000', '海北藏族自治州', '', 2, '青海省', '海北藏族自治州', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3490', 'cn', '620622000000', '古浪县', '', 3, '甘肃省', '武威市', '古浪县', 0, 1, '620600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3491', 'cn', '620623000000', '天祝藏族自治县', '', 3, '甘肃省', '武威市', '天祝藏族自治县', 0, 1, '620600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3492', 'cn', '620701000000', '市辖区', '', 3, '甘肃省', '张掖市', '市辖区', 0, 1, '620700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3493', 'cn', '620702000000', '甘州区', '', 3, '甘肃省', '张掖市', '甘州区', 0, 1, '620700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3494', 'cn', '620721000000', '肃南裕固族自治县', '', 3, '甘肃省', '张掖市', '肃南裕固族自治县', 0, 1, '620700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3495', 'cn', '620722000000', '民乐县', '', 3, '甘肃省', '张掖市', '民乐县', 0, 1, '620700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3496', 'cn', '620723000000', '临泽县', '', 3, '甘肃省', '张掖市', '临泽县', 0, 1, '620700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3497', 'cn', '620724000000', '高台县', '', 3, '甘肃省', '张掖市', '高台县', 0, 1, '620700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3498', 'cn', '620725000000', '山丹县', '', 3, '甘肃省', '张掖市', '山丹县', 0, 1, '620700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3499', 'cn', '620801000000', '市辖区', '', 3, '甘肃省', '平凉市', '市辖区', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('35', 'cn', '130200000000', '唐山市', '', 2, '河北省', '唐山市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('350', 'cn', '632300000000', '黄南藏族自治州', '', 2, '青海省', '黄南藏族自治州', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3500', 'cn', '620802000000', '崆峒区', '', 3, '甘肃省', '平凉市', '崆峒区', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3501', 'cn', '620821000000', '泾川县', '', 3, '甘肃省', '平凉市', '泾川县', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3502', 'cn', '620822000000', '灵台县', '', 3, '甘肃省', '平凉市', '灵台县', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3503', 'cn', '620823000000', '崇信县', '', 3, '甘肃省', '平凉市', '崇信县', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3504', 'cn', '620824000000', '华亭县', '', 3, '甘肃省', '平凉市', '华亭县', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3505', 'cn', '620825000000', '庄浪县', '', 3, '甘肃省', '平凉市', '庄浪县', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3506', 'cn', '620826000000', '静宁县', '', 3, '甘肃省', '平凉市', '静宁县', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3507', 'cn', '620871000000', '平凉工业园区', '', 3, '甘肃省', '平凉市', '平凉工业园区', 0, 1, '620800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3508', 'cn', '620901000000', '市辖区', '', 3, '甘肃省', '酒泉市', '市辖区', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3509', 'cn', '620902000000', '肃州区', '', 3, '甘肃省', '酒泉市', '肃州区', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('351', 'cn', '632500000000', '海南藏族自治州', '', 2, '青海省', '海南藏族自治州', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3510', 'cn', '620921000000', '金塔县', '', 3, '甘肃省', '酒泉市', '金塔县', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3511', 'cn', '620922000000', '瓜州县', '', 3, '甘肃省', '酒泉市', '瓜州县', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3512', 'cn', '620923000000', '肃北蒙古族自治县', '', 3, '甘肃省', '酒泉市', '肃北蒙古族自治县', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3513', 'cn', '620924000000', '阿克塞哈萨克族自治县', '', 3, '甘肃省', '酒泉市', '阿克塞哈萨克族自治县', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3514', 'cn', '620981000000', '玉门市', '', 3, '甘肃省', '酒泉市', '玉门市', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3515', 'cn', '620982000000', '敦煌市', '', 3, '甘肃省', '酒泉市', '敦煌市', 0, 1, '620900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3516', 'cn', '621001000000', '市辖区', '', 3, '甘肃省', '庆阳市', '市辖区', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3517', 'cn', '621002000000', '西峰区', '', 3, '甘肃省', '庆阳市', '西峰区', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3518', 'cn', '621021000000', '庆城县', '', 3, '甘肃省', '庆阳市', '庆城县', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3519', 'cn', '621022000000', '环县', '', 3, '甘肃省', '庆阳市', '环县', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('352', 'cn', '632600000000', '果洛藏族自治州', '', 2, '青海省', '果洛藏族自治州', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3520', 'cn', '621023000000', '华池县', '', 3, '甘肃省', '庆阳市', '华池县', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3521', 'cn', '621024000000', '合水县', '', 3, '甘肃省', '庆阳市', '合水县', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3522', 'cn', '621025000000', '正宁县', '', 3, '甘肃省', '庆阳市', '正宁县', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3523', 'cn', '621026000000', '宁县', '', 3, '甘肃省', '庆阳市', '宁县', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3524', 'cn', '621027000000', '镇原县', '', 3, '甘肃省', '庆阳市', '镇原县', 0, 1, '621000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3525', 'cn', '621101000000', '市辖区', '', 3, '甘肃省', '定西市', '市辖区', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3526', 'cn', '621102000000', '安定区', '', 3, '甘肃省', '定西市', '安定区', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3527', 'cn', '621121000000', '通渭县', '', 3, '甘肃省', '定西市', '通渭县', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3528', 'cn', '621122000000', '陇西县', '', 3, '甘肃省', '定西市', '陇西县', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3529', 'cn', '621123000000', '渭源县', '', 3, '甘肃省', '定西市', '渭源县', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('353', 'cn', '632700000000', '玉树藏族自治州', '', 2, '青海省', '玉树藏族自治州', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3530', 'cn', '621124000000', '临洮县', '', 3, '甘肃省', '定西市', '临洮县', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3531', 'cn', '621125000000', '漳县', '', 3, '甘肃省', '定西市', '漳县', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3532', 'cn', '621126000000', '岷县', '', 3, '甘肃省', '定西市', '岷县', 0, 1, '621100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3533', 'cn', '621201000000', '市辖区', '', 3, '甘肃省', '陇南市', '市辖区', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3534', 'cn', '621202000000', '武都区', '', 3, '甘肃省', '陇南市', '武都区', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3535', 'cn', '621221000000', '成县', '', 3, '甘肃省', '陇南市', '成县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3536', 'cn', '621222000000', '文县', '', 3, '甘肃省', '陇南市', '文县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3537', 'cn', '621223000000', '宕昌县', '', 3, '甘肃省', '陇南市', '宕昌县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3538', 'cn', '621224000000', '康县', '', 3, '甘肃省', '陇南市', '康县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3539', 'cn', '621225000000', '西和县', '', 3, '甘肃省', '陇南市', '西和县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('354', 'cn', '632800000000', '海西蒙古族藏族自治州', '', 2, '青海省', '海西蒙古族藏族自治州', '', 0, 1, '630000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3540', 'cn', '621226000000', '礼县', '', 3, '甘肃省', '陇南市', '礼县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3541', 'cn', '621227000000', '徽县', '', 3, '甘肃省', '陇南市', '徽县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3542', 'cn', '621228000000', '两当县', '', 3, '甘肃省', '陇南市', '两当县', 0, 1, '621200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3543', 'cn', '622901000000', '临夏市', '', 3, '甘肃省', '临夏回族自治州', '临夏市', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3544', 'cn', '622921000000', '临夏县', '', 3, '甘肃省', '临夏回族自治州', '临夏县', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3545', 'cn', '622922000000', '康乐县', '', 3, '甘肃省', '临夏回族自治州', '康乐县', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3546', 'cn', '622923000000', '永靖县', '', 3, '甘肃省', '临夏回族自治州', '永靖县', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3547', 'cn', '622924000000', '广河县', '', 3, '甘肃省', '临夏回族自治州', '广河县', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3548', 'cn', '622925000000', '和政县', '', 3, '甘肃省', '临夏回族自治州', '和政县', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3549', 'cn', '622926000000', '东乡族自治县', '', 3, '甘肃省', '临夏回族自治州', '东乡族自治县', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('355', 'cn', '640100000000', '银川市', '', 2, '宁夏回族自治区', '银川市', '', 0, 1, '640000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3550', 'cn', '622927000000', '积石山保安族东乡族撒拉族自治县', '', 3, '甘肃省', '临夏回族自治州', '积石山保安族东乡族撒拉族自治县', 0, 1, '622900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3551', 'cn', '623001000000', '合作市', '', 3, '甘肃省', '甘南藏族自治州', '合作市', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3552', 'cn', '623021000000', '临潭县', '', 3, '甘肃省', '甘南藏族自治州', '临潭县', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3553', 'cn', '623022000000', '卓尼县', '', 3, '甘肃省', '甘南藏族自治州', '卓尼县', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3554', 'cn', '623023000000', '舟曲县', '', 3, '甘肃省', '甘南藏族自治州', '舟曲县', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3555', 'cn', '623024000000', '迭部县', '', 3, '甘肃省', '甘南藏族自治州', '迭部县', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3556', 'cn', '623025000000', '玛曲县', '', 3, '甘肃省', '甘南藏族自治州', '玛曲县', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3557', 'cn', '623026000000', '碌曲县', '', 3, '甘肃省', '甘南藏族自治州', '碌曲县', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3558', 'cn', '623027000000', '夏河县', '', 3, '甘肃省', '甘南藏族自治州', '夏河县', 0, 1, '623000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3559', 'cn', '630101000000', '市辖区', '', 3, '青海省', '西宁市', '市辖区', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('356', 'cn', '640200000000', '石嘴山市', '', 2, '宁夏回族自治区', '石嘴山市', '', 0, 1, '640000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3560', 'cn', '630102000000', '城东区', '', 3, '青海省', '西宁市', '城东区', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3561', 'cn', '630103000000', '城中区', '', 3, '青海省', '西宁市', '城中区', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3562', 'cn', '630104000000', '城西区', '', 3, '青海省', '西宁市', '城西区', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3563', 'cn', '630105000000', '城北区', '', 3, '青海省', '西宁市', '城北区', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3564', 'cn', '630121000000', '大通回族土族自治县', '', 3, '青海省', '西宁市', '大通回族土族自治县', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3565', 'cn', '630122000000', '湟中县', '', 3, '青海省', '西宁市', '湟中县', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3566', 'cn', '630123000000', '湟源县', '', 3, '青海省', '西宁市', '湟源县', 0, 1, '630100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3567', 'cn', '630202000000', '乐都区', '', 3, '青海省', '海东市', '乐都区', 0, 1, '630200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3568', 'cn', '630203000000', '平安区', '', 3, '青海省', '海东市', '平安区', 0, 1, '630200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3569', 'cn', '630222000000', '民和回族土族自治县', '', 3, '青海省', '海东市', '民和回族土族自治县', 0, 1, '630200000000');
INSERT INTO SYS_NATION_AREA VALUES ('357', 'cn', '640300000000', '吴忠市', '', 2, '宁夏回族自治区', '吴忠市', '', 0, 1, '640000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3570', 'cn', '630223000000', '互助土族自治县', '', 3, '青海省', '海东市', '互助土族自治县', 0, 1, '630200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3571', 'cn', '630224000000', '化隆回族自治县', '', 3, '青海省', '海东市', '化隆回族自治县', 0, 1, '630200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3572', 'cn', '630225000000', '循化撒拉族自治县', '', 3, '青海省', '海东市', '循化撒拉族自治县', 0, 1, '630200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3573', 'cn', '632221000000', '门源回族自治县', '', 3, '青海省', '海北藏族自治州', '门源回族自治县', 0, 1, '632200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3574', 'cn', '632222000000', '祁连县', '', 3, '青海省', '海北藏族自治州', '祁连县', 0, 1, '632200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3575', 'cn', '632223000000', '海晏县', '', 3, '青海省', '海北藏族自治州', '海晏县', 0, 1, '632200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3576', 'cn', '632224000000', '刚察县', '', 3, '青海省', '海北藏族自治州', '刚察县', 0, 1, '632200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3577', 'cn', '632321000000', '同仁县', '', 3, '青海省', '黄南藏族自治州', '同仁县', 0, 1, '632300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3578', 'cn', '632322000000', '尖扎县', '', 3, '青海省', '黄南藏族自治州', '尖扎县', 0, 1, '632300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3579', 'cn', '632323000000', '泽库县', '', 3, '青海省', '黄南藏族自治州', '泽库县', 0, 1, '632300000000');
INSERT INTO SYS_NATION_AREA VALUES ('358', 'cn', '640400000000', '固原市', '', 2, '宁夏回族自治区', '固原市', '', 0, 1, '640000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3580', 'cn', '632324000000', '河南蒙古族自治县', '', 3, '青海省', '黄南藏族自治州', '河南蒙古族自治县', 0, 1, '632300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3581', 'cn', '632521000000', '共和县', '', 3, '青海省', '海南藏族自治州', '共和县', 0, 1, '632500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3582', 'cn', '632522000000', '同德县', '', 3, '青海省', '海南藏族自治州', '同德县', 0, 1, '632500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3583', 'cn', '632523000000', '贵德县', '', 3, '青海省', '海南藏族自治州', '贵德县', 0, 1, '632500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3584', 'cn', '632524000000', '兴海县', '', 3, '青海省', '海南藏族自治州', '兴海县', 0, 1, '632500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3585', 'cn', '632525000000', '贵南县', '', 3, '青海省', '海南藏族自治州', '贵南县', 0, 1, '632500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3586', 'cn', '632621000000', '玛沁县', '', 3, '青海省', '果洛藏族自治州', '玛沁县', 0, 1, '632600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3587', 'cn', '632622000000', '班玛县', '', 3, '青海省', '果洛藏族自治州', '班玛县', 0, 1, '632600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3588', 'cn', '632623000000', '甘德县', '', 3, '青海省', '果洛藏族自治州', '甘德县', 0, 1, '632600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3589', 'cn', '632624000000', '达日县', '', 3, '青海省', '果洛藏族自治州', '达日县', 0, 1, '632600000000');
INSERT INTO SYS_NATION_AREA VALUES ('359', 'cn', '640500000000', '中卫市', '', 2, '宁夏回族自治区', '中卫市', '', 0, 1, '640000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3590', 'cn', '632625000000', '久治县', '', 3, '青海省', '果洛藏族自治州', '久治县', 0, 1, '632600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3591', 'cn', '632626000000', '玛多县', '', 3, '青海省', '果洛藏族自治州', '玛多县', 0, 1, '632600000000');
INSERT INTO SYS_NATION_AREA VALUES ('3592', 'cn', '632701000000', '玉树市', '', 3, '青海省', '玉树藏族自治州', '玉树市', 0, 1, '632700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3593', 'cn', '632722000000', '杂多县', '', 3, '青海省', '玉树藏族自治州', '杂多县', 0, 1, '632700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3594', 'cn', '632723000000', '称多县', '', 3, '青海省', '玉树藏族自治州', '称多县', 0, 1, '632700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3595', 'cn', '632724000000', '治多县', '', 3, '青海省', '玉树藏族自治州', '治多县', 0, 1, '632700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3596', 'cn', '632725000000', '囊谦县', '', 3, '青海省', '玉树藏族自治州', '囊谦县', 0, 1, '632700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3597', 'cn', '632726000000', '曲麻莱县', '', 3, '青海省', '玉树藏族自治州', '曲麻莱县', 0, 1, '632700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3598', 'cn', '632801000000', '格尔木市', '', 3, '青海省', '海西蒙古族藏族自治州', '格尔木市', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3599', 'cn', '632802000000', '德令哈市', '', 3, '青海省', '海西蒙古族藏族自治州', '德令哈市', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('36', 'cn', '130300000000', '秦皇岛市', '', 2, '河北省', '秦皇岛市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('360', 'cn', '650100000000', '乌鲁木齐市', '', 2, '新疆维吾尔自治区', '乌鲁木齐市', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3600', 'cn', '632821000000', '乌兰县', '', 3, '青海省', '海西蒙古族藏族自治州', '乌兰县', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3601', 'cn', '632822000000', '都兰县', '', 3, '青海省', '海西蒙古族藏族自治州', '都兰县', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3602', 'cn', '632823000000', '天峻县', '', 3, '青海省', '海西蒙古族藏族自治州', '天峻县', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3603', 'cn', '632857000000', '大柴旦行政委员会', '', 3, '青海省', '海西蒙古族藏族自治州', '大柴旦行政委员会', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3604', 'cn', '632858000000', '冷湖行政委员会', '', 3, '青海省', '海西蒙古族藏族自治州', '冷湖行政委员会', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3605', 'cn', '632859000000', '茫崖行政委员会', '', 3, '青海省', '海西蒙古族藏族自治州', '茫崖行政委员会', 0, 1, '632800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3606', 'cn', '640101000000', '市辖区', '', 3, '宁夏回族自治区', '银川市', '市辖区', 0, 1, '640100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3607', 'cn', '640104000000', '兴庆区', '', 3, '宁夏回族自治区', '银川市', '兴庆区', 0, 1, '640100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3608', 'cn', '640105000000', '西夏区', '', 3, '宁夏回族自治区', '银川市', '西夏区', 0, 1, '640100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3609', 'cn', '640106000000', '金凤区', '', 3, '宁夏回族自治区', '银川市', '金凤区', 0, 1, '640100000000');
INSERT INTO SYS_NATION_AREA VALUES ('361', 'cn', '650200000000', '克拉玛依市', '', 2, '新疆维吾尔自治区', '克拉玛依市', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3610', 'cn', '640121000000', '永宁县', '', 3, '宁夏回族自治区', '银川市', '永宁县', 0, 1, '640100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3611', 'cn', '640122000000', '贺兰县', '', 3, '宁夏回族自治区', '银川市', '贺兰县', 0, 1, '640100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3612', 'cn', '640181000000', '灵武市', '', 3, '宁夏回族自治区', '银川市', '灵武市', 0, 1, '640100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3613', 'cn', '640201000000', '市辖区', '', 3, '宁夏回族自治区', '石嘴山市', '市辖区', 0, 1, '640200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3614', 'cn', '640202000000', '大武口区', '', 3, '宁夏回族自治区', '石嘴山市', '大武口区', 0, 1, '640200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3615', 'cn', '640205000000', '惠农区', '', 3, '宁夏回族自治区', '石嘴山市', '惠农区', 0, 1, '640200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3616', 'cn', '640221000000', '平罗县', '', 3, '宁夏回族自治区', '石嘴山市', '平罗县', 0, 1, '640200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3617', 'cn', '640301000000', '市辖区', '', 3, '宁夏回族自治区', '吴忠市', '市辖区', 0, 1, '640300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3618', 'cn', '640302000000', '利通区', '', 3, '宁夏回族自治区', '吴忠市', '利通区', 0, 1, '640300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3619', 'cn', '640303000000', '红寺堡区', '', 3, '宁夏回族自治区', '吴忠市', '红寺堡区', 0, 1, '640300000000');
INSERT INTO SYS_NATION_AREA VALUES ('362', 'cn', '650400000000', '吐鲁番市', '', 2, '新疆维吾尔自治区', '吐鲁番市', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3620', 'cn', '640323000000', '盐池县', '', 3, '宁夏回族自治区', '吴忠市', '盐池县', 0, 1, '640300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3621', 'cn', '640324000000', '同心县', '', 3, '宁夏回族自治区', '吴忠市', '同心县', 0, 1, '640300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3622', 'cn', '640381000000', '青铜峡市', '', 3, '宁夏回族自治区', '吴忠市', '青铜峡市', 0, 1, '640300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3623', 'cn', '640401000000', '市辖区', '', 3, '宁夏回族自治区', '固原市', '市辖区', 0, 1, '640400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3624', 'cn', '640402000000', '原州区', '', 3, '宁夏回族自治区', '固原市', '原州区', 0, 1, '640400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3625', 'cn', '640422000000', '西吉县', '', 3, '宁夏回族自治区', '固原市', '西吉县', 0, 1, '640400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3626', 'cn', '640423000000', '隆德县', '', 3, '宁夏回族自治区', '固原市', '隆德县', 0, 1, '640400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3627', 'cn', '640424000000', '泾源县', '', 3, '宁夏回族自治区', '固原市', '泾源县', 0, 1, '640400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3628', 'cn', '640425000000', '彭阳县', '', 3, '宁夏回族自治区', '固原市', '彭阳县', 0, 1, '640400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3629', 'cn', '640501000000', '市辖区', '', 3, '宁夏回族自治区', '中卫市', '市辖区', 0, 1, '640500000000');
INSERT INTO SYS_NATION_AREA VALUES ('363', 'cn', '650500000000', '哈密市', '', 2, '新疆维吾尔自治区', '哈密市', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3630', 'cn', '640502000000', '沙坡头区', '', 3, '宁夏回族自治区', '中卫市', '沙坡头区', 0, 1, '640500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3631', 'cn', '640521000000', '中宁县', '', 3, '宁夏回族自治区', '中卫市', '中宁县', 0, 1, '640500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3632', 'cn', '640522000000', '海原县', '', 3, '宁夏回族自治区', '中卫市', '海原县', 0, 1, '640500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3633', 'cn', '650101000000', '市辖区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '市辖区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3634', 'cn', '650102000000', '天山区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '天山区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3635', 'cn', '650103000000', '沙依巴克区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '沙依巴克区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3636', 'cn', '650104000000', '新市区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '新市区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3637', 'cn', '650105000000', '水磨沟区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '水磨沟区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3638', 'cn', '650106000000', '头屯河区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '头屯河区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3639', 'cn', '650107000000', '达坂城区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '达坂城区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('364', 'cn', '652300000000', '昌吉回族自治州', '', 2, '新疆维吾尔自治区', '昌吉回族自治州', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3640', 'cn', '650109000000', '米东区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '米东区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3641', 'cn', '650121000000', '乌鲁木齐县', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '乌鲁木齐县', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3642', 'cn', '650171000000', '乌鲁木齐经济技术开发区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '乌鲁木齐经济技术开发区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3643', 'cn', '650172000000', '乌鲁木齐高新技术产业开发区', '', 3, '新疆维吾尔自治区', '乌鲁木齐市', '乌鲁木齐高新技术产业开发区', 0, 1, '650100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3644', 'cn', '650201000000', '市辖区', '', 3, '新疆维吾尔自治区', '克拉玛依市', '市辖区', 0, 1, '650200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3645', 'cn', '650202000000', '独山子区', '', 3, '新疆维吾尔自治区', '克拉玛依市', '独山子区', 0, 1, '650200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3646', 'cn', '650203000000', '克拉玛依区', '', 3, '新疆维吾尔自治区', '克拉玛依市', '克拉玛依区', 0, 1, '650200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3647', 'cn', '650204000000', '白碱滩区', '', 3, '新疆维吾尔自治区', '克拉玛依市', '白碱滩区', 0, 1, '650200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3648', 'cn', '650205000000', '乌尔禾区', '', 3, '新疆维吾尔自治区', '克拉玛依市', '乌尔禾区', 0, 1, '650200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3649', 'cn', '650402000000', '高昌区', '', 3, '新疆维吾尔自治区', '吐鲁番市', '高昌区', 0, 1, '650400000000');
INSERT INTO SYS_NATION_AREA VALUES ('365', 'cn', '652700000000', '博尔塔拉蒙古自治州', '', 2, '新疆维吾尔自治区', '博尔塔拉蒙古自治州', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3650', 'cn', '650421000000', '鄯善县', '', 3, '新疆维吾尔自治区', '吐鲁番市', '鄯善县', 0, 1, '650400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3651', 'cn', '650422000000', '托克逊县', '', 3, '新疆维吾尔自治区', '吐鲁番市', '托克逊县', 0, 1, '650400000000');
INSERT INTO SYS_NATION_AREA VALUES ('3652', 'cn', '650502000000', '伊州区', '', 3, '新疆维吾尔自治区', '哈密市', '伊州区', 0, 1, '650500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3653', 'cn', '650521000000', '巴里坤哈萨克自治县', '', 3, '新疆维吾尔自治区', '哈密市', '巴里坤哈萨克自治县', 0, 1, '650500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3654', 'cn', '650522000000', '伊吾县', '', 3, '新疆维吾尔自治区', '哈密市', '伊吾县', 0, 1, '650500000000');
INSERT INTO SYS_NATION_AREA VALUES ('3655', 'cn', '652301000000', '昌吉市', '', 3, '新疆维吾尔自治区', '昌吉回族自治州', '昌吉市', 0, 1, '652300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3656', 'cn', '652302000000', '阜康市', '', 3, '新疆维吾尔自治区', '昌吉回族自治州', '阜康市', 0, 1, '652300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3657', 'cn', '652323000000', '呼图壁县', '', 3, '新疆维吾尔自治区', '昌吉回族自治州', '呼图壁县', 0, 1, '652300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3658', 'cn', '652324000000', '玛纳斯县', '', 3, '新疆维吾尔自治区', '昌吉回族自治州', '玛纳斯县', 0, 1, '652300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3659', 'cn', '652325000000', '奇台县', '', 3, '新疆维吾尔自治区', '昌吉回族自治州', '奇台县', 0, 1, '652300000000');
INSERT INTO SYS_NATION_AREA VALUES ('366', 'cn', '652800000000', '巴音郭楞蒙古自治州', '', 2, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3660', 'cn', '652327000000', '吉木萨尔县', '', 3, '新疆维吾尔自治区', '昌吉回族自治州', '吉木萨尔县', 0, 1, '652300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3661', 'cn', '652328000000', '木垒哈萨克自治县', '', 3, '新疆维吾尔自治区', '昌吉回族自治州', '木垒哈萨克自治县', 0, 1, '652300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3662', 'cn', '652701000000', '博乐市', '', 3, '新疆维吾尔自治区', '博尔塔拉蒙古自治州', '博乐市', 0, 1, '652700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3663', 'cn', '652702000000', '阿拉山口市', '', 3, '新疆维吾尔自治区', '博尔塔拉蒙古自治州', '阿拉山口市', 0, 1, '652700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3664', 'cn', '652722000000', '精河县', '', 3, '新疆维吾尔自治区', '博尔塔拉蒙古自治州', '精河县', 0, 1, '652700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3665', 'cn', '652723000000', '温泉县', '', 3, '新疆维吾尔自治区', '博尔塔拉蒙古自治州', '温泉县', 0, 1, '652700000000');
INSERT INTO SYS_NATION_AREA VALUES ('3666', 'cn', '652801000000', '库尔勒市', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '库尔勒市', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3667', 'cn', '652822000000', '轮台县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '轮台县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3668', 'cn', '652823000000', '尉犁县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '尉犁县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3669', 'cn', '652824000000', '若羌县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '若羌县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('367', 'cn', '652900000000', '阿克苏地区', '', 2, '新疆维吾尔自治区', '阿克苏地区', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3670', 'cn', '652825000000', '且末县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '且末县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3671', 'cn', '652826000000', '焉耆回族自治县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '焉耆回族自治县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3672', 'cn', '652827000000', '和静县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '和静县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3673', 'cn', '652828000000', '和硕县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '和硕县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3674', 'cn', '652829000000', '博湖县', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '博湖县', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3675', 'cn', '652871000000', '库尔勒经济技术开发区', '', 3, '新疆维吾尔自治区', '巴音郭楞蒙古自治州', '库尔勒经济技术开发区', 0, 1, '652800000000');
INSERT INTO SYS_NATION_AREA VALUES ('3676', 'cn', '652901000000', '阿克苏市', '', 3, '新疆维吾尔自治区', '阿克苏地区', '阿克苏市', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3677', 'cn', '652922000000', '温宿县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '温宿县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3678', 'cn', '652923000000', '库车县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '库车县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3679', 'cn', '652924000000', '沙雅县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '沙雅县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('368', 'cn', '653000000000', '克孜勒苏柯尔克孜自治州', '', 2, '新疆维吾尔自治区', '克孜勒苏柯尔克孜自治州', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3680', 'cn', '652925000000', '新和县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '新和县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3681', 'cn', '652926000000', '拜城县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '拜城县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3682', 'cn', '652927000000', '乌什县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '乌什县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3683', 'cn', '652928000000', '阿瓦提县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '阿瓦提县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3684', 'cn', '652929000000', '柯坪县', '', 3, '新疆维吾尔自治区', '阿克苏地区', '柯坪县', 0, 1, '652900000000');
INSERT INTO SYS_NATION_AREA VALUES ('3685', 'cn', '653001000000', '阿图什市', '', 3, '新疆维吾尔自治区', '克孜勒苏柯尔克孜自治州', '阿图什市', 0, 1, '653000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3686', 'cn', '653022000000', '阿克陶县', '', 3, '新疆维吾尔自治区', '克孜勒苏柯尔克孜自治州', '阿克陶县', 0, 1, '653000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3687', 'cn', '653023000000', '阿合奇县', '', 3, '新疆维吾尔自治区', '克孜勒苏柯尔克孜自治州', '阿合奇县', 0, 1, '653000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3688', 'cn', '653024000000', '乌恰县', '', 3, '新疆维吾尔自治区', '克孜勒苏柯尔克孜自治州', '乌恰县', 0, 1, '653000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3689', 'cn', '653101000000', '喀什市', '', 3, '新疆维吾尔自治区', '喀什地区', '喀什市', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('369', 'cn', '653100000000', '喀什地区', '', 2, '新疆维吾尔自治区', '喀什地区', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3690', 'cn', '653121000000', '疏附县', '', 3, '新疆维吾尔自治区', '喀什地区', '疏附县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3691', 'cn', '653122000000', '疏勒县', '', 3, '新疆维吾尔自治区', '喀什地区', '疏勒县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3692', 'cn', '653123000000', '英吉沙县', '', 3, '新疆维吾尔自治区', '喀什地区', '英吉沙县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3693', 'cn', '653124000000', '泽普县', '', 3, '新疆维吾尔自治区', '喀什地区', '泽普县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3694', 'cn', '653125000000', '莎车县', '', 3, '新疆维吾尔自治区', '喀什地区', '莎车县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3695', 'cn', '653126000000', '叶城县', '', 3, '新疆维吾尔自治区', '喀什地区', '叶城县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3696', 'cn', '653127000000', '麦盖提县', '', 3, '新疆维吾尔自治区', '喀什地区', '麦盖提县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3697', 'cn', '653128000000', '岳普湖县', '', 3, '新疆维吾尔自治区', '喀什地区', '岳普湖县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3698', 'cn', '653129000000', '伽师县', '', 3, '新疆维吾尔自治区', '喀什地区', '伽师县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3699', 'cn', '653130000000', '巴楚县', '', 3, '新疆维吾尔自治区', '喀什地区', '巴楚县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('37', 'cn', '130400000000', '邯郸市', '', 2, '河北省', '邯郸市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('370', 'cn', '653200000000', '和田地区', '', 2, '新疆维吾尔自治区', '和田地区', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3700', 'cn', '653131000000', '塔什库尔干塔吉克自治县', '', 3, '新疆维吾尔自治区', '喀什地区', '塔什库尔干塔吉克自治县', 0, 1, '653100000000');
INSERT INTO SYS_NATION_AREA VALUES ('3701', 'cn', '653201000000', '和田市', '', 3, '新疆维吾尔自治区', '和田地区', '和田市', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3702', 'cn', '653221000000', '和田县', '', 3, '新疆维吾尔自治区', '和田地区', '和田县', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3703', 'cn', '653222000000', '墨玉县', '', 3, '新疆维吾尔自治区', '和田地区', '墨玉县', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3704', 'cn', '653223000000', '皮山县', '', 3, '新疆维吾尔自治区', '和田地区', '皮山县', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3705', 'cn', '653224000000', '洛浦县', '', 3, '新疆维吾尔自治区', '和田地区', '洛浦县', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3706', 'cn', '653225000000', '策勒县', '', 3, '新疆维吾尔自治区', '和田地区', '策勒县', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3707', 'cn', '653226000000', '于田县', '', 3, '新疆维吾尔自治区', '和田地区', '于田县', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3708', 'cn', '653227000000', '民丰县', '', 3, '新疆维吾尔自治区', '和田地区', '民丰县', 0, 1, '653200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3709', 'cn', '654002000000', '伊宁市', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '伊宁市', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('371', 'cn', '654000000000', '伊犁哈萨克自治州', '', 2, '新疆维吾尔自治区', '伊犁哈萨克自治州', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3710', 'cn', '654003000000', '奎屯市', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '奎屯市', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3711', 'cn', '654004000000', '霍尔果斯市', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '霍尔果斯市', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3712', 'cn', '654021000000', '伊宁县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '伊宁县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3713', 'cn', '654022000000', '察布查尔锡伯自治县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '察布查尔锡伯自治县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3714', 'cn', '654023000000', '霍城县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '霍城县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3715', 'cn', '654024000000', '巩留县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '巩留县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3716', 'cn', '654025000000', '新源县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '新源县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3717', 'cn', '654026000000', '昭苏县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '昭苏县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3718', 'cn', '654027000000', '特克斯县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '特克斯县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3719', 'cn', '654028000000', '尼勒克县', '', 3, '新疆维吾尔自治区', '伊犁哈萨克自治州', '尼勒克县', 0, 1, '654000000000');
INSERT INTO SYS_NATION_AREA VALUES ('372', 'cn', '654200000000', '塔城地区', '', 2, '新疆维吾尔自治区', '塔城地区', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3720', 'cn', '654201000000', '塔城市', '', 3, '新疆维吾尔自治区', '塔城地区', '塔城市', 0, 1, '654200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3721', 'cn', '654202000000', '乌苏市', '', 3, '新疆维吾尔自治区', '塔城地区', '乌苏市', 0, 1, '654200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3722', 'cn', '654221000000', '额敏县', '', 3, '新疆维吾尔自治区', '塔城地区', '额敏县', 0, 1, '654200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3723', 'cn', '654223000000', '沙湾县', '', 3, '新疆维吾尔自治区', '塔城地区', '沙湾县', 0, 1, '654200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3724', 'cn', '654224000000', '托里县', '', 3, '新疆维吾尔自治区', '塔城地区', '托里县', 0, 1, '654200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3725', 'cn', '654225000000', '裕民县', '', 3, '新疆维吾尔自治区', '塔城地区', '裕民县', 0, 1, '654200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3726', 'cn', '654226000000', '和布克赛尔蒙古自治县', '', 3, '新疆维吾尔自治区', '塔城地区', '和布克赛尔蒙古自治县', 0, 1, '654200000000');
INSERT INTO SYS_NATION_AREA VALUES ('3727', 'cn', '654301000000', '阿勒泰市', '', 3, '新疆维吾尔自治区', '阿勒泰地区', '阿勒泰市', 0, 1, '654300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3728', 'cn', '654321000000', '布尔津县', '', 3, '新疆维吾尔自治区', '阿勒泰地区', '布尔津县', 0, 1, '654300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3729', 'cn', '654322000000', '富蕴县', '', 3, '新疆维吾尔自治区', '阿勒泰地区', '富蕴县', 0, 1, '654300000000');
INSERT INTO SYS_NATION_AREA VALUES ('373', 'cn', '654300000000', '阿勒泰地区', '', 2, '新疆维吾尔自治区', '阿勒泰地区', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3730', 'cn', '654323000000', '福海县', '', 3, '新疆维吾尔自治区', '阿勒泰地区', '福海县', 0, 1, '654300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3731', 'cn', '654324000000', '哈巴河县', '', 3, '新疆维吾尔自治区', '阿勒泰地区', '哈巴河县', 0, 1, '654300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3732', 'cn', '654325000000', '青河县', '', 3, '新疆维吾尔自治区', '阿勒泰地区', '青河县', 0, 1, '654300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3733', 'cn', '654326000000', '吉木乃县', '', 3, '新疆维吾尔自治区', '阿勒泰地区', '吉木乃县', 0, 1, '654300000000');
INSERT INTO SYS_NATION_AREA VALUES ('3734', 'cn', '659001000000', '石河子市', '', 3, '新疆维吾尔自治区', '自治区直辖县级行政区划', '石河子市', 0, 1, '659000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3735', 'cn', '659002000000', '阿拉尔市', '', 3, '新疆维吾尔自治区', '自治区直辖县级行政区划', '阿拉尔市', 0, 1, '659000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3736', 'cn', '659003000000', '图木舒克市', '', 3, '新疆维吾尔自治区', '自治区直辖县级行政区划', '图木舒克市', 0, 1, '659000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3737', 'cn', '659004000000', '五家渠市', '', 3, '新疆维吾尔自治区', '自治区直辖县级行政区划', '五家渠市', 0, 1, '659000000000');
INSERT INTO SYS_NATION_AREA VALUES ('3738', 'cn', '659006000000', '铁门关市', '', 3, '新疆维吾尔自治区', '自治区直辖县级行政区划', '铁门关市', 0, 1, '659000000000');
INSERT INTO SYS_NATION_AREA VALUES ('374', 'cn', '659000000000', '自治区直辖县级行政区划', '', 2, '新疆维吾尔自治区', '自治区直辖县级行政区划', '', 0, 1, '650000000000');
INSERT INTO SYS_NATION_AREA VALUES ('375', 'cn', '110101000000', '东城区', '', 3, '北京市', '市辖区', '东城区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('376', 'cn', '110102000000', '西城区', '', 3, '北京市', '市辖区', '西城区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('377', 'cn', '110105000000', '朝阳区', '', 3, '北京市', '市辖区', '朝阳区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('378', 'cn', '110106000000', '丰台区', '', 3, '北京市', '市辖区', '丰台区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('379', 'cn', '110107000000', '石景山区', '', 3, '北京市', '市辖区', '石景山区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('38', 'cn', '130500000000', '邢台市', '', 2, '河北省', '邢台市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('380', 'cn', '110108000000', '海淀区', '', 3, '北京市', '市辖区', '海淀区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('381', 'cn', '110109000000', '门头沟区', '', 3, '北京市', '市辖区', '门头沟区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('382', 'cn', '110111000000', '房山区', '', 3, '北京市', '市辖区', '房山区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('383', 'cn', '110112000000', '通州区', '', 3, '北京市', '市辖区', '通州区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('384', 'cn', '110113000000', '顺义区', '', 3, '北京市', '市辖区', '顺义区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('385', 'cn', '110114000000', '昌平区', '', 3, '北京市', '市辖区', '昌平区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('386', 'cn', '110115000000', '大兴区', '', 3, '北京市', '市辖区', '大兴区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('387', 'cn', '110116000000', '怀柔区', '', 3, '北京市', '市辖区', '怀柔区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('388', 'cn', '110117000000', '平谷区', '', 3, '北京市', '市辖区', '平谷区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('389', 'cn', '110118000000', '密云区', '', 3, '北京市', '市辖区', '密云区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('39', 'cn', '130600000000', '保定市', '', 2, '河北省', '保定市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('390', 'cn', '110119000000', '延庆区', '', 3, '北京市', '市辖区', '延庆区', 0, 1, '110100000000');
INSERT INTO SYS_NATION_AREA VALUES ('391', 'cn', '120101000000', '和平区', '', 3, '天津市', '市辖区', '和平区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('392', 'cn', '120102000000', '河东区', '', 3, '天津市', '市辖区', '河东区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('393', 'cn', '120103000000', '河西区', '', 3, '天津市', '市辖区', '河西区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('394', 'cn', '120104000000', '南开区', '', 3, '天津市', '市辖区', '南开区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('395', 'cn', '120105000000', '河北区', '', 3, '天津市', '市辖区', '河北区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('396', 'cn', '120106000000', '红桥区', '', 3, '天津市', '市辖区', '红桥区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('397', 'cn', '120110000000', '东丽区', '', 3, '天津市', '市辖区', '东丽区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('398', 'cn', '120111000000', '西青区', '', 3, '天津市', '市辖区', '西青区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('399', 'cn', '120112000000', '津南区', '', 3, '天津市', '市辖区', '津南区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('4', 'cn', '140000000000', '山西省', '', 1, '山西省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('40', 'cn', '130700000000', '张家口市', '', 2, '河北省', '张家口市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('400', 'cn', '120113000000', '北辰区', '', 3, '天津市', '市辖区', '北辰区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('401', 'cn', '120114000000', '武清区', '', 3, '天津市', '市辖区', '武清区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('402', 'cn', '120115000000', '宝坻区', '', 3, '天津市', '市辖区', '宝坻区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('403', 'cn', '120116000000', '滨海新区', '', 3, '天津市', '市辖区', '滨海新区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('404', 'cn', '120117000000', '宁河区', '', 3, '天津市', '市辖区', '宁河区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('405', 'cn', '120118000000', '静海区', '', 3, '天津市', '市辖区', '静海区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('406', 'cn', '120119000000', '蓟州区', '', 3, '天津市', '市辖区', '蓟州区', 0, 1, '310100000000');
INSERT INTO SYS_NATION_AREA VALUES ('407', 'cn', '130101000000', '市辖区', '', 3, '河北省', '石家庄市', '市辖区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('408', 'cn', '130102000000', '长安区', '', 3, '河北省', '石家庄市', '长安区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('409', 'cn', '130104000000', '桥西区', '', 3, '河北省', '石家庄市', '桥西区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('41', 'cn', '130800000000', '承德市', '', 2, '河北省', '承德市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('410', 'cn', '130105000000', '新华区', '', 3, '河北省', '石家庄市', '新华区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('411', 'cn', '130107000000', '井陉矿区', '', 3, '河北省', '石家庄市', '井陉矿区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('412', 'cn', '130108000000', '裕华区', '', 3, '河北省', '石家庄市', '裕华区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('413', 'cn', '130109000000', '藁城区', '', 3, '河北省', '石家庄市', '藁城区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('414', 'cn', '130110000000', '鹿泉区', '', 3, '河北省', '石家庄市', '鹿泉区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('415', 'cn', '130111000000', '栾城区', '', 3, '河北省', '石家庄市', '栾城区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('416', 'cn', '130121000000', '井陉县', '', 3, '河北省', '石家庄市', '井陉县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('417', 'cn', '130123000000', '正定县', '', 3, '河北省', '石家庄市', '正定县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('418', 'cn', '130125000000', '行唐县', '', 3, '河北省', '石家庄市', '行唐县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('419', 'cn', '130126000000', '灵寿县', '', 3, '河北省', '石家庄市', '灵寿县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('42', 'cn', '130900000000', '沧州市', '', 2, '河北省', '沧州市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('420', 'cn', '130127000000', '高邑县', '', 3, '河北省', '石家庄市', '高邑县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('421', 'cn', '130128000000', '深泽县', '', 3, '河北省', '石家庄市', '深泽县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('422', 'cn', '130129000000', '赞皇县', '', 3, '河北省', '石家庄市', '赞皇县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('423', 'cn', '130130000000', '无极县', '', 3, '河北省', '石家庄市', '无极县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('424', 'cn', '130131000000', '平山县', '', 3, '河北省', '石家庄市', '平山县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('425', 'cn', '130132000000', '元氏县', '', 3, '河北省', '石家庄市', '元氏县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('426', 'cn', '130133000000', '赵县', '', 3, '河北省', '石家庄市', '赵县', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('427', 'cn', '130171000000', '石家庄高新技术产业开发区', '', 3, '河北省', '石家庄市', '石家庄高新技术产业开发区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('428', 'cn', '130172000000', '石家庄循环化工园区', '', 3, '河北省', '石家庄市', '石家庄循环化工园区', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('429', 'cn', '130181000000', '辛集市', '', 3, '河北省', '石家庄市', '辛集市', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('43', 'cn', '131000000000', '廊坊市', '', 2, '河北省', '廊坊市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('430', 'cn', '130183000000', '晋州市', '', 3, '河北省', '石家庄市', '晋州市', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('431', 'cn', '130184000000', '新乐市', '', 3, '河北省', '石家庄市', '新乐市', 0, 1, '130100000000');
INSERT INTO SYS_NATION_AREA VALUES ('432', 'cn', '130201000000', '市辖区', '', 3, '河北省', '唐山市', '市辖区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('433', 'cn', '130202000000', '路南区', '', 3, '河北省', '唐山市', '路南区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('434', 'cn', '130203000000', '路北区', '', 3, '河北省', '唐山市', '路北区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('435', 'cn', '130204000000', '古冶区', '', 3, '河北省', '唐山市', '古冶区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('436', 'cn', '130205000000', '开平区', '', 3, '河北省', '唐山市', '开平区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('437', 'cn', '130207000000', '丰南区', '', 3, '河北省', '唐山市', '丰南区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('438', 'cn', '130208000000', '丰润区', '', 3, '河北省', '唐山市', '丰润区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('439', 'cn', '130209000000', '曹妃甸区', '', 3, '河北省', '唐山市', '曹妃甸区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('44', 'cn', '131100000000', '衡水市', '', 2, '河北省', '衡水市', '', 0, 1, '130000000000');
INSERT INTO SYS_NATION_AREA VALUES ('440', 'cn', '130223000000', '滦县', '', 3, '河北省', '唐山市', '滦县', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('441', 'cn', '130224000000', '滦南县', '', 3, '河北省', '唐山市', '滦南县', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('442', 'cn', '130225000000', '乐亭县', '', 3, '河北省', '唐山市', '乐亭县', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('443', 'cn', '130227000000', '迁西县', '', 3, '河北省', '唐山市', '迁西县', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('444', 'cn', '130229000000', '玉田县', '', 3, '河北省', '唐山市', '玉田县', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('445', 'cn', '130271000000', '唐山市芦台经济技术开发区', '', 3, '河北省', '唐山市', '唐山市芦台经济技术开发区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('446', 'cn', '130272000000', '唐山市汉沽管理区', '', 3, '河北省', '唐山市', '唐山市汉沽管理区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('447', 'cn', '130273000000', '唐山高新技术产业开发区', '', 3, '河北省', '唐山市', '唐山高新技术产业开发区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('448', 'cn', '130274000000', '河北唐山海港经济开发区', '', 3, '河北省', '唐山市', '河北唐山海港经济开发区', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('449', 'cn', '130281000000', '遵化市', '', 3, '河北省', '唐山市', '遵化市', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('45', 'cn', '140100000000', '太原市', '', 2, '山西省', '太原市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('450', 'cn', '130283000000', '迁安市', '', 3, '河北省', '唐山市', '迁安市', 0, 1, '130200000000');
INSERT INTO SYS_NATION_AREA VALUES ('451', 'cn', '130301000000', '市辖区', '', 3, '河北省', '秦皇岛市', '市辖区', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('452', 'cn', '130302000000', '海港区', '', 3, '河北省', '秦皇岛市', '海港区', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('453', 'cn', '130303000000', '山海关区', '', 3, '河北省', '秦皇岛市', '山海关区', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('454', 'cn', '130304000000', '北戴河区', '', 3, '河北省', '秦皇岛市', '北戴河区', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('455', 'cn', '130306000000', '抚宁区', '', 3, '河北省', '秦皇岛市', '抚宁区', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('456', 'cn', '130321000000', '青龙满族自治县', '', 3, '河北省', '秦皇岛市', '青龙满族自治县', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('457', 'cn', '130322000000', '昌黎县', '', 3, '河北省', '秦皇岛市', '昌黎县', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('458', 'cn', '130324000000', '卢龙县', '', 3, '河北省', '秦皇岛市', '卢龙县', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('459', 'cn', '130371000000', '秦皇岛市经济技术开发区', '', 3, '河北省', '秦皇岛市', '秦皇岛市经济技术开发区', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('46', 'cn', '140200000000', '大同市', '', 2, '山西省', '大同市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('460', 'cn', '130372000000', '北戴河新区', '', 3, '河北省', '秦皇岛市', '北戴河新区', 0, 1, '130300000000');
INSERT INTO SYS_NATION_AREA VALUES ('461', 'cn', '130401000000', '市辖区', '', 3, '河北省', '邯郸市', '市辖区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('462', 'cn', '130402000000', '邯山区', '', 3, '河北省', '邯郸市', '邯山区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('463', 'cn', '130403000000', '丛台区', '', 3, '河北省', '邯郸市', '丛台区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('464', 'cn', '130404000000', '复兴区', '', 3, '河北省', '邯郸市', '复兴区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('465', 'cn', '130406000000', '峰峰矿区', '', 3, '河北省', '邯郸市', '峰峰矿区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('466', 'cn', '130407000000', '肥乡区', '', 3, '河北省', '邯郸市', '肥乡区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('467', 'cn', '130408000000', '永年区', '', 3, '河北省', '邯郸市', '永年区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('468', 'cn', '130423000000', '临漳县', '', 3, '河北省', '邯郸市', '临漳县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('469', 'cn', '130424000000', '成安县', '', 3, '河北省', '邯郸市', '成安县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('47', 'cn', '140300000000', '阳泉市', '', 2, '山西省', '阳泉市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('470', 'cn', '130425000000', '大名县', '', 3, '河北省', '邯郸市', '大名县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('471', 'cn', '130426000000', '涉县', '', 3, '河北省', '邯郸市', '涉县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('472', 'cn', '130427000000', '磁县', '', 3, '河北省', '邯郸市', '磁县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('473', 'cn', '130430000000', '邱县', '', 3, '河北省', '邯郸市', '邱县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('474', 'cn', '130431000000', '鸡泽县', '', 3, '河北省', '邯郸市', '鸡泽县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('475', 'cn', '130432000000', '广平县', '', 3, '河北省', '邯郸市', '广平县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('476', 'cn', '130433000000', '馆陶县', '', 3, '河北省', '邯郸市', '馆陶县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('477', 'cn', '130434000000', '魏县', '', 3, '河北省', '邯郸市', '魏县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('478', 'cn', '130435000000', '曲周县', '', 3, '河北省', '邯郸市', '曲周县', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('479', 'cn', '130471000000', '邯郸经济技术开发区', '', 3, '河北省', '邯郸市', '邯郸经济技术开发区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('48', 'cn', '140400000000', '长治市', '', 2, '山西省', '长治市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('480', 'cn', '130473000000', '邯郸冀南新区', '', 3, '河北省', '邯郸市', '邯郸冀南新区', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('481', 'cn', '130481000000', '武安市', '', 3, '河北省', '邯郸市', '武安市', 0, 1, '130400000000');
INSERT INTO SYS_NATION_AREA VALUES ('482', 'cn', '130501000000', '市辖区', '', 3, '河北省', '邢台市', '市辖区', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('483', 'cn', '130502000000', '桥东区', '', 3, '河北省', '邢台市', '桥东区', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('484', 'cn', '130503000000', '桥西区', '', 3, '河北省', '邢台市', '桥西区', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('485', 'cn', '130521000000', '邢台县', '', 3, '河北省', '邢台市', '邢台县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('486', 'cn', '130522000000', '临城县', '', 3, '河北省', '邢台市', '临城县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('487', 'cn', '130523000000', '内丘县', '', 3, '河北省', '邢台市', '内丘县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('488', 'cn', '130524000000', '柏乡县', '', 3, '河北省', '邢台市', '柏乡县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('489', 'cn', '130525000000', '隆尧县', '', 3, '河北省', '邢台市', '隆尧县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('49', 'cn', '140500000000', '晋城市', '', 2, '山西省', '晋城市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('490', 'cn', '130526000000', '任县', '', 3, '河北省', '邢台市', '任县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('491', 'cn', '130527000000', '南和县', '', 3, '河北省', '邢台市', '南和县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('492', 'cn', '130528000000', '宁晋县', '', 3, '河北省', '邢台市', '宁晋县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('493', 'cn', '130529000000', '巨鹿县', '', 3, '河北省', '邢台市', '巨鹿县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('494', 'cn', '130530000000', '新河县', '', 3, '河北省', '邢台市', '新河县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('495', 'cn', '130531000000', '广宗县', '', 3, '河北省', '邢台市', '广宗县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('496', 'cn', '130532000000', '平乡县', '', 3, '河北省', '邢台市', '平乡县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('497', 'cn', '130533000000', '威县', '', 3, '河北省', '邢台市', '威县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('498', 'cn', '130534000000', '清河县', '', 3, '河北省', '邢台市', '清河县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('499', 'cn', '130535000000', '临西县', '', 3, '河北省', '邢台市', '临西县', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('5', 'cn', '150000000000', '内蒙古自治区', '', 1, '内蒙古自治区', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('50', 'cn', '140600000000', '朔州市', '', 2, '山西省', '朔州市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('500', 'cn', '130571000000', '河北邢台经济开发区', '', 3, '河北省', '邢台市', '河北邢台经济开发区', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('501', 'cn', '130581000000', '南宫市', '', 3, '河北省', '邢台市', '南宫市', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('502', 'cn', '130582000000', '沙河市', '', 3, '河北省', '邢台市', '沙河市', 0, 1, '130500000000');
INSERT INTO SYS_NATION_AREA VALUES ('503', 'cn', '130601000000', '市辖区', '', 3, '河北省', '保定市', '市辖区', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('504', 'cn', '130602000000', '竞秀区', '', 3, '河北省', '保定市', '竞秀区', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('505', 'cn', '130606000000', '莲池区', '', 3, '河北省', '保定市', '莲池区', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('506', 'cn', '130607000000', '满城区', '', 3, '河北省', '保定市', '满城区', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('507', 'cn', '130608000000', '清苑区', '', 3, '河北省', '保定市', '清苑区', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('508', 'cn', '130609000000', '徐水区', '', 3, '河北省', '保定市', '徐水区', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('509', 'cn', '130623000000', '涞水县', '', 3, '河北省', '保定市', '涞水县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('51', 'cn', '140700000000', '晋中市', '', 2, '山西省', '晋中市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('510', 'cn', '130624000000', '阜平县', '', 3, '河北省', '保定市', '阜平县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('511', 'cn', '130626000000', '定兴县', '', 3, '河北省', '保定市', '定兴县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('512', 'cn', '130627000000', '唐县', '', 3, '河北省', '保定市', '唐县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('513', 'cn', '130628000000', '高阳县', '', 3, '河北省', '保定市', '高阳县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('514', 'cn', '130629000000', '容城县', '', 3, '河北省', '保定市', '容城县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('515', 'cn', '130630000000', '涞源县', '', 3, '河北省', '保定市', '涞源县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('516', 'cn', '130631000000', '望都县', '', 3, '河北省', '保定市', '望都县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('517', 'cn', '130632000000', '安新县', '', 3, '河北省', '保定市', '安新县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('518', 'cn', '130633000000', '易县', '', 3, '河北省', '保定市', '易县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('519', 'cn', '130634000000', '曲阳县', '', 3, '河北省', '保定市', '曲阳县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('52', 'cn', '140800000000', '运城市', '', 2, '山西省', '运城市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('520', 'cn', '130635000000', '蠡县', '', 3, '河北省', '保定市', '蠡县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('521', 'cn', '130636000000', '顺平县', '', 3, '河北省', '保定市', '顺平县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('522', 'cn', '130637000000', '博野县', '', 3, '河北省', '保定市', '博野县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('523', 'cn', '130638000000', '雄县', '', 3, '河北省', '保定市', '雄县', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('524', 'cn', '130671000000', '保定高新技术产业开发区', '', 3, '河北省', '保定市', '保定高新技术产业开发区', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('525', 'cn', '130672000000', '保定白沟新城', '', 3, '河北省', '保定市', '保定白沟新城', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('526', 'cn', '130681000000', '涿州市', '', 3, '河北省', '保定市', '涿州市', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('527', 'cn', '130682000000', '定州市', '', 3, '河北省', '保定市', '定州市', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('528', 'cn', '130683000000', '安国市', '', 3, '河北省', '保定市', '安国市', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('529', 'cn', '130684000000', '高碑店市', '', 3, '河北省', '保定市', '高碑店市', 0, 1, '130600000000');
INSERT INTO SYS_NATION_AREA VALUES ('53', 'cn', '140900000000', '忻州市', '', 2, '山西省', '忻州市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('530', 'cn', '130701000000', '市辖区', '', 3, '河北省', '张家口市', '市辖区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('531', 'cn', '130702000000', '桥东区', '', 3, '河北省', '张家口市', '桥东区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('532', 'cn', '130703000000', '桥西区', '', 3, '河北省', '张家口市', '桥西区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('533', 'cn', '130705000000', '宣化区', '', 3, '河北省', '张家口市', '宣化区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('534', 'cn', '130706000000', '下花园区', '', 3, '河北省', '张家口市', '下花园区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('535', 'cn', '130708000000', '万全区', '', 3, '河北省', '张家口市', '万全区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('536', 'cn', '130709000000', '崇礼区', '', 3, '河北省', '张家口市', '崇礼区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('537', 'cn', '130722000000', '张北县', '', 3, '河北省', '张家口市', '张北县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('538', 'cn', '130723000000', '康保县', '', 3, '河北省', '张家口市', '康保县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('539', 'cn', '130724000000', '沽源县', '', 3, '河北省', '张家口市', '沽源县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('54', 'cn', '141000000000', '临汾市', '', 2, '山西省', '临汾市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('540', 'cn', '130725000000', '尚义县', '', 3, '河北省', '张家口市', '尚义县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('541', 'cn', '130726000000', '蔚县', '', 3, '河北省', '张家口市', '蔚县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('542', 'cn', '130727000000', '阳原县', '', 3, '河北省', '张家口市', '阳原县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('543', 'cn', '130728000000', '怀安县', '', 3, '河北省', '张家口市', '怀安县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('544', 'cn', '130730000000', '怀来县', '', 3, '河北省', '张家口市', '怀来县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('545', 'cn', '130731000000', '涿鹿县', '', 3, '河北省', '张家口市', '涿鹿县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('546', 'cn', '130732000000', '赤城县', '', 3, '河北省', '张家口市', '赤城县', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('547', 'cn', '130771000000', '张家口市高新技术产业开发区', '', 3, '河北省', '张家口市', '张家口市高新技术产业开发区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('548', 'cn', '130772000000', '张家口市察北管理区', '', 3, '河北省', '张家口市', '张家口市察北管理区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('549', 'cn', '130773000000', '张家口市塞北管理区', '', 3, '河北省', '张家口市', '张家口市塞北管理区', 0, 1, '130700000000');
INSERT INTO SYS_NATION_AREA VALUES ('55', 'cn', '141100000000', '吕梁市', '', 2, '山西省', '吕梁市', '', 0, 1, '140000000000');
INSERT INTO SYS_NATION_AREA VALUES ('550', 'cn', '130801000000', '市辖区', '', 3, '河北省', '承德市', '市辖区', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('551', 'cn', '130802000000', '双桥区', '', 3, '河北省', '承德市', '双桥区', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('552', 'cn', '130803000000', '双滦区', '', 3, '河北省', '承德市', '双滦区', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('553', 'cn', '130804000000', '鹰手营子矿区', '', 3, '河北省', '承德市', '鹰手营子矿区', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('554', 'cn', '130821000000', '承德县', '', 3, '河北省', '承德市', '承德县', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('555', 'cn', '130822000000', '兴隆县', '', 3, '河北省', '承德市', '兴隆县', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('556', 'cn', '130824000000', '滦平县', '', 3, '河北省', '承德市', '滦平县', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('557', 'cn', '130825000000', '隆化县', '', 3, '河北省', '承德市', '隆化县', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('558', 'cn', '130826000000', '丰宁满族自治县', '', 3, '河北省', '承德市', '丰宁满族自治县', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('559', 'cn', '130827000000', '宽城满族自治县', '', 3, '河北省', '承德市', '宽城满族自治县', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('56', 'cn', '150100000000', '呼和浩特市', '', 2, '内蒙古自治区', '呼和浩特市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('560', 'cn', '130828000000', '围场满族蒙古族自治县', '', 3, '河北省', '承德市', '围场满族蒙古族自治县', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('561', 'cn', '130871000000', '承德高新技术产业开发区', '', 3, '河北省', '承德市', '承德高新技术产业开发区', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('562', 'cn', '130881000000', '平泉市', '', 3, '河北省', '承德市', '平泉市', 0, 1, '130800000000');
INSERT INTO SYS_NATION_AREA VALUES ('563', 'cn', '130901000000', '市辖区', '', 3, '河北省', '沧州市', '市辖区', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('564', 'cn', '130902000000', '新华区', '', 3, '河北省', '沧州市', '新华区', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('565', 'cn', '130903000000', '运河区', '', 3, '河北省', '沧州市', '运河区', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('566', 'cn', '130921000000', '沧县', '', 3, '河北省', '沧州市', '沧县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('567', 'cn', '130922000000', '青县', '', 3, '河北省', '沧州市', '青县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('568', 'cn', '130923000000', '东光县', '', 3, '河北省', '沧州市', '东光县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('569', 'cn', '130924000000', '海兴县', '', 3, '河北省', '沧州市', '海兴县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('57', 'cn', '150200000000', '包头市', '', 2, '内蒙古自治区', '包头市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('570', 'cn', '130925000000', '盐山县', '', 3, '河北省', '沧州市', '盐山县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('571', 'cn', '130926000000', '肃宁县', '', 3, '河北省', '沧州市', '肃宁县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('572', 'cn', '130927000000', '南皮县', '', 3, '河北省', '沧州市', '南皮县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('573', 'cn', '130928000000', '吴桥县', '', 3, '河北省', '沧州市', '吴桥县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('574', 'cn', '130929000000', '献县', '', 3, '河北省', '沧州市', '献县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('575', 'cn', '130930000000', '孟村回族自治县', '', 3, '河北省', '沧州市', '孟村回族自治县', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('576', 'cn', '130971000000', '河北沧州经济开发区', '', 3, '河北省', '沧州市', '河北沧州经济开发区', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('577', 'cn', '130972000000', '沧州高新技术产业开发区', '', 3, '河北省', '沧州市', '沧州高新技术产业开发区', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('578', 'cn', '130973000000', '沧州渤海新区', '', 3, '河北省', '沧州市', '沧州渤海新区', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('579', 'cn', '130981000000', '泊头市', '', 3, '河北省', '沧州市', '泊头市', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('58', 'cn', '150300000000', '乌海市', '', 2, '内蒙古自治区', '乌海市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('580', 'cn', '130982000000', '任丘市', '', 3, '河北省', '沧州市', '任丘市', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('581', 'cn', '130983000000', '黄骅市', '', 3, '河北省', '沧州市', '黄骅市', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('582', 'cn', '130984000000', '河间市', '', 3, '河北省', '沧州市', '河间市', 0, 1, '130900000000');
INSERT INTO SYS_NATION_AREA VALUES ('583', 'cn', '131001000000', '市辖区', '', 3, '河北省', '廊坊市', '市辖区', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('584', 'cn', '131002000000', '安次区', '', 3, '河北省', '廊坊市', '安次区', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('585', 'cn', '131003000000', '广阳区', '', 3, '河北省', '廊坊市', '广阳区', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('586', 'cn', '131022000000', '固安县', '', 3, '河北省', '廊坊市', '固安县', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('587', 'cn', '131023000000', '永清县', '', 3, '河北省', '廊坊市', '永清县', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('588', 'cn', '131024000000', '香河县', '', 3, '河北省', '廊坊市', '香河县', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('589', 'cn', '131025000000', '大城县', '', 3, '河北省', '廊坊市', '大城县', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('59', 'cn', '150400000000', '赤峰市', '', 2, '内蒙古自治区', '赤峰市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('590', 'cn', '131026000000', '文安县', '', 3, '河北省', '廊坊市', '文安县', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('591', 'cn', '131028000000', '大厂回族自治县', '', 3, '河北省', '廊坊市', '大厂回族自治县', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('592', 'cn', '131071000000', '廊坊经济技术开发区', '', 3, '河北省', '廊坊市', '廊坊经济技术开发区', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('593', 'cn', '131081000000', '霸州市', '', 3, '河北省', '廊坊市', '霸州市', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('594', 'cn', '131082000000', '三河市', '', 3, '河北省', '廊坊市', '三河市', 0, 1, '131000000000');
INSERT INTO SYS_NATION_AREA VALUES ('595', 'cn', '131101000000', '市辖区', '', 3, '河北省', '衡水市', '市辖区', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('596', 'cn', '131102000000', '桃城区', '', 3, '河北省', '衡水市', '桃城区', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('597', 'cn', '131103000000', '冀州区', '', 3, '河北省', '衡水市', '冀州区', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('598', 'cn', '131121000000', '枣强县', '', 3, '河北省', '衡水市', '枣强县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('599', 'cn', '131122000000', '武邑县', '', 3, '河北省', '衡水市', '武邑县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('6', 'cn', '210000000000', '辽宁省', '', 1, '辽宁省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('60', 'cn', '150500000000', '通辽市', '', 2, '内蒙古自治区', '通辽市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('600', 'cn', '131123000000', '武强县', '', 3, '河北省', '衡水市', '武强县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('601', 'cn', '131124000000', '饶阳县', '', 3, '河北省', '衡水市', '饶阳县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('602', 'cn', '131125000000', '安平县', '', 3, '河北省', '衡水市', '安平县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('603', 'cn', '131126000000', '故城县', '', 3, '河北省', '衡水市', '故城县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('604', 'cn', '131127000000', '景县', '', 3, '河北省', '衡水市', '景县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('605', 'cn', '131128000000', '阜城县', '', 3, '河北省', '衡水市', '阜城县', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('606', 'cn', '131171000000', '河北衡水经济开发区', '', 3, '河北省', '衡水市', '河北衡水经济开发区', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('607', 'cn', '131172000000', '衡水滨湖新区', '', 3, '河北省', '衡水市', '衡水滨湖新区', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('608', 'cn', '131182000000', '深州市', '', 3, '河北省', '衡水市', '深州市', 0, 1, '131100000000');
INSERT INTO SYS_NATION_AREA VALUES ('609', 'cn', '140101000000', '市辖区', '', 3, '山西省', '太原市', '市辖区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('61', 'cn', '150600000000', '鄂尔多斯市', '', 2, '内蒙古自治区', '鄂尔多斯市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('610', 'cn', '140105000000', '小店区', '', 3, '山西省', '太原市', '小店区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('611', 'cn', '140106000000', '迎泽区', '', 3, '山西省', '太原市', '迎泽区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('612', 'cn', '140107000000', '杏花岭区', '', 3, '山西省', '太原市', '杏花岭区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('613', 'cn', '140108000000', '尖草坪区', '', 3, '山西省', '太原市', '尖草坪区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('614', 'cn', '140109000000', '万柏林区', '', 3, '山西省', '太原市', '万柏林区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('615', 'cn', '140110000000', '晋源区', '', 3, '山西省', '太原市', '晋源区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('616', 'cn', '140121000000', '清徐县', '', 3, '山西省', '太原市', '清徐县', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('617', 'cn', '140122000000', '阳曲县', '', 3, '山西省', '太原市', '阳曲县', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('618', 'cn', '140123000000', '娄烦县', '', 3, '山西省', '太原市', '娄烦县', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('619', 'cn', '140171000000', '山西转型综合改革示范区', '', 3, '山西省', '太原市', '山西转型综合改革示范区', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('62', 'cn', '150700000000', '呼伦贝尔市', '', 2, '内蒙古自治区', '呼伦贝尔市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('620', 'cn', '140181000000', '古交市', '', 3, '山西省', '太原市', '古交市', 0, 1, '140100000000');
INSERT INTO SYS_NATION_AREA VALUES ('621', 'cn', '140201000000', '市辖区', '', 3, '山西省', '大同市', '市辖区', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('622', 'cn', '140202000000', '城区', '', 3, '山西省', '大同市', '城区', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('623', 'cn', '140203000000', '矿区', '', 3, '山西省', '大同市', '矿区', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('624', 'cn', '140211000000', '南郊区', '', 3, '山西省', '大同市', '南郊区', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('625', 'cn', '140212000000', '新荣区', '', 3, '山西省', '大同市', '新荣区', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('626', 'cn', '140221000000', '阳高县', '', 3, '山西省', '大同市', '阳高县', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('627', 'cn', '140222000000', '天镇县', '', 3, '山西省', '大同市', '天镇县', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('628', 'cn', '140223000000', '广灵县', '', 3, '山西省', '大同市', '广灵县', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('629', 'cn', '140224000000', '灵丘县', '', 3, '山西省', '大同市', '灵丘县', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('63', 'cn', '150800000000', '巴彦淖尔市', '', 2, '内蒙古自治区', '巴彦淖尔市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('630', 'cn', '140225000000', '浑源县', '', 3, '山西省', '大同市', '浑源县', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('631', 'cn', '140226000000', '左云县', '', 3, '山西省', '大同市', '左云县', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('632', 'cn', '140227000000', '大同县', '', 3, '山西省', '大同市', '大同县', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('633', 'cn', '140271000000', '山西大同经济开发区', '', 3, '山西省', '大同市', '山西大同经济开发区', 0, 1, '140200000000');
INSERT INTO SYS_NATION_AREA VALUES ('634', 'cn', '140301000000', '市辖区', '', 3, '山西省', '阳泉市', '市辖区', 0, 1, '140300000000');
INSERT INTO SYS_NATION_AREA VALUES ('635', 'cn', '140302000000', '城区', '', 3, '山西省', '阳泉市', '城区', 0, 1, '140300000000');
INSERT INTO SYS_NATION_AREA VALUES ('636', 'cn', '140303000000', '矿区', '', 3, '山西省', '阳泉市', '矿区', 0, 1, '140300000000');
INSERT INTO SYS_NATION_AREA VALUES ('637', 'cn', '140311000000', '郊区', '', 3, '山西省', '阳泉市', '郊区', 0, 1, '140300000000');
INSERT INTO SYS_NATION_AREA VALUES ('638', 'cn', '140321000000', '平定县', '', 3, '山西省', '阳泉市', '平定县', 0, 1, '140300000000');
INSERT INTO SYS_NATION_AREA VALUES ('639', 'cn', '140322000000', '盂县', '', 3, '山西省', '阳泉市', '盂县', 0, 1, '140300000000');
INSERT INTO SYS_NATION_AREA VALUES ('64', 'cn', '150900000000', '乌兰察布市', '', 2, '内蒙古自治区', '乌兰察布市', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('640', 'cn', '140371000000', '山西阳泉经济开发区', '', 3, '山西省', '阳泉市', '山西阳泉经济开发区', 0, 1, '140300000000');
INSERT INTO SYS_NATION_AREA VALUES ('641', 'cn', '140401000000', '市辖区', '', 3, '山西省', '长治市', '市辖区', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('642', 'cn', '140402000000', '城区', '', 3, '山西省', '长治市', '城区', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('643', 'cn', '140411000000', '郊区', '', 3, '山西省', '长治市', '郊区', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('644', 'cn', '140421000000', '长治县', '', 3, '山西省', '长治市', '长治县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('645', 'cn', '140423000000', '襄垣县', '', 3, '山西省', '长治市', '襄垣县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('646', 'cn', '140424000000', '屯留县', '', 3, '山西省', '长治市', '屯留县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('647', 'cn', '140425000000', '平顺县', '', 3, '山西省', '长治市', '平顺县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('648', 'cn', '140426000000', '黎城县', '', 3, '山西省', '长治市', '黎城县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('649', 'cn', '140427000000', '壶关县', '', 3, '山西省', '长治市', '壶关县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('65', 'cn', '152200000000', '兴安盟', '', 2, '内蒙古自治区', '兴安盟', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('650', 'cn', '140428000000', '长子县', '', 3, '山西省', '长治市', '长子县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('651', 'cn', '140429000000', '武乡县', '', 3, '山西省', '长治市', '武乡县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('652', 'cn', '140430000000', '沁县', '', 3, '山西省', '长治市', '沁县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('653', 'cn', '140431000000', '沁源县', '', 3, '山西省', '长治市', '沁源县', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('654', 'cn', '140471000000', '山西长治高新技术产业园区', '', 3, '山西省', '长治市', '山西长治高新技术产业园区', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('655', 'cn', '140481000000', '潞城市', '', 3, '山西省', '长治市', '潞城市', 0, 1, '140400000000');
INSERT INTO SYS_NATION_AREA VALUES ('656', 'cn', '140501000000', '市辖区', '', 3, '山西省', '晋城市', '市辖区', 0, 1, '140500000000');
INSERT INTO SYS_NATION_AREA VALUES ('657', 'cn', '140502000000', '城区', '', 3, '山西省', '晋城市', '城区', 0, 1, '140500000000');
INSERT INTO SYS_NATION_AREA VALUES ('658', 'cn', '140521000000', '沁水县', '', 3, '山西省', '晋城市', '沁水县', 0, 1, '140500000000');
INSERT INTO SYS_NATION_AREA VALUES ('659', 'cn', '140522000000', '阳城县', '', 3, '山西省', '晋城市', '阳城县', 0, 1, '140500000000');
INSERT INTO SYS_NATION_AREA VALUES ('66', 'cn', '152500000000', '锡林郭勒盟', '', 2, '内蒙古自治区', '锡林郭勒盟', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('660', 'cn', '140524000000', '陵川县', '', 3, '山西省', '晋城市', '陵川县', 0, 1, '140500000000');
INSERT INTO SYS_NATION_AREA VALUES ('661', 'cn', '140525000000', '泽州县', '', 3, '山西省', '晋城市', '泽州县', 0, 1, '140500000000');
INSERT INTO SYS_NATION_AREA VALUES ('662', 'cn', '140581000000', '高平市', '', 3, '山西省', '晋城市', '高平市', 0, 1, '140500000000');
INSERT INTO SYS_NATION_AREA VALUES ('663', 'cn', '140601000000', '市辖区', '', 3, '山西省', '朔州市', '市辖区', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('664', 'cn', '140602000000', '朔城区', '', 3, '山西省', '朔州市', '朔城区', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('665', 'cn', '140603000000', '平鲁区', '', 3, '山西省', '朔州市', '平鲁区', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('666', 'cn', '140621000000', '山阴县', '', 3, '山西省', '朔州市', '山阴县', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('667', 'cn', '140622000000', '应县', '', 3, '山西省', '朔州市', '应县', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('668', 'cn', '140623000000', '右玉县', '', 3, '山西省', '朔州市', '右玉县', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('669', 'cn', '140624000000', '怀仁县', '', 3, '山西省', '朔州市', '怀仁县', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('67', 'cn', '152900000000', '阿拉善盟', '', 2, '内蒙古自治区', '阿拉善盟', '', 0, 1, '150000000000');
INSERT INTO SYS_NATION_AREA VALUES ('670', 'cn', '140671000000', '山西朔州经济开发区', '', 3, '山西省', '朔州市', '山西朔州经济开发区', 0, 1, '140600000000');
INSERT INTO SYS_NATION_AREA VALUES ('671', 'cn', '140701000000', '市辖区', '', 3, '山西省', '晋中市', '市辖区', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('672', 'cn', '140702000000', '榆次区', '', 3, '山西省', '晋中市', '榆次区', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('673', 'cn', '140721000000', '榆社县', '', 3, '山西省', '晋中市', '榆社县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('674', 'cn', '140722000000', '左权县', '', 3, '山西省', '晋中市', '左权县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('675', 'cn', '140723000000', '和顺县', '', 3, '山西省', '晋中市', '和顺县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('676', 'cn', '140724000000', '昔阳县', '', 3, '山西省', '晋中市', '昔阳县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('677', 'cn', '140725000000', '寿阳县', '', 3, '山西省', '晋中市', '寿阳县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('678', 'cn', '140726000000', '太谷县', '', 3, '山西省', '晋中市', '太谷县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('679', 'cn', '140727000000', '祁县', '', 3, '山西省', '晋中市', '祁县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('68', 'cn', '210100000000', '沈阳市', '', 2, '辽宁省', '沈阳市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('680', 'cn', '140728000000', '平遥县', '', 3, '山西省', '晋中市', '平遥县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('681', 'cn', '140729000000', '灵石县', '', 3, '山西省', '晋中市', '灵石县', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('682', 'cn', '140781000000', '介休市', '', 3, '山西省', '晋中市', '介休市', 0, 1, '140700000000');
INSERT INTO SYS_NATION_AREA VALUES ('683', 'cn', '140801000000', '市辖区', '', 3, '山西省', '运城市', '市辖区', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('684', 'cn', '140802000000', '盐湖区', '', 3, '山西省', '运城市', '盐湖区', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('685', 'cn', '140821000000', '临猗县', '', 3, '山西省', '运城市', '临猗县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('686', 'cn', '140822000000', '万荣县', '', 3, '山西省', '运城市', '万荣县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('687', 'cn', '140823000000', '闻喜县', '', 3, '山西省', '运城市', '闻喜县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('688', 'cn', '140824000000', '稷山县', '', 3, '山西省', '运城市', '稷山县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('689', 'cn', '140825000000', '新绛县', '', 3, '山西省', '运城市', '新绛县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('69', 'cn', '210200000000', '大连市', '', 2, '辽宁省', '大连市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('690', 'cn', '140826000000', '绛县', '', 3, '山西省', '运城市', '绛县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('691', 'cn', '140827000000', '垣曲县', '', 3, '山西省', '运城市', '垣曲县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('692', 'cn', '140828000000', '夏县', '', 3, '山西省', '运城市', '夏县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('693', 'cn', '140829000000', '平陆县', '', 3, '山西省', '运城市', '平陆县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('694', 'cn', '140830000000', '芮城县', '', 3, '山西省', '运城市', '芮城县', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('695', 'cn', '140881000000', '永济市', '', 3, '山西省', '运城市', '永济市', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('696', 'cn', '140882000000', '河津市', '', 3, '山西省', '运城市', '河津市', 0, 1, '140800000000');
INSERT INTO SYS_NATION_AREA VALUES ('697', 'cn', '140901000000', '市辖区', '', 3, '山西省', '忻州市', '市辖区', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('698', 'cn', '140902000000', '忻府区', '', 3, '山西省', '忻州市', '忻府区', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('699', 'cn', '140921000000', '定襄县', '', 3, '山西省', '忻州市', '定襄县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('7', 'cn', '220000000000', '吉林省', '', 1, '吉林省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('70', 'cn', '210300000000', '鞍山市', '', 2, '辽宁省', '鞍山市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('700', 'cn', '140922000000', '五台县', '', 3, '山西省', '忻州市', '五台县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('701', 'cn', '140923000000', '代县', '', 3, '山西省', '忻州市', '代县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('702', 'cn', '140924000000', '繁峙县', '', 3, '山西省', '忻州市', '繁峙县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('703', 'cn', '140925000000', '宁武县', '', 3, '山西省', '忻州市', '宁武县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('704', 'cn', '140926000000', '静乐县', '', 3, '山西省', '忻州市', '静乐县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('705', 'cn', '140927000000', '神池县', '', 3, '山西省', '忻州市', '神池县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('706', 'cn', '140928000000', '五寨县', '', 3, '山西省', '忻州市', '五寨县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('707', 'cn', '140929000000', '岢岚县', '', 3, '山西省', '忻州市', '岢岚县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('708', 'cn', '140930000000', '河曲县', '', 3, '山西省', '忻州市', '河曲县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('709', 'cn', '140931000000', '保德县', '', 3, '山西省', '忻州市', '保德县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('71', 'cn', '210400000000', '抚顺市', '', 2, '辽宁省', '抚顺市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('710', 'cn', '140932000000', '偏关县', '', 3, '山西省', '忻州市', '偏关县', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('711', 'cn', '140971000000', '五台山风景名胜区', '', 3, '山西省', '忻州市', '五台山风景名胜区', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('712', 'cn', '140981000000', '原平市', '', 3, '山西省', '忻州市', '原平市', 0, 1, '140900000000');
INSERT INTO SYS_NATION_AREA VALUES ('713', 'cn', '141001000000', '市辖区', '', 3, '山西省', '临汾市', '市辖区', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('714', 'cn', '141002000000', '尧都区', '', 3, '山西省', '临汾市', '尧都区', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('715', 'cn', '141021000000', '曲沃县', '', 3, '山西省', '临汾市', '曲沃县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('716', 'cn', '141022000000', '翼城县', '', 3, '山西省', '临汾市', '翼城县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('717', 'cn', '141023000000', '襄汾县', '', 3, '山西省', '临汾市', '襄汾县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('718', 'cn', '141024000000', '洪洞县', '', 3, '山西省', '临汾市', '洪洞县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('719', 'cn', '141025000000', '古县', '', 3, '山西省', '临汾市', '古县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('72', 'cn', '210500000000', '本溪市', '', 2, '辽宁省', '本溪市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('720', 'cn', '141026000000', '安泽县', '', 3, '山西省', '临汾市', '安泽县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('721', 'cn', '141027000000', '浮山县', '', 3, '山西省', '临汾市', '浮山县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('722', 'cn', '141028000000', '吉县', '', 3, '山西省', '临汾市', '吉县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('723', 'cn', '141029000000', '乡宁县', '', 3, '山西省', '临汾市', '乡宁县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('724', 'cn', '141030000000', '大宁县', '', 3, '山西省', '临汾市', '大宁县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('725', 'cn', '141031000000', '隰县', '', 3, '山西省', '临汾市', '隰县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('726', 'cn', '141032000000', '永和县', '', 3, '山西省', '临汾市', '永和县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('727', 'cn', '141033000000', '蒲县', '', 3, '山西省', '临汾市', '蒲县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('728', 'cn', '141034000000', '汾西县', '', 3, '山西省', '临汾市', '汾西县', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('729', 'cn', '141081000000', '侯马市', '', 3, '山西省', '临汾市', '侯马市', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('73', 'cn', '210600000000', '丹东市', '', 2, '辽宁省', '丹东市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('730', 'cn', '141082000000', '霍州市', '', 3, '山西省', '临汾市', '霍州市', 0, 1, '141000000000');
INSERT INTO SYS_NATION_AREA VALUES ('731', 'cn', '141101000000', '市辖区', '', 3, '山西省', '吕梁市', '市辖区', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('732', 'cn', '141102000000', '离石区', '', 3, '山西省', '吕梁市', '离石区', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('733', 'cn', '141121000000', '文水县', '', 3, '山西省', '吕梁市', '文水县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('734', 'cn', '141122000000', '交城县', '', 3, '山西省', '吕梁市', '交城县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('735', 'cn', '141123000000', '兴县', '', 3, '山西省', '吕梁市', '兴县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('736', 'cn', '141124000000', '临县', '', 3, '山西省', '吕梁市', '临县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('737', 'cn', '141125000000', '柳林县', '', 3, '山西省', '吕梁市', '柳林县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('738', 'cn', '141126000000', '石楼县', '', 3, '山西省', '吕梁市', '石楼县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('739', 'cn', '141127000000', '岚县', '', 3, '山西省', '吕梁市', '岚县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('74', 'cn', '210700000000', '锦州市', '', 2, '辽宁省', '锦州市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('740', 'cn', '141128000000', '方山县', '', 3, '山西省', '吕梁市', '方山县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('741', 'cn', '141129000000', '中阳县', '', 3, '山西省', '吕梁市', '中阳县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('742', 'cn', '141130000000', '交口县', '', 3, '山西省', '吕梁市', '交口县', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('743', 'cn', '141181000000', '孝义市', '', 3, '山西省', '吕梁市', '孝义市', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('744', 'cn', '141182000000', '汾阳市', '', 3, '山西省', '吕梁市', '汾阳市', 0, 1, '141100000000');
INSERT INTO SYS_NATION_AREA VALUES ('745', 'cn', '150101000000', '市辖区', '', 3, '内蒙古自治区', '呼和浩特市', '市辖区', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('746', 'cn', '150102000000', '新城区', '', 3, '内蒙古自治区', '呼和浩特市', '新城区', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('747', 'cn', '150103000000', '回民区', '', 3, '内蒙古自治区', '呼和浩特市', '回民区', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('748', 'cn', '150104000000', '玉泉区', '', 3, '内蒙古自治区', '呼和浩特市', '玉泉区', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('749', 'cn', '150105000000', '赛罕区', '', 3, '内蒙古自治区', '呼和浩特市', '赛罕区', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('75', 'cn', '210800000000', '营口市', '', 2, '辽宁省', '营口市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('750', 'cn', '150121000000', '土默特左旗', '', 3, '内蒙古自治区', '呼和浩特市', '土默特左旗', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('751', 'cn', '150122000000', '托克托县', '', 3, '内蒙古自治区', '呼和浩特市', '托克托县', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('752', 'cn', '150123000000', '和林格尔县', '', 3, '内蒙古自治区', '呼和浩特市', '和林格尔县', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('753', 'cn', '150124000000', '清水河县', '', 3, '内蒙古自治区', '呼和浩特市', '清水河县', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('754', 'cn', '150125000000', '武川县', '', 3, '内蒙古自治区', '呼和浩特市', '武川县', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('755', 'cn', '150171000000', '呼和浩特金海工业园区', '', 3, '内蒙古自治区', '呼和浩特市', '呼和浩特金海工业园区', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('756', 'cn', '150172000000', '呼和浩特经济技术开发区', '', 3, '内蒙古自治区', '呼和浩特市', '呼和浩特经济技术开发区', 0, 1, '150100000000');
INSERT INTO SYS_NATION_AREA VALUES ('757', 'cn', '150201000000', '市辖区', '', 3, '内蒙古自治区', '包头市', '市辖区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('758', 'cn', '150202000000', '东河区', '', 3, '内蒙古自治区', '包头市', '东河区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('759', 'cn', '150203000000', '昆都仑区', '', 3, '内蒙古自治区', '包头市', '昆都仑区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('76', 'cn', '210900000000', '阜新市', '', 2, '辽宁省', '阜新市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('760', 'cn', '150204000000', '青山区', '', 3, '内蒙古自治区', '包头市', '青山区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('761', 'cn', '150205000000', '石拐区', '', 3, '内蒙古自治区', '包头市', '石拐区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('762', 'cn', '150206000000', '白云鄂博矿区', '', 3, '内蒙古自治区', '包头市', '白云鄂博矿区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('763', 'cn', '150207000000', '九原区', '', 3, '内蒙古自治区', '包头市', '九原区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('764', 'cn', '150221000000', '土默特右旗', '', 3, '内蒙古自治区', '包头市', '土默特右旗', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('765', 'cn', '150222000000', '固阳县', '', 3, '内蒙古自治区', '包头市', '固阳县', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('766', 'cn', '150223000000', '达尔罕茂明安联合旗', '', 3, '内蒙古自治区', '包头市', '达尔罕茂明安联合旗', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('767', 'cn', '150271000000', '包头稀土高新技术产业开发区', '', 3, '内蒙古自治区', '包头市', '包头稀土高新技术产业开发区', 0, 1, '150200000000');
INSERT INTO SYS_NATION_AREA VALUES ('768', 'cn', '150301000000', '市辖区', '', 3, '内蒙古自治区', '乌海市', '市辖区', 0, 1, '150300000000');
INSERT INTO SYS_NATION_AREA VALUES ('769', 'cn', '150302000000', '海勃湾区', '', 3, '内蒙古自治区', '乌海市', '海勃湾区', 0, 1, '150300000000');
INSERT INTO SYS_NATION_AREA VALUES ('77', 'cn', '211000000000', '辽阳市', '', 2, '辽宁省', '辽阳市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('770', 'cn', '150303000000', '海南区', '', 3, '内蒙古自治区', '乌海市', '海南区', 0, 1, '150300000000');
INSERT INTO SYS_NATION_AREA VALUES ('771', 'cn', '150304000000', '乌达区', '', 3, '内蒙古自治区', '乌海市', '乌达区', 0, 1, '150300000000');
INSERT INTO SYS_NATION_AREA VALUES ('772', 'cn', '150401000000', '市辖区', '', 3, '内蒙古自治区', '赤峰市', '市辖区', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('773', 'cn', '150402000000', '红山区', '', 3, '内蒙古自治区', '赤峰市', '红山区', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('774', 'cn', '150403000000', '元宝山区', '', 3, '内蒙古自治区', '赤峰市', '元宝山区', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('775', 'cn', '150404000000', '松山区', '', 3, '内蒙古自治区', '赤峰市', '松山区', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('776', 'cn', '150421000000', '阿鲁科尔沁旗', '', 3, '内蒙古自治区', '赤峰市', '阿鲁科尔沁旗', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('777', 'cn', '150422000000', '巴林左旗', '', 3, '内蒙古自治区', '赤峰市', '巴林左旗', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('778', 'cn', '150423000000', '巴林右旗', '', 3, '内蒙古自治区', '赤峰市', '巴林右旗', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('779', 'cn', '150424000000', '林西县', '', 3, '内蒙古自治区', '赤峰市', '林西县', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('78', 'cn', '211100000000', '盘锦市', '', 2, '辽宁省', '盘锦市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('780', 'cn', '150425000000', '克什克腾旗', '', 3, '内蒙古自治区', '赤峰市', '克什克腾旗', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('781', 'cn', '150426000000', '翁牛特旗', '', 3, '内蒙古自治区', '赤峰市', '翁牛特旗', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('782', 'cn', '150428000000', '喀喇沁旗', '', 3, '内蒙古自治区', '赤峰市', '喀喇沁旗', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('783', 'cn', '150429000000', '宁城县', '', 3, '内蒙古自治区', '赤峰市', '宁城县', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('784', 'cn', '150430000000', '敖汉旗', '', 3, '内蒙古自治区', '赤峰市', '敖汉旗', 0, 1, '150400000000');
INSERT INTO SYS_NATION_AREA VALUES ('785', 'cn', '150501000000', '市辖区', '', 3, '内蒙古自治区', '通辽市', '市辖区', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('786', 'cn', '150502000000', '科尔沁区', '', 3, '内蒙古自治区', '通辽市', '科尔沁区', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('787', 'cn', '150521000000', '科尔沁左翼中旗', '', 3, '内蒙古自治区', '通辽市', '科尔沁左翼中旗', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('788', 'cn', '150522000000', '科尔沁左翼后旗', '', 3, '内蒙古自治区', '通辽市', '科尔沁左翼后旗', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('789', 'cn', '150523000000', '开鲁县', '', 3, '内蒙古自治区', '通辽市', '开鲁县', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('79', 'cn', '211200000000', '铁岭市', '', 2, '辽宁省', '铁岭市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('790', 'cn', '150524000000', '库伦旗', '', 3, '内蒙古自治区', '通辽市', '库伦旗', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('791', 'cn', '150525000000', '奈曼旗', '', 3, '内蒙古自治区', '通辽市', '奈曼旗', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('792', 'cn', '150526000000', '扎鲁特旗', '', 3, '内蒙古自治区', '通辽市', '扎鲁特旗', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('793', 'cn', '150571000000', '通辽经济技术开发区', '', 3, '内蒙古自治区', '通辽市', '通辽经济技术开发区', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('794', 'cn', '150581000000', '霍林郭勒市', '', 3, '内蒙古自治区', '通辽市', '霍林郭勒市', 0, 1, '150500000000');
INSERT INTO SYS_NATION_AREA VALUES ('795', 'cn', '150601000000', '市辖区', '', 3, '内蒙古自治区', '鄂尔多斯市', '市辖区', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('796', 'cn', '150602000000', '东胜区', '', 3, '内蒙古自治区', '鄂尔多斯市', '东胜区', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('797', 'cn', '150603000000', '康巴什区', '', 3, '内蒙古自治区', '鄂尔多斯市', '康巴什区', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('798', 'cn', '150621000000', '达拉特旗', '', 3, '内蒙古自治区', '鄂尔多斯市', '达拉特旗', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('799', 'cn', '150622000000', '准格尔旗', '', 3, '内蒙古自治区', '鄂尔多斯市', '准格尔旗', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('8', 'cn', '230000000000', '黑龙江省', '', 1, '黑龙江省', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('80', 'cn', '211300000000', '朝阳市', '', 2, '辽宁省', '朝阳市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('800', 'cn', '150623000000', '鄂托克前旗', '', 3, '内蒙古自治区', '鄂尔多斯市', '鄂托克前旗', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('801', 'cn', '150624000000', '鄂托克旗', '', 3, '内蒙古自治区', '鄂尔多斯市', '鄂托克旗', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('802', 'cn', '150625000000', '杭锦旗', '', 3, '内蒙古自治区', '鄂尔多斯市', '杭锦旗', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('803', 'cn', '150626000000', '乌审旗', '', 3, '内蒙古自治区', '鄂尔多斯市', '乌审旗', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('804', 'cn', '150627000000', '伊金霍洛旗', '', 3, '内蒙古自治区', '鄂尔多斯市', '伊金霍洛旗', 0, 1, '150600000000');
INSERT INTO SYS_NATION_AREA VALUES ('805', 'cn', '150701000000', '市辖区', '', 3, '内蒙古自治区', '呼伦贝尔市', '市辖区', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('806', 'cn', '150702000000', '海拉尔区', '', 3, '内蒙古自治区', '呼伦贝尔市', '海拉尔区', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('807', 'cn', '150703000000', '扎赉诺尔区', '', 3, '内蒙古自治区', '呼伦贝尔市', '扎赉诺尔区', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('808', 'cn', '150721000000', '阿荣旗', '', 3, '内蒙古自治区', '呼伦贝尔市', '阿荣旗', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('809', 'cn', '150722000000', '莫力达瓦达斡尔族自治旗', '', 3, '内蒙古自治区', '呼伦贝尔市', '莫力达瓦达斡尔族自治旗', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('81', 'cn', '211400000000', '葫芦岛市', '', 2, '辽宁省', '葫芦岛市', '', 0, 1, '210000000000');
INSERT INTO SYS_NATION_AREA VALUES ('810', 'cn', '150723000000', '鄂伦春自治旗', '', 3, '内蒙古自治区', '呼伦贝尔市', '鄂伦春自治旗', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('811', 'cn', '150724000000', '鄂温克族自治旗', '', 3, '内蒙古自治区', '呼伦贝尔市', '鄂温克族自治旗', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('812', 'cn', '150725000000', '陈巴尔虎旗', '', 3, '内蒙古自治区', '呼伦贝尔市', '陈巴尔虎旗', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('813', 'cn', '150726000000', '新巴尔虎左旗', '', 3, '内蒙古自治区', '呼伦贝尔市', '新巴尔虎左旗', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('814', 'cn', '150727000000', '新巴尔虎右旗', '', 3, '内蒙古自治区', '呼伦贝尔市', '新巴尔虎右旗', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('815', 'cn', '150781000000', '满洲里市', '', 3, '内蒙古自治区', '呼伦贝尔市', '满洲里市', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('816', 'cn', '150782000000', '牙克石市', '', 3, '内蒙古自治区', '呼伦贝尔市', '牙克石市', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('817', 'cn', '150783000000', '扎兰屯市', '', 3, '内蒙古自治区', '呼伦贝尔市', '扎兰屯市', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('818', 'cn', '150784000000', '额尔古纳市', '', 3, '内蒙古自治区', '呼伦贝尔市', '额尔古纳市', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('819', 'cn', '150785000000', '根河市', '', 3, '内蒙古自治区', '呼伦贝尔市', '根河市', 0, 1, '150700000000');
INSERT INTO SYS_NATION_AREA VALUES ('82', 'cn', '220100000000', '长春市', '', 2, '吉林省', '长春市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('820', 'cn', '150801000000', '市辖区', '', 3, '内蒙古自治区', '巴彦淖尔市', '市辖区', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('821', 'cn', '150802000000', '临河区', '', 3, '内蒙古自治区', '巴彦淖尔市', '临河区', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('822', 'cn', '150821000000', '五原县', '', 3, '内蒙古自治区', '巴彦淖尔市', '五原县', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('823', 'cn', '150822000000', '磴口县', '', 3, '内蒙古自治区', '巴彦淖尔市', '磴口县', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('824', 'cn', '150823000000', '乌拉特前旗', '', 3, '内蒙古自治区', '巴彦淖尔市', '乌拉特前旗', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('825', 'cn', '150824000000', '乌拉特中旗', '', 3, '内蒙古自治区', '巴彦淖尔市', '乌拉特中旗', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('826', 'cn', '150825000000', '乌拉特后旗', '', 3, '内蒙古自治区', '巴彦淖尔市', '乌拉特后旗', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('827', 'cn', '150826000000', '杭锦后旗', '', 3, '内蒙古自治区', '巴彦淖尔市', '杭锦后旗', 0, 1, '150800000000');
INSERT INTO SYS_NATION_AREA VALUES ('828', 'cn', '150901000000', '市辖区', '', 3, '内蒙古自治区', '乌兰察布市', '市辖区', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('829', 'cn', '150902000000', '集宁区', '', 3, '内蒙古自治区', '乌兰察布市', '集宁区', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('83', 'cn', '220200000000', '吉林市', '', 2, '吉林省', '吉林市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('830', 'cn', '150921000000', '卓资县', '', 3, '内蒙古自治区', '乌兰察布市', '卓资县', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('831', 'cn', '150922000000', '化德县', '', 3, '内蒙古自治区', '乌兰察布市', '化德县', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('832', 'cn', '150923000000', '商都县', '', 3, '内蒙古自治区', '乌兰察布市', '商都县', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('833', 'cn', '150924000000', '兴和县', '', 3, '内蒙古自治区', '乌兰察布市', '兴和县', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('834', 'cn', '150925000000', '凉城县', '', 3, '内蒙古自治区', '乌兰察布市', '凉城县', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('835', 'cn', '150926000000', '察哈尔右翼前旗', '', 3, '内蒙古自治区', '乌兰察布市', '察哈尔右翼前旗', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('836', 'cn', '150927000000', '察哈尔右翼中旗', '', 3, '内蒙古自治区', '乌兰察布市', '察哈尔右翼中旗', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('837', 'cn', '150928000000', '察哈尔右翼后旗', '', 3, '内蒙古自治区', '乌兰察布市', '察哈尔右翼后旗', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('838', 'cn', '150929000000', '四子王旗', '', 3, '内蒙古自治区', '乌兰察布市', '四子王旗', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('839', 'cn', '150981000000', '丰镇市', '', 3, '内蒙古自治区', '乌兰察布市', '丰镇市', 0, 1, '150900000000');
INSERT INTO SYS_NATION_AREA VALUES ('84', 'cn', '220300000000', '四平市', '', 2, '吉林省', '四平市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('840', 'cn', '152201000000', '乌兰浩特市', '', 3, '内蒙古自治区', '兴安盟', '乌兰浩特市', 0, 1, '152200000000');
INSERT INTO SYS_NATION_AREA VALUES ('841', 'cn', '152202000000', '阿尔山市', '', 3, '内蒙古自治区', '兴安盟', '阿尔山市', 0, 1, '152200000000');
INSERT INTO SYS_NATION_AREA VALUES ('842', 'cn', '152221000000', '科尔沁右翼前旗', '', 3, '内蒙古自治区', '兴安盟', '科尔沁右翼前旗', 0, 1, '152200000000');
INSERT INTO SYS_NATION_AREA VALUES ('843', 'cn', '152222000000', '科尔沁右翼中旗', '', 3, '内蒙古自治区', '兴安盟', '科尔沁右翼中旗', 0, 1, '152200000000');
INSERT INTO SYS_NATION_AREA VALUES ('844', 'cn', '152223000000', '扎赉特旗', '', 3, '内蒙古自治区', '兴安盟', '扎赉特旗', 0, 1, '152200000000');
INSERT INTO SYS_NATION_AREA VALUES ('845', 'cn', '152224000000', '突泉县', '', 3, '内蒙古自治区', '兴安盟', '突泉县', 0, 1, '152200000000');
INSERT INTO SYS_NATION_AREA VALUES ('846', 'cn', '152501000000', '二连浩特市', '', 3, '内蒙古自治区', '锡林郭勒盟', '二连浩特市', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('847', 'cn', '152502000000', '锡林浩特市', '', 3, '内蒙古自治区', '锡林郭勒盟', '锡林浩特市', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('848', 'cn', '152522000000', '阿巴嘎旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '阿巴嘎旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('849', 'cn', '152523000000', '苏尼特左旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '苏尼特左旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('85', 'cn', '220400000000', '辽源市', '', 2, '吉林省', '辽源市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('850', 'cn', '152524000000', '苏尼特右旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '苏尼特右旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('851', 'cn', '152525000000', '东乌珠穆沁旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '东乌珠穆沁旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('852', 'cn', '152526000000', '西乌珠穆沁旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '西乌珠穆沁旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('853', 'cn', '152527000000', '太仆寺旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '太仆寺旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('854', 'cn', '152528000000', '镶黄旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '镶黄旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('855', 'cn', '152529000000', '正镶白旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '正镶白旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('856', 'cn', '152530000000', '正蓝旗', '', 3, '内蒙古自治区', '锡林郭勒盟', '正蓝旗', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('857', 'cn', '152531000000', '多伦县', '', 3, '内蒙古自治区', '锡林郭勒盟', '多伦县', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('858', 'cn', '152571000000', '乌拉盖管委会', '', 3, '内蒙古自治区', '锡林郭勒盟', '乌拉盖管委会', 0, 1, '152500000000');
INSERT INTO SYS_NATION_AREA VALUES ('859', 'cn', '152921000000', '阿拉善左旗', '', 3, '内蒙古自治区', '阿拉善盟', '阿拉善左旗', 0, 1, '152900000000');
INSERT INTO SYS_NATION_AREA VALUES ('86', 'cn', '220500000000', '通化市', '', 2, '吉林省', '通化市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('860', 'cn', '152922000000', '阿拉善右旗', '', 3, '内蒙古自治区', '阿拉善盟', '阿拉善右旗', 0, 1, '152900000000');
INSERT INTO SYS_NATION_AREA VALUES ('861', 'cn', '152923000000', '额济纳旗', '', 3, '内蒙古自治区', '阿拉善盟', '额济纳旗', 0, 1, '152900000000');
INSERT INTO SYS_NATION_AREA VALUES ('862', 'cn', '152971000000', '内蒙古阿拉善经济开发区', '', 3, '内蒙古自治区', '阿拉善盟', '内蒙古阿拉善经济开发区', 0, 1, '152900000000');
INSERT INTO SYS_NATION_AREA VALUES ('863', 'cn', '210101000000', '市辖区', '', 3, '辽宁省', '沈阳市', '市辖区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('864', 'cn', '210102000000', '和平区', '', 3, '辽宁省', '沈阳市', '和平区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('865', 'cn', '210103000000', '沈河区', '', 3, '辽宁省', '沈阳市', '沈河区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('866', 'cn', '210104000000', '大东区', '', 3, '辽宁省', '沈阳市', '大东区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('867', 'cn', '210105000000', '皇姑区', '', 3, '辽宁省', '沈阳市', '皇姑区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('868', 'cn', '210106000000', '铁西区', '', 3, '辽宁省', '沈阳市', '铁西区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('869', 'cn', '210111000000', '苏家屯区', '', 3, '辽宁省', '沈阳市', '苏家屯区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('87', 'cn', '220600000000', '白山市', '', 2, '吉林省', '白山市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('870', 'cn', '210112000000', '浑南区', '', 3, '辽宁省', '沈阳市', '浑南区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('871', 'cn', '210113000000', '沈北新区', '', 3, '辽宁省', '沈阳市', '沈北新区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('872', 'cn', '210114000000', '于洪区', '', 3, '辽宁省', '沈阳市', '于洪区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('873', 'cn', '210115000000', '辽中区', '', 3, '辽宁省', '沈阳市', '辽中区', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('874', 'cn', '210123000000', '康平县', '', 3, '辽宁省', '沈阳市', '康平县', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('875', 'cn', '210124000000', '法库县', '', 3, '辽宁省', '沈阳市', '法库县', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('876', 'cn', '210181000000', '新民市', '', 3, '辽宁省', '沈阳市', '新民市', 0, 1, '210100000000');
INSERT INTO SYS_NATION_AREA VALUES ('877', 'cn', '210201000000', '市辖区', '', 3, '辽宁省', '大连市', '市辖区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('878', 'cn', '210202000000', '中山区', '', 3, '辽宁省', '大连市', '中山区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('879', 'cn', '210203000000', '西岗区', '', 3, '辽宁省', '大连市', '西岗区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('88', 'cn', '220700000000', '松原市', '', 2, '吉林省', '松原市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('880', 'cn', '210204000000', '沙河口区', '', 3, '辽宁省', '大连市', '沙河口区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('881', 'cn', '210211000000', '甘井子区', '', 3, '辽宁省', '大连市', '甘井子区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('882', 'cn', '210212000000', '旅顺口区', '', 3, '辽宁省', '大连市', '旅顺口区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('883', 'cn', '210213000000', '金州区', '', 3, '辽宁省', '大连市', '金州区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('884', 'cn', '210214000000', '普兰店区', '', 3, '辽宁省', '大连市', '普兰店区', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('885', 'cn', '210224000000', '长海县', '', 3, '辽宁省', '大连市', '长海县', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('886', 'cn', '210281000000', '瓦房店市', '', 3, '辽宁省', '大连市', '瓦房店市', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('887', 'cn', '210283000000', '庄河市', '', 3, '辽宁省', '大连市', '庄河市', 0, 1, '210200000000');
INSERT INTO SYS_NATION_AREA VALUES ('888', 'cn', '210301000000', '市辖区', '', 3, '辽宁省', '鞍山市', '市辖区', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('889', 'cn', '210302000000', '铁东区', '', 3, '辽宁省', '鞍山市', '铁东区', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('89', 'cn', '220800000000', '白城市', '', 2, '吉林省', '白城市', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('890', 'cn', '210303000000', '铁西区', '', 3, '辽宁省', '鞍山市', '铁西区', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('891', 'cn', '210304000000', '立山区', '', 3, '辽宁省', '鞍山市', '立山区', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('892', 'cn', '210311000000', '千山区', '', 3, '辽宁省', '鞍山市', '千山区', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('893', 'cn', '210321000000', '台安县', '', 3, '辽宁省', '鞍山市', '台安县', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('894', 'cn', '210323000000', '岫岩满族自治县', '', 3, '辽宁省', '鞍山市', '岫岩满族自治县', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('895', 'cn', '210381000000', '海城市', '', 3, '辽宁省', '鞍山市', '海城市', 0, 1, '210300000000');
INSERT INTO SYS_NATION_AREA VALUES ('896', 'cn', '210401000000', '市辖区', '', 3, '辽宁省', '抚顺市', '市辖区', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('897', 'cn', '210402000000', '新抚区', '', 3, '辽宁省', '抚顺市', '新抚区', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('898', 'cn', '210403000000', '东洲区', '', 3, '辽宁省', '抚顺市', '东洲区', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('899', 'cn', '210404000000', '望花区', '', 3, '辽宁省', '抚顺市', '望花区', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('9', 'cn', '310000000000', '上海市', '', 1, '上海市', '', '', 0, 1, '0');
INSERT INTO SYS_NATION_AREA VALUES ('90', 'cn', '222400000000', '延边朝鲜族自治州', '', 2, '吉林省', '延边朝鲜族自治州', '', 0, 1, '220000000000');
INSERT INTO SYS_NATION_AREA VALUES ('900', 'cn', '210411000000', '顺城区', '', 3, '辽宁省', '抚顺市', '顺城区', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('901', 'cn', '210421000000', '抚顺县', '', 3, '辽宁省', '抚顺市', '抚顺县', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('902', 'cn', '210422000000', '新宾满族自治县', '', 3, '辽宁省', '抚顺市', '新宾满族自治县', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('903', 'cn', '210423000000', '清原满族自治县', '', 3, '辽宁省', '抚顺市', '清原满族自治县', 0, 1, '210400000000');
INSERT INTO SYS_NATION_AREA VALUES ('904', 'cn', '210501000000', '市辖区', '', 3, '辽宁省', '本溪市', '市辖区', 0, 1, '210500000000');
INSERT INTO SYS_NATION_AREA VALUES ('905', 'cn', '210502000000', '平山区', '', 3, '辽宁省', '本溪市', '平山区', 0, 1, '210500000000');
INSERT INTO SYS_NATION_AREA VALUES ('906', 'cn', '210503000000', '溪湖区', '', 3, '辽宁省', '本溪市', '溪湖区', 0, 1, '210500000000');
INSERT INTO SYS_NATION_AREA VALUES ('907', 'cn', '210504000000', '明山区', '', 3, '辽宁省', '本溪市', '明山区', 0, 1, '210500000000');
INSERT INTO SYS_NATION_AREA VALUES ('908', 'cn', '210505000000', '南芬区', '', 3, '辽宁省', '本溪市', '南芬区', 0, 1, '210500000000');
INSERT INTO SYS_NATION_AREA VALUES ('909', 'cn', '210521000000', '本溪满族自治县', '', 3, '辽宁省', '本溪市', '本溪满族自治县', 0, 1, '210500000000');
INSERT INTO SYS_NATION_AREA VALUES ('91', 'cn', '230100000000', '哈尔滨市', '', 2, '黑龙江省', '哈尔滨市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('910', 'cn', '210522000000', '桓仁满族自治县', '', 3, '辽宁省', '本溪市', '桓仁满族自治县', 0, 1, '210500000000');
INSERT INTO SYS_NATION_AREA VALUES ('911', 'cn', '210601000000', '市辖区', '', 3, '辽宁省', '丹东市', '市辖区', 0, 1, '210600000000');
INSERT INTO SYS_NATION_AREA VALUES ('912', 'cn', '210602000000', '元宝区', '', 3, '辽宁省', '丹东市', '元宝区', 0, 1, '210600000000');
INSERT INTO SYS_NATION_AREA VALUES ('913', 'cn', '210603000000', '振兴区', '', 3, '辽宁省', '丹东市', '振兴区', 0, 1, '210600000000');
INSERT INTO SYS_NATION_AREA VALUES ('914', 'cn', '210604000000', '振安区', '', 3, '辽宁省', '丹东市', '振安区', 0, 1, '210600000000');
INSERT INTO SYS_NATION_AREA VALUES ('915', 'cn', '210624000000', '宽甸满族自治县', '', 3, '辽宁省', '丹东市', '宽甸满族自治县', 0, 1, '210600000000');
INSERT INTO SYS_NATION_AREA VALUES ('916', 'cn', '210681000000', '东港市', '', 3, '辽宁省', '丹东市', '东港市', 0, 1, '210600000000');
INSERT INTO SYS_NATION_AREA VALUES ('917', 'cn', '210682000000', '凤城市', '', 3, '辽宁省', '丹东市', '凤城市', 0, 1, '210600000000');
INSERT INTO SYS_NATION_AREA VALUES ('918', 'cn', '210701000000', '市辖区', '', 3, '辽宁省', '锦州市', '市辖区', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('919', 'cn', '210702000000', '古塔区', '', 3, '辽宁省', '锦州市', '古塔区', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('92', 'cn', '230200000000', '齐齐哈尔市', '', 2, '黑龙江省', '齐齐哈尔市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('920', 'cn', '210703000000', '凌河区', '', 3, '辽宁省', '锦州市', '凌河区', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('921', 'cn', '210711000000', '太和区', '', 3, '辽宁省', '锦州市', '太和区', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('922', 'cn', '210726000000', '黑山县', '', 3, '辽宁省', '锦州市', '黑山县', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('923', 'cn', '210727000000', '义县', '', 3, '辽宁省', '锦州市', '义县', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('924', 'cn', '210781000000', '凌海市', '', 3, '辽宁省', '锦州市', '凌海市', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('925', 'cn', '210782000000', '北镇市', '', 3, '辽宁省', '锦州市', '北镇市', 0, 1, '210700000000');
INSERT INTO SYS_NATION_AREA VALUES ('926', 'cn', '210801000000', '市辖区', '', 3, '辽宁省', '营口市', '市辖区', 0, 1, '210800000000');
INSERT INTO SYS_NATION_AREA VALUES ('927', 'cn', '210802000000', '站前区', '', 3, '辽宁省', '营口市', '站前区', 0, 1, '210800000000');
INSERT INTO SYS_NATION_AREA VALUES ('928', 'cn', '210803000000', '西市区', '', 3, '辽宁省', '营口市', '西市区', 0, 1, '210800000000');
INSERT INTO SYS_NATION_AREA VALUES ('929', 'cn', '210804000000', '鲅鱼圈区', '', 3, '辽宁省', '营口市', '鲅鱼圈区', 0, 1, '210800000000');
INSERT INTO SYS_NATION_AREA VALUES ('93', 'cn', '230300000000', '鸡西市', '', 2, '黑龙江省', '鸡西市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('930', 'cn', '210811000000', '老边区', '', 3, '辽宁省', '营口市', '老边区', 0, 1, '210800000000');
INSERT INTO SYS_NATION_AREA VALUES ('931', 'cn', '210881000000', '盖州市', '', 3, '辽宁省', '营口市', '盖州市', 0, 1, '210800000000');
INSERT INTO SYS_NATION_AREA VALUES ('932', 'cn', '210882000000', '大石桥市', '', 3, '辽宁省', '营口市', '大石桥市', 0, 1, '210800000000');
INSERT INTO SYS_NATION_AREA VALUES ('933', 'cn', '210901000000', '市辖区', '', 3, '辽宁省', '阜新市', '市辖区', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('934', 'cn', '210902000000', '海州区', '', 3, '辽宁省', '阜新市', '海州区', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('935', 'cn', '210903000000', '新邱区', '', 3, '辽宁省', '阜新市', '新邱区', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('936', 'cn', '210904000000', '太平区', '', 3, '辽宁省', '阜新市', '太平区', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('937', 'cn', '210905000000', '清河门区', '', 3, '辽宁省', '阜新市', '清河门区', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('938', 'cn', '210911000000', '细河区', '', 3, '辽宁省', '阜新市', '细河区', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('939', 'cn', '210921000000', '阜新蒙古族自治县', '', 3, '辽宁省', '阜新市', '阜新蒙古族自治县', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('94', 'cn', '230400000000', '鹤岗市', '', 2, '黑龙江省', '鹤岗市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('940', 'cn', '210922000000', '彰武县', '', 3, '辽宁省', '阜新市', '彰武县', 0, 1, '210900000000');
INSERT INTO SYS_NATION_AREA VALUES ('941', 'cn', '211001000000', '市辖区', '', 3, '辽宁省', '辽阳市', '市辖区', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('942', 'cn', '211002000000', '白塔区', '', 3, '辽宁省', '辽阳市', '白塔区', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('943', 'cn', '211003000000', '文圣区', '', 3, '辽宁省', '辽阳市', '文圣区', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('944', 'cn', '211004000000', '宏伟区', '', 3, '辽宁省', '辽阳市', '宏伟区', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('945', 'cn', '211005000000', '弓长岭区', '', 3, '辽宁省', '辽阳市', '弓长岭区', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('946', 'cn', '211011000000', '太子河区', '', 3, '辽宁省', '辽阳市', '太子河区', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('947', 'cn', '211021000000', '辽阳县', '', 3, '辽宁省', '辽阳市', '辽阳县', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('948', 'cn', '211081000000', '灯塔市', '', 3, '辽宁省', '辽阳市', '灯塔市', 0, 1, '211000000000');
INSERT INTO SYS_NATION_AREA VALUES ('949', 'cn', '211101000000', '市辖区', '', 3, '辽宁省', '盘锦市', '市辖区', 0, 1, '211100000000');
INSERT INTO SYS_NATION_AREA VALUES ('95', 'cn', '230500000000', '双鸭山市', '', 2, '黑龙江省', '双鸭山市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('950', 'cn', '211102000000', '双台子区', '', 3, '辽宁省', '盘锦市', '双台子区', 0, 1, '211100000000');
INSERT INTO SYS_NATION_AREA VALUES ('951', 'cn', '211103000000', '兴隆台区', '', 3, '辽宁省', '盘锦市', '兴隆台区', 0, 1, '211100000000');
INSERT INTO SYS_NATION_AREA VALUES ('952', 'cn', '211104000000', '大洼区', '', 3, '辽宁省', '盘锦市', '大洼区', 0, 1, '211100000000');
INSERT INTO SYS_NATION_AREA VALUES ('953', 'cn', '211122000000', '盘山县', '', 3, '辽宁省', '盘锦市', '盘山县', 0, 1, '211100000000');
INSERT INTO SYS_NATION_AREA VALUES ('954', 'cn', '211201000000', '市辖区', '', 3, '辽宁省', '铁岭市', '市辖区', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('955', 'cn', '211202000000', '银州区', '', 3, '辽宁省', '铁岭市', '银州区', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('956', 'cn', '211204000000', '清河区', '', 3, '辽宁省', '铁岭市', '清河区', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('957', 'cn', '211221000000', '铁岭县', '', 3, '辽宁省', '铁岭市', '铁岭县', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('958', 'cn', '211223000000', '西丰县', '', 3, '辽宁省', '铁岭市', '西丰县', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('959', 'cn', '211224000000', '昌图县', '', 3, '辽宁省', '铁岭市', '昌图县', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('96', 'cn', '230600000000', '大庆市', '', 2, '黑龙江省', '大庆市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('960', 'cn', '211281000000', '调兵山市', '', 3, '辽宁省', '铁岭市', '调兵山市', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('961', 'cn', '211282000000', '开原市', '', 3, '辽宁省', '铁岭市', '开原市', 0, 1, '211200000000');
INSERT INTO SYS_NATION_AREA VALUES ('962', 'cn', '211301000000', '市辖区', '', 3, '辽宁省', '朝阳市', '市辖区', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('963', 'cn', '211302000000', '双塔区', '', 3, '辽宁省', '朝阳市', '双塔区', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('964', 'cn', '211303000000', '龙城区', '', 3, '辽宁省', '朝阳市', '龙城区', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('965', 'cn', '211321000000', '朝阳县', '', 3, '辽宁省', '朝阳市', '朝阳县', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('966', 'cn', '211322000000', '建平县', '', 3, '辽宁省', '朝阳市', '建平县', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('967', 'cn', '211324000000', '喀喇沁左翼蒙古族自治县', '', 3, '辽宁省', '朝阳市', '喀喇沁左翼蒙古族自治县', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('968', 'cn', '211381000000', '北票市', '', 3, '辽宁省', '朝阳市', '北票市', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('969', 'cn', '211382000000', '凌源市', '', 3, '辽宁省', '朝阳市', '凌源市', 0, 1, '211300000000');
INSERT INTO SYS_NATION_AREA VALUES ('97', 'cn', '230700000000', '伊春市', '', 2, '黑龙江省', '伊春市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('970', 'cn', '211401000000', '市辖区', '', 3, '辽宁省', '葫芦岛市', '市辖区', 0, 1, '211400000000');
INSERT INTO SYS_NATION_AREA VALUES ('971', 'cn', '211402000000', '连山区', '', 3, '辽宁省', '葫芦岛市', '连山区', 0, 1, '211400000000');
INSERT INTO SYS_NATION_AREA VALUES ('972', 'cn', '211403000000', '龙港区', '', 3, '辽宁省', '葫芦岛市', '龙港区', 0, 1, '211400000000');
INSERT INTO SYS_NATION_AREA VALUES ('973', 'cn', '211404000000', '南票区', '', 3, '辽宁省', '葫芦岛市', '南票区', 0, 1, '211400000000');
INSERT INTO SYS_NATION_AREA VALUES ('974', 'cn', '211421000000', '绥中县', '', 3, '辽宁省', '葫芦岛市', '绥中县', 0, 1, '211400000000');
INSERT INTO SYS_NATION_AREA VALUES ('975', 'cn', '211422000000', '建昌县', '', 3, '辽宁省', '葫芦岛市', '建昌县', 0, 1, '211400000000');
INSERT INTO SYS_NATION_AREA VALUES ('976', 'cn', '211481000000', '兴城市', '', 3, '辽宁省', '葫芦岛市', '兴城市', 0, 1, '211400000000');
INSERT INTO SYS_NATION_AREA VALUES ('977', 'cn', '220101000000', '市辖区', '', 3, '吉林省', '长春市', '市辖区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('978', 'cn', '220102000000', '南关区', '', 3, '吉林省', '长春市', '南关区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('979', 'cn', '220103000000', '宽城区', '', 3, '吉林省', '长春市', '宽城区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('98', 'cn', '230800000000', '佳木斯市', '', 2, '黑龙江省', '佳木斯市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('980', 'cn', '220104000000', '朝阳区', '', 3, '吉林省', '长春市', '朝阳区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('981', 'cn', '220105000000', '二道区', '', 3, '吉林省', '长春市', '二道区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('982', 'cn', '220106000000', '绿园区', '', 3, '吉林省', '长春市', '绿园区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('983', 'cn', '220112000000', '双阳区', '', 3, '吉林省', '长春市', '双阳区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('984', 'cn', '220113000000', '九台区', '', 3, '吉林省', '长春市', '九台区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('985', 'cn', '220122000000', '农安县', '', 3, '吉林省', '长春市', '农安县', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('986', 'cn', '220171000000', '长春经济技术开发区', '', 3, '吉林省', '长春市', '长春经济技术开发区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('987', 'cn', '220172000000', '长春净月高新技术产业开发区', '', 3, '吉林省', '长春市', '长春净月高新技术产业开发区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('988', 'cn', '220173000000', '长春高新技术产业开发区', '', 3, '吉林省', '长春市', '长春高新技术产业开发区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('989', 'cn', '220174000000', '长春汽车经济技术开发区', '', 3, '吉林省', '长春市', '长春汽车经济技术开发区', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('99', 'cn', '230900000000', '七台河市', '', 2, '黑龙江省', '七台河市', '', 0, 1, '230000000000');
INSERT INTO SYS_NATION_AREA VALUES ('990', 'cn', '220182000000', '榆树市', '', 3, '吉林省', '长春市', '榆树市', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('991', 'cn', '220183000000', '德惠市', '', 3, '吉林省', '长春市', '德惠市', 0, 1, '220100000000');
INSERT INTO SYS_NATION_AREA VALUES ('992', 'cn', '220201000000', '市辖区', '', 3, '吉林省', '吉林市', '市辖区', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('993', 'cn', '220202000000', '昌邑区', '', 3, '吉林省', '吉林市', '昌邑区', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('994', 'cn', '220203000000', '龙潭区', '', 3, '吉林省', '吉林市', '龙潭区', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('995', 'cn', '220204000000', '船营区', '', 3, '吉林省', '吉林市', '船营区', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('996', 'cn', '220211000000', '丰满区', '', 3, '吉林省', '吉林市', '丰满区', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('997', 'cn', '220221000000', '永吉县', '', 3, '吉林省', '吉林市', '永吉县', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('998', 'cn', '220271000000', '吉林经济开发区', '', 3, '吉林省', '吉林市', '吉林经济开发区', 0, 1, '220200000000');
INSERT INTO SYS_NATION_AREA VALUES ('999', 'cn', '220272000000', '吉林高新技术产业开发区', '', 3, '吉林省', '吉林市', '吉林高新技术产业开发区', 0, 1, '220200000000');





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

INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2400000003411005', '待办列表', 'BpmTask', '1', '1', '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n					<dd id=\"modularTitle\">\n						<span class=\"project_01\">\n							<p>审批环节</p>\n						</span>\n						<span class=\"project_02\">\n							<p>事项</p>\n						</span>\n						<span class=\"project_03\">\n							<p>日期</p>\n						</span>\n						<span class=\"project_04\">\n							<p>操作</p>\n						</span>\n						<div class=\"clearfix\"></div>\n					</dd>\n					<#list data.obj as obj>\n						<dd>\n							<span class=\"project_01\">\n								<a href=\"###\">${obj.name}</a>\n							</span>\n							<span class=\"project_02\">\n								<a href=\"${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}\" target=\"_blank\">${obj.description}</a>\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n							<span class=\"project_04\">\n								<a href=\"${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}\" target=\"_blank\">操作</a>\n							</span>\n							<div class=\"clearfix\"></div>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalBpmTask(colId)', '1', '1', NULL, '1', '2019-02-13 14:32:42', NULL, '1', 'list', '', '');
INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2430000000040063', '默认tab栏目', 'default_tab', '', NULL, '<div class=\"mini-tabs\" activeIndex=\"0\"  style=\"width:100%;height:200px;\">\n  	<#list data.obj as d>\n    <div title=\"${d.name}${d.count}\">\n        ${d.templet}\n    </div>\n    </#list>\n</div>', '', '1', '1', '2019-02-12 18:12:00', '1', '2019-02-21 18:06:44', NULL, '1', 'tabcolumn', '2400000003411004,2430000000410492,2430000000410493', '');
INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2430000000410492', '已办列表', 'MyBpmTask', '', NULL, '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n					<dd id=\"modularTitle\">\n						<span class=\"project_01\">\n							<p>状态</p>\n						</span>\n						<span class=\"project_02\">\n							<p>事项</p>\n						</span>\n						<span class=\"project_03\">\n							<p>日期</p>\n						</span>\n						<div class=\"clearfix\"></div>\n					</dd>\n					<#list data.obj as obj>\n						<dd>\n							<span class=\"project_01\">\n								<a href=\"###\">${obj.statusLabel}</a>\n							</span>\n							<span class=\"project_02\">\n								${obj.subject}\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n							<div class=\"clearfix\"></div>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalMyBpmTask(colId)', '1', '1', '2019-02-21 15:55:23', '1', '2019-02-21 18:16:32', NULL, '1', 'list', '', '');
INSERT INTO ins_column_def (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_NEWS_, IS_PUBLIC_, type_, TABGROUPS_, TREE_ID_) VALUES ('2430000000410493', '抄送列表', 'MyChao', '', NULL, '<div id=\"myTask\" class=\"colId_${colId}\" colId=\"${colId}\">\n	<div class=\"widget-box border \" >\n		<div class=\"widget-body\">\n			<div class=\"widget-scroller\" >\n				<dl class=\"modularBox\">\n					<dt>\n						<h1>${data.title}</h1>\n						<div class=\"icon\">\n							<input type=\"button\" id=\"More\" onclick=\"showMore(\'${colId}\',\'${data.title}\',\'${data.url}\')\"/>\n							<input type=\"button\" id=\"Refresh\" onclick=\"refresh(\'${colId}\')\"/>\n						</div>\n						<div class=\"clearfix\"></div>\n					</dt>\n					<dd id=\"modularTitle\">\n						<span class=\"project_01\">\n							<p>审批环节</p>\n						</span>\n						<span class=\"project_02\">\n							<p>事项</p>\n						</span>\n						<span class=\"project_03\">\n							<p>日期</p>\n						</span>\n						<div class=\"clearfix\"></div>\n					</dd>\n					<#list data.obj as obj>\n						<dd>\n							<span class=\"project_01\">\n								<a href=\"###\">${obj.nodeName}</a>\n							</span>\n							<span class=\"project_02\">\n								${obj.subject}\n							</span>\n							<span class=\"project_03\">\n								<a href=\"###\">${obj.createTime?string(\'yyyy-MM-dd\')}</a>\n							</span>\n							<div class=\"clearfix\"></div>\n						</dd>\n					</#list>\n				</dl>\n			</div>\n		</div>\n	</div>\n</div>', 'portalScript.getPortalMyChao(colId)', '1', '1', '2019-02-21 15:56:18', '1', '2019-02-21 18:18:52', NULL, '1', 'list', '', '');



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



INSERT INTO sys_menu(MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000007', '210000000418012', '权限分级管理', 'orgGradeMgr', NULL, NULL, NULL, ' icon-jituankehu', '', '2520000000020095', 2, '210000000418012.2520000000020095.2610000000000007.', 0, '/sys/org/sysOrg/mgrGrade.do', NULL, 'NO', 4, '', '', NULL, '1', NULL, NULL, NULL);


-- 菜单配置：
-- 申请加入机构：
INSERT INTO sys_menu(MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000008', '210000000418012', '申请加入机构', 'addSysInst', NULL, NULL, NULL, ' icon-form-sol-18', '', '2520000000020095', NULL, '', 10, '/sys/core/sysInst/showCanApplyList.do', NULL, 'NO', 0, '', '', NULL, '1', NULL, NULL, NULL);

-- 机构申请审批：
INSERT INTO sys_menu(MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000011', '210000000418012', '机构申请审批', 'addSysInstMgr', NULL, NULL, NULL, ' icon-book-18', '', '2520000000020095', 2, '210000000418012.2520000000020095.2610000000000011.', 11, '/sys/core/sysInst/showApplyInstList.do', NULL, 'NO', 0, '', '', NULL, '1', NULL, NULL, NULL);


-- add by shenzhongwen 2019-03-13   脚本调用 菜单------------------------
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_ , BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)
values ('2610000000290037', '210000000418012', '脚本调用', 'invokeScript', NULL, NULL, NULL, ' icon-more', '', '2520000000240005', 1, 'null2610000000290037.', 0, '/sys/core/sysInvokeScript/list.do', 'URL', 'NO', '0', '', NULL, '1', '1', '2019-02-26 10:42:20',NULL,NULL);
-- add by shenzhongwen 2019-03-13   脚本调用 菜单------------------------

-- 菜单配置：批量审批设定
INSERT INTO SYS_MENU (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000060010', '210000000418012', '批量审批配置', 'batchApprovalConfig', NULL, NULL, NULL, ' icon-wodeshenqing', NULL, '2520000000690010', NULL, NULL, 9, '/bpm/core/bpmBatchApproval/list.do', 'URL', 'NO', 0, '', NULL, '1', NULL, NULL, '1', NULL);


-- add by shenzhongwen 2019-04-02 新增 脚本管理菜单--------
INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, TENANT_ID_, CREATE_BY_)
values ('2610000001710002','210000000418012','脚本管理','scriptServiceClass',NULL,NULL,NULL,' icon-database-50','','2520000000240005',1,'null2610000001710002.','0','/sys/org/sysScriptLibary/list.do','URL','NO','0',1,1);


INSERT INTO sys_menu (MENU_ID_, SYS_ID_, NAME_, KEY_, FORM_, ENTITY_NAME_, MODULE_ID_, ICON_CLS_, IMG_, PARENT_ID_, DEPTH_, PATH_, SN_, URL_, SHOW_TYPE_, IS_BTN_MENU_, CHILDS_, BO_LIST_ID_, MOBILE_ICON_CLS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2620000000140002', '2520000000360023', 'OpenOffice配置', 'openOfficeConfig', NULL, NULL, NULL, ' icon-xitongpeizhi', NULL, '2510000000020002', NULL, NULL, '0', '/sys/core/openoffice/config.do', 'URL', 'NO', '0', '', NULL, '1', NULL, NULL, '1', '2019-02-01 17:34:56');

