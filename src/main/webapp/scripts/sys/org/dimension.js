//新增维度
function addDim(){
	_OpenWindow({
		title:'新增维度',
		height:410,
		width:810,
		url:__rootPath +'/sys/org/osDimension/edit.do?tenantId='+tenantId,
		ondestroy:function(action){
			if(action!='ok') return;
			dimTree.load();
		}
	});
}
function refreshDims(){
	dimTree.load();
}

function editDim(e){
	 var node = dimTree.getSelectedNode();
	_OpenWindow({
		title:'编辑维度-'+node.name,
		height:400,
		width:680,
		url:__rootPath + '/sys/org/osDimension/edit.do?pkId='+node.dimId,
		ondestroy:function(action){
			if(action!='ok') return;
			dimTree.load();
		}
	});
}

function delDim(e){
	 var node = dimTree.getSelectedNode();
	 if(!confirm("确定删除维度-"+node.name+"?")){
		 return;
	 }
	 _SubmitJson({
		 url: __rootPath +'/sys/org/osDimension/del.do?ids='+node.dimId,
		 success:function(result){
			 dimTree.load();
		 }
	 });
}