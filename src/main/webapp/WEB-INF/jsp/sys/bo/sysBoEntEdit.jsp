
<%-- 
    Document   : [业务实体对象]编辑页
    Created on : 2018-05-01 14:21:00
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[业务实体对象]编辑</title>
<%@include file="/commons/edit.jsp"%>
<script type="text/javascript" src="${ctxPath}/scripts/common/vue.min.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/common/lodash.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/sys/bo/BoEdit.js?version=${static_res_version}"></script>
<style type="text/css">
	.checkbox-list li{
		display: inline-block;
	}

	.ul_list li{
		height: 25px;
		line-height: 25px;
	}
	.sysBoMode{
		display:inline-block;
	}

</style>
</head>
<body>
	<div class="topToolBar" >
		<div>
			<c:if test="${showFormDb && entGenMode ne 'db'}" >
				<span class="sysBoMode">
					生成业务模型
					<input name="createModer" id ="createModer" class="mini-checkbox" value="false" trueValue="on"
								   falseValue="off" onValuechanged="isCreateModer()"/>
				</span>			
			</c:if>
			<a class="mini-button"  plain="true" onclick="saveBoEnt">保存</a>
			<c:if test="${showFormDb}" >
				<a class="mini-button"   plain="true" onclick="getFromDb">从数据库表映射</a>
			</c:if>
		</div>
	</div>
	<div class="mini-fit"  id="formDiv">
		<div class="form-toolBox">
			<input id="delFromEnt" name="delFromEnt" class="mini-hidden" value="1"/>
			<table  cellspacing="0" cellpadding="0" style="width:100%" class="table-detail" >
				<tr>
					<td >分类：</td>
					<td>
						<input name="categoryId"
							   class="mini-treeselect"
							   url="${ctxPath}/sys/core/sysTree/listAllByCatKey.do?catKey=CAT_FORM_VIEW"
							   textField="name"
							   required="true" idField="treeId"
							   resultAsTree="false"
							   parentField="parentId" value="${categoryId}"
							   style="width: 100%"
						/>
					</td>
					<td>名称：</td>
					<td>
						<input id="comment" name="comment"
							   class="mini-textbox"  required="true" onblur="getPinyin" style="width: 100%" />
					</td>
					<td>标识：</td>
					<td >
						<input id="txtName" name="name"  class="mini-textbox"  required="true" style="width: 100%" />
					</td>
					<c:if test="${showFormDb}" >
						<td style="display: none">是否生成模型：</td>
						<td style="display: none">
							<input id="isCreateMode" name="isCreateMode"  class="mini-textbox"  required="true" />
						</td>
					</c:if>
					<td id="thGenTable">生成物理表：</td>
					<td id="tdGenTable">
						<input id="txtId" name="id"  class="mini-hidden"  value="${pkId}" />
						<input id="genTable" name="genTable"  class="mini-checkbox"  trueValue="yes" falseValue="no" />
						<input id="isMain" name="isMain"  class="mini-hidden" />
					</td>
					<td width="30%" id="tdFromDb" style="display:none;">
						<input id="genMode" name="genMode" class="mini-hidden" value="create"/>
						主键：
						<input id="pkField" name="pkField" class="mini-combobox"  textField="comment" valueField="name"  showNullItem="true" allowInput="true" style="width: 31%"/>
						父ID： <input id="parentField" name="parentField" class="mini-combobox"  textField="comment" valueField="name" showNullItem="true" allowInput="true" style="width: 34%"/>
						<input id="tableName" name="tableName" class="mini-hidden"  value=""  />

					</td>
				</tr>
			</table>
		</div>
		<div class="mini-fit">
			<div id="layout1" class="mini-layout" width="100%" height="100%">
			    <div title="业务属性" region="east" width="400" showCloseButton="false" showSplitIcon="false" showSplit="false">
			    	<div  class="form-toolBox" >
						<a class="mini-button"  plain="true" onclick="saveAttr">保存</a>
					</div>
			        <table id="attrForm" class="table-detail column-two" cellspacing="1" cellpadding="0">
			        	<tr v-if="errMsg.lengtd>0">
							<td colspan="2">
								<div v-html="errMsg" class="errMsg"></div>
							</td>
						</tr>
			        	<tr>
							<td>备注：</td>
							<td>
									<input name="comment"   v-model="attr.comment" style="width:80%;height: 28px;border: 0;border: 1px solid #ddd;" />
							</td>
						</tr>
						<tr>
							<td>字段名：</td>
							<td>
								<input name="name" v-model="attr.name" v-if="isMainBoEnt==1 && genMode!='db'" style="width:80%;height: 28px;border: 0;border: 1px solid #ddd;"/>
								<div v-if="isMainBoEnt==0 ||  genMode=='db'" v-html="attr.name"></div>
							</td>
						</tr>
						
						<tr>
							<td>控件类型：</td>
							<td>
								<select v-model="attr.control"  v-if="isMainBoEnt==1 && attr.control!='mini-ref'" @change="changeControl" >
									<option   value="" >请选择控件类型</option>
									<option  v-for="obj  in controls" :value="obj.val" >{{obj.name}}</option>
								</select>
								
								<div v-if="attr.control=='mini-commonfield'">
									映射字段:<select v-model="attr.extJson.refField"  >
										<option   value="" >==选择==</option>
										<template v-for="item in commonFields">
										    <option  :value="item.id" >{{item.text}}</option>
										</template>
									</select>
								</div>
								
								<div v-if="isComplex()">
									关联字段:
									<select v-model="attr.extJson.refField"  @change="changeRelField">
										<option   value="" >==选择==</option>
										<template v-for="item in fileds">
										    <option v-if="item.name!=attr.name" :value="item.name" >{{item.comment}}</option>
										</template>
									</select>
								</div>
								<div v-if="isMainBoEnt==0 ||  attr.control=='mini-ref'" v-html="displayColName()"></div>
							</td>
						</tr>
						<tr v-if="showRequire">
							<td>必填：</td>
							<td>
								<input type="checkbox"   v-model="attr.extJson.required"  />
							</td>
						</tr>
						
						<tr v-if="showDataType">
							<td>字段类型：</td>
							<td>
								<select v-model="attr.dataType"  v-if="isMainBoEnt==1 && genMode!='db'" @change="changeDataType" >
									<option  v-for="obj  in dataTypes" :value="obj.val" >{{obj.name}}</option>
								</select>
								
								<div v-if="isMainBoEnt==0 || genMode=='db'" v-html="displayDataType()"></div>
							</td>
						</tr>
						
						<tr v-if="showLength">
							<td>属性长度：</td>
							<td>
								<input    v-model="attr.length" style="width:40px;border: 0;border:1px solid #ddd;height: 26px;border-radius: 3px"  v-if="isMainBoEnt==1 && genMode!='db'" />
								<span v-if="attr.dataType=='number'"  v-if="isMainBoEnt==1 && genMode!='db'" >
									精度:<input    v-model="attr.decimalLength"  style="width:20px"/>
								</span>
								<span v-if="isMainBoEnt==0 || genMode=='db'" v-html="attr.length"></span>
								<span v-if="attr.dataType=='number' && (isMainBoEnt==0  ||  genMode=='db')">
									精度:<span  v-html="attr.decimalLength"></span>
								</span>
							</td>
						</tr>
						
						<tr  v-if="attr.control=='mini-textbox'">
							<td colspan="2">
								<table class="table-detail column-two">
									<tr>
										<td>允许输入</td>
										<td style="text-align: left">
											<input type="checkbox"  v-model="attr.extJson.allowinput" />
										</td>
									</tr>
									<tr v-if="attr.dataType=='varchar'">
										<td>替换规则</td>
										<td style="text-align: left">
											<input type="text" readonly v-model="attr.extJson.rtypeName"  style="height: 28px;border: 0;border: 1px solid #ddd;vertical-align: middle;width: 150px;" />
										<%--	<input type="button" value="选择" @click="selReg">--%>
											<span style="display: inline-block;
													vertical-align: middle;
													padding: 4px 6px;
													background: #66b1ff;
													-webkit-border-radius: 3px;
													-moz-border-radius: 3px;
													border-radius: 3px;
													color: #fff;cursor:pointer;"
												  @click="selReg">选择</span>
										</td>
									</tr>
									<tr>
										<td>格式</td>
										<td style="text-align: left">
											<input type="text"  v-model="attr.extJson.format"  style="height: 28px;border: 0;border: 1px solid #ddd;width: 150px;"/>
										</td>
									</tr>
									<tr v-if="attr.dataType=='varchar'">
										<td>值来源</td>
										<td style="text-align: left">
											<select v-model="attr.extJson.from" style="width: 152px">
													<option  v-for="obj  in fromAry" :value="obj.id" >{{obj.text}}</option>
											</select>
										</td>
									</tr>
									
									<tr v-if="attr.dataType=='varchar' && attr.extJson.from=='sequence'">
										<td>流水号</td>
										<td>
											<select v-model="attr.extJson.sequence">
												<option  v-for="obj in seqAry" :value="obj.seqId" >{{obj.name}}</option>
											</select>
										</td>
									</tr>
									<tr v-if="attr.dataType=='varchar' && attr.extJson.from=='scripts'">
										<td>脚本</td>
										<td>
											<textarea rows="5" cols="30" v-model="attr.extJson.script"></textarea>
										</td>
									</tr>
									
								
								</table>
							</td>
						</tr>
						
						<tr  v-if="attr.control=='mini-textarea'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>允许输入</td>
										<td style="text-align: left">
											<input type="checkbox"  v-model="attr.extJson.allowinput"  />
										</td>
									</tr>
									<tr>
										<td>最小长度</td>
										<td style="text-align: left">
											<input type="text"  v-model="attr.extJson.minlen"  style="height: 28px;border: 0;border: 1px solid #ddd;" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-checkbox'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>显示的值</td>
										<td>
											<table>
												<tr>
													<td>选中:</td>
													<td><input type="text" v-model="attr.extJson.truevalue" class="txtLen_80"/></td>
												</tr>
												<tr>
													<td>不选中:</td>
													<td><input type="text" v-model="attr.extJson.falsevalue" class="txtLen_80"/></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>默认选中</td>
										<td style="text-align: left">
											<input type="checkbox" v-model="attr.extJson.checked" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-radiobuttonlist' || attr.control=='mini-checkboxlist' || attr.control=='mini-combobox'" >
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>配置：</td>
										<td style="text-align: left">
											<input type="radio" name="from" value="self" v-model="attr.extJson.from" id="rdo-from-1" style="vertical-align: middle"><label for="rdo-from-1" style="vertical-align: middle">自定义</label>
											<input type="radio" name="from" value="url" v-model="attr.extJson.from" id="rdo-from-2" style="vertical-align: middle"><label for="rdo-from-2" style="vertical-align: middle">URL</label>
											<input type="radio" name="from" value="dic" v-model="attr.extJson.from" id="rdo-from-3" style="vertical-align: middle"><label for="rdo-from-3" style="vertical-align: middle">数据字典</label>
											<input type="radio" name="from" value="sql" v-model="attr.extJson.from" id="rdo-from-4" style="vertical-align: middle"><label for="rdo-from-4" style="vertical-align: middle">自定义SQL</label>
										</td>
									</tr>
									<tr v-if="attr.extJson.from=='self'">
										<td>自定义配置</td>
										<td>
											<table v-if="attr.extJson.from=='self'" class="table-view">
												<tr>
													<td colspan="3">
														<input type="button" value="添加" @click="addRow"> 
														<input type="button" value="删除" @click="delRow">
													</td>
												</tr>
												<tr>
													<td><input type="checkbox" @click="chkAll"/></td>
													<td>标识键</td>
													<td>名称</td>
												</tr>
												<tr v-for="obj  in attr.extJson.data">
													<td><input type="checkbox" v-model="obj.select" ></td>
													<td><input type="text" v-model="obj.key" style="width:100px"></td>
													<td><input type="text" v-model="obj.name" style="width:100px"></td>
												</tr>
											</table>
										</td>
									</tr>
									
									<tr v-if="attr.extJson.from=='url'">
										<td>URL配置</td>
										<td>
											<table class="table-detail">
												<tr>
													<td>URL:</td>
													<td>
														<input type="text" v-model="attr.extJson.url" class="txtLen_150"/> 
													</td>
												</tr>
												<tr>
													<td>文本字段:</td>
													<td><input type="text" v-model="attr.extJson.textfield" class="txtLen_80"/></td>
												</tr>
												<tr>
													<td>数值字段:</td>
													<td><input type="text" v-model="attr.extJson.valuefield"  class="txtLen_80"/></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr v-if="attr.extJson.from=='dic'">
										<td>数据字典:</td>
										<td>
											<input type="text" v-model="attr.extJson.dicName"/>
											<input type="button" value="选择" @click="selDictionary">
										</td>
									</tr>
									<tr v-if="attr.extJson.from=='sql'">
										<td>SQL配置:</td>
										<td>
											<table class="table-detail">
												<tr>
													<td>父控件:</td>
													<td>
														<input type="text" class="txtLen_80" v-model="attr.extJson.sqlParent" />
													</td>
												</tr>
												<tr>
													<td>自定义SQL:</td>
													<td>
														<span v-html="attr.extJson.sqlName"></span>
														<input type="button" value="选择" @click="selCustomSql">
													</td>
												</tr>
												<tr>
													<td>文本字段:</td>
													<td>
														<select v-model="attr.extJson.textfield">
															<option  v-for="obj  in sqlResultFieldAry" :value="obj.fieldName" >{{obj.comment}}</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>数值字段:</td>
													<td>
														<select v-model="attr.extJson.valuefield">
																<option  v-for="obj  in sqlResultFieldAry" :value="obj.fieldName" >{{obj.comment}}</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>输入参数:</td>
													<td>
														<select v-model="attr.extJson.sqlParam">
															<option value="" >请选择</option>
															<option  v-for="obj  in sqlParamsAry" :value="obj.fieldName" >{{obj.comment}}</option>
														</select>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>默认值:</td>
										<td style="text-align: left">
											<input type="text" class="txtLen_80"  v-model="attr.extJson.defaultvalue" style="height: 28px;border: 0;border: 1px solid #ddd;"/>
										</td>
									</tr>	
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.dataType=='date'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>控件显示</td>
										<td style="text-align: left">
											<input type="checkbox" v-model="attr.extJson.showtime">显示时间
											<input type="checkbox" v-model="attr.extJson.showokbutton">确认按钮
											<input type="checkbox" v-model="attr.extJson.showclearbutton">显示清除按钮
											<div>
												<input type="checkbox" v-model="attr.extJson.allowinput">允许输入
												<input type="checkbox" v-model="attr.extJson.initcurtime">初始时间
											</div>
										</td>
									</tr>
									<tr>
										<td>格式:</td>
										<td style="text-align: left">
											<select v-model="attr.extJson.format">
												<option value="">请选择</option>
												<option value="yyyy-MM-dd">yyyy-MM-dd</option>
												<option value="yyyy-MM-dd HH:mm">yyyy-MM-dd HH:mm</option>
												<option value="yyyy-MM-dd HH:mm:ss">yyyy-MM-dd HH:mm:ss</option>
											</select>	
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.dataType=='mini-month'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>允许输入：</td>
										<td><input type="checkbox" v-model="attr.extJson.allowinput"></td>
									</tr>
									<tr>
										<td>初始时间：</td>
										<td><input type="checkbox" v-model="attr.extJson.initcurtime"></td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-time'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>允许输入：</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.allowinput"></td>
									</tr>
									<tr>
										<td>初始时间：</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.initcurtime"></td>
									</tr>
									<tr>
										<td>格式:</td>
										<td style="text-align: left">
											<select v-model="attr.extJson.format">
												<option value="">请选择</option>
												<option value="HH:mm">HH:mm</option>
												<option value="HH:mm:ss">HH:mm:ss</option>
											</select>	
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-spinner'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>配置</td>
										<td  style="text-align: left">
											<ul class="ul_list">
												<li>最小值：<input type="text" class="txtLen_80" v-model="attr.extJson.minvalue"></li>
												<li>最大值：<input type="text" class="txtLen_80" v-model="attr.extJson.maxvalue"></li>
												<li>增量值：<input type="text" class="txtLen_80" v-model="attr.extJson.increment"></li>
											</ul>
										</td>
									</tr>
									<tr>
										<td>允许输入</td>
										<td  style="text-align: left"><input type="checkbox" v-model="attr.extJson.allowinput"></td>
									</tr>
									<tr>
										<td>格式:</td>
										<td  style="text-align: left"><input type="checkbox" v-model="attr.extJson.format"></td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-user'">
							<td colspan="2">
								<table class="table-detail column-two">
									<tr>
										<td>单选</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.single"></td>
									</tr>
									<tr>
										<td>初始登陆用户</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.initloginuser"></td>
									</tr>
									
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-group'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>单选</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.single"></td>
									</tr>
									<tr>
										<td>初始用户组</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.initlogingroup"></td>
									</tr>
									<tr>
										<td>显示所有维度</td>
										<td style="text-align: left">
											<input type="checkbox" v-model="attr.extJson.showdim" @click="getDims()">
											
											<select v-model="attr.extJson.dimid" v-if="!attr.extJson.showdim">
												<option  v-for="obj  in dimAry" :value="obj.dimId" >{{obj.name}}</option>
											</select>
										</td>
									</tr>
									<tr>
										<td>显示级别:</td>
										<td style="text-align: left">
											<select v-model="attr.extJson.level" >
												<option  value="" >选择</option>
												<option  v-for="obj  in rankTypeAry" :value="obj.level" >{{obj.name}}</option>
											</select>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='upload-panel'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>单一文件</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.single"></td>
									</tr>
									<tr>
										<td>上传大小</td>
										<td style="text-align: left"><input type="text" v-model="attr.extJson.sizelimit">mb</td>
									</tr>
									<tr>
										<td>文件类型:</td>
										<td style="text-align: left"><checkbox-list	ref="chkFileType" :items="fileTypes" v-model="attr.extJson.filetype"></checkbox-list></td>
									</tr>
								</table>
							</td>
						</tr>
							
						<tr v-if="attr.control=='mini-dep'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>单选</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.single"></td>
									</tr>
									<tr>
										<td>初始显示部门</td>
										<td style="text-align: left"><input type="checkbox" v-model="attr.extJson.initlogindep"></td>
									</tr>
									<tr>
										<td>部门级别：</td>
										<td style="text-align: left">
											<select v-model="attr.extJson.level" >
												<option  value="" >选择</option>
												<option  v-for="obj  in rankTypeAry" :value="obj.level" >{{obj.name}}</option>
											</select>
										</td>
									</tr>
									<tr>
										<td>初始部门数据:</td>
										<td style="text-align: left">
											<select v-model="attr.extJson.refconfig" >
												<option  value="" >选择</option>
												<option  v-for="obj  in groupTypes" :value="obj.id" >{{obj.text}}</option>
											</select>
											<div v-if="attr.extJson.refconfig=='specific'">
												<input type="text" v-model="attr.extJson.groupidsText" />
												<input type="button" @click="selDep" value="...">
											</div>
											<div v-if="attr.extJson.refconfig=='level'">
												<select v-model="attr.extJson.level" >
													<option  value="" >选择</option>
													<option  v-for="obj  in rankTypeAry" :value="obj.level" >{{obj.name}}</option>
												</select>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-office'">
							<td>版本：</td>
							<td>
								<input type="checkbox" v-model="attr.extJson.version" />
							</td>
						</tr>
						
						<tr v-if="attr.control=='mini-treeselect'">
							<td colspan="2">
								<table class="table-detail">
									<tr>
										<td>值来源</td>
										<td style="text-align: left">
											<input type="radio" name="tree_from" v-model="attr.extJson.from" value="url" id="tree_from_1" /><label for="tree_from_1">URL</label>
											<input type="radio" name="tree_from" v-model="attr.extJson.from" value="customSql" id="tree_from_2"/><label for="tree_from_2">自定义SQL</label>
										</td>
									</tr>
									<tr v-if="attr.extJson.from=='url'">
										<td colspan="2">
											<table class="table-detail">
												<tr><td>JSON URL:</td>
													<td style="text-align: left"><input type="text" v-model="attr.extJson.url" class="txtLen_200"/></td>
												</tr>
												<tr><td>文本字段:</td><td ><input type="text" v-model="attr.extJson.textfield" class="txtLen_80"/></td></tr>
												<tr><td>值字段:</td><td ><input type="text" v-model="attr.extJson.valuefield" class="txtLen_80"/></td></tr>
												<tr><td>父节点字段:</td><td><input type="text" v-model="attr.extJson.parentfield" class="txtLen_80"/></td></tr>
											</table>
										</td>
									</tr>
									<tr v-if="attr.extJson.from=='customSql'">
										<td colspan="2">
											<table class="table-detail">
												<tr><td>自定义SQL</td>
													<td style="text-align: left">
														<span>{{attr.extJson.customSqlName}}</span>
														<input type="button" value="选择" @click="selQuerySql">
													</td>
												</tr>
												<tr>
													<td>文本字段</td>
													<td style="text-align: left">
														<select v-model="attr.extJson.textfield">
															<option  v-for="obj  in sqlResultFieldAry" :value="obj.fieldName" >{{obj.comment}}</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>值字段</td>
													<td style="text-align: left">
														<select v-model="attr.extJson.valuefield">
															<option  v-for="obj  in sqlResultFieldAry" :value="obj.fieldName" >{{obj.comment}}</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>父节点字段</td>
													<td style="text-align: left">
														<select v-model="attr.extJson.parentfield">
															<option  v-for="obj  in sqlResultFieldAry" :value="obj.fieldName" >{{obj.comment}}</option>
														</select>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>树配置</td>
										<td style="text-align: left">
											<input type="checkbox"  v-model="attr.extJson.checkrecursive"/>级联选择
											<input type="checkbox" v-model="attr.extJson.showfoldercheckbox"/>可以选择父节点
											<input type="checkbox" v-model="attr.extJson.autocheckparent"/>自动选择父节点
											<input type="checkbox" v-model="attr.extJson.expand"/>展开树
											<div v-if="attr.extJson.expand">
												<input type="radio" name="imgtype" v-model="attr.extJson.expandType" value="all" />展开所有
												<input type="radio" name="imgtype" v-model="attr.extJson.expandType" value="custom" />自定义
												<span v-if="attr.extJson.expandType=='custom'">
													<input type="text"  v-model="attr.extJson.layer" >(注：0展开第一级节点，以此类推。) 
												</span>
											</div>
											
											<input type="checkbox" v-model="attr.extJson.multiselect"  />多选
										</td>
									</tr>
								</table>
							</td>
						</tr>
					
						<tr v-if="attr.control=='mini-textboxlist'">
							<td colspan="2">
								<table class="table-detail column-two">
									<tr>
										<td>是否允许输入</td>
										<td style="text-align: left"><input type="checkbox"  v-model="attr.extJson.allowinput"/></td>
									</tr>
									<tr>
										<td>默认值</td>
										<td>
											<table class="table-view">
												<tr>
													<td colspan="3" style="text-align: left">
														<input type="button" value="添加" @click="addRow"> 
														<input type="button" value="删除" @click="delRow">
													</td>
												</tr>
												<tr>
													<td><input type="checkbox" @click="chkAll"/></td>
													<td>标识键</td>
													<td>名称</td>
												</tr>
												<tr v-for="obj  in attr.extJson.data">
													<td><input type="checkbox" v-model="obj.select" ></td>
													<td><input type="text" v-model="obj.key" style="width:100px"></td>
													<td><input type="text" v-model="obj.name" style="width:100px"></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>是否使用URL</td>
										<td style="text-align: left"><input type="checkbox"  v-model="attr.extJson.isurl"/></td>
									</tr>
									<tr v-if="attr.extJson.isurl">
										<td colspan="2">
											<table class="table-detail">
												<tr><td>JSON URL:</td>
													<td><input type="text" v-model="attr.extJson.url" class="txtLen_200"/></td>
												</tr>
												<tr><td>文本字段:</td><td><input type="text" v-model="attr.extJson.textfield" class="txtLen_80"/></td></tr>
												<tr><td>值字段:</td><td><input type="text" v-model="attr.extJson.valuefield" class="txtLen_80"/></td></tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						
						<tr v-if="attr.control=='mini-img'">
							<td>设置：</td>
							<td>
								<input type="radio" name="imgtype" v-model="attr.extJson.imgtype" value="upload" id="imgtype_1" /><label for="imgtype_1">上传</label> 
								<input type="radio" name="imgtype" v-model="attr.extJson.imgtype" value="url" id="imgtype_2" /><label for="imgtype_2">URL</label>
							</td>
						</tr>
					</table>

			    </div>
			    <div title="center" region="center" showHeader="false" >
					<div class="form-toolBox">
						<a class="mini-button btn-red" id="btnDel"  plain="true" onclick="onDel">删除</a>
					</div>
					<div class="mini-fit">
				        <div id="gridColumns" class="mini-datagrid"
							 style="width:100%;height:100%;"
							 allowAlternating="true"
							 allowResize="false"
							 allowSortColumn="false"
							 showColumnsMenu="true"
							 showPager="false"
							 onselect="rowClick"
							 multiSelect="true"
						>
						    <div property="columns">
						        <div type="indexcolumn"></div>
						        <div type="checkcolumn" width="40">操作</div>
						        <div field="name" width="120"  allowSort="true">属性名</div>
						        <div field="comment" width="120"  allowSort="true">备注</div>
						        <div renderer="renderDataType" width="120"  allowSort="true">数据类型</div>
						        <div field="control" width="120"  allowSort="true" renderer="renderControlType">控件类型</div>
						    </div>
						</div>
					</div>
			    </div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		var entId="${pkId}";
		
		mini.parse();
		var vm=init();
		var grid=mini.get("gridColumns");
		//加载数据
		initEnt(entId);

		var isCreateMode = mini.get("isCreateMode");
		if(isCreateMode){
			isCreateMode.setValue("no");
		}
		function isCreateModer(){
			var createModer = mini.get("createModer");
			isCreateMode.setValue(createModer.checked==true?"create":"no");
		}
		$(function () {
			$(window).resize(function(){
				mini.layout();
			})
		})
		
	</script>
</body>
</html>