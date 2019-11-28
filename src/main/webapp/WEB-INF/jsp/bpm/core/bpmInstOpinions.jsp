<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<!DOCTYPE html>
<html>
    <head>
        <title>任务转发</title>
      <%@include file="/commons/list.jsp"%>
      <script src="${ctxPath}/scripts/flow/inst/opinion.js?static_res_version=${static_res_version}"></script>
		<style>
			.spanClass
			{
				padding: 4px;
				line-height: 20px;
				float: left !important;
				white-space: normal !important;
			}
			.mini-grid-cell-inner br{
				display: none;
			}
		</style>
	</head>
	
<body >
<div class="fitTop"></div>
<div class="mini-fit">
<div class="form-container" style="height:100%;">
	<table class="table-view"  id="taskHandle" style="height: 100%;">
		<tr>
			<td style="height:48px; border: none; padding: 0;text-indent:2em;text-align:center"><h2>审批记录</h2></td>
		</tr>
		<tr class="trBoxs">
			<td valign="top" style="height:100%;">
				<div 
					id="checkGrid" 
					class="mini-datagrid" 
					style="width:100%;height:100%;" 
					height="auto" 
					allowResize="false" 
					ondrawcell="drawNodeJump" 
					showPager="false"  
					pageSize="50"  
					allowCellWrap="true"
					bodyStyle="border-bottom: none"
					idField="jumpId" 
					allowAlternating="true"
					allowCellWrap="true"
				>
					<div property="columns">
						<div field="createTime" dateFormat="yyyy-MM-dd HH:mm"   >发送时间</div>
						<div field="completeTime" dateFormat="yyyy-MM-dd HH:mm"   >处理时间</div>
						<div field="durationFormat" width="70">停留时间</div>
						<div field="nodeName" width="70"   cellStyle="">审批步骤</div>
						<div field="handlerId" width="70"  cellStyle="font-size:10px">操作者</div>
						<div field="checkStatusText" width="60"   cellStyle="font-size:10px">类型</div>
						<div width="60"  cellStyle="line-height:20px;" renderer="onActionRenderer">意见</div>
						<div field="remark" width="160"   cellStyle="font-size:10px">附件</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
</div>
	<script type="text/javascript">
		mini.parse();
		
		var grid=mini.get("checkGrid");
		var url="${ctxPath}/bpm/core/bpmNodeJump/listForInst.do?actInstId=${param.actInstId}&more=true" ;
		grid.setUrl(url);
		grid.load();
		
		grid.on('update',function(){
	    	_LoadUserInfo();
	    });
		function onActionRenderer(e){
			var record = e.record;
			var  remark=record.remark;
			var s = '<span class="spanClass">'+remark+'</span>';
			return s;
		}
	</script>
</body>
</html>