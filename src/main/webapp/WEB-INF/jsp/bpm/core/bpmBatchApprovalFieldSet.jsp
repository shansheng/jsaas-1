<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<title>列表字段设置</title>
<%@include file="/commons/list.jsp"%>
<style type="text/css">#center{background: transparent;}</style>
</head>
<body>
	<div id="layout1" class="mini-layout"  style="width:100%;height:100%;">
	 
	 	<div region="south" showSplit="false" showHeader="false" height="46"  showSplitIcon="false" >
			<div class="southBtn">
		   	  <a class="mini-button"    onclick="onOk()">确定</a>
		   	  <a class="mini-button btn-red"   onclick="onCancel()">取消</a>
			</div>
	 	</div>
	    <div  title="列表字段设置" region="center" showHeader="false" showCollapseButton="false" >
	    	<div class="mini-toolbar mini-toolbar-one">
				<div class="form-toolBox">
					<a class="mini-button btn-red" onclick="removeSelected">移除</a>
					<a class="mini-button"   onclick="reloadFields">重新加载</a>
				</div>
				<div id="divEnt" style="display:none;">
		    		选择实体:
		    		<input id="boEntity" 
		    			name="boEntity" 
		    			onvaluechaged="changeTable" 
		    			class="mini-combobox"  
		    			textField="comment" 
		    			valueField="tableName" 
	    			 	showNullItem="true"  />
		    	</div>
			</div>
	    	
			<div class="mini-fit">
				<div 
					id="datagrid1" 
					class="mini-datagrid" 
					style="width: 100%; height: 100%;" 
					allowResize="false" 
					idField="fieldId"
					showReloadButton="false"
					showColumnsMenu="true" 
					showPager="false"
					allowCellSelect="true" allowCellValid="true"
					allowAlternating="true" allowCellEdit="true"
					multiSelect="true"
				>
					<div property="columns">
						<div type="indexcolumn">序号</div>
						<div type="checkcolumn" ></div>    
						<div field="name" width="160" headerAlign="center" allowSort="true">字段名</div>
						<div field="comment" width="100" headerAlign="center">列名
							<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
						</div>
						<div field="sn" width="80" headerAlign="center">排序
							<input property="editor" changeOnMousewheel="false" class="mini-spinner"  minValue="1" maxValue="100000" required="true"/>
						</div>
					</div>
				</div>
			</div>
	    </div>
	</div>

	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<script type="text/javascript">
			mini.parse();
			var grid = mini.get("datagrid1");
			var solId="${solId}";
			var ents=[];
			//选择的表名
			var tableName="";
			var divEnt=$("#divEnt");
			var boEntity=mini.get("boEntity");
			var tableMap={};
			
			
			function changeTable(e){
				tableName=e.value;
				if(!tableName) return;
				var attrs=tableMap[tableName];
				grid.setData(attrs);
			}
			
			function removeSelected(){
				var rows=grid.getSelecteds();
				grid.removeRows(rows,true);
			}
			
			function reloadFields(e){
				loadEnts(function(ents,tableMap){
					if(tableName){
						var attrs=tableMap[tableName];
						grid.setData(attrs);
					}
					else{
						var ent=ents[0];
						grid.setData(ent.attrs);	
						tableName=ent.tableName;
					}
				})
			}
			
			/**
			 * [{
		     * 	comment:"",
		     * 	tableName:"",
		     * 	attrs:[{
		     * 		isShow:false,name:"",comment:"",sn:"1"
		     * 	}]
		     * }]
			*/
			function loadEnts(callBack){
				var url=__rootPath + "/bpm/core/bpmBatchApproval/getBoEnts.do?solId=" + solId;
				$.get(url,function(data){
					//tableName1:attrs
					var tableMap={}
					for(var i=0;i<data.length;i++){
						var o=data[i]; 
						tableMap[o.tableName]=o.attrs;
					}
					callBack(data,tableMap);
				})
			}
			
			/**
			* data
			* {
			*	tableName:"",
			*	attrs:[]
			*  }
			*/
			function setData(saved, data){
				
				if(saved || data.tableName){
					grid.setData(data.attrs);
					tableName=data.tableName;
					return;
				}	
				
				loadEnts(function(ents,tableMap){
					tableMap=tableMap;
					if(ents.length==1) {
						divEnt.hide();
					}
					else{
						divEnt.show();
						boEntity.setData(ents);
					}
					
					var ent=ents[0];
					grid.setData(ent.attrs);	
					tableName=ent.tableName;
				})
			}
			
			
		   	function getJsonData(){
		   		var obj={tableName:tableName};
				obj.attrs=grid.getSelecteds();
		   		return obj;
		   	}
		   	
		   	function onOk(){
		   		var rtn=getJsonData().attrs;
		   		if(rtn.length==0){
		   			alert("请选择字段!");
		   			return;
		   		}
				CloseWindow("ok");
			}
			
     </script>
</body>
</html>