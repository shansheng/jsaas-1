<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>[系统自定义业务管理列表]编辑2</title>
		<%@include file="/commons/edit.jsp"%>
		<script type="text/javascript" src="${ctxPath}/scripts/sys/customform/sysCustom.js"></script>
		<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
		<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
		<script src="${ctxPath}/scripts/codemirror/mode/javascript/javascript.js"></script>
		<script src="${ctxPath}/scripts/share/dialog.js" type="text/javascript"></script>
		<style type="text/css">
			.mini-panel-border .mini-grid-row:last-of-type .mini-grid-cell{
				border-bottom: 1px solid #ececec;
			}
			
			.mini-panel-border{
				border: none;
			}
			
			.mini-grid-row{
				background: #fff;
			}
			
			.mini-grid-row-alt{
				background: #f7f7f7
			}
			
			#center{
				border-top: none;
			}
			
			#center .mini-panel-border{
				width: 100%;
			}
		</style>
	</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button" iconCls="icon-prev"  plain="true" onclick="onPre">上一步</a>
			<a class="mini-button"   plain="true" onclick="onSaveConfigJson">保存</a>
			<a class="mini-button" iconCls="icon-start"  plain="true" onclick="onGenHtml">生成页面</a>
			<a class="mini-button" iconCls="icon-edit"  plain="true" onclick="onEditHtml">编辑页面代码</a>
     	</div>
	</div>
	<div class="mini-fit">
		<div id="tabEsSetting" class="mini-tabs" activeIndex="0" plain="false" style="width:100%;height:100%">
			<div title="返回字段" name="tabReturn">
						<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
							<a class="mini-button" iconCls="icon-setting" plain="true" onclick="reloadReturn()">重新加载</a> 
							<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="delRowGrid('gridRtnFields')">删除</a> 
							<span class="separator"></span>
							<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRowGrid('gridRtnFields')">向上</a> 
							<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRowGrid('gridRtnFields')">向下</a>
						</div>
						<div id="gridRtnFields" 
							class="mini-datagrid" 
							style="width: 100%;"
							showPager="false" 
							multiSelect="true"
							allowCellEdit="true" 
							allowCellSelect="true"
							allowAlternating="true">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div type="checkcolumn"></div>   
								<div field="name" width="120" headerAlign="center">
									字段名 
								</div>
								<div field="type" width="120" headerAlign="center">
									类型 
								</div>
							</div>
						</div>
					
					</div>
					<div title="条件字段" name="tabCondition">
						<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
							<a class="mini-button" iconCls="icon-setting" plain="true" onclick="addCondition()">新增</a> 
							<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="delRowGrid('gridWhere')">删除</a> 
							<span class="separator"></span>
							<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRowGrid('gridWhere')">向上</a> 
							<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRowGrid('gridWhere')">向下</a>
						</div>
						<div id="gridWhere" 
							class="mini-datagrid" 
							style="width: 100%;"
							showPager="false" 
							allowCellEdit="true" 
							multiSelect="true"
							allowCellSelect="true"
							oncellbeginedit="gridWhereCellBeginEdit"
							allowAlternating="true">
							<div property="columns">
								<div type="indexcolumn" width="40">序号</div>
								<div type="checkcolumn"></div>   
								<div field="name" width="120" headerAlign="center">字段
									<input property="editor" class="mini-combobox"
										valueField="name" textField="name" data="fieldAry"
										onvaluechanged="onFieldChanged"
										allowInput="true"
    									onvalidation="onComboValidation" 
										/>
								 </div>
								<div field="type" width="60" headerAlign="center">类型</div>
								<div name="typeOperate" 
									displayField="typeOperate_name"
									valueField="id" 
									textField="text" 
									field="typeOperate"
									vtype="required" 
									width="100" 
									align="center" 
									headerAlign="center">
									操作类型 
									<input property="editor" class="mini-combobox"
										valueField="id" textField="text" />
								</div>
								<div name="valueSource" 
									field="valueSource" 
									vtype="required"
									width="100" 
									renderer="onvalueSourceRenderer" 
									align="center"
									headerAlign="center" 
									editor="valueSourceEditor">
									值来源 
									<input property="editor" class="mini-combobox" data="valueSource" />
								</div>
								<div name="valueDef" field="valueDef" width="180" headerAlign="center">默认值</div>
							</div>
						</div>
					</div>
					<div title="排序字段"  name="tabSortField">
						<div class="mini-toolbar" style="padding: 2px; text-align: left; border-bottom: none;">
							<a class="mini-button" iconCls="icon-setting" plain="true" onclick="addSort()">新增</a> 
							<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="delRowGrid('gridOrder')">删除</a> 
							<span class="separator"></span>
							<a class="mini-button" iconCls="icon-up" plain="true" onclick="upRowGrid('gridOrder')">向上</a> 
							<a class="mini-button" iconCls="icon-down" plain="true" onclick="downRowGrid('gridOrder')">向下</a>
						</div>
						<div id="gridOrder" 
							class="mini-datagrid" 
							style="width: 100%;"
							showPager="false" 
							multiSelect="true"
							allowCellEdit="true" 
							allowCellSelect="true"
							allowAlternating="true">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div type="checkcolumn"></div>   
								<div field="name" width="120" headerAlign="center">
									字段名 
									<input property="editor" 
										class="mini-combobox"
										valueField="name" 
										textField="name" 
										data="sortFieldAry"
										allowInput="true"
    									onvalidation="onComboValidation" 
										/>
								</div>
								<div field="typeOrder" 
									vtype="required" 
									width="100"
									renderer="onTypeOrderRenderer" 
									align="center"
									headerAlign="center">
									排序类型 
									<input property="editor" class="mini-combobox" data="typeOrder" />
								</div>
							</div>
						</div>
					</div>
		</div>
	</div>
	<input class="mini-hidden" name="esTable" value="${sysEsList.esTable}"/>
	<div style="display: none;">
			<input id="valueDefTextBox" 
					class="mini-textbox" 
					style="width: 100%;"
					minWidth="120" /> 
			<input id="scriptEditor" 
					class="mini-buttonedit"
					onbuttonclick="getScript" 
					allowInput="false" 
					style="width: 100%;" />
			<input id="constantEditor" 
					class="mini-combobox"
					url="${ctxPath}/sys/core/public/getConstantItem.do" 
					valueField="key"
					textField="val" 
					style="width: 100%;" />
	</div>
	<script type="text/javascript">
		mini.parse();
		
		/**
		 * 索引字段。
		 */
		var fieldAry=[];
		var sortFieldAry=[];
        
		function onPre(){
			location.href=__rootPath+'/sys/core/sysEsList/edit.do?pkId=${param.id}';
		}
		
		
		function onSaveConfigJson(){
		    var data={id:"${sysEsList.id}"};
		    //返回字段
		    var rtnFields= mini.get("gridRtnFields").getData();
		    if(rtnFields.length>0){
			    _RemoveGridData(rtnFields);
			    data.returnFields=JSON.stringify(  rtnFields);
		    }
		    //条件字段
		    var condFields=mini.get("gridWhere").getData();
		    if(condFields.length>0){
			    _RemoveGridData(condFields);
			    data.conditionFields= JSON.stringify( condFields) ;
		    }
		    //条件字段
		    var sortFields=mini.get("gridOrder").getData();
		    if(sortFields.length>0){
		    	_RemoveGridData(sortFields);
		        data.sortFields=JSON.stringify( sortFields);
		    }
		    
		    var url=__rootPath +"/sys/core/sysEsList/save.do";
		    
			var config={
		    	url:url,
		    	method:'POST',
		    	postJson:true,
		    	data:data,
		    	success:function(result){
		    		//CloseWindow('ok');
		    	}
		    }
			_SubmitJson(config);
		}
		
		$(function(){
			initTab();
			initData();
		})
		
		function initData(){
			var json = {};
			json.returnFields = '${sysEsList.returnFields}';
			json.conditionFields = '${sysEsList.conditionFields}';
			json.sortFields = '${sysEsList.sortFields}';
			
			if(json.returnFields){
				var returnFields=eval("("+json.returnFields+")");
				mini.get("gridRtnFields").setData(returnFields);
			}
			if(json.conditionFields){
				var conditionFields=eval("("+json.conditionFields+")");
				mini.get("gridWhere").setData(conditionFields);
			}
			
			if(json.sortFields){
				var sortFields=eval("("+json.sortFields+")");
				mini.get("gridOrder").setData(sortFields);
			}
		}
		
		/**
		 * 条件下拉框处理。
		 * @param e
		 * @returns
		 */
		function gridWhereCellBeginEdit(e) {
			var field = e.field;
			var record = e.record;
			if (field == "typeOperate") {
				var type=getDataType(record.type);
				
				if (type == 'string') {
					e.editor.setData(strOpJson);
				} else if (type == 'number') {
					e.editor.setData(numOpJson);
				} else if (type == 'date') {
					e.editor.setData(dateOpJson);
				}
			} else if (field == 'valueDef') {
				if (record.valueSource == '' || !record.valueSource)
					e.cancel = true;
				else if (record.valueSource == 'param')
					e.cancel = true;
				else if (record.valueSource == 'script')
					e.editor = mini.get("scriptEditor");
				else if (record.valueSource == 'constantVar')
					e.editor = mini.get("constantEditor");
				else
					e.editor = mini.get("valueDefTextBox");
			}
			e.column.editor = e.editor;
			
		}
		
		function onComboValidation(e) {
		    var items = this.findItems(e.value);
		    if (!items || items.length == 0) {
		        e.isValid = false;
		        e.errorText = "输入值不在下拉数据中";
		    }
		}
		
		function onFieldChanged(e){
			  var grid=mini.get("gridWhere");
			  var item=e.sender.getSelected();
			  var row=grid.getEditorOwnerRow(e.sender);
			  grid.updateRow(row,{type:item.type})
		}
		
		var aryTxt={"text":true,"keyword":true};
		var aryNum={"long":true,"integer":true,"short":true,"double":true,"byte":true,"float":true,"half_float":true,"scaled_float":true};
		var aryDate={"date":true};
		
		/**
		 * 
		 * textword.
		 */
		var strOpJson=[
			{"id" : "=","text" : "等于"},
			{"id" : "like","text" : "like"}
		];

		/**
		 * 数字操作
		 */
		var numOpJson=[
			{"id" : "<","text" : "小于"},
			{"id" : "<=","text" : "小于等于"},
			{"id" : "=","text" : "等于"},
			{"id" : ">","text" : "大于"},
			{"id" : ">=","text" : "大于等于"},
			{"id" : "in","text" : "in"},
			{"id" : "between","text" : "between"},
		];

		/**
		 * 日期操作
		 */
		var dateOpJson=[
			{"id" : "<","text" : "小于"},
			{"id" : "<=","text" : "小于等于"},
			{"id" : "=","text" : "等于"},
			{"id" : ">","text" : "大于"},
			{"id" : ">=","text" : "大于等于"},
			{"id" : "between","text" : "between"},
		];
		/**
		 * 获取类型。
		 * @param type
		 * @returns
		 */
		function getDataType(type){
			if(aryTxt[type]) return "string";
			if(aryNum[type]) return "number";
			if(aryDate[type]) return "date";
		}
		
		/**
		 * 添加条件字段。
		 * @returns
		 */
		function addCondition(){
			var gridWhere=mini.get("gridWhere");
			gridWhere.addRow({});
		}
		
		/**
		 * 添加排序
		 * @returns
		 */
		function addSort(){
			var grid=mini.get("gridOrder");
			grid.addRow({});
		}
		
		/**
		 * 重新加载返回字段。
		 * @returns
		 */
		function reloadReturn(){
			initReturnJson(0);
			var grid=mini.get("gridRtnFields");
			grid.setData($.clone(fieldAry));
		}
		
		function initTab(){
			tabObject=mini.get("tabEsSetting");
			//选择索引
			tabObject.on("beforeactivechanged",function(e){
				var esTable=mini.getByName("esTable").getValue();
				if(!esTable){
					alert("请选择索引!");
					e.cancel=true;
				}
				else{
					initReturnJson(e.index);
				}
			});
		}
		
		function initReturnJson(idx){
			//加载字段
			loadFields(function(data){
				if(idx==0){
					var grid=mini.get("gridRtnFields");
					var orignData=grid.getData();
					if(orignData.length>0) return;
					var ary=[];
					for(var i=0;i<data.length;i++){
						var obj=data[i];
						if(!obj.keyword){
							ary.push(obj);
						}
					}
					grid.setData(ary);
				}
			});
		}
		
		/**
		 * 从索引中加载字段。
		 * @param callBack
		 * @returns
		 */
		function loadFields(callback){
			
			var url= __rootPath +"/sys/core/sysEsQuery/getMapping.do";
			var esTable=mini.getByName("esTable").getValue();
			var params={alias:esTable};
			$.post(url,params,function(rtn){
				fieldAry=rtn.data;
				sortFieldAry=$.clone(fieldAry);
				callback($.clone(fieldAry));
			})
		}
		
		function onGenHtml(){
        	mini.confirm("是否初始化页面", "生成页面", function(action){
        		if (action != "ok") return;
               	var id='${param.id}';
               	_SubmitJson({
       	        	url:__rootPath+'/sys/core/sysEsList/genHtml.do?id='+id,
       	    		success:function(){
       	    			_OpenWindow({
       	    				title:'生成的代码预览--${sysEsList.name}',
       	    				width:800,
       	    				height:450,
       	    				max:true,
       	    				url:__rootPath+'/sys/core/sysEsList/edit3.do?id='+id
       	    			});
       	    			
       	    		}
       	    	});
        	})
        }
        
        function onEditHtml(){
        	var id='${param.id}';
        	_OpenWindow({
        		title:'编辑页面代码',
        		url:__rootPath+'/sys/core/sysEsList/edit3.do?id='+id,
        		width:850,
        		height:400
        	});
        }
	</script>
</body>
</html>