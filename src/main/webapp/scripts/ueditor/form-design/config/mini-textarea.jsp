<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>多行文本框-mini-textarea</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="1" cellpadding="1">
					<tr>
						<td>字段备注<span class="star">*</span></td>
						<td>
							<input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100"  style="width:90%" emptytext="请输入字段备注" onblur="getPinyin" />
						</td>
						<td>字段标识<span class="star">*</span></td>
						<td>
							<input id="name" name="name" class="mini-textbox" required="true" onvalidation="onEnglishAndNumberValidation"/>
						</td>
					</tr>
					<tr>
						<td>数据类型</td>
						<td>
							<input class="mini-combobox"  name="datatype"  style="width:150px;" textField="text" valueField="id" onvaluechanged="changeDataType"
							data="[{id:'varchar',text:'字符串'},{id:'clob',text:'大文本'}]" value="varchar" showNullItem="true" allowInput="false"/> 
						</td>
						<td >数据长度</td>
						<td >
							<input id="length" name="length" class="mini-textbox"  value="200" vtype="max:4000"  style="width:60px" required="true"/>
						</td>
					</tr>
					<tr id="minNum_Tr">
						<td>数据最小长度</td>
						<td colspan="3">
							<input class="mini-textbox" id="minlen" name="minlen"  style="width:150px;"  vtype="max:4000"   value="0"   allowInput="true"/> 
						</td>
					</tr>
					<tr>
						<td>允许文本输入</td>
						<td>
							<input class="mini-checkbox" name="allowinput" id="allowinput" checked="checked" trueValue="true" falseValue="false" />是
						</td>
						<td>必　填<span class="star">*</span></td>
						<td>
							<input class="mini-checkbox" name="required" id="required"/>是
						</td>
						
					</tr>
					<tr>
						<td>
							默认值
						</td>
						<td>
							<input class="mini-textbox" name="value" style="width:90%"/>
						</td>
						<td>
							空文本提示
						</td>
						<td>
							<input class="mini-textbox" name="emptytext" style="width:90%"/>
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
						    value="px"  required="true" allowInput="false" />

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
		thePlugins = 'mini-textarea';
		var pluginLabel="${fn:trim(param['titleName'])}";
		
		window.onload = function() {
			//若控件已经存在，则设置回调其值
		    if( UE.plugins[thePlugins].editdom ){
		        //
		    	oNode = UE.plugins[thePlugins].editdom;debugger;
		        //获得字段名称
		        var formData={};
		        var attrs=oNode.attributes;
		        
		        for(var i=0;i<attrs.length;i++){
		        	formData[attrs[i].name]=attrs[i].value;
		        }
				formData["value"]=oNode.innerHTML;
		        form.setData(formData);

		        initData(formData);
		        
		    }
		    else{
		    	var data=_GetFormJson("miniForm");
		    	var array=getFormData(data);
		    	initPluginSetting(array);
		    }
		};
		
		function initData(data){
			var type=data.datatype;
			handDataType(type);
			
		}
		
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
		            oNode = createElement('textarea',name);
		            oNode.setAttribute('class','mini-textarea rxc');
		            //需要设置该属性，否则没有办法其编辑及删除的弹出菜单
		            oNode.setAttribute('plugins',thePlugins);
		        }catch(e){
		        	alert('error');
		        	return;
		        }
	        }
	        //更新控件Attributes
	        var style="";
            if(formData.mwidth!=0){
            	style+="width:"+formData.mwidth+formData.wunit+";";
            }
            if(formData.mheight!=0){
            	if(style!=""){
            		style+=";";
            	}
            	style+="height:"+formData.mheight+formData.hunit+";";
            }
            style+="line-height:25px;"
            oNode.setAttribute('style',style);
            for(var key in formData){
            	if(key == "value"){
            		continue;
				}
            	oNode.setAttribute(key,formData[key]);
            	if(key=="length" && formData[key] && formData[key]!=0){
					oNode.setAttribute("vtype",key+":"+formData[key]);
				}
            }
            oNode.innerHTML = formData["value"];
            //设置长度校验
            setLenValid(oNode,formData);
	    	
	    	 if(isCreate){
		        	editor.execCommand('insertHtml',oNode.outerHTML);
		     }else{
		        	delete UE.plugins[thePlugins].editdom;
		     }
		};
		
		/**
		* 数据类型改变
		*/
		function changeDataType(e){
			var val=e.sender.value;
			handDataType(val);
		}
		
		/**
		* 数据类型。
		*/
		function handDataType(val){
			var objLength=$("#length");
			var objMinNum=$("#minNum_Tr");
			switch(val){
				case "String":
					objLength.show();
					objMinNum.show();
					break;
				case "Clob":
					objLength.hide();
					objMinNum.hide();
					break;
			}
		}
		
		/**
		* 设置长度校验。
		*/
		function setLenValid(oNode,formData){
			var type=formData.datatype;
			if(type=="String"){
				if(formData.minlen!=0){
					oNode.setAttribute('vtype','minLength:'+formData.minlen);
				}
			}
		}
		
		
		
	</script>
</body>
</html>
