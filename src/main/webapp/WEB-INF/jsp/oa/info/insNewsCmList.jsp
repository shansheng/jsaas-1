<%-- 
    Document   : 新闻评论列表页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>新闻评论列表管理</title>

<%@include file="/commons/list.jsp"%>
</head>
<body>
	<redxun:toolbar entityName="com.redxun.oa.info.entity.InsNewsCm" excludeButtons="popupAddMenu,edit,popupSearchMenu,popupAttachMenu,popupSettingMenu,export,importData"/>
	<div class="mini-fit rx-grid-fit" style="height: 100px;">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false" url="${ctxPath}/oa/info/insNewsCm/listData.do" idField="commId" multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
			<div property="columns">
				<div type="checkcolumn" width="50"></div>
				<div name="action" cellCls="actionIcons" width="50" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				<div field="newsTitle" width="120" headerAlign="center" >新闻题目</div>
				<div field="fullName" width="120" headerAlign="center" allowSort="true" sortField="FULL_NAME_">评论人名</div>
				<div field="content" width="120" headerAlign="center" allowSort="true" sortField="CONTENT_">评论内容</div>
				<div field="agreeNums" width="120" headerAlign="center" allowSort="true" sortField="AGREE_NUMS_">赞同与顶</div>
				<div field="refuseNums" width="120" headerAlign="center" allowSort="true" sortField="REFUSE_NUMS_">反对与鄙视次数</div>
				<div field="isReply" width="120" headerAlign="center" allowSort="true" renderer="onIsReplyRenderer" sortField="IS_REPLY_">是否为回复</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
        	//编辑
	        function onActionRenderer(e) {
	            var record = e.record;
	            var uid = record.pkId;
	            var s = '<span  title="明细" onclick="detailRow(\'' + uid + '\')">明细</span>'
	          //          + ' <span class="icon-edit" title="编辑" onclick="editRow(\'' + uid + '\')"></span>'
	                    + ' <span  title="删除" onclick="delRow(\'' + uid + '\')">删除</span>';
	            return s;
	        }
        	
	        function onIsReplyRenderer(e) {
	            var record = e.record;
	            var isReply = record.isReply;
	             var arr = [{'key' : 'yes', 'value' : '是','css' : 'blue'}, 
	    			        {'key' : 'no','value' : '否','css' : 'orange'} ];
	    			return $.formatItemValue(arr,isReply);
	        }
        </script>
	<script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
	<redxun:gridScript gridId="datagrid1" entityName="com.redxun.oa.info.entity.InsNewsCm" winHeight="450" winWidth="700" entityTitle="评论" baseUrl="oa/info/insNewsCm" />
</body>
</html>