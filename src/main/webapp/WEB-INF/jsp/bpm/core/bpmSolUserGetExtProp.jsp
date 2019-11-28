<%--
    Document   : [sys_script_sibary]编辑页
    Created on : 2019-03-29 18:12:21
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>预览</title>
    <%@include file="/commons/edit.jsp" %>
</head>
<body>
<div id="toolbar1" class="topToolBar" >
    <div>
        <a class="mini-button btn-red"  plain="true" onclick="onCancel">关闭</a>
    </div>
</div>
<div class="form-container">
    <form id="form1" method="post">
        <table class="table-detail" cellspacing="1" cellpadding="0">
            <tr>
                <td >查询结果</td>
                <td colspan="3">
                    <span name="example" id="example" style="width: 100%;height:300px;" readonly="true"  class="mini-textarea"></span>
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    mini.parse();
    var example =mini.get('#example');

    function setData(data){
        $.ajax({
            url:__rootPath+ '/bpm/core/bpmSolUser/getApproveUserList.do',
            data:{
                config:data
            },
            type:"POST",
            success: function (json) {
                var config ="";
                for(var i=0;json&&i<json.length;i++){
                    if(!config){
                        config =json[i].name;
                    }else{
                        config+=","+json[i].name;
                    }
                }
                example.setValue(config);
            }
        });
    }
</script>
</body>
</html>