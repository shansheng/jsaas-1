//获取当前月的第一天  
var start = new Date();  
start.setDate(1);  

// 获取当前月的最后一天  
var date = new Date();  
var currentMonth = date.getMonth();  
var nextMonth = ++currentMonth;  
var nextMonthFirstDay = new Date(date.getFullYear(), nextMonth, 1);  
var oneDay = 1000 * 60 * 60 * 24;  
var end = new Date(nextMonthFirstDay - oneDay);

//结果数据
var _listRowDatas;
//开始时间
var _startTime = start.format("yyyy-MM-dd");
//结束时间
var _endTime = end.format("yyyy-MM-dd");

$(function(){
	createCalendar();
})

function createCalendar(){
	$.ajax({
		type : "POST",
		url : __rootPath+"/oa/ats/atsAttenceCalculate/myCalendarHandler.do",
		dataType: 'json',
		data : {
			startTime : _startTime,
			endTime : _endTime
		},
		success : function(data) {
		     if (!data.success) {
		    	alert(data.msg);
                return;
             } 
		   _listRowDatas = data.results;
		   initCalendar();
		   initHelp();
		}
	});
}

var index = 0;

var json= {"缺卡":"icon-cancel","正常":"icon-ok","迟到":"icon-cancel","早退":"icon-cancel",
		   "旷工":"icon-cancel","加班":"icon-cancel","请假":"icon-cancel","出差":"icon-cancel"};
var abnormityAry = {"0":"right","-1":"wrong"};
function getColorTitle(_self, event, flag) {
	var self =  $(_self), title = event.title,dateType =event.dateType,abnormity = event.abnormity;
	var ary = title.split("、");
	var s = "";
    for(var i=0;i<ary.length;i++){
    	var content = "";
    	var clz = "";
    	var icon = "";//json[ary[i]];
		content = event.content;
		icon += abnormityAry[abnormity];
    	s += "<span class='iconfont helper "+ icon +"' helpid='formulaHelp"+index+"'>&nbsp;"+ ary[i] +"</span>";
    	$("body").append($("<div style=\"display:none;\" id=\"formulaHelp"+index+"\"></div>").html("<pre>"+ content +"</pre>"));
    	index++;
    }
    return s;
}

function formatDate(d) {
	return new Date(d.replace(/-/g, "/"));
}

function replaceShiftCalendar(event, start, date1) {
	replaceShift({
		start : start,
		callback : function(rtn) {
			for (var j = 0; j < _listRowDatas.length; j++) {
				var events = _listRowDatas[j], date = formatDate(events["start"]);
				if (date.getTime() == date1.getTime()) {
					events.title = rtn.title;
					events.dateType = rtn.dateType;
					events.shiftId = rtn.shiftId;
					events.start = rtn.start;
					events.holidayName = rtn.holidayName;
					initCalendar();
					break;
				}
			}
		}
	});
}

function replaceShift(conf) {
	var params = {
		start : conf.start
	}, url =__rootPath+'/oa/ats/atsShiftInfo/replace.do?start='+conf.start;
	mini.open({
		height : 600,
		width : 800,
		title : '选择日期类型和班次',
		url : url,
		isResize : true,
		// 回调函数
		onload: function () {
	        var iframe = this.getIFrameEl();
	        iframe.contentWindow.setData(params);
	    },
	    ondestroy: function (rtn) { 
	    	if(rtn=="close" || rtn=="cancel"){
	    		return;
	    	}
	    	conf.callback(rtn);
	    }
	});
}


/**
 * 初始化日历
 */
function initCalendar() {
	var startTime1 = formatDate(_startTime),
		endTime1 =  formatDate(_endTime);
   $('#calendarScheduleInfo').empty();
   $("#calendarScheduleInfo").append("<div  id='calendar_info' > </div>"); 
   var calendar_info = $("#calendar_info");
   calendar_info.fullCalendar({
		header : {
			left : 'title',
			right : 'prev,next'
		},
		year: startTime1.getFullYear(),month: startTime1.getMonth(),
		height : 600,
		editable : true,
		aspectRatio : 1.35,
		disableDragging: true,
		eventAfterRender: function(event, element, view) {
			
            var title = "",startTime = formatDate(event.start.format('YYYY-MM-DD'));
            $("#calendar_info td").each(function() {
                var tdThis = this;
                var dateValue = $(tdThis).attr('data-date');
                if (dateValue != null && dateValue != undefined) {
                    var time = new Date(dateValue.replace(/-/g, "/"));
                    if (time.getTime() >= startTime1.getTime() && time.getTime() <= endTime1.getTime()) {
                        $(this).each(function() {
                            var grand = $(this);
                            if ($(grand).hasClass("fc-day-number")) {
                                $(grand).css("opacity", 0.7);
                            }
                        });
                       
                        if (time.getTime() == startTime.getTime()) {
                            title = getColorTitle(tdThis, event, true);
                        }
                    }
                }
            });
            
            var divHtml = '<div class="divC div-helper">'+ title +'</div>';
            element.html(divHtml);
        },
		eventClick : function(event, e) {
		},
		dayClick: function(date, allDay, event, view) {
			/*var start = date.format('YYYY-MM-DD'),
				date1 = formatDate(start);
	         if (date1.getTime() < startTime1.getTime() || date1.getTime() > endTime1.getTime()) 
                    return false;
			replaceShiftCalendar(event, start,
					date1);*/
		},
		events: _listRowDatas
	});
	$('tr[class="fc-week fc-last"]').css('display', 'none');
	$('#calendar_info').fullCalendar('gotoDate', _startTime);
}