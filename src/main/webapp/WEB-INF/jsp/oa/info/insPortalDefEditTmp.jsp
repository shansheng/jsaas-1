﻿<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Bootstrap Layout</title>
	<%@include file="/commons/dynamic.jspf"%>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/layoutit/css/combined.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/styles/icons.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/layoutit/css/layoutitIndex.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath }/scripts/layoutit/css/layoutit.css">
	<script type="text/javascript" src="${ctxPath }/scripts/boot.js" ></script>
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery-ui.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery.htmlClean.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/common/baiduTemplate.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/scripts.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/share.js"></script>

	<link rel="stylesheet" type="text/css" href="${ctxPath }/scripts/layoutit/css/jquery.gridster.min.css">
	<script type="text/javascript" src="${ctxPath }/scripts/layoutit/js/jquery.gridster.min.js"></script>
	<script type="text/javascript" src="${ctxPath }/scripts/echart/echarts.js"></script>
	<style type="text/css">
		.gs-w{
			background-color: #fff;
			overflow: hidden;
		}
		.gs-w:hover{
			cursor: move;
		}
		em.closeThis{
			font-style:normal;
			/* 	position: absolute; */
			display:inline-block;
			margin-left:6px;
			right:0px;
			top:0px;
			width:18px;
			height:18px;
			text-align:center;
			line-height:17px;
			background:#c3e9f2;
			border-radius:50%;
			color:#2aa6c4;
			font-size:18px;
			vertical-align:4px;
		}
		em.closeThis:hover{
			cursor: pointer;
			background:#b4e4ef;
		}
		.personalPort{
			margin-top: 50px;
		}


		.right_demo{
			overflow:hidden;
		}
		.topNav_left{
			left:0px !important;
		}
        .gridster .gs-w{
            background: #fff;
        }

	</style>
</head>
<body style="min-height: 660px; cursor: auto;" class="edit">
<ul class="topNav topNav_left">
	<li id="sourcepreview">
		<span>预览</span>
	</li>
	<li onclick="saveHtml1(true)">
		<span>保存</span>
	</li>
	<li href="#clear" id="clear">
		<span>清空</span>
	</li>
	<li onclick="addPortal()"  class="active">
		<span>栏目添加</span>
	</li>
</ul>
<div class="container-fluid">
	<div class="changeDimension">
		<div class="row-fluid">
			<div style="float:left;width:0px;height:100px;"></div>
			<div class="right_demo">

				<div class="gridster" style="min-height: 304px;">
					<ul>

                    </ul>
				</div>
			</div>
			<div id="download-layout">
				<div class="gridster"></div>
			</div>
		</div>
	</div>
</div>
<div id="editHtml" style="display: none;">${insPortalDef.editHtml}</div>
<div class="personalPort"></div>
<script>
	//设置左分隔符为 <!
	baidu.template.LEFT_DELIMITER='<#';
	//设置右分隔符为 <!
	baidu.template.RIGHT_DELIMITER='#>';
	var bt=baidu.template;
	$(function(){
		$.ajax({
			url:__rootPath + "/oa/info/insColumnDef/getAllCol.do",
			method:"POST",
			success:function(data){
				buildCols(data);
			}
		});
		$("#Refresh").click(function(){
			var colId = $("#myTask").attr("colId");
			$.ajax({
				url:__rootPath+"/oa/info/insColumnDef/getColHtml.do?colId="+colId,
				method:"POST",
				success:function(data){
					$("#myTask")[0].outerHTML = data;
				}
			});
		});
	});

	/*
     *默认栏目添加
     */
	function addPortal(){
		_OpenWindow({
			url:__rootPath+'/oa/info/insColumnDef/dialog1.do',
			height:600,
			width:600,
			iconCls:'icon-user-dialog',
			title:'栏目选择',
			ondestroy:function(action){
				if(action!='ok')return;
				var iframe = this.getIFrameEl();
				var columnDeGrids = iframe.contentWindow.getColumnDeGrids();
				if(!columnDeGrids || columnDeGrids.length==0)return;
				saveColumnDeGrids(columnDeGrids);
			}
		});
	}

	function saveColumnDeGrids(columnDeGrids){
		for(var i=0;i<columnDeGrids.length;i++){
			var colId = columnDeGrids[i].colId;
			$.ajax({
				url:__rootPath+"/oa/info/insColumnDef/getJson.do?ids="+colId,
				method:"POST",
				async: false,
				success:function(data){
					var json = mini.decode(data);
					var url = __rootPath+"/oa/info/insColumnDef/edit.do?pkId="+colId;
					var tools = "<dl class='modularBox'>"+
							"<dt>"+
							"<h1>"+ json.name +"</h1>"+
							"<div class='icon'>"+
							"<input type='button' id='More' onclick=\"openNewUrl(\'"+url+"\','栏目编辑')\"/>"+
							"<em class='closeThis'>×</em>"+
							"</div>"+
							"<div class='clearfix'></div>"+
							"</dt>";
					var html = "<li><div id=\""+json.key+"\" colId=\""+colId+"\">"+tools+"</div></li>";
					gridster1.add_widget(html,1,2,gridster1.cols,gridster1.rows);
					$(".closeThis").click(function(){
						gridster1.remove_widget($(this).parents(".gs-w"));
					})
				}
			});
		}
	}


	function buildCols(data){
		var menuData=data;
		var data={"list":menuData};
		var menuHtml=bt('ColsTemplate',data);
		$(".boxes").html(menuHtml);
		$(".inner li").click(function(){
			var colId = $(this).attr("colId");
			$.ajax({
				url:__rootPath+"/oa/info/insColumnDef/getJson.do?ids="+colId,
				method:"POST",
				async: false,
				success:function(data){
					var json = mini.decode(data);
					var url = __rootPath+"/oa/info/insColumnDef/edit.do?pkId="+colId;
					var tools = "<dl class='modularBox'>"+
							"<dt>"+
							"<h1>"+ json.name +"</h1>"+
							"<div class='icon'>"+
							"<input type='button' id='More' onclick=\"openNewUrl(\'"+url+"\','栏目编辑')\"/>"+
							"<em class='closeThis'>×</em>"+
							"</div>"+
							"<div class='clearfix'></div>"+
							"</dt>";
					var html = "<li><div id=\""+json.key+"\" colId=\""+colId+"\">"+tools+"</div></li>";
					gridster1.add_widget(html,1,2,gridster1.cols,gridster1.rows);
					$(".closeThis").click(function(){
						gridster1.remove_widget($(this).parents(".gs-w"));
					})
				}
			});
		})
		var ary = [];
		$("#editHtml").find("div[colid]").each(function(){
			ary.push(this);
		});

		for(var i=0;i<ary.length;i++){
			for(var j=0,t=0;j<ary.length-1;j++){
				var a = $(ary[j]).parent().attr("data-row");
				var b = $(ary[j+1]).parent().attr("data-row");
				if(parseInt(a)>parseInt(b)){
					t = ary[j];
					ary[j]=ary[j+1];
					ary[j+1] =t;
				}
			}
		}
		console.log(ary);
		$.each(ary,function(i,n){
			var col = $(n).parent().attr("data-col");
			var row = $(n).parent().attr("data-row");
			var sizex = $(n).parent().attr("data-sizex");
			var sizey = $(n).parent().attr("data-sizey");

			var colId = $(n).attr("colid");
			$.ajax({
				url:__rootPath+"/oa/info/insColumnDef/getJson.do?ids="+colId,
				method:"POST",
				async: false,
				success:function(data){
					var json = mini.decode(data);
					var url = __rootPath+"/oa/info/insColumnDef/edit.do?pkId="+colId;
					var tools = "<dl class='modularBox'>"+
							"<dt>"+
							"<h1>"+ json.name +"</h1>"+
							"<div class='icon'>"+
							"<input type='button' id='More' onclick=\"openNewUrl(\'"+url+"\','栏目编辑')\"/>"+
							"<em class='closeThis'>×</em>"+
							"</div>"+
							"<div class='clearfix'></div>"+
							"</dt>";
					var html = "<li><div id=\""+json.key+"\" colId=\""+colId+"\">"+tools+"</div></li>";
					var obj = gridster1.add_widget(html,sizex,sizey,col,row);
					
					var type = json.type;
					var temp = $("<span></span>");
					temp.css({"background-repeat":"no-repeat",
						"background-position":"center",
						"background-image":"url(\"../../../styles/images/portal/user.png\")",
						"display":"inline-block",
						"width":"100%",
						"height":"45%",
						"position":"absolute",
						"top":"40%",
						"background-size":"auto 100%"
					});
					var url;
					if(type=="newsNotice"){//新闻公告栏目
						url = "../../../styles/images/portal/addColumn-news.png";
					}else if(type=="chart"){//图形报表栏目
						url = "../../../styles/images/portal/addColumn-pie.png";
					}else if(type=="tabcolumn"){//多tab栏目
						url = "../../../styles/images/portal/addColumn-tab.png";
					}else if(type=="list"){//列表栏目
						url = "../../../styles/images/portal/addColumn-list.png";
					}else if(type=="msgbox"){//消息盒子栏目
						url = "../../../styles/images/portal/addColumn-message.png";
					}else{//面板栏目
						url = "../../../styles/images/portal/addColumn-panel.png";
					}
					
					temp.css("background-image","url("+url+")");
					obj.append(temp);
					$(".closeThis").click(function(){
						gridster1.remove_widget($(this).parents(".gs-w"));
					})
				}
			});
		})
	}

	function saveHtml1(flag) {
		var portId = "${portId}";
		var url = __rootPath + "/oa/info/insPortalDef/saveHtml.do?portId="	+ portId;
		var formatSrc = getHtml();
		var editdHtml = $(".gridster").html();
		var formObj=$(formatSrc);
		formObj.find("div[class^=colId]").html("");
		var gs_w = formObj.find(".gs-w");
		formObj.find("ul").html("");
		gs_w.each(function(){
			var id = $(this).children().attr("id");
			var colId = $(this).children().attr("colId");
			var className = $(this).attr("class");
			var data_col = $(this).attr("data-col");
			var data_row = $(this).attr("data-row");
			var data_sizex = $(this).attr("data-sizex");
			var data_sizey = $(this).attr("data-sizey");
			var li = "<li class="+className+" data-col="+data_col+" data-row="+data_row+" data-sizex="+data_sizex+" data-sizey="+data_sizey+">"+
					"<div id="+id+" class=\"colId_"+colId+"\"></div>"
					+"</li>";
			formObj.find("ul").append(li);
		})
		var params = {
			formatSrc : formObj[0].outerHTML,
			editHtml : editdHtml
		};
		$.post(url, params, function(data) {
			if(flag){
				CloseWindow('ok');
			}
		})

	}

	/**
	 * 打开处理窗口。
	 * @param url
	 * @param title
	 * @param solId
	 * @returns
	 */
	function openNewUrl(url,title){
		_OpenWindow({
			title : title,
			height : 400,
			width : 780,
			max : true,
			url :url
		});
	}

	$(document).ready(function() {
		/*编辑按钮*/
		$("#edit").click(function() {
			$("body").removeClass("devpreview sourcepreview");
			$(".left_nav").css("display","block");
			$(".topNav").css("marginLeft","6px");
			$("body").addClass("edit");
			removeMenuClasses();
			$("#sourcepreview").removeClass("active");
			$(this).addClass("active");
			$(".gridster").show();
			$(".personalPort").hide();
			return false
		});
		/*清空按钮*/
		$("#clear").click(function(e) {
			e.preventDefault();
			clearHtml();
		});
		/*预览按钮*/
		$("#sourcepreview").click(function() {
			saveHtml1(false);
			openNewUrl(__rootPath+"/oa/info/insPortalDef/readTmp.do?key=${insPortalDef.key}","门户预览");
			return false
		});
	})
</script>
<script type="text/javascript">
	var gridster1 = null;
	$(document).ready(function () {

		gridster1 = $(".gridster ul").gridster({
			widget_base_dimensions: ['auto', 120],
			autogenerate_stylesheet: true,
			min_cols: 1,
			max_cols: 6,
			avoid_overlapped_widgets:true,
			widget_margins: [10, 10],
			resize: {
				enabled: true
			}
		}).data('gridster');
		$('.gridster  ul').css({'padding': '0'});
	});
</script>
<script id="ColsTemplate"  type="text/html">
	<ul class="inner">
		<#for(var i=0;i<list.length;i++){
		var col=list[i];
		#>
		<li colId="<#=col.colId#>" class="box box-element ui-draggable">
			<div class="preview"><#=col.name#></div>
			<span class="drag label">添加</span>
			<div class="view">
				<div colId="<#=col.colId#>"></div>
			</div>
		</li>
		<#}#>
	</ul>
	<div class="scrollbar">
		<div class="scrollbtn"></div>
	</div>
</script>
</body>
</html>
