<%-- 
    Document   : [自定义查询]编辑页
    Created on : 2017-02-21 15:32:09
    Author     : cjx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义查询]预览</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.css" />
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/json-viewer/jquery.json-viewer.js"></script>
<style type="text/css">
	.search-ui::after{
		clear:both;
		display: block;
		content:'' ;
	}
	.search-ui li{
		float:left;
	}
</style>
</head>
<body>
<body>
    
	<input id="pkId" name="id" class="mini-hidden" value="${query.id}" />
	<input id="alias" name="alias" class="mini-hidden" value="${query.alias}" />
	<div class="mini-toolbar">
		
			<form id="form1" class="search-form">
					<ul class="search-ui">
						<li>
						<c:forEach items="${conditions}" var="col">
							<c:choose>
								<c:when test="${col.typeOperate=='tetween'}">
									<span class="text">${col.name}：</span><input name="${col.name}_start" class="mini-textbox" /> 到<input name="${col.name}_end" class="mini-textbox" />
								</c:when>
								
								<c:otherwise>
									<span class="text">${col.name}：</span><input name="${col.name}" class="mini-textbox" />
								</c:otherwise>
							</c:choose>
						</c:forEach>
						</li>
						<li><a class="mini-button"   plain="true" onclick="doCustomQuery()">查询</a>
						<li><a class="mini-button"	  plain="true" onclick="clearQuery()">清空查询</a></li>
					</ul>
				</form>
		</div>
		<div class="mini-fit">
			返回JSON数据:
			<div style="width:100%;height:520px;background:#fff;border: 1px solid #eee;">
				<div id="jsonview" style="height:500px; width: 100%;overflow: auto"></div>
			</div>
		</div>
	<script type="text/javascript">
		mini.parse();
		
		var conditions=${conditions};
		var alias='${query.alias}';
		
		function getParams(){
			var params={};
			for(var i=0;i<conditions.length;i++){
				var o=conditions[i];
				var name=o.name;
				if(o.typeOperate=="between"){
					var start=mini.getByName(name +"_start").getValue();
					var end=mini.getByName(name +"_end").getValue();
					params[name] =start +"|" + end;
				}
				else{
					var val=mini.getByName(name ).getValue();
					params[name] =val;
				}
			}
			return params;
		}
		
		function doCustomQuery(){
			var params=getParams();
			doQueryEs(alias, params,function(rtn){
				$("#jsonview").jsonViewer(rtn.data);
			});
		}
		
		function clearQuery(){
			var frm = new mini.Form("#form1");
			var data=frm.getData();
			for(var key in data){
				data[key]="";
			}
			frm.setData(data);
			$("#jsonview").jsonViewer("");
		}
		
	</script>
</body>
</html>