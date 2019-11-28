<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>隐藏域-mini-hidden</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="0" cellpadding="1">
					<tr>
						<td>
							字段备注<span class="star">*</span>
						</td>
						<td>
							<input 
								id="label" 
								class="mini-textbox" 
								name="label" 
								required="true" 
								vtype="maxLength:100,chinese"  
								style="width:100%"
								emptytext="请输入字段备注" 
								onblur="getPinyin" 
							/>
						</td>
						<td>
							<span class="starBox">
								字段标识<span class="star">*</span>
							</span>
						</td>
						<td>
							<input id="name" name="name" class="mini-textbox" required="true" onvalidation="onEnglishAndNumberValidation"/>
						</td>
					</tr>
					<tr>
						<td>数据类型</td>
						<td>
							<input class="mini-combobox" name="datatype"
								   onvaluechanged="changeDataType"
								   value="varchar" data="[{'id':'varchar',text:'字符串'},{'id':'number',text:'数字'}]" style="width: 100%;"/>
						</td>
						<td>长　　度</td>
						<td>
							<span id="spanLength">
								<input  id="length" class="mini-spinner" name="length" maxValue="4000" minValue="1" value="50" style="width:80px">
							</span>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="spanDecimal" style="display:none;">
								精度
								<input id="decimal"  class="mini-spinner" name="decimal" minValue="0" maxValue="8" value="0" style="width:80px">
							</span>
						</td>
					</tr>
					<tr>
						<td>
							默  认  值
						</td>
						<td colspan="3">
							<input class="mini-textbox" name="value" style="width:100%"/>
						</td>
					</tr>
					<tr>
						<td>
							初始值来自脚本
						</td>
						<td colspan="3">
							<textarea class="mini-textarea" name="intscriptvalue" style="width:100%;height:100px;"></textarea>
						</td>
					</tr>
				</table>
			</form>
	</div>
	<script type="text/javascript">
		
	
		function createElement(type, name){     
		    var element = null;     
		    try {        
		        element = document.createElement('<'+type+' name="'+name+'" type="checkbox">');     
		    } catch (e) {}   
		    if(element==null) {     
		        element = document.createElement(type);     
		        element.name = name;     
		    } 
		    return element;     
		}
		
		mini.parse();
		var form=new mini.Form('miniForm');
		//编辑的控件的值
		var oNode = null,
		thePlugins = 'mini-hidden';
		var pluginLabel="${fn:trim(param['titleName'])}";
		window.onload = function() {
			//若控件已经存在，则设置回调其值
		    if( UE.plugins[thePlugins].editdom ){
		        //
		    	oNode = UE.plugins[thePlugins].editdom;
		        //获得字段名称
		        var formData={};
		        var attrs=oNode.attributes;
		        
		        for(var i=0;i<attrs.length;i++){
		        	formData[attrs[i].name]=attrs[i].value;
		        }
		        
		        form.setData(formData);
		    }
		    else{
		    	var ary=[{key:"datatype",value:"varchar"},{key:"length",value:"50"}];
		    	initPluginSetting(ary);
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
		    //控件尚未存在，则创建新的控件，否则进行更新
		    if( !oNode ) {
		        try {
		            oNode = createElement('input',name);
		            oNode.setAttribute('class','mini-hidden rxc');
		            //需要设置该属性，否则没有办法其编辑及删除的弹出菜单
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
            	oNode.setAttribute(key,formData[key]);
            }
		    
   
            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
            	
		};
		
		function changeDataType(e){
			handlerDecimalVal(e.value);
			handlerDefaultVal(e.value);
		}
		
	</script>
</body>
</html>
