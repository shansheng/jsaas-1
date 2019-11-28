<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/commons/list.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${insColumn.name}-公告信息列表</title>
</head>
<body>
	<div class="mini-toolbar">
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						标题 ：<input class="mini-textbox" id="subject" name="Q_subject__S_LK" emptyText="请输入标题" /> 
					</li>
					<li>
						关键字：<input class="mini-textbox" id="keywords" name="Q_keywords__S_LK" emptyText="请输入关键字" />
					</li>

					<li class="liBtn">
							<a class="mini-button _search" onclick="onSearch">搜索</a>
							<a class="mini-button _reset" onclick="onClear">清空</a>
							<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
								<em>展开</em>
								<i class="unfoldIcon"></i>
							</span>
					</li>
				</ul>
				<div id="moreBox">
					<ul>
						<li>
							作者：<input class="mini-textbox" id="author" name="Q_author__S_LK" emptyText="请输入作者" />
						</li>
					</ul>
				</div>
			</form>
		</div>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
    </div>
	<div class="mini-fit" style="height: 100px;">
		<div 
			id="newsgrid" 
			class="mini-datagrid" 
			style="width: 100%; height: 100%;" 
			allowResize="false" 
			url="${ctxPath}/oa/info/insNews/listByColId.do?colId=${colId}" 
			idField="newId" 
			multiSelect="true" 
			showColumnsMenu="true" 
			sizeList="[5,10,20,50,100,200,500]" 
			pageSize="20" 
			onrowdblclick="onRowDblClick" 
			ondrawcell="onDrawCell" 
			allowAlternating="true"
		>
			<div property="columns">
				<div type="checkcolumn" width="20"  headerAlign="center" align="center"></div>
				<div field="action" name="action" cellCls="actionIcons" width="60" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="subject" width="150"  allowSort="true">标题</div>
				<div field="keywords" width="100"  allowSort="true">关键字</div>
				<div field="readTimes" width="80"  allowSort="true">阅读次数</div>
				<div field="author" width="80"  allowSort="true">作者</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
			mini.parse();
			//用于弹出的子页面获得父窗口
			top['main']=window;
			
			var colId='${colId}';
			var grid=mini.get('newsgrid');
			grid.load();
			var portal = "${param['portal']}";
			function onDrawCell(e) {
				var record = e.record;
				var uid = record.pkId;
				//功能键
				if (e.field == "action") {
					if (portal == "YES") {
						e.cellHtml = '<span  title="明细" onclick="detailRow(\'' + uid + '\')">明细</span>';
					}
				}
				//超链接
				if (e.field == "subject") {
					var sub = record.subject;
					e.cellStyle = "text-align:left";
					e.cellHtml = '<a href="javascript:detailRow(\'' + uid + '\')">' + sub + '</a>';

				}
			}
			function onRowDblClick(e) {
				var record = e.record;
				var pkId = record.pkId;
				var row = grid.getSelected();
				var title = row.subject;
				_OpenWindow({
					title:title,
					url:__rootPath+'/oa/info/insNews/get.do?permit=no&pkId='+pkId,
					width:800,
					height:800,
					//max:true
				});
			}
			//功能键
	        function onActionRenderer(e) {
	            var record = e.record;
	            var uid = record.pkId;
	            var s = '<span title="明细" onclick="detailRow(\'' + uid + '\')">明细</span>'
	            + '<span title="删除" onclick="delNew(\'' + uid + '\')">删除</span>';
	            return s;
	        }
			
			function editNew(pkId){
				var colId = '${colId}';
				_OpenWindow({
					title:"编辑",
					url:__rootPath+'/oa/info/insColNew/edit.do?pkId='+pkId+'&colId='+colId,
					width:800,
					height:450,
				});
			}
			
			//查看明细
			function detailRow(pkId){
				var row = grid.getSelected();
				var title = row.subject;
				_OpenWindow({
					title:title,
					url:__rootPath+'/oa/info/insNews/get.do?permit=no&pkId='+pkId,
					width:800,
					height:800,
					//max:true
				});
			}
			//清空查询
			function onClear(){
				$("#searchForm")[0].reset();		
			}
			//查询
			function onSearch(){
				var formData=$("#searchForm").serializeArray();
				var filter=mini.encode(formData);
				grid.setUrl(__rootPath+'/oa/info/insNews/listByColId.do');
				grid.load({"colId":colId,"filter":filter});
			}
			
			//弹出选择新闻加入此栏目的页面
			function showInfoDialog(){
				_OpenWindow({
					title:'加入信息至栏目-${insColumn.name}',
					url:__rootPath+'/oa/info/insNews/dialog.do',
					width:800,
					height:500,
					ondestroy:function(action){
						if(action!='ok')return;
						var iframe = this.getIFrameEl();
			            var newsIds = iframe.contentWindow.getNewsIds();
			            if(newsIds=='')return;
			            _SubmitJson({
			            	url:__rootPath+'/oa/info/insNews/joinColumn.do',
			            	data:{
			            		colId:'${colId}',
			            		newsIds:newsIds
			            	},
			            	method:'POST',
			            	success:function(e){
			            		grid.load();
			            	}
			            });
			            
					}
				});
			}
			
			//删除此栏目与此新闻的关系
			function delNew(pkId){
				var colId = '${colId}';
				if (!confirm("确定删除选中记录？")) return;
		        _SubmitJson({
		        	url:__rootPath + '/oa/info/insColNewDef/delNew.do',
		        	method:'POST',
		        	data:{ids: pkId,
		        		  colId:colId},
		        	 success: function(text) {
		                grid.load();
		            }
		         });
			}
	</script>
</body>
</html>