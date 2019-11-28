<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>流程实例选择</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-layout" style="width: 100%;height: 100%;">
	<div title="流程实例列表" region="center" showHeader="false" showCollapseButton="false">
		 <div class="mini-toolbar" >
			<div class="searchBox">
				<form id="searchForm" class="search-form" >
					<ul>
						<li>
							<span class="text">发起人：</span>
							<input class="mini-buttonedit" allowInput="false" name="Q_b.CREATE_BY__S_EQ" onbuttonclick="selectUser"/>
						</li>
						<li>
							<span class="text">事项：</span>
							<input class="mini-textbox" name="Q_SUBJECT__S_LK" onenter="onSearch" />
						</li>
						<li>
							<span class="text">状态：</span><input class="mini-combobox"  name="Q_b.STATUS__S_EQ"
							data="[{id:'DRAFTED',text:'草稿'},{id:'RUNNING',text:'运行中'},{id:'SUCCESS_END',text:'成功结束'},
								   {id:'DISCARD_END',text:'作废'},{id:'ABORT_END',text:'异常中止结束'},{id:'PENDING',text:'挂起'}]"/>
						</li>
					</ul>
				</form>
			</div>
			 <ul class="toolBtnBox">
				 <li><a class="mini-button" onclick="onSearch()" >搜索</a></li>
				 <li><a class="mini-button  btn-red"  onclick="onClear()">清空</a></li>
			 </ul>
			 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>

		<div class="mini-fit" style="height: 120%;">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height:100%;" allowResize="false"
				 url="${ctxPath}/bpm/core/bpmInst/listInstBySolId.do?solId=${param.solId}" idField="instId" multiSelect="${param.flag}" showColumnsMenu="true"
				 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
				<div property="columns">
					<div type="checkcolumn" width="20"></div>
					<div field="treeName" width="60" headerAlign="center" >分类</div>
					<div field="subject" sortField="subject_" width="160" headerAlign="center" allowSort="true">事项</div>
					<!-- div field="status" sortField="status_"   width="60" headerAlign="center" allowSort="true">运行状态</div>
					<div field="taskNodes" width="80" headerAlign="center" >当前节点</div>
					<div field="taskNodeUsers"    width="80" headerAlign="center">当前节点处理人</div -->
					<div field="createBy" sortField="create_by_"  width="60" headerAlign="center" allowSort="true">发起人</div>
					<div field="createTime" sortField="create_time_"  width="60" dateFormat="yyyy-MM-dd HH-mm-ss" headerAlign="center" allowSort="true">创建时间</div>
				</div>
			</div>
		</div>
	</div>

	<div id="toolbar1" region="south" height="46" showHeader="false">
		<div class="southBtn">
			<a class="mini-button" plain="true" onclick="CloseWindow('ok');">确定</a>
			<a class="mini-button btn-red"  plain="true" onclick="CloseWindow('cancel');">取消</a>
		</div>
	</div>
</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		
		grid.on("drawcell", function (e) {
            var record = e.record,
	        field = e.field,
	        value = e.value;
            
            if(field=='createBy'){
            	if(value){
            		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>';
            	}else{
            		e.cellHtml='<span style="color:red">无</span>';
            	}
            }
        });
        
        grid.on('update',function(){
        	_LoadUserInfo();
        });
		
		function getInstances(){
			return grid.getSelecteds();
		}
	</script>
</body>
</html>