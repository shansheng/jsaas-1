<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/commons/get.jsp"%>
<%@taglib prefix="imgArea" uri="http://www.redxun.cn/imgAreaFun"%>
<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/plugins/qtips/jquery.qtip.min.css?version=${static_res_version}" />
<script src="${ctxPath}/scripts/jquery/plugins/qtips/jquery.qtip.min.js?version=${static_res_version}" type="text/javascript"></script>
   <style type="text/css">
		    html, body{
		        margin:0;padding:0;border:0;width:100%;height:100%;
		    }  
          .cage{
                width: 60px;
                height: 22px;
                float: left;
                text-align:center;
                margin-right: 10px;
                font-size:10px;
                font-weight: bold;
            }
    </style>
    <script type="text/javascript">
    var formData;
    function setPostData(postData){
    	formData = postData;
    }
    function initUser(conf){
		var aryParams=[];
		for(var key in conf){
			if(conf[key]){
				aryParams.push(key +"=" +conf[key]);
			}
		}
		var tmp=aryParams.join("&");
		$("area[type='userTask']").each(function(){
		 	var nodeId=$(this).attr('id');
			$(this).qtip({
				content: {
	                text: function(event, api) {
	                    $.ajax({
	                        url: __rootPath+"/bpm/core/bpmTask/calUsers.do?nodeId="+nodeId+"&" + tmp,
	                        data:{"jsonData":formData}
	                    })
	                    .then(function(content) {
	                        api.set('content.text', content);
	                    }, function(xhr, status, error) {
	                        api.set('content.text', status + ': ' + error);
	                    });
	                    return '正在加载...'; 
	                }
	            },
	            position: {
	                target: 'mouse', // Position it where the click was...
	                adjust: { mouse: false } // ...but don't follow the mouse
	            }
		    });
	 });
	}
    </script>
</head>
<body>
	<div style="width:100%;height:100%;overflow: auto;padding: 0 0 0 0;background-color: white;">
		<div style="width:100%;clear:both;">
			<div style="padding:5px;display: block">
				<div class="cage" >边框示例：</div><c:forEach items="${bpmImageColors}" var="bcolor1"> <div class="cage" style="border-bottom:solid 2px rgb(${bcolor1.key});">${bcolor1.value}</div></c:forEach>
				<div style="clear:both;width:100%;padding-top:5px;"></div>
				<div class="cage" >背景示例：</div><c:forEach items="${bpmTimeoutColors}" var="bcolor2"><div class="cage" style="background-color: rgb(${bcolor2.key})">${bcolor2.value}</div></c:forEach>
			</div>
		</div>
		<div style="padding-top:10px;clear:both">
		<c:choose>
			<c:when test="${not empty param.taskId}">
				<img id="activitiDiagram" style="border:0px;" usemap="#imgHref" src="${ctxPath}/bpm/activiti/processImage.do?taskId=${param.taskId}"/>
				<imgArea:imgAreaScript taskId="${param.taskId}" ></imgArea:imgAreaScript>
				<script type="text/javascript">
				initUser({taskId:"${param.taskId}"});	
				</script>
				
			</c:when>
			<c:when test="${not empty param.actInstId}">
				<img id="activitiDiagram" style="border:0px;" usemap="#imgHref" src="${ctxPath}/bpm/activiti/processImage.do?actInstId=${param.actInstId}"/>
				<imgArea:imgAreaScript actInstId="${param.actInstId }" ></imgArea:imgAreaScript>
				<script type="text/javascript">
				initUser({actInstId:"${param.actInstId}"});	
				</script>
			</c:when>
			<c:when test="${not empty param.instId}">
				<img id="activitiDiagram" style="border:0px;" usemap="#imgHref" src="${ctxPath}/bpm/activiti/processImage.do?instId=${param.instId}"/>
				<imgArea:imgAreaScript instId ="${param.instId }" ></imgArea:imgAreaScript>
				<script type="text/javascript">
				initUser({instId:"${param.instId}"});	
				</script>
			</c:when>
			<c:when test="${not empty param.actDefId}">
			 <img src="${ctxPath}/bpm/activiti/processImage.do?actDefId=${param.actDefId}"/>
			</c:when>
		</c:choose>
	    </div>
	</div>
	
	
</body>
</html>