$(function(){
	//定义一个全局变量接收点击 中间模块的 下标
	var hiddenIndex = "0";
	//定义一个全局变量接收 应用模板 里面应用的个数
	var modNumber ='0';
	
	//设置bodys高度；
	bodyResize();
	$(window).resize(function(){
		bodyResize();
	})
	function bodyResize(){
		var bodyHeight = $(window).height();
		$(".bodys").height(bodyHeight);
		//设置右边编辑栏的 #addApplyBox最大高度
		$("#addApplyBox").css("maxHeight",bodyHeight-300);
	}
	
	//hover 中间模板出现   排序框
	$("#centerUl").on("mouseover","li.centerLi",function(){
		$(this).find(".editBox").stop().fadeIn(200);
	});
	$("#centerUl").on("mouseout","li.centerLi",function(){
		$(this).find(".editBox").stop().fadeOut(200);
	});
	//点击排序框 事件
		//上移
	$("#centerUl").on("click",".editBox li.up",function(){
		
	});	
		//下移
	$("#centerUl").on("click",".editBox li.dow",function(){
		
	});	
		//删除
	$("body").on("click","li.del",function(){
		alert("ss")
		$(this).parents("li.centerLi").remove();
		
	});
	
	//点击左边添加模板
	/*$(".left_content ul li").on("click",function(){
		//var thisID = $(this).attr("id");
		var thisType = $(this).attr("type");
		if(thisType == "pic"){
			banners();
		}else if(thisType == "btn"){
			apps();
		}
	});*/
	
	//轮播图模板
		//点击上传图片	
	$(".rollBox").on("change",".fileInput",function(){
		var filePath = $(this).val();//读取图片路径
		var imgObj = this.files[0];//获取图片
		
		var fr = new FileReader();//创建new FileReader()对象
		fr.readAsDataURL(imgObj);//将图片读取为DataURL
		var obj = $(this).parents("li").find(".fileContentBox").find("img");//要显示图片的盒子里的img
		/*console.log(obj);*/
		if(filePath.indexOf("jpg") != -1 || filePath.indexOf("JPG") != -1 || filePath.indexOf("PNG") != -1 || filePath.indexOf("png")!= -1) {
			$(this).parents("li").find(".fileContentBox").show();//显示盒子
			var arr = filePath.split('\\');
			var fileName = arr[arr.length - 1];
		
			fr.onload = function(e) {
				var imgs = this.result;
				obj.attr({"src":imgs});
			};
		}else {
			alert("请选择正确的图片文件");
		}
		var imgSrc = obj.attr("src");
	
    });
	//点击新增banner图；
	$("#addRoll").click(function(){
		var RollHtml = $("#right_mod_banner").html()	
		$(this).parents(".rollBox").find("#rightHeaderBox").append(RollHtml);
	
		var rollUl = $(this).parents(".rollBox").find("#rightHeaderBox").find("ul");
		rollUl.each(function(index){
		
			rollUl.eq(index).find("p.upPic").text("上传图片 第"+(index+1)+"张");  
		});
	});
	//点击新增应用
	
	function mod_app(mod){
		var mods = mod;
		
		var addApplyBox = $("#applyBox").find("#addApplyBox")
		var applyLiBox = $("#applyBox").find("#addApplyBox").find("li.applyLiBox");
		var appRghtMods =$("#right_mod_app").html();
		applyLiBox.remove();
		for (var i = 0;i<= mods;i++) {
			addApplyBox.append(appRghtMods);	
		}
	/*	var applyLiBox_2 = $("#applyBox").find("#addApplyBox").find("li.applyLiBox");
		applyLiBox_2.eq(i).find("p.headline").find("span.head lineBox").text("标题"+(i+1));*/
	};
	$("#addApply").click(function(){
		var _this = $(this);
		//编辑模板组件添加
		var ApplyHtml = $("#right_mod_app").html();				
		$("#addApplyBox").append(ApplyHtml);
		addSort(_this);
		//手机模板组件添加
		rowModule();		
			
	})
	function addSort(_this){
		var oThis = _this;
		var applyLiBox = oThis.parents(".applyBox").find("#addApplyBox").find("li.applyLiBox");
		applyLiBox.each(function(index){
			applyLiBox.eq(index).find("p.headline").find("span.headlineBox").text("标题"+(index+1)); 
		})
			
		
	}
	
	//点击中间模块
	
	$("#centerUl").on("click","li.centerLi",function(event){
	$(this).siblings().css({"borderColor":"#fff"});
		$(this).css({"borderColor":"#ccc"});
		var index_s = $(this).index();
		hiddenIndex = index_s;
	
		var liClassName = $(this).attr("class");
		if (liClassName.indexOf("liBannerBox")>-1) {
			$(".rollBox").stop().show();
			$(".applyBox").stop().hide();
		} else if(liClassName.indexOf("liModuleBox")>-1){
			$(".rollBox").stop().hide();
			$(".applyBox").stop().show();
			var modLis = $(this).find(".moduleLi").length;
			modNumber = modLis-1;
			mod_app(modNumber);
		}else if(liClassName.indexOf("liListBox")>-1){
			
		}
		

		event.stopPropagation()
	});
	
	
	/*应用模块添加 -方法*/
	function rowModule(){
		var moduleLis = $("<li class='moduleLi'>"
									+"<span></span>"
									+"<p>应用名字</p>"
							+"</li>");	
		var mod_li_app = $("#centerUl").find(".centerLi").eq(hiddenIndex)					
		mod_li_app.find("ul.moduleUl").append(moduleLis);	
	}
	/*应用模块删除-方法*/
	$("#addApplyBox").on("click","span.dele",function(){
		var ThisIndex = $(this).parents(".applyLiBox").index();
		$(this).parents(".applyLiBox").remove();	
		removeModule(ThisIndex);
	});
	/*删除对应的右边添加的项*/
	function removeModule(obj){
		var oThis = obj;
		$(".liModuleBox .moduleUl li.moduleLi").eq(oThis).remove();
		/*重新给标题排数字*/
		addSort();
	};
	 /*弹出选择图标模板*/
	
	 
	/*弹出选择颜色模板*/
	$("#addApplyBox").on("click","p span.iconColorBtn",function(){
		var modColor = $(this).parents("li.applyLiBox").find(".modColor");
		modColor.toggle();
		
	});
		//	点击选择颜色
	$("#addApplyBox").on("click",".modColor li",function(){
		var thisColor = $(this).text();
		var iconColorBox = $(this).parents(".applyLiBox").find(".iconColorBox");
		iconColorBox.find(".iconColor").css("backgroundColor",thisColor);
		iconColorBox.find("em").text(thisColor);
		$(this).parents(".modColor").hide();
	});
	
	/*点击模板的按钮确定*/
	$("#moduleBtn").click(function(){
		var myThis = $(this);
		moduleName(myThis);
		
	});
		/*每个应用的名字*/
	function moduleName(myThis){
			/*模块标题*/
		var modVal = myThis.parents(".applyBox").find("p.modInput").find("input").val();
		$(".liModuleBox").eq(hiddenIndex).find("p.moduleHeadline").find("input").val(modVal);
		
			//应用标题  颜色 图标
		var li_length =  $("#addApplyBox li.applyLiBox").length;
		var arrheadline = new Array();
        for ( var i = 0; i <= li_length; i++) { 
            arrheadline[i] = new Array(); 
            for ( var j = 0; j < 2; j++) { 
                arrheadline[i][j];
            }
        }
		$("#addApplyBox li.applyLiBox").each(function(index){
			arrheadline[index][0]= $("#addApplyBox li.applyLiBox").eq(index).find("p").find("input").val();
			arrheadline[index][1]= $("#addApplyBox li.applyLiBox").eq(index).find("p").find("em").text();
		});
	
		for (var i = 0 ;i<=arrheadline.length;i++) {
			if (arrheadline[i][0] == '' && arrheadline[i][1] == '') {
				var _li =$("#centerUl").find("li.centerLi").eq(hiddenIndex).find("li.moduleLi").eq(i);
				_li.find("p").text("应用名字");
				_li.find("span").css("backgroundColor","#BADAE9")
			} else if(arrheadline[i][0] == ''){
				var _li =$("#centerUl").find("li.centerLi").eq(hiddenIndex).find("li.moduleLi").eq(i);
				_li.find("p").text("应用名字");
				_li.find("span").css("backgroundColor",arrheadline[i][1])
			}else if(arrheadline[i][1] == ''){
				var _li =$("#centerUl").find("li.centerLi").eq(hiddenIndex).find("li.moduleLi").eq(i);
				_li.find("p").text(arrheadline[i][0]);
				_li.find("span").css("backgroundColor","#BADAE9")
			}else{
				var _li =$("#centerUl").find("li.centerLi").eq(hiddenIndex).find("li.moduleLi").eq(i);
				_li.find("p").text(arrheadline[i][0]);
				_li.find("span").css("backgroundColor",arrheadline[i][1])
			}
			
		}	
	};
		
	//轮播图
	rollBanners();	
	function rollBanners(){
		var liCopy =$("#centerUl").find("ul.picBox").find("li").first().clone();
		$("#centerUl").find("ul.picBox").append(liCopy);
		var picBox_li = $("#centerUl").find("ul.picBox").find("li").size();
		
	/*	for (var i = 0 ; i< picBox_li ;i++) {
			$('.dot').append("<li></li>");
		}*/
		
	/*	$("#centerUl").on("click","ul.dot li",function(){
			var oIndex = $(this).index();
			var siblingIndex = $(this).parents(".bannerBox").find(".picBox");
			siblingIndex.stop().animate({"left":-(oIndex)*372},500);		
		});*/
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
			if (Roll == 5) {
				Roll = 1;
				rollUl.css({"left":0});
			}
			rollUl.stop().animate({"left":-(Roll*372)},1000);
		}
	};
});