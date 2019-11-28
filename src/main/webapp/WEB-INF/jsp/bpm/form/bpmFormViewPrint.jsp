<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
	<head>
		<title>表单打印</title>
		<%@include file="/commons/customForm.jsp"%>
		<style type="text/css">
			body{
				background: #f7f7f7;
				height: 100%;
			}
		
			.form-outer{
				border-right: none;
			}
			
			.shadowBox{
				box-shadow: none;
				padding-top:5px;
			}
			
			.shadowBox caption,
			.shadowBox th,
			.shadowBox td,
			.mini-grid-topRightCell,
			.mini-grid-headerCell,
			.mini-grid-topRightCell,
			.mini-grid-columnproxy{
				background: transparent;
			}
			
			.shadowBox h2{
				font-size: 18px;
			    padding-top: 5px;
			    line-height:38px;
			    padding-bottom: 5px;
			    width: 100%;
			    /*border-bottom: solid 1px #ddd;*/
			   	margin-bottom:5px;
			    font-weight: bold;
			    color: #252d55;
			}
			
			.mini-grid-row:last-of-type .mini-grid-cell,
			#showCheckListDiv .mini-grid-topRightCell{
				border-bottom: none;
				white-space: nowrap;
				line-height: 22px;
			}
			
			.mini-panel-viewport,
			td .mini-panel-border{
				border: 1px solid #ececec;
			}
			
			.mini-panel-border{
				border-radius: 0;
			}
			
			.mini-grid-columns>.mini-grid-columns-view>.mini-grid-table tr:nth-of-type(2) .mini-grid-headerCell{
				border-color: #ececec;
			}
			
			.mini-panel-viewport{
				border: none;
			}
			
			.mini-grid-vscroll{
				display: none;
			}
			
			.mini-grid-headerCell .mini-grid-headerCell-inner{
				color: #666;
			}
			
			#showCheckListDiv .mini-grid-border{
				border: 1px solid #ececec;
			}
			
			.shadowBox:last-of-type{
				margin-bottom: 0;
			}
			
			#form-panel>table{
				width: 100% !important;
			}
			td .mini-panel-border{
				border:0;
			}

			.noPrint>span{
				vertical-align: middle;
				margin-right: 6px;
			}
			.form-container{
				height: auto;
				min-height: auto;
			}
			.titles{
				padding: 10px 10px 10px 0px;
				font-size: 16px;
			}
			h3.titles{
				line-height: 50px;
				text-align: center;
				font-size: 18px;
			}
		</style>
	</head>
<body>
	<div  class="topToolBar noprint">
		<div class="noPrint">
			<c:if test="${empty param['viewId'] &&  empty param['solId'] && empty param['setContent']}">
				<div id="showCheckList" name="showCheckList" class="mini-checkbox" readOnly="false" text="显示审批历史"  onvaluechanged="showCheckList"></div>
				<div id="showImage" name="showImage" class="mini-checkbox" readOnly="false" text="显示流程图" onvaluechanged="showImage"></div>
			</c:if>
			<a class="mini-button"  onclick="Print();" plain="true">打印</a>
			<a class="mini-button btn-red"  onclick="CloseWindow();" plain="true">关闭</a>
		</div>
	</div>

	<div class="form-container" id="formPrint">
		<h3 class="titles">[测试]维修记录</h3>
		<c:if test="${not empty bpmInst }">
			<div class="titles">流程信息</div>
			<table class="table-detail column-four"  style="width:100%;" cellpadding="0" cellspacing="1">
				<tr>
					<td >
						流程发起人
					</td>
					<td >
						<rxc:userLabel userId="${bpmInst.createBy}"/>
					</td>
					<td>单号</td>
					<td>${bpmInst.billNo}</td>
				</tr>
				<tr>
					<td>发起时间</td>
					<td><fmt:formatDate value="${bpmInst.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>结束时间</td>
					<td></td>
				</tr>
			</table>
		</c:if>
		<div class="titles">基本信息</div>
		<div id="form-panel" style="margin:0 auto;">

		</div>
	</div>

		<c:if test="${empty param['viewId']}">
			<div class="form-container" style="padding: 0;margin-top: 10px;">
				<div  id="showCheckListDiv" style="display:none;padding: 10px;">
					<div class="titles">审批历史</div>
					<div
						id="checkGrid"
						class="mini-datagrid"
						style="width:100%;"
						height="auto"
						allowResize="false"
						showPager="false"
						url="${ctxPath}/bpm/core/bpmNodeJump/listForInst.do?instId=${param['instId']}&actInstId=${actInstId}&taskId=${param['taskId']}"
						idField="jumpId"
						allowAlternating="true"
					>
						<div property="columns">
							<div type="indexcolumn" width="20" headerAlign="center">序号</div>
							<div field="createTime" dateFormat="yyyy-MM:dd HH:mm" width="80"  >发送时间</div>
							<div field="completeTime" dateFormat="yyyy-MM:dd HH:mm" width="80"  >处理时间</div>
							<div field="durationFormat" width="60">停留时间</div>
							<div field="nodeName" width="90"  >节点名称</div>
							<div field="handlerId" width="60" >操作者</div>
							<div field="checkStatusText" width="60"  >审批</div>
							<div field="remark" width="210"  cellStyle="line-height:10px;">处理意见</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-container"  style="padding: 0;margin-top: 10px;">
				<div id="showImageDiv" style="display:none;padding: 10px">
							<div class="titles">流程图</div>
							<div style="border:solid 1px #ececec;text-align:center;width:100%; ">
							<img src="${ctxPath}/bpm/activiti/processImage.do?instId=${param['instId']}&actInstId=${param['actInstId']}&taskId=${param['taskId']}"  style="max-width: 100%;"/>
							</div>
				</div>
			</div>
		</c:if>




	<script type="text/javascript">
		
		function setData(data){
			
			var url="${ctxPath}/bpm/form/bpmFormView/getPrintForm.do";
			var params={
					taskId:"${param['taskId']}",
					solId:"${param['solId']}",
					instId:"${param['instId']}",
					formAlias:"${param['formAlias']}",
					json:data
				}
			$.post(url,params,function(result){
				var html="";
				for(var i=0;i<result.length;i++){
					var o=result[i];
					html+=o.content;
				}
				$("#form-panel").html(html);
				renderMiniHtml({},result);
				loadGrid();
			})
		}
		
		function loadGrid(){
		
			var grid=mini.get('checkGrid');
			grid.load();
			grid.on("drawcell", function (e) {
	            var record = e.record,
		        field = e.field,
		        value = e.value;
	          	var ownerId=record.ownerId;
	            if(field=='handlerId'){
	            	if(ownerId && ownerId!=value){
	            		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>&nbsp;(原审批人:'+ '<a class="mini-user" iconCls="icon-user" userId="'+ownerId+'"></a>'+')';
	            	}else if(value){
	            		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>';
	            	}else{
	            		e.cellHtml='<span style="color:red">无</span>';
	            	}
	            } 
	        });
	        grid.on('update',function(){
	        	_LoadUserInfo();
	        });
		}

		function showCheckList(){
			var div=$("#showCheckListDiv");
			if(div.css('display')=='none'){
				div.css('display','');
				loadGrid();
			}else{
				div.css('display','none');
			}
		}
		
		function showImage(){
			var div=$("#showImageDiv");
			if(div.css('display')=='none'){
				div.css('display','');
			}else{
				div.css('display','none');
			}
		}
	</script>
</body>
</html>