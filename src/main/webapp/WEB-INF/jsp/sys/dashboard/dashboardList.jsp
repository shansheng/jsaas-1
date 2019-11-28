<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>大屏管理</title>
    <%@include file="/commons/list.jsp" %>
    <script src="${ctxPath}/scripts/sys/core/sysTree.js?version=${static_res_version}" ></script>
    <link rel="stylesheet" type="text/css" href="${ctxPath }/scripts/layoutit/css/jquery.gridster.min.css">
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery.gridster.min.js"></script>
	
	<script type="text/javascript" src="${ctxPath }/scripts/sys/echarts/echarts.min.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/sys/echarts/echarts-wordcloud.min.js"></script>
    <%@include file="/WEB-INF/jsp/sys/echarts/echartsTheme.jsp"%>
	<script type="text/javascript" src="${ctxPath}/scripts/layoutit/js/layoutitIndex.js"></script>
	<script src="${ctxPath}/scripts/sys/echarts/echartsFrontCustom.js?t=1.5.137" type="text/javascript"></script>
	<script src="${ctxPath}/scripts/sys/echarts/dashboard.js?t=1.5.137" type="text/javascript"></script>
	
    <!-- <style>
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
    </style> -->
</head>
<body>
<ul id="treeMenu" class="mini-contextmenu">
    <li   onclick="addCatNode">新增分类</li>
    <li iconCls="icon-edit" onclick="editCatNode">编辑分类</li>
    <c:if test="${superAdmin }"><li iconCls="icon-edit" onclick="nodeGrant">控制权限</li></c:if>
    <li iconCls="icon-remove" class=" btn-red" onclick="delCatNode">删除分类</li>
    <li iconCls="icon-edit" onclick="openDemo">模板编辑</li>
</ul>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
    <div title="大屏分类" region="west" width="220" showSplitIcon="false"
            showCollapseButton="false" showProxy="false" allowResize="false" >
        <div id="toolbar1">
            <a class="mini-button"   plain="true" onclick="addCatNode()">新增</a>
            <a class="mini-button" iconCls="icon-refresh" plain="true" onclick="refreshSysTree()">刷新</a>
        </div>
        <ul id="systree" class="mini-tree"
                <%-- url="${ctxPath}/sys/echarts/echartsCustom/getUserGrantTreeList.do" --%>
                url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_DASHBOARD" 
                style="width:100%;" showTreeIcon="true" textField="name" idField="treeId" resultAsTree="false" 
                parentField="parentId" expandOnLoad="true" contextMenu="#treeMenu" onnodeclick="treeNodeClick"></ul>
    </div>
    <div region="center" showHeader="false" showCollapseButton="false" style="background:#EFEFEF;">
		<div class="personalPort" style="width:100%;height:100%;"></div>
    </div>
</div>
<script type="text/javascript">
	mini.parse();
	mini.layout();
	
	function openDemo(){
		var tree = mini.get("systree").getSelected();
		if(!tree){
			alert("请选择大屏分类!");
			return false;
		}
		_OpenWindow({
			max: true,
			title: '模板编辑',
			url: '${ctxPath}/sys/dashboard/dashboard/demo.do?key='+tree.key+"&name="+tree.name+"&treeId="+tree.id,
			ondestroy : function(action){
				if(action!='ok'){
					return;
				}
				var iframe = this.getIFrameEl();
				var datJson = iframe.contentWindow.getDataJson();
				$.post('${ctxPath}/sys/dashboard/singleDashboard/'+datJson.key+'.do', function(data){
					$(".personalPort").html(data.html);
					handData();
				});
			}
		});
	}

    /**
     * 分类树添加节点。
     * @param e
     * @returns
     */
    function addCatNode(e) {
        var systree = mini.get("systree");
        var node = systree.getSelectedNode();
        var parentId = node ? node.treeId : 0;
        _OpenWindow({
            title: '大屏展示分类',
            url: __rootPath + '/sys/core/sysTree/edit.do?parentId=' + parentId + '&catKey=CAT_DASHBOARD',
            width: 720,
            height: 420,
            ondestroy: function (action) {
                systree.load();
            }
        });
    }


    function treeNodeClick(e) {
        var node = e.node;
        var key = node.key;
        var url = '${ctxPath}/sys/dashboard/singleDashboard/'+ key + '.do';
        $.post(url, function(data){
        	$(".personalPort").html(data.html);
			handData();
        });
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

</script>
<%-- <redxun:gridScript gridId="datagrid1"
                   entityName="com.redxun.sys.echarts.entity.SysEchartsCustom"
                   winHeight="450" winWidth="700" entityTitle="自定义图形报表"
                   baseUrl="sys/echarts/echartsCustom"/> --%>
</body>
</html>