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

$(function(){
	initMenu();
    //dropdown
    $(".dropdown-toggle").click(function (event) {
        $(this).parent().addClass("open");
        return false;
    });

    $(document).click(function (event) {
        $(".dropdown").removeClass("open");
    });
});

var menuData;
var menu;

function initMenu(){
	//menu
    menu = new Menu("#mainMenu", {
        itemclick: function (item) {
            if (!item.children) {
                activeTab(item);
            }
        }
    });
	var url=__rootPath +"/getMenus.do";
	$.get(url,function(data){
		menuData=data;
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
    new MenuTip(menu);
	var menuData=data[curIdx].children;
    menu.loadData(menuData);
}


