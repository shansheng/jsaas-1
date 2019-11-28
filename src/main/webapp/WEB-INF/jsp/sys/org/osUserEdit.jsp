<%-- 
    Document   : 用户编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>用户编辑</title>
<%@include file="/commons/edit.jsp"%>
<style type="text/css">
#relInstGrid .mini-panel-border{
	border: 1px solid #ececec;
	border-bottom: none;
}
</style>
</head>
<body>
 	<rx:toolbar toolbarId="toolbar1" pkId="${osUser.userId}" hideRecordNav="true"></rx:toolbar>
	<div class="mini-fit">
	<div class="form-container">
		<form id="form1" method="post" style="height: 100%">
			<input type="hidden" name="crsf_token" class="mini-hidden"  value="${sessionScope.crsf_token}"/>
			<div class="mini-tabs" activeIndex="0"  style="width:100%;min-height:100%;">
				<div  title="用户基本信息">
					<table class="table-detail column-four" cellspacing="1" cellpadding="0">
						<caption>用户基本信息</caption>
						<tr>
							<td>
									姓　　名 <span class="star">*</span>
							</td>
							<td><input name="fullname" value="${osUser.fullname}" class="mini-textbox" vtype="maxLength:64" required="true" emptyText="请输入姓名" />

							<input id="pkId" name="userId" class="mini-hidden" value="${osUser.userId}" />
                            <!--隐藏-->
                            <input id="hideTenantId" name="editTenantId" class="mini-hidden" value="${osUser.editTenantId}" />
							<!-- 表示把用户加到指定的用户组的关系下 -->
							<input name="groupId" class="mini-hidden" value="${groupId}" /> <input name="relTypeId" class="mini-hidden" value="${relTypeId}" />

							</td>
							<td>帐 号 <span class="star">*</span> </td>
							<td>
								<input name="userNo"
									   value="${osUser.userNo}" class="mini-textbox" vtype="maxLength:64" emptyText="请输入账号" required="true" style="width: 60%"/>
								<c:if test="${not empty osUser.userId}">
									<a class="mini-button"  onclick="editPwd('${osUser.userId}')">重设密码</a>
								</c:if>
							</td>
						</tr>
						<c:if test="${empty osUser.userId}">
								<tr>
									<td>
										<span class="starBox">
											密　　码<span class="star">*</span>
										</span>
									</td>
									<td><input class="mini-password" name="pwd" id="pwd" required="true"  /></td>
									<td>
										<span class="starBox">
											确认密码<span class="star">*</span>
										</span>
									</td>
									<td >
										<input
											class="mini-password"
											name="rePassword"
											id="rePassword"
											required="true"
											onvalidation="onValidateRepassword"

										/>
									</td>
								</tr>
						</c:if>
						<tr>
							<td>
								<span class="starBox">
									主   部   门<span class="star">*</span>
								</span>
							</td>
							<td>
								  <input id="mainDepId"
										 name="mainDepId"
										 class="mini-buttonedit icon-dep-button"
										 value="${mainDepId}"
										 text="${mainDepName}"
										 required="true" allowInput="false"
										 onbuttonclick="selectMainDep" style="width:100%"/>
							</td>
							<td>用户类型</td>
							<td>
								<input id="userType"
									   name="userType"
									   class="mini-combobox"
									   url="${ctxPath}/sys/org/osUserType/getAllTypes.do?tenantId=${tenantId}"
									   emptyText="请选择..."
									   showNullItem="true" valueField="code" textField="name" value="${osUser.userType}"/>
							</td>
						</tr>
						<tr>
							<td>
								从属部门
							</td>
							<td colspan="3">
								<input id="canDepIds" name="canDepIds" allowInput="false" class="mini-textboxlist" style="width: 80%;min-height:32px;" value="${canDepIds}" text="${canDepNames}" /> <a class="mini-button"   plain="true" onclick="selectCanDeps()">添加</a>
							</td>
						</tr>
						<tr>
							<td>
								其   他   组
							</td>
							<td colspan="3"  width="300">
								<input id="canGroupIds" name="canGroupIds" allowInput="false" class="mini-textboxlist" style="width: 80%; min-height:32px;" value="${canGroupIds}" text="${canGroupNames}" /> <a class="mini-button"   plain="true" onclick="selectCanGroups()">添加</a>
							</td>
						</tr>
						<tr>
							<td>
								状　 　态<span class="star">*</span>
							</td>
							<td>
								<div name="status" class="mini-radiobuttonlist" value="${osUser.status}" required="true" repeatDirection="vertical" required="true" emptyText="请输入状态" repeatLayout="table" data="[{id:'IN_JOB',text:'在职'},{id:'OUT_JOB',text:'离职'}]" textField="text" valueField="id" required="true" vtype="maxLength:40"></div>
							</td>
							<td>性　　别</td>
							<td>
								<div name="sex" class="mini-radiobuttonlist" value="${osUser.sex}" required="true" repeatDirection="vertical" required="true" emptyText="请输入性别" repeatLayout="table" data="[{id:'Male',text:'男'},{id:'Female',text:'女'}]" textField="text" valueField="id" required="true" vtype="maxLength:40"></div>
							</td>
						</tr>

						<tr>
							<td>入职时间 </td>
							<td><input name="entryTime" value="${osUser.entryTime}" class="mini-datepicker" vtype="maxLength:19" /></td>

							<td>离职时间 </td>
							<td><input name="quitTime" value="${osUser.quitTime}" class="mini-datepicker" vtype="maxLength:19" /></td>
						</tr>
						<tr>
							<td>手　　机 </td>
							<td><input name="mobile" value="${osUser.mobile}" class="mini-textbox" vtype="maxLength:20" /></td>

							<td>
								<span class="starBox">
									邮　　件 <span class="star">*</span> 
								</span>
							</td>
							<td><input name="email" value="${osUser.email}" class="mini-textbox" required="true" vtype="maxLength:100" /></td>
						</tr>

						<tr>
							<td>地　　址 </td>
							<td colspan="3">
								<input name="address" class="mini-textbox" vtype="maxLength:255" value="${osUser.address}" />
							</td>
						</tr>

						<tr>
							<td>紧急联系人 </td>
							<td><input name="urgent" value="${osUser.urgent}" class="mini-textbox" vtype="maxLength:64" /></td>

							<td>紧急联系人手机 </td>
							<td><input name="urgentMobile" value="${osUser.urgentMobile}" class="mini-textbox" vtype="maxLength:20" /></td>
						</tr>
						<tr>
							<td>QQ　号 </td>
							<td><input name="qq" value="${osUser.qq}" class="mini-textbox" vtype="maxLength:20" /></td>
							<td>生　　日</td>
							<td><input name="birthday" value="${osUser.birthday}" class="mini-datepicker" vtype="maxLength:19" /></td>
						</tr>

						<tr>
							<td>照　　片 </td>
							<td colspan="3" style="height:120px;">
								<input id="photo" name="photo" value="${osUser.photo}" class="mini-hidden" />
								<img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=${osUser.photo}" class="upload-file" />
							</td>
						</tr>
					</table>
				</div>
				<div title="关系定义">
						<div style="display: none">
							<input
								id="relTypeEditor"
								class="mini-combobox"
								onvaluechanged="onRelTypeChange"
								name="relTypeEditor"
								url="${ctxPath}/sys/org/osRelType/listUserRelsExcludeBelong.do"
								valueField="name"
								textField="name"
							/>
							<input
								id="userEditor"
								class="mini-buttonedit"
								style="width: 100%"
								onbuttonclick="showUserEditor"
								selectOnFocus="true"
								allowInput="false"
							/>
							<input
								id="groupEditor"
								class="mini-buttonedit"
								style="width: 100%"
								onbuttonclick="showGroupEditor"
								selectOnFocus="true"
								allowInput="false"
							/>
						</div>
						<div id="toolbar1" class="mini-toolbar " >
							<div class="form-toolBox">
								<ul class="toolBtnBox">
									<li><a class="mini-button"   plain="true" onclick="addRelInst">添加关系</a></li>
									<li><a class="mini-button btn-red"  plain="true" onclick="removeRelInst">删除关系</a></li>
								</ul>
							</div>
						</div>
						<div
							id="relInstGrid"
							class="mini-datagrid"
							style="width: 100%;"
							multiSelect="false"
							height="auto"
							oncellbeginedit="changeColumnEditor"
							allowCellEdit="true"
							allowCellSelect="true"
							url="${ctxPath}/sys/org/osRelInst/listByUserIdExcludeBelong.do?userId=${osUser.userId}"
							idField="groupId"
							showPager="false"
							allowAlternating="true"
						>
							<div property="columns">
								<div type="indexcolumn" width="60">序号</div>
								<div field="relTypeName" name="relTypeName" width="160">关系类型</div>
								<div field="partyName1" name="partyName1" width="200">关系用户或组</div>
								<div field="partyName2" name="partyName2" width="200">用户</div>
							</div>
						</div>
			</div>
				<div title="扩展属性">
					<div class="mini-toolbar " >
						<div class="form-toolBox">
							<ul>
								<li><a class="mini-button"   onclick="editAttr('${osUser.userId}')">设置扩展属性</a></li>
							</ul>
						</div>
					</div>
						<div id="customAttr" class="mini-tabs" activeIndex="0"  style="height:500px;">
							<c:forEach items="${treeList}" var="tree">
								<div title="${tree.name}" <%--showCloseButton="true"--%>>
                                    <table class="table-detail column-two">
									<c:forEach items="${osCustomAttributes}" var="attr">
										<c:if test="${tree.treeId == attr.treeId}">
										    <tr id="tr_attr_${attr.ID}">
											<th>${attr.attributeName}：</th>
											<td >
												<c:if test="${attr.widgetType=='textbox'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-textbox" value="${attr.value}"  readonly="readonly" style="display: inline-block;"/></c:if>
												<c:if test="${attr.widgetType=='spinner'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-spinner"  value="${attr.value}" readonly="readonly" style="display: inline-block;"/></c:if>
												<c:if test="${attr.widgetType=='datepicker'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-datepicker"  value="${attr.value}" readonly="readonly" style="display: inline-block;"/></c:if>
												<c:if test="${attr.widgetType=='combobox'}">
													<c:set value="${attr.valueSource}" var="valuesource"></c:set>
													<c:set value="${attr.sourceType}" var="sourceType"></c:set>
													<script>
                                                        var jsonAttr = '${valuesource}';
                                                        var key = '${sourceType}';
                                                        jsonAttr = JSON.parse(jsonAttr);
                                                        if(key == 'URL'){
                                                            document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-combobox" style="width: 150px;" textField="'+jsonAttr[0].key+'" valueField="'+jsonAttr[0].value+'" url="'+'${ctxPath}'+jsonAttr[0].URL+'" value="${attr.value}" showNullItem="true" allowInput="true"/>');
                                                        }else if(key == 'CUSTOM'){
                                                            var id = "widgetType_${attr.ID}";
                                                            document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" textField="text" valueField="id"  class="mini-combobox" data="" value="${attr.value}" />');
                                                            mini.parse();
                                                            mini.get(id).setData('${attr.valueSource}');
                                                        }
													</script>
												</c:if>
												<c:if test="${attr.widgetType=='radiobuttonlist'}">
													<c:set value="${attr.valueSource}" var="valuesource"></c:set>
													<c:set value="${attr.sourceType}" var="sourceType"></c:set>
													<script>
                                                        var jsonAttr = '${valuesource}';
                                                        var key = '${sourceType}';
                                                        if(key == 'URL'){
                                                            jsonAttr = JSON.parse(jsonAttr);
                                                            document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-radiobuttonlist" style="width: auto" repeatItems="4" repeatLayout="table" textField="'+jsonAttr[0].key+'" valueField="'+jsonAttr[0].value+'" value="${attr.value}" url="'+'${ctxPath}'+jsonAttr[0].URL+'"/>');
                                                        }else if(key == 'CUSTOM'){
                                                            var id = "widgetType_${attr.ID}";
                                                            document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-radiobuttonlist" style="width: auto" repeatItems="4" repeatLayout="table" textField="text" valueField="id" data="" value="${attr.value}" />');
                                                            mini.parse();
                                                            mini.get(id).setData('${attr.valueSource}');
                                                        }
													</script>
												</c:if>
											</td>
										</tr>
									    </c:if>
									</c:forEach>
									</table>
                                </div>
							</c:forEach>
						</div>
				</div>
			</div>
		</form>
	</div>
	</div>
	<rx:formScript formId="form1" baseUrl="sys/org/osUser" tenantId="${param.tenantId}" />
	<script type="text/javascript">
		var userId = '${osUser.userId}';
		var grid = mini.get('groupGrid');
		var tenantId='<c:out value='${tenantId}' />';
		var relInstGrid = mini.get('relInstGrid');
		var relTypeEditor = mini.get('relTypeEditor');
		var items = '${osCustomAttributes}';

        var hideTenantId = mini.get('hideTenantId');
        hideTenantId.hide();
        var editTenantId = '${osUser.editTenantId}';

		if (userId != '') {
			relInstGrid.load();
		}

		function editAccountInfo(accountId){
			_OpenWindow({
				title:'编辑用户信息',
				width:620,
				iconCls:'icon-user',
				height:380,
				url:__rootPath+'/sys/core/sysAccount/edit.do?pkId='+accountId
			});
		}

		//重设置密码
        function editPwd(pk){
        	_OpenWindow({
        		title:'重设置密码',
        		url:__rootPath+'/sys/org/osUser/resetPwd.do?userId='+pk,
        		width:600,
        		height:400
        	});
        }

        //设置扩展属性
        function editAttr(pk){
            _OpenWindow({
                title:'设置扩展属性',
                url:__rootPath+'/sys/org/osUser/editAttr.do?userId='+pk,
                width:800,
                height:600,
                ondestroy:function(action){
                    if(action!="ok") return;
                    location.reload()
                }
            });
        }


        //选择主部门
		function selectMainDep(e){
			var b=e.sender;

			_TenantGroupDlg((editTenantId && editTenantId!='undefined')?editTenantId:tenantId,true,'','1',function(g){
				b.setValue(g.groupId);
				b.setText(g.name);
			},false);

		}
		
		function selectCanDeps(){
			var canDepIds=mini.get('canDepIds');
			
			_TenantGroupDlg((editTenantId && editTenantId!='undefined')?editTenantId:tenantId,false,'','1',function(groups){
				var uIds=[];
				var uNames=[];
				for(var i=0;i<groups.length;i++){
					uIds.push(groups[i].groupId);
					uNames.push(groups[i].name);
				}
				if(canDepIds.getValue()!=''){
					uIds.unshift(canDepIds.getValue().split(','));
				}
				if(canDepIds.getText()!=''){
					uNames.unshift(canDepIds.getText().split(','));	
				}
				canDepIds.setValue(uIds.join(','));
				canDepIds.setText(uNames.join(','));
			},false);
		}
		
		function selectCanGroups(){
			var canGroupIds=mini.get('canGroupIds');
			
			_GroupCanDlg({
				tenantId:(editTenantId && editTenantId!='undefined')?editTenantId:tenantId,
				single:false,
				width:900,
				height:500,
				title:'用户组',
				callback:function(groups){
					var uIds=[];
					var uNames=[];
					for(var i=0;i<groups.length;i++){
						uIds.push(groups[i].groupId);
						uNames.push(groups[i].name);
					}
					if(canGroupIds.getValue()!=''){
						uIds.unshift(canGroupIds.getValue().split(','));
					}
					if(canGroupIds.getText()!=''){
						uNames.unshift(canGroupIds.getText().split(','));	
					}
					canGroupIds.setValue(uIds.join(','));
					canGroupIds.setText(uNames.join(','));
				}
			});
		}


		function onRelTypeChange(e) {
			var drow = relTypeEditor.getSelected();
			var isContain =false;
			if(relInstGrid.data && relInstGrid.data.length>0){
				var relData = relInstGrid.data;
				for(var i=0;i<relData.length;i++){
					if((relData[i].relTypeKey && relData[i].relTypeKey == drow.key) || (relData[i].key && relData[i].key == drow.key) ){
						alert("已经存在相同的["+relData[i].relTypeName+"],不允许再次选择！");
						isContain =true;
						break;
					}
				}
			}
			setValueToRelInstGrid(drow,isContain);
		}

		function setValueToRelInstGrid(drow,isContain){
			var row = relInstGrid.getSelected();
			relInstGrid.cancelEdit();
			relInstGrid.updateRow(row, {
				relTypeId : isContain?"":drow.id,
				relTypeName : isContain?"":drow.name,
				relTypeCat : isContain?"":drow.relType,
				key : isContain?"":drow.key,
				relTypeKey:isContain?"":row.relTypeKey
			});
		}


		//删除关系
		function removeRelInst() {
			var row = relInstGrid.getSelected()
			if (!row) {
				alert('请选择需要删除的行!');
				return;
			}
			if (userId == '') {
				relInstGrid.removeRow(row);
			} else {
				if(row.instId&&row.instId!=''){
					_SubmitJson({
						url : __rootPath + '/sys/org/osRelInst/delInst.do?instId=' + row.instId,
						success : function(result) {
							relInstGrid.removeRow(row);
						}
					});
				}else{
					relInstGrid.removeRow(row);
				}
			}
		}

		//动态设置每列的编辑器
		function changeColumnEditor(e) {
			var field = e.field, rs = e.record;
			if (field == "relTypeName") {
				e.editor = mini.get('relTypeEditor');
			} else if (field == 'partyName1') {
				if (!rs.relTypeName) {
					return;
				}
				if (rs.relTypeCat == 'GROUP-USER') {
					e.editor = mini.get('groupEditor');
				} else {
					e.editor = mini.get('userEditor');
				}
			}
			e.column.editor = e.editor;
		}

		function showUserEditor() {
			_UserDlg(true, function(user) {
				var row = relInstGrid.getSelected();
				relInstGrid.cancelEdit();
				relInstGrid.updateRow(row, {
					party1 : user.userId,
					partyName1 : user.fullname,
					partyName2 : '编辑用户'
				});
			});
		}

		function showGroupEditor() {
			_GroupDlg(true, function(group) {
				var row = relInstGrid.getSelected();
				relInstGrid.cancelEdit();
				relInstGrid.updateRow(row, {
					party1 : group.groupId,
					partyName1 : group.name,
					partyName2 : '编辑用户'
				});
			});
		}

		function addRelInst() {
			relInstGrid.addRow({});
		}
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pk = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pk + '\')"></span>' + ' <span  title="删除" onclick="delBelongRow(\'' + record._uid + '\')"></span>';
			return s;
		}

		function detailRow(groupId) {
			_OpenWindow({
				title : '用户组明细',
				height : 330,
				width : 600,
				url : __rootPath + '/sys/org/osGroup/detail.do?groupId=' + groupId
			});
		}

		function delBelongRow(uid) {
			var row = grid.getRowByUID(uid);
			_SubmitJson({
				url : __rootPath + '/sys/org/osUser/removeBelongRelType.do',
				data : {
					groupId : row.groupId,
					userId : userId
				},
				success : function(text) {
					grid.removeRow(row);
				}
			});
		}

		$(function() {
			/**-- 用于上传图片 **/
			$(".upload-file").on('click', function() {
				var img = this;
				_UserImageDlg(true, function(imgs) {
					if (imgs.length == 0)
						return;
					$(img).attr('src', '${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=' + imgs[0].fileId);
					$(img).siblings('input[type="hidden"]').val(imgs[0].fileId);
				});
			});
		});

		function onValidateRepassword(e) {
			if (e.isValid) {
				var pwd = mini.get('pwd').getValue();
				var rePassword = mini.get('rePassword').getValue();
				if (pwd != rePassword) {
					e.errorText = "两次密码不一致!";
					e.isValid = false;
				}
			}
		}

		function attachAccountChange(e) {
			var val = this.getChecked();
			var isAttachAccount = mini.get('isAttachAccount');
			isAttachAccount.setValue(val);
			if (val) {
				$("#accountInfo").css('display', '');
			} else {
				$("#accountInfo").css('display', 'none');
			}
		}

		//保存用户 组前进行表单的数据处理，由Tag中的SaveData调用
		function handleFormData(formData) {
			var relInsts=relInstGrid.getData();
			var mainDepId=mini.get('mainDepId').getValue();
			var canDepIds=mini.get('canDepIds').getValue();
			
			//从属部门数组ID
			var canDepAry=canDepIds.split(",");

			if(mainDepId!='' && canDepIds!=''){
				if(canDepAry.contains(mainDepId)){
					alert('主部门不能同时是从属部门！');
					return {
						formData:formData,
						isValid:false
					}
				}
			}
			
			var formArray=relInstGrid.getData();
			for(var i=0;i<formArray.length;i++){
				if(!formArray[i].party1||!formArray[i].relTypeId){
					return {
						formData : formData,
						isValid : false
					};
				}
			}
			for(var i=0;i<relInsts.length;i++){
				var party2 = relInsts[i].party2;
				if(relInsts[i].partyName2=="编辑用户"){
					party2 = userId;
				}
				relInsts[i].path=relInsts[i].party1+"."+party2+".";
				relInsts[i].instId="";
			}
			formData.push({
				name : 'relInsts',
				value : mini.encode(relInsts)
			});
			return {
				formData : formData,
				isValid : true
			};
		}

		function addGroup() {
			var data = grid.getData();
			//通过用户 选择对话框选择用户组
			_GroupDlg(false, function(groups,dim) {
				for (var i = 0; i < groups.length; i++) {
					var isFound = false;
					//过滤重复的
					for (var j = 0; j < data.length; j++) {
						if (data[j].groupId == groups[i].groupId) {
							isFound = true;
							break;
						}
					}
					if (!isFound) {
						groups[i].isMain = 'NO';
						groups[i].dimId = dim.dimId;
						grid.addRow(groups[i]);
					}
				}
			},true);			
		}
		
		/* function selfSaveData() {
	        form.validate();
	        if (!form.isValid()) {
	            return;
	        }
	        
	        var formData=$("#form1").serializeArray();
	        //处理扩展控件的名称
	        var extJson=_GetExtJsons("form1");
	        for(var key in extJson){
	        	formData.push({name:key,value:extJson[key]});
	        }
	       
	       
	       //若定义了handleFormData函数，需要先调用 
	       if(isExitsFunction('handleFormData')){
	        	var result=handleFormData(formData);
	        	if(!result.isValid) return;
	        	formData=result.formData;
	        }
	        
	        var config={
	        	url:"${ctxPath}/sys/org/osUser/save.do",
	        	method:'POST',
	        	data:formData,
	        	success:function(result){
	        		//如果存在自定义的函数，则回调
	        		if(isExitsFunction('successCallback')){
	        			successCallback.call(this,result);
	        			return;	
	        		}
	        		
	        		CloseWindow('ok');
	        	}
	        }
	        
	        if(result && result["postJson"]){
	        	config.postJson=true;
	        }
	        
	        _SubmitJson(config);
	     } */

	</script>
	<script src="${ctxPath}/scripts/common/form.js" type="text/javascript"></script>
</body>
</html>