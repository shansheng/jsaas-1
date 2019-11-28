<%-- 
    Document   : [自定义属性]列表页
    Created on : 2017-12-14 14:02:29
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[自定义属性]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
    <div id="layout1" class="mini-layout" style="width:100%;height:100%;" >
        <div title="分类" region="west" width="200"  showSplitIcon="true" class="layout-border-r">
            <div class="treeToolBar">
                <a class="mini-button"   plain="true" onclick="createNewTree()">新增分类</a>
            </div>
            <div class="mini-fit">
                <div id="tabs1" class="mini-tabs" activeIndex="0" tabPosition="top" style="width:100%;height:100%">
                    <div title="用户分类" iconCls="icon-cut">
                        <ul id="systree1" class="mini-tree" url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE" style="width:100%; height:100%;"
                            showTreeIcon="false" textField="name" idField="treeId" resultAsTree="false" parentField="parentId" expandOnLoad="true"
                            onnodeclick="treeNodeClick"  contextMenu="#treeMenu" >
                        </ul>
                    </div>
                    <div title="组分类" iconCls="icon-cut" >
                        <ul id="systree2" class="mini-tree" url="${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=CAT_CUSTOMATTRIBUTE_GROUP" style="width:100%; height:100%;"
                            showTreeIcon="false" textField="name" idField="treeId" resultAsTree="false" parentField="parentId" expandOnLoad="true"
                            onnodeclick="treeNodeClick"  contextMenu="#treeMenu" >
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div region="center" showHeader="false" showCollapseButton="false">
            <div class="mini-toolbar" >

                <div class="searchBox">
                    <form id="searchForm" class="search-form" >
                        <ul>
                            <li><span class="text">属性名称：</span><input class="mini-textbox" name="Q_ATTRIBUTE_NAME__S_LK"></li>
                            <li class="liBtn">
                                <a class="mini-button"   plain="true" onclick="searchFrm()">搜索</a>
                                <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空搜索</a>
                            </li>
                        </ul>
                    </form>
                </div>
                <ul class="toolBtnBox">
                    <li><a class="mini-button"  plain="true" onclick="add()">新增</a></li>
                    <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>

                </ul>
                <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
                    <i class="icon-sc-lower"></i>
                </span>
             </div>
            <div class="mini-fit" style="height: 100%;">
                <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
                    url="${ctxPath}/sys/org/osCustomAttribute/listData.do" idField="ID"
                    multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
                    <div property="columns">
                        <div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
                        <div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
                        <div field="attributeName"  sortField="ATTRIBUTE_NAME_"  width="120" headerAlign="" allowSort="true">属性名称</div>
                        <div field="key"  sortField="KEY_"  width="120" headerAlign="" allowSort="true">KEY_</div>
                        <div field="attributeType"  sortField="ATTRIBUTE_TYPE_"  width="120" headerAlign="" allowSort="true">属性类型</div>
                        <div field="widgetType"  sortField="WIDGET_TYPE_"  width="120" headerAlign="" allowSort="true">控件类型</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<ul id="treeMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">
		<li name="remove" class=" btn-red" onclick="onRemoveNode">删除</li>
	</ul>
	<script type="text/javascript">
	mini.parse();
	var tree1=mini.get("systree1");
	var tree2=mini.get("systree2");
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}


		function createNewTree(){
            var type = ""
		    if(mini.get("tabs1").activeIndex==0){
		        type = "CAT_CUSTOMATTRIBUTE"
            }else {
		        type = "CAT_CUSTOMATTRIBUTE_GROUP"
            }
	   		_OpenWindow({
	   			title:'新增表单视图分类',
	   			url:__rootPath+'/sys/core/sysTree/edit.do?catKey=' + type,
	   			width:720,
	   			height:350,
	   			ondestroy:function(action){
	   			    if(type == "CAT_CUSTOMATTRIBUTE"){
                        tree1.load();
                    }else {
                        tree2.load();
                    }

	   			}
	   		});
		}




		function treeNodeClick(e){
			var node=e.node;
			var treeId=node.treeId;
			grid.setUrl("${ctxPath}/sys/org/osCustomAttribute/getAttrsByTreeId.do?treeId="+treeId);
			grid.reload();
		}

		function onBeforeOpen(e) {
			var menu = e.sender;
			var node
            if(mini.get("tabs1").activeIndex==0){
                node = tree1.getSelectedNode();
            }else {
                node = tree2.getSelectedNode();
            }
			
			if (!node || !node.createTime) {
				e.cancel = true;
				return;
			}
		}

		function onRemoveNode(e){
		    var thisTree
            var node
            if(mini.get("tabs1").activeIndex==0){
                thisTree = tree1
            }else {
                thisTree = tree2
            }
            node = thisTree.getSelectedNode();
            mini.confirm("确认删除?", "提示",
			            function (action) {
			                if (action == "ok") {
			                	_SubmitJson({
			                    	url:"${ctxPath}/sys/core/sysTree/del.do",
			                    	method:'POST',
			                    	data:{ids: node.treeId},
			                    	 success: function(text) {
                                         thisTree.reload();
			                        }
			                     });
			                }
			            }
			        );

		}

	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.org.entity.OsCustomAttribute" winHeight="450"
		winWidth="700" entityTitle="自定义属性" baseUrl="sys/org/osCustomAttribute" />
</body>
</html>