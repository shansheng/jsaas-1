<%-- 
    Document   : 已发消息的Get页面
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>内部短消息内容</title>
<%@include file="/commons/get.jsp" %>
<style>
hr {
	border: 1px dashed #ccc;
	border-bottom: 0;
	border-right: 0;
	border-left: 0;
}
</style>
</head>
<body >
	
		
		 <div class="mini-toolbar"  style="height:30px;padding:4px;">
	        发送至:&nbsp;&nbsp;<span style="color: green;">${sendMsg.recName}</span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 12px; color: blue;">${sendMsg.createTime}</span>
	    </div>
	    <div class="mini-fit">
		<div id="panel1" class="mini-panel" showHeader="false" style="width:100%;height:100%;padding:5px;" bodyStyle="border-bottom: none;" 
	      showFooter="true" allowResize="true" bodyStyle="padding:5px;" >

			<div style="color: #712704;">${sendMsg.content}</div>
			
			<div property="footer"  style="padding:5px;text-align:center;">
		        <a class="mini-button btn-red"  plain="true" onclick="closeMsg()">关闭</a>
				<a class="mini-button"  plain="true" onclick="preMsg()">上一条</a>
				<a class="mini-button"  plain="true" onclick="nextMsg()">下一条</a>
				<a class="mini-button btn-red"  plain="true" onclick="delMsg()">删除</a>
		    </div>
	    </div>
	</div>
	<script type="text/javascript">
	//删除消息
    function delMsg(){
    	 if (confirm("确定删除当前记录？")) {
             var pkId='${sendMsg.recId}';
             _SubmitJson({
 				url : "${ctxPath}/oa/info/infInbox/delSendMsg.do",
 				data:{
 					pkId:pkId
 				},
 				method:"POST",
 				success:function(){
 					grid.load();
 				}
 			});
         }
    }
    //关闭页面
	function closeMsg(){
		CloseWindow();
	}
    
    //上一条
	function preMsg(){
		var pkId=top['com.redxun.oa.info.entity.InfInbox'].preRecord();//获得上一条的pkId
        if(pkId==0) {
        	mini.showTips({
                content: "已经是第一条了。",
                state: "info",
                x: "right",
                y: "top",
                timeout: 1000
            });
        	return ;
        }
        //打开上一条
        window.location='${ctxPath}/oa/info/infInbox/sendGet.do?pkId='+pkId;
	}
	
    //下一条
	function nextMsg(){
		var pkId=top['com.redxun.oa.info.entity.InfInbox'].nextRecord();//获得下一条的pkId
        if(pkId==0){
        	mini.showTips({
                content: "已经是最后一条了。",
                state: "info",
                x: "right",
                y: "top",
                timeout: 1000
            });
        	return ;
        }
		//打开下一条
        window.location='${ctxPath}/oa/info/infInbox/sendGet.do?pkId='+pkId;
	}
	
	
</script>
<rx:detailScript baseUrl="oa/info/infInbox" formId="form1"  entityName="com.redxun.oa.info.entity.InfInbox"/>
</body>
</html>