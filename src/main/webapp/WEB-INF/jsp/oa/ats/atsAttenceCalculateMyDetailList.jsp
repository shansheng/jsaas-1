<%-- 
    Document   : [考勤计算]列表页
    Created on : 2018-03-28 15:47:59
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>我的[考勤计算]列表管理</title>
<%@include file="/commons/edit.jsp"%>

</head>
<body>
<div class="mini-toolbar" >
         <table style="width:100%;">
             <tr>
                 <td style="width:100%;">
                 <!-- 顶部按钮 -->
						<a class="mini-button"   onclick="searchGrid()" >查询</a>
				        <a class="mini-button"    onclick="exportFile()">导出</a>
                 </td>
             </tr>
              <tr>
                  <td class="search-form" >
						<ul>
							<li id="attenceTypeLi">
								<span>类型:</span>
								<input 
								    id="attenceType"
									class="mini-combobox" 
								    showNullItem="true"  
								    emptyText="请选择..."
									data="[{id:'000',text:'缺卡'},{id:'001',text:'正常'},{id:'002',text:'迟到'},{id:'003',text:'早退'},
									{id:'004',text:'旷工'},{id:'005',text:'加班'},{id:'006',text:'请假'},{id:'007',text:'出差'}]"
								/>
							</li>
							<li>
								<span>考勤日期从:</span>
								<input id="startTime" name="startTime"  class="mini-datepicker" valueType="String"  format="yyyy-MM-dd"  value="${startTime}"/>
								
							</li>
							<li>	
								<span>至: </span>
								<input id="endTime"   name="endTime" class="mini-datepicker" valueType="String" format="yyyy-MM-dd"  value="${endTime}"/>
							</li>
							<li id="abnormityLi" style="display: none;">
								<span>异常:</span> 
								<input 
								    id="abnormity"
									class="mini-combobox" 
								    showNullItem="true"  
								    emptyText="请选择..."
									data="[{id:'0',text:'正常'},{id:'-1',text:'异常'}]"
								/>
							</li>
						</ul>
                  </td>
              </tr>
         </table>
     </div>
				    	
					    	<div id="datagrid3" class="mini-datagrid" style="width: 100%; height: 85%;" allowResize="false"
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
	<script type="text/javascript">
		mini.parse();
		var tenantId='<c:out value='${tenantId}' />';
		
		var datagrid3 = mini.get("datagrid3");
		
		$(function(){
			loadResultDetailGrid();
		})
		
		//查询方法
		function searchGrid(){
			loadResultDetailGrid();
		}
		
		//导出
		function exportFile(){
			location.href = __rootPath+"/oa/ats/atsAttenceCalculate/exportReportMyDetail.do";
		}
		function loadResultDetailGrid(){
			var type = mini.get("attenceType").getValue();
			grid = mini.get("datagrid3");
			grid.setUrl(__rootPath+"/oa/ats/atsAttenceCalculate/getMyDetailList.do");
			grid.load({
				"Q_beginattenceTime_DL":mini.get("startTime").getValue(),
				"Q_endattenceTime_DE":mini.get("endTime").getValue(),
				"type":type,
				"Q_abnormity_S":mini.get("abnormity").getValue()
			});
		}
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsAttenceCalculate" winHeight="450"
		winWidth="700" entityTitle="考勤计算" baseUrl="oa/ats/atsAttenceCalculate" />
</body>
</html>