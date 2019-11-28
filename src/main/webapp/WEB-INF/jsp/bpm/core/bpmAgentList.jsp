<%-- 
    Document   : 我的流程代理设置列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>我的流程代理设置列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
<%-- 	<redxun:toolbar entityName="com.redxun.bpm.core.entity.BpmAgent" excludeButtons="popupSearchMenu,popupAttachMenu,popupSettingMenu,fieldSearch" > --%>
	<ul id="popupAddMenu" class="mini-menu" style="display:none;">
		 <li onclick="add()">新建</li>
	     <li onclick="copyAdd()">复制新建</li>
	</ul>

	<div class="mini-toolbar">
		<div class="searchBox">
			<form id="searchForm" class="search-form" >
				<ul>

					<li>
						<span class="text">代理简称：</span>
						<input class="mini-textbox" name="Q_SUBJECT__S_LK"  />
					</li>
					<li>
						<span class="text">代理类型：</span>
						<input
							class="mini-combobox"
							name="Q_TYPE__S_LK"
							showNullItem="true"
							emptyText="请选择..."
							data="[{id:'ALL',text:'全部'},{id:'PART',text:'部分'}]"
						/>
					</li>
					<li class="liBtn">
						<a class="mini-button " onclick="searchForm(this)">搜索</a>
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
							<span class="text">状态：</span>
							<input
									class="mini-combobox"
									name="Q_STATUS__S_LK"
									showNullItem="true"
									emptyText="请选择..."
									data="[{id:'ENABLED',text:'启用'},{id:'DISABLED',text:'禁用'}]"
							/>
						</li>
						<li>
							<span class="text">开始时间：</span>
							<input class="mini-datepicker" name="Q_START_TIME__D_GE"/>
						</li>
						<li style="width: auto">
							<span class="text-to">至：</span>
							<input class="mini-datepicker" name="Q_START_TIME__D_LE"/>
						</li>
					</ul>
				</div>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-menubutton"  plain="true" menu="#popupAddMenu">新增</a>
			</li>
			<li>
				<a class="mini-button"  plain="true" onclick="detail()">明细</a>
			</li>
			<li>
				<a class="mini-button"  plain="true" onclick="edit()">编辑</a>
			</li>
			<li>
				<a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
	</div>


	<div class="mini-fit rx-grid-fit">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" url="${ctxPath}/bpm/core/bpmAgent/listData.do" idField="agentId"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" align="center" headerAlign="center" ></div>
				<div name="action" cellCls="actionIcons" width="80" headerAlign="" align="" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="subject" width="160" headerAlign="" allowSort="true">代理简称</div>
				<div field="toUserId" width="60" headerAlign="" allowSort="true">代理给</div>
				<div field="startTime" width="100" headerAlign="" allowSort="true" dateFormat="yyyy-MM-dd">开始时间</div>
				<div field="endTime" width="100" headerAlign="" allowSort="true" dateFormat="yyyy-MM-dd">结束时间</div>
				<div field="type" width="80" headerAlign="" allowSort="true">代理类型</div>
				<div field="status" width="80" headerAlign="" allowSort="true" renderer="onStatusRenderer">状态</div>
			</div>
		</div>
	</div>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmAgent"
	 winHeight="450" winWidth="700" entityTitle="流程代理设置" baseUrl="bpm/core/bpmAgent" />
	 <script type="text/javascript">
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pkId = record.pkId;
	            var s = '<span class="" title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
	                    + ' <span class="" title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>'
	                    + ' <span class="" title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
	            return s;
	        }
        	
	        function onStatusRenderer(e) {
	            var record = e.record;
	            var status = record.status;
	            
	            var arr = [ {'key' : 'ENABLED','value' : '启用','css' : 'green'}, 
	   		                {'key' : 'DISABLED','value' : '禁用','css' : 'red'}];
	   		    return $.formatItemValue(arr,status);
	        }
        	
        	
	        grid.on("drawcell", function (e) {
	            var record = e.record,
		        field = e.field,
		        value = e.value;
	            var status = record.status;
	            var type=record.type;
	            if(field=='toUserId'){
	            	if(value){
	            		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>';
	            	}else{
	            		e.cellHtml='<span style="color:red">无</span>';
	            	}
	            }
	          
	            if(field=='type'){
	            	if(type=='ALL'){
	            		e.cellHtml='全部';
	            	}else if(type=='PART'){
	            		e.cellHtml='部分';
	            	}
	            }
	        });
	        
	        grid.on('update',function(){
	        	_LoadUserInfo();
	        });

        </script>
</body>
</html>