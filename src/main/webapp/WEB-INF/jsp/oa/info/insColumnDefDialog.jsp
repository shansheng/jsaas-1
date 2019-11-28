<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[自定义栏目]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		 <div region="south" showSplit="false" showHeader="false" height="46" showSplitIcon="false"  style="width:100%" bodyStyle="border:0">
			<div class="southBtn" >
			     <a class="mini-button"   onclick="onOk()">确定</a>
				 <a class="mini-button btn-red"  onclick="onCancel()">取消</a>
			</div>	 
		 </div>
		 <div  region="center" showHeader="false" showCollapseButton="false">
			 <div class="mini-toolbar" >
		       <div class="searchBox">
				   <form action="" id="searchForm" class="search-form">
					   <ul>
						   <li>
							   <span class="text">栏目名：</span><input class="mini-textbox" name="Q_NAME__S_LK"/>
						   </li>
						   <li>
							   <span class="text">KEY：</span><input class="mini-textbox" name="Q_KEY__S_LK"/>
						   </li>
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
					url="${ctxPath}/oa/info/insColumnDef/listData.do?Q_TYPE__S_NEQ=tabcolumn" idField="colId"
					<c:choose><c:when test="${single }">multiSelect="false"</c:when><c:otherwise>multiSelect="true"</c:otherwise></c:choose>
					 showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
					<div property="columns">
						<div type="checkcolumn" width="30"></div>
						<div field="name"  sortField="NAME_"  width="120" headerAlign="center" allowSort="true">栏目名字</div>
						<div field="key"  sortField="KEY_"  width="120" headerAlign="center" allowSort="true">栏目KEY</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function GetData(){
			var grid=mini.get("datagrid1");
			return  grid.getSelecteds();
		}	
		
		function onOk(){
			var rtn=GetData();
			if(rtn.size==0){
				alert("请选择表间公式!");
				return;
			}
			CloseWindow("ok");
		}
	
		function onCancel(){
			CloseWindow("cancel");
		}
		
		function onModeRenderer(e){
			var record = e.record;
            var isTest = record.isTest;
            
            var arr = [ {'key' : 'YES', 'value' : '是','css' : 'green'}, 
			            {'key' : 'NO','value' : '否','css' : 'red'}];
			
			return $.formatItemValue(arr,isTest);
		}
		
		function onEventRenderer(e){
			 var record = e.record;
	            var action = record.action;
	            
	            var arr = [ {'key' : 'new', 'value' : '新建','css' : 'green'}, 
				            {'key' : 'upd','value' : '更新','css' : 'orange'},
				            {'key' : 'del','value' : '删除','css' : 'red'}];
				
				return $.formatItemValue(arr,action);
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.info.entity.InsColumnDef" winHeight="450"
		winWidth="700" entityTitle="自定义栏目" baseUrl="oa/info/insColumnDef" />
</body>
</html>