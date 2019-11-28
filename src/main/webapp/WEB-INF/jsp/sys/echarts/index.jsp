<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>自定义图表</title>
	<%-- <%@include file="/commons/dynamic.jspf"%> --%>
	<%@include file="/commons/list.jsp"%>
	<script type="text/javascript" src="${ctxPath}/scripts/jquery-1.11.3.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/echart/echarts.min.js"></script>
	<style>
		*{margin:0;padding:0;font-size:12px;list-style:none;}
		html, body{width:100%;height:100%;background-color:#fff;}
		#container{width:100%;height:100%;}
	</style>
</head>
<body>
	<div id="container"></div>
	<script type="text/javascript">
		var echart = echarts.init(document.getElementById("container"));
		var ecConfig = echarts.config;
		
		$(function(){
			var id = "<%=request.getParameter("id")%>";
			var tjzq = "<%=request.getParameter("TJZQ")%>";
			
			$.post("${ctxPath}/sys/echarts/echartsCustom/testData.do", 
				{"id": id, "SQ": tjzq}, 
				function(dat){
					console.log(dat);
					echart.setOption(dat);
					
					//触发事件Test - start
					/* echart.on('pieselectchanged', function(){
						//console.log("**** "+JSON.parse(this));
						_OpenWindow({ //开窗
							title:'Echarts New Window Test',
							width:"800",
							height:"600",
							url:'http://www.baidu.com',
						});
					}); */
					//end
					/*echart.on('pieselectchanged', function(params){
						var _name = params.name;
						var _selected = params.selected;
						var _selectIndex = -1;
						for(var key in _selected){
							_selectIndex++;
							if(_selected[key]){
								break;
							}
						}
						//console.log(_selectIndex); //第几个被选中
						
						console.log(echart.getOption());
						
						console.log("********************************");
					});*/
					echart.on("click", function(param){
						console.log(param);
					});
					
					
					if(dat.series.type == "gauge"){
						setInterval(function (){
							$.post('${ctxPath}/sys/echarts/echartsCustom/testData.do', {"id":id}, 
								function(data){
									echart.setOption(data, true);
								}
							);
						},1500);
					}
					
				}
			);
		});
		
		function eConsole(params){
			if(typeof params.seriesIndex != 'undefined'){
				alert(params.name);
			}
		}
		
		window.onresize = function(){
			echart.resize();
		}
	</script>
</body>
</html>


