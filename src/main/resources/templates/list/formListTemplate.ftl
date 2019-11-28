<div  id="${sysBoList.key}Wrapper" alias="${sysBoList.key}" form="${sysBoList.formAlias}"  class="grid-container" plugins="mini-list" >
 	<div class="form-toolBox">
		<#if (gridMode=="relQuery" || gridMode=="list")>
		<a  class="mini-button"	onclick="RelationGrid.onAdd" >新建</a>
		<a  class="mini-button"	onclick="RelationGrid.onEdit">编辑</a>
		<a  class="mini-button"	onclick="RelationGrid.onDetail">明细</a>
		<a  class="mini-button"	onclick="RelationGrid.onDel">删除</a>
		</#if>
		<#if (gridMode=="relFill")>
		<a  class="mini-button"	onclick="RelationGrid.addRows">添加选中</a>
		</#if>
		<a  class="mini-button"	onclick="RelationGrid.onSearch">搜索</a>
		<a  class="mini-button"	onclick="RelationGrid.onClear">清空</a>
		<div class="form-toolBox" id="searchForm_${sysBoList.key}">
			${searchHtml}
		</div>
     </div>
	<div id="${sysBoList.key}Grid" class="${controlClass} relation-grid" style="width: 100%;"
		allowResize="false"  expandOnLoad="true" height="auto"
		idField="${sysBoList.idField}" multiSelect="true"
		data-options="{alias:'${sysBoList.key}'}"
		sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true">
		${gridColumns}
	</div>
</div>
