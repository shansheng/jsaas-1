<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html >
<html>
<head>
    <title>下拉列表</title>
    <%@include file="/commons/mini.jsp" %>
</head>
<body>
<div class="form-outer">
    <form id="miniForm">
        <input class="mini-hidden" name="dataField" value="data"/>
        <table class="table-detail column_2_m" cellpadding="1" cellspacing="0">
            <tr>
                <td>字段备注<span class="star">*</span></td>
                <td>
                    <input id="label" class="mini-textbox" name="label" required="true" vtype="maxLength:100"
                           style="width:90%" emptytext="请输入字段备注" onblur="getPinyin"/>
                </td>
                <td>字段标识<span class="star">*</span></td>
                <td>
                    <input id="name" name="name" class="mini-textbox" required="true"
                           onvalidation="onEnglishAndNumberValidation"/>
                </td>
            </tr>
            <tr>
                <td>地址类型</td>
                <td>
                    <div id="from" name="from" class="mini-radiobuttonlist" required="true"
                         data="[{id:'provinceAndCity',text:'省/市/区'},{id:'provinceAndUrbanStreets',text:'省/市/区/街道'}]"
                         value="self"></div>
                </td>
                <td>
                    控件长
                </td>
                <td colspan="3">
                    <div style="padding-bottom: 6px">
                    长：<input id="mwidth" name="mwidth" class="mini-spinner" style="width:80px" value="0" minValue="0"
                           maxValue="1200"/>

                    <input id="wunit" name="wunit" class="mini-combobox" style="width:50px"
                           onvaluechanged="changeMinMaxWidth"
                           data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
                           value="px" required="true" allowInput="false"/>
                    </div>
                    <div>
                    高：<input id="mheight" name="mheight" class="mini-spinner" style="width:80px" value="0"
                                         minValue="0" maxValue="1200"/>
                    <input id="hunit" name="hunit" class="mini-combobox" style="width:50px"
                           onvaluechanged="changeMinMaxHeight"
                           data="[{'id':'px','text':'px'},{'id':'%','text':'%'}]" textField="text" valueField="id"
                           value="px" required="true" allowInput="false"/>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    mini.parse();
    var form = new mini.Form('miniForm');
    var customDataGrid = mini.get('customDataGrid');
    //编辑的控件的值
    var oNode = null;
    var thePlugins = 'mini-area';
    var pluginLabel = "${fn:trim(param['titleName'])}";
    var keyName = mini.get('name');
    var keyFrom = mini.get('from');
    var label =mini.get('label');


    var addrassObj = {
        "class": "mini-combobox rxc",
        "plugins": "mini-combobox",
        "length": "50",
        "from": "sql",
        "mainfield": "no",
        "sql_textfield": "AREA_NAME_",
        "sql_valuefield": "AREA_CODE_",
        "required": "true",
        "allowinput": "false",
        "mwidth": "0",
        "wunit": "px",
        "mheight": "0",
        "hunit": "px",
        "textfield": "AREA_NAME_",
        "valuefield": "AREA_CODE_",
        "shownullitem": "true",
        "nullitemtext": "请选择...",
        "emptytext": "请选择..."
    };
    var addrassToStrees = {
        "class": "mini-textbox rxc",
        "plugins": "mini-textbox",
        "vtype": "length:120",
        "datatype": "varchar",
        "length": "120",
        "decimal": "0",
        "required": "false",
        "allowinput": "true",
        "from": "forminput",
        "mwidth": "150",
        "wunit": "px",
        "mheight": "0",
        "hunit": "px",
        "style": "width:300px",
    };


    var nodeList = [
        {
            "sql": "PROVINCE_LEVEL",
            "data-options": {sql: "PROVINCE_LEVEL"}
        },
        {
            "sql": "CITY_LEVEL",
            "sql_params": "PARENT_CODE_",
            "data-options": {param: "PARENT_CODE_", parent: "", mainfield: "no", sql: "CITY_LEVEL"}
        },
        {
            "sql": "COUNTY_LEVEL",
            "sql_params": "PARENT_CODE_",
            "data-options": {param: "PARENT_CODE_", parent: "", mainfield: "no", sql: "COUNTY_LEVEL"}
        }
    ];


    window.onload = function () {
        var curEl = UE.plugins[thePlugins].editdom;

        var isMain = isInMain(editor);
        //若控件已经存在，则设置回调其值
        if (curEl) {
            oNode = UE.plugins[thePlugins].editdom;
            //获得字段名称
            var attrs = oNode.attributes;
            var formData = {};
            for (var i = 0; i < attrs.length; i++) {
                if (attrs[i].name == 'data') {
                    customDataGrid.setData(mini.decode(attrs[i].value));
                }
                formData[attrs[i].name] = attrs[i].value;
            }
            form.setData(formData);
        } else {
            var data = _GetFormJson("miniForm");
            var array = getFormData(data);
            initPluginSetting(array);
        }
    };
    //取消按钮
    dialog.oncancel = function () {
        if (UE.plugins[thePlugins].editdom) {
            delete UE.plugins[thePlugins].editdom;
        }
    };
    //确认
    dialog.onok = function () {
        form.validate();
        if (form.isValid() == false) {
            return false;
        }
        var isCreate = false;
        var formData = form.getData();
        var keyNameValue = keyName.value;
        var labelValue=label.value;
        //创新新控件
        if (!oNode) {
            isCreate = true;
            try {
                oNode = createElement('span', keyNameValue);
                oNode.setAttribute('class', 'mini-area rxc');
                oNode.setAttribute('plugins', 'mini-area');
                addChidrenNode(keyNameValue,labelValue);
            } catch (e) {
                alert('出错了，请联系管理员！');
                return;
            }
        }
        //更新控件Attributes
        var style = "";
        if (formData.mwidth != 0) {
            style += "width:" + formData.mwidth + formData.wunit;
        }
        if (formData.mheight != 0) {
            if (style != "") {
                style += ";";
            }
            style += "height:" + formData.mheight + formData.hunit;
        }
        oNode.setAttribute('style', style);

        for (var key in formData) {
            oNode.setAttribute(key, formData[key]);
            if (key == "name") {
                oNode.setAttribute("textName", formData[key] + "_name");
            }
        }
        if (isCreate) {
            //创建选项
            editor.execCommand('insertHtml', oNode.outerHTML);
        } else {
            removeChidrenNode();
            addChidrenNode(keyNameValue,labelValue);
            delete UE.plugins[thePlugins].editdom;
        }
    };

    function removeChidrenNode() {
        var chidrenNode = oNode.innerHTML;
        oNode.innerHTML = "";
    }

    function addChidrenNodeToStreets(keyNameValue,labelValue) {
        oNode.append(" 街道(详细地址)： ");
        streetNodeChidren = createElement('input', keyNameValue + "_street");
        streetNodeChidren.setAttribute('label', labelValue+ "_街道(详细地址)");
        for(var key in addrassToStrees){
            streetNodeChidren.setAttribute(key, addrassToStrees[key]);
        }
        oNode.append(streetNodeChidren);

    }

    function addChidrenNode(keyNameValue,labelValue) {
        oNode.append("省： ");
        provinceNodeChidren = createElement('input', keyNameValue + "_provinceo");
        addAttr(provinceNodeChidren);
        provinceNodeChidren.setAttribute('textname', keyNameValue + "_provinceo_name");
        provinceNodeChidren.setAttribute('label', labelValue+ "_省");
        provinceNodeChidren.setAttribute('sql_parent', '');
        provinceNodeChidren.setAttribute('sql_params', '');
        addAttrCityAndCount(provinceNodeChidren, 0, "");
        oNode.append(provinceNodeChidren);

        oNode.append(" 市： ");
        cityNodeChidren = createElement('input', keyNameValue + "_city");
        addAttr(cityNodeChidren);
        cityNodeChidren.setAttribute('textname', keyNameValue + "_city_name");
        cityNodeChidren.setAttribute('label', labelValue+ "_市");
        cityNodeChidren.setAttribute('sql_parent', keyNameValue + "_provinceo");
        addAttrCityAndCount(cityNodeChidren, 1, keyNameValue + "_provinceo");
        oNode.append(cityNodeChidren);

        oNode.append(" 区(县)： ");
        countyNodeChidren = createElement('input', keyNameValue + "_county");
        addAttr(countyNodeChidren);
        countyNodeChidren.setAttribute('textname', keyNameValue + "_county_name");
        countyNodeChidren.setAttribute('label', labelValue+ "_区(县)");
        countyNodeChidren.setAttribute('sql_parent', keyNameValue + "_city");
        addAttrCityAndCount(countyNodeChidren, 2, keyNameValue + "_city");

        oNode.append(countyNodeChidren);

        if (keyFrom.value == "provinceAndUrbanStreets") {
            addChidrenNodeToStreets(keyNameValue,labelValue);
        }
    }

    function addAttr(chidrenNode) {
        for (var key in addrassObj) {
            chidrenNode.setAttribute(key, addrassObj[key]);
        }
    }

    function addAttrCityAndCount(chidrenNode, type, nodeName) {
        var obj = nodeList[type];
        for (var key in obj) {
            if (key == "data-options") {
                var json = {};
                json.sql = obj[key];
                if (type != 0) {
                    json.sql.parent = nodeName;
                }
                chidrenNode.setAttribute(key, mini.encode(json));
                continue;
            }
            chidrenNode.setAttribute(key, obj[key]);
        }
    }

    /**
     * 判断当前字段是在子表还是主表。
     */
    function isInMain() {
        var el = UE.plugins[thePlugins].editdom;
        var elObj = $(el);
        var grid = elObj.closest(".rx-grid");
        var isMain = grid.length == 0;
        return isMain;
    }


    function getMetaData(editor) {
        var el = UE.plugins[thePlugins].editdom;
        var container = $(editor.getContent());
        var elObj = $(el);
        var grid = elObj.closest(".rx-grid");
        var isMain = grid.length == 0;

        if (isMain) {
            return getMainFields
        }
        var aryJson = [];
        var subWindow = elObj.closest("div.popup-window-d");
        var els;
        if (subWindow.length > 0) {
            els = $("[plugins]", subWindow);
        } else {
            els = $("[plugins]", grid);
        }
        getJson(els, aryJson);
        return aryJson;
    }

    /**
     * 返回主表字段
     */
    function getMainFields() {
        var container = $(editor.getContent());
        var aryJson = [];
        var els = $("[plugins]:not(div.rx-grid [plugins])", container);

        els.each(function () {
            var obj = $(this);
            var label = obj.attr("label");
            var plugin = obj.attr("plugins");
            if (plugin == "rx-grid") return true;
            var name = obj.attr("name");
            var fieldObj = {id: name, text: label};
            aryJson.push(fieldObj);
        });

        return aryJson;
    }

    function getJson(els, aryJson) {
        els.each(function () {
            var obj = $(this);
            var label = obj.attr("label");
            var name = obj.attr("name");
            var fieldObj = {id: name, text: label};
            aryJson.push(fieldObj);
        });
    }
</script>
</body>
</html>
