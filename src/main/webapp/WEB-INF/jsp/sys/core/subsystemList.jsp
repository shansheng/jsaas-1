<%-- 
    Document   : 子系统列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>子系统列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >
				  <ul>
						<li><span class="text">系统名称：</span> <input class="mini-textbox" name="Q_NAME__S_LK"></li>
						<li><span class="text">系统Key：</span> <input class="mini-textbox" name="Q_KEY__S_LK"></li>
						<li class="liBtn">
							<a class="mini-button " onclick="searchForm(this)">搜索</a>
							<a class="mini-button  btn-red" onclick="clearForm(this)">清空搜索</a>
						</li>
				   </ul>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-button"    onclick="add()">新增</a>
			</li>
			<li>
				<a class="mini-button"   onclick="detail()">明细</a>
			</li>
			<li>
				<a class="mini-button"   onclick="edit()">编辑</a>
			</li>
			<li>
				<a class="mini-button btn-red"   onclick="remove()">删除</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
	</div>
	<div class="mini-fit rx-grid-fit" style="height: 100px;">
		<div id="datagrid1" class="mini-datagrid"
			 style="width: 100%; height: 100%;"
			 allowResize="false"
			 url="${ctxPath}/sys/core/subsystem/listData.do"
			 idField="keyVar"
			 multiSelect="true"
			 showColumnsMenu="true"
			 sizeList="[5,10,20,50,100,200,500]" p
			 ageSize="20"
			 allowAlternating="true"
			 pagerButtons="#pagerButtons"
		>
			<div property="columns">
				<div type="checkcolumn" width="20"  headerAlign="center" align="center" ></div>
				<div name="action" cellCls="actionIcons" width="120"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="name" width="140" headerAlign="" allowSort="true" sortField="NAME_">系统名称</div>
				<div field="key" width="120" headerAlign="" >系统Key</div>
				<div field="isDefault" width="120" headerAlign="" allowSort="true" sortField="IS_DEFAULT_">是否缺省</div>
				<div field="status" width="50" headerAlign="" >状态</div>
				<div field="sn" width="50" headerAlign="" allowSort="true" sortField="STATUS_">序号</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
			var isMainTenant='${isMainTenant}';
        	//编辑
	        function onActionRenderer(e) {
	            var record = e.record;
	            var uid = record.pkId;
	            var s='<span  title="明细" onclick="detailRow(\'' + uid + '\')">明细</span>';
	            if(isMainTenant=='YES'){
	            	  s+=' <span  title="编辑" onclick="editRow(\'' + uid + '\')">编辑</span>';
	                  s+= ' <span  title="授予子机构" onclick="allotToSysInst(\'' + uid + '\')">授予子机构</span>';
	                  s+= ' <span  title="删除" onclick="delRow(\'' + uid + '\')">删除</span>';
	            }
	            return s;
	        }
	        
        	function allotToSysInst(pkId){
        		_OpenWindow({
                    url: "${ctxPath}/sys/core/sysInstType/selectDialog.do?subSysId="+pkId,
                    title: "选择机构类型", width: 300, height: 400,
                    ondestroy: function(action) {
                    	if(action=='ok'){
                    		mini.showTips({
                                content: "<b>成功</b> <br/>授权成功",
                                state: 'success',
                                x: 'center',
                                y: 'center',
                                timeout: 3000
                            });
                    	}
                    }
                });
        	}
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.Subsystem" 
	 entityTitle="子系统" baseUrl="sys/core/subsystem"  winHeight="450" winWidth="700"/>
	 <script type="text/javascript">
	 	grid.on('drawcell',function(e){
	 		 var record = e.record,
		        field = e.field,
		        value = e.value;

	            //格式化日期
	            if (field == "isDefault") {
	                if(value=='YES'){
	                	e.cellHtml="<span style='color:green'>是</span>";
	                }else{
	                	e.cellHtml="<span style='color:red'>否</span>";
	                }
	            }
	            
	            if (field == "status"){
	            	if(value=='ENABLED'){
	            		e.cellHtml="<span style='color:green'>启用</span>";
	            	}else{
	            		e.cellHtml="<span style='color:red'>禁用</span>";
	            	}
	            }
	 	});
	 </script>
</body>
</html>