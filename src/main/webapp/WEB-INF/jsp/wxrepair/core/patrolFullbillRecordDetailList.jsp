<%-- 
    Document   : [巡检单填写详情]列表页
    Created on : 2019-10-14 10:55:26
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>[巡检单填写详情]列表管理</title>
    <%@include file="/commons/add.jsp" %>
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
                <li><span class="text">题目ID:</span><input class="mini-textbox" name="Q_F_QUESTION_S_LK"></li>
                <li><span class="text">题目:</span><input class="mini-textbox" name="Q_F_QUESTION_name_S_LK"></li>
                <%--<li><span class="text">题型ID:</span><input class="mini-textbox" name="Q_F_QUESTION_TYPE_S_LK"></li>--%>
                <%--<li><span class="text">题型:</span><input class="mini-textbox" name="Q_F_QUESTION_TYPE_name_S_LK"></li>
                <li><span class="text">回答:</span><input class="mini-textbox" name="Q_F_ANSWER_S_LK"></li>
                <li><span class="text">外键:</span><input class="mini-textbox" name="Q_REF_ID__S_LK"></li>
                <li><span class="text">父ID:</span><input class="mini-textbox" name="Q_PARENT_ID__S_LK"></li>
                <li><span class="text">流程实例ID:</span><input class="mini-textbox" name="Q_INST_ID__S_LK"></li>
                <li><span class="text">状态:</span><input class="mini-textbox" name="Q_INST_STATUS__S_LK"></li>
                <li><span class="text">组ID:</span><input class="mini-textbox" name="Q_GROUP_ID__S_LK"></li>--%>
            </ul>
        </form>
        <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
    </div>
</div>
<div class="mini-fit" style="height: 100%;">
    <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
         url="${ctxPath}/wxrepair/core/patrolFullbillRecordDetail/listData.do?recordId=${recordId}" idField="id"
         multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20"
         allowAlternating="true" pagerButtons="#pagerButtons" onload="onload">
        <div property="columns">
            <div type="checkcolumn" width="20"></div>
            <div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center"
                 renderer="onActionRenderer" cellStyle="padding:0;">操作
            </div>
            <div field="question" sortField="F_QUESTION" width="120" headerAlign="center" allowSort="true"
                 align="center">题目ID
            </div>
            <div field="questionTypeName" sortField="F_QUESTION_TYPE_name" width="120" headerAlign="center"
                 allowSort="true" align="center">题型
            </div>
            <div field="questionName" sortField="F_QUESTION_name" width="120" headerAlign="center" allowSort="true"
                 align="center">题目
            </div>
            <%--<div field="questionType"  sortField="F_QUESTION_TYPE"  width="120" headerAlign="center" allowSort="true">题型ID</div>--%>
            <div field="answer" sortField="F_ANSWER" width="120" headerAlign="center" allowSort="true" align="center">
                回答
            </div>
            <%--<div field="refId"  sortField="REF_ID_"  width="120" headerAlign="center" allowSort="true">外键</div>--%>
            <%--<div field="parentId"  sortField="PARENT_ID_"  width="120" headerAlign="center" allowSort="true">父ID</div>--%>
            <%--<div field="instId"  sortField="INST_ID_"  width="120" headerAlign="center" allowSort="true">流程实例ID</div>--%>
            <%--<div field="instStatus"  sortField="INST_STATUS_"  width="120" headerAlign="center" allowSort="true">状态</div>--%>
            <%--<div field="groupId"  sortField="GROUP_ID_"  width="120" headerAlign="center" allowSort="true">组ID</div>--%>
        </div>
    </div>

</div>
<img src="${ctxPath}/scripts/swiper/close.png" class="close-img boxs hide" onclick="hide()">
<div class="img-box boxs hide">
    <div class="swiper-container gallery-top">
        <div class="swiper-wrapper imgs" id="imgdiv1">

        </div>
        <!-- Add Arrows -->
        <div class="swiper-button-next swiper-button-white"></div>
        <div class="swiper-button-prev swiper-button-white"></div>
    </div>
    <div class="swiper-container gallery-thumbs">
        <div class="swiper-wrapper imgs" id="imgdiv2">

        </div>
    </div>
</div>
<div class="modals boxs hide" onclick="hide()">
</div>

<script type="text/javascript">
    mini.parse();
    var datagrid1 = mini.get('datagrid1');
    var galleryThumbs = null;
    var galleryTop = null;
    //行功能按钮
    function onActionRenderer(e) {
        var record = e.record;
        var pkId = record.pkId;
        var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
            /* + '<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
             + '<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'*/
            // + '<span  title="测试" onclick="test()">测试</span>'
        return s;
    }

    /*function test() {
        var rows = datagrid1.findRows(function (row) {
            if (row.questionTypeName == "上传") return true;
        });
        console.log(rows);
    }*/

    function onload(e) {
        //console.log(e);
        var data = e.data;
        for (var i = 0; i < data.length; i++) {
            if (data[i].questionType == "004") {
                data[i].answer = '<span  title="展示图片" style="font-size: 14px;\n' +
                    '    display: inline-block;\n' +
                    '    max-width: 70px;\n' +
                    '    text-overflow: ellipsis;\n' +
                    '    overflow: hidden;\n' +
                    '    white-space: nowrap;\n' +
                    '    vertical-align: middle;\n' +
                    '    padding: 0 6px;\n' +
                    '    color: #409EFF;\n' +
                    '    cursor: pointer;\n' +
                    '    position: relative;" onclick="showiamge(\'' + data[i].id + '\')">展示图片</span>';
            }
        }
    }

    function showiamge(refId) {
        $.ajax({
            url: "${ctxPath}/wxrepair/core/patrolRecordImage/getImageByRefId.do",
            data: {refId: refId},
            type: "post",
            success: function (res) {
                show(res.result.data);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }

    function show(arr) {
        var html = "";
        for (var i = 0; i < arr.length; i++) {
            html += "<div class='swiper-slide'><img src=" + arr[i] + "></div>"
        }
        $(".boxs").fadeIn(100)
        $(".imgs").html(html)

        onLoad()
    }

    // 点击模态框和关闭按钮关闭
    function hide() {
        galleryThumbs.destroy();
        galleryTop.destroy();
        $(".boxs").fadeOut(100);
    }


    function onLoad() {
        //console.log('aaaa')
        galleryThumbs = new Swiper('.gallery-thumbs', {
            spaceBetween: 10,
            slidesPerView: 4,
            freeMode: true,
            watchSlidesVisibility: true,
            watchSlidesProgress: true
        });
        galleryTop = new Swiper('.gallery-top', {
            spaceBetween: 10,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            thumbs: {
                swiper: galleryThumbs
            }
        });
    }
</script>
<redxun:gridScript gridId="datagrid1" entityName="com.airdrop.wxrepair.core.entity.PatrolFullbillRecordDetail"
                   winHeight="450"
                   winWidth="700" entityTitle="巡检单填写详情" baseUrl="wxrepair/core/patrolFullbillRecordDetail"/>
</body>
</html>