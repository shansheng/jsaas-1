<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/1
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>编辑扩展属性</title>
    <%@include file="/commons/edit.jsp"%>
</head>
<body>
<div class="topToolBar">
    <div>
        <a class="mini-button"    onclick="showAllColunm()">加载全部</a>
        <a class="mini-button"    onclick="onOk()">确定</a>
        <a class="mini-button btn-red"    onclick="onCancel()">取消</a>
    </div>
</div>
<div class="shadowBox90" style="margin:auto;">
    <form id="resetForm"  class="form-outer ">
        <input type="hidden" name="userId" value="${param['userId']}"/>
        <div id="customAttr" class="mini-tabs" activeIndex="0"  style="height:500px;">


            <c:forEach items="${treeList}" var="tree">
                <div title="${tree.name}" showCloseButton="true">
                    <table class="table-detail column-two">
                        <c:forEach items="${osCustomAttributes}" var="attr">
                            <c:if test="${tree.treeId == attr.treeId}">

                                <tr id="tr_attr_${attr.ID}">
                                    <td>${attr.attributeName}：</td>
                                    <td >
                                        <c:if test="${attr.widgetType=='textbox'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-textbox" value="${attr.value}"  style="display: inline-block;"/></c:if>
                                        <c:if test="${attr.widgetType=='spinner'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-spinner"  value="${attr.value}"  style="display: inline-block;"/></c:if>
                                        <c:if test="${attr.widgetType=='datepicker'}"><input id="widgetType_${attr.ID}" name="widgetType_${attr.ID}" class="mini-datepicker"  value="${attr.value}" style="display: inline-block;"/></c:if>
                                        <c:if test="${attr.widgetType=='combobox'}">
                                            <c:set value="${attr.valueSource}" var="valuesource"></c:set>
                                            <c:set value="${attr.sourceType}" var="sourceType"></c:set>
                                            <script>
                                                var jsonAttr = '${valuesource}';
                                                var key = '${sourceType}';
                                                jsonAttr = JSON.parse(jsonAttr);
                                                if(key == 'URL'){
                                                    document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-combobox" style="width: 150px;" textField="'+jsonAttr[0].key+'" valueField="'+jsonAttr[0].value+'" url="'+'${ctxPath}'+jsonAttr[0].URL+'" value="${attr.value}" showNullItem="true" allowInput="true"/>');
                                                }else if(key == 'CUSTOM'){
                                                    var id = "widgetType_${attr.ID}";
                                                    document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" textField="text" valueField="id"  class="mini-combobox" data="" value="${attr.value}" />');
                                                }

                                            </script>
                                        </c:if>
                                        <c:if test="${attr.widgetType=='radiobuttonlist'}">
                                            <c:set value="${attr.valueSource}" var="valuesource"></c:set>
                                            <c:set value="${attr.sourceType}" var="sourceType"></c:set>
                                            <script>
                                                var jsonAttr = '${valuesource}';
                                                var key = '${sourceType}';
                                                if(key == 'URL'){
                                                    jsonAttr = JSON.parse(jsonAttr);
                                                    document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-radiobuttonlist" style="width: auto" repeatItems="4" repeatLayout="table" textField="'+jsonAttr[0].key+'" valueField="'+jsonAttr[0].value+'" value="${attr.value}" url="'+'${ctxPath}'+jsonAttr[0].URL+'"/>');
                                                }else if(key == 'CUSTOM'){
                                                    var id = "widgetType_${attr.ID}";
                                                    document.write('<input id="widgetType_'+${attr.ID}+'" name="widgetType_'+${attr.ID}+'" class="mini-radiobuttonlist" style="width: auto" repeatItems="4" repeatLayout="table" textField="text" valueField="id" data="" value="${attr.value}" />');
                                                }

                                            </script>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>

                </div>
            </c:forEach>



        </div>

    </form>
</div>



<script type="text/javascript">

    mini.parse();
    var form=new mini.Form('resetForm');

    var notValue =[];
    var hideTableIndex =[];
    var hideTableTd =[];
    var userId ='${param['userId']}';
    var url =__rootPath+'/sys/org/osUser/listAttributes.do?userId='+userId;
    $.getJSON(url,function callbact(json){
        for(var i=0;json&&i<json.length;i++){
            if((json[i].widgetType=='combobox' || json[i].widgetType=='radiobuttonlist') && json[i].sourceType=="CUSTOM"){
                var id =  "widgetType_"+json[i].id;
                var attr =  mini.get(id);
                if(attr){
                    attr .setData(json[i].valueSource);
                }
            }
            if(!json[i].value){
                notValue.push("#tr_attr_"+json[i].id);
            }
        }
        colunmHide();
    });

    function colunmHide(){
        for(var i=0;notValue&&i<notValue.length;i++){
            $(notValue[i]).hide();
        }
        var tableBodys = $(".mini-tabs-bodys .mini-tabs-body");
        for(var i=0;tableBodys&&i<tableBodys.length;i++){
            hideTableIndex.push(i);
            var tabBody =tableBodys[i].children[0].children[0];
            if(tabBody && tabBody.children){
                var trs =  tabBody.children;
                for(var k=0;trs&&k<trs.length;k++){
                    var trColunm =trs[k];
                    if(!trColunm.style || !trColunm.style.display || trColunm.style.display !="none"){
                        hideTableIndex.pop(i);
                        break;
                    }
                }
            }
        }

        var tds = $(".mini-tabs-header")[0].children[0].children[0].children;
        for(var i=0;tds&&i<tds.length;i++){
            var tdId =tds[i].id;
            if(tdId){
                var index = tdId.split('$')[1]-1;
                for(var j=0;j<hideTableIndex.length;j++){
                    if(index==hideTableIndex[j]){
                        hideTableTd.push(tds[i-1]);
                        hideTableTd.push(tds[i]);
                    }
                }
            }
        }
        for(var i=0;i<hideTableTd.length;i++){
            hideTableTd[i].style.display="none";
        }
    }


    function showAllColunm(){
        for(var i=0;notValue&&i<notValue.length;i++){
            $(notValue[i]).show();
        }
        for(var i=0;i<hideTableTd.length;i++){
            hideTableTd[i].style.display="";
        }
    }
    //OK
    function onOk(){

        var formData=$("#resetForm").serializeArray();
        var comboboxList = {};
        formData.forEach(function(ele,index){
            var idName =ele.name;
            var combobox = mini.get(idName);
            if(combobox){
                if(combobox.text){
                    comboboxList[ele.name] = combobox.text;
                }else if(combobox.data){
                    var data = combobox.data;
                    for(var i=0;i<data.length;i++){
                        if(data[i].id=combobox.value){
                            comboboxList[ele.name] = data[i].text;
                            break;
                        }
                    }
                }

            }
        });

        //遍历处理扩展属性
        var attrbute = {}
        formData.forEach(function(ele,index){
            if(ele.name.indexOf("widgetType_") != -1){
                attrbute[ele.name] = ele.value;
            }
        });
        formData.push({"name":"attrValue","value":JSON.stringify(attrbute)});
        formData.push({"name":"comboboList","value":JSON.stringify(comboboxList)});
        _SubmitJson({
            url:"${ctxPath}/sys/org/osUser/saveAttr.do",
            method:'POST',
            data:formData,
            success:function(result){
                CloseWindow('ok');
            }
        });
    }
    //Cancel
    function onCancel(){
        //$("#resetForm")[0].reset();
        CloseWindow('cancel');
    }

</script>
</body>
</html>