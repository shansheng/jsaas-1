$(function () {

    var winWidth = $(window).width();
    var winHeight = $(window).height();
    $('.side').height(winHeight - 130);

    $('.iframe').height(winHeight - 185);
    $('.content').height(winHeight - 130);
    $('.split').height(winHeight - 130);
    $('.content').width(winWidth - 241);

    mini.layout();
    //首页窗口变化 延时自适应大小；  ------yangxin;
    $(window).resize(function () {
        windowResizes()
    });

    function windowResizes() {
        var times = setInterval(function () {
            mini.layout();
        }, 100)
        setTimeout(function () {
            window.clearInterval(times);
        }, 1000);
    }

    attachMenuEvents();
    $('.close').click(function () {
        $(this).parent('div').remove();
    });

    /*左右伸缩*/
    $(document).on("click", ".mini-tools-collapse", function () {
        windowResizes();
    });
   /* $(document).on("click",".mini-layout-spliticon",function(){
        windowResizes();
        mini.layout();
    });*/
   /* 点击首页顶部的折叠按钮 来触发 树的折叠事件 ---yangxin*/
   $("#toggleBtn").click(function () {
        $(this).toggleClass("btn_select");
        $("#west.nav  .mini-tools-collapse").trigger('click');
        mini.layout();
    });
   
   /*首页头部导航*/
    $("#headerNav").on("click","li",function () {
        $(this).siblings("li#navMore").find("li").removeClass("act");
        $(this).addClass("act").siblings().removeClass("act");
        showTab($(this));
        var id = $(this).attr("id");
        if(id=="navMore")return;
        var menuId = $(this).attr("menuId");
        initMenu(menuId);
    })
    /*logo字体设置*/
    var logoTitle =  $("#logoTitle").text();
    var T_length = logoTitle.length;
    if (T_length < 7 ){
        $("#logoTitle").css("fontSize","24px");
    }else {
        $("#logoTitle").css("fontSize","20px");
    }
    console.log(T_length );

})

$(function () {
    if (self != top) top.location = self.location;
    top['index'] = window;
    var count = '${newMsgCount}', winW, logoW, userW;
    winW = $(document).innerWidth();
    userW = $('#fr').innerWidth();
    window.onload = function () {
        logoW = $('.logo').innerWidth();
        $('#tabsbox').width(winW - logoW - userW - 1);
    }
})

//消息的显示
$(function () {
    initMenu();

});

function initMenu(menuId) {
	if(!menuId)menuId="";
    var url = __rootPath + "/getMenusByMenuId.do?menuId="+menuId;
    $.get(url, function (data) {
        //构建左侧导航
        buildLeftMemu(data);
        //检测是否需要显示tab滑动按钮
        var tabsbox_W = $('.tabsbox').innerWidth(),
            tabwrap_W = $('.movewrap').innerWidth();
        if (tabsbox_W < tabwrap_W) {
            $('#tabsbox .fr').css('display', 'block');
        } else {
            $('#tabsbox .fr').css('display', 'none');
        }

    });
}

var menuData;

function buildLeftMemu(data) {
    menuData = data;
    //若子系统下有子菜单，则展示左边
    if (menuData) {
        try {
            mainLayout = mini.get('mainLayout');
            if (mainLayout) {
                mainLayout.updateRegion('west', {visible: true});
            }
        } catch (e) {
        }

        var data = {"list": menuData};
        var menuHtml = bt('leftMenuTemplate', data);
        $("#sidemenu").html(menuHtml).hide().slideToggle(300);
        attachMenuEvents();
    }
}






