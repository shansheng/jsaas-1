
<%-- 
    Document   : [问题信息]明细页
    Created on : 2019-10-12 11:09:14
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[问题信息]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="form-container">
        <div id="form1" >
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[问题信息]基本信息</caption>
					<tr>
						<td>题目类型ID：</td>
						<td>
							${patrolQuestionInfo.questionType}
						</td>
					</tr>
					<tr>
						<td>题目类型：</td>
						<td>
							${patrolQuestionInfo.questionTypeName}
						</td>
					</tr>
					<tr>
						<td>题目内容：</td>
						<td>
							${patrolQuestionInfo.questionContent}
						</td>
					</tr>
					<tr>
						<td>问卷标识：</td>
						<td>
							${patrolQuestionInfo.refid}
						</td>
					</tr>
					<tr>
						<td>外键：</td>
						<td>
							${patrolQuestionInfo.refId}
						</td>
					</tr>
					<tr>
						<td>父ID：</td>
						<td>
							${patrolQuestionInfo.parentId}
						</td>
					</tr>
					<tr>
						<td>流程实例ID：</td>
						<td>
							${patrolQuestionInfo.instId}
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							${patrolQuestionInfo.instStatus}
						</td>
					</tr>
					<tr>
						<td>租户ID：</td>
						<td>
							${patrolQuestionInfo.tenantId}
						</td>
					</tr>
					<tr>
						<td>创建时间：</td>
						<td>
							${patrolQuestionInfo.createTime}
						</td>
					</tr>
					<tr>
						<td>创建人ID：</td>
						<td>
							${patrolQuestionInfo.createBy}
						</td>
					</tr>
					<tr>
						<td>更新人：</td>
						<td>
							${patrolQuestionInfo.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间：</td>
						<td>
							${patrolQuestionInfo.updateTime}
						</td>
					</tr>
					<tr>
						<td>组ID：</td>
						<td>
							${patrolQuestionInfo.groupId}
						</td>
					</tr>
					<tr>
						<td>题目序号：</td>
						<td>
							${patrolQuestionInfo.sequence}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="wxrepair/core/patrolQuestionInfo" 
        entityName="com.airdrop.wxrepair.core.entity.PatrolQuestionInfo"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${patrolQuestionInfo.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/wxrepair/core/patrolQuestionInfo/getJson.do",
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