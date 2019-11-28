<%-- 
    Document   : 系统脚本库编辑页
    Created on : 2019-03-29 18:12:21
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>系统脚本库编辑</title>
    <%@include file="/commons/edit.jsp" %>
    <link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
    <script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
    <script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
    <script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="sysScriptLibary.libId"/>
<div class="mini-fit">
    <div class="form-container">
        <form id="form1" method="post">
            <input id="libId" name="libId" class="mini-hidden" value="${sysScriptLibary.libId}"/>
            <table class="table-detail" cellspacing="1" cellpadding="0">
                <caption>系统脚本库 基本信息</caption>
                <tr>
                    <td>分类：</td>
                    <td >
                        <input class="mini-combobox" style="width: 100%" id="dateOperator" textField="name" name="treeId" valueField="treeId"/>
                    </td>
                    <td>脚本全名：</td>
                    <td >
                       <input name="fullClassName"  id ="fullClassName" class="mini-textbox"/>
                       <span name="example" style="display: none" id="example22" class="mini-textarea"></span>
                        <span name="dos" style="display: none" id="dos22" class="mini-textarea"></span>
                    </td>
                </tr>
                <tr>
                    <td>方法名\别名：</td>
                    <td>
                        <input name="method" class="mini-textbox" style="width:100%"/>
                    </td>
                    <td>所属类：</td>
                    <td >
                        <input name="beanName" class="mini-textbox" style="width:100%"/>
                    </td>
                </tr>
                <tr>
                    <td>返回类型(java class type)</td>
                    <td colspan="3">
                        <input name="returnType" class="mini-textbox" style="width:100%"/>
                    </td>
                </tr>
                <tr>
                    <td>脚本代码：</td>
                    <td colspan="3">
                        <textarea name="example1" id="example1" width="90%" height="400"  emptyText="请输入脚本"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>详细信息（说明方法的详细使用）：</td>
                    <td colspan="3">
                        <textarea name="dos1" id="dos1" width="90%" height="400"  emptyText="说明方法的详细使用"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    mini.parse();
    var form = new mini.Form("#form1");
    var pkId = '${sysScriptLibary.libId}';
    var dateOperator =mini.get('#dateOperator');
   var exampleValue = "";
   var docValue ="";

    var exampleEditor = null;
    var docEditor = null;
    $(function () {
        initForm();
        var dataUrl = '${ctxPath}/sys/customform/sysCustomFormSetting/getTreeByCat.do?catKey=SCRIPT_SERVICE_CLASS';
        $.getJSON(dataUrl,function callbact(json){
            dateOperator.setData(json);
            exampleValue =mini.get('#example22').value;
            insertVal(exampleEditor,exampleValue);

            docValue =mini.get('#dos22').value;
            insertVal(docEditor,docValue);
        });
        exampleEditor =initCodeMirror("example1");
        docEditor =initCodeMirror("dos1");
    });


    function initCodeMirror(key) {
        var obj = document.getElementById(key);
       return CodeMirror.fromTextArea(obj, {
            matchBrackets : true,
            lineWrapping: true,
            mode : "text/x-groovy"
        });
    }

    function insertVal(editor, val) {
        var doc = editor.getDoc();
        var cursor = doc.getCursor(); // gets the line number in the cursor position
        doc.replaceRange(val, cursor); // adds a new line
    }


    function initForm() {
        if (!pkId) return;
        var url = "${ctxPath}/sys/org/sysScriptLibary/getJson.do";
        $.post(url, {ids: pkId}, function (json) {
            form.setData(json);
        });
    }

    function onOk() {
        form.validate();
        if (!form.isValid()) {
            return;
        }
        var data = form.getData();
        data.example=exampleEditor.getValue();
        data.dos=docEditor.getValue();
        var config = {
            url: "${ctxPath}/sys/org/sysScriptLibary/save.do",
            method: 'POST',
            postJson: true,
            data: data,
            success: function (result) {
                CloseWindow('ok');
            }
        }
        _SubmitJson(config);
    }
</script>
</body>
</html>