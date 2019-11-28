var typeOrder = [ {
	id : 'ASC',
	text : '升序'
}, {
	id : 'DESC',
	text : '降序'
} ];

var valueSource = [ {
	id : "param",
	text : '参数传入'
}, {
	id : "fixedVar",
	text : '固定值'
}, {
	id : "script",
	text : '脚本'
}, {
	id : "constantVar",
	text : '常量'
} ];

/**
 * 在编辑器中插入数据。
 * @param editor
 * @param val
 * @returns
 */
function insertVal(editor, val) {
	var doc = editor.getDoc();
	var cursor = doc.getCursor(); // gets the line number in the cursor position
	doc.replaceRange(val, cursor); // adds a new line
}

/**
 * 获取脚本。
 * @param e
 * @returns
 */
function getScript(e) {
	var buttonEdit = e.sender;
	var row = mini.get("gridWhere").getSelected();
	var scriptContent = typeof (row.valueDef) == 'undefined' ? ""
			: row.valueDef;

	_OpenWindow({
		url : __rootPath + "/sys/db/sysDb/scriptDialog.do",
		title : "脚本内容",
		height : "450",
		width : "600",
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setScript(scriptContent);
		},
		ondestroy : function(action) {
			if (action != 'ok')
				return;
			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.getScriptContent();
			buttonEdit.value = data;
			buttonEdit.text = data;
		}
	});
}

/**
 * 切换构造模式。
 * @param show
 * @returns
 */
function toggleCondtionColumns(show) {
	var grid = mini.get("gridWhere");
	var aryCol = [ "typeOperate", "valueSource", "valueDef" ];
	for (var i = 0; i < aryCol.length; i++) {
		var col = grid.getColumn(aryCol[i]);
		show ? grid.showColumn(col) : grid.hideColumn(col)
	}
}