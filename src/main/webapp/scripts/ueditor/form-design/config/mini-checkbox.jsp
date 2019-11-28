<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>复选框</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="0" cellpadding="1">
					<tr>
						<td>字段备注<span class="star">*</span></td>
						<td>
							<input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100,chinese"  style="width:90%" emptytext="请输入字段备注" onblur="getPinyin" />
						</td>
						<td>字段标识<span class="star">*</span></td>
						<td>
							<input id="name" name="name" class="mini-textbox" required="true" onvalidation="onEnglishAndNumberValidation"/>
							
						</td>
					</tr>
					<tr>
						<td>字符长度<span class="star">*</span></td>
						<td colspan="3">
							<input id="length" class="mini-textbox" value="20" name="length" required="true" vtype="maxLength:20"  style="width:60px" emptytext="输入长度"   />
						</td>
						
					</tr>
					<tr>
					
					<td>显示的值<span class="star">*</span></td>
						<td colspan="3">
							选中 <input id="trueVal" name="truevalue" class="mini-textbox"  value="是" required="true"  style="width:50px;" />
							不选中<input id="falseVal" name="falsevalue" class="mini-textbox"  value="否"  required="true" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<td>
							默认值
						</td>
						<td colspan="3">
							<div name="checked" class="mini-checkbox" checked="true" readOnly="false" text="是否选中" ></div>
						</td>
					</tr>
				</table>
			</form>
	</div>
	<script type="text/javascript">
	
		function createElement(type, name){
		    var element = null;
		    try {    
	 	       element = document.createElement('<lable><'+type+' name="'+name+'" type="checkbox"></lable>'); 
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
		thePlugins = 'mini-checkbox';
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
		    //控件尚未存在，则创建新的控件，否则进行更新
		    if( !oNode ) {
		        try {
		            oNode = createElement('input',name); 
		            oNode.setAttribute('class','mini-checkbox rxc');
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
            	if(key=="label"){
            		oNode.setAttribute("text",formData[key]); 
            	}
            }
		    
		    oNode.setAttribute("type","checkbox"); 
            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
            	
		};
		
		
		
	</script>
</body>
</html>
