
var _widths = "";
var rollNum = 0;
var picLength = 0;
var heights =0;
var type ="";

var rollFont ="";
var heardDt ="";
var heardDtHeigth =0;

function loadHideImge(){
    var img = new Image();
    img.src = __rootPath + "/styles/images/andor.png";
    img.onload = function () {
        var hideInput =$('#hideInput');
        type =hideInput.val();
        heights =hideInput.parent().parent().parent().height();
        heardDt= $('#heardDt');
        heardDtHeigth =heardDt.height();
        var imgList = $(".rollBoxs_szw li");
        if(imgList && imgList.length>0){
            setParentHeight();
            /*克隆第一张图放到最后面*/
            var clonePic = imgList.first();
            var liObj = clonePic[0];
            var imgObj =liObj.children;
            var firstImg=imgObj [0];
            loadFirstimg(firstImg);
        }else{
            heardDt = $('#heardDt');
            setrollFontWidth(heardDt.width());
        }
    }
}
function onTabsActiveChanged(e){
    mini.layout();
    loadHideImge();
}
function setWidthToWest(){
    var rollBanner;
    var rollBanner =$("#rollBanner");
    _widths = rollBanner.width();
    if("imgAndFont"==type){
        _widths =(heardDt.width()/2)-20;
        rollBanner.width(_widths);
        setrollFontWidth(_widths);
        var rollFont =$("#rollFont");
       /* rollBanner.css("margin-right","10px");*/
    }
    setWidth();
}

function setrollFontWidth(width){
    rollFont =$("#rollFont");
    rollFont.width(width);
}

function setWidth() {
    $(".rollBoxs_szw li").width(_widths);
    rollPic();
}

function setParentHeight() {
    /*var rollBanner =$("#rollBanner");
    var parent1 =rollBanner.parent();
    var parent2 =parent1.parent();
    parent1.height(heights);
    parent2.height(heights);*/
   /* rollBanner.height(heights-heardDtHeigth-8);*/
}

loadHideImge();

function loadFirstimg(firstImg){
    var img = new Image();
    img.src = firstImg.src;
    img.title = firstImg.title;
    img.onload = function () {
        addImg(img);
        setWidthToWest();
    }
}

function addImg(img) {
    var liHtim = $('<li></li>');
    liHtim.append(img);
    $(".rollBoxs_szw").append(liHtim);
}

//屏幕大小改变时触发
$(window).resize(function () {
    sizeWidth();
});
function sizeWidth() {
   $(".rollBoxs_szw").css({left: 0});
    var tim = setTimeout(function () {
        _widths = $("#rollBanner").width();
        $(".rollBoxs_szw li").width(_widths);
    },500)

}
function rollPic() {
    //默认第一个显示第一张的文字说明；
    $("#rollText").text($(".rollBoxs_szw li").eq(0).find("img").attr("title"));
    /!*动态添加小圆点*!/
    picLength = $(".rollBoxs_szw li").length;

    for (var i = 1; i < picLength; i++) {
        $(".circlBox").append("<li></li>");
    }
    $(".circlBox li").eq(0).addClass("circlColor");

    rollTime();
    //左边按钮
    $(".leftBtn").click(function () {
        rollNum--;
        roll();
    })
    //右边按钮
    $(".rightBtn").click(function () {
        rollNum++;
        roll();
    });
    $("#rollBanner").hover(function () {
        rollTimes && clearInterval(rollTimes);
    }, function () {
        rollTime();
    });

    $("body").on("click", ".circlBox>li", function () {
        var li_index = $(this).index();
        $(this).addClass("circlColor").siblings().removeClass("circlColor");

        _widths = $("#rollBanner").width();
        $(".rollBoxs_szw").stop().animate({"left": -(_widths) * li_index}, 1200)
        $("#rollText").text($(".rollBoxs_szw li").eq(li_index).find("img").attr("title"));
        return rollNum = li_index;
    })
}

function rollTime() {
    rollTimes = setInterval(function () {
        rollNum++;
        roll();
    }, 3000);
}

function roll() {
   //return;
    var rollText = $(".rollBoxs_szw li").eq(rollNum).find("img").attr("title");
    if (rollNum == picLength) {
        $(".rollBoxs_szw").css({left: 0});
        $("#rollText").text($(".rollBoxs_szw li").eq(1).find("img").attr("title"));
        rollNum = 1;
    }
    _widths = $("#rollBanner").width();
    if (rollNum < 0) {
        $(".rollBoxs_szw").css({left: -(picLength - 1) * (_widths)});
        rollNum = picLength - 2;
    }
    $(".rollBoxs_szw").stop(true).animate({left: -rollNum * (_widths)}, 1000);
    //改变文字说明
    $("#rollText").text(rollText);
    if (rollNum == picLength - 1) {
        $(".circlBox li").eq(0).addClass("circlColor").siblings().removeClass("circlColor");
    } else {
        $(".circlBox li").eq(rollNum).addClass("circlColor").siblings().removeClass("circlColor");
    }
}


function refreshRoll(colId) {
    $.ajax({
        url : __rootPath + "/oa/info/insColumnDef/getColHtml.do?colId="+ colId,
        method : "POST",
        success : function(data) {
            $("div[colid=" + colId + "]")[0].outerHTML = data;
            clearInterval(rollTimes);
            rollNum=0;
            loadHideImge();
        }
    });
}