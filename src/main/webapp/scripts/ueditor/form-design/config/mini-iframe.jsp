<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>offiice控件</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-two" cellspacing="1" cellpadding="1">
					<tr>
						<td>
							URL<span class="star">*</span>
						</td>
						<td>
							<input id="inputSrc" class="mini-textbox" name="src" required="true"    style="width:90%" emptytext="请输入Url"   />
						</td>
					</tr>
					<tr>
						<td>
							控  件  长
						</td>
						<td colspan="3">
							宽：<input id="mwidth" name="mwidth" class="mini-spinner" style="width:80px" value="100" minValue="0" maxValue="1200"/>
							<input id="wunit" name="wunit" class="mini-combobox" style="width:50px" onvaluechanged="changeMinMaxWidth"
							data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
						    value="%"  required="true" allowInput="false" />
							&nbsp;&nbsp;高：<input id="mheight" name="mheight" class="mini-spinner" style="width:80px" value="500" increment="5" minValue="0" maxValue="1200"/>px
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
		thePlugins = 'mini-iframe';
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
		            oNode.setAttribute('class','mini-iframe');
		            oNode.setAttribute('plugins','mini-iframe');
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
		
		    var style="";
            if(formData.mwidth!=0){
            	style+="width:"+formData.mwidth+formData.wunit;
            }
            if(formData.mheight!=0){
            	if(style!=""){
            		style+=";";
            	}
            	style+="height:"+formData.mheight+"px";
            }
            oNode.setAttribute('style',style);
            
            oNode.innerText=formData["src"];
           
            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
		};
	</script>
</body>
</html>
