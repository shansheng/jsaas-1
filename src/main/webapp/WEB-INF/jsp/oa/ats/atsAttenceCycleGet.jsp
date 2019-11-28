
<%-- 
    Document   : [考勤周期]明细页
    Created on : 2018-03-23 14:36:39
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤周期]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[考勤周期]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsAttenceCycle.code}
						</td>
						<td>名称：</td>
						<td>
							${atsAttenceCycle.name}
						</td>
					</tr>
					<tr>
						<td>周期类型：</td>
						<td>
							${atsAttenceCycle.type==1?'自然月':'月(固定日期)'}
						</td>
						<td>是否默认：</td>
						<td>
							${atsAttenceCycle.isDefault==1?'是':'否'}
						</td>
					</tr>
					<tr>
						<td>年：</td>
						<td>
							${atsAttenceCycle.year}
						</td>
						<td>月：</td>
						<td>
							${atsAttenceCycle.month}
						</td>
					</tr>
					<tr>
						<td>周期区间-开始月：</td>
						<td>
							${atsAttenceCycle.startMonth}
						</td>
						<td>周期区间-开始日：</td>
						<td>
							${atsAttenceCycle.startDay}
						</td>
					</tr>
					<tr>
						<td>周期区间-结束月：</td>
						<td>
							${atsAttenceCycle.endMonth}
						</td>
						<td>周期区间-结束日：</td>
						<td>
							${atsAttenceCycle.endDay}
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							${atsAttenceCycle.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
    	
        <rx:detailScript baseUrl="oa/ats/atsAttenceCycle" 
        entityName="com.redxun.oa.ats.entity.AtsAttenceCycle"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		
		
		</script>
    </body>
</html>