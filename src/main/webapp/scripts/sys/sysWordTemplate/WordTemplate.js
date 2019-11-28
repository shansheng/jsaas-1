var controlObj;


function replaceTemplate(data){
	
	//填充主表
	initMainTable(data.main);
	//填充一对一的子表。
	initSubOneToOne(data.sub);
	//填充一对多的子表
	fillSubtables(data.sub)
}

/**
 * 填充主表数据
 * @param main
 */
function initMainTable(mainData){
	controlObj = OfficeControls.getControl("office").getCtl();
	var bookMarks = controlObj.ActiveDocument.BookMarks;
	var bookMarkCount = bookMarks.Count;

	
	for (var i = 1; i < bookMarkCount; i++) {
		try {
			var item = bookMarks.Item(i);
			var name = item.Name;
			
			if(name.startWith("main_1_")){
				
				var field = name.split('_1_')[1];
				
				var nameValue = mainData[field];
				if(nameValue==undefined || nameValue==null) continue;
				var currentRange = item.Range;
				currentRange.Text = nameValue ? nameValue : '';
				i--;// 因替换了一个书签，所以需要减一，否则bookMarks.Item(i)会取不到后面的书签
			}
		} catch (e) { }
	}
}

/**
 * 填充一对一的数据。
 * @param sub
 * @returns
 */
function initSubOneToOne(sub){
	controlObj = OfficeControls.getControl("office").getCtl();
	var bookMarks = controlObj.ActiveDocument.BookMarks;
	var bookMarkCount = bookMarks.Count;
	
	for (var i = 1; i < bookMarkCount; i++) {
		try {
			var item = bookMarks.Item(i);
			var name = item.Name;
			if(name.startWith("oo_1_")){
				var aryName = name.split('_1_');
				var tableName=aryName[1];
				var field=aryName[2];
				var row=sub[tableName];
				var nameValue = row[field];
				if(nameValue==undefined || nameValue==null) continue;
				var currentRange = item.Range;
				currentRange.Text = nameValue ? nameValue : '';
				i--;// 因替换了一个书签，所以需要减一，否则bookMarks.Item(i)会取不到后面的书签
			}
		} catch (e) { }
	}
}

/**
 * 填充子表。
 * @param subTables {table1:[], table2:[],}
 * 
 */
function fillSubtables(subTables){
	var tableMetaData = getMetaData(); 
	var tables = controlObj.ActiveDocument.Tables; //得到tables
	for(var tableName in tableMetaData){
		var tableMeta=tableMetaData[tableName]; 
		var idx = tableMeta.tableIndex; 
		var currentTable = tables.Item(idx); 
		var rows = subTables[tableName];
		//添加序号
		addRownumber(rows); 
		//遍历加载每一个子表的数据。
		fillTable(currentTable, rows, tableMeta);
	}
}

/**
 * 列添加序列号
 * @param rows
 */
function addRownumber(rows){
	if(!rows) return;
	for (var i = 0; i < rows.length; i++) {
		rows[i].rn=i+1;
	}
}

/**
 * 填充子表
 * @param currentTable		office表格
 * @param rows				子表对应的行数据
 * @param tableMeta			表格的元数据
 */
function fillTable(currentTable, rows, tableMeta) {
	var tbColMap = tableMeta.tbColMap;
	var rowCount = currentTable.rows.Count;
	var colCount = currentTable.columns.Count;
	//数据为空的情况
	if (rows.length == 0) {
		currentTable.rows(rowCount).Delete();
	}
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		//按照列填充。
		for (var col = 1; col <= colCount; col++) {
			var field=tbColMap["col" + col];
			var cell = currentTable.Cell(rowCount, col);
			cell.Range.Text=row[field];
		}
		//遍历到最后一行 不加数据。
		if (i < rows.length - 1) {
			currentTable.rows.add();
			rowCount++;
		}
	}
}


/**
读取表的元数据。
*{
*	//表名称
*	tableName1:
*	{
*		//对应表格的序号
*		tableIndex:1,
*		//列映射
*		tbColMap:{col1:field1,col2:field2}
*	}
*}
*/
function getMetaData(){
	var metaData = {};
	
	var tables = controlObj.ActiveDocument.Tables; //得到tables
	var tableCount = tables.Count; //得到table的数量
	
	if (tableCount == 0) return aryTableMeta;
	for (var i = 1; i <= tableCount; i++) {
		var currentTable = tables.Item(i);
		// 表格列数
		var columnCount = currentTable.Columns.Count;
		var rowCount = currentTable.rows.Count;
		
		var rtn = getSubTable(currentTable);
		
		if (!rtn.flag) continue;
		
		var tableMeta = {};
		var tableName=rtn.table;
		//表元数据索引
		tableMeta.tableIndex = i;
		var aryRowMeta = {};
		//列元数据读取
		for (var c = 1; c <= columnCount; c++) {
			var cell = currentTable.Cell(rowCount, c);
			var val = cell.Range.Text;
			aryRowMeta["col" + c]=val.split("#")[2];
		}
		tableMeta.tbColMap = aryRowMeta;
		metaData[tableName]=tableMeta;
	}
	return metaData;
}

/**
 * 判断最后一行的第一个单元格内容是是否使用 om# 开头。
 * "om#" + tableName+'#'+field +"#" + i
 * @param currentTable
 * @returns {Boolean}
 */
function getSubTable (currentTable) {
	var rtn={flag:false};
	// 表格列数
	var rowCount = currentTable.rows.Count;
	var cell = currentTable.Cell(rowCount, 1);
	var val = cell.Range.Text;
	var flag = val.startWith("om#");
	if(!flag) return rtn;
	
	rtn.flag=true;
	var aryTmp=val.split("#");
	rtn.table=aryTmp[1];
	return rtn;
}

function printWord(){
	var oldOption;	
	try {
		var objOptions =  controlObj.ActiveDocument.Application.Options;
		oldOption = objOptions.PrintBackground;
		objOptions.PrintBackground = false;
	} catch(err){};
	
	controlObj.printout(true);
	try {
		var objOptions =  controlObj.ActiveDocument.Application.Options;
		objOptions.PrintBackground = oldOption;
	} catch(err) {};	
}
	