<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>加入机构</title>
    <%@include file="/commons/edit.jsp"%>
    <style>
        body{
            background-color: white;
        }
    </style>
</head>
<body>
<rx:toolbar toolbarId="toptoolbar" pkId="formValidRule.id" />

<div>

    <table class="table-detail column-two">
        <tr>
            <td>申请理由：</td>
            <td>
                <textarea id="note" name="note" class="mini-textarea" emptyText="请输入申请理由" required="true" style="height:60px;"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div
                    id="groupGrid"
                    class="mini-datagrid"
                    style="width:100%;"
                    allowResize="true"
                    onlyCheckSelection="true"
                    allowRowSelect="true"
                    allowUnselect="true"
                    height="auto"
                    allowAlternating="true"
                    multiSelect="true"
                    showPager="false"
                    showPageIndex="false"
                    showPageInfo="false"
                >
                    <div property="columns">
                        <div type="checkcolumn" width="40"></div>
                        <div field="nameCn" width="120" headerAlign="center">机构中文名</div>
                        <div field="domain" width="100" headerAlign="center">域名</div>
                    </div>
                </div>

            </td>
        </tr>
    </table>


</div>

<script type="text/javascript">
    mini.parse();
    var groupGrid = mini.get("groupGrid");
    var note = mini.get('note');

    //获取机构列
    var url = __rootPath+'/sys/core/sysInst/selectAllInstList.do';
    $.getJSON(url,function callbact(json){
        groupGrid.setData(json);
    });

    function onOk() {
        if(!note || !note.value){
            top._ShowTips({
                msg:"请填写申请理由！"
            });
            return;
        }
        CloseWindow('ok');
    }

    function onCancel() {
        CloseWindow('cancel');
    }

    //返回选择用户信息
    function getInst() {
        return groupGrid.getSelecteds();
    }

    //返回申请理由
    function getNoteValue() {
        return note.value;
    }


</script>
</body>
</html>