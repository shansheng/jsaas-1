<%-- 
    Document   : [BPM_REG_LIB]列表页
    Created on : 2018-12-25 15:49:05
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[BPM_REG_LIB]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-layout" style="width: 100%;height: 100%">
	<div region="center" showSplitIcon="false" showHeader="false">
		 <div class="mini-toolbar" >
			 <div class="searchBox">
				<form id="searchForm" class="search-form" >
					<ul>
						<li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
						<li><span class="text">别名：</span><input class="mini-textbox" name="Q_KEY__S_LK"></li>
						<li class="liBtn">
							<a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
							<a class="mini-button"   plain="true" onclick="clearForm()">清空查询</a>
							<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
								<em>展开</em>
								<i class="unfoldIcon"></i>
							</span>
						</li>
					</ul>
					<div id="moreBox">
						<ul>
							<li><span class="text">类型：</span>
								<input class="mini-combobox" name="Q_TYPE__S_LK"
									   data="[{id:'0',text:'校验正则'},{id:'1',text:'替换正则'}]"
									   showNullItem="true"
								>
							</li>
						</ul>
					</div>
				</form>
			 </div>
			 <ul class="toolBtnBox">
				 <li><a class="mini-button"  plain="true" onclick="add()">增加</a></li>
				 <li><a class="mini-button"  plain="true" onclick="edit()">编辑</a></li>
				 <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
			 </ul>
			 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		 </div>
		<div class="mini-fit" style="height: 100%;">
			<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
				url="${ctxPath}/bpm/core/bpmRegLib/listData.do" idField="regId"
				multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
				<div property="columns">
					<div type="checkcolumn" width="20" headerAlign="center" align="center" ></div>
					<div name="action" cellCls="actionIcons" width="50"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
					<div field="name"  sortField="NAME_"  width="120"  allowSort="true">名称</div>
					<div field="key"  sortField="KEY_"  width="120"  allowSort="true">别名</div>
					<div field="type"  sortField="TYPE_"  width="120"  allowSort="true" renderer="typeRenderer">类型</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function typeRenderer(e){
			var val = e.value;
			if(val==0){
				return "校验正则";
			}
			if(val==1){
				return "替换正则";
			}
			return "";
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmRegLib" winHeight="450"
		winWidth="700" entityTitle="BPM_REG_LIB" baseUrl="bpm/core/bpmRegLib" />
</body>
</html>