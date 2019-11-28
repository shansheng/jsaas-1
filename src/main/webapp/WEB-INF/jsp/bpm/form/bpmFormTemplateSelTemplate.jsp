<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <title>新建手机表单</title>
        <%@include file="/commons/edit.jsp" %>
        <script type="text/javascript" src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/sys/bo/BoUtil.js?version=${static_res_version}"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/flow/form/bpmFormView.js?version=${static_res_version}"></script>
    </head>
    <body > 
         <div id="toolbar1" class="mini-toolbar mini-toolbar-bottom" >
		    <a class="mini-button"   onclick="onSelect">选择</a>
		</div>
       <div id="p1" class="form-outer2 ">
            <form id="form1" method="post" >
              <table class="table-detail" cellspacing="1" cellpadding="0">
                <tr>
					<th>
						<span class="starBox">
			 				选择模版<span class="star">*</span>
		 				</span>
			 		</th>
					<td id="tdTemplate">
						
					</td>
				</tr>
			  </table>
            </form>
        </div>
        <script id="templateList"  type="text/html">
			<select id="template" >
				<#for(var n=0;n<templateAry.length;n++){
					var tmp=templateAry[n];
				#>
				<option value="<#=tmp.alias#>"><#=tmp.name#></option>
				<#}#>
			</select>
		</script>
		<script type="text/javascript">
			var category="${param.category}";
			var type="${param.type}";
			
			$(function(){
				var url=__rootPath + "/bpm/form/bpmFormTemplate/getByCategory.do";
				var params={category:category,type:type};
				$.post(url,params,function(data){
					var html= baidu.template('templateList',{templateAry:data});  
					$("#tdTemplate").html(html);
				})
			})
			
			function getData(){
				var template=$("#template").val();
				return template;
			}
			
			function onSelect(){
				var template=getData();
				if(!template){
					alert("请选择模版!")
					return;
				} 
				CloseWindow('ok');
			}
		</script>
      
       
    </body>
</html>