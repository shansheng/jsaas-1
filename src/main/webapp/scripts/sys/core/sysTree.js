/**
 * 分类树添加节点。
 * @param e
 * @returns
 */
function addCatNode(e){
	var systree=mini.get("systree");
	var node = systree.getSelectedNode();
	var parentId=node?node.treeId:0;
	//findNode("add",node.treeId)
	_OpenWindow({
		title:'新增表单视图分类',
		url:__rootPath+'/sys/core/sysTree/edit.do?parentId='+parentId+'&catKey=CAT_FORM_VIEW',
		width:720,
		height:400,
		ondestroy:function(action){
			systree.load();
		}
	});
}

/**
 * 编辑节点。
 * @param e
 * @returns
 */
function editCatNode(e){
	var systree=mini.get("systree");
	var node = systree.getSelectedNode();
	var treeId=node.treeId;
	_OpenWindow({
		title:'编辑节点',
		url:__rootPath+'/sys/core/sysTree/edit.do?pkId='+treeId,
		width:780,
		height:350,
		ondestroy:function(action){
			if(action=='ok'){
				systree.load();
			}
		}
	});
}

/**
 * 删除分类节点
 * @param e
 * @returns
 */
function delCatNode(e){
	var systree=mini.get("systree");
	var node = systree.getSelectedNode();
	mini.confirm("确定删除吗?","提示信息",function(action){
		if(action!="ok") return;
		_SubmitJson({
			url:__rootPath+'/sys/core/sysTree/del.do?ids='+node.treeId,
			success:function(text){
				systree.load();
			}
		});
	});
	
}

/**
 * 刷新分类树。
 * @returns
 */
function refreshSysTree(){
	var systree=mini.get("systree");
	systree.load();
}