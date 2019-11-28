<%-- 
    Document   : [巡检单填写记录]列表页
    Created on : 2019-10-21 11:32:36
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>[巡检单填写记录]列表管理</title>
    <%@include file="/commons/list.jsp" %>
</head>
<body>
<ul id="exportMenu" class="mini-menu" style="display:none;">
    <li onclick="exportAllPage(this)">导出所有页</li>
    <li onclick="exportCurPage(this)">导出当前页</li>
</ul>
<div class="mini-toolbar">
    <ul class="toolBtnBox">
        <li>
            <%--<a class="mini-button" plain="true" onclick="add()">增加</a>
            <a class="mini-button" plain="true" onclick="edit()">编辑</a>
            <a class="mini-button btn-red" plain="true" onclick="remove()">删除</a>--%>
            <a class="mini-button" plain="true" onclick="searchFrm()">查询</a>
            <a class="mini-button btn-red" plain="true" onclick="clearForm()">清空查询</a>
            <a class="mini-menubutton" plain="true" menu="#exportMenu">导出</a>
        </li>
    </ul>
    <div class="searchBox">
        <form id="searchForm" class="search-form">
            <ul>
                <li><span class="text">填单人:</span><input class="mini-textbox" name="Q_F_STAFF_name_S_LK"></li>
                <li><span class="text">巡检单:</span><input class="mini-textbox" name="Q_F_QUESTIONNAIRE_name_S_LK"></li>
                <li><span class="text">门店:</span><input class="mini-textbox" name="Q_F_SHOP_name_S_LK"></li>
            </ul>
        </form>
        <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
    </div>
</div>
<div class="mini-fit" style="height: 100%;">
    <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
         url="${ctxPath}/wxrepair/core/patrolFullbillRecord/listData.do" idField="id"
         multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20"
         allowAlternating="true" pagerButtons="#pagerButtons">
        <div property="columns">
            <div type="checkcolumn" width="20"></div>
            <div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center"
                 renderer="onActionRenderer" cellStyle="padding:0;">操作
            </div>
            <div field="questionnaire" sortField="F_QUESTIONNAIRE" width="120" headerAlign="center" allowSort="true"
                 align="center">巡检单ID
            </div>
            <div field="staffName" sortField="F_STAFF_name" width="120" headerAlign="center" allowSort="true"
                 align="center">填单人
            </div>
            <div field="questionnaireName" sortField="F_QUESTIONNAIRE_name" width="120" headerAlign="center"
                 allowSort="true" align="center">巡检单
            </div>
            <div field="fulldate" sortField="F_FULLDATE" dateFormat="yyyy-MM-dd HH:mm:ss" width="120"
                 headerAlign="center" allowSort="true" align="center">填单时间
            </div>
            <div field="statusName" sortField="F_STATUS_name" width="120" headerAlign="center" allowSort="true"
                 align="center" >状态
            </div>
            <div field="shopName" sortField="F_SHOP_name" width="120" headerAlign="center" allowSort="true"
                 align="center">门店
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    mini.parse();
    var grid=mini.get('datagrid1');
    //var cc = grid.getColumn(6);
    //console.log(cc);
    //console.log(cc.cellStyle);
    //行功能按钮
    function onActionRenderer(e) {
        var record = e.record;
        var pkId = record.pkId;
        var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
        /*+'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
        +'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'*/
        // +'<span  title="填单详情" onclick="detailList(\'' + pkId + '\')">填单详情</span>'
        +'<span  title="填单详情" onclick="fullDetail(\'' + pkId + '\')">填单详情</span>';
        return s;
    }

    function detailList(pkId) {
        //location.href=
        window.open("${ctxPath}/wxrepair/core/patrolFullbillRecordDetail/list.do?pkId="+pkId);
    }

    /*function fullDetail(pkId) {
        //location.href=
        window.open("${ctxPath}/wxrepair/core/patrolFullbillRecordDetail/fullDetail.do?pkId="+pkId);
    }*/

    function fullDetail(pkId) {
        var obj=getWindowSize();
        _OpenWindow({
            url: "${ctxPath}/wxrepair/core/patrolFullbillRecordDetail/fullDetail.do?pkId=" + pkId,
            title: "填单详情", width: obj.width, height: obj.height
        });
    }
</script>
<redxun:gridScript gridId="datagrid1" entityName="com.airdrop.wxrepair.core.entity.PatrolFullbillRecord" winHeight="450"
                   winWidth="700" entityTitle="巡检单填写记录" baseUrl="wxrepair/core/patrolFullbillRecord"/>
</body>
</html>