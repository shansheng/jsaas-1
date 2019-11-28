<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>图形报表导入</title>
    <%@include file="/commons/edit.jsp"%>
</head>
<body>
<div class="topToolBar">
    <div>
        <a class="mini-button btn-red" onclick="CloseWindow()">关闭</a>
    </div>
</div>
<table cellpadding="0" cellspacing="0" class="table-detail" style="padding:6px;">
    <caption>第二步：图形报表导入结果</caption>
    <tr>
        <td> 成功!</td>
    </tr>
</table>

<script type="text/javascript">
    mini.parse();
</script>
</body>
</html>