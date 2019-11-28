<%--
    Document   :数据源对话框
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>自定义查询对话框</title>
    <%@include file="/commons/list.jsp"%>
    <style>
        .mini-textbox-border{
            box-sizing: border-box!important;
        }
        #note{
            width:100%!important;
        }
    </style>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="formValidRule.id" />
<div class="topToolBar">
    <div>
        <a class="mini-button"  onclick="onOk()">确定</a>
        <a class="mini-button" onclick="onCancel()">取消</a>
    </div>
</div>
<div class="form-container">
    <div>
        <input id="note" name="note" class="mini-textbox" emptyText="请输入审批意见" required="true" style="width:100%!important;"/>
    </div>
</div>
<script type="text/javascript">
    mini.parse();
    var note = mini.get('note');
    var instId = '${instId}';
    var approvalType ='${approvalType}';

    var pop=$("#note").closest(".mini-textbox");
    pop.css("height","160px");
    pop.css("width","450px");
    var child = note.el.childNodes[0];
    child.style.height="160px";
    function onOk() {
        if(!note || !note.value){
            top._ShowTips({
                msg:"请输入审批意见！"
            });
            return;
        }
        CloseWindow('ok');
    }

    function getValue() {
        var valueObject={
            instId:instId,
            approvalType:approvalType,
            note:note.value
        }
        return valueObject;
    }
</script>
</body>
</html>
