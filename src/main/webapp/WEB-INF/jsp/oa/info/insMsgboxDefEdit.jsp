
<%-- 
    Document   : [栏目消息盒子表]编辑页
    Created on : 2017-09-01 11:35:24
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[栏目消息盒子表]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toolbar1" pkId="insMsgboxDef.id" />
<div class="mini-fit">
<div class="form-container" >
	<div id="p1">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="boxId" class="mini-hidden" value="${insMsgboxDef.boxId}" />
				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					<caption>[栏目消息盒子表]基本信息</caption>
					<tr>
						<td>名字</td>
						<td>
							
								<input name="name" value="${insMsgboxDef.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>Key</td>
						<td>
							
								<input name="key" value="${insMsgboxDef.key}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>消息列表</td>
						<td>
							<div class="self-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
								<a class="mini-button" plain="true"	onclick="addRow()">增加</a>
								<a class="mini-button btn-red" plain="true" onclick="removeRow()">删除</a>
								<span class="separator"></span>
								<a class="mini-button" plain="true" onclick="upRow()">向上</a>
								<a class="mini-button" plain="true"	onclick="downRow()">向下</a>
							</div>

							<div id="grid" class="mini-datagrid"
								 style="width: 100%;min-height:100px"
								 allowResize="false"
								 url="${ctxPath}/oa/info/insMsgboxBoxDef/getByBoxId.do?boxId=${insMsgboxDef.boxId}"
								 idField="id"
								 allowCellEdit="true"
								 allowCellSelect="true"
								 multiSelect="true"
								 showColumnsMenu="true"
								 sizeList="[5,10,20,50,100,200,500]"
								 pageSize="20"
								 allowAlternating="true"
							>
							<div property="columns">
								<div type="checkcolumn" width="100"></div>
								<div field="sn"  sortField="SN_"  width="120"  allowSort="true">序号
									<input property="editor" class="mini-textbox" style="width:100%;" />
								</div>
								<div field="msgId" displayfield="content" sortField="MSG_ID_"  width="120"  allowSort="true">消息
									<input property="editor" class="mini-combobox"  textField="content" valueField="msgId" url="${ctxPath}/oa/info/insMsgDef/listData.do">
								</div>
							</div>
						</div>

						</td>
					</tr>				
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/info/insMsgboxDef"
		entityName="com.redxun.oa.info.entity.InsMsgboxDef" />
</div>
</div>
	<script type="text/javascript">
	addBody();
	function selfSaveData(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
	    var ary=grid.getData();
		var config={
        	url:"${ctxPath}/oa/info/insMsgboxDef/saveMsgEntity.do",
        	method:'POST',
        	data:{obj:mini.encode(data),data:mini.encode(ary)},
        	success:function(result){
        		//如果存在自定义的函数，则回调
        		if(isExitsFunction('successCallback')){
        			successCallback.call(this,result);
        			return;	
        		}
        		
        		CloseWindow('ok');
        	}
        }
	        
		_SubmitJson(config);
	}	
	
	mini.parse();
	var grid = mini.get("grid");
	grid.load();
	
	function addRow(){
		var index = grid.getData().length;
		grid.addRow({sn:index+1});
	}
	
	function removeRow(){
		var selecteds=grid.getSelecteds();
		if(selecteds.length>0 && confirm('确定要删除？')){
			grid.removeRows(selecteds);
		}
	}
	
	function upRow() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);
            grid.moveRow(row, index - 1);
        }
    }
    function downRow() {
        var row = grid.getSelected();
        if (row) {
            var index = grid.indexOf(row);
            grid.moveRow(row, index + 2);
        }
    }

	</script>
</body>
</html>