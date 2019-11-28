<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>门户Portal栏目导出</title>
    <%@include file="/commons/list.jsp"%>
</head>
<body>
<div class="mini-toolbar" style="padding:6px;">
    <a class="mini-button" iconCls="icon-export" onclick="doExport">导出</a>
    <a class="mini-button btn-red" onclick="CloseWindow()">关闭</a>
</div>
<form id="form">
    <input class="mini-hidden" id="ids" name="ids" value="${param['ids']}"/>
    <%--<table cellpadding="0" cellspacing="0" class="table-detail" style="padding:6px;width:100%;">
        <tr>
            <td>导出选项配置</td>
        </tr>
        <tr>
            <td>
                <div id="expOptions" name="expOptions" class="mini-checkboxlist" repeatItems="4" repeatLayout="table"
                     data="[{id:'sysEchartsCustom',text:'图形报表'},{id:'sysCustomQuery',text:'自定义查询'},{id:'tabColumn',text:'Tab标签页'}]" >
                </div>
            </td>
        </tr>

    </table>--%>
</form>
<script type="text/javascript">
    mini.parse();
    /*var expOptions=mini.get('expOptions');
    expOptions.selectAll();*/

    function doExport(){
        var ids = mini.get('ids').getValue();
        //var options = expOptions.getValue();
        var options = "";
        jQuery.download(__rootPath + '/oa/info/insColumnDef/doExport.do?ids=' + ids, {expOptions:options},'post');
    }
</script>
</body>
</html>