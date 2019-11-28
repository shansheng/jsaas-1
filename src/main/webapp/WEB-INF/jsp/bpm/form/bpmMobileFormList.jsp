<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>[手机表单]列表管理</title>
    <%@include file="/commons/list.jsp" %>
    <script src="${ctxPath}/scripts/share/dialog.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/sys/bo/BoUtil.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
</head>
<body>
<ul id="treeMenu" class="mini-contextmenu">
    <li   onclick="addCatNodePhone">新增分类</li>
    <li  onclick="editCatNode">编辑分类</li>
    <li  class=" btn-red" onclick="delCatNode">删除分类</li>
</ul>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
    <div
            title="手机表单分类"
            region="west"
            width="220"
            showSplitIcon="true"
            showCollapseButton="false"
            showProxy="false"
    >
        <div id="toolbar1" class="treeToolBar">
            <a class="mini-button"   plain="true" onclick="addCatNodePhone()">新增</a>
            <a class="mini-button"  plain="true" onclick="refreshSysTree()">刷新</a>
        </div>
        <div class="mini-fit">
            <ul
                    id="systree"
                    class="mini-tree"
                    url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_PHONE_FORM"
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
            <div class="searchBox">
                <form id="searchForm" class="search-form">
                    <ul>
                        <li class="liAuto">
                            <span class="text">别名：</span>
                            <input name="Q_a.ALIAS__S_LK" class="mini-textbox"/>
                        </li>
                        <li>
                            <span class="text">业务模型：</span>
                            <input
                                    id="btnBoDefId"
                                    name="Q_a.BO_DEF_ID__S_EQ"
                                    class="mini-buttonedit"
                                    text=""
                                    showClose="true"
                                    oncloseclick="clearButtonEdit"
                                    value=""
                                    onbuttonclick="onSelectBo"
                            />
                        </li>
                        <li class="liBtn">
                            <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
                            <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
                        </li>
                    </ul>
                </form>
                <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
                    <i class="icon-sc-lower"></i>
                </span>
            </div>
            <ul class="toolBtnBox">
                <li><a class="mini-button"  plain="true" onclick="addForm()">新增</a></li>
                <li><a class="mini-button"  plain="true" onclick="edit()">编辑</a></li>
                <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
                <li><a class="mini-button" plain="true" onclick="genAll()">全部生成</a></li>
            </ul>
        </div>


        <div class="mini-fit rx-grid-fit" style="height:100%;">
            <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" allowResize="false"
                 url="${ctxPath}/bpm/form/bpmMobileForm/listData.do" idField="id" multiSelect="true"
                 showColumnsMenu="true"
                 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
                    <div name="action" cellCls="actionIcons" width="80"
                         renderer="onActionRenderer" cellStyle="padding:0;">操作
                    </div>
                    <div field="boName" width="120" headerAlign="">关联BO</div>
                    <div field="name" width="120" headerAlign="">手机表单名称</div>
                    <div field="alias" width="120" headerAlign="">手机表单标识</div>
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
        var s =' <span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
            + ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
        return s;
    }

    function addForm() {
        _OpenWindow({
            url: __rootPath + "/bpm/form/bpmMobileForm/add.do",
            title: "新增手机表单", width: "600", height: "420",
            ondestroy: function (action) {
                if (action == "ok") {
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
    function addCatNodePhone(e) {
        var systree = mini.get("systree");
        var node = systree.getSelectedNode();
        var parentId = node ? node.treeId : 0;
        //findNode("add",node.treeId)
        _OpenWindow({
            title: '新增表单视图分类',
            url: __rootPath + '/sys/core/sysTree/edit.do?parentId=' + parentId + '&catKey=CAT_PHONE_FORM',
            width: 720,
            height: 450,
            ondestroy: function (action) {
                systree.load();
            }
        });
    }


    function treeNodeClick(e) {
        var node = e.node;
        var treeId = node.treeId;
        categoryId = treeId;
        var url = __rootPath + "/bpm/form/bpmMobileForm/listData.do?Q_a.TREE_ID__S_EQ=" + treeId;
        grid.setUrl(url);
        grid.reload();
    }
    
    function genAll(){
		_SubmitJson({
   			url:__rootPath+'/bpm/form/bpmMobileForm/generateAllHtml.do',
   			success:function(text){
   				grid.load();
   			}
   		});
    }
</script>

<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.form.entity.BpmMobileForm"
                   winHeight="450" winWidth="700"
                   entityTitle="[手机表单]" baseUrl="bpm/form/bpmMobileForm"/>
</body>
</html>