
<%-- 
    Document   : [班次类型]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[班次类型]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[班次类型]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsShiftType.code}
						</td>
						<td>名称：</td>
						<td>
							${atsShiftType.name}
						</td>
					</tr>
					<tr>
						<td>是否系统预置：</td>
						<td>
							${atsShiftType.isSys==1?'是':'否'}
						</td>
						<td>状态：</td>
						<td>
							${atsShiftType.status==1?'启用':'禁用'}
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							${atsShiftType.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsShiftType" 
        entityName="com.redxun.oa.ats.entity.AtsShiftType"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsShiftType.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsShiftType/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>