<%--
    Document   : [ins_column_def]编辑页
    Created on : 2017-08-16 11:39:47
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>自定义栏目编辑</title>
    <%@include file="/commons/edit.jsp" %>

    <link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
    <script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
    <script src="${ctxPath}/scripts/codemirror/mode/xml/xml.js"></script>
    <script src="${ctxPath}/scripts/codemirror/addon/mode/multiplex.js"></script>


</head>
<body>

<rx:toolbar toolbarId="toolbar1" pkId="insColumnDef.colId"/>

<div class="mini-fit">
<div class="form-container">
    <div id="p1" >
        <form id="form1" method="post">

            <input id="pkId" name="id" class="mini-hidden" value="${insColumnDef.colId}"/>
            <table class="table-detail column-four" cellspacing="1" cellpadding="0">
                <caption>自定义栏目基本信息</caption>
                <tr>
                    <td>栏目名称</td>
                    <td colspan="3">
                        <input name="name" value="${insColumnDef.name}" class="mini-textbox" style="width: 90%"
                               required="true"/>
                    </td>
                </tr>
                <tr>
                    <td>栏目KEY</td>
                    <td colspan="3">
                        <input name="key" value="${insColumnDef.key}" class="mini-textbox" style="width: 90%"
                               required="true"/>
                    </td>
                </tr>
                <tr>
                    <td>分类选择 *:</td>
                    <td>
                        <input id="treeId" name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_POTAL_COLUMN"
                               multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="false" value="${insColumnDef.treeId}"
                               showFolderCheckBox="false"  expandOnLoad="true" showClose="true" oncloseclick="_ClearButtonEdit"
                               popupWidth="300" style="width:90%"/>
                    </td>
                    <td>手机端栏目</td>
                    <td>
                        <input name="isMobile" class="mini-radiobuttonlist"
                               value='${empty insColumnDef.isMobile ? "0" : insColumnDef.isMobile}'
                               data="[{id:'0',text:'否'},{id:'1',text:'是'}]"
                               valueField="id" textField="text"/>
                    </td>
                </tr>
                <tr>
                    <td>是否为公共栏目</td>
                    <td>
                        <input name="isPublic" value="${insColumnDef.isPublic}"
                               class="mini-combobox"
                               emptyText="请选择..."
                               data="[{id:'1',text:'是'},{id:'0',text:'否'}]"
                               style="width: 90%"/>
                    </td>
                    <td>栏目类型</td>
                    <td colspan="3">
                        <input name="type" value="${insColumnDef.type}"
                               class="mini-combobox"
                               emptyText="请选择..."
                               url="${ctxPath }/oa/info/insColumnTemp/getJsonData.do"
                               style="width: 96%"
                               required="true"
                               onvaluechanged="onValueChanged"/>
                    </td>
                </tr>
                <tr id="newType">
                    <td>新闻类型</td>
                    <td colspan="3">
                        <input name="newType" value="${insColumnDef.newType}"
                               class="mini-combobox"
                               emptyText="请选择..."
                               url="${ctxPath }/oa/info/insColumnTemp/getJsonData.do"
                               style="width: 96%"
                               required="true"
                         />
                    </td>
                </tr>
                <tr id="dataUrl">
                    <td>更多Url</td>
                    <td colspan="3">
                        <input name="dataUrl" value="${insColumnDef.dataUrl}" class="mini-textbox" style="width: 96%"/>
                    </td>
                </tr>
                <tr id="function">
                    <td>数据来源方法</td>
                    <td colspan="3">

                        <input name="function" value='${insColumnDef.function}' class="mini-textbox" style="width: 87%"/>
                        <a href="javascript:showScriptLibary()">常用脚本</a>&nbsp;
                        <a href="javascript:showSQLLibary()">自定义SQL</a>
                    </td>
                </tr>
                <tr id="tabGroups">
                    <td>TAB标签组：</td>
                    <td colspan="3">
                        <input id="tabGroupsData" name="tabGroups" allowInput="false" class="mini-textboxlist"
                               style="width: 80%;" value="${insColumnDef.tabGroups}" text="${tabGroupsName}"/>
                        <a class="mini-button" plain="true" onclick="selectTabGroups()">添加</a>
                    </td>
                </tr>
                <tr>
                    <td>模板HTML</td>
                    <td colspan="3">
                        <a id="selectEchartBtn" class="mini-button" visible="false"
                           onclick="selectEchartDemo()">选择图表模板</a><!-- Louis append -->
                        <textarea id="content" class="textarea" name="script"
                                  style="width:100%;height:100%;margin-left: 0;">${insColumnDef.templet}</textarea>
                    </td>
                </tr>
            </table>

        </form>
    </div>
</div>
</div>
<rx:formScript formId="form1" baseUrl="oa/info/insColumnDef"
               entityName="com.redxun.oa.info.entity.InsColumnDef"/>
<script>
    addBody();
    var dataUrlValue ='${insColumnDef.dataUrl}';
    var functionValue ='${insColumnDef.function}';
    var newType ='${insColumnDef.newType}';
    var newTypeObj =mini.getByName("newType");

    var newTyleList=[
        {
           "text":"图片",
           "id":"img"
        },{
            "text":"文字列表",
            "id":"wordsList"
        },{
            "text":"图片与文件",
            "id":"imgAndFont"
        }
    ];
    newTypeObj.setData(newTyleList);

    function SaveData() {
        var form = new mini.Form("form1");
        form.validate();
        if (!form.isValid()) {
            return;
        }
        var formData = form.getData();
        var temp = editor.getValue();
        formData.templet = temp;
        var config = {
            url: "${ctxPath}/oa/info/insColumnDef/save.do",
            method: 'POST',
            data: formData,
            success: function (result) {
                //如果存在自定义的函数，则回调
                if (isExitsFunction('successCallback')) {
                    successCallback.call(this, result);
                    return;
                }

                CloseWindow('ok');
            }
        }

        _SubmitJson(config);
    }

    //显示脚本库
    function showScriptLibary() {
        _OpenWindow({
            title: '脚本库',
            iconCls: 'icon-script',
            url: __rootPath + '/bpm/core/bpmScript/libary.do',
            height: 450,
            width: 800,
            onload: function () {

            },
            ondestroy: function (action) {
                if (action != 'ok') return;

                var win = this.getIFrameEl().contentWindow;
                var row = win.getSelectedRow();

                if (row) {
                    appendScript(row.example);
                }
            }
        });
    }

    //显示SQL
    function showSQLLibary() {
        _OpenWindow({
            title: '自定义SQL',
            iconCls: 'icon-script',
            url: __rootPath + '/sys/db/sysSqlCustomQuery/dialog.do',
            height: 450,
            width: 800,
            onload: function () {

            },
            ondestroy: function (action) {
                if (action != 'ok') {
                    return;
                }
                var win = this.getIFrameEl().contentWindow;
                var row = win.getData();

                if (row) {
                    appendSql(row);
                }
            }
        });
    }

    function appendSql(row) {
        var textbox = mini.getByName('function');
        var name = 'portalScript.getByCustomSql(colId,"' + row.key + '")';
        textbox.setValue(name);
        var resultField = mini.decode(row.resultField);
        var config = {
            url: "${ctxPath}/oa/info/insColumnDef/getSQLHtml.do",
            method: 'POST',
            data: {
                resultField: row.resultField,
                bokey: row.name
            },
            success: function (result) {

                editor.setValue(result.data);
            }
        }

        _SubmitJson(config);

    }

    //在当前活动的tab下的加入脚本内容
    function appendScript(scriptText) {
        var textbox = mini.getByName('function');
        textbox.setValue(scriptText);
    }

    CodeMirror.defineMode("mycode", function (config) {
        return CodeMirror.multiplexingMode(
            CodeMirror.getMode(config, "text/html"),
            {
                open: "<<", close: ">>",
                mode: CodeMirror.getMode(config, "text/plain"),
                delimStyle: "delimit"
            }
            // .. more multiplexed styles can follow here
        );
    });
    var editor = CodeMirror.fromTextArea(document.getElementById("content"), {
        mode: "mycode",
        lineNumbers: true,
        lineWrapping: true
    });

    $(function () {
        init();
    })

    function init() {
        urlAndFunshow();
        $("#tabGroups").hide();
        $("#newType").hide();
        if (${insColumnDef.type=="tabcolumn"}) {
            setUrlAndFunValue(null,null);
            urlAndFunhide();
            $("#tabGroups").show();
        }
        if (${insColumnDef.type=="chart"}) { //Louis append
            mini.get("selectEchartBtn").setVisible(true);
        }
        if(${insColumnDef.type =="newsNotice"}){
            urlAndFunhide();
            $("#newType").show();
        }
    }

    function getUrlAndFunValue(){
        dataUrlValue =mini.getByName("dataUrl").getValue();
        functionValue =mini.getByName("function").getValue();
    }

    function setUrlAndFunValue(dataUrlValue,functionValue){
         mini.getByName("dataUrl").setValue(dataUrlValue);
         mini.getByName("function").setValue(functionValue);
    }

    function urlAndFunshow(){
        $("#dataUrl").show();
        $("#function").show();
    }

    function urlAndFunhide(){
        $("#dataUrl").hide();
        $("#function").hide();
    }

    function clearNewTypeValue(){
        newType =newTypeObj.getValue();
        newTypeObj.setValue(null);
    }

    function onValueChanged(e) {
        var value = e.value;
        $.ajax({
            type: "GET",
            url: "${ctxPath}/oa/info/insColumnTemp/getKey.do?key=" + value,
            success: function (data) {
                if (data.templet != null)
                    editor.setValue(data.templet);
            }
        });
        urlAndFunshow();
        $("#tabGroups").hide();
        $("#newType").hide();
        mini.get("selectEchartBtn").setVisible(false);
        if (value == "tabcolumn") {
            getUrlAndFunValue();
            setUrlAndFunValue(null,null);
            urlAndFunhide();
            $("#tabGroups").show();
        } else if (value == "chart") {
            setUrlAndFunValue(dataUrlValue,functionValue);
            mini.get("selectEchartBtn").setVisible(true);
        }else if(value =="newsNotice"){
            setUrlAndFunValue(dataUrlValue,functionValue);
            urlAndFunhide();
            newTypeObj.setValue(newType);
            $("#newType").show();
        }else{
            setUrlAndFunValue(dataUrlValue,functionValue);
        }

        if(value !="newsNotice"){
            clearNewTypeValue();
        }
    }

    //echarts模板选择
    function selectEchartDemo() {
        _OpenWindow({
            url: __rootPath + '/sys/echarts/echartsCustom/select.do',
            height: 590,
            width: 950,
            title: '图表选择',
            ondestroy: function (action) {
                if (action != 'ok') return;
                var iframe = this.getIFrameEl();
                var dat = iframe.contentWindow.getCustomChartsInfo();
                setEchartsHtml(dat);
            }
        });
    }

    //设置echarts内容
    function setEchartsHtml(json) {
        $.post(__rootPath + '/sys/echarts/echartsCustom/frontSetting.do',
            {"id": json.id, "alias": json.key, "key": mini.getByName("key").getValue()},
            function (dat) {
                editor.setValue(dat);
            }
        );
    }

    function selectTabGroups() {
        var canDepIds = mini.get('tabGroupsData');

        var conf = {
            single: false, callBack: function (groups) {
                var uIds = [];
                var uNames = [];
                for (var i = 0; i < groups.length; i++) {
                    if (canDepIds.getValue().indexOf(groups[i].colId) != -1) {
                        continue;
                    }
                    uIds.push(groups[i].colId);
                    uNames.push(groups[i].name);
                }
                if (canDepIds.getValue() != '') {
                    uIds.unshift(canDepIds.getValue().split(','));
                }
                if (canDepIds.getText() != '') {
                    uNames.unshift(canDepIds.getText().split(','));
                }
                canDepIds.setValue(uIds.join(','));
                canDepIds.setText(uNames.join(','));
            }
        };
        openColumnDefDialog(conf);
    }


</script>
</body>
</html>