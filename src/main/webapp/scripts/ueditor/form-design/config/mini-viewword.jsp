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
				<table class="table-detail column-two" cellspacing="1" cellpadding="1">
					<tr>
						<td>
							<span class="starBox">
								word模版<span class="star">*</span>
							</span>
						</td>
						<td>
							<input name="alias" textname="alias" class="mini-buttonedit" onbuttonclick="onButtonEdit"/>
						</td>
					</tr>
					<tr>
						<td>
							标题
						</td>
						<td >
							<input name="title" class="mini-textbox" value="打印"  />
						</td>
					</tr>
				</table>
			</form>
	</div>
	<script type="text/javascript">

		mini.parse();
		var form=new mini.Form('miniForm');
		//编辑的控件的值
		var oNode = null,
		thePlugins = 'mini-viewword';
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
			if(!form.isValid()) return;
	        
	        var formData=form.getData();
	        var isCreate=false;
		    //控件尚未存在，则创建新的控件，否则进行更新
		    if( !oNode ) {
		        try {
		            oNode = createElement('div',name);
		            oNode.setAttribute('class','mini-viewword');
		            oNode.setAttribute('iconCls','icon-word');
		            oNode.setAttribute('plugins','mini-viewword');
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
            
            oNode.innerText=formData["title"];
           
            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
            	
		};
		
		function onButtonEdit(e){
			var btn=e.sender;
			openWordTemplateDialog({single:"true",callback:function(data){
				btn.setValue(data[0].name);
				btn.setText(data[0].templateName);
				}
			});
		}
		
	</script>
</body>
</html>
