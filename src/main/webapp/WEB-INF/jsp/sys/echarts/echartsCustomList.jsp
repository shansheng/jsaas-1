<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>图表列表管理</title>
    <%@include file="/commons/list.jsp" %>
    <script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
    <style>
        .mini-menuitem-inner .mini-menuitem-icon {
            height: 28px;
            line-height: 28px;
        }
        .custom-li-style {
            height: 30px;
            line-height: 30px;
        }
        .icon-jichushuju:before {
            color: orange !important;
        }
    </style>
</head>
<body>
<ul id="treeMenu" class="mini-contextmenu">
    <li   onclick="addCatNodeEChar">新增分类</li>
    <li  onclick="editCatNode">编辑分类</li>
    <c:if test="${superAdmin }"><li  onclick="nodeGrant">控制权限</li></c:if>
    <li  class=" btn-red" onclick="delCatNode">删除分类</li>
</ul>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
    <div
            title="报表分类"
            region="west"
            width="220"
            showSplitIcon="true"
            showCollapseButton="false"
            showProxy="false"
    >
        <div class="treeToolBar">
            <a class="mini-button"   plain="true" onclick="addCatNodeEChar()">新增</a>
            <a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
        </div>
        <div class="mini-fit">
            <ul
                    id="systree"
                    class="mini-tree"
                    url="${ctxPath}/sys/echarts/echartsCustom/getUserGrantTreeList.do"
                    style="width:100%;"
                    showTreeIcon="true"
                    textField="name"
                    idField="treeId"
                    resultAsTree="false"
                    parentField="parentId"
                    expandOnLoad="true"
                    contextMenu="#treeMenu"
                    onnodeclick="treeNodeClick"
            ></ul>
        </div>
    </div>
    <div showHeader="false" showCollapseButton="false">
        <div class="mini-toolbar">
            <ul id="popupAddMenu" class="mini-menu" style="display:none;">
                <li  onclick="createCommonChart('table')" class="custom-li-style">表格</li>
				<li  onclick="createCommonChart('common')" class="custom-li-style">折线/柱状图</li>
				<li  onclick="createCommonChart('pie')" class="custom-li-style">饼图</li>
				<li  onclick="createCommonChart('funnel')" class="custom-li-style">漏斗图</li>
				<li  onclick="createCommonChart('radar')" class="custom-li-style">雷达图</li>
				<li  onclick="createCommonChart('heatmap')" class="custom-li-style">热力图</li>
				<li  onclick="createCommonChart('gauge')" class="custom-li-style">仪表图</li>
				<li  onclick="createCommonChart('wordCloud')" class="custom-li-style">字符云</li>
            </ul>
            <ul id="popupAddMenuExport" class="mini-menu" style="display:none;">
                <li  onclick="doExport(false)">导出选中</li>
                <li  onclick="doExport(true)">导出全部</li>
            </ul>
            <div class="searchBox">
                <form id="searchForm" class="search-form">
                    <ul>
                        <li>
                            <span class="text">名字：</span>
                            <input class="mini-textbox" name="Q_NAME__S_LK">
                        </li>
                        <li>
                            <span class="text">标识：</span>
                            <input class="mini-textbox" name="Q_KEY__S_LK">
                        </li>
                        <li class="liBtn">
                            <a class="mini-button " onclick="searchForm(this)">搜索</a>
                            <a class="mini-button  btn-red" onclick="clearForm()">清空</a>
                        </li>
                    </ul>
                </form>
            </div>
            <ul class="toolBtnBox">
                <li>
                    <a class="mini-menubutton" plain="true" menu="#popupAddMenu">新增</a>
                </li>
                <li>
                    <a class="mini-button" onclick="edit()">编辑</a>
                </li>
                <li>
                    <a class="mini-menubutton" plain="true" menu="#popupAddMenuExport">导出</a>
                </li>
                <li>
                    <a class="mini-button" onclick="doImport">导入</a>
                </li>
                <li>
                    <a class="mini-button btn-red"  onclick="remove()">删除</a>
                </li>
            </ul>
            <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
        </div>
        <div class="mini-fit" style="height: 100%;">
            <div id="datagrid1" class="mini-datagrid"
                 style="width: 100%; height: 100%;" allowResize="false"
                 url="${ctxPath}/sys/echarts/echartsCustom/listData.do" idField="id"
                 multiSelect="true" showColumnsMenu="true"
                 sizeList="[5,10,20,50,100,200,500]" pageSize="20"
                 allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
                    <div name="action" cellCls="actionIcons" width="100"
                          renderer="onActionRenderer"
                         cellStyle="padding:0;">操作
                    </div>
                    <div field="name" sortField="NAME_" width="120" headerAlign=""
                         allowSort="true">名字
                    </div>
                    <div field="key" sortField="KEY_" width="120" headerAlign=""
                         allowSort="true">标识
                    </div>
                    <div field="echartsType" sortField="ECHARTS_TYPE_" width="120"
                         headerAlign="" allowSort="true" renderer="onEchartTypeRenderer">图表类型
                    </div>
					<!-- <div width="240" renderer="renderUrl">Url路径</div> -->
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
        var type = record.echartsType;
        var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>' +
            '<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>' +
            //'<span class="icon-grant" title="权限" onclick="premissionRow(\'' + pkId + '\')"></span>' +
            '<span  title="预览" onclick="preview(\'' + key + '\', \'' + type + '\')">预览</span>';
        return s;
    }
    
    function renderUrl(e){
		var record = e.record;
		return "<span>/sys/echarts/echartsCustom/preview/"+record.key+".do</span>";
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
    function preview(key, type) {
        _OpenWindow({
            url: "${ctxPath}/sys/echarts/echartsCustom/preview/" + key + ".do",
            title: "预览",
            max: true,
            ondestroy: function (action) {
                if (action == 'ok') {
                    grid.reload();
                }
            }
        });
    }
    
    //权限
    function premissionRow(id){
   		var url=__rootPath+'/sys/echarts/echartsPremission/grant.do?singleId='+id;
   		_OpenWindow({
    		url:url,
    		title:'图形报表权限',
    		width:780,
    		height:400,
    		max:false,
    		ondestroy:function(action){
    			if(action!='ok'){
    				return;
    			}
    			mini.showTips({
		            content: "<b>成功</b> <br/>保存成功",
		            state: 'success',
		            x: 'center',
		            y: 'center',
		            timeout: 3000
		        });
    		}
    	});
    }

    function help(pkId) {
        _OpenWindow({
            url: "${ctxPath}/sys/db/sysSqlCustomQuery/help.do?pkId=" + pkId,
            title: "帮助",
            width: 1000,
            height: 375
        });
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

    function createCommonChart(type){
   		var url = "";
   		var title = "";
   		var _pre = "echartsCustomEdit";
   		if(type == 'common'){
   			url = _pre + ".do";
   			title = "自定义柱状图/折线图"
   		} else if(type == 'pie'){
   			url = _pre + "Pie.do";
   			title = "自定义饼图";
   		} else if(type == 'gauge'){
   			url = _pre + "Gauge.do";
   			title = "自定义仪表图";
   		} else if(type == 'table'){
   			url = _pre + "Table.do";
   			title = "自定义表格";
   		} else if(type == "funnel") {
   			url = _pre + "Funnel.do";
   			title = "自定义漏斗图";
   		} else if(type == "heatmap") {
   			url = _pre + "Heatmap.do";
   			title = "自定义热力图";
   		} else if(type == "radar") {
   			url = _pre + "Radar.do";
   			title = "自定义雷达图";
   		} else if(type == "wordCloud") {
   			url = _pre + "WordCloud.do";
   			title = "自定义字符云";
   		}
   		_OpenWindow({
			url : "${ctxPath}/sys/echarts/" + url ,
			title : title,
			width:'100%',
			height:'100%',
			ondestroy : function(action) {
				if (action == 'ok') {
					grid.reload();
				}
			}
		});
   	}

    /**
     * 分类树添加节点。
     * @param e
     * @returns
     */
    function addCatNodeEChar(e) {
        var systree = mini.get("systree");
        var node = systree.getSelectedNode();
        var parentId = node ? node.treeId : 0;
        //findNode("add",node.treeId)
        _OpenWindow({
            title: '报表分类',
            url: __rootPath + '/sys/core/sysTree/edit.do?parentId=' + parentId + '&catKey=CAT_GRAPHIC_REPORT',
            width: 720,
            height: 420,
            ondestroy: function (action) {
                systree.load();
            }
        });
    }


    function treeNodeClick(e) {
        var node = e.node;
        var treeId = node.treeId;
        categoryId = treeId;
        var url = __rootPath + "/sys/echarts/echartsCustom/listData.do?Q_TREE_ID__S_EQ=" + treeId + "&treeId=" + treeId;
        grid.setUrl(url);
        grid.reload();
    }
    
    function nodeGrant(e){
   		var systree=mini.get("systree");
   		var node = systree.getSelectedNode();
   		var treeId=node.treeId;
   		var url=__rootPath+'/sys/echarts/echartsPremission/grant.do?treeId='+treeId;
   		_OpenWindow({
    		url:url,
    		title:'图形报表权限',
    		width:780,
    		height:400,
    		max:false,
    		ondestroy:function(action){
    			if(action!='ok'){
    				return;
    			}
    			mini.showTips({
		            content: "<b>成功</b> <br/>保存成功",
		            state: 'success',
		            x: 'center',
		            y: 'center',
		            timeout: 3000
		        });
    		}
    	});
   	}

    /**
     *导出
     **/
    function doExport(flag){
        var rows = grid.getSelecteds();
        if(rows.length == 0 && !flag){
            alert('请选择需要导出的图形报表！');
            return;
        }
        if(flag){
            rows = grid.getData();
        }
        var ids = _GetKeys(rows);
        jQuery.download(__rootPath+'/sys/echarts/echartsCustom/doExport.do?keys='+ids,{}, 'post');
    }

    /**
     *导入
     **/
    function doImport(){
        _OpenWindow({
            title:'查询导入',
            url:__rootPath+'/sys/echarts/echartsCustom/import1.do',
            height:350,
            width:600,
            ondestroy:function(action){
                grid.reload();
            }
        });
    }

</script>
<redxun:gridScript gridId="datagrid1"
                   entityName="com.redxun.sys.echarts.entity.SysEchartsCustom"
                   winHeight="450" winWidth="700" entityTitle="自定义图形报表"
                   baseUrl="sys/echarts/echartsCustom"/>
</body>
</html>