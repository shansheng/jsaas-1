<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="imgArea" uri="http://www.redxun.cn/imgAreaFun"%>
<!DOCTYPE html>
<html>
<head>
	<title>业务流程解决方案管理-流程定义处理</title>
	<%@include file="/commons/edit.jsp"%>
	<style type="text/css">
		body {
			background-color:white;
		}
	</style>
</head>
<body>
	<div class="form-toolBox" >
		<a class="mini-button"  onclick="editBpmDefDesign()">编辑流程定义</a>
	    <c:if test="${not empty bpmDef}">
        	<a class="mini-button"  onclick="showProcessProperties()" plain="true">流程属性配置</a>
           	<a class="mini-button" plain="true" onclick="showBpmDefInfo('${bpmDef.actDefId}')">
           		${bpmDef.subject}(${bpmDef.key})-当前版本(${bpmDef.version})
       		</a>

       		<a class="mini-button"  plain="true" onclick="showBpmDefInfo('${oldBpmDef.actDefId}')">
           		${oldBpmDef.subject}(${oldBpmDef.key})-启用版本(${oldBpmDef.version})
       		</a>
			<input id="sequence" name="sequence" onshowpopup="showpopup" class="mini-lookup" style="width: 200px;"
				   textField="subject" valueField="key"
				   popupWidth="auto"
				   popup="#gridPanel"
				   grid="#datagrid1" multiSelect="false"
				   value="" text="" emptyText="流程定义版本"
			/>
								<div id="gridPanel" class="mini-panel" title="header"
									 style="width: 700px; height: 280px;"
									 showToolbar="true" showCloseButton="true"
									 showHeader="false" bodyStyle="padding:0" borderStyle="border:0"
								>
									<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;"
										 borderStyle="border:0" showPageSize="false" showPageIndex="true"
										 url="${ctxPath}/bpm/core/bpmDef/listByMainDefId.do?mainDefId=${bpmDef.mainDefId}"
										 multiSelect="false" pageSize="15"
									>
										<div property="columns">
											<div type="checkcolumn" headerAlign="center" align="center" ></div>
											<div name="action" cellCls="actionIcons"
												 width="80" renderer="onActionRenderer1" cellStyle="padding:0;">操作</div>
											<div field="subject" sortField="SUBJECT_" width="160" headerAlign="center" allowSort="true">标题</div>
											<div field="key" sortField="KEY_" width="100" headerAlign="center" allowSort="true">标识Key</div>
											<div field="version" sortField="VERSION_" width="80" headerAlign="center" allowSort="true">版本号</div>
										</div>
									</div>
								</div>

       	</c:if>
       	<c:if test="${empty bpmDef}">
       	
								<input id="sequence" name="sequence" onshowpopup="showpopup" class="mini-lookup" style="width: 200px;" textField="subject" valueField="key" popupWidth="auto" popup="#gridPanel" grid="#datagrid1" multiSelect="false" value="" text="" emptyText="绑定流程设计"/>

								<div id="gridPanel" class="mini-panel" title="header"  style="width: 480px; height: 280px;" showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0">
									<div property="toolbar" style="padding: 5px; padding-left: 8px; text-align: center;">
										<div style="float: left; padding-bottom: 2px;">
											<span>标题：</span> <input id="keyText" class="mini-textbox" style="width: 160px;" onenter="onSearchClick" /> 
											<a class="mini-button"  onclick="onSearchClick">查询</a>
	                        				<a class="mini-button"  onclick="onClearClick">清空</a>
										</div>
										<div style="float: right; padding-bottom: 2px;">
										 <a class="mini-button btn-red"  plain="true" onclick="onCloseClick">关闭</a>
									</div>
										<div style="clear: both;"></div>
									</div>
									<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderStyle="border:0" showPageSize="false" showPageIndex="true" url="${ctxPath}/bpm/core/bpmDef/listForDialog.do" multiSelect="false" pageSize="15">
										<div property="columns">
											<div type="checkcolumn"></div>
											<div name="action" cellCls="actionIcons" width="35" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
											<div field="subject" sortField="SUBJECT_" width="160" headerAlign="center" allowSort="true">标题</div>
											<div field="key" sortField="KEY_" width="100" headerAlign="center" allowSort="true">标识Key</div>
											<div field="version" sortField="VERSION_" width="80" headerAlign="center" allowSort="true">版本号</div>
										</div>
									</div>
								</div>
			</c:if>
	</div>
	
	<div class="mini-fit" style="box-sizing: border-box;position: relative">
		<div style="box-sizing: border-box;background: #fff;padding-top:10px;padding-buttom:20px;" id="bpmImgContainer">
			<c:if test="${empty bpmDef}">
				<div style="margin:auto;text-align: center;position:absolute;height: 60px;top: 50%;margin-top: -30px;left: 50%;margin-left: -115px;width: 230px;">
					<span>
						<img src="${ctxPath}/styles/images/alert1.png" style="vertical-align: middle;width: 60px;"/>
					</span>
					<span style="padding-left: 5px;font-size:20px;color: red;display: inline-block;vertical-align: middle">请绑定流程定义！</span>
				</div>
			</c:if>
			<c:if test="${not empty bpmDef}">
				<div style="padding-left: 5px;clear:both;width:100%;box-sizing: border-box">提示：右击流程节点可进行属性配置</div>
				<img id="bpmImg" src="${ctxPath}/bpm/activiti/processImage.do?actDefId=${bpmDef.actDefId}" usemap="#imgHref"/>
				<imgArea:imgAreaScript actDefId="${bpmDef.actDefId}"></imgArea:imgAreaScript>
			</c:if>			
		</div>
	</div>
	
	<ul id="contextMenu" class="mini-contextmenu" >
		<li name="prop"   onclick="nodeSetting()">属性设置</li>
		<li name="usermenu" onclick="userSetting()">人员配置</li>
	</ul>
	
	<script type="text/javascript">
		
		var nodeId;
		var nodeType;
		var nodeName;
		var solId="${param['solId']}";
		var bpmDef = "${bpmDef}";
		if(!bpmDef){
			mini.parse();
		}
		
		$(function(){
			$("area").bind("mouseover",function(){
				  nodeId=$(this).attr("id");
				  nodeType=$(this).attr('type');
				  nodeName=$(this).attr('name');
			});
		});

		function handGridButtons(el){
			el=$(el);
			$(".actionIcons",el).each(function(i){
				var parentDiv=$(".mini-grid-cell-inner",$(this));
				var btns=parentDiv.children("span");
				var length=btns.length;
				parentDiv.find(".editBtnBox").eq(0).nextAll().remove();
				/*if(length<0) return true ;*/
				// 表格行间工具条；   --yangxin
				var editBtnBox = $("<div class='editBtnBox'></div>")
				var ops_btnOne = $("<span class='ops_btnOne'></span>")
				var manageBtn=$("<div class='ops_btn'>更多</div>");
				var btnContainer=$("<div class='buttonContainer'></div>");
				if(length > 2){
					for(var k = 0;k<length;k++){
						if (k < 2 ){
							var btnOne1 = btns[k];
							ops_btnOne.append(btnOne1);
						}else{
							var btn=btns[k];
							btnContainer.append(btn);
						}
					}
					editBtnBox.append(ops_btnOne);
					manageBtn.append(btnContainer);
					manageBtn.attr("title","");
					editBtnBox.append(manageBtn);
				}else if( length <= 1){
					ops_btnOne.addClass("iconOne");
					ops_btnOne.append(btns[0]);
					editBtnBox.empty();
					editBtnBox.append(ops_btnOne);
				} else {
					for (var i = 0 ;i< length ;i++){
						var btnOne2 = btns[i];
						ops_btnOne.append(btnOne2);
					}
					editBtnBox.empty();
					editBtnBox.append(ops_btnOne);
				}
				parentDiv.append(editBtnBox);
				btnContainer.hide();
				manageBtn.hoverDelay({hoverEvent:function(event){
						var _this = manageBtn;
						places(_this,event);
						manageBtn.addClass("ops_active");
						btnContainer.show();
					},
					outEvent:function(){
						manageBtn.removeClass("ops_active ops_location");
						btnContainer.hide();
					}
				});
			});
		}
		var grid1;
		function showpopup(e){
			grid1 = mini.get("datagrid1");
			grid1.on("update",function(e){
				handGridButtons(e.sender.el);
			});
		    grid1.load();
		}


		/*绑定菜单*/
		window.onload = function () {
             $("#imgHref").bind("contextmenu", function (e) {
                var menu = mini.get("contextMenu");
                var usermenu = mini.getByName("usermenu", menu);
                var formmenu=mini.getByName('formmenu',menu);
                if(nodeType=='userTask'){
   				 	usermenu.show();
   				 	//formmenu.show();
	   			 }else{
	   				usermenu.hide();
	   				//formmenu.hide();
	   			 }
                menu.showAtPos(e.pageX, e.pageY);
                return false;
            }); 
        }
		
		function onActionRenderer1(e) {
            var record = e.record;
            var actDefId = record.actDefId;
            var key = record.key;
            var s = '<span  title="切换" onclick="changeVersion(\'' + actDefId + '\')">切换</span>'+
            		'<span  title="启用" onclick="setMainRow(\'' + actDefId + '\',\''+key+'\')">启用</span>';
            return s;
    	} 
		
		function onActionRenderer(e) {
	            var record = e.record;
	            var actDefId = record.actDefId;
	            var key = record.key;
	            var s = '<span  title="启用" onclick="setMainRow(\'' + actDefId + '\',\''+key+'\')">启用</span>';
	            return s;
	    } 
		
		function getIframeByElement(element){
		    var iframe;
		    $("iframe", window.parent.document).each(function(){
		        if(element.ownerDocument === this.contentWindow.document) {
		            iframe = this;
		        }
		        return !iframe;
		    });
		    return iframe;
		}
		
		function changeVersion(actDefId){
			parent.location.href=__rootPath+"/bpm/core/bpmSolution/mgrFast.do?solId="+solId+"&actDefId="+actDefId;
		}
		
		function setMainRow(actDefId,key){
			var iframe = getIframeByElement(document.body);
			if(!solId){
				alert("没有保存流程方案");
				return;
			}
			var url=__rootPath +"/bpm/core/bpmSolution/save.do";
			var data={solId:solId,actDefId:actDefId,defKey:key};
		    
			var config={
		    	url:url,
		    	method:'POST',
		    	data:data,
		    	success:function(result){
		    		var url = __rootPath+"/bpm/core/bpmSolution/mgrFast.do?solId="+solId+"&actDefId="+actDefId;
		    	    parent.location.href=url;
		    	}
		    }
		        
			_SubmitJson(config);
		}

		function onSearchClick(e) {
			var keyText = mini.get("keyText");
            grid1.load({
                "Q_subject__S_LK": keyText.value
            });
        }
		
		function onClearClick(e){
			mini.get("keyText").setValue("");
			grid1.setUrl(__rootPath+"/bpm/core/bpmDef/listForDialog.do");
			grid1.load();
		}
		
		function onCloseClick(e) {
            var lookup2 = mini.get("sequence");
            lookup2.hidePopup();
        }
		
		
		//实定义信息明细
		function showBpmDefInfo(procDefId){
			_OpenWindow({
				title:'流程定义明细',
				url:__rootPath+'/bpm/core/bpmDef/get.do?hideRecordNav=true&actDefId='+procDefId,
				max:true
			});
		}
		
		function nodeSetting(){
			_OpenWindow({
				title : '流程节点[' + nodeName + ']-属性配置',
				iconCls : 'icon-mgr',
				max : true,
				width : 600,
				height : 500,
				url : __rootPath + '/bpm/core/bpmNodeSet/getNodeConfig.do?nodeId=' + nodeId + '&nodeType=' + nodeType + '&solId=' + solId +'&actDefId=${bpmDef.actDefId}'
			});
		}
		
		function userSetting(){
			_OpenWindow({
				title : '流程节点[' + nodeName + ']-人员配置',
				iconCls : 'icon-user',
				max : true,
				width : 600,
				height : 500,
				url : __rootPath + '/bpm/core/bpmSolution/nodeUser.do?nodeId=' + nodeId + '&nodeType=' + nodeType + '&solId=' + solId +'&actDefId=${bpmDef.actDefId}'
			});
		}
		
		function showProcessProperties(){
			_OpenWindow({
				title : '流程属性配置-[${bpmSolution.name}]',
				iconCls : 'icon-properties',
				max : true,
				width : 600,
				height : 500,
				url : __rootPath + '/bpm/core/bpmNodeSet/getNodeConfig.do?nodeId=_PROCESS&nodeType=process&solId=' + solId +'&actDefId=${bpmDef.actDefId}'
			});
		}

		function editBpmDefDesign(){
			var modelId = "${bpmDef.modelId}";
			if(modelId){
	            _OpenWindow({
	                title : '流程定义设计',
	                iconCls : 'icon-design',
	                max : true,
	                width : 600,
	                height : 500,
	                url:__rootPath+'/process-editor/modeler.jsp?modelId=${bpmDef.modelId}&solId=${bpmSolution.solId}',
	                ondestroy:function(action){
	                	parent.location.href=__rootPath+"/bpm/core/bpmSolution/mgrFast.do?solId="+solId+"&actDefId=";
	                }
	            });
			}else{
				if(!solId){
					alert("没有保存流程方案");
					return;
				}
				var url = __rootPath+"/bpm/core/bpmDef/save.do";
				var config={
				    url: url,
				   	method:'POST',
				   	data:{solId:solId,defId:"${bpmDef.defId}"},
				   	success:function(result){
				   		var data = result.data;
				   		if(result.success){
					   		designRow(data.modelId,data.defId);
				   		}else{
				   			top._ShowTips({
			            		msg:result.message
			            	});
				   		}
                	}
				}
				     
				_SubmitJson(config);
			}
		}
		
		function designRow(modelId,defId){
    		_OpenWindow({
    			width:800,
    			height:600,
    			max:true,
    			url:__rootPath+'/process-editor/modeler.jsp?modelId='+modelId,
    			title:'流程建模设计',
    			ondestroy:function(action){
    				$.ajax({
    		            url:__rootPath+ '/bpm/core/bpmSolution/saveToBpmDef.do',
    		            data:{
    		            	solId:"${bpmSolution.solId}",
    		            	defId:defId
    		            },
    					type:"POST",
    		            success: function (jsons) {
    		            	parent.location.href=__rootPath+"/bpm/core/bpmSolution/mgrFast.do?solId="+solId+"&actDefId="+defId;
    		            }
    		        }); 
    			}
    		});
    	}




	</script>
</body>
</html>