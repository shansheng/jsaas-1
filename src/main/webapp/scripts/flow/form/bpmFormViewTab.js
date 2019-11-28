//tab控件
var tabControl;
//存储数据控件。
var formContainer;

//初始化TAB
function initTab(tabTitle,formHtml) {
	if (!tabTitle) tabTitle = "页面1";
	formContainer = new FormContainer();
	var aryTitle = tabTitle.split(formContainer.splitor);
	var aryForm = formHtml.split(formContainer.splitor);
	var aryLen = aryTitle.length;

	//初始化
	formContainer.init(tabTitle, formHtml);

	tabControl = new PageTab("pageTabContainer", aryLen, {
		addCallBack : addCallBack,
		beforeActive : beforeActive,
		activeCallBack : activeCallBack,
		beforeDell : beforeDell,
		delCallBack : delCallBack,
		txtCallBack : txtCallBack
	});
	tabControl.init(aryTitle);
	if (aryLen >= 1) {
		templateView.setContent(aryForm[0]);
	}
}

//添加tab页面
function addCallBack() {
	var curPage = tabControl.getCurrentIndex();
	var str = "新页面";
	var idx = curPage - 1;
	formContainer.insertForm(str, "", idx);
	saveTabChange(idx - 1, idx);
}
//切换tab之前，返回false即中止切换
function beforeActive(prePage) {
	return 1;
}
//点击激活tab时执行。
function activeCallBack(prePage, currentPage) {
	if (prePage == currentPage) return;
	//保存上一个数据。
	saveTabChange(prePage - 1, currentPage - 1);
}
//根据索引设置数据
function setDataByIndex(idx) {
	if (idx == undefined) return;
	var obj = formContainer.getForm(idx);
	templateView.setContent(obj.form || "<p/>");
	$("b", tabControl.currentTab).text(obj.title);
}
//在删除页面之前的事件，返回false即中止删除操作
function beforeDell(curPage) {
	return 1;
}

//点击删除时回调执行。
function delCallBack(curPage) {
	formContainer.removeForm(curPage - 1);
	var tabPage = tabControl.getCurrentIndex();
	setDataByIndex(tabPage - 1);
}
//文本返回
function txtCallBack() {
	var curPage = tabControl.getCurrentIndex();
	var idx = curPage - 1;
	var title = tabControl.currentTab.text();
	//设置标题
	formContainer.setFormTitle(title, idx);
}
//tab切换时保存数据
function saveTabChange(index, curIndex) {
	var data = templateView.getContent();
	formContainer.setFormHtml(data, index);
	setDataByIndex(curIndex);
}
//表单或者标题发生变化是保存数据。
function saveChange() {
	var index = tabControl.getCurrentIndex() - 1;
	var title = tabControl.currentTab.text();
	var data = templateView.getContent();
	formContainer.setForm(title, data, index);
}