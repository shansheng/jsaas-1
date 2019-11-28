		<ul id="popupAddMenu" class="mini-menu" style="display:none;">
		 	<#if add=="true">
            <li  onclick="add()">新建</li>
            </#if>
            <#if copyAdd=="true">
            <li  onclick="copyAdd()">复制新建</li>
            </#if>
        </ul>
        <ul id="popupExportMenu1" class="mini-menu" style="display:none;">
			<li  onclick="doExport(false)">导出选中</li>
			<li  onclick="doExport(true)">导出全部</li>
		</ul>
        <ul id="popupSettingMenu" class="mini-menu" style="display:none;">
            <li>
                <span iconCls="icon-download">导出</span>
                <ul id="popupExportMenu" class="mini-menu">
                	<#if exportCurPage=="true">
                    <li  onclick="exportCurPage()">导出当前页</li>
                    </#if>
                    <#if exportAllPage=="true">
                    <li  onclick="exportAllPage()">导出所有页</li>
                    </#if>
                </ul>
            </li>
        </ul>
                </ul>
        <ul id="popupSettingMenu" class="mini-menu" style="display:none;">
            <li>
                <span iconCls="icon-download">导出</span>
                <ul id="popupExportMenu" class="mini-menu">
                	<#if exportCurPage=="true">
                    <li  onclick="exportCurPage()">导出当前页</li>
                    </#if>
                    <#if exportAllPage=="true">
                    <li onclick="exportAllPage()">导出所有页</li>
                    </#if>
                </ul>
            </li>
        </ul>
        <div class="mini-toolbar">
			 <#if fieldSearch=="true">
				<div class="searchBox">
					<form id="searchForm" class="text-distance">						
						<ul>
							<li>
								<span class="text" title="请选择查询字段" style="max-width:auto;width: auto;margin-left: 10px "> 请选择查询字段：</span>
								<input id="fieldName" class="mini-combobox" textField="title"
									   style="width: 150px"
									   valueField="dbFieldName"
									   parentField="parentId"  onvaluechanged="onSearchFieldChanged" 
									   url="${rootPath}/ui/module/getModuleFields.do?entityName=${entityName}"/>
							</li>
							<li><input id="fieldCompare" class="mini-combobox" textField="fieldOpLabel" valueField="fieldOp"/></li>
							<li id="fieldValContainer">
								<input id="fieldVal" class="mini-textbox mini-buttonedit" emptyText="请输入查询条件值" style="width:150px;" onenter="onKeyEnter"/>					
							</li>
							<#if selfSearch??>
								${selfSearch}
							</#if>
							<li class="liBtn">
								<a class="mini-button"  onclick="search()" >搜索</a>
								<a class="mini-button btn-red"  onclick="clearSearch()" >清空</a>
							</li>
						</ul>
					</form>
				</div>
			</#if>
			<ul class="toolBtnBox">
				<#if popupAddMenu=="true">
					<li>
						<a class="mini-menubutton"  plain="true" menu="#popupAddMenu">新增</a>
					</li>
				</#if>
				<#if edit=="true">
					<li>
						<a class="mini-button"  plain="true" onclick="edit()">编辑</a>
					</li>
				</#if>
				<#if detail=="true">
					<li>
						<a class="mini-button"  plain="true" onclick="detail()">明细</a>
					</li>
				</#if>
				<#if export=="true">
					<li>
						<a class="mini-menubutton"  plain="true" menu="#popupExportMenu1">导出</a>
					</li>
				</#if>
				<#if importData=="true">
					<li>
						<a class="mini-button"  onclick="doImport">导入</a>
					</li>
				</#if>
				<#if remove=="true">
					<li>
						<a class="mini-button btn-red"  plain="true" onclick="remove()">删除</a>
					</li>
				</#if>
				<#if extToolbars??>
					${extToolbars}
				</#if>
			</ul>
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
					<i class="icon-sc-lower"></i>
				</span>
		</div>