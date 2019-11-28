/*------------------------------------意见处理 开始--------------------------------------*/
/*保存意见*/
function saveOpinionLib(){
	var opText =mini.get("opinion").getValue();
	if(opText==null){
		alert("请勿保存空值");
		return ;
	}
	_SubmitJson({
		url:__rootPath+'/bpm/core/bpmOpinionLib/saveOpinion.do',
		data: {
			opText:opText
		},
		method:'POST',
		success:function(result){
			var url=__rootPath + "/bpm/core/bpmOpinionLib/getUserText.do";
			//重新加载意见列表控件
			mini.get('opinionSelect').load(url);
		}
	});
}

function onDrawCells(e) {
	var item = e.record, field = e.field, value = e.value;
    //组织HTML设置给cellHtml
    var textLength=value.length;
    var ancientValue=value;
    if(textLength>15){
    	textLength=15;	
    	value=value.substring(0,textLength)+'...';
    }
    if(ancientValue!='同意。'&&ancientValue!='拒绝。'){
    	e.cellHtml = '<span title='+ancientValue+'>'+value+'</span>'+'<span style="color:red;font-size:15px;float:right;width:15px;" title="删除" onclick="deleteMyOpinion(\''+item.opId+'\');event.cancelBubble=true;"> X</span>';
    }
    else{
    	e.cellHtml = '<span title='+ancientValue+'>'+value+'</span>';	
    }
}

//显示评语
function showOpinion(e){
	var opinionSelect = mini.get("opinionSelect");
	var opText = opinionSelect.getText();
	var remarkObj=mini.get("opinion");
	remarkObj.setValue(opText);
}

function deleteMyOpinion(data){
	mini.confirm("<b>确定要删除此条意见吗</b>", "确定",
        function (action) {
            if (action != "ok")  return;
           	$.ajax({
               	url:__rootPath + "/bpm/core/bpmOpinionLib/del.do",
               	type:'POST',
               	async:false,
               	data:{ids: data},
               	success:function (){
               		mini.get('opinionSelect').load(__rootPath+ "/bpm/core/bpmOpinionLib/getUserText.do");
               	}
           });
        });
}	

/*------------------------------------意见处理 结束 --------------------------------------*/