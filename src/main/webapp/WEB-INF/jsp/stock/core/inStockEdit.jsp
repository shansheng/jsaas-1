<%-- 
    Document   : [入库单]编辑页
    Created on : 2018-12-06 10:19:04
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[入库单]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	
<div class="form-container">	
	
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${inStock.stockId}" />
				<table class="table-detail column_2" cellspacing="1" cellpadding="0">
					<caption>[入库单] 基本信息</caption>
			            <tr>
						<th>单号：</th>
						<td>
								<input name="no"  class="mini-textbox"  required="true" />
						</td>
					
						<th>金额：</th>
						<td>
								<input name="total"  class="mini-textbox"  required="true"/>
						</td>
						</tr>
			            <tr>
						<th>描述：</th>
						<td colspan="4">
								<textarea  name="descp"  class="mini-textarea"  style='width:100%'></textarea>
						</td>
						</tr>
				</table>
					<div class="mini-toolbar">
				    	<a class="mini-button"   plain="true" onclick="addIN_STOCK_ITEMRow">添加</a>
						<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="removeIN_STOCK_ITEMRow">删除</a>
					</div>
					<div id="grid_IN_STOCK_ITEM" class="mini-datagrid"  allowResize="false"
					idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false" 
					multiSelect="true" s allowAlternating="true" showPager="false" >
						<div property="columns">
							<div type="checkcolumn"></div>
							<div field="itemId"  headerAlign="center" >ITEM_ID_
								<input property="editor" class="mini-textbox" /></div>
							<div field="stockId"  headerAlign="center" >STOCK_ID_
								<input property="editor" class="mini-textbox" /></div>
							<div field="pno"  headerAlign="center" >产品编码
								<input property="editor" class="mini-textbox" /></div>
							<div field="amt"  headerAlign="center" >数量
								<input property="editor" class="mini-textbox" /></div>
							<div field="PRICE"  headerAlign="center" >价格
								<input property="editor" class="mini-textbox" /></div>
							<div field="subtotal"  headerAlign="center" >总数量
								<input property="editor" class="mini-textbox" /></div>
							<div field="remark"  headerAlign="center" >备注
								<input property="editor" class="mini-textbox" /></div>
						
					</div>
		</form>
	
	
</div>	
	<script type="text/javascript">
	mini.parse();
	var gridIN_STOCK_ITEM = mini.get("grid_IN_STOCK_ITEM");
	var form = new mini.Form("#form1");
	var pkId = '${inStock.stockId}';
	$(function(){
		initForm();
	})
	
	function isValid(){
		form.validate();
		return form.isValid();
	}
	
	function getData(){
		var data={};
		data.main=form.getData();
		var grid=mini.get('grid_IN_STOCK_ITEM');
		
		data.items=mini.encode(grid.getData());
		return data;
		
	}
	
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/stock/core/inStock/getJson.do";
		$.post(url,{ids:pkId},function(json){
			form.setData(json);
			gridIN_STOCK_ITEM.setData(json.inStockItems);
		});
	}
		
	function addIN_STOCK_ITEMRow(){
		var row = {};
		gridIN_STOCK_ITEM.addRow(row);
	}
	
	function removeIN_STOCK_ITEMRow(){
		var selecteds=gridIN_STOCK_ITEM.getSelecteds();
		gridIN_STOCK_ITEM.removeRows(selecteds);
	}
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
		data.inStockItems = removeData( gridIN_STOCK_ITEM.getData());
		var config={
        	url:"${ctxPath}/stock/core/inStock/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
		_SubmitJson(config);
	}	
	</script>
</body>
</html>