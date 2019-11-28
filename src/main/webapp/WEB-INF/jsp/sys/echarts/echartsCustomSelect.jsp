<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>图表列表管理</title>
<%@include file="/commons/list.jsp"%>
<style>
.mini-menuitem-inner .mini-menuitem-icon {
	height: 28px;
	line-height: 28px;
}
</style>
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
		 	title="报表分类" 
		 	region="west" width="220" showSplitIcon="true" showCollapseButton="false" showProxy="false"
	 	>
			 <div class="mini-fit">
				<ul id="systree" class="mini-tree"
				            url="${ctxPath}/sys/echarts/echartsCustom/getUserGrantTreeList.do"
				            style="width:100%;" showTreeIcon="true" textField="name" idField="treeId" resultAsTree="false"
				            parentField="parentId" expandOnLoad="true" contextMenu="#treeMenu" onnodeclick="treeNodeClick"></ul>
			 </div>
		 </div>
	    <div region="center" showHeader="false" showCollapseButton="true" >
				    	<div class=" mini-toolbar">
							<div class="searchBox">
								<form id="searchForm">
									<ul>
										<li class="liAuto"><span class="text">名字:</span> <input class="mini-textbox" name="Q_NAME__S_LK"></li>
										<li><span class="text">标识:</span> <input class="mini-textbox" name="Q_KEY__S_LK"></li>
										<li class="liBtn">
											<a class="mini-button " onclick="searchForm(this)">搜索</a>
											<a class="mini-button " onclick="onClearList(this)">清空</a>
										</li>
									</ul>
								</form>
							</div>
							<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
								<i class="icon-sc-lower"></i>
							</span>
		    			 </div>
			<div class="mini-fit">
							<div id="datagrid1" class="mini-datagrid" style="width: 100%;height:100%;" allowResize="false"
								url="${ctxPath}/sys/echarts/echartsCustom/listData.do" idField="id" 
								<c:if test='${multiSelect eq "1"}'>multiSelect="true"</c:if> showColumnsMenu="true"
								sizeList="[5,10,20,50,100]" pageSize="10" allowAlternating="true" pagerButtons="#pagerButtons">
								<div property="columns">
									<div type="checkcolumn" width="20"></div>
									<div name="action" cellCls="actionIcons" width="22" headerAlign="center" align="center" renderer="onActionRenderer"
										cellStyle="padding:0;">操作</div>
									<div field="name" sortField="NAME_" width="120" headerAlign="center" allowSort="true">名字</div>
									<div field="key" sortField="KEY_" width="120" headerAlign="center" allowSort="true">标识</div>
									<div field="echartsType" sortField="ECHARTS_TYPE_" width="120" headerAlign="center" 
										allowSort="true" renderer="onEchartTypeRenderer">图表类型</div>
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
			var key = record.key;
			var s = '<span  title="预览" onclick="preview(\''
					+ key + '\')">预览</span>';
			return s;
		}

		//区分是什么类型的图表
		function onEchartTypeRenderer(e) {
			var record = e.record;
			var type = record.echartsType;
			var s = "";
			if(type == "common"){
				s = "<span>折线/柱状图</span>";
			} else if(type == "Pie"){
				s = "<span>饼图</span>";
			} else if(type == "Gauge"){
				s = "<span>仪表图</span>";
			} else if(type == "Funnel"){
				s = "<span>漏斗图</span>";
			} else if(type == "Radar"){
				s = "<span>雷达图</span>";
			} else if(type == "Heatmap"){
				s = "<span>热力图</span>";
			} else if(type == "Table"){
				s = "<span>表格</span>";
			} else if(type == "WordCloud"){
				s = "<span>字符云</span>";
			}
			return s;
		}

		//预览
		function preview(key) {
			_OpenWindow({
				url : "${ctxPath}/sys/echarts/echartsCustom/preview/"+key+".do",
				title : "预览",
				max : true,
				ondestroy : function(action) {
					if (action == 'ok') {
						grid.reload();
					}
				}
			});
		}
		
		function onOk(){
			CloseWindow('ok');
		}

		//返回选择的信息
		function getCustomChartsInfo() {
			var multiSelect = '${multiSelect}';
			if(multiSelect != ''){
				var rows = mini.get("datagrid1").getSelecteds();
				return rows;
			}
			var row = mini.get("datagrid1").getSelected();
			var dat = {};
			dat.id = row.id;
			dat.key = row.key;
			return dat;
		}

		/**
		 * 获得表格的行的主键key列表，并且用',’分割
		 * @param rows
		 * @returns
		 */
		function _GetKeys(rows) {
			var ids = [];
			for (var i = 0; i < rows.length; i++) {
				ids.push(rows[i].key);
			}
			return ids.join(',');
		}

		function treeNodeClick(e) {
	        var node = e.node;
	        var treeId = node.treeId;
	        categoryId = treeId;
	        var url = __rootPath + "/sys/echarts/echartsCustom/listData.do?Q_TREE_ID__S_EQ=" + treeId + "&treeId=" + treeId;
	        grid.setUrl(url);
	        grid.reload();
	    }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.echarts.entity.SysEchartsCustom" winHeight="450" winWidth="700"
		entityTitle="图形报表查询" baseUrl="sys/echarts/echartsCustom" />
</body>
</html>