<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
<title>用户选择框-mini-user</title>
<%@include file="/commons/mini.jsp"%>
</head>
<body>
	<div class="form-outer">
			<form id="miniForm">
				<table class="table-detail column-four" cellspacing="1" cellpadding="1">
					<tr>
						<td>字段备注<span class="star">*</span></td>
						<td>
							<input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100"  style="width:100%" emptytext="请输入字段备注" onblur="getPinyin" />
						</td>
						<td>字段标识<span class="star">*</span></td>
						<td>
							<input id="name" name="name" class="mini-textbox" required="true" onvalidation="onEnglishAndNumberValidation"/>
						</td>
					</tr>
					<tr>
						<td>字符长度<span class="star">*</span></td>
						<td>
							<input id="length" class="mini-textbox" value="50" name="length" required="true" vtype="maxLength:20"  style="width:60px" emptytext="输入长度"   />
						</td>
						<td>限定机构<span class="star">*</span></td>
						<td>
							<input id="refconfig" name="refconfig" class="mini-combobox" style="width:100%;" textField="text" valueField="id"
						        data="[{id:'specific',text:'指定机构'},{id:'level',text:'所选机构'}]" showNullItem="true" emptyText="当前机构"
						        onvaluechanged="configShow"
						        />
						    <div id="chkMainField" name="mainfield" onvaluechanged="mainChanged" 
								class="mini-checkbox"  text="主表字段" trueValue="yes" falseValue="no"></div>
						    <input id="grouplevel" name="dimlevel" class="mini-combobox" style="width:150px;"
						    textField="text" valueField="id"
						     showNullItem="true"/>
						        
						    <input id="groupid" 	name="dimid" class="mini-buttonedit icon-dep-button" textField="name" valueField="groupId" required="true"  allowInput="false" onbuttonclick="onSelParentInst"/>
						</td>
					</tr>
					<tr>
						<td>是否单选<span class="star">*</span></td>
						<td>
							<div class="mini-radiobuttonlist" repeatItems="5" repeatLayout="table" 
    						textField="text" valueField="id" value="true" id="single" name="single" data="[{id:'true',text:'是'},{id:'false',text:'否'}]"></div>
						</td>
						<td>必　填<span class="star">*</span></td>
						<td>
							<input class="mini-checkbox" name="required" id="required"/>是
						</td>
					</tr>
					<tr>
						<td>初始显示登录用户<span class="star">*</span></td>
						<td>
							<input class="mini-checkbox" name="initloginuser" id="initloginuser" value="true" trueValue="true" falseValue="false" />是
						</td>

						<td>指定用户范围</td>
						<td>
							指定用户组：
							<input id="orgConfig" name="orgconfig" class="mini-combobox" style="width:103.5px;" textField="text" valueField="id" 
						        data="[{id:'curOrg',text:'当前用户组'},{id:'selOrg',text:'指定用户组'}]" showNullItem="true" emptyText="无"
						        onvaluechanged="orgConfigShow"
						        />
						    <input id="orgId" name="groupid" class="mini-buttonedit icon-dep-button" style="width:140px;" textField="name" valueField="groupId" required="true"  allowInput="false" onbuttonclick="_DepDlgFromIds(e)"/><br/>
							<div style="padding: 6px 0;">
							<span id="dimShow">维度：<input class="mini-combobox"  id="initDim" textField="name" valueField="dimId" showNullItem="true" url="${ctxPath}/sys/org/osDimension/getAllDimansion.do" onvaluechanged="listRankLevel" emptyText="默认为全部人员"/></span><br/>
							</div>
							等级：<input class="mini-combobox"  id="initRankLevel" textField="name" valueField="level" showNullItem="true" onbeforeshowpopup="getLevelByDim"/>
							
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
						    value="%"  required="true" allowInput="false" />

						</td>
					</tr>
				</table>
			</form>
	</div>
	<script type="text/javascript">
		
		mini.parse();
		var form=new mini.Form('miniForm');
		//机构
		var grouplevel = mini.get('grouplevel');
		var groupid = mini.get('groupid');
		//用户组
		var orgId = mini.get('orgId');
		var dimShow = $("#dimShow");
		grouplevel.hide();
		groupid.hide();
		orgId.hide();
		//编辑的控件的值
		var oNode = null,
		thePlugins = 'mini-user';
		var pluginLabel="${param['titleName']}";
		/**
		* 判断当前字段是在子表还是主表。
		*/
		function isInMain(){
			var el=UE.plugins[thePlugins].editdom ;
			var elObj=$(el);
			var grid=elObj.closest(".rx-grid");
			var isMain=grid.length==0;
			return isMain;
		}
		
		function onSelParentInst(e){
		   	var btn=e.sender;
		   	_OpenWindow({
		   		title:'机构选择',
		   		height:450,
		   		width:780,
		   		url:__rootPath+'/sys/core/sysInst/dialog.do?single=true',
		   		ondestroy:function(action){
		   			if(action!='ok'){
		   				return;
		   			}
		   			
		   			var win=this.getIFrameEl().contentWindow;
					var data=win.getData();
					if(data.length==1){
						btn.setValue(data[0].instId);
						btn.setText(data[0].nameCn);
					}
		   		}
		   	});
		   }
		
		window.onload = function() {
			var isMain=isInMain(editor);
			var chkMainField=mini.get("chkMainField");
		    chkMainField.setVisible(!isMain);
			//若控件已经存在，则设置回调其值
		    if( UE.plugins[thePlugins].editdom ){
		        //
		    	oNode = UE.plugins[thePlugins].editdom;
		        //获得字段名称
		        var formData={};
		        var attrs=oNode.attributes;
		        for(var i=0;i<attrs.length;i++){
					if(attrs[i].name=='data-options'){
						var val=mini.decode(attrs[i].value);
						mini.get('initRankLevel').setValue(val.initRankLevel);
						mini.get('initRankLevel').setText(val.initRankLevelText);
						mini.get('initDim').setValue(val.initDim);
						mini.get('initDim').setText(val.initDimText);
					}else{
						formData[attrs[i].name]=attrs[i].value;
					}

		        }
		        
		        form.setData(formData);
		        if(isMain || (formData.mainfield=="yes")){
					var fields=getMainFields();
					if(!isMain){
						fields.splice(0, 0, {id: "ID_", text: "主键"});  
					}
					grouplevel.setData(fields);
				}
				else{
					var fields=getMetaData(editor);
					grouplevel.setData(fields);
				}
		        var refconfig = formData["refconfig"];
				if(refconfig=="specific"){
					groupid.setValue(formData["dimid"]);
		    		groupid.setText(formData["dimname"]);
					groupid.show();
		    	}
		    	if(refconfig=="level"){
		    		grouplevel.setValue(formData["dimlevel"]);
		    		grouplevel.show();
		    	}
		    	var orgconfig = formData["orgconfig"];
		    	if(orgconfig=="selOrg"){
		    		orgId.setValue(formData["groupid"]);
		    		orgId.setText(formData["orgname"]);
		    		orgId.show();
		    		dimShow.hide();
		    		mini.get('initDim').setValue(1);
		    	}else if(orgconfig=="curOrg"){
		    		dimShow.hide();
		    		mini.get('initDim').setValue(1);
		    	}else{
		    		dimShow.show();
		    	}
		    }
		    else{
		    	var data=_GetFormJson("miniForm");
		    	var array=getFormData(data);
		    	initPluginSetting(array);
		    	//设置字段
		    	setSqlParent(isMain);
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
		            oNode.setAttribute('class','mini-user rxc');
		            //需要设置该属性，否则没有办法其编辑及删除的弹出菜单
		            oNode.setAttribute('plugins',thePlugins);
		        }catch(e){
		        	alert('error');
		        	return;
		        }
	        }

			//初始维度
			var initDim = mini.get('initDim').getValue();
			var initDimText = mini.get('initDim').getText();

			//初始等级
			var initRankLevel = mini.get('initRankLevel').getValue();
			var initRankLevelText = mini.get('initRankLevel').getText();

			//加入data-option
			var dataOptions = {initRankLevel:initRankLevel,initRankLevelText:initRankLevelText,initDim:initDim,initDimText:initDimText};
			oNode.setAttribute('data-options',mini.encode(dataOptions));

	        
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
			oNode.setAttribute('initDim',initDim);
			oNode.setAttribute('initRankLevel',initRankLevel);
            oNode.setAttribute('style',style);
            oNode.setAttribute('allowinput','false');
            var refconfig = formData["refconfig"];
            if(refconfig=="specific"){
            	formData["dimName"]=groupid.getText();
            }
            var orgconfig = formData["orgconfig"];
            if(orgconfig=="selOrg"){
            	formData["orgName"]=orgId.getText();
            }
            for(var key in formData){
            	oNode.setAttribute(key,formData[key]);
            	if(key=="name"){
            		oNode.setAttribute("textName",formData[key] +"_name");
            	}
				if(key=="length" && formData[key] && formData[key]!=0){
					oNode.setAttribute("maxLength",formData[key]);
				}
            }
            //设置文本内容
	    	
    	 	if(isCreate){
	        	editor.execCommand('insertHtml',oNode.outerHTML);
	     	}else{
	        	delete UE.plugins[thePlugins].editdom;
	     	}
		};

		//列出维度下等级
		function listRankLevel(e){
			var url = __rootPath + "/sys/org/osRankType/listByDimId.do?dimId=" + e.sender.value;
			mini.get("initRankLevel").setUrl(url);
		}

		function getLevelByDim(e){
			var dim = mini.get("initDim").getValue();
			var url = __rootPath + "/sys/org/osRankType/listByDimId.do?dimId=" + dim;
			e.sender.setUrl(url);
		}
		
		function mainChanged(e){
			var val=e.sender.checked;
			setSqlParent(val);
		}
		
		/**
		* 返回主表字段
		*/
		function getMainFields(){
			var container=$(editor.getContent());
			var aryJson=[];
			var els=$("[plugins]:not(div.rx-grid [plugins])",container);
			
			els.each(function(){
				var obj= $(this);
				var label=obj.attr("label");
				var plugin=obj.attr("plugins");
				if(plugin=="rx-grid") return true;
				var name=obj.attr("name");
				var fieldObj={id: name, text: label};  
				aryJson.push(fieldObj);
			});
			
			return aryJson;
		}
		
		function setSqlParent(val){
			if(val){
				var data=getMainFields();
				data.splice(0, 0, {id: "ID_", text: "主键"});  
				grouplevel.setData(data);
			}
			else{
				var data=getMetaData(editor);
				grouplevel.setData(data);
			}
		}
		
		function getMetaData(editor){
			var el=UE.plugins[thePlugins].editdom ;
			var container=$(editor.getContent());
			var elObj=$(el);
			var grid=elObj.closest(".rx-grid");
			var isMain=grid.length==0;
			
			if(isMain){
				return getMainFields
			}
			var aryJson=[];
			var subWindow=elObj.closest("div.popup-window-d");
			var els;
			if(subWindow.length>0){
				els=$("[plugins]",subWindow);
			}
			else{
				els=$("[plugins]",grid);	
			}
			getJson(els,aryJson);
			return aryJson;
		}

		function configShow(e){			
			var levelValue = e.sender.getValue();
			//级别
			if('level'== levelValue){
				grouplevel.show();	
				groupid.hide();
				
			}else if('specific' == levelValue){		//指定部门	
				grouplevel.hide();
				groupid.show();
			}else{
				grouplevel.hide();
				groupid.hide();
				groupid.setValue('');
				grouplevel.setValue('');
			}

		}
		
		function orgConfigShow(e){			
			var levelValue = e.sender.getValue();
			//级别
			if("curOrg"==levelValue){
				dimShow.hide();	
				orgId.hide();
				mini.get('initDim').setValue(1);
			}else if("selOrg"==levelValue){
				orgId.show();
				dimShow.hide();
				mini.get('initDim').setValue(1);
			}else{
				dimShow.show();	
				orgId.hide();
			}
		}
	</script>
</body>
</html>
