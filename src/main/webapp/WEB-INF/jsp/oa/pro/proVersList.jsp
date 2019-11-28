<%-- 
    Document   : 项目版本列表页面
    Created on : 2015-3-21, 0:11:48
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>版本管理</title>
<%@include file="/commons/list.jsp"%>
<style>
	.mini-toolbar{
		margin: 0
	}
	.titleBar{
		margin-top: 0;
		margin-bottom: 0;
	}
</style>
</head>
<body>
	<div id="toolbutton1" class=" form-outer">
		<redxun:toolbar entityName="com.redxun.oa.pro.entity.ProVers" excludeButtons="popupAddMenu,popupAttachMenu,detail,edit,remove,popupSearchMenu,fieldSearch,saveCurGridView,saveAsNewGridView,export,importData">
			<div class="self-toolbar">
				<li>
					<a style="display: node;" id="newversadd" class="mini-button" onclick="addOne()" plain="true">起草版本</a>
				</li>
				<li>
					<a class="mini-button" plain="true" onclick="location.reload();">刷新</a>
				</li>
			</div>
		</redxun:toolbar>
	</div>
	<div class="mini-fit form-outer" style="height: 100%;">
		<div 
			id="datagrid1" 
			class="mini-datagrid"
			style="width: 100%; height: 100%;" 
			allowResize="false"
			url="${ctxPath}/oa/pro/proVers/listData.do?projectId=${projectId}" 
			idField="versionId"
			multiSelect="true" 
			showColumnsMenu="true" 
			ondrawcell="OnDrawCell(e)" 
			onrowdblclick="openDetail(e)"
			sizeList="[5,10,20,50,100,200,500]" 
			pageSize="20"  
			onupdate="restrictCreate()"
			allowAlternating="true" 
		>
			<div property="columns">
				<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" 	
					cellStyle="padding:0;">操作</div>
				<div field="version" width="120" headerAlign="center"  >版本号</div>
				<div field="status" width="120" headerAlign="center"  renderer="onStatusRenderer">状态</div>
				<div field="startTime" width="120" headerAlign="center"   renderer="onRenderer">开始时间</div>
				<div field="endTime" width="120" headerAlign="center"   renderer="onRenderer">结束时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	mini.parse();
	var grid=mini.get("datagrid1");
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pkId = record.pkId;
	            var s ='';
         	   s+='<span title="明细" onclick="detailMyRow(\'' + pkId + '\')">明细</span>';
	            if(record.status!='DEPLOYED'){
	            	   if(record.status!='RUNNING'){
	            		   s+='<span  title="启动" onclick="startRow(\'' + pkId + '\')">启动</span>';//变成DEPLOYED状态
	            	   }else{
                       s+='<span title="发布" onclick="publishRow(\'' + pkId + '\')">发布</span>';}//变成	RUNNING 状态
	            	   s+=' <span  title="编辑" onclick="editMyRow(\'' + pkId + '\')">编辑</span>';
	            	   s+=' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';}
	            return s;
	        }
        	
        	
        	
        	var computeNum=0;
	        function restrictCreate(){
	        	if(computeNum>0){
	        		$("#newversadd").hide();
	        	}else{
	        		$(function(){
        				$("#newversadd").show();
        			});
	        	}
	        	computeNum=0;
	        }
        	
        	
        	//当版本中全是已发布的时候允许新建版本草稿
        	function OnDrawCell(e){
        		var record=e.record;
        		if(record.status!="DEPLOYED"){
        			computeNum++;
        		}
        	}
        	
        	
        	//行明细
	        function detailMyRow(pkId) {
	            _OpenWindow({
	            	url: __rootPath+"/oa/pro/proVers/get.do?pkId=" + pkId,
	                title: "版本明细", width: 800, height: 400,
	            });
	        }
        	
        	
	      //编辑行数据
	        function editMyRow(pkId) {        
	            _OpenWindow({
	        		 url: __rootPath+"/oa/pro/proVers/edit.do?pkId="+pkId,
	                title: "编辑版本",
	                width: 800, height: 600,
	                ondestroy: function(action) {
	                    if (action == 'ok') {
	                        grid.reload();
	                    }
	                }
	        	});
	        }
	        //添加数据
		    function addOne() {
		    	_OpenWindow({
		    		url: __rootPath+"/oa/pro/proVers/edit.do?parentId="+${projectId},
		            title: "新增", width: 800, height: 600,
		            ondestroy: function(action) {
		            	if(action == 'ok' && typeof(addCallback)!='undefined'){
		            		var iframe = this.getIFrameEl().contentWindow;
		            		addCallback.call(this,iframe);
		            	}else if (action == 'ok') {
		                    grid.reload();
		                }
		            }
		    	});
		    }
	        	
	        //发布项目版本
	        function publishRow(pkId){
	        	if(confirm("确认要发布此版本吗")){
	        		$.ajax({
		                type: "Post",
		                url : '${ctxPath}/oa/pro/proVers/publish.do?versionId='+pkId+"&projectId="+${projectId},
		                beforeSend: function () { 
		                },
		                success: function (action) {
		                		mini.get("datagrid1").reload();		
		                }
		            }); 
	        	}
	        }
	        
	        //启动项目版本
	        function startRow(pkId){
	        	if(confirm("确认要启动此版本吗")){
	        		$.ajax({
		                type: "Post",
		                url : '${ctxPath}/oa/pro/proVers/start.do?versionId='+pkId+"&projectId="+${projectId},
		                beforeSend: function () { 
		                },
		                success: function (action) {
		                		mini.get("datagrid1").reload();		
		                }
		            }); 
	        	}
	        }
	        
	      //渲染时间
	   	 function onRenderer(e) {
	               var value = e.value;
	               if (value) return mini.formatDate(value, 'yyyy-MM-dd HH:mm:ss');
	               return "暂无";
	           }
        	
	      
	   //双击打开项目明细
			function openDetail(e){
				e.sender;
				var record=e.record;
				var pkId=record.pkId;
				detailMyRow(pkId);
			}
	   
	   
			 function onStatusRenderer(e) {
		         var record = e.record;
		         var status = record.status;
		         
		         var arr = [ {'key' : 'DEPLOYED','value' : '发布','css' : 'green'}, 
				             {'key' : 'DRAFTED','value' : '草稿','css' : 'orange'},
				             {'key' : 'RUNNING','value' : '进行中','css' : 'blue'}, 
				             {'key' : 'FINISHED','value' : '完成','css' : 'red'} ];
				
					return $.formatItemValue(arr,status);
		     }
			 
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.redxun.oa.pro.entity.ProVers" winHeight="450"
		winWidth="700" entityTitle="项目版本" baseUrl="oa/pro/proVers" />
	
</body>
</html>