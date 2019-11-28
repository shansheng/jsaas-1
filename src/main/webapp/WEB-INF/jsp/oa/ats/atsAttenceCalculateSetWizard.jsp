<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>排班向导</title>
	<%@include file="/commons/edit.jsp"%>
	<!-- 引入ystep样式 -->
	<link rel="stylesheet" href="${ctxPath}/scripts/jquery/plugins/ystep/css/ystep.css"/>
	<!-- 引入ystep插件 -->
	<script src="${ctxPath}/scripts/jquery/plugins/ystep/js/ystep.js"></script>
	<!-- 引入日历插件 -->
	<link href='${ctxPath}/scripts/FullCalender/fullcalendar.css' rel='stylesheet' />
	<link href='${ctxPath}/scripts/FullCalender/fullcalendar.print.css' rel='stylesheet' media='print' />
	<script src='${ctxPath}/scripts/FullCalender/moment.min.js'></script>
	<script src='${ctxPath}/scripts/FullCalender/fullcalendar.min.js'></script>
	<script src='${ctxPath}/scripts/FullCalender/lang-all.js'></script>
	<script src='${ctxPath}/scripts/ats/atsAttenceCalculateSetWizard.js'></script>
	
	<style type="text/css">
		#north{
		
		}
		thead tr{
	color: #83A3B4;
}
.fc-event {
	border: 0px !important;
}


.fc-grid .fc-day-number {
	float: left !important;
	padding-left: 2px;
}

thead tr.fc-first{
	background: #E8EDEE;
}

.fc-day-number{
	color: #797979;
	font-size: 14px;
	font-weight: 800;
	opacity: 0.2
}
.fc-state-highlight{
	background-color: white !important;
}
.gray-color{
	background-color:rgba(119, 119, 119, 0.43)  !important;
}
.litterGreen-color{
	background-color: rgba(0, 197, 167, 1) !important;
}
.buttom_margin{
	margin-top: -12px !important;
	margin-bottom: 10px !important;
}

th.ui-th-column div{
    white-space:normal !important;
     height:auto !important;
     padding:0px;
	text-align:center;
}
.list-gridcell{
background-color:#337ab7 ;color: #fff;cursor:pointer;
}
.mini-toolbar{
 	margin-left:6px;
	 margin-top:6px;
}

	</style>
</head>
<body>
		<div id="layout1" class="mini-layout" style="width:100%;height:100%;" >
		    <div 
		    	title="north" 
		    	region="north" 
		    	height="120" 
		    	showSplitIcon="false" 
		    	showHeader="false"
		    	class="north-top"
	    	>
		    	<div class="mini-toolbar">
                    <a class="mini-button" plain="true" onclick="refresh()">刷新</a>
                    <span class="separator"></span>
                    <a class="mini-button"  plain="true" onclick="prevStep()">上一步</a>
                    <a class="mini-button"  plain="true" onclick="nextStep()">下一步</a>
                    <a id="save" class="mini-button"  plain="true" onclick="onSave()">保存</a>
			     </div>
		    	<div class="ystep1" style="padding-left:8px;padding-top:2px;"></div>
		    </div>
		    <div region="center" showHeader="false" showSplitIcon="false" style="border:0;" bodyStyle="border:0;">
		    	<div class="mini-fit">
			    	<div id="tabs1" class="mini-tabs" onactivechanged="onTabsActiveChanged" style="width:100%;height:100%">
				    	<div id="step0" title="选择排班方式" iconCls="icon-info" style="background: #fff ">
							   <div>
									<label><input type="radio" id="shiftType1" name="shiftType" value="1" checked="checked"> &nbsp;&nbsp;日历式排班 </label>
									<span class="help-block" var="shiftType1">适合的排班场景为所选员工使用相同轮班或排班规则。</span>
								</div>
								<div>
									<label><input type="radio" id="shiftType2" name="shiftType" value="2"> &nbsp;&nbsp;列表式排班 </label>
									<span class="help-block" var="shiftType2">
										<ul>
											<li>适用的排班场景为所选员工使用相同或不同的轮班或排班规则。 </li>
											<li>可支持所选人员使用相同的轮班或排班规则。</li>
											<li>可支持不同人员使用相同的轮班规则但不同的起始点。 </li>
											<li>可支持不同人员使用不同的轮班或排班规则。</li>
										</ul>
									</span>
								</div>
						</div>
					    <div 
					    	id="step1" 
					    	title="设置时间" 
					    	iconCls="icon-flow" 
					    	url=""
				    	>
							<div class="form-toolBox">
								开始时间：<input id="startDate" class="mini-datepicker" valueType="String" />
								结束时间：<input id="endDate" class="mini-datepicker" valueType="String" />
							</div>
				    	</div>
					    <div 
					    	id="step2" 
					    	title="选择人员" 
					    	iconCls="icon-form" 
					    	<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
					    	url="${ctxPath}/oa/ats/atsAttenceCalculateSet/userList.do"
				    	></div>
						
					   	<div 
					   		id="step3" 
					   		title="排班设置" 
					   		iconCls="icon-var" 
					   		<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
					   		url=""
				   		>
				   		<div class="mini-toolbar" >
                    		<a class="mini-button" plain="true" href="javascript:addShiftRule();">新增轮班规则</a>
                    	</div>
				   			<!-- 日历式排班 -->
							<div id="scheduleCalendar">
								<div class="col-md-3">
								  	<div  id="userlist" class="user-list"> </div>
								</div>
								 <div class="col-md-9">
								  	<div id ="calendarScheduleInfo" class="calendar-info">
							           <div id="calendar_info" ></div>
								 	</div>
							  	</div>
							</div>
							<!-- 列表式排班 -->
							<!-- <div  id="scheduleList"> -->
								<div  id="scheduleList" class="mini-fit" style="height: 100%;">
									<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
									    idField="id" 
										multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
									</div>
								</div>
							<!-- </div> -->
				   		</div>
					    <div 
					    	id="step4" 
					    	title="完成"
					    	iconCls="icon-user"
					    	<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
					    	url=""
				    	>
					    	<div class="mini-fit" style="height: 100%;">
								<div id="datagrid2" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
									idField="id"
									multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
									<div property="columns">
										<div field="userName"   width="120" headerAlign="center" allowSort="true">用户名</div>
										<div field="orgName"   width="120" headerAlign="center" allowSort="true">组织名称</div>
										<div field="attenceTime"   width="120" headerAlign="center" allowSort="true">考勤时间</div>
										<div field="dateType"   width="120" headerAlign="center" allowSort="true" renderer="onIsAttendanceRenderer">日期类型</div>
										<div field="shiftName"   width="120" headerAlign="center" allowSort="true">班次名称</div>
										<div field="cardNumber"  width="120" headerAlign="center" allowSort="true">考勤编号</div>
										<div field="policyName"   width="120" headerAlign="center" allowSort="true">考勤制度</div>
										<div field="cardRuleName"    width="120" headerAlign="center" allowSort="true">取卡规则</div>
									</div>
								</div>
							</div>
				    	</div>
					</div>
				</div>
		    </div>
		</div>
	
	<script type="text/javascript">
		mini.parse();
		var tabs=mini.get('tabs1');
		var curStep=0;
		
		$(function(){
			$(".ystep1").loadStep({
			      size: "large",
			      color: "blue",
			      steps: [{
			        title: "排班方式",
			        content: "初始化流程解决方案"
			      },{
			        title: "设置时间",
			        content: "进行流程定义的设计，并且进行发布"
			      },
			     
			      {
			        title: "选择人员",
			        content: "绑定或设计跟流程相关的业务展示表单方案"
				  },
				  
			      {
				        title: "排班设置",
				        content: "设置流程各环节的流程需要使用的变量"
				  },
			      {
			        title: "完成",
			        content: "绑定流程节点的执行人员"
			      }
			      ]
			    });
			
			//$(".ystep1").setStep(curStep);
			//把当前步骤前面的tab更新为可用
			for(var i=0;i<curStep;i++){
				var tab=tabs.getTab(i);
				tabs.updateTab(tab,{enabled:true});
			}
			var curTab=tabs.getTab(curStep);
			tabs.activeTab(curTab);
		});
		
		function onSave() {
			//CloseWindow();
			location.href="${ctxPath}/oa/ats/atsScheduleShift/list.do";
		}
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsAttenceCalculateSet" winHeight="450"
		winWidth="700" entityTitle="考勤计算设置" baseUrl="oa/ats/atsAttenceCalculateSet" />
</body>
</html>