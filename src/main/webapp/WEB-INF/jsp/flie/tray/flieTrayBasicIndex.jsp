<%-- 
    Document   : 文件夹和文件共同（treegrid）列表页
    Created on : 2018-6-19 14:43:10
    Author     : 杨义
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>文档列表管理</title>
<%@include file="/commons/list.jsp"%>
<style>.mini-panel-border{border-left:none;border-bottom: none;}</style>
</head>
<body>
	
	
	 <div id="toolbar1" class="mini-toolbar" style="padding:2px;">
	  	<a class="mini-button" iconCls="icon-add" plain="true"  id="newFile">新增文件夹</a>
			                 		
		<span class="separator"></span>
        
		<a class="mini-button" iconCls="icon-refresh" plain="true" onclick="location.reload(true)">页面刷新</a>
	    <span class="separator"></span>
	 <input class="text text-border" id="key" name="key" />    
	  <a class="mini-button" plain="true" iconCls="icon-search" onclick="searchForSomeKey" tooltip="包含该字段的条目">查找</a>
    </div>
 <div class="mini-fit rx-grid-fit" style="padding-top:12px;">
            <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;border" allowResize="false"
                 ondrawnode="onDrawNode" url="${ctxPath}/flie/tray/flieTrayBasicJpa/listData.do" onnodedblclick="openNew()" idField="ID_" multiSelect="false" showColumnsMenu="true"
                 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true"  pagerButtons="#pagerButtons">

			<div property="columns">
                <div type="checkcolumn"></div>
				<div name="action" cellCls="actionIcons" width="22"
					headerAlign="center" align="center" renderer="onActionRenderer" allowSort="true">操作</div>
				<div   field="fileTrayName"  width="160" headerAlign="center"  align="left"  allowSort="true">文档名称</div>
				<div  field="adminName" width="60" headerAlign="center" allowSort="true">管理员</div>
				<div  field="createTime"  dateFormat="yyyy-MM-dd" width="60" headerAlign="center" allowSort="true">创建时间</div>
				<div  field="permissionName"  width="60" headerAlign="center" allowSort="true">权限</div>
			</div>
		</div>
	</div>
<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.airdrop.flie.tray.entity.FlieTrayBasic" winHeight="450"
		winWidth="700" entityTitle="文档" baseUrl="flie/tray/flieTrayBasic"  />
	<script type="text/javascript">
// 	mini.parse();	

	/*获取页面传来的值*/
	var folderId="${fileId}";
	var multi="${multi}";
	var type ="${type}";
	var isShare="${isShare}";
	var grid=mini.get('datagrid1');
	var eidtT = false;
	var deleteT = false;
	
	
		//禁用树右键菜单以及禁用增加文件夹
	   //根据folderId与userId查询是否具有权限 修改 删除 添加

	$("#newFile").click(function()
	{
			_OpenWindow({
				url : '${ctxPath}/flie/tray/flieTrayBasic/edit.do?pageType=new', 
				title : "新建文件夹",
				width : 600,
				height : 400,
				method : 'POST',
				onload : function() {

				},
				ondestroy : function(action) {
					if (action == 'ok')
						{
						grid.load();
						}
				}

			});
 	}		
	);
	
	
	
	//设置文件夹图标
    function onDrawNode(e) {
        var tree = e.sender;
        var node = e.node;
        console.log(node.name);
        switch (node.type)
               {
               case "文件夹":
               	e.iconCls='icon-folder';
                 break;
               case "html":
                  	e.iconCls='icon-html';
                    break;
               case "doc":
            	   e.iconCls='icon-myword';
                 break;
               case "docx":
            	   e.iconCls='icon-myword';
                 break;
               case "xls":
            	   e.iconCls='icon-myexcel';
               	break;
               case "xlsx":
            	   e.iconCls='icon-myexcel';
                 break;
               case "ppt":
            	   e.iconCls='icon-myppt';
                 break;
               case "pptx":
            	   e.iconCls='icon-myppt';
                   break;
               }
    	if(node.name.length>15){
    		var shortnodeName=node.name.substring(0,14)+"…";
    	e.nodeHtml= '<a title="' +node.name+ '">' +shortnodeName+ '</a>';
    	}else{
    		e.nodeHtml= '<a title="' +node.name+ '">' +node.name+ '</a>';
    	}
    }
	//toolbar新增文件夹按钮
	function addFolder(){
		var folder;
		 $.ajax({
          url: "${ctxPath}/oa/doc/docFolder/getOne.do?folderId="+folderId,
          success: function (text) {
          	folder = mini.decode(text);
          	_OpenWindow({
      			url : '${ctxPath}/oa/doc/docFolder/edit.do?parent='+folderId+"&path="+folder.userId+"&type="+folder.type,
      			title : "新增文件夹",
      			width : 600,
      			height : 400,
      			onload : function() {
      			},
      			ondestroy : function(action) {
      				if (action == 'ok') {
                   location.reload(true);
                   window.parent.tree.load();
               }
      			}
      		});
          }
      }); 
	}
	
	
	//编辑节点
	 function editMyRow(pkId) {    
		if(true){
        	_OpenWindow({
       		 url: "${ctxPath}/flie/tray/flieTrayBasic/edit.do?pkId="+pkId+"&fileId="+folderId+"&pageType=update",
               title: "编辑文件夹",
               width: 690, height: 300,
               ondestroy: function(action) {
               	
                   if (action == 'ok') {
                       grid.reload();
                   }
               }
       	});	
    	}else{
            _OpenWindow({
       		 url: "${ctxPath}/online/tree/videoUpload/edit.do?pkId="+pkId+"&fileId="+folderId,
               title: "编辑文件",
               width: 850, height: 750,
               ondestroy: function(action) {
               	
                   if (action == 'ok') {
                       grid.reload();
                       window.parent.tree.load();
                   }
               }
       	});
           }
    }  
	 
	 //当前页面新增文件
	 function addRow3(docType) {  
			var grid=mini.get('datagrid1');
	        _OpenWindow({
	    		 url: "${ctxPath}/online/tree/videoUpload/create.do?fileId="+folderId+"&type="+type + '&docType='+docType,
	            title: "新增文件",
	            width: 850, height: 780,
	            ondestroy: function(action) {
	                if (action == 'ok') {
	                    grid.reload();
	                }
	            }
	    	});
	    }  

	//删除节点
		function delMyRow() {
		 	var tree = mini.get("datagrid1");
			var node = tree.getSelectedNode();
			var isLeaf = tree.isLeaf(node);
			var id=node.id;
			if (node.type!="文件夹") {
				if (confirm("确定删除此文件?")) {
					$.ajax({
		                type: "Post",
		                url : '${ctxPath}/online/tree/videoUpload/del.do?ids='+id,
		                data: {},
		                beforeSend: function () {
		                },
		                success: function () {
		                }
		            }); 
					tree.removeNode(node);
					 window.parent.tree.load();
				}
			}else if(node.type=="文件夹"){
				if (confirm("确定删除此文件夹?")) {
					$.ajax({
		                type: "Post",
		                url : '${ctxPath}/oa/doc/docFolder/delContain.do?folderId='+ids+"&type="+type,
		                data: {},
		                beforeSend: function () { 
		                },
		                success: function () {
		                	tree.removeNode(node);
		                	 window.parent.tree.load();
		                }
		            }); 
					
				}
			}
			
		}
	
		//节点增加文件夹
		 function addrowfolder() {    
			var tree = mini.get("datagrid1");
			var node = tree.getSelectedNode();
			var pkId=node.dafId;
			var grid=mini.get('datagrid1');
			
			var folder;
			 $.ajax({
	          url: "${ctxPath}/oa/doc/docFolder/getOne.do?folderId="+folderId,
	          success: function (text) {
	          	folder = mini.decode(text);
	          	_OpenWindow({
	      			url : '${ctxPath}/oa/doc/docFolder/edit.do?parent='+pkId+"&path="+folder.userId+"&type="+folder.type+"&pageType=new",
	      			title : "新增文件夹",
	      			width : 600,
	      			height : 400,
	      			onload : function() {
	      			},
	      			ondestroy : function(action) {
	      				if (action == 'ok') {
	                   location.reload(true);
	                   window.parent.tree.load();
	               }
	      			}
	      		});
	          }
	      }); 
	    }  
		/* 
		
             var menu = mini.get("rightClickFileMenu");
             menu.showAtPos(e.pageX, e.pageY);
	  */
        	//行功能按钮
	        function onActionRenderer(e){		
			 var record = e.record;
	         var type=record.type;
			var pkId = record.pkId;
			var permissionValue = record.permissionValue;
			var permissionName = record.permissionName;
			var s = '';
			console.log(permissionValue);
			if(permissionValue=="admin")
			{
				 s+= '<span class="icon-detail"  title="查看" onclick="detailMyRow()"></span>';
				 s+= ' <span class="icon-edit" title="编辑" onclick="editMyRow(\''+pkId+'\')"></span>'; 
				 s+='<span class="icon-remove" title="删除" onclick="delRow(\'' + pkId + '\')"></span>';
// 				 <a id="Remove" class="mini-button" data-options="{url:'/flie/tray/flieTrayBasic/del.do'}"   iconCls="icon-remove" onclick="onRemove">删除文件夹</a>
		    	 s+='<span class="icon-form" title="编辑权限" onclick="PermisionRow(\\\'edit\\\',\\\'\' + pkId + \'\\\'s)"></span>';
		    	 s+='<span class="icon-grant" title="阅读权限" onclick="PermissionRow(\'read\',\'' + pkId + '\')"></span>';
			}
			else 
			{
				s+= '<span class="icon-detail"  title="查看" onclick="detailMyRow()"></span>';
			}
			return s;
	        }
	  
		function PermissionRow(url,pkId){
			var type2 = "";
			var type2Name = "";
			if(url=="edit")
		    {
				type2 = "edit";
				type2Name = "编辑权限";
		    }
			else
		    {
				type2 = "read";
				type2Name = "阅读权限";
		    }
			var type2Title = type2Name;
			type2Name = encodeURI(encodeURI(type2Name));
			_OpenWindow({
				title : type2Title,
				width : 700,
				height : 400,
				url : __rootPath + '/filetray/authority/insPortalPermissionType/edit.do?layoutId=' + pkId + '&&type2=' + type2+ "&&type2Name=" + type2Name
			});
		}    
	    
        	//移动文件
        	function moveTo(){
        		var tree = mini.get("datagrid1");
				var node = tree.getSelectedNode();
				var pkId=node.dafId;
				_OpenWindow({
		       		 url: "${ctxPath}/oa/doc/docFolder/select.do?docId="+pkId+"&type="+type,
		               title: "选中要移动到的文件夹",
		               width: 450, height: 600,
		               ondestroy: function(action) {
		               
		                   if (action == 'ok') {
		                		location.reload("true");
		                   }
		               }
		       	});	
        	}
        	
        	//明细功能按钮
	        function detailMyRow() {    
	          window.location.href = "${ctxPath}/flie/tray/flieTrayBasic/left.do";
	        }
        	//条目按钮新增文档菜单
        	function addDocOnThis(e){
        		
        		e=e||window.event;
        		
        		var x=e.pageX || e.clientX+document.body.scrollLeft;
        		
        		var y=e.pageY || e.clientY+document.body.scrollTop;
        		
        		 var menu = mini.get("rightClickFileMenu");
                 menu.showAtPos(x,y);
        	}
        	
        	//条目按钮新增文档按钮
        	function addDocOnThat(docType){
        		var tree = mini.get("datagrid1");
				var node = tree.getSelectedNode();
				var pkId=node.dafId;
        		var grid=mini.get('datagrid1');
    	        _OpenWindow({
    	    		 url: "${ctxPath}/oa/doc/doc/edit.do?folderId="+pkId+"&type="+type+"&docType="+docType,
    	            title: "新增文档",
    	            width: 830, height: 710,
    	            ondestroy: function(action){
    	                if (action == 'ok') {
    	                    grid.reload();
    	                }
    	            }
    	    	});
        	}
        	
        	
        	//按某些字段查找
        	function searchForSomeKey(){
        		 var key = document.getElementById("key").value;
        		 	var grid=mini.get('datagrid1');
        		 	var encodekey=encodeURIComponent(key);
        			grid.setUrl("${ctxPath}/oa/doc/doc/getByKey.do?key="+encodekey+"&folderId="+folderId+"&multi="+multi+"&type="+type+"&isShare="+isShare);                                            
        			grid.load();
        	}
        	
        	
        //打开文档视图模式	
        function openNew(){
        	console.log("openNew");
          var tree = mini.get("datagrid1");
     	  var node = tree.getSelectedNode();
     	 if(node.type=="文件夹"){
     			_OpenWindow({
			       		 url: "${ctxPath}/oa/doc/docFolder/listBoxWindow.do?folderId="+node.dafId+"&type="+type+"&firstOpenId="+node.dafId,
			               title: "文档视图",
			               width: 790, height: 580,
			               ondestroy: function(action) {
			               	if(action=='close')
			               		tree.load();
			               }
			       	});
	            }else{
	            	_OpenWindow({
		        		 url: "${ctxPath}/online/tree/videoUpload/get.do?pkId="+node.id,
		                title: "文件明细",
		                width: 690, height: 600,
		                ondestroy: function(action) {
		                	if(action=='close'||action=='ok'){
		                	location.reload(true);
		                	}
		                }
		        	});
     	  }
     	  }
       
        
    	function onRemove(e){
			var row=grid.getSelecteds();
			if(row.length==0){
			   alert('请选择表格行');
			   return;
			}
			
			var url="/flie/tray/flieTrayBasic/del.do";
			if(e.sender && e.sender.url){
				url=e.sender.url;
			}
			url=__rootPath+url;
			mini.confirm("确定删除吗?", "提示信息", function(action){
                if (action != "ok")  return;
				var ids = [];
				
				for(var i=0; i < row.length; i++){
					if(row[i]['id']){
						ids.push(row[i]['id']);
					}else{
						grid.removeRow(row[i]);
					}
				}
				
				
				if(ids.length>0){
					_SubmitJson({url:url,method:"POST",data:{id:ids.join(',')},success:function(){
						grid.load();
					}}) ;
				}  
            })
		}
    	
        //删除行
        function delRow(pkId) {
        
        	if(isExitsFunction('_delRow')){
        		_delRow(pkId);
        		return;
        	}
        	
            if (!confirm("确定删除选中记录？")) return;
           
            _SubmitJson({
            	url:"/flie/tray/flieTrayBasic/del.do",
            	method:'POST',
            	data:{ids: pkId},
            	 success: function(text) {
                    grid.load();
                }
             });
        }

        </script>
</body>
</html>