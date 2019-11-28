<%-- 
    Document   : [SYS_WORDTE_MPLATE【模板表】]列表页
    Created on : 2018-05-16 11:29:19
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[SYS_WORD_TEMPLATE【模板表】]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		 <div class="searchBox">
			 <form id="searchForm" >
				 <ul>
					 <li><span class="text">模板名称：</span><input class="mini-textbox" name="Q_TEMPLATE_NAME__S_LK"></li>
					 <li><span class="text">名称：</span><input class="mini-textbox" name="Q_NAME__S_LK"></li>
					 <li class="liBtn">
						 <a class="mini-button"   plain="true" onclick="searchFrm()">查询</a>
						 <a class="mini-button btn-red"   plain="true" onclick="clearForm()">清空查询</a>
						 <span class="unfoldBtn" onclick="no_more(this,'moreBox')">
							<em>展开</em>
							<i class="unfoldIcon"></i>
						</span>
					 </li>
				 </ul>
				 <div id="moreBox">
					 <ul>
						 <li><span class="text">数据源：</span><input class="mini-textbox" name="Q_DS_ALIAS__S_LK"></li>
						 <li><span class="text">描述：</span><input class="mini-textbox" name="Q_DESCRIPTION__S_LK"></li>
					 </ul>
				 </div>
			 </form>
		 </div>
		 <ul class="toolBtnBox">
			 <li>
				 <a class="mini-button"  plain="true" onclick="add()">新增</a>
			 </li>
			 <li><a class="mini-button" plain="true" onclick="edit()">编辑</a></li>
			 <li><a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a></li>
		 </ul>
		 <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
     </div>
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
			url="${ctxPath}/sys/core/sysWordTemplate/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="name"  sortField="NAME_"  width="120" headerAlign="" allowSort="true">名称</div>
				<div field="dsAlias"  sortField="DS_ALIAS_"  width="120" headerAlign="" allowSort="true">数据源</div>
				<div field="templateName"  sortField="TEMPLATE_NAME_"  width="120" headerAlign="" allowSort="true">模板名称</div>
				<div field="description"  sortField="DESCRIPTION_"  width="120" headerAlign="" allowSort="true">描述</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var alias=record.templateName;
			var templateId=record.templateId;
			var ary=[];
			ary.push('<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>');
			if(templateId){
				ary.push('<span  title="预览" onclick="preview(\'' + alias + '\')">预览</span>');
			}
			ary.push('<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>');
			return ary.join("");
		}
		 //预览
	    function preview(alias){
	    	 mini.prompt("请输入查询主键pk：", "请输入",
   	            function (action, value) {
   	                if (action != "ok") return;
   	             	previewWord(alias,value);
   	            }
	    	  );
	    }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysWordTemplate" winHeight="450"
		winWidth="700" entityTitle="模板" baseUrl="sys/core/sysWordTemplate" />
</body>
</html>