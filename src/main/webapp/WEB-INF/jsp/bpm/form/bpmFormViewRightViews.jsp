<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="/commons/list.jsp"%>
		<script src="${ctxPath}/scripts/share/dialog.js" type="text/javascript"></script>
		<title>流程方案字段权限</title>
	</head>
	<body>
		<div class="form-toolBox" >
			<ul>
				<li>
					<a class="mini-button"   onclick="addRow">添加</a>
				</li>
				<li>
					<a class="mini-button btn-red" onclick="delRowGrid('formGrid')">删除</a>
				</li>
				<li>
					<a class="mini-button"  onclick="upRowGrid('formGrid')">向上</a>
				</li>
				<li>
					<a class="mini-button"  onclick="upRowGrid('formGrid')">向上</a>
				</li>
				<li>
					<a class="mini-button"   onclick="CloseWindow('ok')">确定</a>
				</li>
			</ul>
		</div>
		<div class="mini-fit">
			<div 
				id="formGrid" 
				class="mini-datagrid" 
				style="width:100%;height:100%;" 
	        	allowResize="true" 
	        	pageSize="20" 
	        	showPager="false"
	        	allowCellEdit="true" 
	        	allowCellSelect="true" 
	        	multiSelect="true" 
	        	editNextOnEnterKey="true"  
	        	editNextRowCell="true"
        		allowAlternating="true"
        	>
		        <div property="columns">
		            <div type="indexcolumn" headerAlign="center" align="center">序号</div>
		            <div type="checkcolumn"></div>
		            <div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
		            <div name="formAlias"  displayfield="formName"  allowSort="true" width="150">表单
		                <input property="editor" class="mini-buttonedit" onbuttonclick="onSelectForm()" style="width:100%;" minWidth="200" showClose="true" oncloseclick="clearData(e,'formAlias,formName')"/>
		            </div>
		            <div type="checkboxcolumn" field="isAll" trueValue="true" falseValue="false" width="60" >全部</div>
		            <div type="checkboxcolumn" field="attendUsers" trueValue="true" falseValue="false" width="60" >含审批人</div>
		            <div type="checkboxcolumn" field="startUser" trueValue="true" falseValue="false" width="60" >含发起人</div>
		            <div field="userIds" displayfield="userNames" width="200">用户
		                <input property="editor" class="mini-buttonedit" onbuttonclick="onSelectUser()" style="width:100%;"  showClose="true" oncloseclick="clearData(e,'userIds,userNames')"/>
		            </div>  
		            <div field="groupIds" displayfield="groupNames" width="200">用户组
		                <input property="editor" class="mini-buttonedit" onbuttonclick="onSelectGroup()" style="width:100%;"  showClose="true" oncloseclick="clearData(e,'groupIds,groupNames')"/>
		            </div>
		                                  
		        </div>
		    </div>
		</div>
		<script type="text/javascript">
			mini.parse();
			var formGrid=mini.get('formGrid');
			var bodefId='${param.boDefIds}';
			var nodeId='${param.nodeId}';
			var solId='${param.solId}';
			var actDefId='${param.actDefId}';
			
			function addRow(e){
                onSelectForm();
            }
	
			//行功能按钮
			function onActionRenderer(e) {
				var record = e.record;
				var pkId = record.pkId;
				var uid=record._uid;
				
				var s = '<span style="color:blue;cursor:pointer" title="表单授权" onclick="formRightGrant(\''+uid+'\')">表单授权</span>';
				return s;
			}

			function formRightGrant(uid){
				var record=formGrid.getRowByUID(uid);
				if(!record.formAlias){
					alert('请选择表单！');
					return;
				}
				showFormViewGrant(solId,record.formAlias,actDefId,nodeId);
			}
			
			//设置表单视图的授权
			function showFormViewGrant(solId,viewKey,actDefId,nodeId){
	      		_OpenWindow({
					url:__rootPath+'/bpm/core/bpmFormRight/edit.do?formAlias='+viewKey+'&nodeId=' + nodeId +'&solId=' + solId +'&actDefId=' + actDefId,
					title:'表单视图的字段管理',
					width:780,
					height:480,
					max:true
				});
	      	}

			function onSelectGroup(){
				formGrid.cancelEdit();
				var row=formGrid.getSelected();
				_GroupDlg(false,function(groups){
					var groupIds=[];
					var groupNames=[];
					for(var i=0;i<groups.length;i++){
						groupIds.push(groups[i].groupId);
						groupNames.push(groups[i].name);
					}
					formGrid.updateRow(row,{groupIds:groupIds.join(','),groupNames:groupNames.join(',')});
				});
			}
			
			function setGridData(data){
				formGrid.setData(mini.decode(data));
			}
				
			function onSelectUser(){
				formGrid.cancelEdit();
				var row=formGrid.getSelected();
				_UserDlg(false,function(users){
					var userIds=[];
					var userNames=[];
					for(var i=0;i<users.length;i++){
						userIds.push(users[i].userId);
						userNames.push(users[i].fullname);
					}
					formGrid.updateRow(row,{userIds:userIds.join(','),userNames:userNames.join(',')});
				});
			}
			
			function getCondForms(){
				var forms=formGrid.getData();
				for(var i=forms.length-1;i>=0;i--){
					var form=forms[i];
					if(!form.formAlias) {
						forms.splice(i,1);
					}
				}
				return mini.encode(forms);
			}
			
			function onSelectForm(){
				formGrid.cancelEdit();
				var row=formGrid.getSelected();
				var conf={single:true,bodefId:bodefId,callBack:function(formView){
                        var aryKey=[];
                        var aryName=[];
                        var aryType=[];
                        for(var i=0;i<formView.length;i++){
                            var o=formView[i];
                            aryKey.push(o.key);
                            aryName.push(o.name);
                            aryType.push(o.type);
                        }
                        if(!row){
                            formGrid.addRow({
                                formAlias: aryKey.join(","),
                                formName: aryName.join(","),
                                type: aryType.join(","),
								isAll:true
                            });
                        }else {
                            formGrid.updateRow(row, {
                                formAlias: aryKey.join(","),
                                formName: aryName.join(","),
                                type: aryType.join(",")
                            });
                        }
                    }};
				openBpmFormViewDialog(conf);
			}
			
			function clearData(e,fields){
				var obj=e.sender;
				obj.setValue("");
				obj.setText("");
				var ary=fields.split(",");
				var row=formGrid.getSelected();
				var obj={};
				for(var i=0;i<ary.length;i++){
					obj[ary[i]]="";
				}
				formGrid.updateRow(row,obj);
			}
		</script>
	</body>
	<body>