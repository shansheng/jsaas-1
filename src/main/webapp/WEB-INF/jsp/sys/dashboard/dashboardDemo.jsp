<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
			margin-top: 9px;
			font-style:normal;
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
		.topNav>li{
			width: auto;
			padding-left: 10px;
			padding-right: 10px;
		}
	</style>
</head>
<body style="min-height: 660px; cursor: auto;" class="edit">
<ul class="topNav topNav_left" style="margin:0;">
	<li id="sourcepreview">
		<span>预览</span>
	</li>
	<li onclick="saveHtml1(true)">
		<span>保存</span>
	</li>
	<li href="#clear" id="clear" style="background:red;">
		<span>清空</span>
	</li>
	<li onclick="addPortal()" class="active" style="padding-left:10px;padding-right:10px;">
		<span>添加报表</span>
	</li>
	<li onclick="addFilter()" class="active" style="padding-left:10px;padding-right:10px;">
		<span>添加过滤条件</span>
	</li>
</ul>
<div class="container-fluid">
	<div class="changeDimension">
		<div class="row-fluid">
			<div style="float:left;width:0px;height:100px;"></div>
			<div class="right_demo">

				<div class="gridster" style="min-height: 304px;">
					<ul></ul>
				</div>
			</div>
			<div id="download-layout">
				<div class="gridster"></div>
			</div>
		</div>
	</div>
</div>
<div id="editHtml" style="display: none;">${dashboardJson.editHtml}</div>
<form id="queryFilterFrm">
<textarea id="queryFilterInp" name="queryFilter" style="display:none;">${dashboardJson.queryFilterJsonStr}</textarea>
</form>
<div class="personalPort"></div>
<script>
	var gridster1 = null;
	var dataJson;
	$(function(){
		initDataJson();
		gridster1 = $(".gridster ul").gridster({
				widget_base_dimensions: ['auto', 140],
				autogenerate_stylesheet: true,
				min_cols: 1,
				max_cols: 6,
				avoid_overlapped_widgets:true,
				widget_margins: [10, 10],
				resize: {enabled: true}
			}).data('gridster');
		$('.gridster  ul').css({'padding': '0'});
		var arr = [];
		$("#editHtml").find("div[colid]").each(function(){
			arr.push(this);
		});
		//调整顺序
		for(var i=0;i<arr.length;i++){
			for(var j=0,t=0;j<arr.length-1;j++){
				var a = $(arr[j]).attr("data-row");
				var b = $(arr[j+1]).attr("data-row");
				if(parseInt(a)>parseInt(b)){
					t = arr[j];
					arr[j]=arr[j+1];
					arr[j+1] =t;
				}
			}
		}
		$.each(arr, function(){
			var colId = $(this).attr("colid");
			var _title = $(this).find("h1").text();
			var dset = this.dataset;
			var tools = "<dl class='modularBox'>"+
					"<dt>"+
					"<h1>"+ _title +"</h1>"+
					"<div class='icon'>"+
					(colId == "queryFilter" ? "<input type='button' id='More' onclick=\"openNewUrl(\'"+"\','栏目编辑')\"/>" : "") + 
					"<em class='closeThis'>×</em>"+
					"</div>"+
					"<div class='clearfix'></div>"+
					"</dt>";
			var html = "<div id=\""+this.id+"\" colId=\""+colId+"\">"+tools+"</div>";
			gridster1.add_widget(html, dset.sizex, dset.sizey, dset.col, dset.row);
			
		});
		$(".closeThis").click(function(){
			gridster1.remove_widget($(this).parents(".gs-w"));
		});
	});
	
	//useful
	//初始化回传参数
	function initDataJson(){
		var params = {
			id : '${dashboardJson.id}',
			name : '${dashboardJson.name}',
			key : '${dashboardJson.key}',
			treeId : '${dashboardJson.treeId}'
		};
		dataJson = params;
	}
	
	/* useful
     *默认栏目添加
     */
	function addPortal(){
		_OpenWindow({
			url: '${ctxPath}/sys/echarts/echartsCustom/select.do?multiSelect=1',
			height:600,
			width:800,
			title:'图表选择',
			ondestroy:function(action){
				if(action!='ok')return;
				var iframe = this.getIFrameEl();
				var datArr = iframe.contentWindow.getCustomChartsInfo();
				saveColumnDeGrids(datArr);
			}
		});
	}
	
	function addFilter(){
		_OpenWindow({
			url: '${ctxPath}/sys/dashboard/dashboard/filter.do?'+$("#queryFilterFrm").serialize(),
			max: true,
			title: '自定义过滤设置',
			ondestroy: function(action){
				if(action != 'ok')
					return;
				var iframe = this.getIFrameEl();
				var pluginJsonStr = iframe.contentWindow.pluginJsonStr;
				if($("#queryFilter").html() == undefined){
					var tools = "<dl class='modularBox'>"+
							"<dt>"+
							"<h1>过滤条件</h1>"+
							"<div class='icon'>"+
							"<input type='button' id='More' onclick=\"openNewUrl(\'"+"\','栏目编辑')\"/>"+
							"<em class='closeThis'>×</em>"+
							"</div>"+
							"<div class='clearfix'></div>"+
							"</dt>";
					var html = "<div id=\"queryFilter\" colId=\"queryFilter\">"+tools+"</div>";
					gridster1.add_widget(html, 1, 1, gridster1.cols, gridster1.rows);
					$(".closeThis").click(function(){
						gridster1.remove_widget($(this).parents(".gs-w"));
					});
				}
				$("#queryFilterInp").text(pluginJsonStr);
			}
		});
	}

	//useful
	function saveColumnDeGrids(columnDeGrids){
		for(var i = 0; i < columnDeGrids.length; i++){
			var colId = columnDeGrids[i].id;
			var tools = "<dl class='modularBox'>"+
					"<dt>"+
					"<h1>"+ columnDeGrids[i].name +"</h1>"+
					"<div class='icon'>"+
					"<em class='closeThis'>×</em>"+
					"</div>"+
					"<div class='clearfix'></div>"+
					"</dt>";
			var html = "<div id=\""+columnDeGrids[i].key+"\" colId=\""+colId+"\">"+tools+"</div>";
			gridster1.add_widget(html, 1, 2, gridster1.cols, gridster1.rows);
			$(".closeThis").click(function(){
				gridster1.remove_widget($(this).parents(".gs-w"));
			});
		}
	}

	//useful
	function saveHtml1(flag) {
		var url = "${ctxPath}/sys/dashboard/saveHtml.do";
		var formatSrc = getHtml();
		var editdHtml = $(".gridster").html();
		var formObj=$(formatSrc);
		formObj.find("div[class^=colId]").html("");
		var gs_w = formObj.find(".gs-w");
		formObj.find("ul").html("");
		gs_w.each(function(){
			var id = $(this).attr("id");
			var colId = $(this).attr("colId");
			var className = $(this).attr("class");
			var data_col = $(this).attr("data-col");
			var data_row = $(this).attr("data-row");
			var data_sizex = $(this).attr("data-sizex");
			var data_sizey = $(this).attr("data-sizey");
			var li = "<li class="+className+" data-col="+data_col+" data-row="+data_row+" data-sizex="+data_sizex+" data-sizey="+data_sizey+">"+
					"<div id="+id+" class=\"colId_"+colId+"\"></div></li>";
			formObj.find("ul").append(li);
		})
		var params = {
			id : '${dashboardJson.id}',
			name : '${dashboardJson.name}',
			key : '${dashboardJson.key}',
			treeId : '${dashboardJson.treeId}',
			layoutHtml : formObj[0].outerHTML,
			editHtml : editdHtml,
			queryFilterJsonStr: $("#queryFilterInp").text()
		};
		var _json = {
			json : JSON.stringify(params)
		}
		dataJson = params;
		$.post(url, _json, function(data) {
			if(flag){
				CloseWindow('ok');
			}
		});
	}
	
	//回调传值 useful
	function getDataJson(){
		return dataJson;
	}

	/** useful
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

	//useful
	$(document).ready(function() {
		/*清空按钮*/
		$("#clear").click(function(e) {
			e.preventDefault();
			clearHtml();
		});
		/*预览按钮*/
		$("#sourcepreview").click(function() {
			saveHtml1(false);
			openNewUrl("${ctxPath}/sys/dashboard/dashboard/readDemo.do?key=${dashboardJson.key}", "大屏预览");
			return false;
		});
	})
</script>
</body>
</html>
