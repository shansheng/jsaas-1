<%-- 
    Document   : 系统流水号列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
    <title>系统流水号列表管理</title>
    <%@include file="/commons/list.jsp" %>
    <script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}"></script>
</head>
<body>

<ul id="treeMenu" class="mini-contextmenu">
    <li   onclick="addCatNodeNum">新增分类</li>
    <li  onclick="editCatNode">编辑分类</li>
    <li  class=" btn-red" onclick="delCatNode">删除分类</li>
</ul>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
    <div
            title="流水号分类"
            region="west"
            width="220"
            showSplitIcon="true"
            showCollapseButton="false"
            showProxy="false"
    >
        <div class="treeToolBar">
            <a class="mini-button"   plain="true" onclick="addCatNodeNum()">新增</a>
            <a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
        </div>
        <div class="mini-fit">
            <ul
                    id="systree"
                    class="mini-tree"
                    url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_SERIAL_NUMBER"
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
    <div region="center" showHeader="false" showCollapseButton="false">
        <redxun:toolbar entityName="com.redxun.sys.core.entity.SysSeqId"/>
        <div class="mini-fit rx-grid-fit" style="height: 100%;">
            <div id="datagrid1" class="mini-datagrid" style="width:100%; height:100%;" allowResize="false"
                 url="${ctxPath}/sys/core/sysSeqId/listData.do?tenantId=${tenantId}" idField="seqId"
                 multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20"
                 allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
                    <div name="action" cellCls="actionIcons" width="100"
                         renderer="onActionRenderer" cellStyle="padding:0;">操作
                    </div>
                    <div field="name" width="120" headerAlign="" allowSort="true">名称</div>
                    <div field="alias" width="120" headerAlign="" allowSort="true">别名</div>
                    <div field="rule" width="160" headerAlign="" allowSort="true">规则</div>
                    <div field="genType" width="120" headerAlign="" allowSort="true">生成方式</div>
                    <div field="len" width="40" headerAlign="" allowSort="true">流水号长度</div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysSeqId"
                   winHeight="580" winWidth="800" entityTitle="系统流水号" baseUrl="sys/core/sysSeqId"/>
<script type="text/javascript">
    //行功能按钮
    function onActionRenderer(e) {
        var record = e.record;
        var pkId = record.pkId;
        var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
            + ' <span  title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>'
            + ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
        return s;
    }


    grid.on("drawcell", function (e) {
        var record = e.record,
            field = e.field,
            value = e.value;
        var genType = record.genType;
        if (field == 'genType') {
            if (genType == 'DAY') {
                e.cellHtml = '每天';
            } else if (genType == 'WEEK') {
                e.cellHtml = '每周';
            } else if (genType == 'MONTH') {
                e.cellHtml = '每月';
            } else if (genType == 'YEAR') {
                e.cellHtml = '每年';
            } else if (genType == 'AUTO') {
                e.cellHtml = '自动增长';
            }
        }
    });

    /**
     *导出
     **/
    function doExport(flag) {
        var rows = grid.getSelecteds();
        if (rows.length == 0 && !flag) {
            alert('请选择需要导出的流水号记录！')
            return;
        }
        if (flag) {
            rows = grid.getData();
        }
        var ids = _GetKeys(rows);
        jQuery.download(__rootPath + '/sys/core/sysSeqId/doExport.do?keys=' + ids, {}, 'post');
    }

    /**
     * 获得表格的行的主键key列表，并且用',’分割
     * @param rows
     * @returns
     */
    function _GetKeys(rows) {
        var ids = [];
        for (var i = 0; i < rows.length; i++) {
            ids.push(rows[i].alias);
        }
        return ids.join(',');
    }

    /**
     *导入
     **/
    function doImport() {
        _OpenWindow({
            title: '流水号导入',
            url: __rootPath + '/sys/core/sysSeqId/import1.do',
            height: 350,
            width: 600,
            ondestroy: function (action) {
                grid.reload();
            }
        });
    }


    /**
     * 分类树添加节点。
     * @param e
     * @returns
     */
    function addCatNodeNum(e) {
        var systree = mini.get("systree");
        var node = systree.getSelectedNode();
        var parentId = node ? node.treeId : 0;
        //findNode("add",node.treeId)
        _OpenWindow({
            title: '新增表单视图分类',
            url: __rootPath + '/sys/core/sysTree/edit.do?parentId=' + parentId + '&catKey=CAT_SERIAL_NUMBER',
            width: 720,
            height: 350,
            ondestroy: function (action) {
                systree.load();
            }
        });
    }


    function treeNodeClick(e) {
        var node = e.node;
        var treeId = node.treeId;
        categoryId = treeId;
        var url = __rootPath + "/sys/core/sysSeqId/listData.do?Q_TREE_ID__S_EQ=" + treeId;
        grid.setUrl(url);
        grid.reload();
    }


</script>
</body>
</html>