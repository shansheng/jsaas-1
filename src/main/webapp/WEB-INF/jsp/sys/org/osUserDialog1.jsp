<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>[FORM_VALID_RULE]编辑</title>
	<%@include file="/commons/edit.jsp"%>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="formValidRule.id" />
<div class="mini-fit">
<div class="form-container">
	<form id="form1" method="post">
		<table class="table-detail column-two" cellspacing="1" cellpadding="0">
			<caption>用户权限设置</caption>
			<tr>
				<td>用户选择：</td>
				<td>
					<div>
						<input id="userLinks" name="userLinks" allowInput="false" class="mini-textboxlist"  style="width:200px;height: 30px" value="" text="" />
						<a class="mini-button"  plain="true" onclick="addUsers">用户</a>
					</div>
				</td>
			</tr>
			<tr>
				<td>角色选择：</td>
				<td>
						<div
								id="groupGrid"
								class="mini-treegrid"
								style="width:100%;min-height:20px;"
								showTreeIcon="true"
								onbeforeload="onBeforeGridTreeLoad"
								resultAsTree="false"
								treeColumn="name"
								idField="groupId"
								parentField="parentId"
								allowResize="true"
								onlyCheckSelection="true"
								allowRowSelect="true"
								allowUnselect="true"
								onbeforeload="userLoaded"
								allowAlternating="true"
								url="${ctxPath}/sys/org/sysOrg/searchQY.do?showDimId=2&tenantId=&excludeAdmin="
								multiSelect="true"
								showPager="false"
								showPageIndex="false"
								showPageInfo="false"
						>
							<div property="columns">
								<div type="checkcolumn" width="40"></div>
								<div field="name" name="name" displayfield="name" width="180" headerAlign="center" allowSort="true">
									名称
								</div>
								<div field="key" width="130" headerAlign="center" allowSort="true">标识Key</div>
							</div>
						</div>

				</td>
			</tr>
		</table>
	</form>
</div>
</div>
<script type="text/javascript">
	mini.parse();
	var userList = [];
	//当前操作的机构ID
	var tenantId='${param.tenantId}';
	var isSuperAdmin='${param.isSuperAdmin}';

    var groupId =${param.groupId};
	var groupGrid = mini.get("groupGrid");
	function addUsers(){
		var conf ={};
	   if(isSuperAdmin && isSuperAdmin==='true'){
		   conf ={
			   single:false,
			   callback :function(users){
				   addUser(users);
			   }
		   };
	   }else{
		   conf ={
			   single:false,
			   tenantId:tenantId,
			   orgconfig:"selOrg",
			   orgid:groupId,
			   showDimId:true,
			   callback :function(users){
				   addUser(users);
			   }
		   };

	   }
		_UserDialog(conf);
	}

	function addUser(users){
		var userLinks=mini.get("userLinks");
		var uIds=[];
		var uNames=[];
		for(var i=0;i<users.length;i++){
			var isCanAdd =true;
			if(userList.length>0){
				for(var j=0;j<userList.length;j++){
					if(userList[j].userId ==users[i].userId){
						isCanAdd =false;
						break;
					}
				}
			}
			if(isCanAdd){
				uIds.push(users[i].userId);
				uNames.push(users[i].fullname);
				userList.push(users[i]);
			}
		}
		if(userLinks.getValue()!=''){
			uIds.unshift(userLinks.getValue().split(','));
		}
		if(userLinks.getText()!=''){
			uNames.unshift(userLinks.getText().split(','));
		}
		userLinks.setValue(uIds.join(','));
		userLinks.setText(uNames.join(','));
	}

	function onOk() {
		if(userList.length ==0){
			alert("请选择用户！");
		}else if(!groupGrid.getSelecteds() || groupGrid.getSelecteds().length ==0){
			alert("请选择角色！");
		}else{
			CloseWindow('ok');
		}
	}
	//返回选择用户信息
	function getUsers(){
		return userList;
	}


	function onCancel() {
		CloseWindow('cancel');
	}

	function onBeforeGridTreeLoad(e) {

		var tree = e.sender;    //树控件
		var node = e.node;      //当前节点
		var params = e.params;  //参数对象

		//可以传递自定义的属性
		params.parentId = node.groupId; //后台：request对象获取"myField"
	}


	loadGroupRootNode();

	//当前维度一样时才切换
	function loadGroupRootNode() {
		var nodes = groupGrid.getRootNode().children;
		for (var i = 0; i < nodes.length; i++) {
			groupGrid.loadNode(nodes[0]);
		}
	}

	function userLoaded(e) {
		groupGrid.deselectAll(false);
	}

	//返回选择用户信息
	function getGroups() {
		return groupGrid.getSelecteds();
	}


</script>
</body>
</html>