
<%-- 
    Document   : [BPM_REG_LIB]明细页
    Created on : 2018-12-25 15:49:05
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[BPM_REG_LIB]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[BPM_REG_LIB]基本信息</caption>
					<tr>
						<th>用户ID，为0代表公共的：</th>
						<td>
							${bpmRegLib.userId}
						</td>
					</tr>
					<tr>
						<th>正则表达式：</th>
						<td>
							${bpmRegLib.regText}
						</td>
					</tr>
					<tr>
						<th>TENANT_ID_：</th>
						<td>
							${bpmRegLib.tenantId}
						</td>
					</tr>
					<tr>
						<th>CREATE_BY_：</th>
						<td>
							${bpmRegLib.createBy}
						</td>
					</tr>
					<tr>
						<th>CREATE_TIME_：</th>
						<td>
							${bpmRegLib.createTime}
						</td>
					</tr>
					<tr>
						<th>UPDATE_BY_：</th>
						<td>
							${bpmRegLib.updateBy}
						</td>
					</tr>
					<tr>
						<th>UPDATE_TIME_：</th>
						<td>
							${bpmRegLib.updateTime}
						</td>
					</tr>
					<tr>
						<th>名称：</th>
						<td>
							${bpmRegLib.name}
						</td>
					</tr>
					<tr>
						<th>类型，0为校验正则，1为替换正则：</th>
						<td>
							${bpmRegLib.type}
						</td>
					</tr>
					<tr>
						<th>别名：</th>
						<td>
							${bpmRegLib.key}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="bpm/core/bpmRegLib" 
        entityName="com.redxun.bpm.core.entity.BpmRegLib"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${bpmRegLib.regId}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/bpm/core/bpmRegLib/getJson.do",
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