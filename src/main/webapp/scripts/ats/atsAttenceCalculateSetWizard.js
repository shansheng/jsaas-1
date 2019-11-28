var AtsConstant = { // 用户的常量
				SHIFT_TYPE_CALENDAR : 1,
				SHIFT_TYPE_LIST : 2
		}		

		function refresh(){
			window.location.reload();
		}
		function prevStep(){
			var step=$(".ystep1").getStep();
			if(step<=0) return;
			var tab=tabs.getTab(step-1-1);
			tabs.updateTab(tab,{enabled:true});
			tabs.activeTab(tab);
			$(".ystep1").setStep(step-1);
			$("#save").hide();
		}
		
		function nextStep(){
			//步骤从1开始，tab的index从0开始
			var step=$(".ystep1").getStep();
			if(step>4) return;
			//检查当前步骤是否已经完成，需要确认检查条件TODO
			var tab=tabs.getTab(step+1-1);
			tabs.updateTab(tab,{enabled:true});
			tabs.activeTab(tab);
			$(".ystep1").setStep(step+1);
			if(step>3){
				if(attencePolicy == null || attencePolicy == ""){
					prevStep();
					mini.alert("请输入考勤制度");
	        	}
			}
			if(step == 4){
				$("#save").show();
			}else{
				$("#save").hide();
			}
			/*
			if(step==6){
				mini.get('deployButton').setEnabled(true);
			}*/
		}
		
		//获取当前月的第一天
		function getCurrentMonthFirst(){
		 var date=new Date();
		 date.setDate(1);
		 return date;
		}
		
		//获取当前月的最后一天
		function getCurrentMonthLast(){
		 var date=new Date();
		 var currentMonth=date.getMonth();
		 var nextMonth=++currentMonth;
		 var nextMonthFirstDay=new Date(date.getFullYear(),nextMonth,1);
		 var oneDay=1000*60*60*24;
		 return new Date(nextMonthFirstDay-oneDay);
		}
		 
		var _startTime;//开始时间
		var _endTime;//结束时间
		_listRowDatas = [];//排班数据
		var userAry = [];//用户数据
		var attencePolicy;//考勤制度
		var type;//排班类型
		var selectedIds = [];
		function onTabsActiveChanged(e) {
            var tabs = e.sender;
           // var tab = tabs.getActiveTab();
            var index=tabs.getActiveIndex();
            $(".ystep1").setStep(index+1);
            
            _startTime = mini.get("startDate").value;
        	_endTime = mini.get("endDate").value;
        	
        	if(index > 0){
        		var obj1 = $("input[name=shiftType]:checked");
        		type = obj1.val();
        		if(index==1){
        			_listRowDatas = [];//切换模式时,清空数据
        			//初始化当前月第一天和最后一天
        			mini.get("startDate").setValue(getCurrentMonthFirst());
        			mini.get("endDate").setValue(getCurrentMonthLast());
        		}
        	}
        	if(index > 1){
        		if(!checkData(index)){
            		return;
            	};
        	}
            if(index==3){
            	if(type=="1"){
            		$('#scheduleCalendar').show();
    				$('#scheduleList').hide();
    				if (_listRowDatas.length  > 0 ){
				        initCalendar();
				    }else{
	            		createCalendar();
				    }
            	}else{
            		$('#scheduleCalendar').hide();
    				$('#scheduleList').show();

    				renderDataGrid("scheduleList");
    				
            	}
            }
            
            if(index==4){
        		var grid = mini.get("datagrid2");
            	$("#save").show();
            	
            	$.ajax({
    				type : "POST",
    				url : __rootPath+"/oa/ats/atsAttenceCalculateSet/finished.do",
    				async : true,
    				data : {
    					userAry : JSON.stringify(userAry),
    					listRowDatas : JSON.stringify(_listRowDatas),
    					shiftType : $("input[name=shiftType]:checked").val()
    				},
    				success : function(data) {
    					var d = $.parseJSON(data);
    					if (!d.success) {
							mini.alert(d.results);
    						return;
    					}
    					grid.setData(d.results);
    				}
    			});
            }else{
				$("#save").hide();
			}
        }
		
		/**
		 * 新增排班规则
		 */
		function addShiftRule() {
				/*if (_shiftType == AtsConstant.SHIFT_TYPE_LIST) {// 列表模式
					selectedIds = $("#list_info").jqGrid('getGridParam',
							'selarrrow');
					if (selectedIds == null || selectedIds.length < 1) {
						$.ligerDialog.alert("请选择要编排人员！", "提示信息");
						return;
					}
				}*/
				var params = {
					startTime : _startTime,
					endTime : _endTime,
				}, url = __rootPath + '/oa/ats/atsShiftRule/setting.do';
				mini.open({
					height : 600,
					width : 800,
					title : '轮班规则',
					url : url,
					isResize : true,
					// 回调函数
					onload: function () {
				        var iframe = this.getIFrameEl();
				        iframe.contentWindow.setParam(params);
				    },
				    ondestroy: function (rtn,beginCol) { 
				    	if(rtn=="close" || rtn=="cancel"){
				    		return;
				    	}
				    	if (type == AtsConstant.SHIFT_TYPE_CALENDAR) {// 日历模式
							_listRowDatas = rtn;
							initCalendar();
						} else {
							for (var i = 0; i < userAry.length; i++) {
								for (var j = 0; j < rtn.length; j++) {
									// 数据处理
									var rowData = _listRowDatas[i][rtn[j].start];
									rowData.title = rtn[j].title;
									rowData.start = rtn[j].start;
									rowData.dateType = rtn[j].dateType;
									rowData.shiftId = rtn[j].shiftId;
									rowData.holidayName = rtn[j].holidayName;
									if(rowData.title=="" || rowData.title==null){
										rowData.title = rowData.holidayName;
									}
									var row = grid.getRow(i);
									grid.updateRow(row,rowData);
								}
								var colData = _listRowDatas[i];
								delete colData.title;
								delete colData.start;
								delete colData.dateType;
								delete colData.shiftId;
								delete colData.holidayName;
								delete colData._state;
							}
							
						}
				    }
				});
		}
		
		function remoteCall(conf){
			var url = conf.url;
			if(conf.method)
				url =__rootPath+"/oa/ats/atsAttenceCalculateSet/"+conf.method+".do";
			$.ajax({
				type : "POST",
				url :url,
				data : conf.param?conf.param:{},
				success : function(data) {
					conf.success.call(this,data);
				}
			});
		}
		
		function renderDataGrid(method){
			remoteCall({
				method : method,
				param : {
					"startTime" : _startTime,
					"endTime" : _endTime
				},
				success : function(data) {
					onLoadGrid(data);
				}
			});
		}
		
		function onLoadGrid(data){
			grid = mini.get("datagrid1");
			var colNames = data.colNames;
			var	colModel = data.colModel;
			
			 	grid.set({
			        columns: mini.decode(colModel)
			    });
			 	
			 	loadGrid();
			 	
			 	grid.on("drawcell",function(e){
					if(e.field=="account" || e.field=="userName") return;
					e.cellHtml=e.value.title;
				})
		}
		
		
		
		function loadGrid(){
			$.ajax({
				type : "POST",
				url : __rootPath+"/oa/ats/atsAttenceCalculateSet/listShiftHandler.do",
				data : {
					users : JSON.stringify(userAry),
					startTime : _startTime,
					endTime : _endTime
				},
				success : function(json) {
					var jsonObj = mini.decode(json).results;
					grid.setData(jsonObj);
					_listRowDatas = jsonObj;
					grid.on("cellclick",function(e){
						e.record[e.field]
					    var col = e.column._index;
						var colName = e.field;
						if (col > 1 && col <= e.sender.columns.length-1) {
							replaceShift({
										start : colName,
										callback : function(rtn, date1) {
											
											/*$(tdObject).attr('title', rtn.title);*/
											//更新数据
											var rowData = (_listRowDatas[e.record.index])[colName];
											rowData.title = rtn.title;
											rowData.start = rtn.start;
											rowData.dateType = rtn.dateType;
											rowData.shiftId = rtn.shiftId;
											rowData.holidayName = rtn.holidayName;
											
											grid.updateRow(e.row,e.record);
										}
									});
						}
					})
				}
			});
		}		
		
		//检查数据 -- 日期/选择人员/考勤周期
		function checkData(index){
			if(isEmpty(_startTime) || isEmpty(_endTime) && index>1){
				mini.alert("请选择日期");
        		tabPage(1);
        		return false;
        	}
			if(_startTime > _endTime){
				mini.alert("开始时间必须小于结束时间");
        		tabPage(1);
        		return false;
			}
			if(userAry.length==0 && index>2){
				mini.alert("请选择人员");
        		tabPage(2);
        		return false;
        	}
			if(isEmpty(attencePolicy) && index>2){
				mini.alert("请输入考勤制度");
				tabPage(2);
				return false;
        	}
        	return true;
		}
		
		//跳转至特定页
		function tabPage(index){
			var step=index;
			var tab=tabs.getTab(step);
			tabs.updateTab(tab,{enabled:true});
			tabs.activeTab(tab);
			$(".ystep1").setStep(step);
		}
		
		function isEmpty(obj){
			if(obj == null || obj == ""){
        		return true;
        	}
			return false;
		}
		
		function formatDate(d) {
			return new Date(d.replace(/-/g, "/"));
		}
		
		function createCalendar(){
			$.ajax({
				type : "POST",
				url : __rootPath+"/oa/ats/atsAttenceCalculateSet/calendarShiftHandler.do",
				dataType: 'json',
				data : {
					startTime : _startTime,
					endTime : _endTime
				},
				success : function(data) {
				     if (!data.success) {
						 mini.alert(data.msg);
		                return;
		             } 
				   _listRowDatas = data.results;
				   initCalendar();
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
		
		function getColorTitle(_self, event, flag) {
			var self =  $(_self), title = event.title,dateType =event.dateType;
		    self.removeClass('gray-color');
		    self.removeClass('litterGreen-color');
		    if (dateType == 2) {//休息日
		        if (flag) {
		            self.addClass('gray-color');
		        }
		    } 
		    else if (dateType == 3) {//节假日
		        if (flag) {
		      
	        	  if (self.hasClass("fc-day-number") && event.holidayName != null) {
	        	  	  var td = self.html();
	        	  	  self.html(event.holidayName+"&nbsp;"+td);
	        	  }
	        	  self.addClass('litterGreen-color');
		        }
		    } 
		     return title;
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
	                var divHtml = '<div style="color:#ffffff;">' + title + '</div>';
	                element.html(divHtml);
	            },
				eventClick : function(event, e) {
				},
				dayClick: function(date, allDay, event, view) {
					var start = date.format('YYYY-MM-DD'),
						date1 = formatDate(start);
			         if (date1.getTime() < startTime1.getTime() || date1.getTime() > endTime1.getTime()) 
		                    return false;
					replaceShiftCalendar(event, start,
							date1);
				},
				events: _listRowDatas
			});
			$('tr[class="fc-week fc-last"]').css('display', 'none');
			$('#calendar_info').fullCalendar('gotoDate', _startTime);
		}