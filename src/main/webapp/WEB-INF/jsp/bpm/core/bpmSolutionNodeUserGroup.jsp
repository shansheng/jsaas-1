<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>业务流程解决方案管理-抄送人员配置</title>
	<%@include file="/commons/list.jsp"%>
</head>
<body>
	<div class="topToolBar">
		<div style="text-align: left;">
        	<a class="mini-button"   onclick="addGroup()"  plain="true">添加</a>
        	<a class="mini-button btn-red"  onclick="CloseWindow()" plain="true">关闭</a>
	  		<input class="mini-hidden" id="nodeText" value=""/>
		</div>
	</div>
 	<div class="mini-fit">
		<div id="userGrid" class="mini-datagrid"  
	        		data-options="{nodeId:'${param.nodeId}'}"
	         		url="${ctxPath}/bpm/core/bpmSolUsergroup/getBySolNode.do?actDefId=${param.actDefId}&solId=${param.solId}&nodeId=${param.nodeId}&groupType=${param.groupType}"
					idField="id" showPager="false" style="width:100%;height:100%">
			<div property="columns">
				<div type="indexcolumn" width="20" headerAlign="center">序号</div>
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center"
					 align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="groupName" name="groupName"   width="80" >组类型</div>
				<div field="displayNotifyType" name="displayNotifyType"   width="160" >通知类型</div>
				<div field="sn" name="sn" width="30" headerAlign="center" align="center">序号</div>
				<div field="userListString" name="userListString" width="50" headerAlign="center" >抄送人员</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	var groupType="${groupType}";
	var actDefId="${param.actDefId}";
	var solId = "${param.solId}";
	mini.parse();
	
	var grid=mini.get('userGrid');
	grid.load();
	
	
	function addGroup(){
		var url="${ctxPath}/bpm/core/bpmSolUsergroup/edit.do?actDefId=${param.actDefId}&solId=${param.solId}&nodeId=${param.nodeId}&groupType=${param.groupType}";
		
		_OpenWindow({
			url:url,
			title:'添加用户组',
			width:780,
			height:480,
			ondestroy:function(action){
				if(action=="ok"){
					grid.load();
				}
			}
		});
	}
	
	function onActionRenderer(e) {
        var record = e.record;
        var uid = record.pkId;
    	var	s= ' <span  title="编辑" onclick="editRowOwn(\'' + uid +'\')">编辑</span>';
            s+= ' <span  title="删除" onclick="delRow(\'' + uid + '\')">删除</span>';
        return s;
    }
	
	//编辑行数据
    function editRowOwn(pkId,fullWindow) {    
    	var width=700;
    	var height=500;
    	if(fullWindow){
    		width=getWindowSize().width;
    		height=getWindowSize().height;
    	}
    
    	if(isExitsFunction('_editRow')){
    		_editRow(pkId);
    		return;
    	}
        _OpenWindow({
    		url: "${ctxPath}/bpm/core/bpmSolUsergroup/edit.do?pkId="+pkId+"&actDefId=${param.actDefId}&solId=" + solId,
            title: "编辑用户分组",
            width: width, height: height,
            ondestroy: function(action) {
                if (action == 'ok') {
                    grid.reload();
                }
            }
    	});
    }

</script>

<redxun:gridScript gridId="userGrid" entityName="com.redxun.bpm.core.entity.BpmSolUsergroup" 
        	winHeight="500" winWidth="700"
          	entityTitle="用户分组" baseUrl="bpm/core/bpmSolUsergroup"/>
</body>
</html>