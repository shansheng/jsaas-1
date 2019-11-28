<%-- 
    Document   : 文件夹和文件共同（treegrid）列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
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
	 <ul id="popupFileMenu" class="mini-menu" style="display:none;">
	    <li iconCls="icon-html" onclick="addRow3('html')">文件</li>
    </ul>
    <ul id="rightClickFileMenu" class="mini-menu" style="display:none;">
	    <li iconCls="icon-html" onclick="addDocOnThat('html')">文件</li>

    </ul>
	
	 <div id="toolbar1" class="mini-toolbar" style="padding:2px;">
	  	<a class="mini-menubutton" iconCls="icon-add" plain="true" menu="#popupFileMenu" id="newFile">新增文件</a>
		 <a class="mini-button noneFile" iconCls="icon-remove"  onclick="delMyRow()">删除</a>
		 <a class="mini-button noneFile" iconCls="icon-detail"  onclick="movementCopy()">复制/移动</a>
		 <a class="mini-button noneFile" iconCls="icon-save"  onclick="updateFileMessage()">保存</a>
		 <a class="mini-button" iconCls="icon-refresh" plain="true" onclick="location.reload(true)">页面刷新</a>
    </div>
	<div class="mini-fit rx-grid-fit">
		<div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" allowResize="false"
			 ondrawnode="onDrawNode" url="${ctxPath}/flie/tray/flieTrayBasic/getByRefId.do?folderId=${folderId}&labelText=${labelText}&fileSelect=${fileSelect}" onnodedblclick="openNew()"  idField="ID_" multiSelect="true" showColumnsMenu="true"
			 sizeList="[5,10,20,50,100,200,500]" pageSize="20"   allowCellEdit="true" allowCellSelect="true"  pagerButtons="#pagerButtons">


			<div property="columns">
				<div type="checkcolumn"></div>
				<div name="action" cellCls="actionIcons" width="22"
					headerAlign="center" align="center" renderer="onActionRenderer">操作</div>
				<div  name="name" field="name" width="160" headerAlign="center"  align="left">文档名称
					<input property="editor" class="mini-textbox" style="width:100%;"/>
				</div>
				<div  name="fileSize" field="fileSize" width="160" headerAlign="center"  align="left">文档大小
				</div>
				<div  name="docFname" field="docFname" width="160" headerAlign="center"  align="left">自定义名称
					<input property="editor" class="mini-textbox" style="width:100%;"/>
				</div>
				<div name="author" field="author" width="60" headerAlign="center" >创建人
				</div>
				<div name="docLabel" field="docLabel" width="60" headerAlign="center" >标签
					<input property="editor" class="mini-combobox" allowInput="true" style="width:100%;" url="${ctxPath}/flie/tray/flieTrayBasic/backDownBox.do" />
				</div>
				<div name="createTime" field="createTime"  dateFormat="yyyy-MM-dd" width="60" headerAlign="center" >创建时间</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	mini.parse();	
	

	/*获取页面传来的值*/
	var folderId="${folderId}";
    var secKey="${secKey}";
    var tenantId = "${tenantId}";

	var grid=mini.get('datagrid1');

	console.log(grid.data);
	var eidtT = false;
	var deleteT = false;
		//禁用树右键菜单以及禁用增加文件夹
	   //根据folderId与userId查询是否具有权限 修改 删除 添加

	grid.load();


    var saveData = [];
    grid.on("cellcommitedit",function(e){
        var record = e.record;
        saveData.push(record);
        console.log(saveData);
	})


    $(function(){
       if(secKey=="read")
	   {
           $("#newFile").css("display","none");

           $(".mini-button.noneFile").css("display","none");

       }
    });


    //授权用户组
    function movementCopy(){
        var ids = _GetGridIds("datagrid1");
        if(ids=="") {
            alert("请选择文件!");
            return;
        }
        mini.open({
            showMaxButton: false,
            allowResize: false,
            title:'复制/移动文件',
            url:__rootPath+'/flie/tray/flieTrayBasic/toGrant.do?groupId='+ folderId + '&tenantId='+tenantId+"&ids="+ids.join(","),
            width:450,
            height:600,
            onload: function () {
            },
            ondestroy: function (action) {
                grid.load();
            }
        });
        // _OpenWindow({
        //     title:'复制/移动文件',
        //     url:__rootPath+'/flie/tray/flieTrayBasic/toGrant.do?groupId='+ folderId + '&tenantId='+1,
        //     width:450,
        //     height:600,
			// onload:function() {
        //         var iframe = this.getIFrameEl();
        //         var data = {action: "edit", pWin: window};
        //         iframe.contentWindow.setData(data);
        //     },
        //     ondestroy : function(action) {
        //         grid.load();
        //     }
        // });
    }

	//设置文件夹图标
    function onDrawNode(e) {
        var tree = e.sender;
        var node = e.node;
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
                   window.parent.grid.load();
               }
      			}
      		});
          }
      }); 
	}
	
	
	//编辑节点
	 function editMyRow() {    
		var node = grid.getSelectedNode();
		var pkId=node.id;
		if(node.type=="文件夹"){
        	_OpenWindow({
       		 url: "${ctxPath}/online/tree/videoUpload/edit.do?pkId="+pkId+"&fileId="+folderId,
               title: "编辑文件夹",
               width: 690, height: 300,
               ondestroy: function(action) {
               	
                   if (action == 'ok') {
                       grid.reload();
                       window.parent.grid.load();
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
                       window.parent.grid.load();
                   }
               }
       	});
           }
    }  
	 
	 //当前页面新增文件
	 function addRow3(docType) {  
         _OpenWindowFileDown({
                url: "${ctxPath}/flie/tray/flieTrayBasic/addFile.do?fileId="+folderId,
	            title: "新增文件",
	            width: 850, height: 700,
	            ondestroy: function(action) {
	                if (action == 'ok') {
	                    grid.reload();
	                }
	            }
	    	});
	    }

    function _OpenWindowFileDown(config){

        if(!config.iconCls){
            config.iconCls='icon-window';
        }

        if(typeof(config.allowResize)=='undefined'){
            config.allowResize=true;
        }

        if(typeof(config.showMaxButton)=='undefined'){
            config.showMaxButton=true;
        }
        if(typeof(config.showModel)=='undefined'){
            config.showModel=true;
        }

        var win=mini.open({
            iconCls:config.iconCls,
            allowResize: config.allowResize, //允许尺寸调节
            allowDrag: true, //允许拖拽位置
            showCloseButton: false, //显示关闭按钮
            showMaxButton: config.showMaxButton, //显示最大化按钮
            showModal: config.showModel,
            url: config.url,
            title: config.title,
            width:config.width,
            height: config.height,
            onload: function() {
                if(config.onload){
                    config.onload.call(this);
                }
            },
            ondestroy:function(action){
                if(config.ondestroy){
                    config.ondestroy.call(this,action);
                }
            }
        });
        var flag=false;
        var el = win.getHeaderEl();
        $(el).dblclick(function () {
            if (!flag) {
                win.max();
                mini.layout();
                flag = true;
            } else {
                win.restore();
                flag = false;
            }
        });

        if(config.max){
            win.max();
            mini.layout();
            flag=true;
        }
    }

	//删除节点
		function delMyRow() {
            var ids = _GetGridIds("datagrid1");
            if (confirm("确定删除此文件?")) {
                $.ajax({
                    type: "Post",
                    url : '${ctxPath}/flie/tray/address/del.do',
                    data: {"ids":ids.join(',')},
                    success: function (result) {
                        _ShowTips({
                            msg:"删除成功!"
                        });
                        grid.load();
                    }
                });
            }

		}
	
		//节点增加文件夹
		 function addrowfolder() {    
			var node = grid.getSelectedNode();
			var pkId=node.dafId;

			var folder;
			 $.ajax({
	          url: "${ctxPath}/oa/doc/docFolder/getOne.do?folderId="+folderId,
	          success: function (text) {
	          	folder = mini.decode(text);
	          	_OpenWindow({
	      			url : '${ctxPath}/oa/doc/docFolder/edit.do?parent='+pkId+"&path="+folder.userId+"&type="+folder.type,
	      			title : "新增文件夹",
	      			width : 600,
	      			height : 400,
	      			onload : function() {
	      			},
	      			ondestroy : function(action) {
	      				if (action == 'ok') {
	                   location.reload(true);
	                   window.parent.grid.load();
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
	         var s='';
	         s+= '<span class="icon-import"  title="下载" onclick="downMyRow()"></span>';
					if(secKey!="read")
					{
						  //s+= ' <span class="icon-edit" title="编辑" onclick="editMyRow()"></span>';
					}
	            return s;
	        }
        	//移动文件
        	function moveTo(){
				var node = gird.getSelectedNode();
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
        	
        	//下载功能按钮
	        function downMyRow() {
                var row = grid.getSelected();
                var path=row.docPath;
                var docNameValue=row.name;
				//var url = "http://localhost:8080/file/down.do";
				var url = "http://120.78.80.17:9080/file/down.do";
                var myform = $("<form></form>");
                myform.attr('method','post')
                myform.attr('action',url);

                var pathTruth = $("<input type='hidden' name='pathTruth' />");
                var docName = $("<input type='hidden' name='docName' />");
                var ip = $("<input type='hidden' name='ip' />");
                pathTruth.attr('value',path);
                docName.attr('value',docNameValue);
                // ip.attr('value',"192.168.1.90:80");
                ip.attr('value',"120.27.12.48");
                myform.append(pathTruth);
                myform.append(docName);
                myform.append(ip);
                myform.appendTo('body').submit(); //must add this line for higher html spec
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
				var node = grid.getSelectedNode();
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

        	function updateFileMessage() {
	            if(saveData.length==0) {
                    alert("请修改文件后再进行保存操作");
                }
                else
				{
                    //ajax保存成功并刷新页面
                    $.ajax({
                        type:"POST",
                        url:"${ctxPath}/flie/tray/flieTrayBasic/updateFileMessage.do",
                        dataType:"json",
                        contentType:"application/json",
                        data:JSON.stringify(saveData),
                        success:function(data){
                            if(data.success==true) {
                                alert("更新成功");
                                saveData = [];
                                grid.load();
                            }
                            else {
                                alert("上传错误,错误原因:"+data.message);
                            }
                        }
                    });
				}
            }
        	
        	
        //打开文档视图模式	
        function openNew(){
     	  var node = grid.getSelectedNode();
     	 if(node.type=="文件夹"){
     			_OpenWindow({
			       		 url: "${ctxPath}/oa/doc/docFolder/listBoxWindow.do?folderId="+node.dafId+"&type="+type+"&firstOpenId="+node.dafId,
			               title: "文档视图",
			               width: 790, height: 580,
			               ondestroy: function(action) {
			               	if(action=='close')
			               		grid.load();
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
       
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1"
		entityName="com.airdrop.online.tree.entity.VideoUpload" winHeight="450"
		winWidth="700" entityTitle="文档" baseUrl="online/tree/videoUpload"  />
</body>
</html>