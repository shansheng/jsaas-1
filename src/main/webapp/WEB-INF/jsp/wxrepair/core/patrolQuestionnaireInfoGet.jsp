
<%-- 
    Document   : [问卷信息]明细页
    Created on : 2019-10-16 10:18:37
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[问卷信息]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="form-container">
        <div id="form1" >
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[问卷信息]基本信息</caption>
					<tr>
						<td>问卷名称：</td>
						<td>
							${patrolQuestionnaireInfo.questionnaireName}
						</td>
					</tr>
					<tr>
						<td>问卷类型ID：</td>
						<td>
							${patrolQuestionnaireInfo.questionnaireType}
						</td>
					</tr>
					<tr>
						<td>问卷类型：</td>
						<td>
							${patrolQuestionnaireInfo.questionnaireTypeName}
						</td>
					</tr>
					<tr>
						<td>问卷主题：</td>
						<td>
							${patrolQuestionnaireInfo.questionnaireTheme}
						</td>
					</tr>
					<tr>
						<td>开始时间：</td>
						<td>
							${patrolQuestionnaireInfo.startdate}
						</td>
					</tr>
					<tr>
						<td>结束时间：</td>
						<td>
							${patrolQuestionnaireInfo.enddate}
						</td>
					</tr>
					<tr>
						<td>创建人：</td>
						<td>
							${patrolQuestionnaireInfo.creator}
						</td>
					</tr>
					<tr>
						<td>外键：</td>
						<td>
							${patrolQuestionnaireInfo.refId}
						</td>
					</tr>
					<tr>
						<td>父ID：</td>
						<td>
							${patrolQuestionnaireInfo.parentId}
						</td>
					</tr>
					<tr>
						<td>流程实例ID：</td>
						<td>
							${patrolQuestionnaireInfo.instId}
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							${patrolQuestionnaireInfo.instStatus}
						</td>
					</tr>
					<tr>
						<td>租户ID：</td>
						<td>
							${patrolQuestionnaireInfo.tenantId}
						</td>
					</tr>
					<tr>
						<td>创建时间：</td>
						<td>
							${patrolQuestionnaireInfo.createTime}
						</td>
					</tr>
					<tr>
						<td>创建人ID：</td>
						<td>
							${patrolQuestionnaireInfo.createBy}
						</td>
					</tr>
					<tr>
						<td>更新人：</td>
						<td>
							${patrolQuestionnaireInfo.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间：</td>
						<td>
							${patrolQuestionnaireInfo.updateTime}
						</td>
					</tr>
					<tr>
						<td>组ID：</td>
						<td>
							${patrolQuestionnaireInfo.groupId}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="wxrepair/core/patrolQuestionnaireInfo" 
        entityName="com.airdrop.wxrepair.core.entity.PatrolQuestionnaireInfo"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${patrolQuestionnaireInfo.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/wxrepair/core/patrolQuestionnaireInfo/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
	</div>
    </body>
</html>