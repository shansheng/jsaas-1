<%-- 
    Document   : 联系人分组编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>联系人分组编辑</title>
<%@include file="/commons/edit.jsp"%>
	<style>
		.addRecord{
			display: flex;
			border: 1px solid #eee;
		}
		.addRecord .addRecord-center{
			width: 100px;
			padding: 0 10px;
			border: 1px solid #eee;
			border-bottom: 0px;
			border-top:0px;
			display: flex;
			align-items: center;
			justify-content: center;
			flex-direction: column;
		}
		.addRecord .addRecord-center .mini-button{
			margin-bottom: 4px;
		}
		.addRecord .addRecord-left,
		.addRecord .addRecord-right{
			flex: 1;
		}
		.mini-listbox-border{
			border: 0;
		}
	</style>
</head>
<body>
	<div id="toolbar1" class="topToolBar">
		<div>
			<a class="mini-button"  plain="true" onclick="save">保存</a>
			<a id="del" class="mini-button btn-red"  plain="true" onclick="delGrp">删除此分组</a>
		</div>
	</div>
	<div class="mini-fit">
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<input id="pkId" name="groupId" class="mini-hidden" value="${addrGrp.groupId}" />
			<div style="padding: 6px 0;">
				分组名字 ： <input name="name" value="${addrGrp.name}" class="mini-textbox" vtype="maxLength:50" style="width: 50%" required="true" emptyText="请输入分组名字" />
			</div>
			<div class="addRecord">
				<div class="addRecord-left">
					<div id="leftInfo" class="mini-fit">
						<ul id="tree2" class="mini-tree" url="${ctxPath}/oa/personal/addrGrp/getAllGrpAndBook.do" style="width: 200px; padding: 5px;" showTreeIcon="false" textField="name" idField="gabId" parentField="parentId" resultAsTree="false" showCheckBox="true" checkRecursive="true" allowSelect="false" enableHotTrack="false" showTreeLines="true">
						</ul>
					</div>
				</div>
				<div class="addRecord-center">
					<a class="mini-button " onclick="add()">添加联系人</a>
					<a class="mini-button btn-red" plain="true" onclick="removes">移除联系人</a>
				</div>
				<div class="addRecord-right">
					<div id="listbox2" class="mini-listbox" style="height: 200px;" showCheckBox="true" multiSelect="true" url="${ctxPath}/oa/personal/addrBook/getAddrBookByGroupId.do?groupId=${param['pkId']}">
						<div property="columns">
							<div header="已有联系人" field="name"></div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/personal/addrGrp" />
	<script type="text/javascript">
	addBody();
    mini.parse();
    var tree = mini.get("tree2");
    var listbox2 = mini.get("listbox2");
    var btnDelGrp=mini.get("del");       //删除分组按钮
    var id='${addrGrp.groupId}';

    /*判断是否屏蔽分组按钮*/
     $(function(){                    
    	if(id=='')
    		btnDelGrp.setVisible(false);
    	else
    		btnDelGrp.setVisible(true);
    }); 
    
    /*将左边的树的联系人添加到右边的listbox*/
    function add() {               
        var items = tree.getCheckedNodes(false);     //获取选中节点且不添加父节点到listbox
        for(var i=0;i<items.length;i++){
        	var flag=false;
        	if(items[i].parentId==null)       //如果ID为0，则为父节点 则不添加
        		continue;
        	var listBoxData=listbox2.getData();
        	if(listBoxData.length<=0)
        		listbox2.addItem(items[i]);
        	else{
	        	for(var j=0;j<listBoxData.length;j++){
	        		if(typeof(listBoxData[j].addrId)!="undefined"){
	        			if(listBoxData[j].addrId!=items[i].gabId)
		        			continue;
		        		else{
		        			flag=true;
		        			break;
		        		}
	        		}else{
		        		if(listBoxData[j].gabId!=items[i].gabId)
		        			continue;
		        		else{
		        			flag=true;
		        			break;
		        		}
	        		}
	        	}
	        	if(!flag){
	        		listbox2.addItem(items[i]);     //listbox添加元素
	        	}
        	}
        }
    }
    
    /*删除当前分组*/
    function delGrp(){                   
        if (confirm("确定当前分组？")) {
            _SubmitJson({
            	url:__rootPath+"/oa/personal/addrGrp/del.do",
            	data:{
            		ids:id
            	},
            	method:'POST',
            	success:function(){
            		CloseWindow('ok'); 
            	}
            });
            top['grp'].refreshMenu();         //刷新联系人分组
        }
    }
    
    /*关闭窗口*/
    function exit(){   
    	CloseWindow('canel'); 
    }

    /*保存listbox里面的联系人*/
    function save(){                      
        form.validate();
        if (!form.isValid()) {
            return;
        }
    	var formJson=_GetFormJson("form1");
    	var listBoxData=listbox2.getData();
      	_SubmitJson({
    		url:__rootPath+"/oa/personal/addrGrp/saveGrp.do",
    		data:{
    			formData:mini.encode(formJson),
    			listData:mini.encode(listBoxData)
    		},
    		method:'POST',
    		success:function(){
    			CloseWindow('ok'); 
    		}
    	});  
    }
    
    /*移除listbox内所有联系人*/
    function removes() {                  
        var items = listbox2.getSelecteds();
        listbox2.removeItems(items);
    }
    


	</script>

</body>
</html>