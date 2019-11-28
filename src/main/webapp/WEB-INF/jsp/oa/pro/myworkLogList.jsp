<%-- 
    Document   : 日志列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>日志列表管理</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>

<div class="mini-toolbar">

	<div class="searchBox">
		<form id="searchForm" class="search-form" >
			<ul>
				<li>
					<span class="text">任务内容：</span><input class="mini-textbox" name="Q_content_S_LK">
				</li>
				<li><span class="text">状态：</span>
					<input
							class="mini-combobox"
							name="Q_status_S_LK"
							showNullItem="true"
							emptyText="请选择..."
							data="[{id:'DRAFT',text:'草稿'},{id:'PENDING',text:'提交'}]"
					/></li>
				<li class="liBtn">
					<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
					<a class="mini-button btn-red"  plain="true" onclick="clearForm()">清空查询</a>
					<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
				</li>

			</ul>
			<div id="moreBox">
				<ul>
					<li>
						<span class="text">开始时间：</span><input  name="Q_startTime_D_GE"  class="mini-datepicker" format="yyyy-MM-dd" />
					</li>
					<li>
						<span class="text">结束时间：</span><input  name="Q_endTime_D_LE"  class="mini-datepicker" format="yyyy-MM-dd" />
					</li>
				</ul>
			</div>
		</form>
	</div>
	<ul class="toolBtnBox">
		<li>
			<a class="mini-button"  plain="true" onclick="addOne()">撰写日志</a>
		</li>
	</ul>
	<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
		<i class="icon-sc-lower"></i>
	</span>
</div>
<div class="mini-fit rx-grid-fit" style="height: 100%;">
	<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
		 idField="taskId" multiSelect="true" showColumnsMenu="true" onrowdblclick="openDetail(e)"
		 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
		<div property="columns">
			<!-- <div type="checkcolumn" width="20"></div> -->
			<div name="action" cellCls="actionIcons" width="70" headerAlign="center" align="center" renderer="onActionRenderer"
				 cellStyle="padding:0;">操作</div>
			<div field="content" width="120" headerAlign="center"  >任务内容</div>
			<div field="startTime" width="120" headerAlign="center"   renderer="onRenderer">开始时间</div>
			<div field="endTime" width="120" headerAlign="center"   renderer="onRenderer">结束时间</div>
			<div field="status" width="120" headerAlign="center" renderer="onStatusRenderer" >状态</div>
			<div field="last" width="120" headerAlign="center"  >耗时(分）</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	mini.parse();
	var grid=mini.get("datagrid1");
	grid.setUrl("${ctxPath}/oa/pro/workLog/myTask.do?");
	grid.load();

	//行功能按钮
	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.pkId;
		var s = '<span  title="明细" onclick="detailMyRow(\'' + pkId + '\')">明细</span>'
				+ ' <span  title="编辑" onclick="_editRow(\'' + pkId + '\')">编辑</span>'
				+ ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
		return s;
	}


	//日志明细
	function detailMyRow(pkId) {
		_OpenWindow({
			url: __rootPath + "/oa/pro/workLog/get.do?pkId=" + pkId,
			title: "日志明细",
			width: 700,
			height: 450,
		});
	}
	//新增
	function addOne() {
		_OpenWindow({
			url: __rootPath+"/oa/pro/workLog/edit.do",
			title: "新增", width: 1024, height: 600,
			ondestroy: function(action) {
				if(action == 'ok' && typeof(addCallback)!='undefined'){
					var iframe = this.getIFrameEl().contentWindow;
					addCallback.call(this,iframe);
				}else if (action == 'ok') {
					grid.reload();
				}
			}
		});
	}

	//渲染时间
	function onRenderer(e) {
		var value = e.value;
		if (value){
			var date = new Date(value);
			return mini.formatDate(date, 'yyyy-MM-dd HH:mm:ss');
		}
		else
			return "暂无";
	}

	//双击打开项目明细
	function openDetail(e){
		e.sender;
		var record=e.record;
		var pkId=record.pkId;
		detailRow(pkId);
	}


	//编辑
	function _editRow(pkId){
		_OpenWindow({
			url: __rootPath+"/oa/pro/workLog/edit.do?pkId="+pkId,
			title: "编辑日志",
			width: 820, height: 470,
			ondestroy: function(action) {
				if (action == 'ok') {
					grid.reload();
				}
			}
		});
	}

	//绘制是否为系统预置
	function onStatusRenderer(e) {
		var record = e.record;
		var status = record.status;
		var arr = [{'key' : 'DRAFT', 'value' : '草稿','css' : 'red'},
			{'key' : 'PENDING','value' : '提交','css' : 'green'}];
		return $.formatItemValue(arr,status);
	}
</script>
<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.pro.entity.WorkLog" winHeight="450" winWidth="700" entityTitle="日志"
				   baseUrl="oa/pro/workLog" />
</body>
</html>