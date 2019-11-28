<%-- 
    Document   : [问卷信息]编辑页
    Created on : 2019-10-16 10:18:37
    Author     : zpf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>[问卷信息]编辑</title>
    <%@include file="/commons/edit.jsp" %>
</head>
<body>
<%--<rx:toolbar toolbarId="toptoolbar" pkId="patrolQuestionnaireInfo.id" />--%>
<div class="mini-fit">
    <div class="form-container">

        <form id="form1" method="post">
            <input id="pkId" name="id" class="mini-hidden" value="${patrolQuestionnaireInfo.id}"/>
            <table class="table-detail" cellspacing="1" cellpadding="0">
                <caption>[问卷信息] 基本信息</caption>


                <tr>
                    <td>问卷名称：</td>
                    <td>
                        <input name="questionnaireName" class="mini-textbox" required="true"/>
                    </td>
                </tr>
                <%--<tr>--%>
                <%--<td>问卷类型ID：</td>--%>
                <%--<td>--%>
                <%--<input name="questionnaireType" class="mini-textbox"/>--%>
                <%--</td>--%>
                <%--</tr>--%>
                <tr>
                    <td>问卷类型：</td>
                    <td>
                        <input name="questionnaireTypeName" id="combo1" class="mini-combobox" style="width:150px;" textField="typeName" valueField="typeName" multiSelect=false emptyText="请选择..."
                               url="${ctxPath}/wxrepair/core/patrolQuestionnaireType/getAllType.do" required="true" allowInput="true" showNullItem="true" nullItemText="请选择..."/>
                        <%--<input name="questionnaireTypeName" class="mini-textbox"/>--%>
                    </td>
                </tr>
                <tr>
                    <td>问卷主题：</td>
                    <td>
                        <input name="questionnaireTheme" class="mini-textbox"/>
                    </td>
                </tr>
                <tr>
                    <td>开始时间：</td>
                    <td>
                        <input id="startdate" name="startdate" class="mini-datepicker" format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss"
                               showTime="true" showOkButton="true" showClearButton="false" value="new Date"/>
                    </td>
                </tr>
                <tr>
                    <td>结束时间：</td>
                    <td>
                        <input id="enddate" name="enddate" class="mini-datepicker" format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss"
                               showTime="true" showOkButton="true" showClearButton="false" onvalidation="onDateValidation"/>
                    </td>
                </tr>
                <tr>
                    <td>创建人：</td>
                    <td>
                        <input name="creator" class="mini-textbox" required="true" allowInput="false" value="${user.fullname}"/>
                    </td>
                </tr>
                <tr>
                    <td>状态：</td>
                    <td>
                        <input name="status" class="mini-combobox" textfield="name" valuefield="key"
                               data="[{key:1,name:'启用'},{key:2,name:'禁用'}]" required="true" onitemclick="itemClick">
                    </td>
                </tr>
            </table>
            <input id="stat" class="mini-hidden" name="statusName"/>
        </form>
        <div align="center"><a class="mini-button" plain="true" onclick="next()">下一步</a></div>

    </div>
</div>
<script type="text/javascript">
    mini.parse();
    var combo1 = mini.get("combo1");
    var form = new mini.Form("#form1");
    var pkId = '${patrolQuestionnaireInfo.id}';
    var statusName = '${patrolQuestionnaireInfo.statusName}';
    $(function () {
        initForm();
    })

    function initForm() {
        if (!pkId) return;
        var url = "${ctxPath}/wxrepair/core/patrolQuestionnaireInfo/getJson.do";
        $.post(url, {ids: pkId}, function (json) {
            form.setData(json);
        });
    }

    function itemClick(e) {
        statusName = e.item.name;
    }


    /*function onOk() {
        form.validate();
        if (!form.isValid()) {
            return;
        }
        var data = form.getData();
        var config = {
            url: "${ctxPath}/wxrepair/core/patrolQuestionnaireInfo/save.do",
            method: 'POST',
            postJson: true,
            data: data,
            success: function (result) {
                CloseWindow('ok');
            }
        }
        _SubmitJson(config);
        //location.href="${ctxPath}/wxrepair/core/patrolQuestionInfo/list.do";
    }*/

    function next() {
        form.validate();
        if (!form.isValid()) {
            return;
        }
        //console.log(combo1.getSelected());
        var option = combo1.getSelected();
        var data = form.getData();
        if (option){
            data.questionnaireType = option.id;
        }
        data.statusName = statusName;
        //console.log(data);
        var jsonData = JSON.stringify(data);
        $.ajax({
            url: "${ctxPath}/wxrepair/core/patrolQuestionInfo/list.do",
            type: 'POST',
            data: jsonData,
            contentType: "application/json;charset=UTF-8",
            success: function (result) {
                document.write(result);
            }
        })
    }

    function onDateValidation(e) {
        if (e.isValid) {
            if (isCompare(e.value) == false) {
                e.errorText = "不能小于开始日期";
                e.isValid = false;
            }
        }
    }

    function isCompare(enddate) {
        var startdate = mini.get("startdate").value;
        if (startdate == ""){
            return true;
        }
        if(enddate<startdate){
            return false;
        }else {
            return true;
        }
    }
</script>
</body>
</html>