<%-- 
    Document   : [BpmInstRead]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    	<title>[BpmInstRead]列表管理</title>
    	<%@include file="/commons/list.jsp"%>
    </head>
    <body>
        <table class="table-view"  id="taskHandle" style="height: 100%;">
			<tr>
				<td style="height:24px; border: none; padding: 0;">阅读记录</td>
			</tr>
			<tr>
				<td  >
					<div id="readGrid" class="mini-datagrid" style="width:100%;" height="auto" allowResize="false" showPager="true" ondrawcell="onReadDrawCells"
						url="${ctxPath}/bpm/core/bpmInstRead/readList.do?instId=${bpmInst.instId}" idField="readId" allowAlternating="true" >
						<div property="columns">
							<div type="indexcolumn" width="30">序号</div>
							<div field="userName" width="100" headerAlign="center" allowSort="true">用户名</div>
							<div field="depName" width="100" headerAlign="center" allowSort="true">部门名</div>
							<div field="state" width="100" headerAlign="center" allowSort="true">流程状态</div>
							<div field="createTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="100" headerAlign="center" >阅读时间</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<script type="text/javascript">
		mini.parse();
		
		var grid=mini.get("checkGrid");
		var url="${ctxPath}/bpm/core/bpmInstRead/readList.do?instId=${param.instId}" ;
		grid.setUrl(url);
		grid.load();
		
		grid.on('update',function(){
	    	_LoadUserInfo();
	    });
		
		function onReadDrawCells(e){
			 var field = e.field, value = e.value;		 
			 if(field=='state'){
				var obj={DRAFTED:"草稿",RUNNING:"运行中",SUCCESS_END:"运行完成"};
				e.cellHtml=obj[value];
	         }
		}
		</script>
        
    </body>
</html>