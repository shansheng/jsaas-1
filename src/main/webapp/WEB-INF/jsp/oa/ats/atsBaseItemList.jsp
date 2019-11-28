<%-- 
    Document   : [基础数据]列表页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<title>[基础数据]列表管理</title>
<%@include file="/commons/list.jsp"%>
</head>
<body>
	 <div class="mini-toolbar" >
		<div class="searchBox">
			<form id="searchForm" class="search-form" >						
				<ul>
					<li>
						<span class="text">编码：</span><input class="mini-textbox" name="Q_CODE_S_LK">
					</li>
					<li>
						<span class="text">名称：</span><input class="mini-textbox" name="Q_NAME_S_LK">
					</li>
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
                        <li>
                            <span class="text" title="是否系统预置">是否系统预置：</span>
                            <input
                                    class="mini-combobox"
                                    name="Q_IS_SYS_S_LK"
                                    showNullItem="true"
                                    emptyText="请选择..."
                                    data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
                            />
                        </li>
                    </ul>
                </div>
			</form>
		</div>
         <ul class="toolBtnBox">
             <li>
                 <a class="mini-button" plain="true" onclick="add()">新增</a>
             </li>
          <%--   <li>
                 <a class="mini-button"  plain="true" onclick="edit()">编辑</a>
             </li>--%>
             <li>
                 <a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
             </li>
         </ul>
         <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
         </span>
     </div>
	
	<div class="mini-fit" style="height: 100%;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" onDrawCell="onDrawCell"
			url="${ctxPath}/oa/ats/atsBaseItem/listData.do" idField="id"
			multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="20" headerAlign="center" align="center" ></div>
				<div name="action" cellCls="actionIcons" width="80" renderer="onActionRenderer" >操作</div>
				<div field="code"  sortField="CODE"  width="120" headerAlign="" allowSort="true">编码</div>
				<div field="name"  sortField="NAME"  width="120" headerAlign="" allowSort="true">名称</div>
				<div field="url"  sortField="URL"  width="120" headerAlign="" allowSort="true">地址</div>
				<div field="isSys"  sortField="IS_SYS"  width="120" headerAlign="" allowSort="true" renderer="onIsSysRenderer">是否系统预置</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//行功能按钮
		function onActionRenderer(e) {
			var record = e.record;
			var pkId = record.pkId;
			var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
					+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
					+'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
			return s;
		}
		
		//绘制是否为系统预置
		function onIsSysRenderer(e) {
            var record = e.record;
            var isSys = record.isSys;
             var arr = [{'key' : '1', 'value' : '是','css' : 'red'}, 
    			        {'key' : '0','value' : '否','css' : 'green'}];
    			return $.formatItemValue(arr,isSys);
        }
		
		function onDrawCell(e) {
	        var record=e.record;
	        var field=e.field;
	        value = e.value;
	        	if(field=='name'){
		        		e.cellHtml='<a href="${ctxPath}'+record.url+'">'+value+'</a>';
	    		} 
	    }
	</script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.ats.entity.AtsBaseItem" winHeight="450"
		winWidth="700" entityTitle="基础数据" baseUrl="oa/ats/atsBaseItem" />
</body>
</html>