<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title></title>
<%@include file="/commons/mini.jsp"%>
<link href="${ctxPath}/styles/customform.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div class="form-outer">
		<form id="miniForm">
			<table class="table-detail column_2_m" cellspacing="0" cellpadding="1">
				<tr>
					<td style="background-color: white">列数</td>
					<td>
					<div id="column" name="column" class="mini-radiobuttonlist"  onvaluechanged="previewHtml()"
						  textField="text" valueField="id" value="column-four"  data="[{id:'column-two',text:'双列'},{id:'column-four',text:'四列'},{id:'column-six',text:'六列'}]" >
						</div>
					</td>
					<td style="background-color: white">行数</td>
					<td>
						<input id="row"
							   name="row"
							   style="width: 100%"
							   allowinput="true"
							   changeOnMousewheel="false"
							   class="mini-spinner"
							   minValue="1"
							   maxValue="50"
							   onvaluechanged="previewHtml()"/>
					</td>
				</tr>
				<tr>
					<td style="background-color: white">样式风格</td>
					<td colspan="3" class="toggleColor">
						<label><input name="color" type="radio" value="transparent" checked onclick="radioChange()"/>透明</label>
						<label><input name="color" type="radio" value="blue" onclick="radioChange()"/>浅蓝</label>
						<label><input name="color" type="radio" value="green"  onclick="radioChange()"/>淡绿</label>
						<label><input name="color" type="radio" value="brown"  onclick="radioChange()"/>树棕</label>
						<label><input name="color" type="radio" value="grey"  onclick="radioChange()"/>银灰</label>
					</td>
				</tr>
				<tr>
					<td>一对一子表</td>
					<td colspan="3">
						<input class="mini-checkbox" name="subOneToOne" id="subOneToOne" onvaluechanged="subOneToOneChange"/>
						<span id="spanSubTableName">
							表名:<input class="mini-textbox" name="subTableName" id="subTableName" width="200"/>
							备注:<input class="mini-textbox" name="comment" id="comment" width="200"/>
						</span>
					</td>
				</tr>
			</table>
		</form>

		<script id="templateList"  type="text/html">
			<# 
			var row=rows;
			if(isPreview) row=2;
			#>
			<div class="tableBox" id="<#=formId#>" <# if(subOneToOne){#>  relationtype="onetoone" tablename="<#=subTableName#>" comment="<#=comment#>" <#}else{#> relationtype="main" <#}#> >
				<table cellspacing="1" cellpadding="0" class="table-detail <#=column#> <#=colorStyle#>" cellspacing="1" cellpadding="0" >
					<caption>标题</caption>
					<# for(var i=0;i<row;i++){#>
						<#if (column=='column-two'){#>
							<tr><td align="center"></td><td align="left"></td></tr>
						<#}else if(column=='column-four'){#>
							<tr> <td align="center"></td> <td align="left"></td> <td align="center"></td> <td align="left"></td> </tr>
						<#}else if(column=='column-six'){#>
							<tr> <td align="center"></td> <td align="left"></td> <td align="center"></td> <td align="left"></td> <td align="center"></td> <td align="left"></td></tr>
						<#}else if(column=='column-eight'){#>
							<tr><td align="center"></td> <td></td> <td align="center"></td><td></td> <td align="center"></td><td></td> <td align="center"></td><td></td></tr>
						<#}
					}
					#>
				</table>
			</div>
		</script>
		
		<div id="previewForm"></div>

	</div>
		<script type="text/javascript">
			mini.parse();
			//预览HTML
			previewHtml();
			//切换子表是否显示。
			toggleSubOneToOne()
			
	        function buildHtml(isPreview){
	    		var column=mini.get("column").getValue();//列数
	    		var row=mini.get("row").getValue();//行数
	    		var colorStyle=$("input[name='color']:checked").val();
	    		var subTableName=mini.get("subTableName").getValue();
	    		var subOneToOne=mini.get("subOneToOne").getChecked();
	    		var formId="form_" + ( subOneToOne?subTableName:"main") +new Date().format("mmss");
	    		var comment=mini.get("comment").getValue();
	    		var data={rows:row,colorStyle:colorStyle,column:column,isPreview:isPreview,
	    				subOneToOne:subOneToOne,subTableName:subTableName,formId:formId,comment:comment};
	    		var html=baiduTemplate('templateList',data);
	            return html;
	        }
		
			function previewHtml(){
				$("#previewForm").html(buildHtml(true));
				$("#previewForm").hide();
				$("#previewForm").fadeIn();
			}
			
			function radioChange(){
				previewHtml();
			}
		
		
			//确认
			dialog.onok = function (){
		            editor.execCommand('insertHtml',buildHtml(false));
			};
			
			function toggleSubOneToOne(){
				var subOneToOne=mini.get("subOneToOne").getChecked();
				var spanSubTableName=$("#spanSubTableName");
				if(subOneToOne){
					spanSubTableName.show();
				}
				else{
					spanSubTableName.hide();
				}
			} 
			
			function subOneToOneChange(){
				toggleSubOneToOne();
			}
		
	</script>
</body>
</html>
