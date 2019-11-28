<%-- 
    Document   : 公司文档目录列表页
    Created on : 2015-11-6, 16:11:48
    Author     : 陈茂昌
--%>
<%@page import="com.redxun.sys.org.controller.SysOrgMgrController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>文档目录管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div id="layout1" class="mini-layout"
		style="width: 100%; height: 100%;">
		<div title="center" region="center" bodyStyle="overflow:hidden;"
			style="border: 0;">
			<!--Splitter-->
			<div class="mini-splitter" style="width: 100%; height: 100%;"
				borderStyle="border:0;">
				<div size="270" maxSize="350" minSize="100"
					showCollapseButton="true" style="border-width: 1px;">
					<!--Tree-->

					<div id="panel1" class="mini-panel" title="文件目录"
						iconCls="" style="width: 440px; height: 100%;"
						showToolbar="true" showCollapseButton="true" showFooter="false"
						allowResize="true" collapseOnTitleClick="true">
						<!--toolbar-->
						
						<div property="toolbar"  class="toolbar-margin">
						<div id="treetoolbar">
								<input type='checkbox' name='multi' id='multi' style="display:none"  />
						</div>
							<a class="mini-button" iconCls="icon-add" onclick="addroot" plain="true"  id="treeadd">新建文档目录</a>
							<a class="mini-button" iconCls="icon-detail" onclick="selectType" plain="true"  id="selectType">标签查找</a>
						</div>
					
						<!--Tree-->
						<ul id="tree1" class="mini-tree"
							url="${ctxPath}/flie/tray/flieTrayBasic/leftList.do"
							style="width: 100%; padding: 5px; height: 100%;" showTreeIcon="true"
							textField="fileTrayName" idField="id" value="base" expandOnLoad="true"
							parentField="parent"
							resultAsTree="0" contextMenu="#treeMenu"
							onnodeclick="onNodeSelect">
						</ul>
						<div id="toolbar1" class="mini-toolbar" style="padding:2px;position: fixed; bottom:0;">
							<input class="text text-border" id="key" name="key" style="border:1px solid black;">

							<div id="combobox3" field="docLabel" width="60" headerAlign="center" style="width:170px;display:none;"  popupWidth="400" textField="text">
								<input property="editor" name="combobox3Value" class="mini-combobox"  style="width:100%;" url="${ctxPath}/flie/tray/flieTrayBasic/backDownBox.do" />
							</div>

								<a class="mini-button mini-button-plain" onclick="searchForSomeKey" title="包含该字段的条目"><span class="mini-button-icon-text "><span class="mini-button-icon mini-iconfont icon-search" style=""></span>查找</span></a>
						</div>
					</div>

				</div>

				<div showCollapseButton="false" style="border: 0px;">
					<!--Tabs-->
					<div id="mainTabs" class="mini-tabs bg-toolbar" activeIndex="0"
						style="width: 100%; height: 100%;"
						onactivechanged="onTabsActiveChanged"></div>
				</div>
			</div>
		</div>
	</div>
	
<!-- 树右键菜单 -->
	<ul id="treeMenu" class="mini-contextmenu" onbeforeopen="onBeforeOpen">
		<li name="add" iconCls="icon-add" onclick="onAddAfter">新增同级文件夹</li>
		<li name="subadd" iconCls="icon-add" onclick="onAddNode">增加子文件夹</li>
		<li name="edit" iconCls="icon-edit" onclick="onEditNode">编辑文件夹</li>
	    <li name="perm" iconCls="icon-form" onclick="onPerm('edit')">编辑权限</li>
		<li name="read" iconCls="icon-grant" onclick="onPerm('read')">阅读权限</li>
		<li name="remove" iconCls="icon-remove" onclick="onRemoveNode">删除文件夹</li>
	</ul>



	<script type="text/javascript">
        function onComboValidation(e) {
            var items = this.findItems(e.value);
            if (!items || items.length == 0) {
                e.isValid = false;
                e.errorText = "输入值不在下拉数据中";
            }
        }


        mini.parse();
		var tree = mini.get("tree1");
        var rightTrue = false;
        var inputValue;
		//在没有根目录的清空下建立新目录的按钮

		
		
		//建立根目录
		function addroot(){
			var iscompany = 0;//可用来判断是否公司
			var newNode = {};//新建空节点
			//tree.addNode(newNode, "add", node);
			_OpenWindow({
				url : '${ctxPath}/flie/tray/flieTrayBasic/edit.do?pageType=new&parent='+"0",
				title : "新建文件夹",
				width : 600,
				height : 400,
				onload : function() {
				},
				ondestroy : function(action) {
					if (action == 'ok'){
					tree.load();
					}
				}

			});
			
		}
        //下拉选择
		function selectType()
		{
		    var htmlSelectType = "<span class=\"mini-button-text  mini-button-icon-text \"><span class=\"mini-button-icon mini-iconfont icon-detail\" style=\"\"></span>";
		    if($("#key").css("display")=="none")
			{
                $("#key").css("display","inline-block");
                $("#selectType").html(htmlSelectType+"标签查找</span>");
                $("#combobox3").css("display","none");
			}
			else
			{
                $("#key").css("display","none");
                $("#selectType").html(htmlSelectType+"文档查找</span>");
                $("#combobox3").css("display","inline-block");
			}
		}
		
		
		//增加同级节点
		function onAddAfter(e) {
			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var newNode = {};
			var parent = node.parent;
			var pkId = node.folderId;//节点的唯一标识符
			_OpenWindow({
				url : '${ctxPath}/flie/tray/flieTrayBasic/edit.do?pageType=new&parent='+parent,
				title : "新增同级节点",
				width : 600,
				height : 400,
				onload : function() {

				},
				ondestroy : function(action) {
					if (action == 'ok')
						tree.load();
				}

			});
		}
		
		
		/*设置节点的图标*/
		function onDrawNode(e) {
			var tree = e.sender;
			var node = e.node;
			e.iconCls = 'icon-folder';
			if(node.name.length>10){
        		var shortnodeName=node.name.substring(0,9)+"…";
        	e.nodeHtml= '<a title="' +node.name+ '">' +shortnodeName+ '</a>';
        	}else{
        		e.nodeHtml= '<a title="' +node.name+ '">' +node.name+ '</a>';
        	}

		}


		//增加子节点
		function onAddNode(e) {
			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var iscompany = 0;//可用来判断是否公司
			var newNode = {};//新建空节点
			var type = "COMPANY";
			_OpenWindow({
				url : '${ctxPath}/flie/tray/flieTrayBasic/edit.do?pageType=new&parent='
						+ node.id,	
				title : "新增子文件夹",
				width : 600,
				height : 400,
				onload : function() {
				},
				ondestroy : function(action) {
					if (action == 'ok'){
						tree.load();
					}
				}

			});
		}

		//编辑节点文本（URL）
		function onEditNode(e) {
			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var pkId = node.id;
            _OpenWindow({
                url: "${ctxPath}/flie/tray/flieTrayBasic/edit.do?pkId="+pkId+"&fileId="+pkId+"&pageType=update",
                title: "编辑文件夹",
                width: 690, height: 300,
                ondestroy: function(action) {

                    if (action == 'ok') {
                        tree.load();
                    }
                }
            });

        }
		
		function onPerm(url)
		{
            var type2 = "";
            var type2Name = "";
            var tree = mini.get("tree1");
            var node = tree.getSelectedNode();
            if(url=="edit")
            {
                type2 = "edit";
                type2Name = "编辑权限";
            }
            else
            {
                type2 = "read";
                type2Name = "阅读权限";
            }
            var type2Title = type2Name;
            type2Name = encodeURI(encodeURI(type2Name));
            _OpenWindow({
                title : type2Title,
                width : 700,
                height : 400,
                url : __rootPath + '/filetray/authority/insPortalPermissionType/edit.do?layoutId=' + node.id + '&&type2=' + type2+ "&&type2Name=" + type2Name
            });
		}
		
		//删除节点
		function onRemoveNode(e) {

			var tree = mini.get("tree1");
			var node = tree.getSelectedNode();
			var isLeaf = tree.isLeaf(node);
			var folderId = node.id;
			var menuIds = tree.getValue(true);
			if (node) {
				if (confirm("确定删除选中节点?")) {
					$.ajax({
								type : "Post",
                                url:"${ctxPath}/flie/tray/flieTrayBasic/del.do",
								data : {"ids":folderId},
								beforeSend : function() {
								},
								success : function(result) {

									mini.alert(result.message);
								}
							});
					tree.removeNode(node);
				}
			}
		}

		//阻止浏览器默认右键菜单
		function onBeforeOpen(e) {
		    //三种情况 如果是主文件夹非管理员不可以删除 如果是非主文件夹 则拥有修改权限的人可以删除可以新建可以编辑
            //阅读权限点击右键无反应

			
			var menu = e.sender;
			var tree = mini.get("tree1");

			var node = tree.getSelectedNode();

            $.ajax({
                type : "Post",
                url : '${ctxPath}/flie/tray/flieTrayBasic/security.do',
                async:false,
                data : {"id":node.id},
                success : function(result) {
                    var securityValue = result.message;
                    if(securityValue=="edit")
                    {
                        mini.getByName("add").show();
                        mini.getByName("subadd").show();
                        mini.getByName("edit").hide();
                        mini.getByName("remove").hide();
                        mini.getByName("perm").hide();
                        mini.getByName("read").hide();
                    }
                    else if(securityValue=="read")
                    {
                        e.cancel = true;
                        //阻止浏览器默认右键菜单
                        e.htmlEvent.preventDefault();
                        return;
                    }
                    else
					{
                        mini.getByName("add").show();
                        mini.getByName("subadd").show();
                        mini.getByName("edit").show();
                        mini.getByName("remove").show();
                        mini.getByName("perm").show();
                        mini.getByName("read").show();
                    }
                }
            });




			////////////////////////////////////////////////////


		}

		//显示节点页面
        function showTab(node) {
            var tabs = mini.get("mainTabs");
            var tabsArray = tabs.tabs;
            var id = node.id;
            for(var i = 0; i < tabsArray.length; i++)
            {
                if(tabsArray[i]._nodeid==id)
				{
				    return;
				}
            }
				tab = {};
				tab._nodeid = node.id;
				tab.title = node.fileTrayName;
				tab.showCloseButton = true;
				tab.url = __rootPath
						+ "/flie/tray/flieTrayBasic/movieIndex.do?folderId="
						+ node.id;

				tabs.addTab(tab);
			    tabs.activeTab(tab);
			    tabs.removeAll(tab);//只显示当前
        }
        //点击节点时
		function onNodeSelect(e) {
			var node = e.node;
			showTab(node);
		}

		function onTabsActiveChanged(e) {
			var tree = mini.get("tree1");
			var tabs = e.sender;
			var tab = tabs.getActiveTab();
			if (tab && tab._nodeid) {

				var node = tree.getNode(tab._nodeid);
				if (node && !tree.isSelectedNode(node)) {
					tree.selectNode(node);
				}
			}
		}


        //按某些字段查找
        function searchForSomeKey(){
		    var fileSelect = "";
            if($("#key").css("display")!="none")
            {
                inputValue = $("#key").val();
                fileSelect = "fileSelect";
            }
            else {
                inputValue =$("input[name='combobox3Value']").val();
			}
            var tabs = mini.get("mainTabs");
            var tabsArray = tabs.tabs;
            tab = {};
            tab.title = inputValue;
            tab.showCloseButton = true;
            tab.url = "${ctxPath}/flie/tray/flieTrayBasic/movieIndex.do?labelText="
                + encodeURI(encodeURI(inputValue))+"&fileSelect="+fileSelect;

            tabs.addTab(tab);
            tabs.activeTab(tab);
        }

        function valueBlur(e)
        {
            var obj = e.sender;
            inputValue = obj.getText();
        }

        function onCloseClick(e) {
            var obj = e.sender;
            obj.setText("");
            obj.setValue("");
        }

	</script>

</body>
</html>