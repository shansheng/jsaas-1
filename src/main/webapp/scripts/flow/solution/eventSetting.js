function settingEvent(gridId,solId,actDefId,nodeId,nodeType){
	var grid=mini.get(gridId);
	var row=grid.getSelected();
	if(!row){
		alert('请选择配置行！');
		return;
	}
	if(!row.callType || row.callType==''){
		alert('请选择接口类型！');
		return;
	}
	if(row.callType=="jms"){
		alert('类型队列不需要配置！');
		return;
	}
	var conf={
			title:grid.eventName+'接口调用配置',
			url:__rootPath+'/bpm/core/bpmNodeSet/callConfig'+row.callType+'.do?solId='+solId+'&actDefId='+actDefId+'&nodeId='+nodeId+'&nodeType='+nodeType,
			onload:function(){
				var win = this.getIFrameEl().contentWindow;
				win.setData(row.script);
			},
			ondestroy:function(action){
				if(action!='ok'){
					return;
				}
				var win = this.getIFrameEl().contentWindow;
				var data=win.getData();
				grid.updateRow(row,{script:data});
			}
	}
	if(row.callType=="HttpInvoke"){
		conf.max=true;
	}
	else{
		conf.width=800;
		conf.height=600;
	}
	_OpenWindow(conf);
}