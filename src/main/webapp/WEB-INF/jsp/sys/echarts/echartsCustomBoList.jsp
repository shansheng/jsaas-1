<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[单据数据列表]列表管理</title>
<%@include file="/commons/list.jsp"%>

</head>
<body>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	<div
				region="south"
				showSplit="false"
				showHeader="false"
				height="46"
				showSplitIcon="false"
				style="width:100%"
		>
			<div class="southBtn">
				<a class="mini-button"   onclick="onOk()">确定</a> 
				<a class="mini-button"   onclick="onCancel()">取消</a>
			</div>
		</div>
	    <div
		 	title="列表分类" 
		 	region="west" width="220" showSplitIcon="true" showCollapseButton="false" showProxy="false"
	 	>
			 <div class="mini-fit">
				 <ul id="systree" class="mini-tree" 
				         	url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BO_LIST" 
				         	style="width:100%;" showTreeIcon="true" textField="name" idField="treeId" resultAsTree="false" 
				         	parentField="parentId" expandOnLoad="true" onnodeclick="treeNodeClick" contextMenu="#treeMenu"></ul>
			 </div>
		 </div>
	    <div region="center" showHeader="false" showCollapseButton="true" >
	        <div class="mini-toolbar" >
				<div class="searchBox">
					<form id="searchForm" class="search-form" >
						<ul>
										<li><span class="text">名称:</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
										<li><span class="text">标识键:</span><input class="mini-textbox" name="Q_KEY__S_LK"></li>
										<li class="searchBtnBox">
											<a class="mini-button _search" onclick="searchFrm()">搜索</a>
											<a class="mini-button _reset" onclick="clearForm()">清空</a>
										</li>
										<li class="clearfix"></li>
									</ul>
					</form>
				</div>
				<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
		     </div>
			<div class="mini-fit">
				<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
								url="${ctxPath}/sys/core/sysBoList/listData.do" 
								idField="id" multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200]" 
								pageSize="20" allowAlternating="true">
								<div property="columns">
									<div type="checkcolumn" width="20"></div>
									<div name="action" cellCls="actionIcons" width="25" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
									<div field="name"  sortField="NAME_"  width="160" headerAlign="center" >名称</div>
									<div field="key"  sortField="KEY_"  width="120" headerAlign="center" >标识键</div>
									<div field="isLeftTree"  sortField="IS_LEFT_TREE_"  width="60" headerAlign="center" renderer="onRenderer" >是否显示左树</div>
									<div field="createTime" dateformat="yyyy-MM-dd"  sortField="CREATE_TIME_"  width="80" headerAlign="center" >创建时间</div>
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
			var uid=record._uid;
			var s = '';
			if(record.isGen=='YES'){
				s+= ' <span title="预览"  onclick="preview(\'' + uid + '\')">预览</span>'; 
			}
			return s;
		}
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysBoList" winHeight="450"
		winWidth="700" entityTitle="单据数据列表" baseUrl="sys/core/sysBoList" />
		
	<script type="text/javascript">
		function preview(uid){
			var row=grid.getRowByUID(uid);
			var url=__rootPath+'/sys/core/sysBoList/'+row.key+'/list.do';
			_OpenWindow({
				title: row.name+'-预览',
				max:true,
				url:url,
				height:500,
				width:800
			});
		}
		
		function onRenderer(e) {
            var record = e.record;
            var val = record[e.field];
            var arr = [ {'key' : 'YES', 'value' : '是','css' : 'green'}, 
			            {'key' : 'NO','value' : '否','css' : 'red'} ];
			return $.formatItemValue(arr,val);
        }
	   	
	   	//按分类树查找数据字典
	   	function treeNodeClick(e){
	   		var node=e.node;
	   		grid.setUrl(__rootPath+'/sys/core/sysBoList/listData.do?treeId='+node.treeId);
	   		grid.load();
	   	}
	   	
	   	function onOk(){
			CloseWindow('ok');
		}

		//返回选择的信息
		function getCustomChartsInfo() {
			var row = mini.get("datagrid1").getSelected();
			var dat = {};
			dat.id = row.id;
			dat.key = row.key;
			return dat;
		}
	</script>
</body>
</html>