<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI" %>
<!DOCTYPE html>
<html>
    <head>
        <title>管理员设置</title>
        <%@include file="/commons/list.jsp"%>
    </head>
    <body>
    	<div class="topToolBar" >
	         <div>
                 <a class="mini-button"   onclick="addAdmin()">新增</a>
                 <a class="mini-button btn-red"  onclick="removeAdmin()">删除</a>
                 <a class="mini-button btn-red"    onclick="CloseWindow()">关闭</a>
             </div>
	     </div>

        <div class="mini-fit rx-grid-fit">
            <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;border" allowResize="false"
                 url="${ctxPath}/sys/org/osUser/getInstAdmin.do?tenantId=${param['tenantId']}"  idField="userId" multiSelect="false" showColumnsMenu="true"
                 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" >
                <div property="columns">
                    <div type="checkcolumn" width="20"></div>
                    <div field="userNo" width="120" headerAlign="center">用户编号</div>    
                    <div field="fullname" width="100" headerAlign="center">用户名</div>
                </div>
            </div>
        </div>
        <script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
        <redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.org.entity.OsUser" 
           winHeight="450" winWidth="800" tenantId="${param['tenantId']}"
           entityTitle="用户" baseUrl="sys/org/osUser"/>
        <script type="text/javascript">
            var tenantId = "${param['tenantId']}";
			function addAdmin(){
                var conf ={
                    single:false,
                    tenantId:"${param['tenantId']}",
                    callback :updateAdmin
                };
                _UserDialog(conf);
			}
			
			function updateAdmin(users){
                if(users==null || users.length==0) return;
                for(var i=0;i<users.length;i++){
                    var user =users[i];
                    var config={
                        url:__rootPath+"/sys/org/osUser/updateIsAdmin.do",
                        method:'POST',
                        showMsg:false,
                        data:{userId:user.userId,flag:1,tenantId:tenantId},
                        success:function(result){
                            grid.load();
                        }
                    }
                    _SubmitJson(config);
                }
			}
			
			function removeAdmin(){
				var row=grid.getSelecteds();
				if(row.length<1){
					alert("请选择要删除的管理员！");
					return;
				}
				var config={
		        	url:__rootPath+"/sys/org/osUser/updateIsAdmin.do",
		        	method:'POST',
		        	showMsg:false,
		        	data:{userId:row[0].userId,flag:0,tenantId:tenantId},
		        	success:function(result){
		        		grid.load();
		        	}
		        }		       
			    _SubmitJson(config);	
			}
        </script>
    </body>
</html>