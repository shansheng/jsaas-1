$(function(){
	//定义一个全局变量接收点击 中间模块的 下标
	var hiddenIndex = "0";
	//定义一个全局变量接收 应用模板 里面应用的个数
	var modNumber ='0';

	//设置bodys高度；
	bodyResize();
	$(window).resize(function(){
		bodyResize();
	});

	//hover 中间模板出现   排序框
	$("#centerUl").on("mouseover","li.centerLi",function(){
		$(this).find(".editBox").stop().fadeIn(200);
	});
	$("#centerUl").on("mouseout","li.centerLi",function(){
		$(this).find(".editBox").stop().fadeOut(200);
	});

	/*$("body").on("click","li.del",function(){
		$(this).parents("li.centerLi").remove();
	});
	$("#centerUl").on("click",".editBox li.up",function(){
		var demo = $(this).closest(".centerLi");
		var prevId = $(this).closest(".centerLi").prev().attr("id");
		$(demo).insertBefore($("#"+prevId));
	});
	$("#centerUl").on("click",".editBox li.dow",function(){
		var demo = $(this).closest(".centerLi");
		var prevId = $(this).closest(".centerLi").next().attr("id");
		$(demo).insertAfter($("#"+prevId));
	});*/

	//点击排序框 事件
	//上移
	$(".centerUl").on("click","li.up",function(event){
		var htmL_li = $(this).parents("li.centerLi");
		if (htmL_li.index() == 0 ) {
			alert("当前已经是第一个了喔，亲~");
		} else{
			htmL_li.hide().prev().before(htmL_li);
			htmL_li.fadeIn(300);
		}
		event.stopPropagation();
	});
	//下移
	$(".centerUl").on("click","li.dow",function(event){
		var htmL_li = $(this).parents("li.centerLi");
		var html_ul = $(this).parents(".centerUl").find(".centerLi").length;

		if(htmL_li.index() == html_ul - 1){
			alert("当前已经是最后一个了喔，亲~")
		}else{
			htmL_li.hide().next().after(htmL_li);
			htmL_li.fadeIn(300);
		}
		event.stopPropagation();
	});
	//删除
	$(".centerUl").on("click","li.del",function(event){
		$(this).parents("li.centerLi").fadeOut("500",0,function(){
			$(this).remove();
		});
		event.stopPropagation();
	});

	rollBanners();
});

function appendToDemo(typeId, name, btnType){
	if(btnType == "pic"){
		banners(typeId, name);
	}else if(btnType == "btn"){
		apps(typeId, name);
	}
}

function banners(typeId, name){
	if($("#centerUl>#mod_"+typeId).length > 0){
		return false;
	}
	$("#mod_banner").find(".centerLi").attr("id", "mod_"+typeId);
	$("#mod_banner").find(".picBox").html("");
	$.post(__rootPath+"/wx/portal/wxPortalBtn/listDataByType_"+typeId+".do?", function(dat){
		if(dat.length != 0){
			for(var i = 0; i < dat.length; i++){
				var ht_ = "";
				if(dat[i].icon != undefined && dat[i].icon != null && dat[i].icon != ""){
					ht_ = '<li><img src="'+__rootPath+'/jkww/core/pictureShow/showImageIO.do?url='+encodeURI(dat[i].icon)+'"/></li>'
				}
				$("#mod_banner").find(".picBox").append(ht_);
			}
		}
		var mod_banner = $("#mod_banner").html();
		$("#centerUl").append(mod_banner);
		$("#mod_banner").find(".centerLi").removeAttr("id");
		//init banner
		rollBanners();
	}, 'json');
}

function apps(typeId, name){
	//init
	if($("#centerUl>#mod_"+typeId).length > 0){
		return false;
	}
	$("#mod_app").find(".moduleHeadline").html("");
	$("#mod_app").find(".moduleUl").html("");
	//create
	$("#mod_app").find(".centerLi").attr("id", "mod_"+typeId);
	$("#mod_app").find(".moduleHeadline").html("<span>"+name+"</span>");
	$.post(__rootPath+"/wx/portal/wxPortalBtn/listDataByType_"+typeId+".do?", function(dat){
		var maxIcon = 6;
		if(dat.length != 0){
			//var maxIcon = 4; //可以显示的图标数量
			for(var i = 0; i < dat.length; i++){
				var ht_ = "";
				var hide = ""
				if(dat[i].icon == undefined || dat[i].icon == null || dat[i].icon == ""){
					ht_ = '<li class="moduleLi" style="'+hide+'" onclick="gotoUrl(\''+dat[i].appId+'\', \''+dat[i].url+'\')"><span></span><p>'+dat[i].name+'</p></li>';
				} else {
					ht_ = '<li class="moduleLi" style="'+hide+'" onclick="gotoUrl(\''+dat[i].appId+'\', \''+dat[i].url+'\')"><span style="background:transparent;"><img src="'+__rootPath+'/jkww/core/pictureShow/showImageIO.do?url='+encodeURI(dat[i].icon)+'" style="width:100%;height:100%;"></span><p>'+dat[i].name+'</p></li>'
				}
				$("#mod_app").find(".moduleUl").append(ht_);
			}
		}
		if(dat.length > maxIcon){
			var _lis = $("#mod_app").find(".moduleUl>li");
			var ht_ = '<li class="moduleLi" onclick="showMore(this);"><span style="background:transparent;"><img src="'+__rootPath+'/scripts/weixin/portal/css/img/more.png" style="width:100%;height:100%;"></span><p>更多</p></li>'
			$(_lis[3]).before(ht_);
			$("#mod_app").find(".moduleUl>li:gt(5)").css({"display":"none"});
		}
		var mod_banner = $("#mod_app").html();
		$("#centerUl").append(mod_banner);
		$("#mod_app").find(".centerLi").removeAttr("id");
	}, 'json');
}

function showMore(o){
	$(o).parent().find("li").css({"display":"inline-block"});
	$(o).remove();
}

/*function rollBanners(){
	var liCopy =$("#centerUl").find("ul.picBox").find("li").first().clone();
	$("#centerUl").find("ul.picBox").append(liCopy);
	var picBox_li = $("#centerUl").find("ul.picBox").find("li").size();
	var Roll =0;
	var rollUl = $("#centerUl").find("ul.picBox");
	var timRoll =setInterval(rollLeft,2000)
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
		rollUl.stop().animate({"left":-(Roll*372)},1000);
	}
}*/
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

function bodyResize(){
	var bodyHeight = $(window).height();
	$(".bodys").height(bodyHeight);
	//设置右边编辑栏的 #addApplyBox最大高度
	$("#addApplyBox").css("maxHeight",bodyHeight-300);
}