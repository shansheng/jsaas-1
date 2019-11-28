<%--
    Document   : 业务表单视图编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
	<title>业务表单视图编辑</title>
	<%@include file="/commons/edit.jsp"%>
	<link href="${ctxPath}/scripts/ueditor/form-design/css/toolbars.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/ueditor-fd-config.js"></script>
	<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/ueditor-fd.all.js"> </script>
	<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/ueditor-form.js"> </script>
	<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>
	<!-- 引入表单控件 -->
	<script type="text/javascript"  src="${ctxPath}/scripts/ueditor/form-design/design-plugin.js"></script>
	<link href="${ctxPath}/scripts/form/tab/css/tab.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript"  src="${ctxPath}/scripts/form/tab/PageTab.js"></script>
	<script type="text/javascript"  src="${ctxPath}/scripts/form/tab/FormContainer.js"></script>
	<script type="text/javascript"  src="${ctxPath}/scripts/flow/form/bpmFormView.js"></script>
	<script type="text/javascript"  src="${ctxPath}/scripts/flow/form/bpmFormViewTab.js"></script>
	<style type="text/css">
		.edui-default .edui-editor {
			border: none !important;
		}

		.toobar_left {
			margin-top: -1px;
			background: #fff;
			border: 1px solid #eee;
		}

		.toobar_left>div>div {
			padding-bottom: 5px;
			padding-left: 10px;
			font-weight: bold;
			margin-bottom: 2px;
			height:20px;
		}

		ul.toobar_li_ul>li, .flex_ul>li {
			display: inline-block;
		}

		ul.toobar_li_ul>li {
			width: calc( 100% / 2 - 4px );
			margin-bottom:6px;
			background: #ecf6ff;
			font-size: 12px;
			height: 26px;
			line-height: 26px;
			padding-left: 6px;
			box-sizing: border-box;
		}

		ul.toobar_li_ul>li:nth-child(even) {
			margin-left: 4px;
		}

		.toobar_li_ul>li>a {
			color: #333;
		}

		.toobar_li_ul>li>a>i {
			padding-right: 2px;
		}

		.toobar_li_ul>li>a>i.iconfont:before {
			color: #409eff;
			font-size: 14px;
		}

		.clearfix:after {
			content: "";
			display: block;
			visibility: hidden;
			clear: both;
			height: 0;
		}
		.mini-layout-region-center .mini-layout-region-body {
			overflow: hidden;
		}
	</style>
</head>
<body>

<ul id="popupToolMenu" class="mini-menu" style="display:none;">
	<li  id="${ctxPath}/sys/core/sysDic/mgr.do" onclick="showTool">数字字典</li>
	<li  id="${ctxPath}/sys/db/sysSqlCustomQuery/list.do" onclick="showTool">自定义SQL</li>
	<li  id="${ctxPath}/sys/core/sysBoList/dialogs.do" onclick="showTool">对话框</li>
	<li  id="${ctxPath}/sys/core/sysSeqId/list.do" onclick="showTool">流水号</li>
	<li  id="${ctxPath}/sys/core/sysDataSource/list.do" onclick="showTool">数据源</li>
	<li  id="${ctxPath}/bpm/panel.do" onclick="showTool">更多...</li>
</ul>

<div class="topToolBar">
	<div>
		<a class="mini-button" plain="true" onclick="saveExit">保存</a>
		<c:if test="${not empty bpmFormView.viewId}">
			<a class="mini-button"  plain="true" onclick="saveNoExit">暂存</a>
		</c:if>
		<a class="mini-button"  plain="true" onclick="nextStep">生成元数据</a>

		<c:if test="${not empty bpmFormView.boDefId && bpmFormView.status=='INIT' }">
			<a class="mini-button" plain="true" onclick="deploy()">发布</a>
		</c:if>

		<c:if test="${not empty bpmFormView.boDefId && bpmFormView.status=='DEPLOYED' }">
			<a class="mini-button"  plain="true" onclick="deployNew()">发布新版</a>
		</c:if>
		<a class="mini-button" plain="true" onclick="preview()">预览</a>
		<a class="mini-menubutton"  plain="true" menu="#popupToolMenu" >工具选项</a>
	</div>
</div>
<div class="mini-fit">
	<form id="form1" method="post" style="padding-top: 4px;background: #fff;">
		<table class="table-detail" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<span class="starBox">
						分　　类  <span class="star">*</span>
					</span>
				</td>
				<td>
					<input id="pkId" name="viewId" class="mini-hidden" value="${bpmFormView.viewId}" />
					<input
							id="treeId"
							name="treeId"
							class="mini-treeselect"
							url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_FORM_VIEW"
							multiSelect="false"
							textField="name"
							valueField="treeId"
							parentField="parentId"
							required="true"
							value="${bpmFormView.treeId}"
							pinyinField="right"
							showFolderCheckBox="false"
							expandOnLoad="true"
							showClose="true"
							style="width:100%"
							oncloseclick="onClearTree"
							style="width:100%"
					/>
				</td>
				<td>
					名　　称 <span class="star">*</span>
				</td>
				<td>
					<input
							name="name"
							value="${bpmFormView.name}"
							class="mini-textbox"
							vtype="maxLength:255"

							required="true"
							emptyText="请输入名称" style="width:100%"/>
				</td>
				<td>标   识   键 <span class="star">*</span></td>
				<td>
					<input
							name="key"
							value="${bpmFormView.key}"
							class="mini-textbox"
							<c:if test="${not empty bpmFormView.boDefId}">readonly="true"</c:if>
							vtype="key,maxLength:100"
							style="width:100%"
							required="true"
							emptyText="请输入标识键"
					/>
				</td>
				<td>展示模式 </td>
				<td>
					<input name="type" class="mini-hidden"   value="ONLINE-DESIGN" />
					<div
							name="displayType"
							id="displayType"
							class="mini-radiobuttonlist"
							textField="text"
							valueField="id"
							data="[{'id':'first','text':'展示首tab'},{'id':'normal','text':'默认模式'}]"
							value="${bpmFormView.displayType}" style="width:100%"></div>
				</td>
				<td style="white-space:nowrap;">生成表单方案
					<input name="isCreate" class="mini-checkbox" value="true" trueValue="on" falseValue="off" />
				</td>

			</tr>
		</table>
	</form>
	<div class="mini-fit">
		<div id="mainLayout" class="mini-layout" style="width:100%;height:100%;">
			<div  region="west" width="220" expanded="true" showSplitIcon="true"  showHeader="false"  bodyStyle="padding:0px;">
				<ul>
					<li id="li-height">
						<ul class="flex_ul">
							<li class="toobar_left">
								<div>
									<div>容器</div>
									<ul class="toobar_li_ul">
										<li><a plugin="mini-customtable"><i class="iconfont icon-daima1"></i>表单模板</a></li>
										<li><a  onclick="insertFieldSet()"><i class="iconfont icon-uncheck"></i>边框容器</a></li>
										<li><a plugin="mini-div"><i class="iconfont icon-workbench"></i>DIV容器</a></li>
										<li><a plugin="mini-condition-div"><i class="iconfont icon-tiaojian"></i>条件容器</a></li>
									</ul>
									<div>表单控件</div>
									<ul class="toobar_li_ul">
										<li><a  plugin="mini-textBox"><i class="iconfont icon-clob"></i>文本</a></li>

										<li><a  plugin="mini-textarea"><i class="iconfont icon-kongjian_duohangwenben"></i>多行文本</a></li>
										<li><a  plugin="mini-checkbox"><i class="iconfont icon-fuxuank"></i>复选框</a></li>
										<li><a  plugin="mini-radiobuttonlist"><i class="iconfont icon-radio"></i>单选按钮</a></li>
										<li><a  plugin="mini-checkboxlist"><i class="iconfont icon-fuxuan"></i>复选按钮</a></li>
										<li><a  plugin="mini-combobox"><i class="iconfont icon-xialakuang"></i>下拉框</a></li>
										<li><a  plugin="mini-treeselect"><i class="iconfont icon-xialakuang1"></i>下拉树</a></li>
										<li><a  plugin="mini-area"><i class="iconfont icon-dizhi"></i>地址控件</a></li>
										<li><a  plugin="mini-spinner"><i class="iconfont icon-shuzi"></i>数字</a></li>

										<li><a  plugin="mini-datepicker"><i class="iconfont icon-richeng4"></i>日期</a></li>

										<li><a  plugin="mini-month"><i class="iconfont icon-yuefen"></i>月份</a></li>
										<li><a  plugin="mini-time"><i class="iconfont icon-shijian6"></i>时间</a></li>
										<li><a  plugin="mini-ueditor"><i class="iconfont icon-fuwenben"></i>富文本</a></li>
										<li><a  plugin="upload-panel"><i class="iconfont icon-shangchuan2"></i>上传控件</a></li>
										<li><a  plugin="mini-img"><i class="iconfont icon-picture"></i>图片上传</a></li>
										<li><a  plugin="mini-hidden"><i class="iconfont icon-yincang"></i>隐藏域</a></li>
										<li><a  plugin="mini-buttonedit"><i class="iconfont icon-bianji"></i>编辑按钮</a></li>
										<li><a  plugin="rx-grid" ><i class="iconfont icon-zibiao"></i>子表</a></li>
										<li><a  plugin="mini-list"><i class="iconfont icon-createtask"></i>数据列表</a></li>
										<li><a  plugin="mini-textboxlist"><i class="iconfont icon-caogao"></i>文本盒子</a></li>
										<li><a  plugin="mini-checkhilist"> <i class="iconfont icon-shenpi3"></i>审批历史</a></li>
										<li><a  plugin="mini-relatedsolution"><i class="iconfont icon-liucheng"></i>关联流程</a></li>
									</ul>
								</div>
								<div>
									<div>用户组织控件</div>
									<ul class="toobar_li_ul">
										<li><a  plugin="mini-user"><i class="iconfont icon-people"></i>用户选择</a></li>
										<li><a  plugin="mini-group"><i class="iconfont icon-group"></i>用户组选择</a></li>
										<li><a  plugin="mini-dep"><i class="iconfont icon-bumen"></i>部门选择器</a></li>
									</ul>
								</div>
								<div>
									<div>扩展控件</div>
									<ul class="toobar_li_ul">
										<li><a  plugin="mini-button"><i class="iconfont icon-zdybtn"></i>自定义按钮</a></li>
										<li><a  plugin="mini-nodeopinion"><i class="iconfont icon-interactive"></i>审批意见</a></li>
										<li><a  plugin="mini-office"><i class="iconfont icon-office"></i>Office控件</a></li>
										<li><a  plugin="mini-iframe"><i class="iconfont icon-workbench"></i>内窗控件</a></li>
										<li><a  plugin="mini-viewword"><i class="iconfont icon-word1"></i>Word模版</a></li>
										<li><a  plugin="mini-contextonly"><i class="iconfont  icon-touzantongpiao"></i>上下文控件</a></li>
									</ul>
								</div>
							</li>
						</ul>
					</li>
				</ul>
			</div><!-- end of west region -->
			<div title="center" region="center"  showHeader="false">
				<div class="mini-fit" id="fitHeight">
					<div id="templateView" style="width: 100%!important;" name="templateView" type="text/plain"></div>
					<div id="pageTabContainer" style=""></div>
				</div>

			</div><!-- end of center region-->
		</div>
	</div>
</div>

<rx:formScript formId="form1" baseUrl="bpm/form/bpmFormView" entityName="com.redxun.bpm.form.entity.BpmFormView" />
<script type="text/javascript">
	mini.layout();
	/* 根据浏览器窗口宽度来设置  -高度 */
	_windowWidth = $(window).width();
	var layout=mini.get('mainLayout');
	var templateView=UE.getEditor('templateView',{initialFrameWidth:''});
	templateView.ready(function(){
		templateView.setHeight();
	});
	/*插件高度自适应---------------yangxin*/
	editHeight();
	function editHeight(){
		var height_fit = $("#fitHeight").height();
		var windowWidth = $(window).width();

        if(windowWidth < 1470 ){
            $("#templateView").height(height_fit - 105 );
        }else {
            $("#templateView").height(height_fit - 80 );
        }
	}

	$(function(){

		$("[plugin]").each(function(){
			var plugin=$(this).attr('plugin');
			$(this).parent().css('cursor','pointer');
			$(this).parent().click(function(){
				formDesign.exec(plugin);
			});
		});
	});

	$(window).resize(function(){
		editHeight();
		mini.layout();
		setTimeout(function(){
			templateView.setHeight($(document).height()-240);
		},500);
	});



	function showTool(e){
		var item=e.sender;
		_OpenWindow({
			title:item.getText(),
			height:450,
			width:800,
			max:true,
			url:item.getId(),
		});
	}
	var formDesign = {
		/*执行控件*/
		exec : function (method) {
			//templateView.execCommand(method);
			exePlugin(method);
		},
		execCommand : function (className) {
			if (className == "fieldset") {
				//这里可以不用执行命令,做你自己的操作也可
				var timestamp=new Date().getTime();
				var html="<fieldset class='fieldsetContainer'><legend class='title'>标题</legend><br/></fieldset><br/>";
				templateView.execCommand('insertHtml',html);
			}
		}
	};

	templateView.addListener("ready", function () {
		//采用后加载方式加载html编辑器的内容
		var pkId=mini.get('pkId').getValue();
		if(pkId.trim()==''){
			initTab("","");
			return;
		}
		_SubmitJson({
			url:__rootPath+'/bpm/form/bpmFormView/getTemplateView.do?viewId='+pkId,
			showMsg:false,
			success:function(result){
				initTab(result.message, result.data);
			}
		});
	});

	function showTool(e){
		var item=e.sender;
		_OpenWindow({
			title:item.getText(),
			width:800,
			height:450,
			max:true,
			url:item.getId(),
		});
	}
	function nextStep(){
		var status=${bpmFormView.status=='DEPLOYED'};

		saveChange();

		var form=new mini.Form("form1");
		form.validate();
		if(!form.isValid()) return;

		var formData=form.getData();

		//保存表单标题和内容。
		var result=formContainer.getResult();
		formData.title=result.title;
		formData.templateView=result.form;
		var objTree=mini.get("treeId");
		var category=objTree.getText();
		formData.category=category;
		formData.treeId=objTree.getValue();
		_OpenWindow({
			url:__rootPath+'/bpm/form/bpmFormView/saveEnt.do',
			title:'生成业务模型并保存',
			height:600,
			width:900,
			onload:function(){
				var iframe = this.getIFrameEl().contentWindow;
				iframe.init(formData);
				iframe.setFormViewStatus(status);
				iframe.setIsCreate(mini.getByName("isCreate").getValue());
			},
			ondestroy:function(action){
				//关闭窗口
				if(action=="ok"){
					CloseWindow('ok');
				}
			}
		});
	}

	function deploy() {
		saveChange();

		var form = new mini.Form("form1");
		form.validate();
		if (!form.isValid() )  return;


		if(!checkTitle()){
			alert("请使用不重复的tab名字");
			return;
		}

		var formData=$("#form1").serializeArray();
		formData.push({
			name:'deploy',
			value:true
		});
		putArrayToFormData(formData);
		_SubmitJson({
			url:__rootPath+"/bpm/form/bpmFormView/save.do",
			method:'POST',
			data:formData,
			success:function(result){
				CloseWindow('ok');
			}
		});
	}

	function deployNew(){
		saveChange();

		var form = new mini.Form("form1");
		form.validate();
		if (!form.isValid() ) return;

		if(!checkTitle()){
			alert("请使用不重复的tab名字");
			return;
		}

		var formData=$("#form1").serializeArray();
		formData.push({
			name:'deployNew',
			value:true
		});

		putArrayToFormData(formData);
		_SubmitJson({
			url:__rootPath+"/bpm/form/bpmFormView/save.do",
			method:'POST',
			data:formData,
			success:function(result){
				CloseWindow('ok');
			}
		});
	}


	function onClearTree(){
		var treeId=mini.get('treeId');
		treeId.setValue('');
		treeId.setText('');
	}


	function saveExit(){
		selfSaveData(true);
	}

	function saveNoExit(){
		selfSaveData(false);
	}

	function selfSaveData(exit) {
		if(templateView.queryCommandState( 'source' )==1){
			mini.alert("请切换视图,源码模式不允许直接保存");
			return;
		}

		saveChange();

		var form=new mini.Form('form1');
		/*
     if(!validateRight()){
            alert("您没有添加权限,请联系管理员");
         return;
        }*/
		form.validate();
		if (!form.isValid()) {
			return;
		}
		if(!checkTitle()){
			alert("请使用不重复的tab名字");
			return;
		}


		var formData=new mini.Form("#form1").getData();
		putArrayToFormData(formData);
		var config={
			url:__rootPath+"/bpm/form/bpmFormView/save.do",
			method:'POST',
			data:formData,
			success:function(result){
				if(exit){
					CloseWindow('ok');
				}
			}
		}

		_SubmitJson(config);
	}


	//将tab的数组(包括title和html内容)存进formData
	function putArrayToFormData(formData) {
		var result = formContainer.getResult();

		var titleArray = result.title;//formContainer.aryTitle.join("#page#");
		var contentArray = result.form;//formContainer.aryForm.join("#page#");
		formData.templateView = contentArray;
		formData.title = titleArray;
	}


	function validateRight(){

		if(${isSuperAdmin}){
			return true;
		}
		var dataArray=mini.get("treeId").getData();
		for(var node in dataArray){
			if(dataArray[node].treeId==mini.get("treeId").getValue()){
				var rightJson=JSON.parse(dataArray[node].right);
				if(rightJson&&rightJson.add=="true"){
					return true;
				}
			}
		}
		return false;
	}

</script>
</body>
</html>