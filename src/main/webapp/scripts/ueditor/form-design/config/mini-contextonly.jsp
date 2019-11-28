<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>wor预览控件</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="1" cellpadding="1">
					<tr>
						<td >
							<span class="starBox">
								字段备注<span class="star">*</span>
							</span>		
						</td>
						<td>
							<input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100,chinese"  style="width:90%" emptytext="请输入字段备注" onblur="getPinyin" />
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
						<td>
							上下文：<span class="star">*</span>
						</td>
						<td colspan="3">
							<input  name="constantItem" class="mini-combobox" showNullItem="true"
							url="${ctxPath }/sys/core/public/getConstantItem.do" valueField="key" textField="val" 
							style="width: 90%;"
							/>
						</td>
					</tr>
					<tr>
					</tr>
				</table>
			</form>
	</div>
	<script type="text/javascript">

		mini.parse();
		var form=new mini.Form('miniForm');
		//编辑的控件的值
		var oNode = null,
		thePlugins = 'mini-contextonly';
		var pluginLabel="${fn:trim(param['titleName'])}";
		var constantItem = mini.getByName("constantItem");
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
		        constantItem.setValue(formData["constantitem"]);
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
			if(!form.isValid()) return;
	        
	        var formData=form.getData();
	        var isCreate=false;
		    //控件尚未存在，则创建新的控件，否则进行更新
		    if( !oNode ) {
		        try {
		            oNode = createElement('span',name);
		            oNode.setAttribute('class','mini-contextonly rxc');
		            oNode.setAttribute('iconCls','icon-seq-no-18');
		            oNode.setAttribute('plugins','mini-contextonly');
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
		    var text = constantItem.getText();
		    var innerText = formData["constantItem"];
		    oNode.innerText=innerText.slice(0,innerText.length-1)+":"+text+"]";
            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
            	
		};
		
	</script>
</body>
</html>
