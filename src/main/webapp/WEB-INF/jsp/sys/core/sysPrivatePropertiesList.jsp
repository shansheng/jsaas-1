<%-- 
    Document   : [私有参数]列表页
    Created on : 2017-06-21 10:30:22
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[私有参数]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="titleBar mini-toolbar" >
         <ul>
			<li>
				<a class="mini-button"  plain="true" onclick="saveGridData_()">保存</a>
			</li>
			<li>
				<a class="mini-button" iconCls="icon-edit"  onclick="edit()">编辑</a>
			</li>
			<li>
				<a class="mini-button btn-red" iconCls="icon-remove"  onclick="remove()">删除</a>
			</li>
			<li class="clearfix"></li>
		</ul>
		<div class="searchBox">
			<form id="searchForm" class="text-distance" style="display: none;">						
				<ul>
					<li>
						<span class="text">参数ID:</span><input class="mini-textbox" name="Q_PRO_ID__S_LK">
					</li>
					<li>
						<span class="text">私有值:</span><input class="mini-textbox" name="Q_PRI_VALUE__S_LK">
					</li>
					<li class="searchBtnBox">
						<a class="mini-button _search" onclick="searchForm(this)" >搜索</a>
						<a class="mini-button _reset" onclick="onClearList(this)">清空</a>
					</li>
					<li class="clearfix"></li>
				</ul>
			</form>	
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" allowCellEdit="true" allowCellSelect="true"
			url="${ctxPath}/sys/core/sysPrivateProperties/getPrivateProperties.do" idField="id" ondrawcell="onProIdRenderer"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="22" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
				<div field="proId"  sortField="PRO_ID_"  width="120" headerAlign="center" allowSort="true" >参数</div>
				<div field="priValue"  sortField="PRI_VALUE_"  width="120" headerAlign="center" allowSort="true">值
				<input property="editor" class="mini-textbox" style="width:100%;" required="true"/></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')"></span>'
					/* +'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)"></span>' */
					/* +'<span  title="删除" onclick="delRow(\'' + pkId + '\')"></span>' */;
			return s;
		}
		
		function onProIdRenderer(e){
			var record = e.record;
			if(e.field=='proId'){
				$.ajax({
					url:"${ctxPath}/sys/core/sysProperties/getProperties.do",
					type:"post",
					data:{"proId":record.proId},
					async:false,
					success:function (result){
						e.cellHtml="<span style='color:#999;cursor:pointer;' onclick='openPropertiesGet(\""+record.proId+"\")'>"+result.name+"</span>";
					}
				});
			}
			
		}
		
		function openPropertiesGet(proId){
			_OpenWindow({
	        	url: "${ctxPath}/sys/core/sysProperties/get.do?pkId=" + proId,
	            title: "参数明细", 
	            width: '800px',
	            height: '800px',
	        });
		}
		
		function saveGridData_(){
			var grid=mini.get("datagrid1");
			var json = mini.encode(grid.getData());
            var postData={gridData:json};
            $.ajax({
				url:"${ctxPath}/sys/core/sysPrivateProperties/saveGridData.do",
				type:"post",
				data:postData,
				async:false,
				success:function (result){
					if(result.success){
						mini.showTips({
				            content: "<b>成功</b> <br/>数据保存成功",
				            state: 'success',
				            x: 'center',
				            y: 'center',
				            timeout: 3000
				        });
						grid.reload();
					}
				}
			});
            
		}
		
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysPrivateProperties" winHeight="450"
		winWidth="700" entityTitle="私有参数" baseUrl="sys/core/sysPrivateProperties" />
</body>
</html>