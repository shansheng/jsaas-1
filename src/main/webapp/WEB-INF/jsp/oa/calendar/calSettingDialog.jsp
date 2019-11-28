<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[工作日历]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		 <div region="south" showSplit="false" showHeader="false" height="46" showSplitIcon="false"  style="width:100%">
			 <div class="southBtn">
			     	<a class="mini-button"    onclick="onOk()">确定</a>
				    <a class="mini-button btn-red"  onclick="onCancel()">取消</a>
			 </div>
		 </div>
		 <div  region="center" showHeader="false" showCollapseButton="false">
			 <div class="mini-toolbar" >
				 <div class="searchBox">
					 <form action="" id="searchForm" class="search-form">
						 <ul>
							 <li><span class="text">日历名称：</span><input class="mini-textbox" name="Q_calName_S_LK"></li>
							 <li class="liBtn">
								 <a class="mini-button"  plain="true" onclick="searchFrm()">查询</a>
								 <a class="mini-button btn-red"  plain="true" onclick="clearForm()">清空查询</a>
							 </li>
						 </ul>
					 </form>
				 </div>
		     </div>
     
	
			<div class="mini-fit" style="height: 100%;">
				<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
					url="${ctxPath}/oa/calendar/calSetting/tenantList.do" idField="settingId"
					<c:choose><c:when test="${single }">multiSelect="false"</c:when><c:otherwise>multiSelect="true"</c:otherwise></c:choose>
					 showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
					<div property="columns">
						<div type="checkcolumn" width="30"></div>
						<div field="calName" width="120" headerAlign="center" allowSort="true">日历名称</div>
						<div field="isCommon" width="120" headerAlign="center" allowSort="true" renderer="onIsCommonRenderer">是否默认</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var grid=mini.get("datagrid1");
		grid.on("drawcell", function (e) {
            var record = e.record,
	        field = e.field,
	        value = e.value;
         
            if (record.isCommon=='YES') {
                e.rowCls = "myrow";
            }
        });
		
		function GetData(){
			return  grid.getSelecteds();
		}	
		
		function onOk(){
			var rtn=GetData();
			if(rtn.size==0){
				alert("请选择工作日历!");
				return;
			}
			CloseWindow("ok");
		}
		
		function onCancel(){
			CloseWindow("cancel");
		}
		
		function onIsCommonRenderer(e) {
	            var record = e.record;
	            var isCommon = record.isCommon;
	             var arr = [{'key' : 'YES', 'value' : '是','css' : 'green'}, 
	    			        {'key' : 'NO','value' : '否','css' : 'red'} ];
	    			return $.formatItemValue(arr,isCommon);
	        }
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.calendar.entity.CalSetting" winHeight="450" winWidth="700"
		entityTitle="工作日历" baseUrl="oa/calendar/calSetting" />
</body>
</html>