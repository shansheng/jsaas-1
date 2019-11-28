<%-- 
    Document   : [表间公式]列表页
    Created on : 2018-08-07 09:06:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>[表间公式]列表管理</title>
    <%@include file="/commons/list.jsp" %>
    <script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
</head>
<body>


<ul id="treeMenu" class="mini-contextmenu">
    <li   onclick="addCatNodeTable">新增分类</li>
    <li  onclick="editCatNode">编辑分类</li>
    <li  class=" btn-red" onclick="delCatNode">删除分类</li>
</ul>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
    <div
        title="公式分类"
        region="west"
        width="220"
        showSplitIcon="true"
        showCollapseButton="false"
        showProxy="false"
    >
        <div class="treeToolBar">
            <a class="mini-button"   plain="true" onclick="addCatNodeTable()">新增</a>
            <a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
        </div>
        <div class="mini-fit">
            <ul
                    id="systree"
                    class="mini-tree"
                    url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_BPM_FROM"
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
                        <li><span class="text">公式名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
                        <li><span class="text">类型：</span>
                            <input name="Q_ACTION__S_EQ" class="mini-combobox"
                                   textField="text" valueField="id"
                                   data="[{id:'new',text:'新建'},{id:'upd',text:'更新'},{id:'del',text:'删除'}]"
                                   showNullItem="true" allowInput="false"/>
                        </li>
                        <li class="liBtn">
                            <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                            <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空</a>
                        </li>
                    </ul>
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
            <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
                 url="${ctxPath}/bpm/form/bpmTableFormula/listData.do" idField="id"
                 multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20"
                 allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div type="checkcolumn" width="30" headerAlign="center" align="center"></div>
                    <div name="action" cellCls="actionIcons" width="100"
                         renderer="onActionRenderer" cellStyle="padding:0;">操作
                    </div>
                    <div field="name" sortField="NAME_" width="150" headerAlign="" allowSort="true">公式名称</div>
                    <div field="action" sortField="ACTION_" width="120" headerAlign="" allowSort="true"
                         renderer="onEventRenderer">触发时机
                    </div>

                    <div field="isTest" sortField="IS_TEST_" width="80" headerAlign="" allowSort="true"
                         renderer="onModeRenderer">调试模式
                    </div>
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
            + '<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
        return s;
    }

    function onModeRenderer(e) {
        var record = e.record;
        var isTest = record.isTest;

        var arr = [{'key': 'YES', 'value': '是', 'css': 'green'},
            {'key': 'NO', 'value': '否', 'css': 'red'}];

        return $.formatItemValue(arr, isTest);
    }

    function onEventRenderer(e) {
        var record = e.record;
        var action = record.action;

        var arr = [{'key': 'new', 'value': '新建', 'css': 'green'},
            {'key': 'upd', 'value': '更新', 'css': 'orange'},
            {'key': 'del', 'value': '删除', 'css': 'red'}];

        return $.formatItemValue(arr, action);
    }


    function treeNodeClick(e){
        var node=e.node;
        var treeId=node.treeId;
        categoryId=treeId;
        var url=__rootPath +"/bpm/form/bpmTableFormula/listData.do?Q_TREE_ID__S_EQ="+treeId;
        grid.setUrl(url);
        grid.reload();
    }


    /**
     * 分类树添加节点。
     * @param e
     * @returns
     */
    function addCatNodeTable(e){
        var systree=mini.get("systree");
        var node = systree.getSelectedNode();
        var parentId=node?node.treeId:0;
        //findNode("add",node.treeId)
        _OpenWindow({
            title:'公式分类',
            url:__rootPath+'/sys/core/sysTree/edit.do?parentId='+parentId+'&catKey=CAT_BPM_FROM',
            width:720,
            height:420,
            ondestroy:function(action){
                systree.load();
            }
        });
    }



</script>
<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.form.entity.BpmTableFormula" winHeight="450"
                   winWidth="700" entityTitle="表间公式" baseUrl="bpm/form/bpmTableFormula"/>
</body>
</html>