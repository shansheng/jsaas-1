<%-- 
    Document   : [问题信息]列表页
    Created on : 2019-10-12 11:09:13
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>[问题信息]列表管理</title>
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
            <a class="mini-button" plain="true" onclick="addQuestion()">增加</a>
            <%--<a class="mini-button" plain="true" onclick="edit()">编辑</a>--%>
            <a class="mini-button btn-red" plain="true" onclick="removeQuestion()">删除</a>
            <span class="separator"></span>
            <a class="mini-button" plain="true" onclick="editOptions()">编辑选项</a>
            <a class="mini-button" plain="true" onclick="saveQuestion()" style="position: absolute;right: 10px;">保存</a>
            <%--<a class="mini-button" plain="true" onclick="searchFrm()">查询</a>
            <a class="mini-button btn-red" plain="true" onclick="clearForm()">清空查询</a>
            <a class="mini-menubutton" plain="true" menu="#exportMenu">导出</a>--%>
        </li>
    </ul>
    <%--<div class="searchBox">
        <form id="searchForm" class="search-form">
            <ul>
                <li><span class="text">题目类型ID:</span><input class="mini-textbox" name="Q_F_QUESTION_TYPE_S_LK"></li>
                <li><span class="text">题目类型:</span><input class="mini-textbox" name="Q_F_QUESTION_TYPE_name_S_LK"></li>
                <li><span class="text">题目内容:</span><input class="mini-textbox" name="Q_F_QUESTION_CONTENT_S_LK"></li>
                <li><span class="text">问卷标识:</span><input class="mini-textbox" name="Q_F_REFID_S_LK"></li>
                <li><span class="text">外键:</span><input class="mini-textbox" name="Q_REF_ID__S_LK"></li>
                <li><span class="text">父ID:</span><input class="mini-textbox" name="Q_PARENT_ID__S_LK"></li>
                <li><span class="text">流程实例ID:</span><input class="mini-textbox" name="Q_INST_ID__S_LK"></li>
                <li><span class="text">状态:</span><input class="mini-textbox" name="Q_INST_STATUS__S_LK"></li>
                <li><span class="text">组ID:</span><input class="mini-textbox" name="Q_GROUP_ID__S_LK"></li>
                <li><span class="text">题目序号:</span><input class="mini-textbox" name="Q_F_SEQUENCE_S_LK"></li>
            </ul>
        </form>
        <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
    </div>--%>
</div>
<div class="mini-fit" style="height: 100%;">
    <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" allowResize="false"
         url="${ctxPath}/wxrepair/core/patrolQuestionInfo/listData.do?refId=${questionnaireInfo.id}" idField="id"
         multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20"
         allowCellEdit="true" allowCellSelect="true"
         allowAlternating="true" pagerButtons="#pagerButtons" allowCellValid="true" oncellendedit="oncellendedit">
        <div property="columns">
            <div type="checkcolumn" width="20"></div>
            <%--<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>--%>
            <div type="comboboxcolumn" autoShowPopup="true" field="questionType" sortField="F_QUESTION_TYPE" width="120"
                 headerAlign="center"
                 allowSort="true" align="center" vtype="required">题目类型<input required="true" property="editor"
                                                                             class="mini-combobox"
                                                                             data="[{text:'简答',id:'001'},{text:'选择',id:'002'},{text:'判断',id:'003'},{text:'上传',id:'004'}]"
                                                                             style="width:100%;"/>
            </div>
            <div field="questionContent" sortField="F_QUESTION_CONTENT" width="120" headerAlign="center"
                 allowSort="true" align="center" vtype="required">题目内容<input required="true" property="editor"
                                                                             class="mini-textbox" style="width:100%;"/>
            </div>
            <div field="sequence" sortField="F_SEQUENCE" width="120" headerAlign="center" allowSort="true"
                 align="center" vtype="required">题目序号<input required="true" property="editor" class="mini-spinner"
                                                            minValue="1" maxValue="100"
                                                            style="width:100%;"/></div>
        </div>
    </div>
</div>

<div id="optionWindow" class="mini-window" title="选项" style="width:650px; height: 450px"
     showModal="true" allowResize="true" allowDrag="true"
>
    <ul class="toolBtnBox">
        <li>
            <a class="mini-button" plain="true" onclick="addOption()">增加</a>
            <a class="mini-button btn-red" plain="true" onclick="removeOption()">删除</a>
            <a class="mini-button" plain="true" onclick="confirm()" style="position: absolute;right: 10px;">确定</a>
        </li>
    </ul>
    <div id="datagrid2" class="mini-datagrid" style="width: 100%; height: 86%;" allowResize="false" multiSelect="true"
         showColumnsMenu="true" showPager="false"
         allowCellEdit="true" allowCellSelect="true" allowAlternating="true" allowSortColumn="false"
         allowCellValid="true" oncellendedit="oncellendedit">

        <div property="columns">
            <div type="checkcolumn" width="20"></div>
            <div field="optionCode" sortField="F_OPTION_CODE" width="120" headerAlign="center"
                 allowSort="true" align="center" vtype="required">选项编码<input required="true" property="editor"
                                                                             class="mini-textbox" style="width:100%;"/>
            </div>
            <div field="optionContent" sortField="F_OPTION_CONTENT" width="120" headerAlign="center"
                 allowSort="true" align="center" vtype="required">选项内容<input required="true" property="editor"
                                                                             class="mini-textbox" style="width:100%;"/>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //行功能按钮
    /*function onActionRenderer(e) {
        var record = e.record;
        var pkId = record.pkId;
        var s = '<span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
                +'<span  title="编辑" onclick="editRow(\'' + pkId + '\',true)">编辑</span>'
                +'<span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>';
        return s;
    }*/
    var nid = '${questionnaireInfo.id}';
    mini.parse();
    var datagrid1 = mini.get('datagrid1');
    var datagrid2 = mini.get('datagrid2');
    var optionWindow = mini.get("optionWindow");

    function addOption() {
        var newRow = {name: "Option Row"};
        datagrid2.addRow(newRow, 0);
    }

    function removeOption() {
        var selecteds = datagrid2.getSelecteds();
        datagrid2.removeRows(selecteds);
    }

    function addQuestion() {
        var newRow = {name: "Question Row"};
        datagrid1.addRow(newRow, 0);
    }

    function removeQuestion() {
        var selecteds = datagrid1.getSelecteds();
        datagrid1.removeRows(selecteds);
    }

    function saveQuestion() {
        datagrid1.validate();
        if (datagrid1.isValid() == false) {
            //alert("请校验输入单元格内容");
            var error = datagrid1.getCellErrors()[0];
            datagrid1.beginEditCell(error.record, error.column);
            return;
        }
        var alldata = datagrid1.data;
        for (var i = 0; i < alldata.length ; i++) {
            if (alldata[i].questionType == "002"){
                if(alldata[i].showdata){
                    if (alldata[i].showdata.length == 0) {
                        mini.alert("请为选择题添加选项");
                        return;
                    }
                }else{
                    mini.alert("请为选择题添加选项");
                    return;
                }
            }
        }
        var data = datagrid1.getChanges();
        var json = mini.encode(data);
        datagrid1.loading("保存中，请稍后......");
        $.ajax({
            url: "${ctxPath}/wxrepair/core/patrolQuestionInfo/saveQuestion.do",
            data: {data: json, nid: nid},
            type: "post",
            success: function (text) {
                datagrid1.reload();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
        });
    }

    function oncellendedit(e) {
        var editor = e.editor;
        editor.validate();
        if (editor.isValid() == false) {
            alert(editor.getErrorText());
            e.cancel = true;
        }
    }

    //编辑选项
    function editOptions() {
        var rows = datagrid1.getSelecteds();
        var size = rows.length;
        //console.log(size);
        if (size == 0) {
            alert("请选择一个题目");
        } else if (size > 1) {
            alert("多选无效");
        } else {
            var row = rows[0];
            if (row.questionType == "002") {
                datagrid2.setData(row.showdata);
                optionWindow.show();
            } else {
                alert("仅支持选择题");
            }
        }
    }

    //确定选择题选项
    function confirm() {
        var data = datagrid2.getChanges();
        console.log(data);
        var row = datagrid1.getSelected();
        row.options = data;
        row.showdata = datagrid2.data;
        row._state = "modified";
        //清空行
        datagrid2.clearRows();
        //清空选中
        datagrid2.setCurrentCell([null, null]);
        optionWindow.hide();
    }
</script>
<redxun:gridScript gridId="datagrid1" entityName="com.airdrop.wxrepair.core.entity.PatrolQuestionInfo"
                   winHeight="450"
                   winWidth="700" entityTitle="问题信息" baseUrl="wxrepair/core/patrolQuestionInfo"/>
</body>
</html>