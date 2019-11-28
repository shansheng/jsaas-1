
<%-- 
    Document   : [取卡规则]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[取卡规则]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
	<div class="topToolBar">
		<div>
			<rx:toolbar toolbarId="toolbar1"/>
		</div>
	</div>
        <div class="mini-fit">
			<div id="form1" class="form-container">
				<div style="padding:5px;">
					<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
						<caption>[取卡规则]基本信息</caption>
						<tr>
							<td>编码：</td>
							<td>
								${atsCardRule.code}
							</td>
							<td>名称：</td>
							<td>
								${atsCardRule.name}
							</td>
						</tr>
						<tr>

						</tr>
						<tr>
							<td>上班取卡提前(小时)：</td>
							<td>
								${atsCardRule.startNum}
							</td>
							<td>下班取卡延后(小时)：</td>
							<td>
								${atsCardRule.endNum}
							</td>
						</tr>
						<tr>

						</tr>
						<tr>
							<td>最短取卡间隔(分钟）：</td>
							<td>
								${atsCardRule.timeInterval}
							</td>
							<td>适用段次：</td>
							<td>
								${atsCardRule.segmentNum==1?'一段':atsCardRule.segmentNum==2?'二段':'三段'}
							</td>
						</tr>
						<tr>
							<td>是否默认：</td>
							<td colspan="3">
								${atsCardRule.isDefault==1?'是':'否'}
							</td>
						</tr>
						<tr>
							<td>第一次上班取卡范围开始时数：</td>
							<td>
								${atsCardRule.segBefFirStartNum}
							</td>
							<td>第一次上班取卡范围结束时数：</td>
							<td>
								${atsCardRule.segBefFirEndNum}
							</td>
						</tr>
						<tr>
							<td>第一次上班取卡方式：</td>
							<td>
								${atsCardRule.segBefFirTakeCardType==1?'该段最早卡':'该段最晚卡'}
							</td>
							<td>第一次下班取卡范围开始时数：</td>
							<td>
								${atsCardRule.segAftFirStartNum}
							</td>
						</tr>
						<tr>
							<td>第一次下班取卡范围结束时数：</td>
							<td>
								${atsCardRule.segAftFirEndNum}
							</td>
							<td>第一次下班取卡方式：</td>
							<td>
								${atsCardRule.segAftFirTakeCardType==1?'该段最早卡':'该段最晚卡'}
							</td>
						</tr>
						<tr>
							<td>第二次上班取卡范围开始时数：</td>
							<td>
								${atsCardRule.segBefSecStartNum}
							</td>
							<td>第二次上班取卡范围结束时数：</td>
							<td>
								${atsCardRule.segBefSecEndNum}
							</td>
						</tr>
						<tr>
							<td>第二次上班取卡方式：</td>
							<td>
								${atsCardRule.segBefSecTakeCardType==1?'该段最早卡':'该段最晚卡'}
							</td>
							<td>第二次下班取卡范围开始时数：</td>
							<td>
								${atsCardRule.segAftSecStartNum}
							</td>
						</tr>
						<tr>
							<td>第二次下班取卡范围结束时数：</td>
							<td>
								${atsCardRule.segAftSecEndNum}
							</td>
							<td>第二次下班取卡方式：</td>
							<td>
								${atsCardRule.segAftSecTakeCardType==1?'该段最早卡':'该段最晚卡'}
							</td>
						</tr>
						<tr>
							<td>第一段间分配类型：</td>
							<td>
								${atsCardRule.segFirAssignType==1?'手工分配':'最近打卡点'}
							</td>
							<td>第一段间分配段次：</td>
							<td>
								${atsCardRule.segFirAssignSegment==1?'第一段下班':'第二段上班'}
							</td>
						</tr>
						<tr>
							<td>第二段间分配类型：</td>
							<td>
								${atsCardRule.segSecAssignType==1?'手工分配':'最近打卡点'}
							</td>
							<td>第二段间分配段次：</td>
							<td>
								${atsCardRule.segSecAssignSegment==1?'第一段下班':'第二段上班'}
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

        <rx:detailScript baseUrl="oa/ats/atsCardRule" 
        entityName="com.redxun.oa.ats.entity.AtsCardRule"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsCardRule.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsCardRule/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>