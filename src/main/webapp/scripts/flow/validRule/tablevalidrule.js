

function addRule(gridName){
	var grid = mini.get(gridName);
	var node = grid.getSelectedNode();
	var newNode = {isConf:false};
	if(node){
		if(node._level==1)return;
		newNode.isConf=true;
	}
	var action = node?"add":"before";
	grid.addNode(newNode, action, node);
}

function removeRule(gridName){
	var grid = mini.get(gridName);
	var row = grid.getSelecteds();	
	
	if(!row){
		alert("请选择至少一个节点删除");
		return;
	}
	
	if (!confirm("确定删除此记录？")) {return;}

    if(row){
    	grid.removeNodes(row);
    }
}

function onScriptEdit(e){
	var tab = gridTab.getActiveTab();
	var grid = mini.get("grid-"+tab.name+"-"+boDefId);
	var node = grid.getSelectedNode();
	if(!node.alias){
		alert("请选择规则！");
		return;
	}
	if(node.alias=="required" || node.alias=="unique")return;
	_OpenWindow({
		title:'规则配置',
		height:500,
		width:680,
		url:__rootPath+"/bpm/form/valid/formValidRule/"+node.alias+"?tableName="+tab.name+"&boDefId="+boDefId,
		onload:function(){
        	var iframe = this.getIFrameEl().contentWindow;
        	var btn=e.sender;
        	var data = btn.getValue();
        	if(node.alias!="reg" && node.alias!="script"){
           		data = mini.decode(data);
           	}
        	iframe.setData(data);
        },
		ondestroy: function(action) {
        	if(action!="ok") return ;
       		var iframe = this.getIFrameEl().contentWindow;
           	var data=iframe.getData();
           	if(node.alias=="reg"){
           		data = data.reg;
           	}else if(node.alias=="script"){
           		data = data;
		    }else{
           		data = mini.encode(data);
           	}
           	var btn=e.sender;
        	btn.setValue(data);
        	btn.setText(data);
        }
	});
}

function addTableTab(data){
	var comment=data.comment;
	var name = data.name;
	
	var tab=gridTab.addTab({
		title:comment,
		name:name,
		showCloseButton:true,
		iconCls:'icon-table'
	});
	var el=gridTab.getTabBodyEl(tab);
	data.num=new Date().getTime();
	var html=baidu.template('vaildRuleSettingTemplate',data);
	$(el).html(html);
	mini.parse();
	//加载数据
	loadData(data,el);
	//gridTab.activeTab(tab);
}

function loadData(data,el){
	var valids=data.valids;
	var grid=getDataGrid(el);
	var ary = [];
	var i = 0;
	for(var key in valids){
		var obj = {isConf:false,name:key,children:valids[key]};
		ary[i]=obj;
		i++;
	}
	grid.loadData(ary);
}

function getDataGrid(el){
	var ctls=mini.getChildControls(el);
	for(var i=0;i<ctls.length;i++){
		var ctl=ctls[i];
		if(ctl.type=="treegrid"){
			return ctl;
		}
	}
}

function OnCellBeginEdit(e) {
	var field = e.field;
	if (!e.row.isConf){
		e.editor = null;
		e.column.editor = null;
		if(field == "name") {
		   var ary = e.sender.id.split("-");
		   var tableName = ary[1];
		   var boDefId = ary[2];
           e.editor=mini.get('fieldCombo');
           e.editor.setUrl(__rootPath+"/sys/bo/sysBoEnt/getFieldByBoDefId.do?tableName="+tableName+"&boDefId="+boDefId);
           e.column.editor=e.editor;
		}
    }else{
    	if(field == "name"){
    		e.editor=mini.get('ruleName');
            e.column.editor=e.editor;
    	}
    	if(field == "alias"){
			e.editor=mini.get("aliasCombo");
            e.editor.setUrl(__rootPath+"/bpm/form/formValidRule/getValidRules.do");
            e.column.editor=e.editor;
		}
    	if(field == "action"){
    		e.editor=mini.get("actionList");
    		e.editor.setData([{id:"add",text:"新增"},{id:"upd",text:"修改"},{id:"del",text:"删除"}]);
    	    e.column.editor=e.editor;
    	}
    	if(field == "conf"){
    		e.editor=mini.get("buttonEditEditor");
    	    e.column.editor=e.editor;
    	}
    }
}
