<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>意见审批控件-mini-nodeopinion</title>
<%@include file="/commons/mini.jsp"%>
	<style>
		.mini-tabs-bodys{
			padding: 0;
		}
	</style>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="0" cellpadding="1">
					<tr>
						<td class="form-table-th">
							标　　题<span class="star">*</span>
						</td>
						<td class="form-table-td">
							<input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100"  style="width:90%" emptytext="请输入字段备注" onblur="getPinyin" />
						</td>
						<td class="form-table-th">ID</td>
						<td class="form-table-td"><input id="name" class="mini-textbox" name="name" required="true" vtype="maxLength:100,chinese" style="width: 80%" emptytext="请输入字段标识" /></td>
					</tr>
					<tr>
						<td>容器展现条件设置</td>
						<td colspan="3" style="padding:5px">
							<div class="form-toolBox">
						 		<a class="mini-button"  plain="true" onclick="addRowGrid1()">添加</a>
								<a class="mini-button btn-red"  plain="true" onclick="delRowGrid1()">删除</a>
							</div>
							<div id="fieldTab" class="mini-tabs" activeIndex="0"  style="width:100%;min-height:240px;">
							    <div title="跳转逻辑">
							        <div 
										id="fieldGrid_jump" 
										class="mini-datagrid" 
										style="width:100%;min-height:100px;" 
										height="200" 
										showPager="false"
										multiSelect="true" 
										allowCellEdit="true" 
										allowCellSelect="true"
										allowAlternating="true"
									>
									    <div property="columns">
									        <div type="indexcolumn" width="30">序号</div>
									        <div type="checkcolumn" width="20"></div>                 
									        <div field="name" width="120" headerAlign="center">字段
									         <input property="editor" class="mini-combobox" valuefield="name" data="fields" textfield="label" style="width:100%;" minWidth="120" />
									        </div> 
									        <div field="op" width="120" headerAlign="center">比较符
									        	<input property="editor" class="mini-combobox" style="width:100%;" data="[{id:'==',text:'等于'},{id:'include',text:'包含'},{id:'!=',text:'不等于'}]"/>
									        </div>     
									        <div field="value" width="120" headerAlign="center">值
									        	<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" />
									        </div>
									        <div field="logic" width="50" headerAlign="center">逻辑运算
									        	<input property="editor" class="mini-combobox" allowInput="true" data="[{id:'&&',text:'并且'},{id:'||',text:'或'}]" style="width:100%;" minWidth="120" />
									        </div>
									    </div>
									</div>
							    </div>
							    <div title="显示逻辑">
							        <div 
										id="fieldGrid_show" 
										class="mini-datagrid" 
										style="width:100%;min-height:100px;" 
										height="200" 
										showPager="false"
										multiSelect="true" 
										allowCellEdit="true" 
										allowCellSelect="true"
										allowAlternating="true"
									>
									    <div property="columns">
									        <div type="indexcolumn" width="30">序号</div>
									        <div type="checkcolumn" width="20"></div>                 
									        <div field="name" width="120" headerAlign="center">字段
									         <input property="editor" class="mini-combobox" valuefield="name" data="fields" textfield="label" style="width:100%;" minWidth="120" />
									        </div> 
									        <div field="op" width="120" headerAlign="center">比较符
									        	<input property="editor" class="mini-combobox" style="width:100%;" data="[{id:'==',text:'等于'},{id:'include',text:'包含'},{id:'!=',text:'不等于'}]"/>
									        </div>     
									        <div field="value" width="120" headerAlign="center">值
									        	<input property="editor" class="mini-textbox" style="width:100%;" minWidth="120" />
									        </div>
									        <div field="logic" width="50" headerAlign="center">逻辑运算
									        	<input property="editor" class="mini-combobox" allowInput="true" data="[{id:'&&',text:'并且'},{id:'||',text:'或'}]" style="width:100%;" minWidth="120" />
									        </div>     
									    </div>
									</div>
							    </div>
						    </div>
						</td>
					</tr>
					<tr>
						<td>
							控  件
						</td>
						<td colspan="3">

								长：<input id="mwidth" name="mwidth" class="mini-spinner" style="width:80px" value="0" minValue="0" maxValue="1200"/>
								<input id="wunit" name="wunit" class="mini-combobox" style="width:50px" onvaluechanged="changeMinMaxWidth"
								data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
								value="%"  required="true" allowInput="false" />

								高：<input id="mheight" name="mheight" class="mini-spinner" style="width:80px" value="0" minValue="0" maxValue="1200"/>
								<input id="hunit" name="hunit" class="mini-combobox" style="width:50px" onvaluechanged="changeMinMaxHeight"
								data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
								value="%"  required="true" allowInput="false" />

						</td>
					</tr>
				</table>
			</form>
	</div>
	<script type="text/javascript">
		var pre="div_";
		mini.parse();
		var grid_jump=mini.get('fieldGrid_jump');
		var grid_show=mini.get('fieldGrid_show');
		var form=new mini.Form('miniForm');
		var tabs = mini.get("fieldTab");
		//编辑的控件的值
		var oNode = null,
		thePlugins = 'mini-condition-div';
		var pluginLabel="${fn:trim(param['titleName'])}";
		function buildFields(){
			var html = editor.getContent();
        	var container=$(html);
        	var fs=[];
        	var els=$("[plugins]:not(div.rx-grid [plugins])",container);
    		els.each(function(){
    			var obj=$(this);
    			//排除子表。
    			var plugins=obj.attr("plugins");
    			if(plugins=="rx-grid") return true;
    			if(plugins=="mini-datepicker") return true;
    			if(plugins=="mini-month") return true;
    			if(plugins=="mini-time") return true;
    			if(plugins=="mini-ueditor") return true;
    			if(plugins=="mini-checkhilist") return true;
    			if(plugins=="upload-panel") return true;
    			if(plugins=="mini-img") return true;
    			if(plugins=="mini-relatedsolution") return true;
    			if(plugins=="mini-condition-div") return true;
    			var label=obj.attr("label");
    			var name=obj.attr("name");
    			if(!label || !name){
    				return true;
    			}
    			var fieldObj={name: name, label: label};   
    			fs.push(fieldObj);
    		});
    		return fs;
        }
		function getActiveGrid(){
			var tab = tabs.getActiveTab();
			if(tab.title=="显示逻辑"){
				return grid_show;
			}
			return grid_jump;
		}
		/**
		 * 添加行
		 * @param gridId
		 * @param row
		 */
		function addRowGrid1(){
			var grid = getActiveGrid();
			grid.addRow({});
		}
		/**
		 * 删除选择行
		 * @param gridId
		 */
		function delRowGrid1(){
			var grid = getActiveGrid();
			var selecteds=grid.getSelecteds();
			grid.removeRows(selecteds);
		}
		
		var fields=[];
		window.onload = function() {
			fields=buildFields();
			//若控件已经存在，则设置回调其值
			if( UE.plugins[thePlugins].editdom ){
		        //
		    	oNode = UE.plugins[thePlugins].editdom;
		        //获得字段名称
		        var formData={};
		        var attrs=oNode.attributes;
		        
		        for(var i=0;i<attrs.length;i++){
		        	var obj=attrs[i];
		        	var name=obj.name;
		        	if(name=="name"){
		        		formData[name]=obj.value.replace(pre,"");	
		        	}
		        	else{
		        		formData[name]=obj.value;
		        	}
		        }
		        form.setData(formData);
		        grid_jump.setData(mini.decode(formData.fieldjson_jump));
		        grid_show.setData(mini.decode(formData.fieldjson_show));
			}
		    else{
		    	var data=_GetFormJson("miniForm");
		    	var array=getFormData(data);
		    	initPluginSetting(array);
		    }
		};
		 
		//取消按钮
		dialog.oncancel = function () {
		    if( UE.plugins[thePlugins].editdom ) {
		        delete UE.plugins[thePlugins].editdom;
		    }
		};
		//确认
		dialog.onok = function (){
			form.validate();
	        if (form.isValid() == false) {
	            return false;
	        }
	        
	        var formData=form.getData();
	        var isCreate=false;
	        var fieldJson_jump=mini.encode(grid_jump.getData());
	        var fieldJson_show=mini.encode(grid_show.getData());
		    //控件尚未存在，则创建新的控件，否则进行更新
		    if( !oNode ) {
		        try {
		            oNode = createElement('div',name);
		            oNode.setAttribute('class','div-condition rxc');
		            oNode.setAttribute('plugins',thePlugins);
		            
		        } catch (e) {
		            try {
		                editor.execCommand('error');
		            } catch ( e ) {
		                alert('控件异常，请联系技术支持');
		            }
		            return false;
		        }
		        isCreate=true;
		    }
		  	
		    for(var key in formData){
		    	if(key=="name"){
		    		oNode.setAttribute(key,pre + formData[key]);	
		    		oNode.setAttribute("id",formData[key]);
		    	}
		    	else{
		    		oNode.setAttribute(key,formData[key]);	
		    	}
            }
		    oNode.setAttribute('fieldjson_jump',fieldJson_jump);
		    oNode.setAttribute('fieldjson_show',fieldJson_show);
		    var style="";
            if(formData.mwidth!=0){
            	style+="width:"+formData.mwidth+formData.wunit;
            }
            if(formData.mheight!=0){
            	if(style!=""){
            		style+=";";
            	}
            	style+="height:"+formData.mheight+formData.hunit;
            }
            oNode.setAttribute('style',style);
            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
		};
		
		
		
		
	</script>
</body>
</html>