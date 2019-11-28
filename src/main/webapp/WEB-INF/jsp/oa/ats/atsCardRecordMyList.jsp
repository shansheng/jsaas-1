<%-- 
    Document   : [打卡记录]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>我的[打卡记录]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		 <div class="searchBox">
			 <form action="" id="searchForm" class="search-form">
				 <ul>
					 <li><span class="text">打卡来源:</span>
						 <input
								 class="mini-combobox"
								 name="Q_CARD_SOURCE_S_LK"
								 showNullItem="true"
								 emptyText="请选择..."
								 data="[{id:'1',text:'企业微信'},{id:'0',text:'补打卡'},{id:'2',text:'EXCEL'}]"
						 /></li>
					 <li><span class="text">打卡位置:</span><input class="mini-textbox" name="Q_CARD_PLACE_S_LK"></li>
					 <li class="liBtn">
						 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
						 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
					 </li>
				 </ul>
				 <div id="moreBox">
					 <ul>
						 <li>
							 <span class="text">打卡日期 从</span>:<input  name="Q_CARD_DATE_D_GE"  class="mini-datepicker" format="yyyy-MM-dd" style="width:100px"/>
						 </li>
						 <li>
							 <span class="text">至: </span><input  name="Q_CARD_DATE_D_LE" class="mini-datepicker" format="yyyy-MM-dd" style="width:100px" />
						 </li>
					 </ul>
				 </div>
			 </form>
		 </div>
		 <div class="toolBtnBox">
			 <a class="mini-button" plain="true" onclick="exportData()">导出</a>
		 </div>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsCardRecord/myListData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div field="cardNumber"   width="120" headerAlign="" allowSort="false">考勤编号</div>
				<div field="cardDate" sortField="CARD_DATE"  width="120" headerAlign="" allowSort="true" renderer="onDateRenderer">打卡日期</div>
				<div field="cardTime"   width="120" headerAlign="" renderer="onTimeRenderer">打卡时间</div>
				<div field="cardSource"  sortField="CARD_SOURCE"  width="120" headerAlign="" allowSort="true" renderer="onCardSourceRenderer">打卡来源</div>
				<div field="cardPlace"  sortField="CARD_PLACE"  width="120" headerAlign="" allowSort="true">打卡位置</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctxPath}/scripts/ats/atsShare.js"></script>
	<script type="text/javascript">
		
		function onCardSourceRenderer(e) {
            var record = e.record;
            var cardSource = record.cardSource;
             var arr = [{'key' : '0', 'value' : '补打卡'}, 
    			        {'key' : '1','value' : '企业微信'},
    			        {'key' : '2','value' : 'EXCEL'}];
    			return $.formatItemValue(arr,cardSource);
        }
		
		//导出打卡记录
		function exportData(){
			location.href="${ctxPath}/oa/ats/atsCardRecord/exportMyData.do";
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsCardRecord" winHeight="450"
		winWidth="700" entityTitle="打卡记录" baseUrl="oa/ats/atsCardRecord" />
</body>
</html>