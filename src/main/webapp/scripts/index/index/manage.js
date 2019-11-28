var menuData;
$(function(){
	var url=__rootPath +"/getMenus.do";
	$.getJSON(url,function(data){
		menuData=convertArray(data);
		$("#menu1").sidemenu({data: menuData});	
	    var sidebarH = $(".sidebar").height();
	    var menuH = $("#menu1").innerHeight()-8;
	    $(".sidebar_btn").hide();
	    if( sidebarH < menuH ){
	    	$(".sidebar_btn").show();
	    }
	    var p = $('#menu1>ul').position().top;
	});
})

function showTab(node) {
  	var conf={
  		menuId:node.id,
  		url:node.url,
  		showType:$(node).attr('showType'),
  		iconCls:node.firstChild.className,
  		title:node.innerText
  	};
  	showTabPage(conf)
}

var menu1 = $("#menu1").innerHeight()-8;
var sidebarH= '';

$(window).resize(function () {
    var sidebarH = $(".sidebar").height();
    menu1 = $("#menu1").innerHeight()-8;
    $(".sidebar_btn").hide();
    if( sidebarH < menu1 ){
    	$(".sidebar_btn").show();
    }else{
    	$('#menu1>ul').animate( {top:0} , 200 );
    	x = 0;
    }
    
    $("#Screen").children().eq(1).hide();
	$("#Screen h5:eq(0)").on('click',function(){
		$("#Screen").children().hide().eq(1).show();
		$(this).parent().attr('title','正常显示');
		requestFullScreen(document.documentElement);
	});
	
	$("#Screen h5:eq(1)").on('click',function(){
		$("#Screen").children().hide().eq(0).show();
		$(this).parent().attr('title','全屏显示');
		exitFull();
	});
});

var x = 0;

$(document).on('click' , '.sidebar_btn_up' , function(){
	p = $('#menu1>ul').position().top;
 	menu1 = $("#menu1").height() +8 +55;
 	sidebarH = $(".sidebar").height();

	if( p+menu1 > sidebarH ){
    	x -= 100;
    	$('#menu1>ul').animate( {top:x} , 200 );	
	}else{
		$('#menu1>ul').animate( {top:x} , 200 );
	}
})
.on( 'click' , '.sidebar_btn_down' , function(){
	p = $('#menu1>ul').position().top;
	
	if( p < 55 ){
		x += 100;
		$('#menu1>ul').animate( {top:x} , 200 );
	}
});

function convertArray(data){
	var aryJson=[];
	for(var i=0;i<data.length;i++){
		var obj=data[i];
		var firstMenu={}
		convertJson(firstMenu,obj);
		aryJson.push(firstMenu);
	}
	return aryJson;
}

function convertJson(parent,obj){
	parent.id=obj.menuId;
	parent.iconCls=obj.iconCls;
	parent.url=obj.url;
	parent.text=obj.name;
	parent.key=obj.key;
	parent.showType=obj.showType;
	var child=obj.children;
	if(child && child.length>0){
		parent.children=parent.children ||[];
		for(var i=0;i<child.length;i++){
			var menu={};
			convertJson(menu,child[i]);
			parent.children.push(menu);	
		}
	}
}


