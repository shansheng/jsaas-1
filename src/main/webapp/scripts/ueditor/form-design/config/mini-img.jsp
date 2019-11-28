<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>图片上传-img</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="0" cellpadding="1">
					<tr>
						<td>字段备注<span class="star">*</span></td>
						<td>
							<input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100,chinese"  style="width:100%" emptytext="请输入字段备注"  onblur="getPinyin" />
						</td>
						<td>字段标识<span class="star">*</span></td>
						<td>
							<input id="name" name="name" class="mini-textbox" required="true" onvalidation="onEnglishAndNumberValidation"/>
						</td>
					</tr>
					
					<tr>
						<td>字符长度<span class="star">*</span></td>
						<td >
							<input id="length" class="mini-textbox" value="80" name="length" required="true" vtype="maxLength:20"  style="width:60px" emptytext="输入长度"   />
						</td>
						<td>类　型<span class="star">*</span></td>
						<td>
							<div id="imgtype" name="imgtype" class="mini-radiobuttonlist"  value="upload"
								textField="text" valueField="id" data="[{id:'upload',text:'上传'},{id:'url',text:'图片URL'}]"></div>
						</td>
					</tr>

					<tr>
						<td class="form-table-th">图片长</td>
						<td colspan="3" class="form-table-td">

							长：<input id="mwidth" name="mwidth" class="mini-spinner"
								   style="width: 80px" value="0" minValue="0" maxValue="1200" />
							<input id="wunit" name="wunit" class="mini-combobox" style="width: 50px"
								   onvaluechanged="changeMinMaxWidth"
								   data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]"
								   textField="text" valueField="id" value="%" required="true" allowInput="false" />

							高：<input id="mheight" name="mheight" class="mini-spinner" style="width: 80px"
												 value="0" minValue="0" maxValue="1200" />
							<input id="hunit" name="hunit" class="mini-combobox"
								   style="width: 50px"
								   onvaluechanged="changeMinMaxHeight"
								   data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]"
								   textField="text" valueField="id" value="%" required="true" allowInput="false" />

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
		thePlugins = 'mini-img';
		
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
		    	//initData(data);
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
		            oNode = createElement('img',name);
		            oNode.setAttribute('class','mini-img rxc');
		            oNode.setAttribute('src','${ctxPath}/styles/images/upPic.png');
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
		    
		  	//更新控件Attributes
	        /* var style="";
            if(formData.mwidth!=0){
            	style+="width:"+formData.mwidth+formData.wunit;
            }
            if(formData.mheight!=0){
            	if(style!=""){
            		style+=";";
            	}
            	style+="height:"+formData.mheight+formData.hunit;
            }
            oNode.setAttribute('style',style); */
		  	
		    for(var key in formData){
            	oNode.setAttribute(key,formData[key]);
            }
   
            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
            	
		};
	
	</script>
</body>
</html>
