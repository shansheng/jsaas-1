
if(self!=top) top.location=self.location;
top['index'] = window;
//设置左分隔符为 <!
baidu.template.LEFT_DELIMITER='<#';
//设置右分隔符为 <!  
baidu.template.RIGHT_DELIMITER='#>';

var bt=baidu.template;


/**
 * 首页TAB
 */
var mainTab;
/**
 * 选中的TAB选项。
 */
var currentTab = null;
/**
 * 主页TAB
 */
var homepageTab;

$(function(){
	mini.parse();
	mainTab=mini.get('mainTab');
	if(mainTab){
		homepageTab=mainTab.getTab("homepage");
	}
})


function closeTab() {
	 mainTab.removeTab(currentTab);
}

function closeAll() {
	 mainTab.removeAll();
}

function onTabsActiveChanged(e){
	var tabs = e.tab;
	var T_width = $("iframe[name='mini-iframe-7']").width();
	var T_width2 = $(".index_box").width();
	var t = setTimeout(function () {
		mini.layout();
	},500)
}

/**
 * 关闭除首页和当前页的所有页签
 * @returns
 */
function closeAllBut() {
	 var tabs= mainTab. getTabs();
	 for(var i=tabs.length;i>=0;i--){
		 var tab=tabs[i];
		 if(tab==homepageTab || tab==currentTab) continue;
		 mainTab.removeTab(tab);
	 }
}

/**
 * 除首页全部关闭。
 * @returns
 */
function closeAllButFirst(){
	 var tabs= mainTab. getTabs();
	 for(var i=tabs.length;i>=0;i--){
		 var tab=tabs[i];
		 if(tab==homepageTab ) continue;
		 mainTab.removeTab(tab);
	 }
}

/**
 * 首页避免关闭。
 * @param e
 * @returns
 */
function onBeforeOpen(e) {
    currentTab = mainTab.getTabByEvent(e.htmlEvent);
    if(currentTab.title=="首页") {
   	 e.cancel = true;
   	 return;
    }
}

/**
 * 获取当前系统。
 * @returns
 */
function getCurrentSys(){
	var id= mini.Cookie.get('SYS_ID_');
	return id;
}


 function exitSwitchUser(){
	location.href=__rootPath +"/j_spring_security_exit_user";
 }

 /*
  * 菜单只允许点击一次，重复点击无效。
  */
 var curMenuId=null;
 
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
	         }else if(config.showType=='FUNS' || config.showType=='FUN'||config.showType=='FUNS_BLOCK'){
	        	 tab.url = __rootPath + '/ui/view/menuView/menuPanel.do?menuId='+config.menuId;
	        	 tabs.addTab(tab);
	        	 tabs.activeTab(tab);
	         }else if(config.showType=='TAB_NAV'){
	        	 tab.url = __rootPath + '/ui/view/menuView/tabPanel.do?menuId='+config.menuId;
	        	 tabs.addTab(tab);
	        	 tabs.activeTab(tab);
	         }
	         else if(config.url!='' && config.url!=undefined && config.url!='null' && config.url!='/index.do' && config.url!='/base/index.do'){
	            tab.url =url;
	            tabs.addTab(tab);
	            tabs.activeTab(tab);
	         }
     }else{
    	//相同则直接返回。
    	 tabs.activeTab(tab);
    	 if(curMenuId==config.menuId) return;
    	 curMenuId=config.menuId;
    	 
    	 tab.url=url;
    	 tabs.reloadTab(tab);
     } 
  }
 
function showTabFromPage(config){
	var id = "tab_" + config.tabId;
	var tabs = mini.get("mainTab");
    var tab = tabs.getTab(id);
    if (!tab) {
        tab = {};
        tab.name = id;
        tab.title = config.title;
        tab.showCloseButton = true;
        tab.url = config.url;
        tab.iconCls=config.iconCls;
        tabs.addTab(tab);
        tabs.activeTab(tab);
    }
    else{
    	tabs.activeTab(tab);
    }
}


/*首页 tab*/
function showTab(node) {
   	var url=node.attr('url');
    var menuId =  node.attr('menuId');
    /*去掉图标---yangxin*/
    //var iconCls= node.attr('iconCls');
	var iconCls= node.attr('');
    var title=node.attr('name');
    var showType=node.attr("showType");
    showTabPage({menuId:menuId,showType:showType,title:title,iconCls:iconCls,url:url});
}


/**
 * 编辑个人信息
 * @returns
 */
function editInfo(){
	showTabFromPage({
		tabId:'editInfo',
		iconCls:'icon-mgr',
		title:'修改个人信息',
		url:__rootPath+'/sys/org/osUser/infoEdit.do'
	});
	
}

/**
 * 打开邮件。
 * @returns
 */
function onEmail(){
	showTabFromPage({
		title:'内部邮件',
		tabId:'onEmail',
		iconCls:'icon-newMsg',
		url:__rootPath+'/oa/mail/mailBox/list.do'
	});
}

/**
 * 显示内部消息
 * @returns
 */
function innerMsgInfo(){
	showTabFromPage({
		title:'内部消息',
		tabId:'innerMsgInfo',
		iconCls:'icon-newMsg',
		url:__rootPath+'/oa/info/infInbox/receive.do'
	});
}

/**
 * 显示我的任务
 * @returns
 */
function getMyTask(){
	showTabFromPage({
		tabId:'getMyTask',
		iconCls:'icon-xitongguanli02',
		title:'待办事项',
		url:__rootPath+'/bpm/core/bpmTask/myList.do'
	});
	
}

function updatePwd(pk){
	showTabFromPage({
		tabId:'updatePwd',
		iconCls:'icon-gerenxingxin',
		title:'修改密码',
		url:__rootPath+'/sys/core/sysAccount/resetPwd.do?accountId='+pk,
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
   					title : "消息内容"
   	        });
		}
	});
}

function changeSystem(e){
	var curId= getCurrentSys();
 	var sysId = $(e).attr('id');
 	var name=$(e).attr('name');
 	mini.Cookie.set('SYS_ID_',sysId);
 	
 	if(curId==sysId) return;

 	/*$(e).siblings().removeClass('active');
 	$(e).addClass('active');*/
 	
 	var curIdx= getActiveMenu(menuData,sysId);
 	buildLeftMemu(menuData,curIdx);
}

function getCurrentSys(){
	var id= mini.Cookie.get('SYS_ID_');
	return id;
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
	$("#divRootMenu").html($("#divRootMenu").html()+rootHtml);
	//toggle
    $("#toggle, .sidebar-toggle").click(function () {
        $('body').toggleClass('compact');
        mini.layout();
    });
}

/**
 * 右键菜单事件。
 * @returns
 */


function attachMenuEvents(){
	 var first = $('.sidemenu li.firstmenu:first .secondmenu');
	 
	 if(first.length>0){
		 $('.sidemenu li.firstmenu>p:first').siblings('ul').slideDown(300);/*默认展开第一个树*/
		 $('.sidemenu li.firstmenu>p:first').parent("li").addClass("active");/*默认图标变减号*/
	 }
	 $('.sidemenu li.firstmenu>p').click(function(){
	        $(this).parent('li').siblings('li').removeClass('active');
	        $(this).siblings('ul').children('li').removeClass('active');
	        $(this).parent('li').addClass('active');
	        $(this).parent('li').siblings('li').children('ul').slideUp(300);
	        $(this).siblings('ul').slideToggle(300); 
	        showTab($(this));
	    });
	 
	    $('.sidemenu .secondmenu>li>p').click(function(){
	    	$(this).parent('li').parent('ul').siblings("ul").children('li').removeClass('active').children('ul').slideUp(300);
	    	$(this).parent('li').siblings('li').removeClass('active');
	        $(this).siblings('ul').children('li').removeClass('active');
	        $(this).parent('li').addClass('active');
	        $(this).parent('li').siblings('li').children('ul').slideUp(300);
	        $(this).siblings('ul').slideToggle(300);
	        showTab($(this));
	    });
	    $('.sidemenu .threemenu>li>p').siblings('ul').slideUp(300);
	    $('.sidemenu .threemenu>li>p').click(function(){
	    	$(this).parent('li').siblings('li').removeClass('active');
	        $(this).siblings('ul').children('li').removeClass('active');
	        $(this).parent('li').addClass('active');
	        $(this).parent('li').siblings('li').children('ul').slideUp(300);
	        $(this).siblings('ul').slideToggle(300);
	    	 showTab($(this)); 
	    });
	    $('.sidemenu .fourmenu>li>p').click(function(){
	    	$(this).parent('li').siblings('li').removeClass('active');
	        $(this).siblings('ul').children('li').removeClass('active');
	        $(this).parent('li').addClass('active');
	        $(this).parent('li').siblings('li').children('ul').slideUp(300);
	        $(this).siblings('ul').slideToggle(300);
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


/**
 * 菜单搜索
 * ctrl +shift + f
 */
$(function(){
	var activeList = -1,TimeVal;
	$(document).keydown(function(event){
		if(event.ctrlKey && event.shiftKey && event.keyCode === 70){
			$('.search').css('left',4)
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