<%-- 
    Document   : 已收消息的List页面,收的是InnerMsg
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
	<title>我收到的消息</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-toolbar" >
	<div class="searchBox">
		<form id="searchForm" class="search-form" >
			<ul>
				<li>
					<span class="text">状态： </span><input name="Q_isRead_S_LK" class="mini-combobox" data="[{id:'yes',text:'已读'},{id:'no',text:'未读'}]"/>
				</li>
				<li>
					<span class="text">发件人： </span><input name="Q_sender_S_LK" class="mini-textbox" />
				</li>
				<li class="liBtn">
					<a class="mini-button " onclick="searchForm(this)" >搜索</a>
					<a class="mini-button  btn-red" onclick="onClearList(this)">清空</a>
					<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
				</li>
			</ul>
			<div id="moreBox">
				<ul>
					<li>
						<span class="text">时间 从：</span><input name="Q_startTime_D_GT" class="mini-datepicker" value="" format="yyyy-MM-dd" />
					</li>
					<li>
						<span class="text-to">至：</span><input name="Q_endTime_D_LT" class="mini-datepicker" value="" format="yyyy-MM-dd" />
						<input type="hidden" name="crsf_token" class="mini-hidden"  value="${sessionScope.crsf_token}"/>
					</li>
				</ul>
			</div>
		</form>
	</div>
	<ul class="toolBtnBox">
		<li>
			<a class="mini-button"   onclick="sendMsg()">发送信息</a>
		</li>
		<li>
			<a class="mini-button"   target='_self' href='${ctxPath}/oa/info/infInbox/receive.do'>已收信息</a>
		</li>
		<li>
			<a class="mini-button"   target='_self' href='${ctxPath}/oa/info/infInbox/send.do'>已发信息</a>
		</li>
		<li>
			<a class="mini-button"   target='_self' href='${ctxPath}/oa/info/infInbox/groupMsg.do'>组消息</a>
		</li>

		<li>
			<a class="mini-button"   onclick="clearSearch()">刷新</a>
		</li>
		<li>
			<a class="mini-button  btn-red"   onclick="remove()">删除</a>
		</li>
	</ul>
	<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
</div>
<div class="mini-fit " style="height: 100%;">
	<div
			id="datagrid1"
			class="mini-datagrid"
			style="width: 100%; height: 100%;"
			allowResize="false"
			url="${ctxPath}/oa/info/infInbox/received.do"
			idField="msgId"
			multiSelect="true"
			showColumnsMenu="true"
			onrowdblclick="onRowDblClick"
			sizeList="[5,10,20,50,100,200,500]"
			pageSize="20"
			ondrawcell="onDrawCell"
			allowAlternating="true"
			pagerButtons="#pagerButtons"
	>
		<div property="columns">
			<div type="checkcolumn" width="20" allowSort="false"></div>
			<div name="status" field="status" cellCls="actionIcons" width="22"
				 headerAlign="" align="" allowSort="false"
				 cellStyle="padding:0;">状态</div>
			<div name="action" cellCls="actionIcons" width="80"
				 headerAlign="" align="left" renderer="onActionRenderer"
				 cellStyle="padding:0;">操作</div>
			<div field="content"  headerAlign="" width="150" allowSort="false"
				 allowSort="true">消息内容</div>
			<div field="category" width="50" headerAlign="" allowSort="false"
				 allowSort="true">消息分类</div>
			<div field="sender" width="50" headerAlign=""
				 allowSort="true">发送人名</div>
			<div field="createTime" width="50" headerAlign="" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">收到时间</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	mini.parse();
	var grid = mini.get("datagrid1");
	grid.load();
	//清空搜索
	function clearSearch1(e) {
		var form = new mini.Form('searchForm');
		form.clear();
	}
	//搜索
	function search1(e) {
		var button = e.sender;
		var el = button.getEl();
		var form = $(el).parents('form');

		if (form != null) {
			var formData = form.serializeArray();
			var data = {};
			//加到查询过滤器中
			data.filter = mini.encode(formData);

			data.pageIndex = grid.getPageIndex();
			data.pageSize = grid.getPageSize();
			data.sortField = grid.getSortField();
			data.sortOrder = grid.getSortOrder();
			grid.load(data);
		}

	}
	//行功能按钮
	function onActionRenderer(e) {
		var record = e.record;
		var pkId = record.msgId;
		var s = '<span class="" title="明细" onclick="readMsg(\'' + pkId + '\')">明细</span>'
				+ ' <span class="" title="删除" onclick="delMsg(\'' + pkId + '\')">删除</span>'
		return s;
	}

	//删除消息
	function delMsg(pkId) {
		if (confirm("是否删除这条已发消息?")) {
			_SubmitJson({
				url : "${ctxPath}/oa/info/infInbox/delMsg.do",
				data : {
					pkId : pkId
				},
				method : "POST",
				success : function() {
					grid.load();
				}
			});
		}
	}

	//判断已读未读的图标
	function onDrawCell(e) {
		var record = e.record;
		var isRead = record.isRead;
		if (e.field == "status") {
			if (isRead == "yes") {
				e.cellHtml = '<span class="" style="padding-left: 6px;color: #67C23A;" title="已读">已读</span>';
			} else if (isRead == "no") {
				e.cellHtml = '<span class="" style="padding-left: 6px;color: #F56C6C;"  title="未读">未读</span>';
			} else if (isRead == "group") {
				e.cellHtml = '<span class="" style="padding-left: 6px;color:#E6A23C"  title="组消息">组消息</span>';
			}
		}
	}

	//打开新消息的发送页面
	function sendMsg() {
		_OpenWindow({
			url : "${ctxPath}/oa/info/infInnerMsg/send.do",
			title : "发送新消息",
			width : 800,
			height : 500,
			iconCls:'icon-newMsg',
			allowResize : false,
			showMaxButton:false
		});
	}
	//查看消息
	function readMsg(pkId) {
		_OpenWindow({
			onload : function() {
				_SubmitJson({
					url : "${ctxPath}/oa/info/infInbox/updateStatus.do",
					showMsg : false,
					data : {
						pkId : pkId
					},
					method : "POST",
					success : function() {
					}
				});
			},
			url : "${ctxPath}/oa/info/infInbox/recGet.do?pkId=" + pkId,
			width : 500,
			height : 350,
			title : "消息内容",
			ondestroy : function(action) {
				var pageIndex = grid.getPageIndex();
				var pageSize = grid.getPageSize();
				grid.load({
					pageIndex : pageIndex,
					pageSize : pageSize
				});
			}
		});
	}
	//双击打开查看消息
	function onRowDblClick(e) {
		var record = e.record;
		var pkId = record.msgId;
		_OpenWindow({
			onload : function() {
				_SubmitJson({
					url : "${ctxPath}/oa/info/infInbox/updateStatus.do",
					showMsg : false,
					data : {
						pkId : pkId
					},
					method : "POST",
					success : function() {
					}
				});
			},
			url : "${ctxPath}/oa/info/infInbox/recGet.do?pkId=" + pkId,
			width : 500,
			height : 350,
			title : "消息内容",
			ondestroy : function(action) {
				var pageIndex = grid.getPageIndex();
				var pageSize = grid.getPageSize();
				grid.load({
					pageIndex : pageIndex,
					pageSize : pageSize
				});
			}
		});
	}


	grid.on("drawcell", function (e) {
		var record = e.record,
				field = e.field,
				value = e.value;
		if(field=='content'){
			e.cellHtml= '<a href="javascript:readMsg(\'' + record.pkId + '\')">'+record.content+'</a>';
		}
	});
	grid.on('update',function(){
		_LoadUserInfo();
	});
</script>
<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
<redxun:gridScript gridId="datagrid1"
				   entityName="com.redxun.oa.info.entity.InfInnerMsg" winHeight="450"
				   winWidth="700" entityTitle="消息" baseUrl="oa/info/infInnerMsg" />
</body>
</html>