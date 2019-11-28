
<%-- 
    Document   : [INS_MSG_DEF]明细页
    Created on : 2017-09-01 10:40:15
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[INS_MSG_DEF]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
	<div class="mini-fit">
    <div class="form-container">
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                	<caption>[INS_MSG_DEF]基本信息</caption>
					<tr>
						<td>颜　色</td>
						<td>
							${insMsgDef.color}
						</td>
					</tr>
					<tr>
						<td>更多URl</td>
						<td>
							${insMsgDef.url}
						</td>
					</tr>
					<tr>
						<td>图　标</td>
						<td>
							${insMsgDef.icon}
						</td>
					</tr>
					<tr>
						<td>文　字</td>
						<td>
							${insMsgDef.content}
						</td>
					</tr>
					<tr>
						<td>租用机构ID</td>
						<td>
							${insMsgDef.tenantId}
						</td>
					</tr>
					<tr>
						<td>创建人ID</td>
						<td>
							${insMsgDef.createBy}
						</td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td>
							${insMsgDef.createTime}
						</td>
					</tr>
					<tr>
						<td>更新人ID</td>
						<td>
							${insMsgDef.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间</td>
						<td>
							${insMsgDef.updateTime}
						</td>
					</tr>
					<tr>
						<td>数据库名字</td>
						<td>
							${insMsgDef.dsName}
						</td>
					</tr>
					<tr>
						<td>数据库id</td>
						<td>
							${insMsgDef.dsAlias}
						</td>
					</tr>
					<tr>
						<td>SQL语句</td>
						<td>
							${insMsgDef.sqlFunc}
						</td>
					</tr>
					<tr>
						<td>TYPE_</td>
						<td>
							${insMsgDef.type}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/info/insMsgDef" 
        entityName="com.redxun.oa.info.entity.InsMsgDef"
        formId="form1"/>
        </div>
	</div>
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = ${insMsgDef.msgId};
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/info/insMsgDef/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>