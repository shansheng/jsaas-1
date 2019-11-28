<%--
	//用户组的资源授权
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>用户组授权</title>
    <%@include file="/commons/edit.jsp" %> 
</head>
<body>
	<div id="mainLayout" class="mini-layout" style="width:100%;height:100%;" >
		 <div region="south" showSplit="false" showHeader="false" height="40" showSplitIcon="false"  style="width:100%">
			<div class="mini-toolbar" style="text-align:center;border:none" bodyStyle="border:0">
			    <a class="mini-button" iconCls="icon-ok" onclick="onOk()">确定</a>
			    <span style="display:inline-block;width:25px;"></span>
			    <a class="mini-button" iconCls="icon-cancel" onclick="onCancel()">取消</a>
			</div>	 
		 </div>
		<div region="center" title="授权资源"  showHeader="false" showCollapseButton="false">
			<div class="mini-toolbar"  bodyStyle="border:0" style="border:none;border-bottom:solid 1px #aaa " >
			    <a class="mini-button" iconCls="icon-expand"  onclick="onExpand()">展开</a>
			    <a class="mini-button" iconCls="icon-collapse"  onclick="onCollapse()">收起</a>
			    <a id="selectAll" class="mini-button" iconCls="icon-check"  onclick="onCheckAll()">全选</a>
			    <a id="inverseSelect"  class="mini-button" iconCls="icon-uncheck"  onclick="onUnCheckAll()">反选</a>
			    <a class="mini-button" iconCls="icon-close"  onclick="CloseWindow()">关闭</a>
			</div>
			<div>
				<input class="mini-combobox" id="instType" name="instType" value="" url="${ctxPath}/flie/tray/flieTrayBasic/typeName.do" textField="typeName" valueField="typeCode" onvaluechanged="onChangeInstType" style="width:100%;"/>
				
			</div>
			<div class="mini-fit" bodyStyle="padding:2px;">
				<ul id="menuTree" class="mini-tree" style="width:100%;padding:5px;" 
			        showTreeIcon="true" textField="name" idField="menuId" parentField="parentId" resultAsTree="false"  
			        showCheckBox="true" checkRecursive="false" 
			         expandOnLoad="true" 
			         allowSelect="false" enableHotTrack="false">
			    </ul>
		    </div>
		</div>
	</div>
	<script type="text/javascript">
		mini.parse();
        //文件夹id
		var groupId="${param['groupId']}";
		var tenantId="${param['tenantId']}";
		var instTypeVal="${param['instType']}";
		var tree=mini.get('menuTree');
		var ids = "${param['ids']}";
		var type = "";

		//非超管不显示下拉
		var instType =  mini.get("instType");
		if(tenantId != '1'){
			tree.setUrl('${ctxPath}/flie/tray/flieTrayBasic/leftListGrant.do?instType='+instTypeVal);
		}
		
		function onChangeInstType(e){
        	var s=e.sender;
        	var val=s.getValue();
            type = val;
        	tree.setUrl('${ctxPath}/flie/tray/flieTrayBasic/leftListGrant.do?instType='+val + "&tenantId=" + tenantId + "&itselfId=" + groupId);
        }
		
		function onOk(e){
			var menuIds=tree.getValue(true);
			var sysIds=[];
			var allCheckedNodes=tree.getCheckedNodes(true);
			//取得所有一级目录的节点，即子系统
			for(var i=0;i<allCheckedNodes.length;i++){
				var ckNode=allCheckedNodes[i];
				if(ckNode._level==0){
					sysIds.push(ckNode.menuId);
				}
			}
			
			_SubmitJson({
				url:__rootPath+'/flie/tray/flieTrayBasic/fileMovementCopy.do',
				method:'POST',
				data:{
					groupId:groupId,
					//子系统项
					sysIds:sysIds.join(','),
					//包括根节点的菜单项，即包括子系统项
					menuIds:menuIds,
                    ids:ids,
					type:type
				},
				success:function(text){
					CloseWindow('ok');
				}
			});
		}
		
		function onCancel(){
			CloseWindow('cancel');
		}
		
		function onExpand(){
			tree.expandAll();
		}
		
		function onCollapse(){
			tree.collapseAll();
		}
		
		function onCheckAll(){
			tree.checkAllNodes();
		}
		
		function onUnCheckAll(){
			tree.uncheckAllNodes();
		}
		
	</script>
</body>
</html>