<%
	//栏目选择框
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>栏目选择框</title>
	<%@include file="/commons/list.jsp" %>
	<style type="text/css">
		#toolbarBody >*{
			float: left;
		}

		#toolbarBody::after{
			content: '';
			display: block;
			clear: both;
		}

		#center{
			background: transparent;
		}
	</style>


</head>
<body>
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
	<div
			region="south"
			showSplit="false"
			showHeader="false"
			height="46"
			showSplitIcon="false"
			style="width:100%"
			bodyStyle="border:0;text-align:center;padding-top:5px;">
		<div class="southBtn">
        <a class="mini-button"   onclick="onOk()">确定</a>
		<a class="mini-button btn-red" onclick="onCancel()">取消</a>
	    </div>
	</div>

	<div region="center" title="栏目列表"   showHeader="false" showCollapseButton="false" style=" mini-toolbar-bottom">
        <div class="mini-toolbar">
            <div class="searchBox">
                <form id="searchForm" class="search-form">
                    <ul>
                        <li style="margin-left: 6px">
                            <input class="mini-textbox" id="name" name="name" emptyText="栏目名称" onenter="onSearch"/>
                        </li>
                        <li>
                            <input class="mini-textbox"  id="key" name="key" emptyText="请输入栏目关键字" onenter="onSearch"/>
                        </li>
                        <li class="liBtn">
							<a class="mini-button " onclick="onSearch">搜索</a>
							<a class="mini-button  btn-red" onclick="onClear">清空</a>
                        </li>
                    </ul>
                </form>
			</div>
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
		</div>


		<div class="mini-fit rx-grid-fit form-outer4">
			<div
					id="columnDeGrid"
					class="mini-datagrid"
					style="width: 100%; height: 100%;"
					allowResize="false"
					url="${ctxPath}/oa/info/insColumnDef/search.do"
					idField="name"
                    treeColumn="name"
                    allowResize="true"
                    onlyCheckSelection="true"
                    multiSelect="true"
                    allowRowSelect="true"
                    allowUnselect="true"
                    allowAlternating="true"
					showColumnsMenu="true" sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
				<div property="columns">
					<div type="checkcolumn" width="40"></div>
					<div field="name" name="name" displayfield="name" width="180" headerAlign="center" allowSort="true">
						名称
					</div>
                    <div field="key" name="key" displayfield="key" width="180" headerAlign="center" allowSort="true">
                        栏目关键字
                    </div>
				</div>
			</div>
		</div>
	</div>

</div>


<script type="text/javascript">
	mini.parse();

	var columnDeGrid=mini.get("#columnDeGrid");
	columnDeGrid.load();


    //搜索
    function onSearch(){
        var formData=$("#searchForm").serializeArray();
        var data=jQuery.param(formData);
        columnDeGrid.setUrl("${ctxPath}/oa/info/insColumnDef/search.do?"+data);
        columnDeGrid.load();
    }

    function onClear(){
        $("#searchForm")[0].reset();
        columnDeGrid.setUrl("${ctxPath}/oa/info/insColumnDef/search.do?");
        columnDeGrid.load();
    }

	function onCancel(){
		CloseWindow('cancel');
	}

	function onOk(){
		CloseWindow('ok');
	}

    //返回选择用户信息
    function getColumnDeGrids(){
        return columnDeGrid.getSelecteds();
    }
</script>
</body>
</html>