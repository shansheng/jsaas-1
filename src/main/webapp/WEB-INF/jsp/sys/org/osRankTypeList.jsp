<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>维度等级自定义管理</title>
		<%@include file="/commons/list.jsp"%>
		<style>.shadowBox90 #datagrid1>.mini-panel-border{width: 100%;}</style>
    </head>
    <body>
    	 <div class="topToolBar">
             <div>
	             <a class="mini-button" plain="true"   onclick="addRankType()">增加等级</a>
                 <a class="mini-button" plain="true"  onclick="batchSave()">保存等级</a>
                 <a class="mini-button btn-red" plain="true"  onclick="batchDel()">删除等级</a>
             </div>
	  	</div>
<div class="mini-fit">
	<div class="form-container">
	            <div 
	            	id="datagrid1" 
	            	class="mini-datagrid" 
	            	style="width:100%;" 
	            	allowResize="false"
	                url="${ctxPath}/sys/org/osRankType/listByDimId.do?dimId=${osDimension.dimId}"  
	                idField="id" 
	                multiSelect="true" 
	                showColumnsMenu="true"
	                allowCellEdit="true" 
	                allowCellSelect="true" 
	                multiSelect="true" 
	                showPager="false" 
	                oncellvalidation="onCellValidation" 
	                oncellendedit="onCellEndEdit"
	                allowAlternating="true"
				>
	                <div property="columns">
	                    <div type="checkcolumn" width="20"></div>
	                    <div 
	                    	name="action" 
	                    	cellCls="actionIcons" 
	                    	width="80"
	                    	renderer="onActionRenderer" 
	                    	cellStyle="padding:0;"
	                   	>操作</div>
	                    <div field="name" width="120"  >名称
	                    	<input property="editor" class="mini-textbox" required="true" vtype="maxLength:255" />
	                    </div>    
	                    <div field="key" width="100"  >Key
	                    	<input property="editor" class="mini-textbox"  required="true" vtype="maxLength:64"/>
	                    </div>
	                    <div field="level" name="level" width="100"  >级别
	                    	 <input property="editor" class="mini-spinner"  minValue="0" maxValue="100" value="1" />
	                    </div>
	                </div>
	            </div>
	 </div>
	</div>
        <script type="text/javascript">
        	addBody();
        	mini.parse();
        	var grid=mini.get("#datagrid1");
        	grid.load();
        	var dimId='${osDimension.dimId}';
        	function onActionRenderer(e) {
	            var record = e.record;
	            var uid = record._uid;
	            var s = '<span title="保存" onclick="saveRow(\'' + uid + '\')">保存</span>'
	                    + ' <span  title="删除" onclick="delRow(\'' + uid + '\')">删除</span>';
	            return s;
	        }
        	
	        function addRankType(){
	        	  var newRow = { name: "新等级" };
	              grid.addRow(newRow, 0);
	              grid.beginEditCell(newRow, "新等级");
	              $(".listEmpty").remove();
	        }
	        
	        function onCellValidation(e){
	        	if(e.field=='key' && (!e.value||e.value=='')){
	        		 e.isValid = false;
	        		 e.errorText='Key不能为空！';
	        	}
	        	if(e.field=='name' && (!e.value||e.value=='')){
	        		e.isValid = false;
	       		 	e.errorText='名称不能为空！';
	        	}
	        }
	        
	        var count = 0;
	        function onCellEndEdit(e){
	        	var data = grid.getData();
	        	if(e.field=='level'){
	        		for(var i=0;i<data.length;i++){
			        	if(e.value==data[i].level){
			        		count++;
			        	}
		        	}
	        		if(count>1){
		        		e.row.level=null;
	        		}
	        	}
	        	count=0;
	        	grid.updateRow(e.row);
	        }
	        
	        function saveRow(uid){
	        	//表格检验
	        	grid.validate();
	        	if(!grid.isValid()){
	            	return;
	            }
	        	var row=grid.getRowByUID(uid);
	        	_SubmitJson({
	        		url:'${ctxPath}/sys/org/osRankType/saveRow.do',
	        		data:{
	        			dimId:dimId,
	        			data:mini.encode(row)},
	        		method:'POST',
	        		success:function(text){
	        			var result=mini.decode(text);
	        			row.id=result.data.id;
	        			grid.acceptRecord(row);
	        		}
	        	});
	        }
	        
	        function batchSave(){
	        	//表格检验
	        	grid.validate();
	        	if(!grid.isValid()){
	            	return;
	            }
	        	var data=grid.getData();
	        	_SubmitJson({
		        	url:'${ctxPath}/sys/org/osRankType/saveBatch.do',
	        		data:{dimId:dimId,data:mini.encode(data)},
	        		method:'POST',
	        		success:function(text){
	        			grid.load();
	        		}
	        	});
	        }
	        
	        function delRow(uid){
	        	var row=grid.getRowByUID(uid);
	        	if(row.id){
	        		_SubmitJson({
			        	url:'${ctxPath}/sys/org/osRankType/del.do',
		        		data:{ids:row.id},
		        		method:'POST',
		        		success:function(text){
		        			grid.load();
		        		}
		        	});	
	        	}else{
	        		batchDel();
	        	}
	        	
	        }
	        
	        function batchDel(){
	        	var rows=grid.getSelecteds();
	        	if(rows.length==0){
	        		alert("请选择要删除的行!");
	        		return;
	        	}
	        	var ids=[];
	        	for(var i=0;i<rows.length;i++){
	        		ids.push(rows[i].id);
	        	}
	        	_SubmitJson({
		        	url:'${ctxPath}/sys/org/osRankType/del.do',
	        		data:{ids:ids.join(',')},
	        		method:'POST',
	        		success:function(text){
	        			grid.load();
	        		}
	        	});
	        }
	        
        </script>
    </body>
</html>