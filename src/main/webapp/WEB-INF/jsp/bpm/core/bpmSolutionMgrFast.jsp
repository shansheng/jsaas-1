<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>业务流程解决方案管理-${bpmSolution.name}</title>
	<%@include file="/commons/edit.jsp"%>
	<!-- 引入ystep样式 -->
	<link rel="stylesheet" href="${ctxPath}/scripts/jquery/plugins/ystep/css/ystep.css"/>
	<!-- 引入ystep插件 -->
	<script src="${ctxPath}/scripts/jquery/plugins/ystep/js/ystep.js"></script>
	<style type="text/css">
		body{
		/* 	overflow:hidden; */
		}
		.mini-tabs-bodys{
			background: #f7f7f7;
		}
		#north{
		
		}
	</style>
	
	
</head>
<body>
	<div class="topToolBar">
		<div>
	        <c:if test="${allowCopyConfig==true}">
                <a class="mini-button"  onclick="configCopy()">复制主版本配置</a>
            </c:if>
            <a class="mini-button"  plain="true" onclick="refresh()">刷新</a>
            
            <a class="mini-button"  plain="true" onclick="prevStep()">上一步</a>
            <a class="mini-button"  plain="true" onclick="nextStep()">下一步</a>
            <c:if test="${not empty bpmDef}">
            <c:if test="${bpmSolution.status!='DEPLOYED'}">
             	<a id="deployButton" class="mini-button"  plain="true" onclick="deploy()">发布</a>
            </c:if>
            </c:if>
            <a class="mini-button btn-red"  plain="true" onclick="CloseWindow()">关闭</a>
		</div>
	</div>

	<div class="mini-fit">
		<div id="layout1" class="mini-layout" style="width:100%;height:100%;" >
		  <div 
		    	title="north" 
		    	region="north" 
		    	height="80" 
		    	showSplitIcon="false" 
		    	showHeader="false"
		    	class="north-top">
		    	<div class="ystep1" style="padding-left:8px;padding-top:2px;"></div>
		    </div>
		    <div region="center" showHeader="false" showSplitIcon="false" style="border:0;" bodyStyle="border:0;">
		    	<div class="mini-fit">
			    	<div id="tabs1" class="mini-tabs"  onactivechanged="onTabsActiveChanged" style="width:100%;min-height:100%;height: 100%;">
					    <div id="step0" title="方案概述" >
							<div class="fitTop"></div>
							<div class="mini-fit">
								<div style="margin-bottom: 10px;margin-left:10px ;margin-right: 10px;background: #fff;padding: 6px 0">
									<a class="mini-button"  plain="true" onclick="saveBpmSolution()">保存</a>
								</div>
								<div class="mini-fit">
									<div class="form-container">
									<form id="form1" class="form-outer" style="border:none;">
										<div class="form-inner">
										 
											<table style="width: 100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
												<caption>业务流程解决方案基本信息</caption>
												<tr>
													<td>解决方案名称</td>
													<td>
														<input id="name"
															name="name"
															value="${bpmSolution.name}"
															class="mini-textbox"
															vtype="maxLength:100"
															required="true"
															emptyText="请输入解决方案名称"
															style="width:90%"
														/>
													</td>
													<td>解决方案标识Key</td>
													<td>
														<input id="key"
															name="key"
															value="${bpmSolution.key}"
															class="mini-textbox"
															vtype="key,maxLength:100"
															required="true"
															emptyText="请输入标识键"
															style="width:90%"
														/>
													</td>
												</tr>
												<tr>
													<td>所属分类</td>
													<td>
														<input
															id="treeId"
															name="treeId"
															class="mini-treeselect"
															url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BPM_SOLUTION"
															multiSelect="false"
															textField="name"
															valueField="treeId"
															parentField="parentId"
															required="true"
															value="${bpmSolution.treeId}"
															showFolderCheckBox="false"
															expandOnLoad="true"
															popupWidth="350"
														/>
													</td>
													<td>正式版</td>
													<td>
														<input
															name="formal"
															class="mini-combobox"
															textField="text"
															valueField="id"
															emptyText="请选择..."
															value="${bpmSolution.formal}"
															required="true"
															data="[{id:'no',text:'测试'},{id:'yes',text:'正式'}]"
														/>
													</td>
												</tr>
												<tr>
													<td>图　　标</td>
													<td>
														<input name="icon" id="icon" value="${bpmSolution.icon}" text="${bpmSolution.icon}" class="mini-buttonedit" onbuttonclick="selectIcon" style="width:160px"/>
									    				<a class="mini-button MyBlock" id="icnClsBtn" style=""></a>
													</td>
													<td>颜　色</td>
													<td>
														<input type="color" name="color" id="color" value="${bpmSolution.color}">
													</td>
												</tr>
												<tr>
													<td>解决方案描述</td>
													<td colspan="3">
														<div id="descp" name="descp" class="mini-ueditor"  style="height:360px;width:100%;"  ></div>
													</td>
												</tr>
											</table>
										</div>
									</form>
								</div>
								</div>
							</div>
					    </div><!-- end of 方案概述 -->
					    <div 
					    	id="step1" 
					    	title="流程定义" 

					    	url="${ctxPath}/bpm/core/bpmSolution/bpmDef.do?solId=${bpmSolution.solId}&actDefId=${bpmDef.actDefId}"
				    	></div>
					    <div 
					    	id="step2" 
					    	title="审批表单" 

					    	<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
					    	url="${ctxPath}/bpm/core/bpmSolution/formView.do?solId=${bpmSolution.solId}&actDefId=${bpmDef.actDefId}"
				    	></div>
						
					   	<div 
					   		id="step3" 
					   		title="变量配置" 

					   		<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
					   		url="${ctxPath}/bpm/core/bpmSolution/vars.do?solId=${bpmSolution.solId}&actDefId=${bpmDef.actDefId}"
				   		></div>
					    <div 
					    	id="step4" 
					    	title="审批人员" 

					    	<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
					    	url="${ctxPath}/bpm/core/bpmSolution/user.do?solId=${bpmSolution.solId}&actDefId=${bpmDef.actDefId}"
				    	></div>
					    <div 
					    	id="step5" 
					    	title="节点配置" 

					    	<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
					    	url="${ctxPath}/bpm/core/bpmSolution/nodeSet.do?solId=${bpmSolution.solId}&actDefId=${bpmDef.actDefId}"
				    	></div>
						<div 
							id="step7" 
							title="授权" 

							<c:if test="${isBindFlow==false}">enabled="false"</c:if> 
							url="${ctxPath}/bpm/core/bpmSolution/grant.do?solId=${bpmSolution.solId}&actDefId=${bpmDef.actDefId}"
						></div>
					</div>
				</div>
		    </div>
		</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var solId='${bpmSolution.solId}';
		var isBindFlow='${isBindFlow}';
		var tabs=mini.get('tabs1');
		top['solutionMgrWin']=window;
		var curStep=${bpmSolution.step};
		
		function onCollapse(){
			var layout=mini.get('layout1');
			layout.updateRegion("north", { visible: false });
		}
		
		//选择图标
	    function selectIcon(e){
	 	   var btn=e.sender;
	 	   _IconSelectDlg(function(icon){
				btn.setText(icon);
				btn.setValue(icon);
				mini.get('icnClsBtn').setIconCls(icon);
			});
	    }
		//从主版本中拷贝配置
		function configCopy(){
			_SubmitJson({
				url:__rootPath+'/bpm/core/bpmSolution/copyConfig.do',
				data:{
					solId:solId,
					actDefId:'${bpmDef.actDefId}'
				},
				success:function(result){
					location.reload();
				}
			});
		}
		
		$(function(){
			var icon = '${bpmSolution.icon}';
	    	mini.get('icnClsBtn').setIconCls(icon);
			$(".ystep1").loadStep({
			      size: "large",
			      color: "blue",
			      steps: [{
			        title: "初始化",
			        content: "初始化流程解决方案"
			      },{
			        title: "流程定义",
			        content: "进行流程定义的设计，并且进行发布"
			      },
			     
			      {
			        title: "审批表单",
			        content: "绑定或设计跟流程相关的业务展示表单方案"
				  },
				  
			      {
				        title: "变量配置",
				        content: "设置流程各环节的流程需要使用的变量"
				  },
			      {
			        title: "审批人员",
			        content: "绑定流程节点的执行人员"
			      },{
			    	  title:"节点配置",
			    	  content:"设置节点配置参数及绑定流程数据交互配置"
			      }
			      /* ,{
			    	  title:"测试",
			    	  content:"流程模拟测试"
			    	} */,
			    	{
				    	  title:"授权",
				    	  content:"流程授权配置"
				    }
			      ]
			    });
			
			//$(".ystep1").setStep(curStep);
			//把当前步骤前面的tab更新为可用
			for(var i=1;i<=curStep;i++){
				var tab=tabs.getTab(i-1);
				tabs.updateTab(tab,{enabled:true});
			}
			var curTab=tabs.getTab(curStep);
			tabs.activeTab(curTab);
		});
		function refresh(){
			window.location.reload();
		}
		
		function prevStep(){
			var step=$(".ystep1").getStep();
			if(step<=1) return;
			var tab=tabs.getTab(step-1-1);
			tabs.updateTab(tab,{enabled:true});
			tabs.activeTab(tab);
		}
		
		function nextStep(){
			//步骤从1开始，tab的index从0开始
			var step=$(".ystep1").getStep();
			if(step==1 && solId==''){
			    alert('请保存流程方案信息！');
                var form=new mini.Form("#form1");
                form.validate();
			    return;
			}
			if(step>=2 && isBindFlow=='false'){
				alert('请先绑定流程！');
				return;
			}
			if(step>6) return;
			//检查当前步骤是否已经完成，需要确认检查条件TODO
			
			var tab=tabs.getTab(step+1-1);
			tabs.updateTab(tab,{enabled:true});
			tabs.activeTab(tab);
			/*
			if(step==6){
				mini.get('deployButton').setEnabled(true);
			}*/
		}
		
		function saveBpmSolution(){
			var form=new mini.Form("#form1");
			form.validate();
		    if (!form.isValid()) {
		        return;
		    }
		    var index=tabs.getActiveIndex();
		    var data=form.getData();
		    var color = $("#color").val();
		    data.color=color;
		    data.step=index;
		    data.solId=solId;
		    
		    var url=__rootPath +"/bpm/core/bpmSolution/save.do";
		    
			var config={
		    	url:url,
		    	method:'POST',
		    	data:data,
		    	success:function(result){
		    		location.href=__rootPath+"/bpm/core/bpmSolution/mgrFast.do?solId="+result.data.solId;
		    	}
		    }
		        
			_SubmitJson(config);
		}
		
		function edit(){
			_OpenWindow({
				title:'编辑流程业务解决方案',
				url:__rootPath+'/bpm/core/bpmSolution/edit.do?hideNav=true&pkId='+solId,
				width:850,
				height:630,
				ondestroy:function(action){
					if(action!='ok')return;
					window.location.reload();
				}
			});
		}
		//发布
		function deploy(){
			_SubmitJson({
				url:__rootPath+'/bpm/core/bpmSolution/deploy.do',
				method:'POST',
				data:{
					solId:solId,
					actDefId:'${bpmDef.actDefId}'
				},
				success:function(result){
					mini.confirm("发布成功,关闭当前窗口!","提示信息",function(action){
						if(action=="ok"){
							CloseWindow("ok");
						}
					});
				}
			});
		}
		
		function onTabsActiveChanged(e) {
            var tabs = e.sender;
           // var tab = tabs.getActiveTab();
            var index=tabs.getActiveIndex();
           
            $(".ystep1").setStep(index+1);
            //更新当前步骤
            _SubmitJson({
				url:__rootPath+'/bpm/core/bpmSolution/updStep.do',
				data:{
					solId:solId,
					step:index
				},
				method:'POST',
				showMsg:false
			});
        }
	</script>
</body>
</html>