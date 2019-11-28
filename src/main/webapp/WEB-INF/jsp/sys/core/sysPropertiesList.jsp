<%-- 
    Document   : [系统参数]列表页
    Created on : 2017-06-21 11:22:36
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[系统参数]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
      <div class="mini-toolbar" >

		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li class="liAuto">
						<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK">
					</li>
					<li>
						<span class="text" >别名：</span><input class="mini-textbox" name="Q_ALIAS__S_LK">
					</li>

					<li class="liBtn">
						<a class="mini-button " onclick="searchFrm()" >搜索</a>
						<a class="mini-button  btn-red" onclick="clearForm()">清空</a>
						<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
					</li>
				</ul>
				<div id="moreBox">
					<ul>
						<li class="liAuto">
							<span class="text" >分类：</span><input class="mini-textbox" name="Q_CATEGORY__S_LK">
						</li>
					</ul>
				</div>
			</form>
		</div>
		  <ul class="toolBtnBox">
			  <li>
				  <a class="mini-button"  plain="true" onclick="add()">新增</a>
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
	<div class="mini-fit" style="height: 100%;">
		<div 
			id="datagrid1" 
			class="mini-datagrid" 
			style="width: 100%; height: 100%;" 
			allowResize="false"
			url="${ctxPath}/sys/core/sysProperties/listAll.do" 
			idField="proId" 
			multiSelect="true" 
			showColumnsMenu="true" 
			sizeList="[5,10,20,50,100,200,500]" 
			pageSize="20" 
			allowAlternating="true" 
			pagerButtons="#pagerButtons"
		>
			<div property="columns">
				<div type="checkcolumn" width="30"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="name"  sortField="NAME_"  width="120" headerAlign="" allowSort="true">名称</div>
				<div field="alias"  sortField="ALIAS_"  width="120" headerAlign="" allowSort="true">别名</div>
				<div field="global"  sortField="GLOBAL_"  width="80" renderer="onRenderer" headerAlign="" allowSort="true">是否全局</div>
				<div field="encrypt"  sortField="ENCRYPT_"  width="80"  headerAlign="" allowSort="true" renderer="onRenderer" >是否加密存储</div>
				<div field="value"  sortField="VALUE_"  width="120" headerAlign="" renderer="onValRenderer"  allowSort="true">参数值</div>
				<div field="category"  sortField="CATEGORY_"  width="120" headerAlign="" allowSort="true">分类</div>
				<div field="description"  sortField="DESCRIPTION_"  width="120" headerAlign="" allowSort="true">描述</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		function onRenderer(e) {
            var record = e.record;
            var field=e.field;
            var val = record[field];
            
            var arr = [ {'key' : 'YES', 'value' : '是','css' : 'green'}, 
			            {'key' : 'NO','value' : '否','css' : 'red'} ];
			
			return $.formatItemValue(arr,val);
        }
		
		function onValRenderer(e){
			var record = e.record;
			var v=record["encrypt"]
			if(v=='YES'){
				return "已加密";
			}
			else{
				return e.value;
			}
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysProperties" winHeight="450"
		winWidth="700" entityTitle="系统参数" baseUrl="sys/core/sysProperties" />
</body>
</html>