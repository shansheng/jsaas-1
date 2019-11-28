
<%-- 
    Document   : [假期类型]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[假期类型]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[假期类型]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsHolidayType.code}
						</td>
						<td>名称：</td>
						<td>
							${atsHolidayType.name}
						</td>
					</tr>
					<tr>
						<td>是否系统预置：</td>
						<td>
							${atsHolidayType.isSys==1?'是':'否'}
						</td>
						<td>状态：</td>
						<td>
							${atsHolidayType.status==1?'启用':'禁用'}
						</td>
					</tr>
					<tr>
						<td>是否异常：</td>
						<td>
							${atsHolidayType.abnormity==0?'正常':'异常'}
						</td>
						<td>描述：</td>
						<td>
							${atsHolidayType.memo}
						</td>
					</tr>
					
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsHolidayType" 
        entityName="com.redxun.oa.ats.entity.AtsHolidayType"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsHolidayType.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsHolidayType/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>