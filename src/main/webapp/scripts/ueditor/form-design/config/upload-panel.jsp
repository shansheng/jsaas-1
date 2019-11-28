<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="com.redxun.core.util.AppBeanUtil"%>
<%@page import="com.redxun.saweb.config.upload.FileUploadConfig"%>
<%@page import="com.redxun.saweb.config.upload.FileExtCategory"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>上传控件-upload-panel</title>
<%@include file="/commons/mini.jsp"%>	
<%
	FileUploadConfig fileConfig= (FileUploadConfig)AppBeanUtil.getBean("fileUploadConfig");
	String fileExtCatMap=fileConfig.getFileExtGroupMapJson();
%> 	
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="1" cellpadding="1">
					<tr>
						<td>
							<span class="starBox">
								字段备注<span class="star">*</span>
							</span>	
						</td>
						<td>
							<input 
								id="label" 
								class="mini-textbox" 
								name="label" 
								required="true" 
								vtype="maxLength:100"  
								style="width:100%"
								emptytext="请输入字段备注" 
								onblur="getPinyin" 
							/>
						</td>
						<td>附  件  名</td>
						<td>
							<input 
								id="name" 
								name="name" 
								class="mini-textbox" 
								style="width:100%"
								valueField="id"   
								required="true"  
								onvalidation="onEnglishAndNumberValidation"
							/>
						</td>				
					</tr>
					<tr>
						<td>
							<span class="starBox">
								字符长度<span class="star">*</span>
							</span>	
						</td>
						<td >
							<input id="length" class="mini-textbox" value="2048" name="length" required="true" vtype="maxLength:20"  style="width:60px" emptytext="输入长度"   />
						</td>
						<td>上传 大小限制<span class="star">*</span></td>
						<td >
							<input 
								id="sizelimit" 
								class="mini-textbox" 
								value="50" 
								name="sizelimit" 
								required="true" 
								vtype="maxLength:20"  
								style="width:60px;" 
								emptytext="输入大小限制"   
							/>MB
						</td>
					</tr>
					<tr>
						<td>单一附件</td>
						<td colspan="3"><div class="mini-radiobuttonlist" repeatItems="5" repeatLayout="table" 
    						textField="text" valueField="id" value="false" name="isone" data="[{id:'true',text:'是'},{id:'false',text:'否'}]"></div>
						</td>
						
						<!-- <th >是否必填</th>
						<td ><div class="mini-radiobuttonlist" repeatItems="5" repeatLayout="table" 
    						textField="text" valueField="id"  value="false"  name="require"  data="[{id:'true',text:'是'},{id:'false',text:'否'}]"></div>
						</td> -->
					</tr>
					<tr>
						<td>上传类型</td>
						<td colspan="3">
							<div class="mini-CheckBoxList"  textField="text" valueField="id"  name="filetype" 
							data="<%=fileExtCatMap%>"></div>
						</td>
					</tr>
					<tr>
						<td>
							控  件  长
						</td>
						<td colspan="3">

							长：<input id="mwidth" name="mwidth" class="mini-spinner" style="width:80px" value="0" minValue="0" maxValue="1200"/>
							
							<input 
								id="wunit" 
								name="wunit" 
								class="mini-combobox" 
								style="width:50px" 
								onvaluechanged="changeMinMaxWidth"
								data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" 
								textField="text" 
								valueField="id"
						    	value="%"
						    	required="true" 
						    	allowInput="false" 
					    	/>

							宽：<input id="mheight" name="mheight" class="mini-spinner" style="width:80px" value="0" minValue="0" maxValue="1200"/>
							<input id="hunit" name="hunit" class="mini-combobox" style="width:50px" onvaluechanged="changeMinMaxHeight"
							data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
						    value="%"  required="true" allowInput="false" />

						</td>
					</tr>
				</table>
			</form>
			</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var form=new mini.Form('miniForm');
		//编辑的控件的值
		var oNode = null,
		thePlugins = 'upload-panel';
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
	        var isCreate=false;
	        var formData=form.getData();
	        //创新新控件
	        if( !oNode ) {
	        	isCreate=true;
		        try {
		            oNode = createElement('input',name);
		            oNode.setAttribute('class','upload-panel rxc');
		            //需要设置该属性，否则没有办法其编辑及删除的弹出菜单
		            oNode.setAttribute('plugins',thePlugins);
		        }catch(e){
		        	alert('出错，请联系管理员！');
		        	return;
		        }
	        }
	        //更新控件Attributes
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
            oNode.setAttribute('style',"width:auto;");
            oNode.setAttribute('allowupload','true');
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
