<%-- 
    Document   : 流程实例列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>我的草稿</title>
<%@include file="/commons/list.jsp"%>
<style>
	body .mini-fit .wed{
		text-align: center;
	}
</style>
</head>
<body>
	<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		    <div 
		    	title="流程方案分类" 
		    	region="west" 
		    	width="240"  
		    	showSplitIcon="true"
		    	showCollapseButton="false"
		    	showProxy="false"
		    	class="layout-border-r">
		    	<div class="mini-fit">
					 <ul
						id="systree"
						class="mini-tree"
						url="${ctxPath}/bpm/core/bpmInst/getInstTree.do"
						style="width:100%; height:100%;"
						showTreeIcon="true"
						textField="name"
						idField="treeId"
						resultAsTree="false"
						parentField="parentId"
						expandOnLoad="true"
						onnodeclick="treeNodeClick"
					>
					</ul>
	            </div>
		    </div>
		    <div title="流程实例列表" region="center" showHeader="false" showCollapseButton="false">
		    	<div class="mini-toolbar">
		            <div class="searchBox">
		                <form id="searchForm" class="search-form">
		                    <ul>
		                       <li>
									<span class="text">单号：</span><input class="mini-textbox" name="Q_BILL_NO__S_LK"   />
								</li>
								<li>
									<span class="text">标题：</span><input class="mini-textbox" name="Q_SUBJECT__S_LK"   />
								</li>
								<li class="liBtn">
									<a class="mini-button"  plain="true" onclick="searchFrm()">查询</a>
									<a class="mini-button btn-red"  plain="true" onclick="clearForm()">清空查询</a>
									<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
										<em>展开</em>
										<i class="unfoldIcon"></i>
									</span>
								</li>
		                    </ul>
							<div id="moreBox">
								<ul>
									<li>
										<span class="text">发起时间：</span>
										<input name="Q_CREATE_TIME__START_D_GE" class="mini-datepicker" format="yyyy-MM-dd" />
									</li>
									<li>
										<span class="text-to">&nbsp;至：</span>
										<input name="Q_CREATE_TIME__END_D_LE" class="mini-datepicker" format="yyyy-MM-dd" />
									</li>
								</ul>
							</div>
		                </form>
		            </div>
					<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
						<i class="icon-sc-lower"></i>
					</span>
				</div>
				<div class="mini-fit rx-grid-fit">
					<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
						url="${ctxPath}/bpm/core/bpmInst/listDrafts.do" idField="instId" multiSelect="true" showColumnsMenu="true"
						sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
						<div property="columns">
							<div type="indexcolumn" width="20" style="text-align:center;" class="wed" headerAlign="center">序号</div>
							<div name="action" cellCls="actionIcons" width="80" headerAlign="" align="" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
							<div field="treeName" width="60" headerAlign="" >分类</div>
							<div field="billNo" width="80" headerAlign="" allowSort="true">单号</div>
							<div field="subject" width="200" headerAlign="" allowSort="true">标题</div>
							<div field="createTime" width="60" headerAlign="" allowSort="true">创建时间</div>
						</div>
					</div>
				</div>
			</div>
	</div>
<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.core.entity.BpmInst" winHeight="450" winWidth="700" entityTitle="流程实例"
		baseUrl="bpm/core/bpmInst" />
	<script type="text/javascript">
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pk = record.pkId;
	            
	            var s = '<span class="" title="明细" onclick="informRow(\'' + pk + '\')">明细</span>'
	                    + ' <span class="" title="删除" onclick="delDraftRow(\'' + pk + '\')">删除</span>'
	            		+ ' <span class="" title="启动流程" onclick="startRow(\'' + record._uid + '\')">启动流程</span>';
	            return s;
	        }
        	
	        function onSearch(){
				var formData=$("#searchForm").serializeArray();
				var data=jQuery.param(formData);
				grid.setUrl("${ctxPath}/bpm/core/bpmInst/listDrafts.do?"+data);
				grid.load();
			}
        			
        	function informRow(pkId) {
		    	var obj=getWindowSize();
		        _OpenWindow({
		        	url: __rootPath +"/bpm/core/bpmInst/inform.do?instId=" + pkId,
		            title: "流程实例明细", width: obj.width, height: obj.height
		        });
		    }
        	
        	
			function delDraftRow(pkId) {
	            if (!confirm("确定删除选中记录？")) return;
	            _SubmitJson({
	            	url:__rootPath +"/bpm/core/bpmInst/delDraft.do",
	            	method:'POST',
	            	data:{ids: pkId},
	            	 success: function(text) {
	                    grid.load();
	                }
	             });
	        }

        	
	        function startRow(uid){
        		var row=grid.getRowByUID(uid);
        		_OpenWindow({
        			title:row.subject+'-流程启动',
        			url:__rootPath+'/bpm/core/bpmInst/start.do?instId='+row.instId,
        			max:true,
        			height:400,
        			width:800,
        			ondestroy:function(action){
        				if(action=='ok'){
        					grid.load();
        				}
        			}
        		});
        	}
        	
	        grid.on("drawcell", function (e) {
	            var record = e.record,
		        field = e.field,
		        value = e.value;

	            //格式化日期
	            if (field == "createTime") {
	                if (mini.isDate(value)) e.cellHtml = mini.formatDate(value, "yyyy-MM-dd HH:mm");
	            }
	            
	            if(field=='subject'){
	            	e.cellHtml= '<a href="javascript:startRow(\'' + record._uid + '\')">'+record.subject+'</a>';
	            }
	            
	            if(field=='createBy'){
	            	if(value){
	            		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>';
	            	}else{
	            		e.cellHtml='<span style="color:red">无</span>';
	            	}
	            }
	        });
	        
	        grid.on('update',function(){
	        	_LoadUserInfo();
	        });
	        
	        function treeNodeClick(e){
		   		var node=e.node;
		   		grid.setUrl(__rootPath+'/bpm/core/bpmInst/listDrafts.do?treeId='+node.treeId);
		   		grid.load();
		   	}
	        
        </script>
	
</body>
</html>