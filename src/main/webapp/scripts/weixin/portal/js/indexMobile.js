function initMobilePieview(){
	editFontSize();

	//设置每个li的宽度	
	var _li = $(".bannerBox .picBox li");
	var _width = $(window).width();
	_li.width(_width);
	
	rollBanners();
}


function editFontSize(){
	var w = window.innerWidth;
    w = (w>640)?640:w;
    w = (w<320)?320:w;
    document.documentElement.style.fontSize = (w/640)*100+"px";
}

$(window).resize(function(){
	editFontSize();
});

function rollBanners(){
	var liCopy =$("#centerUl").find(".centerLi").find("ul.picBox").find("li").first().clone();
	$("#centerUl").find("ul.picBox").append(liCopy);
	var picBox_li = $("#centerUl").find("ul.picBox").find("li").size();

	var Roll =0;
	var rollUl = $("#centerUl").find("ul.picBox");
	var timRoll =setInterval(rollLeft,2000);
	
	var _width = $(".bannerBox").width();

	$("#centerUl").on("mousemove",".bannerBox",function(){
			clearInterval(timRoll)	
	});	
	$("#centerUl").on("mouseout",".bannerBox",function(){
			timRoll = setInterval(rollLeft,2000)	
	});	
	function rollLeft(){
		Roll++;
		if (Roll == picBox_li) {
			Roll = 1;
			rollUl.css({"left":0});
		}
		var He = Roll*_width;
		rollUl.stop().animate({"left":-He},1000);
	}
};

function gotoUrl(appId, url){
	if(appId == undefined || appId == null || appId == "" || url == undefined || url == null || url == ""){
		return false;
	}

	window.location.href = __rootPath + '/vuemobile/index.html#' + url;
	// $.post(__rootPath + "/api/proxy/"+appId+".do?url="+url, function(_data){
	// 	if(!_data.success){
	// 		alert(_data.message);
	// 		return false;
	// 	}
	// 	var targetUrl = _data.data.targetUrl;
	// 	var params = targetUrl.substr(targetUrl.indexOf("?") + 1);
	// 	var _token = getUrlParam(params, "token");
	// 	/*if(appId == "daibiaolvzhi"){ //用于测试，正式环境请注释
	// 		_token = "oasjoppkdpa";
	// 	}*/
	// 	$.post(__rootPath + "/api/checkToken.do", {"token":_token}, function(__data){
	// 		//alert("checkToekn:" + __data.success);
	// 		if(!__data.success){
	// 			alert(__data.message);
	// 			return false;
	// 		}
	// 		window.location.href = targetUrl;
	// 	});
	//
	// });
}

//获取参数值
function getUrlParam(targetUri, name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = targetUri.match(reg);
	if (r != null) return unescape(r[2]); return null;
}

function showMore(o){
	$(o).parent().find("li").css({"display":"inline-block"});
	$(o).remove();
}
