--转义符
Set define OFF;

-- 22. 消息盒子
INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000007699002', '1', '/bpm/core/bpmTask/myList.do', ' icon-card_agency', '我的待办', 'mysql', 'mysql', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from act_ru_task where assignee_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011559007', '', '/oa/personal/bpmInst/myAttends.do', ' icon-card_engine', '我的已办', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(distinct(JUMP_ID_))from bpm_inst b left join bpm_node_jump c on b.ACT_INST_ID_=c.ACT_INST_ID_ where HANDLER_ID_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011589004', '', '/bpm/core/bpmInst/myDrafts.do', ' icon-card_editor', '我的流程草稿', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from bpm_inst b where status_ = ''DRAFTED'' and create_by_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011609029', '', '/oa/personal/bpmSolApply/myList.do', ' icon-card_agency', '我的代办', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(distinct(JUMP_ID_))from bpm_inst b left join bpm_node_jump c on b.ACT_INST_ID_=c.ACT_INST_ID_ where HANDLER_ID_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011609030', '', '/oa/personal/bpmSolApply/myList.do', ' icon-card_form_edit', '我的工单', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(distinct(JUMP_ID_))from bpm_inst b left join bpm_node_jump c on b.ACT_INST_ID_=c.ACT_INST_ID_ where HANDLER_ID_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011609031', '', '/oa/personal/bpmSolApply/myList.do', ' icon-card_Modular', '设计工具', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(distinct(JUMP_ID_))from bpm_inst b left join bpm_node_jump c on b.ACT_INST_ID_=c.ACT_INST_ID_ where HANDLER_ID_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011609032', '', '/oa/personal/bpmSolApply/myList.do', ' icon-card_Dept', '我的组件', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(distinct(JUMP_ID_))from bpm_inst b left join bpm_node_jump c on b.ACT_INST_ID_=c.ACT_INST_ID_ where HANDLER_ID_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011609033', '', '/oa/personal/bpmSolApply/myList.do', ' icon-card_pen', '可视化设计', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(distinct(JUMP_ID_))from bpm_inst b left join bpm_node_jump c on b.ACT_INST_ID_=c.ACT_INST_ID_ where HANDLER_ID_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011609034', '', '/oa/personal/bpmSolApply/myList.do', ' icon-card_editor', '流程方案申请', '', '', 'portalScript.getCountMySolList()', 'function', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011679032', '', '/oa/info/infInbox/receive.do', ' icon-card_message', '我的消息', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(m.MSG_ID_) from inf_inner_Msg m left join inf_inbox  box on m.MSG_ID_=box.MSG_ID_ where box.REC_TYPE_ = ''REC'' and box.IS_READ_ = ''no'' and box.REC_USER_ID_ ="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011769008', '', '/oa/res/oaMeetAtt/listOameet.do', ' icon-card_news', '我的会议', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from OA_MEET_ATT att where att.USER_ID_="+userId ;
return sql;', 'sql', '1', NULL, NULL, NULL, NULL);

INSERT INTO INS_MSG_DEF(MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
values ('2400000011769009', '', '/sys/core/sysFile/myMgr.do', ' icon-card_commodity', '我的附件', '', '', 'import com.redxun.saweb.context.ContextUtil;

String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from sys_file where CREATE_BY_="+userId ;
return sql;
', 'sql', '1', NULL, NULL, NULL, NULL);

-- 18. 数据源对话框
INSERT INTO SYS_BO_LIST(ID_,SOL_ID_,NAME_,KEY_,DESCP_,ID_FIELD_,URL_,MULTI_SELECT_,IS_LEFT_TREE_,LEFT_NAV_,LEFT_TREE_JSON_,SQL_,USE_COND_SQL_,COND_SQLS_,DB_AS_,FIELDS_JSON_,COLS_JSON_,LIST_HTML_,SEARCH_JSON_,BPM_SOL_ID_,FORM_ALIAS_,TOP_BTNS_JSON_,BODY_SCRIPT_,IS_DIALOG_,IS_PAGE_,IS_EXPORT_,HEIGHT_,WIDTH_,ENABLE_FLOW_,IS_GEN_,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)
VALUES ('2400000000001017','','数据源对话框','dataSourceDialog','','ID_','','false','NO','','','select * from sys_datasource_def','NO','[]','','[{"isReturn":null,"field":"ID_","dataType":"string","queryDataType":"S","width":100,"header":"主键","_id":6,"_uid":6},{"isReturn":"YES","field":"NAME_","dataType":"string","queryDataType":"S","width":100,"header":"数据源名称","_id":7,"_uid":7},{"isReturn":"YES","field":"ALIAS_","dataType":"string","queryDataType":"S","width":100,"header":"别名","_id":8,"_uid":8},{"isReturn":null,"field":"ENABLE_","dataType":"string","queryDataType":"S","width":100,"header":"是否使用","_id":9,"_uid":9},{"isReturn":null,"field":"SETTING_","dataType":"string","queryDataType":"S","width":100,"header":"数据源设定","_id":10,"_uid":10},{"isReturn":"YES","field":"DB_TYPE_","dataType":"string","queryDataType":"S","width":100,"header":"数据库类型","_id":11,"_uid":11},{"isReturn":null,"field":"INIT_ON_START_","dataType":"string","queryDataType":"S","width":100,"header":"启动时初始化","_id":12,"_uid":12},{"isReturn":null,"field":"CREATE_TIME_","dataType":"date","queryDataType":"D","format":"yyyy-MM-dd","width":100,"header":"创建时间","_id":13,"_uid":13},{"isReturn":null,"field":"CREATE_BY_","dataType":"string","queryDataType":"S","width":100,"header":"创建人","_id":14,"_uid":14},{"isReturn":null,"field":"UPDATE_BY_","dataType":"string","queryDataType":"S","width":100,"header":"更新人","_id":15,"_uid":15},{"isReturn":null,"field":"UPDATE_TIME_","dataType":"date","queryDataType":"D","format":"yyyy-MM-dd","width":100,"header":"更新时间","_id":16,"_uid":16}]','[{"_pid":-1,"expanded":true,"field":"NAME_","queryDataType":"S","dataType":"string","width":100,"_level":0,"header":"数据源名称","_id":3,"_uid":3},{"_pid":-1,"expanded":true,"field":"ALIAS_","queryDataType":"S","dataType":"string","width":100,"_level":0,"header":"别名","_id":4,"_uid":4},{"_pid":-1,"expanded":true,"field":"DB_TYPE_","queryDataType":"S","dataType":"string","width":100,"_level":0,"header":"数据库类型","_id":5,"_uid":5}]',NULL,'[{"fc":"mini-textbox","_id":1,"_uid":1,"_state":"added","fieldLabel":"数据源名称","dataType":"string","queryDataType":"S","fieldName":"NAME_","fieldOpLabel":"%模糊匹配%","fieldOp":"LK","fcName":"文本框","fieldText":"数据源名称","type":"query","typeName":"查询参数","autoFilter":"YES","autoFilterName":"是"},{"fc":"mini-textbox","_id":2,"_uid":2,"_state":"added","fieldLabel":"数据源名称","dataType":"string","queryDataType":"S","fieldName":"NAME_","fieldOpLabel":"%模糊匹配%","fieldOp":"LK","fcName":"文本框","fieldText":"数据源名称","type":"query","typeName":"查询参数","autoFilter":"YES","autoFilterName":"是"}]','','','','','YES','YES','','600','800','','YES','1','1','','','');
commit;
DECLARE  
  html SYS_BO_LIST.LIST_HTML_ %TYPE;  
BEGIN 
html := '<!DOCTYPE html >
<html>
<head>
    <title>数据源对话框</title>
	<script type="text/javascript">
		var __rootPath=''${ctxPath}'';
	</script>
	<link href="${ctxPath}/styles/skin/default/index.css" rel="stylesheet" type="text/css" /> 
	<link href="${ctxPath}/styles/commons.css" rel="stylesheet" type="text/css" />
	<link href="${ctxPath}/styles/list.css" rel="stylesheet" type="text/css" />
	<script src="${ctxPath}/scripts/mini/boot.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/share.js" type="text/javascript"></script>
	<link href="${ctxPath}/styles/skin/default/index.css" rel="stylesheet" type="text/css" /> 
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/share/customQuery.js" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/common/form.js" type="text/javascript"></script>
	<link href="${ctxPath}/styles/cover_list.css" rel="stylesheet" type="text/css" />
		<#assign query="">
		<#if params??&&(params?size>0)>
			<#assign query="?">
			<#assign  keys=params?keys/>
			<#list keys as key>
				<#if (key_index==0)>
					<#assign query=query + key +"=" + params[key] >		
				<#else>
					<#assign query=query +"&" +key +"=" + params[key] >
				</#if>
			</#list>
		</#if>
</head>
<body >   
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">

      <div region="center"  title="数据源对话框" showCollapseButton="false" >
     	<div class="mini-toolbar" >
	         <table style="width:100%;">
	             <tr>
	                 <td style="width:100%;">
	                    <a class="mini-button" iconCls="icon-search"  onclick="onSearch()">查询</a>
                     	<a class="mini-button" iconCls="icon-cancel"  onclick="onClear()">清空查询</a>
                     	<span class="separator"></span>
                     	<a class="mini-button" iconCls="icon-ok"   onclick="CloseWindow(''ok'');">确定</a>
		    			<a class="mini-button" iconCls="icon-cancel"  onclick="CloseWindow();">取消</a>
	                 </td>
	             </tr>
	              <tr>
	                  <td  class="search-form" style="white-space:nowrap;">
	                   	<div id="searchForm">
	                    	<div>
 <ul>
  <li><span>数据源名称</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
  <li><span>数据源名称</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
 </ul>
</div>
	                    </div>
	                  </td>
	              </tr>
	         </table>
	     </div>
	    
     	<div class="mini-fit rx-grid-fit">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" 
	        	url="${ctxPath}/dev/cus/customData/dataSourceDialog/getData.do${query}" idField="ID_" multiSelect="false" showColumnsMenu="true" 
	        	parentField="" treeColumn="" allowResize="false" expandOnLoad="true"
	        	sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
						<div property="columns">
 <div type="indexcolumn"></div>
 <div type="checkcolumn"></div>
 <div header="数据源名称" width="100" field="NAME_" name="NAME_"></div>
 <div header="别名" width="100" field="ALIAS_" name="ALIAS_"></div>
 <div header="数据库类型" width="100" field="DB_TYPE_" name="DB_TYPE_"></div>
</div>
			</div>
		</div>
    </div>
</div>

    
    <script type="text/javascript">
        mini.parse();
		var grid=mini.get(''datagrid1'');
		grid.load();
		var searchForm=new mini.Form(''searchForm'');
			
		function onSearch(){
			var data=searchForm.getData();
			_ConvertFormData(data);
			grid.load(data);
		}
		
		//---------------开始生成服务器自定义按钮-------------
		 //-------------结束生成服务器自定义按钮-------------
		
		 grid.on("drawcell", function (e) {
		   var record = e.record,
		   field = e.field,
		   value = e.value;
		   if(field==''CREATE_BY_'' || field==''UPDATE_BY_'' || field==''CREATE_USER_ID_''){
		     if(value){
		     	e.cellHtml=''<a class="mini-user" iconCls="icon-user" userId="''+value+''"></a>'';
		     }else{
		     	e.cellHtml=''<span style="color:red">无</span>'';
		     }
		   }
            
            if( field== "INST_STATUS_"){
            	var statusText="";
            	if(value==''RUNNING''){
            		e.cellHtml=''<span style="color:green">运行中</span>'';
            	}else if(value==''DRAFTED''){
            		e.cellHtml=''<span style="color:red">草稿</span>'';
            	}else if(value==''SUCCESS_END''){
            		e.cellHtml=''<span style="color:green">成功结束</span>'';
            	}else if(value==''DISCARD_END''){
            		e.cellHtml=''<span style="color:red">作废</span>'';
            	}else if(value==''ABORT_END''){
            		e.cellHtml=''<span style="color:red">异常中止结束</span>'';
            	}else if(value==''PENDING''){
            		e.cellHtml=''挂起'';
            	}else{
            		e.cellHtml=e.value;
            	}
            }
            
            
            
		 });
		
		 grid.on(''update'',function(){
		   _LoadUserInfo();
		 });
		  
		 grid.on(''rowdblclick'',function(e){
		 	if(''''==''''){
				return ;
			}
			var record=e.record;
			
			if(record==null){
			   alert(''请选择表格行'');
			   return;
			}
			
		   _OpenWindow({
				title:''数据源对话框--明细'',
				height:400,
				width:800,
				max:true,
				url:__rootPath+''/sys/customform/sysCustomFormSetting/detail//''+record.ID_+''.do'',
				ondestroy:function(action){
					if(action!=''ok''){
						return;
					}
				}
			});
		 });
		 
		function getUrlFromRecord(url,record){
		
            url=url.replace(''{ctxPath}'',__rootPath);
            for(var field in record){
            	url=url.replace(''{''+field+''}'',record[field]);
            }
            return url;
		}
		
		function onClear(){
			searchForm.clear();
			var url=grid.getUrl();
			var index=url.indexOf(''?'');
			if(index!=-1){
				url=url.substring(0,index);
			}
			grid.setUrl(url);
			grid.load();
		}
		
		function onClose(){
			CloseWindow();
		}
		
		function onRemove(e){
			var row=grid.getSelecteds();
			if(row.length==0){
			   alert(''请选择表格行'');
			   return;
			}
			
			var url="/sys/customform/sysCustomFormSetting/remove/.do";
			if(e.sender && e.sender.url){
				url=e.sender.url;
			}
			url=__rootPath+url;
			mini.confirm("确定删除吗?", "提示信息", function(action){
                if (action != "ok")  return;
				var ids = [];
				for(var i=0; i < row.length; i++){
					ids.push(row[i][''ID_'']);
				}
				_SubmitJson({url:url,method:"POST",data:{id:ids.join('','')},success:function(){
					grid.load();
				}})    
            })
		}
		
		//返回选择的数据
		function getData(){
			var rows=grid.getSelecteds();
			return rows;
		}
		
		function showLink(value,field,url,linkType){
			if(linkType==''tabWindow''){
				top[''index''].showTabFromPage({
        			tabId:''_''+field,
        			title:value + ''-信息'',
        			url:url
        		});
			}else if(linkType=="newWindow"){
				 window.open(url); 
			}else{
				 _OpenWindow({
					title:value,
					height:400,
					width:800,
					max:true,
					url:url
				});
			}
		}
    </script>

</body>
</html>' ; 
UPDATE SYS_BO_LIST T SET T.LIST_HTML_ = html WHERE t.ID_='2400000000001017';  
END;
/

-- 19. 栏目定义

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000003411003', '消息盒', 'msgBox', '1', '1', NULL, 'portalScript.getPortalMsgBox("msgbox")', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000003411004', '待办列表', 'BpmTask', '/bpm/core/bpmTask/myList.do', '1', NULL, 'portalScript.getPortalBpmTask(colId)', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000004011000', '公司公告', 'news', '1', '1', NULL, 'portalScript.getPortalNews(colId)', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000004021000', '我的消息', 'myMsg', '1', '1', NULL, 'portalScript.getPortalMsg(colId)', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000004021001', '外部邮件', 'outMail', '1', '1', NULL, 'portalScript.getPortalOutEmail(colId)', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000008039006', '基础信息', 'baseInfo', '', '', NULL, 'portalScript.getPortalMsgBox("msgbox")', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000008759000', '柱状报表', 'report', '', '', NULL, '', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000011559002', '折线报表图', 'zxbbt', '', '', NULL, '', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000011559004', '曲线报表图', 'qxbbt', '', '', NULL, '', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000011559013', '流程方案申请', 'mySolList', '', '', NULL, 'portalScript.getPortalMySolList(colId);', '1', '1', NULL, NULL, NULL);

		INSERT INTO ins_column_def(COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
		values ('2400000011589005', '漏斗报表图', 'ldbbt', '', '', NULL, '', '1', '1', NULL, NULL, NULL);
		commit;

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="msgBox" class="colId_${colId}" colId="${colId}">
	<div class="card">
		<ul id="cardUl">
			<#list data.obj as d>
			<li class="p_top">
            	<a href="${ctxPath}${d.url}" target="_blank">
					<div class="cardBox" url="${ctxPath}${d.url}">
						<span class="iconfont  ${d.icon}"></span> 
						<span class="card_text">
							<h3>${d.count}</h3>
							<h2>${d.title}</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			</#list>
			<h1 class="clearfix"></h1>
		</ul>
	</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000003411003';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="myTask" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')"/>
						</div>
						<div class="clearfix"></div>
					</dt>
					<dd id="modularTitle">
						<span class="project_01">
							<p>审批环节</p>
						</span>
						<span class="project_02">
							<p>事项</p>
						</span>
						<span class="project_03">
							<p>日期</p>
						</span>
						<span class="project_04">
							<p>操作</p>
						</span>
						<div class="clearfix"></div>
					</dd>
					<#list data.obj as obj>
						<dd>
							<span class="project_01">
								<a href="###">${obj.name}</a>
							</span>
							<span class="project_02">
								<a href="${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}" target="_blank">${obj.description}</a>
							</span>
							<span class="project_03">
								<a href="###">${obj.createTime?string(''yyyy-MM-dd'')}</a>
							</span>
							<span class="project_04">
								<a href="${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true&taskId=${obj.id}" target="_blank">操作</a>
							</span>
							<div class="clearfix"></div>
						</dd>
					</#list>
				</dl>
			</div>
		</div>
	</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000003411004';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="news" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" class="p_top" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"/>
							<input type="button" id="Refresh" class="p_top" onclick="refresh(''${colId}'')"/>
						</div>
						<div class="clearfix"></div>
					</dt>
						<#list data.obj as obj>
						<dd class="p_top">
							<p><a href="${ctxPath}/oa/info/insNews/get.do?permit=no&pkId=${obj.newId}" target="_blank">${obj.subject}</a></p>
						</dd>
						</#list>
				</dl>
			</div>
		</div>
		<div class="Load">
			<span></span>
			<h1>加载中...</h1>
		</div>
	</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000004011000';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="myMsg" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')"/>
						</div>
						<div class="clearfix"></div>
					</dt>
						<#list data.obj as obj>
						<dd>
							<p><a href="${ctxPath}/oa/info/infInbox/recPortalGet.do?pkId=${obj.msgId}" target="_blank">${obj.content}</a></p>
						</dd>
						</#list>
				</dl>
			</div>
		</div>
	</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000004021000';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="outMail" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')"/>
						</div>
						<div class="clearfix"></div>
					</dt>
						<#list data.obj as obj>
						<dd>
							<p><a href="${ctxPath}/oa/mail/outMail/get.do?isHome=YES&pkId=${obj.mailId}" target="_blank">${obj.subject}</a></p>
						</dd>
						</#list>
				</dl>
			</div>
		</div>
	</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000004021001';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="msgBox" class="colId_${colId}" colId="${colId}">
	<div class="card_msg">
		<ul id="cardUl">			
			<li class="p_top">
				<div class="cardInfo">
					<h3>公司违纪举报电话及邮箱</h3>
					<h2>jichabu@redxun.cn</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>总裁办</h3>
					<h2>020-26404070 13602987111</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>总经办</h3>
					<h2>020-86310367 18023875131</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>稽查部</h3>
					<h2>020-86385980 18023876667</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>人事部</h3>
					<h2>020-86331013 18053769755</h2>
				</div>
			</li>
			<h1 class="clearfix"></h1>
		</ul>
	</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000008039006';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="report" class="colId_${colId} modularBox" colId="${colId}" style="background: #fff;">
<div id="zzbb" style="width:100%;height:360px;" ></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById(''zzbb''));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: ''本月销量''
            },
            tooltip: {},
            legend: {
                data:[''销量'']
            },
            xAxis: {
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
            },
            yAxis: {},
            series: [{
                name: ''销量'',
                type: ''bar'',
                data: [5, 20, 36, 10, 10, 20]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000008759000';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="zxbbt" class="colId_${colId} " colId="${colId}" style="background: #fff;">
<div id="zxbbtChart" style="width:100%;height:360px;" ></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var zxChart = echarts.init(document.getElementById(''zxbbtChart''));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: ''本月销量''
            },
            tooltip: {},
            legend: {
                data:[''销量'']
            },
            xAxis: {
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
            },
            yAxis: {},
            series: [{
                name: ''销量'',
                type: ''line'',
                data: [5, 20, 36, 10, 10, 20]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        zxChart.setOption(option);
    </script>
</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000011559002';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="qxbbt" class="colId_${colId}" colId="${colId}" style="background: #fff;">
<div id="qxbbtChart" style="width:100%;height:360px;" ></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var qxChart = echarts.init(document.getElementById(''qxbbtChart''));

        // 指定图表的配置项和数据
        option = {
    title : {
        text: ''某楼盘销售情况'',
        subtext: ''纯属虚构''
    },
    tooltip : {
        trigger: ''axis''
    },
    legend: {
        data:[''意向'',''预购'',''成交'']
    },
    calculable : true,
    xAxis : [
        {
            type : ''category'',
            boundaryGap : false,
            data : [''周一'',''周二'',''周三'',''周四'',''周五'',''周六'',''周日'']
        }
    ],
    yAxis : [
        {
            type : ''value''
        }
    ],
    series : [
        {
            name:''成交'',
            type:''line'',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: ''default''}}},
            data:[10, 12, 21, 54, 260, 830, 710]
        },
        {
            name:''预购'',
            type:''line'',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: ''default''}}},
            data:[30, 182, 434, 791, 390, 30, 10]
        },
        {
            name:''意向'',
            type:''line'',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: ''default''}}},
            data:[1320, 1132, 601, 234, 120, 90, 20]
        }
    ]
};
                    

        // 使用刚指定的配置项和数据显示图表。
        qxChart.setOption(option);
    </script>
</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000011559004';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="myDrafts" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')"/>
						</div>
						<div class="clearfix"></div>
					</dt>
						<#list data.obj as obj>
						<dd>
							<p><a href="${ctxPath}/bpm/core/bpmInst/start.do?solId=${obj.solId}" target="_blank">${obj.name}</a></p>
						</dd>
						</#list>
				</dl>
			</div>
		</div>
	</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000011559013';  
END;
/

DECLARE  
html ins_column_def.TEMPLET_ %TYPE;  
BEGIN 
html := '<div id="ldbbt" class="colId_${colId}" colId="${colId}" style="background: #fff;">
<div id="ldbbtChart" style="width:100%;height:360px;" ></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var ldChart = echarts.init(document.getElementById(''ldbbtChart''));

        // 指定图表的配置项和数据
      option = {
    title : {
        text: ''漏斗图'',
        subtext: ''纯属虚构''
    },
    tooltip : {
        trigger: ''item'',
        formatter: "{a} <br/>{b} : {c}%"
    },
    legend: {
        data : [''展现'',''点击'',''访问'',''咨询'',''订单'']
    },
    calculable : true,
    series : [
        {
            name:''漏斗图'',
            type:''funnel'',
            width: ''40%'',
            data:[
                {value:60, name:''访问''},
                {value:40, name:''咨询''},
                {value:20, name:''订单''},
                {value:80, name:''点击''},
                {value:100, name:''展现''}
            ]
        },
        {
            name:''金字塔'',
            type:''funnel'',
            x : ''50%'',
            sort : ''ascending'',
            itemStyle: {
                normal: {
                    // color: 各异,
                    label: {
                        position: ''left''
                    }
                }
            },
            data:[
                {value:60, name:''访问''},
                {value:40, name:''咨询''},
                {value:20, name:''订单''},
                {value:80, name:''点击''},
                {value:100, name:''展现''}
            ]
        }
    ]
};
                    

        // 使用刚指定的配置项和数据显示图表。
        ldChart.setOption(option);
    </script>
</div>
</div>' ; 
UPDATE ins_column_def T SET T.TEMPLET_ = html WHERE t.COL_ID_='2400000011589005';  
END;
/

-- 20 定义门户

	 		INSERT INTO ins_portal_def(PORT_ID_, NAME_, KEY_, IS_DEFAULT_, USER_ID_, LAYOUT_HTML_, PRIORITY_, EDIT_HTML_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
			values ('2400000007019000', '个人', 'PERSONAL', 'NO', '1', '<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div>
				<div id="msgBox" class="colId_2400000003411003"></div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div>
				<div id="msgBox" class="colId_2400000008039006"></div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span6">
			<div>
				<div id="news" class="colId_2400000004011000"></div>
			</div>
		</div>
		<div class="span6">
			<div>
				<div id="report" class="colId_2400000008759000"></div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
			<div class="span6">
				<div>
					<div id="ldbbt" class="colId_2400000011589005"></div>
				</div>
			</div>
			<div class="span6">
					<div>
						<div id="qxbbt" class="colId_2400000011559004"></div>
					</div>
				</div>
		</div>
</div>', '1', NULL, '1', NULL, NULL, NULL, NULL);

	 		INSERT INTO ins_portal_def(PORT_ID_, NAME_, KEY_, IS_DEFAULT_, USER_ID_, LAYOUT_HTML_, PRIORITY_, EDIT_HTML_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
			values ('2400000007579001', '全局门户', 'GLOBAL-PERSONAL', 'YES', '', '<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div>
				<div id="msgBox" class="colId_2400000003411003"></div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span6">
			<div>
				<div id="myTask" class="colId_2400000003411004"></div>
			</div>
		</div>
		<div class="span6">
			<div>
				<div id="myMsg" class="colId_2400000004021000"></div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div>
				<div id="msgBox" class="colId_2400000008039006"></div>
			</div>
		</div>
	</div>
</div>', '0', NULL, '1', NULL, NULL, NULL, NULL);
commit;
		DECLARE  
		html ins_portal_def.EDIT_HTML_ %TYPE;  
		BEGIN 
		html := '
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					<div class="lyrow ui-draggable" style="display: block;">
									<a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
									<div class="preview">
										<input value="1列(12)" type="text">
									</div>
									<div class="view">
										<div class="row-fluid clearfix">
											<div class="span12 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">消息盒</div><div class="view"><div colid="2400000003411003"><div id="msgBox" class="colId_2400000003411003" colid="2400000003411003">
	<div class="card">
		<ul id="cardUl">
			<li>
            	<a href="/jsaas/bpm/core/bpmInst/myDrafts.do" target="_blank">
					<div class="cardBox" url="/jsaas/bpm/core/bpmInst/myDrafts.do">
						<span class="iconfont   icon-reporting"></span> 
						<span class="card_text">
							<h3>4</h3>
							<h2>我的流程草稿</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			<li>
            	<a href="/jsaas/oa/info/infInbox/receive.do" target="_blank">
					<div class="cardBox" url="/jsaas/oa/info/infInbox/receive.do">
						<span class="iconfont   icon-youxiang01"></span> 
						<span class="card_text">
							<h3>6</h3>
							<h2>我的消息</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			<li>
            	<a href="/jsaas/oa/personal/bpmSolApply/myList.do" target="_blank">
					<div class="cardBox" url="/jsaas/oa/personal/bpmSolApply/myList.do">
						<span class="iconfont   icon-reporting"></span> 
						<span class="card_text">
							<h3>0</h3>
							<h2>流程方案申请</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			<li>
            	<a href="/jsaas/sys/core/sysFile/myMgr.do" target="_blank">
					<div class="cardBox" url="/jsaas/sys/core/sysFile/myMgr.do">
						<span class="iconfont   icon-LDAPguanli"></span> 
						<span class="card_text">
							<h3>1,256</h3>
							<h2>我的附件</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			<li>
            	<a href="/jsaas/oa/res/oaMeetAtt/listOameet.do" target="_blank">
					<div class="cardBox" url="/jsaas/oa/res/oaMeetAtt/listOameet.do">
						<span class="iconfont   icon-user-org-18"></span> 
						<span class="card_text">
							<h3>1</h3>
							<h2>我的会议</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			<li>
            	<a href="/jsaas/oa/personal/bpmInst/myAttends.do" target="_blank">
					<div class="cardBox" url="/jsaas/oa/personal/bpmInst/myAttends.do">
						<span class="iconfont   icon-form_edit"></span> 
						<span class="card_text">
							<h3>105</h3>
							<h2>我的已办</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			<li>
            	<a href="/jsaas/oa/personal/bpmSolApply/myList.do" target="_blank">
					<div class="cardBox" url="/jsaas/oa/personal/bpmSolApply/myList.do">
						<span class="iconfont   icon-reporting"></span> 
						<span class="card_text">
							<h3>0</h3>
							<h2>流程方案申请</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			<li>
            	<a href="/jsaas/bpm/core/bpmTask/myList.do" target="_blank">
					<div class="cardBox" url="/jsaas/bpm/core/bpmTask/myList.do">
						<span class="iconfont   icon-Integrate"></span> 
						<span class="card_text">
							<h3>95</h3>
							<h2>我的待办</h2>
						</span>
						<div class="clearfix"></div>
					</div>
                </a>
			</li>
			
			<h1 class="clearfix"></h1>
		</ul>
	</div>
</div></div></div></div></div>
										</div>
									</div>
								</div><div class="lyrow ui-draggable" style="display: block;">
									<a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
									<div class="preview">
										<input value="1列(12)" type="text">
									</div>
									<div class="view">
										<div class="row-fluid clearfix">
											<div class="span12 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">基础信息</div><div class="view"><div colid="2400000008039006"><div id="msgBox" class="colId_2400000008039006" colid="2400000008039006">
	<div class="card">
		<ul id="cardUl">			
			<li>
				<div class="cardInfo">
					<h3>公司违纪举报电话及邮箱:</h3><br>
					<h2>jichabu@haiya.com.cn</h2>
				</div>
			</li>
			<li>
				<div class="cardInfo">
					<h3>总裁办：</h3><br>
					<h2>0755-26404070 13902987111</h2>
				</div>
			</li>
			<li>
				<div class="cardInfo">
					<h3>总经办：</h3><br>
					<h2>0755-86310367 18923875131</h2>
				</div>
			</li>
			<li>
				<div class="cardInfo">
					<h3>稽查部：</h3><br>
					<h2>0755-86385980 18923876667</h2>
				</div>
			</li>
			<li>
				<div class="cardInfo">
					<h3>人事部：</h3><br>
					<h2>0755-86331013 18923876755</h2>
				</div>
			</li>
			<h1 class="clearfix"></h1>
		</ul>
	</div>
	</div></div></div></div></div>
										</div>
									</div>
								</div><div class="lyrow ui-draggable" style="display: block;">
									<a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
									<div class="preview">
										<input value="2列(6,6)" type="text">
									</div>
									<div class="view">
										<div class="row-fluid clearfix">
											<div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">公司公告</div><div class="view"><div colid="2400000004011000"><div id="news" class="colId_2400000004011000" colid="2400000004011000">
	<div class="widget-box border ">
		<div class="widget-body">
			<div class="widget-scroller">
				<dl class="modularBox">
					<dt>
						<h1>公司公告</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''2400000004011000'',''公司公告'',''/oa/info/insNews/byColId.do?colId=2400000004011000&amp;portal=YES'')">
							<input type="button" id="Refresh" onclick="refresh(''2400000004011000'')">
						</div>
						<div class="clearfix"></div>
					</dt>
						<dd>
							<p><a href="/jsaas/oa/info/insNews/get.do?permit=no&amp;pkId=2400000000002106" target="_blank">2016公司年报</a></p>
						</dd>
						<dd>
							<p><a href="/jsaas/oa/info/insNews/get.do?permit=no&amp;pkId=2400000010679002" target="_blank">test</a></p>
						</dd>
				</dl>
			</div>
		</div>
	</div>
</div></div></div></div></div>
											<div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block; position: relative; opacity: 1; left: 0px; top: 0px;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">柱状报表</div><div class="view"><div colid="2400000008759000"><div id="report" class="colId_2400000008759000" colid="2400000008759000" style="background: #fff;">
<div id="zzbb" style="width: 100%; height: 360px; -webkit-tap-highlight-color: transparent; user-select: none; position: relative; background: transparent;" _echarts_instance_="ec_1508981527557"><div style="position: relative; overflow: hidden; width: 763px; height: 360px; padding: 0px; margin: 0px; border-width: 0px;"><canvas width="763" height="360" data-zr-dom-id="zr_0" style="position: absolute; left: 0px; top: 0px; width: 763px; height: 360px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div></div></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById(''zzbb''));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: ''本月销量''
            },
            tooltip: {},
            legend: {
                data:[''销量'']
            },
            xAxis: {
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
            },
            yAxis: {},
            series: [{
                name: ''销量'',
                type: ''bar'',
                data: [5, 20, 36, 10, 10, 20]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</div>
</div></div></div></div></div>
										</div>
									</div>
								</div>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				<div class="lyrow ui-draggable" style="display: block;">
									<a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
									<div class="preview">
										<input value="2列(6,6)" type="text">
									</div>
									<div class="view">
										<div class="row-fluid clearfix">
											<div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">漏斗报表图</div><div class="view"><div colid="2400000011589005"><div id="ldbbt" class="colId_2400000011589005" colid="2400000011589005" style="background: #fff;">
<div id="ldbbtChart" style="width: 100%; height: 360px; -webkit-tap-highlight-color: transparent; user-select: none; position: relative; background: transparent;" _echarts_instance_="ec_1508981527558"><div style="position: relative; overflow: hidden; width: 763px; height: 360px; padding: 0px; margin: 0px; border-width: 0px;"><canvas width="763" height="360" data-zr-dom-id="zr_0" style="position: absolute; left: 0px; top: 0px; width: 763px; height: 360px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div></div></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var ldChart = echarts.init(document.getElementById(''ldbbtChart''));

        // 指定图表的配置项和数据
      option = {
    title : {
        text: ''漏斗图'',
        subtext: ''纯属虚构''
    },
    tooltip : {
        trigger: ''item'',
        formatter: "{a} <br/>{b} : {c}%"
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    legend: {
        data : [''展现'',''点击'',''访问'',''咨询'',''订单'']
    },
    calculable : true,
    series : [
        {
            name:''漏斗图'',
            type:''funnel'',
            width: ''40%'',
            data:[
                {value:60, name:''访问''},
                {value:40, name:''咨询''},
                {value:20, name:''订单''},
                {value:80, name:''点击''},
                {value:100, name:''展现''}
            ]
        },
        {
            name:''金字塔'',
            type:''funnel'',
            x : ''50%'',
            sort : ''ascending'',
            itemStyle: {
                normal: {
                    // color: 各异,
                    label: {
                        position: ''left''
                    }
                }
            },
            data:[
                {value:60, name:''访问''},
                {value:40, name:''咨询''},
                {value:20, name:''订单''},
                {value:80, name:''点击''},
                {value:100, name:''展现''}
            ]
        }
    ]
};
                    

        // 使用刚指定的配置项和数据显示图表。
        ldChart.setOption(option);
    </script>
</div>
</div></div></div></div></div>
											<div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">曲线报表图</div><div class="view"><div colid="2400000011559004"><div id="qxbbt" class="colId_2400000011559004" colid="2400000011559004" style="background: #fff;">
<div id="qxbbtChart" style="width: 100%; height: 360px; -webkit-tap-highlight-color: transparent; user-select: none; position: relative; background: transparent;" _echarts_instance_="ec_1508981527559"><div style="position: relative; overflow: hidden; width: 763px; height: 360px; padding: 0px; margin: 0px; border-width: 0px;"><canvas width="763" height="360" data-zr-dom-id="zr_0" style="position: absolute; left: 0px; top: 0px; width: 763px; height: 360px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div></div></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var qxChart = echarts.init(document.getElementById(''qxbbtChart''));

        // 指定图表的配置项和数据
        option = {
    title : {
        text: ''某楼盘销售情况'',
        subtext: ''纯属虚构''
    },
    tooltip : {
        trigger: ''axis''
    },
    legend: {
        data:[''意向'',''预购'',''成交'']
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: [''line'', ''bar'', ''stack'', ''tiled'']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    xAxis : [
        {
            type : ''category'',
            boundaryGap : false,
            data : [''周一'',''周二'',''周三'',''周四'',''周五'',''周六'',''周日'']
        }
    ],
    yAxis : [
        {
            type : ''value''
        }
    ],
    series : [
        {
            name:''成交'',
            type:''line'',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: ''default''}}},
            data:[10, 12, 21, 54, 260, 830, 710]
        },
        {
            name:''预购'',
            type:''line'',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: ''default''}}},
            data:[30, 182, 434, 791, 390, 30, 10]
        },
        {
            name:''意向'',
            type:''line'',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: ''default''}}},
            data:[1320, 1132, 601, 234, 120, 90, 20]
        }
    ]
};
                    

        // 使用刚指定的配置项和数据显示图表。
        qxChart.setOption(option);
    </script>
</div>
</div></div></div></div></div>
										</div>
									</div>
								</div>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				' ; 
  		UPDATE ins_portal_def T SET T.EDIT_HTML_ = html WHERE t.PORT_ID_='2400000007019000';  
		END;
			/

		DECLARE  
		html ins_portal_def.EDIT_HTML_ %TYPE;  
		BEGIN 
		html := '
					
					
					
					
					
					
					
					<div class="lyrow ui-draggable" style="display: block; position: relative; opacity: 1; left: 0px; top: 0px;">
									<a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
									<div class="preview">
										<input value="1列(12)" type="text">
									</div>
									<div class="view">
										<div class="row-fluid clearfix">
											<div class="span12 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">消息盒</div><div class="view"><div colid="2400000003411003"><div id="msgBox" class="colId_2400000003411003" colid="2400000003411003">
	<div class="card">
		<ul id="cardUl">
			<li style="width: 173.6px;">
            	<a href="/jsaas/bpm/core/bpmTask/myList.do" target="_blank">
				<div class="cardBox" url="/jsaas/bpm/core/bpmTask/myList.do">
					<span class="iconfont   icon-list-50"></span> 
					<span>
						<h3>43</h3><br>
						<h2>我的待办2</h2>
					</span>
					<div class="clearfix"></div>
				</div>
                </a>
			</li>
			<li style="width: 173.6px;">
            	<a href="/jsaas/bpm/core/bpmTask/myList.do" target="_blank">
				<div class="cardBox" url="/jsaas/bpm/core/bpmTask/myList.do">
					<span class="iconfont   icon-bpm-task-50"></span> 
					<span>
						<h3>43</h3><br>
						<h2>我的待办</h2>
					</span>
					<div class="clearfix"></div>
				</div>
                </a>
			</li>
			
			<h1 class="clearfix" style="width: 173.6px;"></h1>
		</ul>
	</div>
	</div></div></div></div></div>
										</div>
									</div>
								</div>
				
				
				
				
				
				
				<div class="lyrow ui-draggable" style="display: block;">
									<a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
									<div class="preview">
										<input value="2列(6,6)" type="text">
									</div>
									<div class="view">
										<div class="row-fluid clearfix">
											<div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">待办列表</div><div class="view"><div colid="2400000003411004"><div id="myTask" class="colId_2400000003411004" colid="2400000003411004">
	<div class="widget-box border ">
		<div class="widget-body">
			<div class="widget-scroller">
				<dl class="modularBox">
					<dt>
						<h1>待办列表</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''2400000003411004'',''待办列表'',''/bpm/core/bpmTask/myList.do'')">
							<input type="button" id="Refresh" onclick="refresh(''2400000003411004'')">
						</div>
						<div class="clearfix"></div>
					</dt>
					<dd id="modularTitle">
						<span class="project_01">
							<p>审批环节</p>
						</span>
						<span class="project_02">
							<p>事项</p>
						</span>
						<span class="project_03">
							<p>日期</p>
						</span>
						<span class="project_04">
							<p>操作</p>
						</span>
						<div class="clearfix"></div>
					</dd>
				</dl>
			</div>
		</div>
	</div>
</div></div></div></div></div>
											<div class="span6 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">我的消息</div><div class="view"><div colid="2400000004021000"><div id="myMsg" class="colId_2400000004021000" colid="2400000004021000">
	<div class="widget-box border ">
		<div class="widget-body">
			<div class="widget-scroller">
				<dl class="modularBox">
					<dt>
						<h1>我的消息</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''2400000004021000'',''我的消息'',''/oa/info/infInbox/receive.do'')">
							<input type="button" id="Refresh" onclick="refresh(''2400000004021000'')">
						</div>
						<div class="clearfix"></div>
					</dt>
				</dl>
			</div>
		</div>
	</div>
</div></div></div></div></div>
										</div>
									</div>
								</div>
				<div class="lyrow ui-draggable" style="display: block;">
									<a href="#close" class="remove label label-important"><i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span>
									<div class="preview">
										<input value="1列(12)" type="text">
									</div>
									<div class="view">
										<div class="row-fluid clearfix">
											<div class="span12 column ui-sortable"><div class="box box-element ui-draggable" style="display: block;"><a href="#close" class="remove label label-important"> <i class="icon-remove icon-white"></i>删除</a> <span class="drag label"><i class="icon-move"></i>拖动</span><div class="preview">基础信息</div><div class="view"><div colid="2400000008039006"><div id="msgBox" class="colId_2400000008039006" colid="2400000008039006">
	<div class="card_msg">
		<ul id="cardUl">			
			<li class="p_top">
				<div class="cardInfo">
					<h3>公司违纪举报电话及邮箱</h3>
					<h2>jichabu@haiya.com.cn</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>总裁办</h3>
					<h2>0755-26404070 13902987111</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>总经办</h3>
					<h2>0755-86310367 18923875131</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>稽查部</h3>
					<h2>0755-86385980 18923876667</h2>
				</div>
			</li>
			<li class="p_top">
				<div class="cardInfo">
					<h3>人事部</h3>
					<h2>0755-86331013 18923876755</h2>
				</div>
			</li>
			<h1 class="clearfix"></h1>
		</ul>
	</div>
</div></div></div></div></div>
										</div>
									</div>
								</div>' ; 
  		UPDATE ins_portal_def T SET T.EDIT_HTML_ = html WHERE t.PORT_ID_='2400000007579001';  
		END;
			/



