<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>数字输入框-mini-spinner</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="1" cellpadding="1">
					<tr>
						<td>字段备注<span class="star">*</span></td>
						<td>
							<input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100,chinese"  style="width:100%" emptytext="请输入字段备注" onblur="getPinyin"  />
						</td>
						<td>字段标识<span class="star">*</span></td>
						<td>
							<input id="name" name="name" class="mini-textbox" required="true" onvalidation="onEnglishAndNumberValidation"/>
						</td>
					</tr>
					<tr>
						<td>最小值</td>
						<td>
							<input name="minvalue" class="mini-spinner" style="width:100%" value="1" minValue="-100000000000" maxValue="100000000000"/>
						</td>
						
						<td>最大值</td>
						<td>
							<input name="maxvalue" class="mini-spinner" style="width:100%" value="100" minValue="-100000000000" maxValue="100000000000" />
						</td>
					</tr>
					<tr>
						<td>增量值</td>
						<td>
							<input name="increment" class="mini-spinner" style="width:100%" value="1" />
						</td>
						<td>必　填<span class="star">*</span></td>
						<td>
							<input class="mini-checkbox" name="required" id="required"/>是
						</td>
					</tr>
					
					<tr id="fpattern-row">
						<td>格式串</td>
						<td colspan="3">
							<input id="fpattern" class="mini-textbox" name="format" vtype="maxLength:20" />
							如：¥#,0.00 或,###.##
						</td>
					</tr>
				
					<tr>
						<td>允许文本输入</td>
						<td>
							<input class="mini-checkbox" name="allowinput" id="allowinput"/>是
						</td>
						<td>
							默认值
						</td>
						<td>
							<input class="mini-spinner" name="value"  style="width:100%" miniValue="-100000000000" maxValue="100000000000"/>
						</td>
					</tr>
					<tr>
						<td>
							控件
						</td>
						<td colspan="3">

							长：<input id="mwidth" name="mwidth" class="mini-spinner" style="width:80px" value="0" minValue="0" maxValue="1200"/>
							<input id="wunit" name="wunit" class="mini-combobox" style="width:50px" onvaluechanged="changeMinMaxWidth"
							data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
						    value="%"  required="true" allowInput="false" />

							高：<input id="mheight" name="mheight" class="mini-spinner" style="width:80px" value="0" minValue="0" maxValue="1200"/>
							<input id="hunit" name="hunit" class="mini-combobox" style="width:50px" onvaluechanged="changeMinMaxHeight"
							data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
						    value="px"  required="true" allowInput="false" />

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
		thePlugins = 'mini-spinner';
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
		        
		        //将最大值框默认设置为最大值
		        if(!formData.maxvalue){
		        	formData.maxvalue=mini.getByName("maxvalue").maxValue;
		        }

		        form.setData(formData);
		        
		        //onFtypeChange();
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
		            oNode.setAttribute('class','mini-spinner rxc');
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
		    
		  	//设置校验规则
		    oNode.setAttribute('vtype','rangeLength:'+formData['minvalue']+','+formData['maxvalue']);
		    for(var key in formData){
            	oNode.setAttribute(key,formData[key]);
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
            oNode.setAttribute('style',style);
            
            oNode.setAttribute('datatype',"number");
            
            oNode.setAttribute('defaultValue', mini.getByName("value").getValue());
            oNode.setAttribute('allowNull', 'true');

            if(isCreate){
	            editor.execCommand('insertHtml',oNode.outerHTML);
            }else{
            	delete UE.plugins[thePlugins].editdom;
            }
            	
		};
	
	</script>
</body>
</html>
