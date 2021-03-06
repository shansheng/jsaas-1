<%-- 
    Document   : [日历模版]列表页
    Created on : 2018-03-22 09:49:46
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[日历模版]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" >
		 <div class="searchBox">
			 <form action="" id="searchForm" class="search-form">
				 <ul>
						<li><span class="text">编码:</span><input class="mini-textbox" name="Q_CODE_S_LK"></li>
						<li><span class="text">名称:</span><input class="mini-textbox" name="Q_NAME_S_LK"></li>
						<li class="liBtn">
                        <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                        <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
                        <span class="unfoldBtn" onclick="no_more(this,'moreBox')">
                            <em>展开</em>
                            <i class="unfoldIcon"></i>
                        </span>
                    	</li>
					</ul>
				 <div id="moreBox">
					 <ul>
						 <li><span class="text">是否系统预置:</span><input 
							class="mini-combobox" 
							name="Q_IS_SYS_S_LK"
						    showNullItem="true"  
						    emptyText="请选择..."
							data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
						/></li>
						<li><span>状态:</span>
						<input 
							class="mini-combobox" 
							name="Q_STATUS_S_LK"
						    showNullItem="true"  
						    emptyText="请选择..."
							data="[{id:'1',text:'启用'},{id:'0',text:'禁用'}]"
						/></li>
					 </ul>
				 </div>
			 </form>
		 </div>
		 <div class="toolBtnBox">
			 <ul>
				<li><a class="mini-button"  plain="true" onclick="add()">增加</a></li>
                <li><a class="mini-button"  plain="true" onclick="edit()">编辑</a></li>
                <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
                <li><a class="mini-button"  plain="true" onclick="back()">返回</a></li>
			 </ul>
		 </div>
		 <span class="searchSelectionBtn" onclick="no_search(this,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/oa/ats/atsCalendarTempl/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="code"  sortField="CODE"  width="120" headerAlign="" allowSort="true">编码</div>
				<div field="name"  sortField="NAME"  width="120" headerAlign="" allowSort="true">名称</div>
				<div field="isSys"  sortField="IS_SYS"  width="120" headerAlign="" allowSort="true" renderer="onIsSysRenderer">是否系统预置</div>
				<div field="status"  sortField="STATUS"  width="120" headerAlign="" allowSort="true" renderer="onStatusRenderer">状态</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		//绘制是否为系统预置
		function onIsSysRenderer(e) {
            var record = e.record;
            var isSys = record.isSys;
             var arr = [{'key' : '1', 'value' : '是','css' : 'red'}, 
    			        {'key' : '0','value' : '否','css' : 'green'}];
    			return $.formatItemValue(arr,isSys);
        }
		
		//绘制状态
		function onStatusRenderer(e) {
            var record = e.record;
            var status = record.status;
             var arr = [{'key' : '1', 'value' : '启用','css' : 'green'}, 
    			        {'key' : '0','value' : '禁用','css' : 'red'}];
    			return $.formatItemValue(arr,status);
        }
		function back(){
			history.back(-1);
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsCalendarTempl" winHeight="450"
		winWidth="700" entityTitle="日历模版" baseUrl="oa/ats/atsCalendarTempl" />
</body>
</html>