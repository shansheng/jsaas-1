
UE.registerUI('customtable',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'自定义样式表单',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-image: url('+__rootPath+'/scripts/ueditor/themes/default/images/anchor.gif)',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-customtable');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});
UE.registerUI('fieldset',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'边框',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-image: url('+__rootPath+'/scripts/ueditor/themes/default/images/anchor.gif)',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	var timestamp=new Date().getTime();
        	var html="<fieldset class='fieldsetContainer'><legend class='title'>标题</legend><br/></fieldset><br/>";
        	editor.execCommand('insertHtml',html);
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});

UE.registerUI('button',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'自定义按钮',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-image: url('+__rootPath+'/scripts/ueditor/themes/default/images/anchor.gif)',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-button');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});



UE.registerUI('nodeopinion',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'审批意见控件',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-image: url('+__rootPath+'/scripts/ueditor/themes/default/images/anchor.gif)',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-nodeopinion');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});



UE.registerUI('relatedsolution',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'关联流程',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-image: url('+__rootPath+'/scripts/ueditor/themes/default/images/anchor.gif)',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-relatedsolution');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});

UE.registerUI('div',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'DIV容器',
      
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-div');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});



//日期计算
UE.registerUI('chineseup',function(editor,uiName){
	
    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
    editor.registerCommand("chineseup",{
        execCommand:function(){
        		var dialog = new UE.ui.Dialog({
					iframeUrl:this.options.UEDITOR_HOME_URL + UE.FormDesignBaseUrl
					+'/config/mini-chinese.jsp?titleName=中文大写',
					name:uiName,
					editor:this,
					title: '中文大写',
					cssRules:"width:400px;height:300px;",
					buttons:[
					{
						className:'edui-okbutton',
						label:'确定',
						onclick:function () {
							dialog.close(true);
						}
					},
					{
						className:'edui-cancelbutton',
						label:'取消',
						onclick:function () {
							dialog.close(false);
						}
					}]
				});
        		dialog.render();
        		dialog.open();
		},
        queryCommandState : function() {
        	 var rtn= findChineseUp(this) ;
        	 return rtn;
        }
    });
    findChineseUp = function(editor){
    	var selectNode=editor.selection.getStart();
    	var node=$(selectNode);
		if(selectNode.tagName=="DIV" && node.attr("class")=="divContainer"){
			return 0;
		}
		return -1;
    };
    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:"中文大写转换",
        //点击时执行的命令
        onclick:function () {
        	editor.editdom = editor.selection.getStart();
        	editor.execCommand("chineseup");
        }
    });

    //当点到编辑内容上时，按钮要做的状态反射
    editor.addListener('selectionchange', function () {
        var state = editor.queryCommandState("chineseup");
        if (state == -1) {
            btn.setDisabled(true);
            btn.setChecked(false);
        } else {
            btn.setDisabled(false);
            btn.setChecked(state);
        }
    });

    
    return btn;
});


//日期计算
UE.registerUI('datecalc',function(editor,uiName){
	
    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
    editor.registerCommand("datecalc",{
        execCommand:function(){
        		var dialog = new UE.ui.Dialog({
					iframeUrl:this.options.UEDITOR_HOME_URL + UE.FormDesignBaseUrl
					+'/config/mini-datecalc.jsp?titleName=日期计算设置',
					name:uiName,
					editor:this,
					title: '日期计算设置',
					cssRules:"width:600px;height:400px;",
					buttons:[
					{
						className:'edui-okbutton',
						label:'确定',
						onclick:function () {
							dialog.close(true);
						}
					},
					{
						className:'edui-cancelbutton',
						label:'清空&关闭',
						onclick:function () {
							dialog.close(false);
						}
					}]
				});
        		dialog.render();
        		dialog.open();
		},
        queryCommandState : function() {
        	 var rtn= findTextBox(this) ;
        	 return rtn;
        }
    });
    findTextBox = function(editor){
    	var selectNode=editor.selection.getStart();
    	var plugins=selectNode.getAttribute("plugins");
    	if(plugins && plugins=="mini-textbox"){
			return 0;
		}
		return -1;
    };
   
    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:"日期计算",
        //点击时执行的命令
        onclick:function () {
        	editor.editdom = editor.selection.getStart();
        	editor.execCommand("datecalc");
        }
    });

    //当点到编辑内容上时，按钮要做的状态反射
    editor.addListener('selectionchange', function () {
        var state = editor.queryCommandState("datecalc");
        if (state == -1) {
            btn.setDisabled(true);
            btn.setChecked(false);
        } else {
            btn.setDisabled(false);
            btn.setChecked(state);
        }
    });

    
    return btn;
});

/**
 * customquery
 */
UE.registerUI('customqueryui',function(editor,uiName){
	
    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
    editor.registerCommand("customquerydef",{
        execCommand:function(){
        		var dialog = new UE.ui.Dialog({
					iframeUrl:this.options.UEDITOR_HOME_URL + UE.FormDesignBaseUrl
					+'/config/mini-customquery.jsp?titleName=自定义查询',
					name:uiName,
					editor:this,
					title: '自定义查询设置',
					cssRules:"width:800px;height:450px;",
					buttons:[
					{
						className:'edui-okbutton',
						label:'确定',
						onclick:function () {
							dialog.close(true);
						}
					},
					{
						className:'edui-cancelbutton',
						label:'关闭',
						onclick:function () {
							dialog.close(false);
						}
					}]
				});
        		dialog.render();
        		dialog.open();
		},
        queryCommandState : function() {
        	 var rtn= findTextBox(this) ;
        	 return rtn;
        }
    });
    /**
     * 允许配置自定查询的控件。
     */
    isAllowControl=function(plugins){
    	var allowPluggins=["mini-textbox","mini-user","mini-datepicker","mini-group","mini-dep","mini-buttonedit",'mini-combobox'];
    	for(var i=0;i<allowPluggins.length;i++){
    		if(allowPluggins[i]==plugins){
    			return true;
    		}
    	}
    	return false;
    };
    
    findTextBox = function(editor){
    	var selectNode=editor.selection.getStart();
    	var plugins=selectNode.getAttribute("plugins");
    	if(plugins ){
    		return isAllowControl(plugins)?0:-1;
		}
		return -1;
    };
   
    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:"自定义查询",
        //点击时执行的命令
        onclick:function () {
        	editor.editdom = editor.selection.getStart();
        	editor.execCommand("customquerydef");
        }
    });

    //当点到编辑内容上时，按钮要做的状态反射
    editor.addListener('selectionchange', function () {
        var state = editor.queryCommandState("customquerydef");
        if (state == -1) {
            btn.setDisabled(true);
            btn.setChecked(false);
        } else {
            btn.setDisabled(false);
            btn.setChecked(state);
        }
    });

    return btn;
});

//注册条件容器按钮在设计器中
UE.registerUI('conditiondiv',function(editor,uiName){
    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'条件DIV容器',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-condition-div');
        }
    });
    //因为你是添加button,所以需要返回这个button
    return btn;
});



/**
 * 字段关联
 */
UE.registerUI('fieldlinkui',function(editor,uiName){
	
    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
    editor.registerCommand("fieldlink",{
        execCommand:function(){
        		var dialog = new UE.ui.Dialog({
					iframeUrl:this.options.UEDITOR_HOME_URL + UE.FormDesignBaseUrl
					+'/config/mini-fieldlink.jsp?titleName=关联字段',
					name:uiName,
					editor:this,
					title: '关联字段设置',
					cssRules:"width:800px;height:480px;",
					buttons:[
					{
						className:'edui-okbutton',
						label:'确定',
						onclick:function () {
							dialog.close(true);
						}
					},
					{
						className:'edui-cancelbutton',
						label:'关闭',
						onclick:function () {
							dialog.close(false);
						}
					}]
				});
        		dialog.render();
        		dialog.open();
		},
        queryCommandState : function() {
        	 var rtn= findControls(this) ;
        	 return rtn;
        }
    });
    /**
     * 允许配置自定查询的控件。
     */
    isAllowControl=function(plugins){
    	var allowPluggins=["mini-textbox","mini-user","mini-datepicker","mini-group","mini-dep","mini-buttonedit",'mini-combobox','mini-div'];
    	for(var i=0;i<allowPluggins.length;i++){
    		if(allowPluggins[i]==plugins){
    			return true;
    		}
    	}
    	return false;
    };
    
    findControls = function(editor){
    	var selectNode=editor.selection.getStart();
    	var plugins=selectNode.getAttribute("plugins");
    	if(plugins ){
    		return isAllowControl(plugins)?0:-1;
		}
		return -1;
    };
   
    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:"关联字段",
        //点击时执行的命令
        onclick:function () {
        	editor.editdom = editor.selection.getStart();
        	editor.execCommand("fieldlink");
        }
    });

    //当点到编辑内容上时，按钮要做的状态反射
    editor.addListener('selectionchange', function () {
        var state = editor.queryCommandState("fieldlink");
        if (state == -1) {
            btn.setDisabled(true);
            btn.setChecked(false);
        } else {
            btn.setDisabled(false);
            btn.setChecked(state);
        }
    });

    return btn;
});


UE.registerUI('iframe',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'iframe控件',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -878px -0px;',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-iframe');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});

UE.registerUI('btnWord',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'WORD控件',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -860px -0px',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-viewword');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});

UE.registerUI('btnList',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'插入列表',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -907px -0px',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-list');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});

//上下文控件
UE.registerUI('btnContextOnly',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'上下文控件',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -939px -0px',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
        	exePlugin('mini-contextonly');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});


//上下文控件
UE.registerUI('btnArea',function(editor,uiName){

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name:uiName,
        //提示
        title:'地址控件',
        //需要添加的额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules :'background-position: -965px -0px',
        //点击时执行的命令
        onclick:function () {
            //这里可以不用执行命令,做你自己的操作也可
            exePlugin('mini-area');
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
});


