//document.write("<script language=javascript src='"+__rootPath+"/scripts/echart/echarts.min.js'></script>");

 /*************************************************/
function clearHtml() {
	$('.gridster>ul>li').each(function(){
		gridster1.remove_widget(this);
	});
	
}

var currentDocument = null;
var timerSave = 1000;
var stopsave = 0;
var startdrag = 0;
var demoHtml = $(".gridster").html();
var currenteditor = null;

$(document).ready(function() {
	$(".frame").addClass("activeNav").next().slideDown(300);
})

function getHtml() {
	var e = "";
	//$(".demo .gs-w .gs-resize-handle").remove();
	var demoHtml = $(".gridster").html();
	$("#download-layout").children().html(demoHtml);
	formatSrc = $.htmlClean($("#download-layout").html(), {
		format: true,
		allowedAttributes: [
			["id"],
			["class"],
			["data-col"],
			["data-row"],
			["data-sizex"],
			["data-sizey"],
			["colid"]
		]
	});
	return formatSrc;
}

/**
 * 关闭窗口
 * @returns {unresolved}
 */
function CloseWindow(action,preFun,afterFun) {
	if(preFun){
		preFun.call(this);
	}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
    if(afterFun){
		afterFun.call(this);
	}
}



