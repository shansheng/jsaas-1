<%-- 
    Document   : [BpmLog]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[BpmLog]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" >
         <table style="width:100%;">
             <tr>
                 <td style="width:100%;">
                     <a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
                     <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                     <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
                 </td>
             </tr>
              <tr>
                  <td class="search-form" >
                     <ul>
						<li><span>方案:</span><input class="mini-buttonedit"  showClose="true" oncloseclick="_ClearButtonEdit" onbuttonclick="selectSolution" name="Q_SOL_ID__S_EQ" ></li>
						
						<li><span>实例ID:</span><input   class="mini-textbox" name="Q_INST_ID__S_EQ" ></li>
						<li>
							<span class="text">创建时间从:</span>
							<input class="mini-datepicker" style="width:150px;" name="Q_CREATE_TIME__D_GE" onenter="onSearch"/>
							至
							<input class="mini-datepicker" style="width:150px;" name="Q_CREATE_TIME__D_LE" onenter="onSearch" />
						</li>

						<li><span>创建人:</span>
							<input  name="Q_CREATE_BY__S_EQ" class="mini-user"   style="width:auto;"   single="true" />
						</li>
						
					</ul>
                  </td>
              </tr>
         </table>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/bpm/core/bpmLog/listData.do" idField="logId" multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]"
			pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="22" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="opContent" width="120" headerAlign="center" allowSort="true">操作内容</div>
				<div field="solId" width="120" headerAlign="center" allowSort="true">解决方案ID</div>
				<div field="instId" width="120" headerAlign="center" allowSort="true">流程实例ID</div>
				<div field="taskId" width="120" headerAlign="center" allowSort="true">流程任务ID</div>
				<div field="logType" width="120" headerAlign="center" allowSort="true">日志分类</div>
				<div field="opType" width="120" renderer="onOpRenderer" headerAlign="center" allowSort="true">操作类型</div>
				
			</div>
		</div>
	</div>

	<script type="text/javascript">
       	//行功能按钮
        function onActionRenderer(e) {
            var record = e.record;
            var uid = record.pkId;
            var s = '<span  title="明细" onclick="detailRow(\'' + uid + '\')"></span>'
                    + ' <span  title="删除" onclick="delRow(\'' + uid + '\')"></span>';
            return s;
        }
       
		function selectSolution(e){
			var btn=e.sender;
			openBpmSolutionDialog(true,function(data){
				var row=data[0];
				btn.setText(row.name);
				btn.setValue(row.solId);
			})
		}
		
		function onOpRenderer(e){
			var record = e.record;
			var json={COMMUTE:"沟通",TASK_TRANSFER:"转办",TASK_REVOKE:"撤销沟通",TASK_REPLY:"任务回复",INST_DISCARD:"作废",
					INST_ACTIVE:"激活实例",INST_PEND:"挂起实例",INST_START:"启动流程",INST_END:"实例结束",INST_DRAFT:"保存草稿"};
			
			return json[record.opType] || record.opType;
		}
	</script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmLog" winHeight="450" winWidth="700" entityTitle="[BpmLog]"
		baseUrl="bpm/core/bpmLog" />
</body>
</html>