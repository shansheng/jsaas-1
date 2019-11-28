<%@page contentType="text/html" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true" %>
<!DOCTYPE html >
<html>
<head>
    <title>流程实例的配置页</title>
    <%@include file="/commons/edit.jsp" %>
    <!-- code codemirror start -->
    <link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
    <script src="${ctxPath}/scripts/codemirror/lib/codemirror.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js" type="text/javascript"></script>
    <script src="${ctxPath}/scripts/flow/solution/eventSetting.js" type="text/javascript"></script>

    <!-- code minitor end -->
    <script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip-blue.css"/>
    <script type="text/javascript" src="${ctxPath}/scripts/common/baiduTemplate.js"></script>
    <script type="text/javascript">
        //设置左分隔符为 <!
        baidu.template.LEFT_DELIMITER = '<!';
        //设置右分隔符为 <!
        baidu.template.RIGHT_DELIMITER = '!>';
    </script>
</head>
<body>
<script id="rightTemplate" type="text/html">
    <table class="table-detail column-two">
        <tr>
            <td>子表名</td>
            <td>权限</td>
        </tr>
        <!for(var key in data){
        var json=data[key];
        !>
        <tr class="trName" tbName="<!=key!>">
            <td class="tbName"><!=key!>(<!=json.comment!>)</td>
            <td class="tbRight">
                <label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="user" <!if(json.type=='user'){!>checked='checked'<!}!> />当前用户</label>
				<label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="group" <!if(json.type=='group'){!>checked='checked'<!}!>/>当前用户组</label>
				<label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="sql" <!if(json.type=='sql'){!>checked='checked'<!}!>/>SQL</label>
				<label style="margin-right: 8px"><input type="radio" name="<!=key!>" onclick="handType(this)" value="all" <!if(json.type=='all'){!>checked='checked'<!}!>/>全部</label>
				<div class="sql" <!if(json.type!='sql'){!>style="display:none;"<!}!>>
					<div style="margin-top: 6px">
						常&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						量：
						<select onchange='changeConstant(this)' style="width:200px;">
						<!for(var i=0;i<vars.length;i++){
						var obj=vars[i];
						!>
						<option value="<!=obj.key!>"><!=obj.val!></option>
						<!}!>
						</select>
					</div>
					<div style="margin: 6px 0">字段选择：
						<input id="fieldTree" onvaluechanged="fieldSelect" class="mini-treeselect" url="<!=ctx!>/sys/bo/sysBoEnt/getTreeByBoDefId.do?boDefId=<!=boDefId!>"
									   expandOnLoad="true"   popupWidth="200"  parentField="pid" textField="text" valueField="id" />
					</div>
					<div>通用字段：
						<input id="commonTree" onvaluechanged="fieldSelect" class="mini-treeselect" url="<!=ctx!>/sys/bo/sysBoEnt/getCommonField.do"
								expandOnLoad="true"   popupWidth="200"  parentField="pid" textField="text" valueField="id" />
					</div>

					<textarea tbName="<!=key!>" style="width:600px;height:100px">
					 <!if(json.sql){!><!=json.sql!><!}else{!>select * from w_<!=key!> where REF_ID_=#{fk}  <!}!>
					</textarea>
				<div>
            </td>
        </tr>
        <!}!>
    </table>
</script>
<div class="topToolBar">
    <div>
        <a class="mini-button" plain="true" onclick="saveConfig">保存</a>
        <a class="mini-button btn-red" plain="true" onclick="CloseWindow()">关闭</a>
    </div>
</div>

<div id="gridPanel_start" class="mini-panel" title="header" style="width:460px;height:250px;"
     showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0"
>
    <div id="taskNodeGrid_start" class="mini-datagrid" style="width:100%;height:100%;"
         borderStyle="border:0" showPager="false">
        <div property="columns">
            <div type="checkcolumn"></div>
            <div field="activityId" headerAlign="center">任务ID</div>
            <div field="name" headerAlign="center">任务名称</div>
        </div>
    </div>
</div>

<div id="gridPanel_end" class="mini-panel" title="header" style="width:450px;height:250px;"
     showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0"
>
    <div id="taskNodeGrid_end" class="mini-datagrid" style="width:100%;height:100%;"
         borderStyle="border:0" showPager="false">
        <div property="columns">
            <div type="checkcolumn"></div>
            <div field="activityId" headerAlign="center">任务ID</div>
            <div field="name" headerAlign="center">任务名称</div>
        </div>
    </div>
</div>
<div class="mini-fit">
    <div class="form-container">
        <div class="mini-tabs" activeIndex="0" onactivechanged="changeds" style="width:100%;height:780px">
            <div title="基本信息配置">
                <form id="form1">
                    <table class="table-detail column-two" cellspacing="1" cellpadding="0" style="width:100%">
                        <tr>
                            <td>事项标题规则</td>
                            <td colspan="3">
                                <input
                                        id="subRuleEdit"
                                        name="subRule"
                                        class="mini-popupedit"
                                        style="width:55%;"
                                        textField="name"
                                        valueField="key"
                                        popupWidth="auto"
                                        showPopupOnClick="true"
                                        popup="#varPanel"
                                        multiSelect="true"
                                        allowInput="true"
                                        value="${subRule}"
                                        text="${subRule}"
                                />
                                <a class="mini-button" plain="true" onclick="clickVar('createUser')">发起人</a>
                                <a class="mini-button" plain="true" onclick="clickVar('createTime')">发起时间</a>
                            </td>
                        </tr>
                        <tr>
                            <td>启动前置处理器</td>
                            <td>
                                <input class=" mini-textbox" title="实现ProcessStartPreHandler接口的Spring的BeanId"
                                       name="preHandle" value="${preHandle}" style="width:80%;"/>
                                <div class="div-helper">
                                    <div class="iconfont helper icon-Help-configure" title="帮助" placement="w"
                                         helpid="preHandleHelp"></div>
                                </div>
                            </td>

                            <td>启动后置处理器</td>
                            <td>
                                <input class=" mini-textbox" title="实现ProcessStartAfterHandler接口的Spring的BeanId"
                                       name="afterHandle" value="${afterHandle}" style="width:80%;"/>
                                <div class="div-helper">
                                    <div class="iconfont helper icon-Help-configure" title="帮助" placement="w"
                                         helpid="afterHandleHelp"></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="100">结束处理器</td>
                            <td>
                                <input class=" mini-textbox" name="processEndHandle" value="${processEndHandle}"
                                       title="实现ProcessEndHandler接口的Spring的BeanId" style="width:80%;"/>
                                <div class="div-helper">
                                    <div class="iconfont helper icon-Help-configure" title="帮助" placement="w"
                                         helpid="processEndHandleHelp"></div>
                                </div>
                            </td>
                            <td>跳过第一个节点</td>
                            <td>
                                <div name="isSkipFirst" class="mini-checkbox" checked="${isSkipFirst}" readOnly="false"
                                     falseValue="false" trueValue="true" onvaluechanged="handSkipFirst"
                                     text="跳过第一个节点"></div>

                                <div id="needOpinion" name="needOpinion" class="mini-checkbox" checked="${needOpinion}"
                                     enabled="false" readOnly="false" falseValue="false" trueValue="true"
                                     text="填写意见"></div>

                                <div id="startUser" name="startUser" class="mini-checkbox" checked="${startUser}"
                                     enabled="false" readOnly="false" falseValue="false" trueValue="true"
                                     text="指定下一步用户"></div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                启动时批量设置执行人
                            </td>
                            <td>
                                <div id="selectUser" name="selectUser" class="mini-checkbox" readOnly="false"
                                     falseValue="false" trueValue="true" value="${selectUser}" text="启动时设置执行人"></div>
                            </td>
                            <td>
                                启动时显示执行人
                            </td>
                            <td>
                                <div name="showExecPath" class="mini-checkbox" readOnly="false" falseValue="false"
                                     trueValue="true" value="${showExecPath}"></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                启动流程需确认
                            </td>
                            <td>
                                <c:if test="${empty confirmStart }">
                                    <c:set var="confirmStart" value="true"></c:set>
                                </c:if>
                                <div name="confirmStart" class="mini-radiobuttonlist" textField="text" valueField="id"
                                     value="${confirmStart}"
                                     data="[{id:true,text:'需要确认'},{id:false,text:'直接启动'}]">
                                </div>
                            </td>
                            <td>驳回配置</td>
                            <td>
                                <div name="jumpTypes" class="mini-checkboxlist" value="${jumpTypes}"
                                     textField="text" valueField="id" required="true"
                                     data="[{id:'BACK',text:'驳回(上一节点)'},{id:'BACK_TO_STARTOR',text:'驳回(发起人)'},{id:'BACK_SPEC',text:'驳回指定节点'}]"></div>
                            </td>
                        </tr>
                        <tr>

                            <td>
                                外部表单URL
                            </td>
                            <td>
                                <input class="mini-textbox" name="extFormUrl" value="${extFormUrl}" style="width:90%"/>
                                <div class="div-helper">
                                    <div class="iconfont helper icon-Help-configure" title="帮助" placement="w"
                                         helpid="urlHelp"></div>
                                </div>
                            </td>

                            <td>表间公式</td>
                            <td>
                                <input id="btnFormula" name="formulaId" textName="formulaName" allowinput="false"
                                       style="width: 90%" class="mini-buttonedit" showClose="true" text="${formulaName}"
                                       oncloseclick="_ClearButtonEdit" onbuttonclick="onFormulaSelect"
                                       value="${formulaId}"/>
                            </td>
                        </tr>
                        <tr>
                            <td>通知配置</td>
                            <td>
                                <div
                                        name="notices"
                                        class="mini-checkboxlist"
                                        value="${notices}"
                                        textField="text"
                                        valueField="name"
                                        url="${ctxPath}/bpm/core/bpmConfig/getNoticeTypes.do"
                                ></div>
                            </td>
                            <td>跳过配置</td>
                            <td>
                                <div
                                        name="jumpSetting"
                                        class="mini-checkboxlist"
                                        value="${jumpSetting}"
                                        textField="val"
                                        valueField="key"
                                        url="${ctxPath}/bpm/core/bpmConfig/getJumpTypes.do"
                                ></div>
                            </td>
                        </tr>


                        <tr>
                            <td>意见标题配置</td>
                            <td colspan="3">
                                <div id="gridOpinion" name="gridOpinion" class="mini-datagrid"
                                     style="width:300px;height:180px;"
                                     showPager="false" allowCellEdit="true" allowCellSelect="true">
                                    <div property="columns">
                                        <div field="id" headerAlign="center">标识</div>
                                        <div field="text" headerAlign="center">文本
                                            <input property="editor" class="mini-textbox" style="width:100%;"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>子表权限</td>
                            <td colspan="3">
                                <input id="tableRightJson" name="tableRightJson" class="mini-hidden"/>
                                <span id="spanTableRightJson"></span>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div title="事件与接口配置">
                <table class="table-detail column-two" cellspacing="1" cellpadding="0" style="width:100%">
                    <c:forEach items="${eventConfigs}" var="event" varStatus="i">
                        <tr>
                            <td>
                                【${event.eventName}】事件调用配置
                            </td>
                            <td style="padding: 0 !important;">
                                <div class="form-toolBox">
                                    <a class="mini-button" onclick="addRowGrid('eventGrid_${i.index}')">添加</a>
                                    <a class="mini-button btn-red" onclick="delRowGrid('eventGrid_${i.index}')">删除</a>
                                    <a class="mini-button" onclick="upRowGrid('eventGrid_${i.index}')">上移</a>
                                    <a class="mini-button" onclick="downRowGrid('eventGrid_${i.index}')">下移</a>
                                    <a class="mini-button" onclick="configRowGrid('eventGrid_${i.index}')">配置</a>
                                </div>
                                <div
                                        id="eventGrid_${i.index}"
                                        data-options="{eventKey:'${event.eventKey}',eventName:'${event.eventName}'}"
                                        class="mini-datagrid"
                                        allowAlternating="true"
                                        allowCellEdit="true"
                                        allowCellSelect="true" height="auto"
                                        idField="id"
                                        showPager="false"
                                        style="width:100%;"
                                >
                                    <div property="columns">
                                        <div type="indexcolumn" width="20"></div>
                                        <div type="checkcolumn" width="20"></div>

                                        <div field="jumpType" name="jumpType" displayField="jumpTypeName"
                                             width="100">满足的审批动作
                                            <input
                                                    property="editor"
                                                    class="mini-treeselect"
                                                    multiSelect="true"
                                                    textField="jumpTypeName"
                                                    valueField="jumpType"
                                                    parentField="parent"
                                                    data="jumpTypeData"
                                            />
                                        </div>
                                        <div header="异步调用" width="100" field="async" type="checkboxcolumn"
                                             truevalue="YES" falsevalue="NO"></div>
                                        <div type="comboboxcolumn" field="callType" name="callType"
                                             displayField="callTypeName" width="80" headerAlign="center">接口类型
                                            <input
                                                    property="editor"
                                                    class="mini-combobox"
                                                    data="[{id:'Script',text:'Groovy脚本'},{id:'HttpInvoke',text:'HTTP请求服务调用'},{id:'Sql',text:'执行SQL'},{id:'ProcessCall',text:'ProcessCall调用接口'},{id:'jms',text:'发送到队列'},{id:'subProcess',text:'启动子流程'}]"
                                            />
                                        </div>
                                        <div field="callName" name="config" width="160" headerAlign="center">调用功能描述
                                            <input property="editor" class="mini-textbox"/>
                                        </div>
                                    </div>
                                </div>
                                <textarea id="script_${event.eventKey}" name="script"
                                          style="display:none">${event.script}</textarea>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td>
                            全局启动事件调用配置
                        </td>
                        <td style="padding: 0 !important;">
                            <div class="form-toolBox">
                                <a class="mini-button" onclick="addRowGrid('eventGrid_start')">添加</a>
                                <a class="mini-button btn-red" onclick="delRowGrid('eventGrid_start')">删除</a>
                                <a class="mini-button" onclick="upRowGrid('eventGrid_start')">上移</a>
                                <a class="mini-button" onclick="downRowGrid('eventGrid_start')">下移</a>
                                <a class="mini-button" onclick="configRowGrid('eventGrid_start')">配置</a>
                                执行节点:
                                <input name="taskNodesStart"
                                       class="mini-lookup"
                                       style="width:299px;"
                                       textField="name"
                                       valueField="activityId"
                                       popupWidth="auto"
                                       popup="#gridPanel_start"
                                       grid="#taskNodeGrid_start"
                                       multiSelect="true"
                                       onbeforeshowpopup="setTaskNodes"
                                       value=""
                                       text=""
                                />
                            </div>
                            <div
                                    id="eventGrid_start"
                                    data-options="{eventKey:'globalEvent_start',eventName:'全局启动事件'}"
                                    class="mini-datagrid"
                                    allowAlternating="true"
                                    allowCellEdit="true"
                                    allowCellSelect="true" height="auto"
                                    idField="id"
                                    showPager="false"
                                    style="width:100%;"
                            >
                                <div property="columns">
                                    <div type="indexcolumn" width="20"></div>
                                    <div type="checkcolumn" width="20"></div>

                                    <div field="jumpType" name="jumpType" displayField="jumpTypeName"
                                         width="100">满足的审批动作
                                        <input
                                                property="editor"
                                                class="mini-treeselect"
                                                multiSelect="true"
                                                textField="jumpTypeName"
                                                valueField="jumpType"
                                                parentField="parent"
                                                data="jumpTypeData"
                                        />
                                    </div>
                                    <div header="异步调用" width="100" field="async" type="checkboxcolumn" truevalue="YES"
                                         falsevalue="NO"></div>
                                    <div type="comboboxcolumn" field="callType" name="callType"
                                         displayField="callTypeName" width="80" headerAlign="center">接口类型
                                        <input
                                                property="editor"
                                                class="mini-combobox"
                                                data="[{id:'Script',text:'Groovy脚本'},{id:'HttpInvoke',text:'HTTP请求服务调用'},{id:'Sql',text:'执行SQL'},{id:'ProcessCall',text:'ProcessCall调用接口'},{id:'jms',text:'发送到队列'}]"
                                        />
                                    </div>
                                    <div field="callName" name="config" width="160" headerAlign="center">调用功能描述
                                        <input property="editor" class="mini-textbox"/>
                                    </div>
                                </div>
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            全局结束事件调用配置
                        </td>
                        <td style="padding: 0 !important;">
                            <div class="form-toolBox">
                                <a class="mini-button" onclick="addRowGrid('eventGrid_end')">添加</a>
                                <a class="mini-button btn-red" onclick="delRowGrid('eventGrid_end')">删除</a>
                                <a class="mini-button" onclick="upRowGrid('eventGrid_end')">上移</a>
                                <a class="mini-button" onclick="downRowGrid('eventGrid_end')">下移</a>
                                <a class="mini-button" onclick="configRowGrid('eventGrid_end')">配置</a>
                                执行节点:
                                <input name="taskNodesEnd"
                                       class="mini-lookup"
                                       style="width:299px;"
                                       textField="name"
                                       valueField="activityId"
                                       popupWidth="auto"
                                       popup="#gridPanel_end"
                                       grid="#taskNodeGrid_end"
                                       multiSelect="true"
                                       onbeforeshowpopup="setTaskNodes"
                                       value=""
                                       text=""
                                />
                            </div>
                            <div
                                    id="eventGrid_end"
                                    data-options="{eventKey:'globalEvent_end',eventName:'全局结束事件'}"
                                    class="mini-datagrid"
                                    allowAlternating="true"
                                    allowCellEdit="true"
                                    allowCellSelect="true" height="auto"
                                    idField="id"
                                    showPager="false"
                                    style="width:100%;"
                            >
                                <div property="columns">
                                    <div type="indexcolumn" width="20"></div>
                                    <div type="checkcolumn" width="20"></div>

                                    <div field="jumpType" name="jumpType" displayField="jumpTypeName"
                                         width="100">满足的审批动作
                                        <input
                                                property="editor"
                                                class="mini-treeselect"
                                                multiSelect="true"
                                                textField="jumpTypeName"
                                                valueField="jumpType"
                                                parentField="parent"
                                                data="jumpTypeData"
                                        />
                                    </div>
                                    <div header="异步调用" width="100" field="async" type="checkboxcolumn" truevalue="YES"
                                         falsevalue="NO"></div>
                                    <div type="comboboxcolumn" field="callType" name="callType"
                                         displayField="callTypeName" width="80" headerAlign="center">接口类型
                                        <input
                                                property="editor"
                                                class="mini-combobox"
                                                data="[{id:'Script',text:'Groovy脚本'},{id:'Sql',text:'执行SQL'},{id:'HttpInvoke',text:'HTTP请求服务调用'}]"
                                        />
                                    </div>

                                    <div field="callName" name="config" width="160" headerAlign="center">调用功能描述
                                        <input property="editor" class="mini-textbox"/>
                                    </div>
                                </div>
                            </div>

                        </td>
                    </tr>

                    <tr>
                        <td>
                            终止流程执行脚本:
                        </td>
                        <td>
                            <div class="div-helper">
                                <div class="iconfont helper icon-Help-configure" title="帮助" placement="e"
                                     helpid="scriptHelp"></div>
                            </div>
                            <textarea id="endProcessScript" name="endProcessScript"
                                      style="width:100%;height:200px">${endProcessScript}</textarea>
                        </td>
                    </tr>
                </table>
            </div>

            <div title="自定义按钮配置">
                <div class="form-toolBox">
                    <a class="mini-button" onclick="addButton()">添加</a>
                    <a class="mini-button" onclick="addAllButtons()">添加全部</a>
                    <a class="mini-button btn-red" onclick="delButtons()">删除</a>
                    <a class="mini-button" onclick="upRowGrid('buttonGrid')">上移</a>
                    <a class="mini-button" onclick="downRowGrid('buttonGrid')">下移</a>
                </div>
                <div id="buttons" style="display: none">${buttons}</div>
                <div id="buttonGrid" class="mini-datagrid"
                     style="height: 350px; width: 100%;" idField="id"
                     showPager="false" allowCellEdit="true" allowCellSelect="true"
                     editNextOnEnterKey="true"
                     oncellbeginedit="OnButtonCellBeginEdit" editNextRowCell="true" multiSelect="true">
                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div type="checkcolumn"></div>
                        <div name="id" field="id" headerAlign="center">
                            ID <input id="editor" class="mini-textbox" property="editor"/>
                        </div>
                        <div name="name" field="name" headerAlign="center">
                            名称 <input property="editor" class="mini-textbox" style="width: 100%;"/>
                        </div>
                        <div name="alias" field="alias" headerAlign="center">
                            别名 <input property="editor" class="mini-textbox" style="width: 100%;"/>
                        </div>
                        <div name="iconCls" field="iconCls" headerAlign="center">
                            图标<input property="editor" class="mini-textbox" style="width: 100%;"/>
                        </div>
                        <div name="script" field="script" width="150" headerAlign="center">
                            JS脚本方法 <input property="editor" class="mini-textarea" minValue="0"
                                          style="height: 280px; width: 100%;"/>
                        </div>
                    </div>
                </div>
            </div>
            <div title="子流程映射配置">
                <div class="form-toolBox">
                    <a class="mini-button" onclick="addBpmDef()">添加</a>
                    <a class="mini-button btn-red" onclick="delBpmDef()">删除</a>
                    <a class="mini-button" onclick="upRowGrid('bpmDefGrid')">上移</a>
                    <a class="mini-button" onclick="downRowGrid('bpmDefGrid')">下移</a>
                    <a class="mini-button" onclick="bpmDefConfig()">配置</a>
                </div>
                <div id="bpmDefs" style="display: none">${bpmDefs}</div>
                <div class="mini-fit">
                    <div id="bpmDefGrid" class="mini-datagrid"
                         style="height: 100%; width: 100%;" idField="id"
                         showPager="false" allowCellEdit="true" allowCellSelect="true"
                         multiSelect="true">
                        <div property="columns">
                            <div type="indexcolumn" headerAlign="center">序号</div>
                            <div type="checkcolumn"></div>
                            <div name="alias" field="alias" headerAlign="center">
                                子流程 <input property="editor" class="mini-buttonedit" onclick="selectBpmSolution"
                                           style="width: 100%;"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="varPanel" class="mini-panel" title="变量选择面板" style="width:600px;height:250px;"
     showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0;border:0" showFooter="true">
    <div
            id="vargrid"
            class="mini-datagrid"
            style="width:100%;height:100%;"
            borderStyle="border:0"
            showPager="false"
            onrowdblclick="varGridDblClick"
            url="${ctxPath}/bpm/core/bpmSolution/getFormFields.do?solId=${param.solId}&actDefId=${param.actDefId}&nodeId=_PROCESS">
        <div property="columns">
            <div field="val" width="100" headerAlign="center">名称</div>
            <div field="key" width="100" headerAlign="center">字段</div>
        </div>
    </div>
    <div property="footer">
        选择变量选择请双击表格行。
    </div>
</div>

<div style="display:none" id="urlHelp">
	<pre>
 配置这个URL的场景是：
在流程实例列表中，用户点击实例，系统将跳转到该URL，这个URL配置方法样式如下:
oa/instById.do?instId={instId}&busKey={busKey}
上下文变量有：
instId:流程实例ID
busKey: 业务主键
	</pre>
</div>

<div style="display:none" id="preHandleHelp">
	<pre>
流程启动时前置处理器，在调用流程引擎启动流程之前执行。
需要实现接口:
com.redxun.bpm.activiti.handler.ProcessStartPreHandler
接口方法：
processStartPreHandle(ProcessStartCmd cmd);
这里需要配置接口实现类的spring实例Id，这个需要在spring容器进行配置。
	</pre>
</div>

<div style="display:none" id="afterHandleHelp">
	<pre>
流程启动时后置处理器，在调用流程引擎启动流程之后执行。
需要实现接口:
com.redxun.bpm.activiti.handler.ProcessStartAfterHandler
接口方法：
String processStartAfterHandle(ProcessConfig processConfig,ProcessStartCmd cmd,BpmInst bpmInst);
传入参数:
processConfig:流程全局配置
cmd:启动cmd对象
bpmInst:流程实例对象
返回数据：
这里可以返回为空，如果返回的话是返回的一个buskey ,这个数据会更新到 bpmInst的busKey字段。
这里需要配置接口实现类的spring实例Id，这个需要在spring容器进行配置。
	</pre>
</div>
<div style="display:none" id="processEndHandleHelp">
	<pre>
流程结束时调用的处理器，在流程结束时执行。
需要实现接口:
com.redxun.bpm.activiti.handler.ProcessEndHandler
接口方法：
void endHandle(BpmInst bpmInst);
传入参数:
bpmInst:流程实例对象
这里需要配置接口实现类的spring实例Id，这个需要在spring容器进行配置。
	</pre>
</div>

<div style="display:none" id="scriptHelp">
	<pre>
  上下文变量 :
  bpmInst:流程实例对象
	</pre>
</div>

<div id="divGlobalEvent" style="display:none">${globalEvent }</div>

<script type="text/javascript">

    var solId = "${param['solId']}";
    var actDefId = "${param['actDefId']}";
    var nodeType = "${param['nodeType']}";
    var nodeId = "${param['nodeId']}";
    var tableRightJson = <c:choose><c:when test="${empty tableRightJson}">{}</c:when><c:otherwise>${tableRightJson}</c:otherwise></c:choose>;
    var contextVars = '${contextVars}';
    var boDefId = '${boDefId}';
    var opinionText = '${opinionText}';
    //编辑器存储。
    var editorJson = {};

    mini.parse();
    var buttonGrid = mini.get("buttonGrid");
    var bpmDefGrid = mini.get("bpmDefGrid");

    var vargrid = mini.get('vargrid');
    vargrid.load();

    var jumpTypeData = [
        {jumpType: 'AGREE', jumpTypeName: '通过'},
        {jumpType: 'REFUSE', jumpTypeName: '反对'},
        {jumpType: 'BACK', jumpTypeName: '驳回'},
        {jumpType: 'BACK_TO_STARTOR', jumpTypeName: '驳回至发起人'},
        {jumpType: 'RECOVER', jumpTypeName: '撤回'},
        {jumpType: 'TIMEOUT_SKIP', jumpTypeName: '超时跳过'},
        {jumpType: 'SKIP', jumpTypeName: '跳过'},
        {jumpType: 'ABSTAIN', jumpTypeName: '弃权'},
        {jumpType: 'INTERPOSE', jumpTypeName: '干预'}
    ];

    var eventGrids = [];

    function init() {
        //事件Grid
        <c:forEach items="${eventConfigs}" var="event" varStatus="i">
        eventGrids.push(mini.get('eventGrid_${i.index}'));
        </c:forEach>
        for (var i = 0; i < eventGrids.length; i++) {
            var eventKey = eventGrids[i].eventKey;
            var eventName = eventGrids[i].eventName;
            var script = $('#script_' + eventKey).val().trim();
            if (script) {
                var scriptArr = [];
                try {
                    scriptArr = mini.decode(script)
                } catch (e) {
                }
                if (scriptArr instanceof Array) {
                    eventGrids[i].setData(scriptArr);
                }
            }
        }
        var buttons = $("#buttons").text() || "[]";
        buttonGrid.setData(mini.decode(buttons));
        var bpmDefs = $("#bpmDefs").text() || "[]";
        bpmDefGrid.setData(mini.decode(bpmDefs));

        initHelp();

        initOpinionText();

        initEndScript();

        initGlobalScript();
    }
    var signs = false;
    function changeds(e) {
        var tab = e.tab;
        if (tab._id === 2) {
            if (signs === false ){
                initEndScript();
                signs = true;
            }
        }
    }

    var scriptEditor;

    function initEndScript() {
        scriptEditor = CodeMirror.fromTextArea(document.getElementById('endProcessScript'), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-groovy"
        });

    }

    function setTaskNodes(e) {
        var url = __rootPath + "/bpm/core/bpmNodeSet/getTaskNodes.do?actDefId=" + actDefId;
        var gridNodes = e.sender.grid;
        gridNodes.setUrl(url);
        gridNodes.load();
    }

    function initOpinionText() {
        var json = [{"id": "AGREE", text: "同意"}, {id: "REFUSE", "text": "不同意"}, {"id": "ABSTAIN", "text": "弃权"}]
        if (opinionText) {
            json = eval("(" + opinionText + ")");
        }
        var gridOpinion = mini.get("gridOpinion");
        gridOpinion.setData(json);
    }

    $(function () {
        $('.east').powerTip({placement: 'e'});
        $('.south').powerTip({placement: 's'});
        init();
    });


    function clickVar(pvar) {
        var subRuleEdit = mini.get('subRuleEdit');
        var newRule = subRuleEdit.getText();
        newRule = newRule + "\${" + pvar + "}";
        subRuleEdit.setText(newRule);
        subRuleEdit.setValue(newRule);
    }

    function varGridDblClick(e) {
        var grid = e.sender;
        var record = e.record;

        clickVar(record.key);

        var subRuleEdit = mini.get('subRuleEdit');
        subRuleEdit.hidePopup();
    }

    function handSkipFirst(e) {
        var obj = mini.get("needOpinion");
        var objUser = mini.get("startUser");
        var checked = e.sender.checked;
        obj.setEnabled(checked);
        objUser.setEnabled(checked);
    }

    //选择节点
    function selectNode(buttonId) {
        var elButton = mini.get(buttonId);
        var elButtonName = mini.get(buttonId + "Name")
        _OpenWindow({
            title: '选择节点',
            width: 650,
            height: 450,
            url: __rootPath + '/bpm/core/bpmSolution/nodeMessageSelect.do?solId=' + solId,
            onload: function () {
            },
            ondestroy: function (action) {
                if (action != 'ok') {
                    return;
                }
                var iframe = this.getIFrameEl().contentWindow;
                var nodeName = iframe.getNodeName();
                var nodeId = iframe.getNodeId();

                elButton.setValue(nodeId);
                elButton.setText(nodeName);
                elButtonName.setValue(nodeName);
            }
        });

    }

    //清空elButton的值
    function clearTheButton(buttonId) {
        var elButton = mini.get(buttonId);
        var elButtonName = mini.get(buttonId + "Name");
        elButton.setValue("");
        elButton.setText("");
        elButtonName.setValue("");//清空相应的
    }

    //设置中文进去json
    function setThisName(EL) {
        var elButton = mini.get(EL + "Name");//获取域里的name控件
        var ancientButton = mini.get(EL)
        var name = ancientButton.getText();
        elButton.setValue(name);
    }

    //配置事件接口调用
    function configRowGrid(gridId) {
        settingEvent(gridId, solId, actDefId, nodeId, '_PROCESS');
    }


    //保存配置信息
    function saveConfig() {
        var form = new mini.Form('form1');
        form.validate();
        if (!form.isValid()) return;

        var configs = _GetFormJsonMini("form1");

        delete configs.SUB_gridOpinion;

        var events = [];

        for (var i = 0; i < eventGrids.length; i++) {
            var key = eventGrids[i].eventKey;
            var eventName = eventGrids[i].eventName;
            events.push({
                eventKey: key,
                eventName: eventName,
                script: mini.encode(eventGrids[i].getData())
            });
        }

        var globalEvent = getGlobalEvent();
        if (!globalEvent.result) {
            alert(globalEvent.message);
            return;
        }

        var tabRightJson = getRightJson();

        configs.tableRightJson = tabRightJson;
        configs.endProcessScript = scriptEditor.getValue();

        //
        var buttons = mini.get("buttonGrid").getData();
        var bpmDefs = mini.get("bpmDefGrid").getData();

        var opinionText = mini.get("gridOpinion").getData();

        configs.buttons = buttons;
        configs.bpmDefs = bpmDefs;
        configs.opinionText = opinionText;

        var configJson = {
            configs: configs,
            events: events
        };
        configJson.globalEvent = globalEvent.event;

        _SubmitJson({
            url: __rootPath + '/bpm/core/bpmNodeSet/saveNodeConfig.do',
            method: 'POST',
            data: {
                solId: solId,
                nodeType: nodeType,
                nodeId: nodeId,
                actDefId: actDefId,
                configJson: mini.encode(configJson)
            },
            success: function (text) {
                CloseWindow();
            }
        });
    }

    function getGlobalEvent() {
        var events = {};
        var rtn = {result: true, message: "", event: events};
        var startNodesObj = mini.getByName("taskNodesStart");
        var gridStart = mini.get("eventGrid_start").getData();
        if (gridStart.length > 0) {
            if (!startNodesObj.getValue()) {
                rtn.result = false;
                rtn.message = "请选择全局启动事件节点!";
                return rtn;
            }
            events.startIds = startNodesObj.getValue();
            events.startNames = startNodesObj.getText();
            _RemoveGridData(gridStart);
            events.startEvent = gridStart;
        }

        var endNodesObj = mini.getByName("taskNodesEnd");
        var gridEnd = mini.get("eventGrid_end").getData();
        if (gridEnd.length > 0) {
            if (!endNodesObj.getValue()) {
                rtn.result = false;
                rtn.message = "请选择全局完成事件节点!";
                return rtn;
            }
            events.endIds = endNodesObj.getValue();
            events.endNames = endNodesObj.getText();
            _RemoveGridData(gridEnd);
            events.endEvent = gridEnd;
        }
        return rtn;

    }
    
    //字段选择。
	function fieldSelect(e){
		var obj=e.sender;
		var node=obj.getSelectedNode();
		if(node.type=='table') return;
		var jqObj=$(obj.el);
		var parent=$(jqObj).closest("td");
		var divSql=$("textarea",parent);
		var tableName=divSql.attr("tbName");

		if(node.type=='field'){
			appendContent(tableName,"F_" + node.id);
		}
		else{
			appendContent(tableName, node.id);
		}
	}

	function appendContent(tabName,content){
		var editor=editorJson[tabName];
		var doc = editor.getDoc();
		var cursor = doc.getCursor(); // gets the line number in the cursor position
		doc.replaceRange(content, cursor); // adds a new line
	}

    function getRightHtml() {
        if (!tableRightJson) return "";
        var bt = baidu.template;
        var vars = mini.decode(contextVars);
        var data = {data: tableRightJson, vars: vars, boDefId: boDefId, ctx: __rootPath};

        var html = bt("rightTemplate", data);
        var parent = $("#spanTableRightJson");

        parent.html(html);

        $("textarea", parent).each(function (i) {
            var tabName = $(this).attr("tbName");
            var editor = CodeMirror.fromTextArea(this, {
                matchBrackets: true,
                mode: "text/x-sql"
            });
            editorJson[tabName] = editor;
        });

        $(".CodeMirror", parent).each(function (i) {
            $(this).height(150);
        })

        mini.parse();
    }

    //加载权限HTML
    getRightHtml();

    function getRightJson() {
        var spanObj = $("#spanTableRightJson");
        var json = {};
        $(".trName", spanObj).each(function (i) {
            var tr = $(this);
            var tableName = tr.attr("tbName");
            var tbRight = $(".tbRight", tr);
            var val = $('input:radio:checked', tbRight).val();
            var obj = {type: val};
            if (val == "sql") {
                var editor = editorJson[tableName];
                obj.sql = editor.getValue();
            }
            json[tableName] = obj;
        });
        return mini.encode(json);
    }

    function handType(obj) {
        var jqObj = $(obj);
        var parent = $(obj).closest("td");
        var divSql = $(".sql", parent);
        var type = jqObj.val();
        if (type == "sql") {
            divSql.show();
        } else {
            divSql.hide();
        }
    }

    function isButtonExist(rows, key) {
        var found = false;
        for (var j = 0; j < rows.length; j++) {
            var row = rows[j];
            if (row.alias == key) {
                found = true;
                break;
            }
        }
        return found;
    }

    function addAllButtons() {
        var url = __rootPath + '/bpm/core/bpmConfig/getCheckButtons.do?type=inst&solId=' + solId + '&actDefId=' + actDefId;

        function handButtons(text) {
            var result = mini.decode(text);
            var rows = buttonGrid.getData();
            for (var i = 0; i < result.length; i++) {
                var obj = result[i];
                obj.isDefault = 1;
                var key = obj.alias;
                var found = isButtonExist(rows, key);
                if (found) continue;
                buttonGrid.addRow(obj);
            }
        }

        $.get(url, handButtons);
    }

    function delButtons() {
        var selecteds = buttonGrid.getSelecteds();
        buttonGrid.removeRows(selecteds);
    }

    function addButton() {
        buttonGrid.addRow({defaultBtn: 0});
    }

    function delBpmDef() {
        var selecteds = bpmDefGrid.getSelecteds();
        bpmDefGrid.removeRows(selecteds);
    }

    function addBpmDef() {
        bpmDefGrid.addRow({defaultBtn: 0});
    }

    function bpmDefConfig() {
        var row = bpmDefGrid.getSelected();
        if (!row || !row.alias) {
            alert("请选择子流程");
            return;
        }
        var config = mini.clone(row.config);
        if (config) {
            openBpmDefConfigDialog(config, function (data) {
                row.config = data;
            });
        } else {
            var conf = {
                url: __rootPath + "/bpm/core/bpmSolution/getTableNameByKey.do",
                method: 'POST',
                data: {key: row.alias,boDefId:boDefId},
                showMsg: false,
                success: function (result) {
                    openBpmDefConfigDialog(result, function (data) {
                        row.config = data;
                    });
                }
            }
            _SubmitJson(conf);
        }
    }

    function openBpmDefConfigDialog(obj, callBack) {
        var boName = '${boName}';
        var url = __rootPath + "/bpm/core/bpmNodeSet/bpmConfig.do?boDefId=" + boDefId + "&boName=" + boName + "&solId=" + solId + '&actDefId=' + actDefId;
        _OpenWindow({
            url: url,
            title: "子流程配置", max: true,
            onload: function () {
                var iframe = this.getIFrameEl().contentWindow;
                iframe.setDataConf(obj);
            },
            ondestroy: function (action) {
                if (action != "ok") return;
                var iframe = this.getIFrameEl().contentWindow;
                var data = iframe.getValue();
                if (callBack) {
                    callBack(data);
                }
            }
        });
    }

    function selectBpmSolution(e) {
        var btn = e.sender;
        var row = bpmDefGrid.getSelected();
        _BpmSolutionDialog(true, function (sols) {
            btn.setText(sols[0].name);
            btn.setValue(sols[0].key);
            row.name = sols[0].name;
            row.config = null;
        })
    }

    function OnButtonCellBeginEdit(e) {
        var col = e.column;
        var name = col.name;
        var row = e.record;
        var upName = name.substring(0, 1).toUpperCase() + name.substring(1);
        var editor = mini.get("btn" + upName + "Editor");
        if (row.isDefault == 1 && (name == "id" || name == "alias" || name == "script")) {
            e.cancel = true;
        } else {
            e.cancel = false;
        }
    }

    function onFormulaSelect(e) {
        var btn = e.sender;
        if (!boDefId) {
            alert("请先在表单设置业务对象模型!");
            return;
        }
        var conf = {
            boDefId: boDefId, single: false, callBack: function (data) {
                var ids = [];
                var names = [];
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    ids.push(item.id);
                    names.push(item.name);
                }
                btn.setText(names.join(","));
                btn.setValue(ids.join(","));
            }
        };
        openFormulaDialog(conf);
    }


    function initGlobalScript() {
        var jsonStr = $("#divGlobalEvent").text();
        if (!jsonStr) return;
        var json = eval("(" + jsonStr + ")");
        var startNodeObj = mini.getByName("taskNodesStart");
        var startGrid = mini.get("eventGrid_start");

        var endNodeObj = mini.getByName("taskNodesEnd");
        var endGrid = mini.get("eventGrid_end");

        if (json.startIds) {
            startNodeObj.setValue(json.startIds);
            startNodeObj.setText(json.startNames);
            startGrid.setData(json.startEvent);
        }

        if (json.endIds) {
            endNodeObj.setValue(json.endIds);
            endNodeObj.setText(json.endNames);
            endGrid.setData(json.endEvent);
        }

    }
</script>
</body>
</html>
