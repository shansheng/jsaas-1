
<%-- 
    Document   : [消息提醒]明细页
    Created on : 2018-04-28 16:03:20
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[消息提醒]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>

        <rx:toolbar toolbarId="toolbar1"/>

	<div class="mini-fit">
        <div id="form1" class="form-container">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                	<caption>[消息提醒]基本信息</caption>
					<tr>
						<td>主题：</td>
						<td>
							${oaRemindDef.subject}
						</td>
					</tr>
					<tr>
						<td>提醒需要连接到的地址：</td>
						<td>
							${oaRemindDef.url}
						</td>
					</tr>
					<tr>
						<td>设置类型(FUNC:方法,SQL:SQL,GROOVYSQL)：</td>
						<td>
							${oaRemindDef.type}
						</td>
					</tr>
					<tr>
						<td>SQL语句或方法：</td>
						<td>
							${oaRemindDef.setting}
						</td>
					</tr>
					<tr>
						<td>数据源别名：</td>
						<td>
							${oaRemindDef.dsalias}
						</td>
					</tr>
					<tr>
						<td>消息描述：</td>
						<td>
							${oaRemindDef.description}
						</td>
					</tr>
					<tr>
						<td>排序：</td>
						<td>
							${oaRemindDef.sn}
						</td>
					</tr>
					<tr>
						<td>是否有效1.有效0.无效：</td>
						<td>
							${oaRemindDef.enabled}
						</td>
					</tr>
					<tr>
						<td>创建人id：</td>
						<td>
							${oaRemindDef.createBy}
						</td>
					</tr>
					<tr>
						<td>创建时间：</td>
						<td>
							${oaRemindDef.createTime}
						</td>
					</tr>
					<tr>
						<td>租户ID：</td>
						<td>
							${oaRemindDef.tenantId}
						</td>
					</tr>
					<tr>
						<td>更新时间：</td>
						<td>
							${oaRemindDef.updateTime}
						</td>
					</tr>
					<tr>
						<td>更新人id：</td>
						<td>
							${oaRemindDef.updateBy}
						</td>
					</tr>
				</table>
             </div>
    	</div>
	</div>
        <rx:detailScript baseUrl="oa/info/oaRemindDef" 
        entityName="com.redxun.oa.info.entity.OaRemindDef"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${oaRemindDef.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/info/oaRemindDef/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>