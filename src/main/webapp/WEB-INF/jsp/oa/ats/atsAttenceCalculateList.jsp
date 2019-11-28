<%-- 
    Document   : [考勤计算]列表页
    Created on : 2018-03-28 15:47:59
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[考勤计算]列表管理</title>
<%@include file="/commons/edit.jsp"%>

</head>
<body>
		 <div class="mini-toolbar" >
				<div class="searchBox">
					<form id="searchForm" class="search-form" >						
						<ul>
							<li>
								<span class="text">组织：</span>
								<input id="orgId" name="Q_orgId_L" class="mini-buttonedit icon-dep-button"
								 required="true" allowInput="false" onbuttonclick="selectMainDep"/>
							</li>
							<li>
								<span class="text">姓名：</span>
								<input  id="fullname"  class="mini-textbox" />
							</li>
							<li class="liBtn">
								<a class="mini-button"   onclick="searchGrid()" >查询</a>
								<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
									<em>展开</em>
									<i class="unfoldIcon"></i>
								</span>
							</li>

						</ul>
						<div id="moreBox">
							<ul>
								<li>
									<span class="text">考勤制度：</span>
									<input id="attencePolicy" name="Q_attencePolicy_L" class="mini-buttonedit icon-dep-button" value="${atsAttencePolicy.id}"
										   text="${atsAttencePolicy.name}" required="true" allowInput="false" onbuttonclick="onSelAttencePolicy"/>
								</li>
								<li>
									<span class="text">考勤日期从：</span>
									<input id="startTime" name="startTime"  class="mini-datepicker" valueType="String"  format="yyyy-MM-dd"  value="${startTime}"/>
								</li>
								<li>
									<span class="text-to">至: </span>
									<input id="endTime"   name="endTime" class="mini-datepicker" valueType="String" format="yyyy-MM-dd"  value="${endTime}"/>
								</li>

								<li id="abnormityLi" style="display: none;">
									<span class="text">异常：</span>
									<input
											id="abnormity"
											class="mini-combobox"
											showNullItem="true"
											emptyText="请选择..."
											data="[{id:'0',text:'正常'},{id:'-1',text:'异常'}]"
									/>
								</li>
								<li>
									<span class="text">工号：</span>
									<input  id="userId"   class="mini-textbox" />
								</li>

								<li id="attenceTypeLi" style="display: none;">
									<span class="text">类型：</span>
									<input
											id="attenceType"
											class="mini-combobox"
											showNullItem="true"
											emptyText="请选择..."
											data="[{id:'000',text:'缺卡'},{id:'001',text:'正常'},{id:'002',text:'迟到'},{id:'003',text:'早退'},
									{id:'004',text:'旷工'},{id:'005',text:'加班'},{id:'006',text:'请假'},{id:'007',text:'出差'}]"
									/>
								</li>
							</ul>
						</div>
					</form>
				</div>
				 <ul class="toolBtnBox">
					 <li>
						 <a class="mini-button"    onclick="allCalculate()" >计算全部</a>
					 </li>
					 <li>
						 <a class="mini-button"    onclick="calculateSelect()">计算选中行</a>
					 </li>
					 <li>
						 <a class="mini-button"    onclick="exportFile()">导出</a>
					 </li>
				 </ul>
				 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
	     </div>
		 <div class="mini-fit">
			<div id="tabs1" class="mini-tabs" style="width:100%;height:100%" onactivechanged="onTabsActiveChanged">
				<div id="step0" title="已计算人员" iconCls="icon-info" >
				<div class="mini-fit" style="height: 100%;">
					<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
						idField="id"
						multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="account"    width="120" headerAlign="center" >工号</div>
							<div field="userName"   width="120" headerAlign="center" >姓名</div>
						</div>
					</div>
				</div>
				</div>
				<div
					id="step1"
					title="未计算人员"
					iconCls="icon-flow">
					<div id="datagrid2" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
						idField="id"
						multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="fileId"    width="120" headerAlign="center" >考勤编号</div>
							<div field="account"    width="120" headerAlign="center" >工号</div>
							<div field="userName"    width="120" headerAlign="center" >姓名</div>
							<div field="orgName"  width="120" headerAlign="center" >组织</div>
						</div>
					</div>
				</div>
				<div
					id="step2"
					title="结果明细"
					iconCls="icon-form">
					<div id="datagrid3" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
						idField="id"
						multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
						<div property="columns">
							<div type="checkcolumn" width="20"></div>
							<div field="userName"    width="120" headerAlign="center" >姓名</div>
							<div field="account"    width="180" headerAlign="center" >工号</div>
							<div field="orgName"   width="120" headerAlign="center" >组织</div>
							<div field="attenceTime"  width="120" headerAlign="center" >考勤日期</div>
							<div field="week"  width="120" headerAlign="center" >星期</div>
							<div field="shiftName"  width="120" headerAlign="center" >班次名称</div>
							<div field="abnormity"  width="120" headerAlign="center" >是否异常</div>
							<div field="attenceType"  width="120" headerAlign="center" >类型</div>
							<div field="shiftTime11"  width="120" headerAlign="center" >第一段上班</div>
							<div field="shiftTime12"  width="120" headerAlign="center" >第一段下班</div>
							<div field="shiftTime21"  width="120" headerAlign="center" >第二段上班</div>
							<div field="shiftTime22"  width="120" headerAlign="center" >第二段下班</div>
							<div field="shiftTime31"  width="120" headerAlign="center" >第三段上班</div>
							<div field="shiftTime32"  width="120" headerAlign="center" >第三段下班</div>
						</div>
					</div>
				</div>
			</div>
		 </div>
<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/ats/AtsAttenceCalculate.js"></script>
	<script type="text/javascript">
		var tenantId='<c:out value='${tenantId}' />';
		
		var datagrid3 = mini.get("datagrid3");
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsAttenceCalculate" winHeight="450"
		winWidth="700" entityTitle="考勤计算" baseUrl="oa/ats/atsAttenceCalculate" />
</body>
</html>