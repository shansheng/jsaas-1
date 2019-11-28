<%-- 
    Document   : [自定义查询]编辑页
    Created on : 2017-02-21 15:32:09
    Author     : cjx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[自定义查询]编辑</title>

<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${ctxPath}/scripts/share/dialog.js"></script>
	<style type="text/css">
		.padding2{
			padding-left: 2%;
		}
		.padding4{
			padding-left: 4%;
		}
		.padding6{
			padding-left: 6%;
		}
		.padding8{
			padding-left: 8%;
		}
	</style>

</head>
<body>
<div class="fitTop"></div>
	<div class="mini-fit">
	<div class="form-container" >
		<%--<input id="pkId" name="id" class="mini-hidden" value="${invokeScript.id}" />--%>
		<table class="table-detail column_2" cellspacing="1" cellpadding="0">

			<tr>
				<td>js引用文件地址</td>
				<td>该方法文件定义在scripts/share.js中</td>
			</tr>
			<tr>
				<td>方法使用</td>
				<td>
				<div>
					<div>
					<div style="color: red;">1.JS调用</div>
						<div class="padding2">在share.js 文件中定义了方法 invokeScript</div>
						<div class="padding2">方法说明如下：</div>
						<div class="padding4">invokeScript(alias,params,callBack)；</div>
						<div class="padding2">参数说明如下：</div>
						<div class="padding4">alias:定义脚本的别名</div>
						<div class="padding4">params: 从客户端提交的参数</div>
						<div class="padding4">callBack:回调方法，参数格式为:</div>
						<div class="padding6">{</div>
						<div class="padding8">success:true or false,</div>
						<div class="padding8">message:"提示信息",</div>
						<div class="padding8">data:"服务端脚本执行结果"</div>
						<div class="padding6">}</div>
						<div class="padding2">示例如下:</div>
						<div class="padding4">invokeScript("${name}","1",function(data){</div>
						<div class="padding4">}</div>
						<br />
					</div>
					<div>
						<div style="color: red;">2.http调用</div>
						<div class="padding2">url : /sys/core/sysInvokeScript/invoke/别名</div>
						<div class="padding2">method:POST</div>
						<div class="padding2">参数 ： params</div>
						<br />
					</div>
					<div>
						<div style="color: red;">3.服务端脚本写法</div>
						<div class="padding2">在服务端中获取从客户端传入的参数，需要通过 params 获取客户端提交的参数。</div>
						<div class="padding2">例如获取一个用户：</div>
						<div class="padding4">String userId=params;</div>
						<div class="padding4">OsUser user=osUserManager.get(userId);</div>
						<div class="padding4">return user;</div>
						<br />
					</div>
				</div>
				</td>
			</tr>
			<tr>
				<td>备　　注</td>
				<td>
					<div>如果是in操作的参数的格式,如:{"fieldName":"value1,value2"},</div>
					<div>between操作的参数格式,如{"fieldName":"value1|value2"}</div>
				</td>
			</tr>

		</table>
	</div>
	</div>
	<script type="text/javascript">
		addBody();
		mini.parse();
	</script>
</body>
</html>


