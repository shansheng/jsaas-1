
//刷新我的消息
function myNewsRemind() {
	var oDate=new Date();
	var url = __rootPath + "/oa/info/oaRemindDef/myRemind.do";
	$.get(url, function(result) {
		var data = result.data;
		if(data.length>0){
			$('#redDot').css({'display':'block'})
			$('.result').hover(function(){
				$('.messagebox').css({'display':'block'})
			},function(){
				$('.messagebox').css({'display':'none'})
			});
			for(var i=0;i<data.length;i++){
				var html =  "<div><span class='messageIcon greenBg'>";
				html +=	"<i class='iconfont icon-nodeReminder'></i>";
				html += "</span><span class='message'>";
				html += "<p><em class='dot'></em><a class='remind' target='view_frame'  target='view_frame'";
				html += "href='"+__rootPath+data[i].url +"'><span >"+data[i].str+"</span>";
				html += "</a></p>";
				html += "</span></div>";
				$("#test").append(html);
			}
		}else{
			
		}

	});

}
//执行一次 开启定时任务
window.setTimeout(myNewsRemind, 100);


var moreOrgnaiData =[];
//查询多机构进行机构切换登陆
function queryMoreOrgnai(){
	var url = __rootPath + "/sys/core/sysInst/queryMoreOrgnai.do";
	var countAry = [];
	$.get(url, function(result) {
		for (var i = 0; result &&i < result.length; i++) {
			var domain = result[i].domain;
			var name = result[i].nameCn;
			var s ='<p onclick="changeOrgnai(\''+domain+'\')">'+name+'</p>';
			countAry.push(s);
		}
        var parent = $("#moreOrganiParent");
		if(countAry.length==0) {
			parent.hide();
			return;
		}
		moreOrgnaiData =result;
		var html = countAry.join("");
		$("#moreOrgani").html(html);
		if(moreOrgnaiData.length==1){
			parent.hide();
		}
	});
}
queryMoreOrgnai();

//切换机构,重新登陆
function changeOrgnai(domain){
	if(moreOrgnaiData.length==1){
		top._ShowTips({
			msg:"只有一个机构，不用进行切换！"
		});
		return;
	}
	mini.confirm('是否确定切换登陆机构？','切换登陆机构',function ok(action){
		if (action != "ok") return;
		location.href=__rootPath +"/j_spring_security_switch_user_tochangorg?domain=" + domain;
	});
}