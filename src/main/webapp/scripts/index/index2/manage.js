

$(function(){
	var tabsbox_W = $('.tabsbox').innerWidth(),
	tabwrap_W = $('.movewrap').innerWidth() +20,
	menu_P,
	window_W,
	X = 0;
	if( tabsbox_W < tabwrap_W ){
		$('#tabsbox .fr').css('display','block');
	}else{
		$('#tabsbox .fr').css('display','none');
		$('.tabwrap').animate( {left:0} , 300 );
	}
	$(window).resize(function() {
		tabsbox_W = $('.tabsbox').innerWidth();
		tabwrap_W = $('.movewrap').innerWidth() +60;
		if( tabsbox_W < tabwrap_W ){
			$('#tabsbox .fr').css('display','block');
		}else{
			$('#tabsbox .fr').css('display','none');
			$('.tabwrap').animate( {left:0} , 300 );
		}
	
	});
	$(document).on('click' , '.fr .icon-prev' , function(){
		    	if( X > 0){
					X --;
					$('.tabwrap').animate( {left:-X*100} , 300 );
				}
   		})
		.on( 'click' , '.fr .icon-next' , function(){
			menu_P = $('.movewrap').offset().left;
	    	tabwrap_W = $('.movewrap').innerWidth();
	    	tabsbox_W = $('.tabsbox').innerWidth();
	    	window_W = $(window).width();
	    	if( tabwrap_W+menu_P >  window_W - 100 ){
    			X ++;
    			$('.tabwrap').animate( {left:-X*100} , 300 );
	    	}else{
	    		return false;
	    	}
		});
});

$(window).resize(function() {
	setTimeout('mini.layout();',400);
});
$(document).on("click",".mini-layout-spliticon",function(){
	setTimeout('mini.layout();',400);
});
	
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
});

var menuData;


function initMenu(){
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
		var menuHtml=bt('leftMenuTemplate',data);
		$("#sidemenu").html(menuHtml).hide().slideToggle(300);
		attachMenuEvents();
		
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


