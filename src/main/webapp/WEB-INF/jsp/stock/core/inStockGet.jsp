
<%-- 
    Document   : [入库单]明细页
    Created on : 2018-12-06 10:19:04
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[入库单]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[入库单]基本信息</caption>
					<tr>
						<th>单号：</th>
						<td>
							${inStock.no}
						</td>
					</tr>
					<tr>
						<th>金额：</th>
						<td>
							${inStock.total}
						</td>
					</tr>
					<tr>
						<th>描述：</th>
						<td>
							${inStock.descp}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${inStock.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${inStock.createTime}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${inStock.createBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${inStock.updatetimeTime}
						</td>
					</tr>
					<tr>
						<th>更新人：</th>
						<td>
							${inStock.updatetimeBy}
						</td>
					</tr>
				</table>
             </div>
    	</div>
    	<div id="grid_IN_STOCK_ITEM" class="mini-datagrid" allowResize="false"
				idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false"
				multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
			<div property="columns">
				<div field="itemId"   width="120" headerAlign="center" >ITEM_ID_</div>
				<div field="stockId"   width="120" headerAlign="center" >STOCK_ID_</div>
				<div field="pno"   width="120" headerAlign="center" >产品编码</div>
				<div field="amt"   width="120" headerAlign="center" >数量</div>
				<div field="PRICE"   width="120" headerAlign="center" >价格</div>
				<div field="subtotal"   width="120" headerAlign="center" >总数量</div>
				<div field="remark"   width="120" headerAlign="center" >备注</div>
				<div field="tenantId"   width="120" headerAlign="center" >租户ID</div>
				<div field="createTime"   width="120" headerAlign="center" >创建时间</div>
				<div field="createBy"   width="120" headerAlign="center" >创建人</div>
				<div field="updatetimeTime"   width="120" headerAlign="center" >更新时间</div>
				<div field="updatetimeBy"   width="120" headerAlign="center" >更新人</div>
			</div>
		</div>
        <rx:detailScript baseUrl="stock/core/inStock" 
        entityName="com.redxun.stock.core.entity.InStock"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var gridIN_STOCK_ITEM = mini.get("grid_IN_STOCK_ITEM");
		var form = new mini.Form("#form1");
		var pkId = '${inStock.stockId}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/stock/core/inStock/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
					gridIN_STOCK_ITEM.setData(json.inStockItems);
				}					
			});
		})
		</script>
	</div>
    </body>
</html>