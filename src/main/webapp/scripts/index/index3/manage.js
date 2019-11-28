//设置左分隔符为 <!
baidu.template.LEFT_DELIMITER='<#';
//设置右分隔符为 <!  
baidu.template.RIGHT_DELIMITER='#>';
var bt=baidu.template;

/**
 * Created by Devin on 2016/6/16.
 */

if(self!=top) top.location=self.location;
top['index'] = window;


$(function(){
	var winW,logoW,userW;
winW = $(document).innerWidth();
userW = $('#fr').innerWidth();
window.onload = function(){
	logoW = $('.logo').innerWidth();
	$('#tabsbox').width( winW - logoW - userW - 5);
}


 var tabsbox_W = $('.tabsbox').innerWidth(), tabwrap_W = $('.movewrap')
		.innerWidth() + 20, menu_P, window_W, X = 0;
if (tabsbox_W < tabwrap_W) {
	$('#tabsbox .fr').css('display', 'block');
} else {
	$('#tabsbox .fr').css('display', 'none');
	$('.tabwrap').animate({
		left : 0
	}, 300);
} 

$(window).resize(function() {
	winW = $(document).innerWidth();
	logoW = $('.logo').innerWidth();
	userW = $('#fr').innerWidth();
	$('#tabsbox').width( winW - logoW - userW -5 );
	tabsbox_W = $('.tabsbox').innerWidth();
	tabwrap_W = $('.movewrap').innerWidth() + 60;
	if (tabsbox_W < tabwrap_W) {
		$('#tabsbox .fr').css('display', 'block');
	} else {
		$('#tabsbox .fr').css('display', 'none');
		$('.movewrap').animate({
			left : 0
		}, 400);
	}
	setTimeout('mini.layout();',400);
});
/*左右伸缩*/
$(document).on("click",".mini-tools-collapse",function(){
	setTimeout('mini.layout();',400);
});
$(document).on('click', '.fr .icon-next', function() {
	menu_P = $('.movewrap').position().left;
	tabwrap_W = $('.movewrap').innerWidth();
	tabsbox_W = $('.tabsbox').innerWidth();
	window_W = $(window).width();
	
	
	if (tabwrap_W + menu_P > tabsbox_W) {
		X++;
		$('.movewrap').animate({
			left : -X * 100
		}, 300);
	} else {
		return false;
	}
}).on('click', '.fr .icon-prev', function() {
	if (X > 0) {
		X--;
		$('.movewrap').animate({
			left : -X * 100
		}, 300);
	}
});
});

function setSize(){
	 var winWidth = $(window).width();
	 var winHeight= $(window).height();
	 if($('.side').is(':hidden')){
		 $('.content').width(winWidth-5);
	 }else{
		 $('.content').width(winWidth-241);
	 }
	var top=$('#top');
	if(top.css('display')!='none'){
		 $('.iframe').height(winHeight-185);
		 $('.content').height(winHeight-130);
		 $('.split').height(winHeight-130);
		 $('.side').height(winHeight-130);
	}else{
		 $('.iframe').height(winHeight-95);
		 $('.content').height(winHeight-40);
		 $('.split').height(winHeight-40);
		 $('.side').height(winHeight-40);
	}
	mini.layout();
	//mainTab.doLayout();
}

$(function(){
	var activeList = -1,TimeVal;
	$(document).keydown(function(event){
		if(event.ctrlKey && event.shiftKey && event.keyCode === 70){
			$('.search').css('left',0)
			$('.searchVal').focus();
			event.preventDefault();
		};
		
		var isFocus = $('.searchVal').is(':focus'),
			listLen = $('.listBox li').length;
		if(isFocus){
			if(event.keyCode === 38 && activeList > 0){
				event.preventDefault();
				activeList--;
				$('.listBox li').removeClass('activeSe').eq(activeList).addClass('activeSe');
		    }else if(event.keyCode === 40 && (activeList+1)<listLen){
		    	event.preventDefault();
		    	activeList++;
				$('.listBox li').removeClass('activeSe').eq(activeList).addClass('activeSe');
		    }
		};
		if(event.keyCode === 13 && listLen){
			activeList = -1;
			if($('.listBox li[class=activeSe]').length){
				$('.listBox li[class=activeSe]').trigger("click");
			}else{
				$('.listBox li').each(function(){
					if($(this).text() === $('.searchVal').val()){
						$(this).trigger("click");
					}
				});
			}
		}
	});

	$('.searchVal')
		.bind('input propertychange', function() {  
			$('.listBox').html('');
			var searchValue = $('.searchVal').val();
			if(!searchValue){
				$('.listBox').html('');
				return;
			}
			function getKey(Data){
				var Val = Data,Html='';
				for(var item=0; item<Val.length ; item++){
					if(Val[item].children){
						getKey(Val[item].children);
						continue;
					}
					if(Val[item].text.indexOf(searchValue) != -1){
						Html += "<li menuId="+Val[item].id+" showType="+Val[item].showType+" title="+Val[item].text+" url="+Val[item].url+" iconCls="+Val[item].iconCls+">"+Val[item].text+"</li>"
					}
			    }
				$('.listBox').append(Html)
			};
			getKey(menuData);
		})
		.blur(function(){
			TimeVal = setTimeout(function(){
				$('.search').css('left',-255);
			},4000);
		})
		.focus(function(){
			clearTimeout(TimeVal);
		});
	
	$('.listBox').on('click','li',function(){
		var dataObj = {
			"menuId":$(this).attr('menuId'),
			"showType":$(this).attr('showType'),
			"title":$(this).attr('title'),
			"url":$(this).attr('url'),
			"iconCls":$(this).attr('iconCls')
		};
		showTabPage(dataObj);
		$('.listBox').html('');
		$('.searchVal').val('');
		$('.searchVal').blur();
	});
});

//进入全屏
function requestFullScreen(element) {
	var requestMethod = element.requestFullScreen || element.webkitRequestFullScreen || element.mozRequestFullScreen || element.msRequestFullScreen;
	if (requestMethod) {
		requestMethod.call(element);
	}else if (typeof window.ActiveXObject !== "undefined") {
		var wscript = new ActiveXObject("WScript.Shell");
		if (wscript !== null) {
			wscript.SendKeys("{F11}");
		}
	}
};
//退出全屏
function exitFull() {
	var exitMethod = document.exitFullscreen || document.mozCancelFullScreen || document.webkitExitFullscreen || document.webkitExitFullscreen; 
	if (exitMethod) {
		exitMethod.call(document);
	}
	else if (typeof window.ActiveXObject !== "undefined") {
		var wscript = new ActiveXObject("WScript.Shell");
		if (wscript !== null) {
			wscript.SendKeys("{F11}");
		}
	}
};

$(function(){
    var winWidth = $(window).width();
    var winHeight= $(window).height();
    $('.side').height(winHeight-130);

    $('.iframe').height(winHeight-185);
    $('.content').height(winHeight-130);
    $('.split').height(winHeight-130);
    $('.content').width(winWidth-241);
   
    mini.layout();
  
    $(window).resize(function(){
    	setTimeout('setSize()',500);
    });

    attachMenuEvents();
    $('.close').click(function(){
        $(this).parent('div').remove();
    });

    /*左右伸缩*/
   $('.side .shs').click(function(){
	   var winWidth = $(window).width();
       $('.side').hide();
       $('.content').width(winWidth-5);
       $('.split').show();
       mainTab.doLayout();
   });
    $('.split').click(function(){
    	var winWidth = $(window).width();
        $(this).hide();
        $('.content').width(winWidth-241);
        $('.side').show();
        mainTab.doLayout();
    });
});

function attachMenuEvents(){
	  $('.sidemenu li.firstmenu>p').click(function(){
	        $(this).parent('li').siblings('li').removeClass('active');
	        $(this).siblings('ul').children('li').removeClass('active');
	        $(this).parent('li').toggleClass('active');
	        $(this).parent('li').siblings('li').children('ul').slideUp(300);
	        $(this).siblings('ul').slideToggle(300);
	        $('.sidemenu .threemenu').slideUp(300);
	        showTab($(this));
	    });
	    $('.sidemenu .secondmenu>li>p').click(function(){
	        $(this).siblings('ul').slideToggle(300);
	        showTab($(this));
	    });
	    
	    $('.threemenu>li').click(function(){
	    	 showTab($(this));
	    });
	    
	    $(".sidemenu p").hover(
    		function(){
    			$(this).addClass('secondActive');
    		},
    		function(){
    			$(this).removeClass('secondActive')
    		}
		);
	    	    
}

$(function(){
	initMenu();
});

var menuData;


function initMenu(){
	var url=__rootPath +"/getMenus.do";
	$.get(url,function(data){
		menuData=data;
		console.log(menuData);
		var curId= getCurrentSys();
		var curIdx=getActiveMenu(data,curId);
		//构建根导航
		buildRootMenu(data,curIdx);	
		//构建左侧导航
		buildLeftMemu(data,curIdx);
		
		//检测是否需要显示tab滑动按钮
		var tabsbox_W = $('.tabsbox').innerWidth(),
			tabwrap_W = $('.movewrap').innerWidth();
		if( tabsbox_W < tabwrap_W ){
			$('#tabsbox .fr').css('display','block');
		}else{
			$('#tabsbox .fr').css('display','none');
		}
		
	});
}

function buildLeftMemu(data,curIdx){
	var menuData=data[curIdx].children;
	//若子系统下有子菜单，则展示左边 并激活第一个菜单
	if(menuData && menuData.length>0){
		
		try{
			mainLayout=mini.get('mainLayout');
			if(mainLayout){
				mainLayout.updateRegion('west',{ visible: true });
			}
		}
		catch(e){
		}
		
		var data={"list":menuData};
		console.info(data);
		var menuHtml=bt('leftMenuTemplate',data);
		$("#sidemenu").html(menuHtml).hide().slideToggle(300);
		attachMenuEvents();
		showTabPage({menuId:menuData[0].menuId,showType:menuData[0].showType,
			title:menuData[0].name,
			iconCls:menuData[0].iconCls,url:menuData[0].url});
	}else{//子系统只有一个单页		
		try{
			mainLayout=mini.get('mainLayout');
			if(mainLayout){
				mainLayout.updateRegion('west',{ visible: false });	
			}
		}
		catch(e){
		}
		 
		showTabPage({menuId:data[curIdx].menuId,showType:'URL',
			title:data[curIdx].name,
			iconCls:data[curIdx].iconCls,
			url:data[curIdx].url});
	}
}

//获取激活的导航。
function getActiveMenu(data,curId){
	if(!curId) return 0;
	for(var i=0;i<data.length;i++){
		var o=data[i];
		if(o.menuId==curId) return i;
	}
	return 0;
}

//构建导航条。
function buildRootMenu(data,curIdx){
	var menuData={"list":data,idx:curIdx};
	var rootHtml=bt('rootTemplate',menuData);
	$("#divRootMenu").html(rootHtml);
}



function getCurrentSys(){
	var id= mini.Cookie.get('SYS_ID_');
	return id;
}

function changeSystem(e){
	var curId= getCurrentSys();
 	var sysId = $(e).attr('id');
 	var name=$(e).attr('name');
 	//mini.Cookie.set('SYS_ID_',sysId);
 	
 	if(curId==sysId) return;

 	$(e).siblings().removeClass('active');
 	$(e).addClass('active');
 	
 	var curIdx= getActiveMenu(menuData,sysId);
 	buildLeftMemu(menuData,curIdx);
 }

mini.parse();

var mainTab=mini.get('mainTab');
function fullclick(){
	var winWidth = $(window).width();
    var winHeight= $(window).height();
    if($(".side").is(":hidden")){
    	$('.content').width(winWidth-5);
    }else{
    	$('.content').width(winWidth-241);
    }

    var mainLayout=mini.get('mainLayout');
	var top=$('#top');
	if(top.css('display')!='none'){
		 mainLayout.updateRegion("north", { height: 35 });
		top.css('display','none');
		
		$('.iframe').height(winHeight-95);
		 $('.content').height(winHeight-40);
		 $('.split').height(winHeight-40);
		 $('.side').height(winHeight-40);
		
	}else{
		 mainLayout.updateRegion("north", { height: 85 });
		 top.css('display','');
		
		 $('.iframe').height(winHeight-185);
		 $('.content').height(winHeight-130);
		 $('.split').height(winHeight-130);
		 $('.side').height(winHeight-130);
		
	}
	mainTab.doLayout();
	mini.layout();
}

 function closeTab() {
	 mainTab.removeTab(currentTab);
 }
 function closeAllBut() {
	 mainTab.removeAll(currentTab);
 }
 function closeAll() {
	 mainTab.removeAll();
 }
 function closeAllButFirst() {
//     var but = [currentTab];
//     but.push(mainTab.getTab("first"));
//     mainTab.removeAll(but);
	 mainTab.removeAll(mainTab.getTab(0));
 }

 var currentTab = null;

 function onBeforeOpen(e) {
     currentTab = mainTab.getTabByEvent(e.htmlEvent);
     if (!currentTab) {
         e.cancel = true;
     }
 }

 function showTab(node) {
   	var url=node.attr('url');
    var menuId =  node.attr('menuId');
    var iconCls= node.attr('iconCls');
    
    var title=node.attr('name');
    var showType=node.attr("showType");
  
    showTabPage({menuId:menuId,showType:showType,title:title,iconCls:iconCls,url:url});
 }
 
 var fstate = 0;
	function fullCommScreen() {
		if (fstate == 0) {
			requestFullScreen(document.documentElement);
			$("#fullscreen").removeClass("icon-Maximization");
			$("#fullscreen").addClass("icon-Minimize");
			fstate = 1;
		} else {
			exitFull();
			$("#fullscreen").addClass("icon-Maximization");
			$("#fullscreen").removeClass("icon-Minimize");
			fstate = 0;
		}
	}
	
	function exitSwitchUser(){
		location.href=__rootPath +"/j_spring_security_exit_user";
	}
 

 
 function showTabPage(config){
	 var url=config.url;
     if(url && url.indexOf('http')==-1){
    	 url=__rootPath+config.url;
     }
	 var id = "tab_" + config.menuId;
     var tabs = mini.get("mainTab");
     var tab = tabs.getTab(id);
    
     if (!tab) {
      	tab = {};
         tab.name = id;
         tab.title = config.title;
         tab.iconCls=config.iconCls;
         tab.showCloseButton = true;
     	if(config.showType=='NEW_WIN'){
	        	 _OpenWindow({
					title : config.title,
					max : true,
					height : 500,
					width : 800,
					url : url
				});
	         }else if(config.showType=='FUNS' || config.showType=='FUN'|| config.showType=='FUNS_BLOCK'){
	        	 tab.url = __rootPath + '/ui/view/menuView/menuPanel.do?menuId='+config.menuId;
	        	 tabs.addTab(tab);
	        	 tabs.activeTab(tab);
	         }else if(config.showType=='TAB_NAV'){
	        	 tab.url = __rootPath + '/ui/view/menuView/tabPanel.do?menuId='+config.menuId;
	        	 tabs.addTab(tab);
	        	 tabs.activeTab(tab);
	         }
	         else if(config.url!='' && config.url!=undefined && config.url!='null'){
	            tab.url =url;
	            tabs.addTab(tab);
	            tabs.activeTab(tab);
	         }
     }else{
    	 tab.url=url;
    	 tabs.activeTab(tab);
     } 
  }
 
function showTabFromPage(config){
	var tabs = mini.get("mainTab");
	var id = "tab_" + config.tabId;
    var tab = tabs.getTab(id);
    if (!tab) {
        tab = {};
        tab.name = id;
        tab.title = config.title;
        tab.showCloseButton = true;
        tab.url = config.url;
        tab.iconCls=config.iconCls;
        tabs.addTab(tab);
    }
    tabs.activeTab(tab);
}
 
//点击公司门户
	
function editInfo(){
	showTabFromPage({
		tabId:'editInfo',
		iconCls:'icon-mgr',
		title:'修改个人信息',
		url:__rootPath+'/sys/org/osUser/infoEdit.do'
	});
 	
 }
 function onEmail(){
 	showTabFromPage({
 		title:'内部邮件',
 		tabId:'onEmail',
 		iconCls:'icon-newMsg',
 		url:__rootPath+'/oa/mail/mailBox/list.do'
 	});
 }
 	
 function innerMsgInfo(){
 	showTabFromPage({
 		title:'内部消息',
 		tabId:'innerMsgInfo',
 		iconCls:'icon-newMsg',
 		url:__rootPath+'/oa/info/infInbox/receive.do'
 	});
 }

function showNewMsg() {
    _SubmitJson({
		url : __rootPath+"/oa/info/infInnerMsg/count.do",
		showMsg:false,
		method:"POST",
		showProcessTips:false,
		success:function(result){
			newMsg=result.data;
			if(newMsg==0) return;
   			var uid = 1;
   			_OpenWindow({
   					url : __rootPath +"/oa/info/infInbox/indexGet.do?&uId="+uid,
   					width : 500,
   					height : 308,
   					title : "消息内容",
   					ondestroy : function(action) {
   					}
   	        });
		}
	});
}

function newMsg(newMsgCount){
	if(newMsgCount!=0){
    	window.setInterval(function(){
    		$(".app").html('<span style="color:red">消息('+newMsgCount+')</span>');
        	window.setTimeout(function(){
        		$(".app").html('<span >消息('+newMsgCount+')</span>');
        		},1000);
    		}, 2000);

    }else{
    	$("#msg").find("span").append('<span class="mini-button-icon mini-iconfont icon-msg" style=""></span>消息');
    }
}

