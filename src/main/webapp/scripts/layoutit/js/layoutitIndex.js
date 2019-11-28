
/*function loadPortal(alias){
	var url=__rootPath + "/oa/info/insPortalDef/getPortalData/"+alias+".do";
	$.get(url,function(data){
		handData(data);
	})
}


function loadUserPortal(){
	var url=__rootPath + "/oa/info/insPortalDef/getPersonalPort.do";
	$.get(url,function(data){
		handData(data);	
	})
}*/

var gridster = null;
function handData(){
	/*if(data){
		$(".personalPort").html(data);
	}*/
	mini.parse();
	/*$(data).find('.script script').each(function(){
		eval($(this).html());
	});*/
	
	gridster = $(".personalPort .gridster > ul").gridster({
        widget_base_dimensions: ['auto', 120],
        autogenerate_stylesheet: true,
        min_cols: 1,
        max_cols: 6,
        widget_margins: [10, 10],
    }).data('gridster');
    $('.personalPort  .gridster  ul').css({'padding': '0'});
    gridster.disable();
    ininFrontEcharts(); //加载echarts, --append by Louis 
}

function refresh(colId) {
	$.ajax({
		url : __rootPath + "/oa/info/insColumnDef/getColHtml.do?colId="+ colId,
		method : "POST",
		success : function(data) {
			$("div[colid=" + colId + "]")[0].outerHTML = data;
		}
	});
}

/**
 * 打开处理窗口。
 * @param url
 * @param title
 * @param solId
 * @returns
 */
function openUrl(url,title){
	_OpenWindow({
		title : title,
		height : 400,
		width : 780,
		max : true,
		url :url,
		ondestroy : function(action) {
			location.href=location.href+"?time="+new Date().getTime();		
		}
	});
}



function showMore(colId, name, moreUrl) {
	moreUrl = __rootPath + moreUrl;
	mgrNewsRow(colId, name, moreUrl);
}

function showTabMore(obj) {
	var active = $(obj).parent().parent().find(".activeSpan");
	var colId = active.attr("colid");
	var name = active.attr("title");
	var moreUrl = active.attr("url");
	if(!moreUrl)return;
	moreUrl = __rootPath + moreUrl;
	mgrNewsRow(colId, name, moreUrl);
}

function refreshTab(obj) {
	var active = $(obj).parent().parent().find(".activeSpan");
	var colId = active.attr("colid");
	$.ajax({
		url : __rootPath + "/oa/info/insColumnDef/getColHtml.do?colId="+ colId,
		method : "POST",
		success : function(data) {
			$("div[colid=" + colId + "]")[0].outerHTML = data;
		}
	});
}

//打开一个新的页面显示这个栏目的more
function mgrNewsRow(colId, name, moreUrl) {
	top['index'].showTabFromPage({
		title : name,
		tabId : 'colNewsMgr_' + colId,
		url : moreUrl
	});
}

//打开设置门户页面
function setPort() {
	$.ajax({
		url : __rootPath + "/oa/info/insPortalDef/setPersonalPort.do",
		method : "POST",
		success : function(data) {
			_OpenWindow({
				title : '门户配置',
				height : 400,
				width : 780,
				max : true,
				url : __rootPath
						+ '/scripts/layoutit/layoutitIndex.jsp?portId='
						+ data,
				ondestroy : function(action) {
					location.reload();
				}
			});
		}
	})
}
$('.mini-tabs-body-top:eq(0)', parent.document).children().addClass('index_box');

function card_msg(num){
	$(".card_msg ul li").css('width','calc(100% / '+num+' - 20px)');
}


$(document).on("click","#Refresh",function(){
	$(this).parents('.widget-body').siblings().show();
});


var windowW=$(window).width();
window.onresize = function(){
	cardResponse();	
}; 



function cardResponse(){
	windowW=$(window).width();
	if(windowW < 1000){
		$('body').attr('class', '').addClass('winW1000');
	}else if(windowW < 1190){
		$('body').attr('class', '').addClass('winW1190');
	}else if(windowW < 1260){
		$('body').attr('class', '').addClass('winW1260');
	}else if(windowW < 1400){
		$('body').attr('class', '').addClass('winW1400');
	}else if(windowW < 1600){
		$('body').attr('class', '').addClass('winW1600');
	}else{
		$('body').attr('class', '');
	}
};
/*设置左侧导航的高*/
$(function(){
	 var _heighOl =$("ol.cardUl").height();
	/* alert($("ol.cardUl"));
	 alert(_heighOl);*/
	 //$("ol.cardUl").parents("li.gs-w").height(_heighOl);
});

/*多TAB*/
$(function(){
	$(window).resize(function(){
		toolTabs();
		$("#tabRollBox").css("left","0")
	})
	var outTime = setTimeout(function(){
		toolTabs();
		$(".tabRollBox li").eq(0).addClass("activeSpan");
	},500);
	//toolTabs();
	var tabRollBox_width = $("#tabRollBox").width();
	function toolTabs(){
		var tims = setTimeout(function () {
			var tabHeaderLeft = $("#tabHeaderLeft").width();
			console.log(tabHeaderLeft +":"+ tabRollBox_width);
			if (tabHeaderLeft < tabRollBox_width) {
				$(".oTabBtn").css("display","inline-block");
			}else{
				$(".oTabBtn").css("display","none");
			}
		},300);


		var isclick= true;
		$(".tabHeaderRight .tabBtnRight").click(function(){
			 if(isclick){
			 	isclick= false;
		       	var tabRollBox = $(this).parents(".tabHeader").find("#tabRollBox");
				var tabRollBox_li_width = tabRollBox.find("li").outerWidth();
				var tabRollBox_left =Math.abs( parseInt(tabRollBox.css("left")));
				var tabRollBox_right =tabRollBox.css("right");
				if (tabRollBox_right < "0px") {
					tabRollBox.stop().animate({"left":-tabRollBox_left - tabRollBox_li_width-20},400);
				}
				console.log(tabRollBox.css("right"));
				setTimeout(function(){
		            isclick = true;
		        }, 400);
			}
		})
		$(".tabHeaderRight .tabBtnLeft").click(function(){
			if(isclick){
				isclick= false;
				var tabRollBox = $(this).parents(".tabHeader").find("#tabRollBox");
				var tabRollBox_li_width = tabRollBox.find("li").outerWidth();
				var tabRollBox_left =parseInt(tabRollBox.css("left"));
				if (tabRollBox_left < 0 ) {
					tabRollBox.stop().animate({"left":tabRollBox_left + tabRollBox_li_width+20});
				}
				setTimeout(function(){
			            isclick = true;
		        }, 400);
			}
		})
		$(".tabRollBox").on("click","li",function(){
			var _index =$(this).index();
			var contentBox = $(this).parents(".toolTabs").find(".tabContent").find(" .contentBox");
			$(this).addClass("activeSpan").siblings().removeClass("activeSpan");
			contentBox.eq(_index).show().siblings().hide();
		})
		//判断数据显示是否为0  为0则不显示；
		var tabRollBoxLi = $(".tabRollBox li");
		for (var i = 0 ;i< tabRollBoxLi.length ; i++) {
			var b_text = tabRollBoxLi.eq(i).find("b").text();
			if (b_text == 0 ) {
				tabRollBoxLi.eq(i).find("b").hide();
			}
		}
	}

})