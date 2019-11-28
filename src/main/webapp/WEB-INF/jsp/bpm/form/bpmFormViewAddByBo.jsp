<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <title>新建手机表单</title>
        <%@include file="/commons/edit.jsp" %>
        <script type="text/javascript" src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/sys/bo/BoUtil.js?version=${static_res_version}"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/flow/form/bpmFormView.js?version=${static_res_version}"></script>
		<style>
			.labelCkeckBox{
				display:inline-block ;
				vertical-align: -3px;
				height: 16px;
				width: 16px;
				background: url("${ctxPath}/scripts/mini/miniui/themes/default/images/icons/checkBoxNew.png") -22px -2px no-repeat;
			}
			input[type="checkbox"]{
				vertical-align: middle;
			}
			input[type="checkbox"]:checked + label {
				background-position: -2px -2px ;
			}
		</style>
    </head>
    <body > 
     <div class="topToolBar">
		<div>
		    <a class="mini-button" onclick="next('pc')">下一步</a>
		</div>
	</div>
	 <div class="mini-fit">
		<div class="form-container">
            <form id="form1" method="post" >
			  <input id="pkId" name="id" class="mini-hidden" value="${bpmMobileForm.id}"/>
              <table class="table-detail column-two" cellspacing="1" cellpadding="0">
                <caption>新建表单</caption>
                <tr>
					<td>
						颜色
			 		</td>
					<td>
						<div class="mini-radiobuttonlist" id="color" name="color"   textField="text" valueField="id" value="transparent" 
							data="[{id:'transparent',text:'透明'},{id:'blue',text:'浅蓝'},{id:'green',text:'淡绿'},{id:'brown',text:'树棕'},{id:'grey',text:'银灰'}]" >
						</div>
						  
					</td>
				</tr>
				<tr id="viewNameTr">
					<td>
						选择业务对象<span class="star">*</span>
			 		</td>
					<td >
						<input id="viewName"  allowInput="false" class="mini-textbox input-60" vtype="maxLength:60" required="true" style="width:60%" />
						<a id="viewNameBtn" class="mini-button" onclick="selectBo('pc')">选择</a>
					</td>
				</tr>
				<tbody id="tbody"></tbody>
			  </table>
            </form>

 </div>
	 </div>
	 <script id="templateList"  type="text/html">
		<# if (list.length>1) {#>
			<tr >
				<td>支持TAB</td>
				<td>
					<input id="genTab" name="genTab" type="checkbox" checked="checked" style="display: none"/><label for="genTab" class="labelCkeckBox" ></label>
				</td>
			</tr>
		<#}#>
		<#for(var i=0;i<list.length;i++){
			var obj=list[i];
			var tempAry=obj.template;
		#>
		<tr >
				<td><#=obj.name#></td>
				<td>
					<select name="template" alias="<#=obj.key#>" type="<#=obj.type#>">
						<#for(var n=0;n<tempAry.length;n++){
							var tmp=tempAry[n];
						#>
							<option value="<#=tmp.alias#>"><#=tmp.name#></option>
						<#}#>
					</select>
					<#if (obj.type!="main") {#>
					<input id="ckeckBox" type="checkbox" checked="checked" style="display: none" /><label for="ckeckBox" class="labelCkeckBox" style="margin-left: 6px"></label>
					<#}#>
				</td>
		</tr>
		<#}#>
		</script>
      	<script type="text/javascript">
      		var grid=null;
			var newBoDefId='${param.boDefId}';
			var editViewId = '${param.editViewId}';
			var editIsAgaion = '${param.editIsAgaion}';

			if(newBoDefId){
				mini.parse();
				initBoAgain(newBoDefId,editViewId,editIsAgaion);
			}
      		function setGrid(obj){
      			grid=obj;
      		}
      	</script>
       
    </body>
</html>