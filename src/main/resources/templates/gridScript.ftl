<script type="text/javascript">
	var fullWindow=true;
	//进行转化
	mini.parse();
	
	//用于弹出的子页面获得父窗口
	top['${entityName}']=window;
	
    var grid = mini.get("${gridId}");
    //存储其原URL，为后续的高级查询条件的组合
    var gdBaseUrl=grid.getUrl();
  
	grid.load();

	function loadGrid(){
		grid.load();
	}
    function detailRow(pkId) {
    	var obj=getWindowSize();
        _OpenWindow({
        	url: "${rootPath}/${baseUrl}/get.do?pkId=" + pkId,
            title: "${entityTitle}明细", width: obj.width, height: obj.height,
        });
    }
	
	//编辑
    function detail() {
		var row = grid.getSelected();
        
        if (row) {
			var rows = grid.getSelecteds();
			if(rows.length>1){
				alert("选中多条记录时不能操作!");
				grid.deselects(rows,false);
				return;
			}
            detailRow(row.pkId);
        } else {
            alert("请选中一条记录");
        }
        
    }

	//复制添加数据
    function add(rowData) {
    
    	var width=${winWidth};
    	var height=${winHeight};
    	if(fullWindow){
    		width=getWindowSize().width;
    		height=getWindowSize().height;
    	}

    	if(isExitsFunction('_add')){
    		_add(rowData);
    		return;
    	}
    	var urlAppend="";
    	if(rowData){
    		urlAppend="forCopy=true&pkId="+rowData.pkId;
    	}
    	
    	_OpenWindow({
    		url: "${rootPath}/${baseUrl}/edit.do?"+urlAppend,
            title: "新增${entityTitle}", width: width, height: height,
            ondestroy: function(action) {
            	if(action == 'ok' && typeof(addCallback)!='undefined'){
            		var iframe = this.getIFrameEl().contentWindow;
            		addCallback.call(this,iframe);
            	}else if (action == 'ok') {
                    grid.reload();
                }
            }
    	});
    }
	//编辑行数据
    function editRow(pkId,fullWindow) {    
    	var width=${winWidth};
    	var height=${winHeight};
    	if(fullWindow){
    		width=getWindowSize().width;
    		height=getWindowSize().height;
    	}
    
    	if(isExitsFunction('_editRow')){
    		_editRow(pkId);
    		return;
    	}
    	    
        _OpenWindow({
    		 url: "${rootPath}/${baseUrl}/edit.do?pkId="+pkId,
            title: "编辑${entityTitle}",
            width: width, height: height,
            ondestroy: function(action) {
                if (action == 'ok') {
                    grid.reload();
                }
            }
    	});
    }
    
	//编辑
    function edit(fullWindow) {
		var row = grid.getSelected();
                //行允许删除
        if(rowEditAllow && !rowEditAllow(row)){
        	return;
        }
        
        if (row) {
			var rows = grid.getSelecteds();
			if(rows.length>1){
				alert("选中多条记录时不能编辑!");
				grid.deselects(rows,false);
				return;
			}
            editRow(row.pkId,fullWindow);
        } else {
            alert("请选中一条记录");
        }
        
    }
    //删除行
    function delRow(pkId) {
    
    	if(isExitsFunction('_delRow')){
    		_delRow(pkId);
    		return;
    	}
    	mini.confirm("确定删除选中记录？","确定？",function(action){
    		if(action!='ok'){
    			return;
    		}else{
				 _SubmitJson({
		        	url:"${rootPath}/${baseUrl}/del.do",
		        	method:'POST',
		        	data:{ids: pkId},
		        	 success: function(text) {
		                grid.load();
		            }
		         });
    		}
    	});
       
    }
    //删除多条记录
    function remove() {
    
    	if(isExitsFunction('_remove')){
    		_remove();
    		return;
    	}
    	
        var rows = grid.getSelecteds();
        if (rows.length <= 0) {
        	alert("请选中一条记录");
        	return;
        }
        //行允许删除
        if(rowRemoveAllow && !rowRemoveAllow()){
        	return;
        }
                 
        mini.confirm("确定删除选中记录？","提示",function(action){
    		if(action!='ok'){
    			return;
    		}else{
				var ids = [];
				for (var i = 0, l = rows.length; i < l; i++) {
				    var r = rows[i];
				    ids.push(r.pkId);
				}
				 _SubmitJson({
		        	url:"${rootPath}/${baseUrl}/del.do",
		        	method:'POST',
		        	data:{ids: ids.join(',')},
		        	 success: function(text) {
		                grid.load();
		            }
		         });
    		}
    	});       
    }

    //获取查询条件
    function getSearList(btn){
        var params =[];
        var parent=$(btn.el).closest(".mini-toolbar");
        var inputAry=$("input",parent);
        inputAry.each(function(i){
            var el=$(this);
            var obj={};
            obj.name=el.attr("name");
            if(!obj.name) return true;
            obj.value=el.val();
            if(obj.value){
                params.push(obj);
            }
        });
        return params;
    }

    //获取导出的列
    function getColumnList(){
        var columns = grid.getColumns();
        var valCols = [];
        for (var i = 0; i < columns.length; i++) {
            var col = columns[i];
            if (col.type == 'checkcolumn' || col.name == 'action') {
                continue;
            }
            valCols.push(col);
        }
        return valCols;
    }

    //导出当前页
    function exportCurPage(btn) {
	    if(!grid.totalCount || grid.totalCount.length==0){
            top._ShowTips({
                msg:"当前查询无数据！"
            });
	        return;
        }
		var url=constructUrlParams(grid.getUrl(),{_export:true});
        var params = getSearList(btn);
        var valCols = getColumnList();

        jQuery.download(url, {
            pageIndex: grid.getPageIndex(),
            pageSize: grid.getPageSize(),
            columns: encodeURI(mini.encode(valCols)),
            params:encodeURI(mini.encode(params))}, 'post');
    }
    //导出所有页
    function exportAllPage(btn) {
        if(!grid.totalCount || grid.totalCount.length==0){
            top._ShowTips({
                msg:"当前查询无数据"
            });
            return;
        }
        var url=constructUrlParams(grid.getUrl(),{_export:true,_all:true});
        var params = getSearList(btn);
        var valCols = getColumnList();

        jQuery.download(url, {
            pageIndex: grid.getPageIndex(),
            pageSize: grid.totalCount,
            pageIndex:0,
            columns: encodeURI(mini.encode(valCols)),
            params:encodeURI(mini.encode(params))}, 'post');
    }
</script>