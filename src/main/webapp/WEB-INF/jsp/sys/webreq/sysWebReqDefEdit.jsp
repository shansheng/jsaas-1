<%-- 
    Document   : [流程数据绑定表]编辑页
    Created on : 2018-07-24 17:46:42
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>WEB调用请求定义编辑</title>
<%@include file="/commons/edit.jsp"%>
<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
<script src="${ctxPath}/scripts/codemirror/mode/xml/xml.js"></script>
<script src="${ctxPath}/scripts/codemirror/addon/mode/multiplex.js"></script>
</head>
<body>
<div class="topToolBar">
	<div>
		<rx:toolbar toolbarId="toolbar1" pkId="bpmDataBind.id" />
	</div>
</div>
	<div class="mini-fit">
	<div class=form-container>
		<form id="form1" method="post">
			<div class="form-outer"  id="accountInfo">
							<input id="pkId" name="id" class="mini-hidden" value="${sysWebReqDef.id}" />
							<table class="table-detail column_2_m" cellspacing="1" cellpadding="0" style="width: 100%;" id="accountTable">
								<caption>WEB调用请求定义基本信息</caption>
								<tr>
									<td width="120">
										<span class="starBox">
											名　　称<span class="star">*</span>
										</span>
									</td>
									<td width="250">
										<input name="name" class="mini-textbox" vtype="maxLength:200" required="true" style="width:60%" />
									 </td>
									 <td width="120">
										<span class="starBox">
											别　　名<span class="star">*</span>
										</span>
									</td>
									<td width="250"><input class="mini-textbox" name="key" vtype="maxLength:64" required="true"  style="width:60%"/></td>
								</tr>
								<tr>
									<td width="120">
										<span class="starBox">
											请求地址<span class="star">*</span>
										</span>
									</td>
									<td colspan="3">
										<input 
										    id="url"
											class="mini-textbox" 
											name="url" 
											required="true" 
											style="width: 60%" 
										/>
										<a class="mini-button" onclick="loadApp">调用请求</a>
									</td>
								</tr>
								<tr>
									<td width="120">
										<span class="starBox">
											请求方式<span class="star">*</span>
										</span>
									</td>
									<td width="250">
										<input 
											id="mode"
											name="mode"
											class="mini-combobox" 
											emptyText="请选择..."
											required="true"
											url="${ctxPath}/sys/webreq/sysWebReqDef/getSelectData.do?key=MODE"
											value="RESTFUL"
											onvaluechanged="modeSelect"
										/>
									 </td>
									 <td width="120">
										<span class="starBox">
											请求类型<span class="star">*</span>
										</span>
									</td>
									<td width="250">
										<input 
										    id="type"
											name="type"
											class="mini-combobox" 
											emptyText="请选择..."
											required="true"
											url="${ctxPath}/sys/webreq/sysWebReqDef/getSelectData.do?key=TYPE"
										/>
									</td>
								</tr>
								<tr>
									<td width="120">
										<span class="starBox">
											状　　态
										</span>
									</td>
									<td id="dataTypeStatus">
										<input 
											name="status"
											class="mini-combobox" 
											emptyText="请选择..."
											value="1"
											url="${ctxPath}/sys/webreq/sysWebReqDef/getSelectData.do?key=STATUS"
										/>
									</td>
									<td width="120">
										<span class="starBox">
											内容类型
										</span>
									</td>
									<td>
										<input 
											name="dataType"
											class="mini-combobox" 
											emptyText="请选择..."
											onitemclick="itemclick"
											value=""
											data="[{id:'application/json',text:'json'},{id:'application/x-www-form-urlencoded',text:'键值对'},{id:'text/xml',text:'xml'}]"
										/>
									</td>
								</tr>
							</table>
					</div>
					<div id="tabs" class="mini-tabs" activeIndex="0"  style="width:100%;height:600px;" onactivechanged="activeChanged">
						<div class="form-outer" title="请求头配置">
								<div id="datagrid1" class="mini-datagrid" showPager="false"
									style="width: 100%; height: 100%;" allowResize="false"
									idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false" oncellendedit="onChangeValue"
									multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true"
									 pagerButtons="#pagerButtons">
									<div property="columns">
										<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
										<div field="key" width="120" headerAlign="center">键
											<input property="editor" class="mini-textbox" style="width:100%;" /> 
										</div>
										<div field="value"  width="120" headerAlign="center">值
											<input property="editor" class="mini-textbox" style="width:100%;" /> 
										</div>
										<div field="description"  width="120" headerAlign="center">说明
											<input property="editor" class="mini-textbox" style="width:100%;" /> 
										</div>
									</div>
								</div>
					  </div>
					  <div title="传递数据">
					  		<span>注：此处键供定义,应用于请求报文中 ; 值供测试使用</span>
							<div id="datagrid2" class="mini-datagrid" showPager="false"
										style="width: 100%; height: 100%;" allowResize="false"
										idField="id" allowCellEdit="true" allowCellSelect="true" allowSortColumn="false" oncellendedit="onChangeValue"
										multiSelect="true" showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true"
										 pagerButtons="#pagerButtons">
										<div property="columns">
											<div name="action" cellCls="actionIcons" width="50" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
											<div field="key" width="120" headerAlign="center">键
												<input property="editor" class="mini-textbox" style="width:100%;" /> 
											</div>
											<div field="value"  width="120" headerAlign="center">值
												<input property="editor" class="mini-textbox" style="width:100%;" /> 
											</div>
											<div field="description"  width="120" headerAlign="center">说明
												<input property="editor" class="mini-textbox" style="width:100%;" /> 
											</div>
										</div>
									</div>
					  </div>
					  <div title="请求报文">
						<textarea id="listHtml" name="listHtml" ><c:out value="${listHtml }" escapeXml="true"/></textarea>
					  </div>
					  <div title="返回内容">
						<textarea id="responseHtml" name="responseHtml" ></textarea>
					  </div>
			</div>
		</form>
	
	</div>
</div>
	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var pkId = '${bpmDataBind.id}';
	var tabIndex = 0;
	var tabs = mini.get("tabs");
	var datagrid1 = mini.get("datagrid1");
	var datagrid2 = mini.get("datagrid2");
	
	
	//行功能按钮
	function onActionRenderer(e) {
		var s = '<span  title="删除" onclick="delRow()">删除</span>';
		return s;
	}
	
	 //删除行
    function delRow() {
    	var datagrid;
		if(tabIndex==0){
			datagrid = datagrid1;
		}
		if(tabIndex==1){
			datagrid = datagrid2;
		}
		if(datagrid.getData().length<=1){
			mini.showTips({content:"不允许删除最后一位参数!",state:"warning"});
			return;
		}
		mini.confirm("确定删除选中记录？","确定？",function(action){
    		if(action!='ok'){
    			return;
    		}else{
    			var selecteds=datagrid.getSelecteds();
    			datagrid.removeRows(selecteds);
    		}
    	});
		
    }
	 
	$(function(){
		initForm();
	})
	
	function initForm(){
		datagrid1.addRow({key:"",value:"",description:""});
		datagrid2.addRow({key:"",value:"",description:""});
		if(!pkId) return;
		var url="${ctxPath}/sys/webreq/sysWebReqDef/getJson.do";
		$.post(url,{ids:pkId},function(json){
			form.setData(json);
			datagrid1.setData(mini.decode(json.paramsSet));
			datagrid2.setData(mini.decode(json.data));
			datagrid1.addRow({key:"",value:"",description:""});
			datagrid2.addRow({key:"",value:"",description:""});
			editor1.setValue(json.temp);
			
			initMode(json.mode);
			getTabShow("返回内容",false);
		});
	}
	
	//请求报文文本框渲染
	CodeMirror.defineMode("selfHtml", function(config) {
		return CodeMirror.multiplexingMode(
			CodeMirror.getMode(config, "text/xml"),
			{open: "<<", close: ">>",
			mode: CodeMirror.getMode(config, "text/plain"),
			delimStyle: "delimit"}
			);
	});
	var editor1 = CodeMirror.fromTextArea(document.getElementById("listHtml"), {
			  mode: "selfHtml",
			  lineNumbers: true,
			  lineWrapping: true
		});
	editor1.setSize('auto','100%');
	var editor2 = CodeMirror.fromTextArea(document.getElementById("responseHtml"), {
		  mode: "selfHtml",
		  lineNumbers: true,
		  lineWrapping: true
	});
	editor2.setSize('auto','100%');
	
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
	    var d1 = datagrid1.getData();//请求头设置
	    var d2 = datagrid2.getData();//传递数据
	    var header = mini.encode(parseGridData(d1));
	    var body = mini.encode(parseGridData(d2));
	    var temp = editor1.getValue();
	    data['paramsSet'] = header;
	    data['data'] = body;
	    data['temp'] = temp;
		var config={
        	url:"${ctxPath}/sys/webreq/sysWebReqDef/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
		_SubmitJson(config);
	}
	
	//请求方式更改
	function modeSelect(e){
		var val = e.value;
		initMode(val);
	}
	
	function initMode(val){
		if(val=="RESTFUL"){
			var val = mini.getByName("dataType").text;
			if(val=="json"){
				getTabShow("请求报文",true);
			}else{
				getTabShow("请求报文",false);
			}
		}
		if(val=="SOAP"){
			getTabShow("请求报文",true);
		}
	}
	
	function getTabShow(title,flag){
		var ary = tabs.getTabs();
		for(var i=0;i<ary.length;i++){
			var obj = ary[i];
			if(obj.title==title){
				tabs.updateTab(obj, {
					visible : flag
				});
				return obj;
			}
		}
	}
	
	function itemclick(e){
		var val = e.item.id;
		var text = e.item.text;
		if(text=="json"){
			getTabShow("请求报文",true);
		}else{
			getTabShow("请求报文",false);
		}
		var row = datagrid1.findRow(function(row){
		    if(row.key == "Content-Type") return true;
		});
		if(!row){
			datagrid1.addRow({"key":"Content-Type","value":val+";charset=UTF-8","description":""})
			return;
		}
		row.value=val+";charset=UTF-8";
		datagrid1.updateRow(row);
	}
	
	//tab改变时修改
	function activeChanged(e){
		tabIndex = e.index;
		editor1.refresh();
		editor2.refresh();
	}
	
	function onChangeValue(e){
		var index = e.rowIndex;
		var datagrid;
		if(tabIndex==0){
			datagrid = datagrid1;
		}
		if(tabIndex==1){
			datagrid = datagrid2;
		}
		var row = datagrid.getRow(index);
		if(row){
			if(row.key=="" && row.value==""){
				if(datagrid.getData().length>1){
					datagrid.removeRow(row);
				}
			}
		}
		row = datagrid.getRow(index+1);
		if(!row){
			if(e.value!=""){
				datagrid.addRow({key:"",value:"",description:""});
			}
		}
	}
	
	function loadApp(){
		//请求方式
		var mode=mini.get("mode").getValue();
		//请求类型
		var type=mini.get("type").getValue();
		//请求地址
		var url=mini.get("url").getValue();
		
		var val = mini.getByName("dataType").text;
		var temp = editor1.getValue();
		
		if(!url){
			alert("请求地址为空!");
			return;
		}
		var tempUrl = "";
		var config = {};
		if(mode.toUpperCase()=="SOAP"){
			tempUrl = __rootPath +"/sys/webreq/sysWebReqDef/soap.do";
		}
		if(mode.toUpperCase()=="RESTFUL"){
			tempUrl = __rootPath +"/sys/webreq/sysWebReqDef/restful.do";
		}
		config = {
				url:url,
				type:type,
				header:mini.encode(parseGridData(datagrid1.getData())),
				body:mini.encode(parseGridData(datagrid2.getData())),
				temp:temp
			};
		postSubmit(tempUrl,config);
	}
	
	function isEmpty(str){
		if(!str || str==""){
			return true;
		}
		return false;
	}
	
	function parseGridData(data){
		var ary = [];
		for(var i =0;i<data.length;i++){
			var obj = {};
			obj.key = data[i].key;
			obj.value = data[i].value;
			obj.description = data[i].description;
			if(isEmpty(obj.key)) continue;
			ary[i] = obj;
		}
		return ary;
	}
	
	function postSubmit(url,config){
		$.post(url,config,function(data){
			if(data.success){
				editor2.setValue(data.data);
				if(data.message!=""){
					mini.showTips({content:data.message});
				}
				tabs.activeTab(getTabShow("返回内容",true));
			}
			else{
				alert("出错信息:" +data.message);
			}
		});
	}
	</script>
</body>
</html>