$(function(){
	editLeft();
	$(window).resize(function(){
		var W_height = $(window).height()
		$("#body").height(W_height);
		mobileBoxHeight();
	})
	
	mobileBoxHeight();
	function mobileBoxHeight(){
		var mobileBoxHeight = $("#mobileBox").height();
		var widths = parseInt(mobileBoxHeight)*0.5;
		$("#mobileBox>span").width(widths);
	}
	
	headerSweitch();
	function headerSweitch(){
		$(".bodyContainer").find(".contentBox").css("zIndex","9");
		$(".bodyContainer").find(".contentBox").eq(0).css("zIndex","10");
		$("#headers ul li").click(function(){
			var thisIndex = $(this).index();
			$(this).addClass("active").siblings().removeClass("active");
			$("#editUl>li.contentBox").eq(thisIndex).css("zIndex","10").siblings().css("zIndex","9");
		})	
	}
	

	var Time = new Date();
	Time.getTime();
	$(".mobileTime").text(Time.getHours()+":"+Time.getMinutes());
	function editLeft(){
		var W_height = $(window).height()
		$("#body").height(W_height);
		
		var _li = $("#tree").find('li');
		for (var i = 0; i<_li.length;i++) {
			var ks =  _li.eq(i).children()
			if (ks.length > 1) {
				_li.eq(i).children("p").find("i").show();
			}
		}
		$("#tree").on("click","p",function(){
			var _p = $(this);
			$("#tree").find("p").removeClass("active");
			_p.addClass("active");
		 	toggles(_p)
		})
		function toggles(pl){
			var pl = pl;
			var iconClass = pl.find("i").attr("class");
			var display_ul = pl.siblings("ul").css("display") || pl.siblings("ul").attr("display");
			console.log(display_ul);
			
			if (display_ul == "none") {
				commonsFn();	
				pl.find("i").attr({"class":"iconfont icon-unfold"});
				pl.siblings("ul").stop().slideDown(500);
				pl.siblings("ul").find("li ul").stop().slideUp(500);
				pl.parent().siblings().find("ul").stop().slideUp(500);
			} 
			if (display_ul == "block") {
				commonsFn();
				pl.removeClass("active");
				pl.find("i").attr({"class":"iconfont icon-packup"});
				pl.siblings("ul").stop().slideUp(500);
				pl.siblings("ul").find("li ul").stop().slideUp(500);
			}
				
		}
		function commonsFn(){
			$(".two_ul").siblings("p").find("i").attr({"class":"iconfont icon-packup"});
			$(".three_ul").siblings("p").find("i").attr({"class":"iconfont icon-packup"});
		}
	}

	
})