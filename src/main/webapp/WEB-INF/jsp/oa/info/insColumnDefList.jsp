<%-- 
    Document   : [ins_column_def]列表页
    Created on : 2017-08-16 11:39:47
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>栏目列表管理</title>
    <%@include file="/commons/list.jsp" %>
    <script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
</head>
<body>
<ul id="treeMenu" class="mini-contextmenu">
    <li   onclick="addCatNodeDef">新增分类</li>
    <li  onclick="editCatNode">编辑分类</li>
    <li  class=" btn-red" onclick="delCatNode">删除分类</li>
</ul>

<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
    <div
            title="栏目分类"
            region="west"
            width="220"
            showSplitIcon="true"
            showCollapseButton="false"
            showProxy="false"
    >
        <div class="treeToolBar">
            <a class="mini-button"   plain="true" onclick="addCatNodeDef()">新增</a>
            <a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
        </div>
        <div class="mini-fit">
            <ul
                    id="systree"
                    class="mini-tree"
                    url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_POTAL_COLUMN"
                    style="width:100%;"
                    showTreeIcon="true"
                    textField="name"
                    idField="treeId"
                    resultAsTree="false"
                    parentField="parentId"
                    expandOnLoad="true"
                    onnodeclick="treeNodeClick"
                    contextMenu="#treeMenu"
            ></ul>
        </div>
    </div>


    <div showHeader="false" showCollapseButton="false">
        <div class="mini-toolbar">
            <div class="searchBox">
                <form id="searchForm" class="search-form">
                    <ul>
                        <li class="liAuto">
                            <span class="text">栏目名：</span><input class="mini-textbox" name="Q_NAME__S_LK">
                        </li>
                        <li>
                            <span class="text">KEY：</span><input class="mini-textbox" name="Q_KEY__S_LK">
                        </li>
                        <li class="liBtn">
                            <a class="mini-button " onclick="searchFrm()">搜索</a>
                            <a class="mini-button  btn-red" onclick="clearForm()">清空</a>
                        </li>
                    </ul>
                </form>
            </div>
            <ul class="toolBtnBox">
                <li>
                    <a class="mini-button"  onclick="add()">新增</a>
                </li>
                <li>
                    <a class="mini-button"  onclick="edit(true)">编辑</a>
                </li>
                <li>
                    <a class="mini-button" onclick="doExport">导出</a>
                </li>
                <li>
                    <a class="mini-button" onclick="doImport">导入</a>
                </li>
                <li>
                    <a class="mini-button btn-red" onclick="remove()">删除</a>
                </li>
            </ul>
            <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
        </div>
        <div class="mini-fit" style="height: 100%;">
            <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
                 url="${ctxPath}/oa/info/insColumnDef/listData.do" idField="colId"
                 multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20"
                 allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
                    <div name="action" cellCls="actionIcons" width="100"
                         renderer="onActionRenderer" cellStyle="padding:0;">操作
                    </div>
                    <div field="name" sortField="NAME_" width="120"  allowSort="true">栏目名字</div>
                    <div field="key" sortField="KEY_" width="120" headerAlign="" allowSort="true">栏目KEY</div>
                    <div field="function" sortField="FUNCTION_" width="120" headerAlign="" allowSort="true">调用方法</div>
                    <div field="isMobile" sortField="IS_MOBILE_" width="80" headerAlign="center" align="center" allowSort="true" renderer="isMobileRenderer">是否移动端栏目</div>

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
        var isNews = record.isNews;
        var name = record.name;
        var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
            +'<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
            +'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
        if (isNews == "YES") {
            s += '<span  title="管理公告" onclick="mgrNews(\'' + pkId + '\',\'' + name + '\')">管理公告</span>'
        }
        return s;
    }

    function isMobileRenderer(e){
		var record = e.record;
		var isMobile = record.isMobile;
		return "<span>" + (isMobile == 1 ? "是" : "否") + "</span>";
	}

    function mgrNews(colId, name) {
        top['index'].showTabFromPage({
            title: name + '-信息公告',
            tabId: 'colNewsMgr_' + colId,
            url: __rootPath + '/oa/info/insNews/byColId.do?colId=' + colId
        });
    }
    /**
     * 分类树添加节点。
     * @param e
     * @returns
     */
    function addCatNodeDef(e){
        var systree=mini.get("systree");
        var node = systree.getSelectedNode();
        var parentId=node?node.treeId:0;
        //findNode("add",node.treeId)
        _OpenWindow({
            title:'新增表单视图分类',
            url:__rootPath+'/sys/core/sysTree/edit.do?parentId='+parentId+'&catKey=CAT_POTAL_COLUMN',
            width:720,
            height:350,
            ondestroy:function(action){
                systree.load();
            }
        });
    }


    function treeNodeClick(e){
        var node=e.node;
        var treeId=node.treeId;
        categoryId=treeId;
        var url=__rootPath +"/oa/info/insColumnDef/listData.do?Q_TREE_ID__S_EQ="+treeId;
        grid.setUrl(url);
        grid.reload();
    }

    function doExport(){
        var grid1 = mini.get("datagrid1");
        var rows = grid1.getSelecteds();
        if(rows.length == 0){
            mini.alert("请选择导出的栏目。");
            return;
        }
        var ids = new Array();
        for(var i = 0; i < rows.length; i++){
            ids.push(rows[i].pkId);
        }
        ids = ids.join();
        /*_OpenWindow({
            title: '门户Portal栏目导出',
            url: '${ctxPath}/oa/info/insColumnDef/export.do?ids=' + ids,
            height: 350,
            width: 600
        });*/
        var options = "";
        jQuery.download(__rootPath + '/oa/info/insColumnDef/doExport.do?ids=' + ids, {expOptions:options},'post');
    }

    function doImport(){
        _OpenWindow({
            title: '门户Portal栏目导入',
            url: '${ctxPath}/oa/info/insColumnDef/import1.do',
            height: 350,
            width: 600
        });
    }
</script>
<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.info.entity.InsColumnDef" winHeight="450"
                   winWidth="700" entityTitle="自定义栏目" baseUrl="oa/info/insColumnDef"/>
</body>
</html>