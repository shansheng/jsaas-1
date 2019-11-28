<%-- 
    Document   : [BpmFormTemplate]列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <title>表单模板列表管理</title>
        <%@include file="/commons/list.jsp" %>
    </head>
    <body>
      
    <div class="mini-toolbar">
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">别名：</span>
						<input name="Q_ALIAS__S_LK" class="mini-textbox"   />
					</li>
					<li>
						<span class="text">类型：</span>
						<input class="mini-combobox"
							   name="Q_TYPE__S_LK"
							   textField="text"
							   valueField="id"
							   data="[{id:'pc',text:'PC模板'},{id:'mobile',text:'手机模板'},{id:'print',text:'打印表单'}]"
							   showNullItem="true" allowInput="false"/>
					</li>
					<li class="liBtn">
						<a class="mini-button " onclick="searchForm(this)" >搜索</a>
						<a class="mini-button  btn-red" onclick="onClearList(this)">清空</a>
					</li>
				</ul>
			</form>
		</div>
		<ul class="toolBtnBox">
			<li>
				<a class="mini-button"   onclick="detail()">明细</a>
			</li>
			<li>
				<a class="mini-button"  onclick="edit()">编辑</a>
			</li>
			<li>
				<a class="mini-button"   onclick="init()">初始化</a>
			</li>
			<li>
				<a class="mini-button"   onclick="searchForm(this)">查询</a>
			</li>
			<li>
				<a class="mini-button btn-red"   onclick="remove()">删除</a>
			</li>
		</ul>
		<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
			<i class="icon-sc-lower"></i>
		</span>
	</div>
        <div class="mini-fit rx-grid-fit" style="height:100%;">
            <div 
            	id="datagrid1" 
            	class="mini-datagrid" 
            	style="width:100%;height:100%;" 
            	allowResize="false"
                url="${ctxPath}/bpm/form/bpmFormTemplate/listData.do"  
                idField="id" 
                multiSelect="true" 
                showColumnsMenu="true"
                sizeList="[5,10,20,50,100,200,500]" 
                pageSize="20" 
                allowAlternating="true" 
                pagerButtons="#pagerButtons"
            >
                <div property="columns">
                    <div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
                    <div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
	                <div field="name" width="120" headerAlign="">模版名称</div>
					<div field="alias" width="120" headerAlign="">别名</div>
					<div field="type" width="120" headerAlign="" renderer="renderType">模版类型</div>
					<div field="init" width="120" headerAlign="" renderer="renderInit">系统默认</div>
				</div>
            </div>
        </div>
        
        <script type="text/javascript">
        	//行功能按钮
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pkId = record.pkId;
	            var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
	                    + ' <span  title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>'
	                    if(record.init==0){
	                    	+ ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'
	                    }
	            return s;
	        }
        	
        	function renderInit(e){
        		var record = e.record;
        		if(record.init==0){
        			return "自定义模版";
        		}
        		else{
        			return "系统";
        		}
        	}
        	
        	function renderType(e){
        		var record = e.record;
        		var obj={"mobile":"手机表单","print":"打印表单",pc:"PC表单"};
        		return obj[record.type];
        	}
        	
        	
        	function init(){
        		_SubmitJson({
		   			url:__rootPath+'/bpm/form/bpmFormTemplate/init.do',
		   			success:function(text){
		   			 grid.load();
		   			}
		   		});
        	}
        </script>
        
        <redxun:gridScript gridId="datagrid1" entityName="com.redxun.bpm.form.entity.BpmFormTemplate" 
        	winHeight="512" winWidth="710"
          	entityTitle="表单模板" baseUrl="bpm/form/bpmFormTemplate"/>
    </body>
</html>