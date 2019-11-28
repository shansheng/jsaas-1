<%-- 
    Document   : [启动流程日志]列表页
    Created on : 2018-06-29 17:52:12
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[启动流程日志]列表管理</title>
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
						<li><span>启动方案:</span><input class="mini-buttonedit"  showClose="true" oncloseclick="_ClearButtonEdit" onbuttonclick="selectSolution" name="Q_FROM_SOL_ID__S_EQ" ></li>
						<li><span>被启动方案:</span><input class="mini-buttonedit" showClose="true" oncloseclick="_ClearButtonEdit" onbuttonclick="selectSolution" name="Q_TO_SOL_ID__S_EQ"></li>
						<li>
							<span class="text">创建时间从:</span>
							<input class="mini-datepicker" style="width:150px;" name="Q_CREATE_TIME__D_GE" onenter="onSearch"/>
							至
							<input class="mini-datepicker" style="width:150px;" name="Q_CREATE_TIME__D_LE" onenter="onSearch" />
						</li>

						<li><span>创建人:</span>
							<input  name="Q_TO_SOL_ID__S_LK" class="mini-user"   style="width:auto;"   single="true" />
						
						</li>
						
					</ul>
                  </td>
              </tr>
         </table>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/bpm/core/bpmInstStartLog/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div field="fromNodeName"  sortField="FROM_NODE_NAME_"  width="120" headerAlign="center" allowSort="true">节点名称</div>
				<div field="fromSubject"  sortField="FROM_SUBJECT_" renderer="onInstRenderer" width="120" headerAlign="center" allowSort="true"  >启动主题</div>
				<div field="toSubject"  sortField="TO_SUBJECT_"  width="120" renderer="onInstRenderer"  headerAlign="center" allowSort="true">被启动主题</div>
				<div field="createUser"  sortField="CREATE_USER_"  width="120" headerAlign="center" allowSort="true">创建人</div>
				<div field="createTime"  sortField="CREATE_TIME_" dateFormat="yyyy-MM-dd HH:mm:ss"  width="120" headerAlign="center" allowSort="true">创建时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function selectSolution(e){
			var btn=e.sender;
			openBpmSolutionDialog(true,function(data){
				var row=data[0];
				btn.setText(row.name);
				btn.setValue(row.solId);
			})
		}
		
		function onInstRenderer(e){
			var record = e.record;
            if(e.field=="fromSubject"){
            	var html='<a href="javascript:;" onclick="_ShowBpmInstInfo(\''+record.fromInstId+'\')">'+record[e.field]+'</a>';
            	return html;
            }
            if(e.field=="toSubject"){
            	var html='<a href="javascript:;" onclick="_ShowBpmInstInfo(\''+record.toInstId+'\')">'+record[e.field]+'</a>';
            	return html;
            }
		}
		
		
		
		
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmInstStartLog" winHeight="450"
		winWidth="700" entityTitle="启动流程日志" baseUrl="bpm/core/bpmInstStartLog" />
</body>
</html>