<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI" %>
<!DOCTYPE html>
<html>
    <head>
        <title>组织列表管理</title>
        <%@include file="/commons/list.jsp"%>
    </head>
    <body>

        <div class="mini-fit rx-grid-fit">
            <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;border" allowResize="false"
                 url="${ctxPath}/sys/core/sysInst/getAllApplyInstList.do"  idField="instId" multiSelect="true" showColumnsMenu="true"
                 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div name="action" cellCls="actionIcons" width="30" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
                    <div field="usFullName" width="30" headerAlign="center" allowSort="true" sortField="US_FULL_NAME_">申请人</div>
                    <div field="note" width="100" headerAlign="center" allowSort="true" sortField="NOTE_">备注</div>
                </div>
            </div>
        </div>
        <script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
        <redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysInst" 
           winHeight="450" winWidth="800" tenantId="${param['tenantId']}"
           entityTitle="组织" baseUrl="sys/core/sysInst"/>
        <script type="text/javascript">
			var datagrid1 = mini.get('datagrid1');
        	//编辑
	        function onActionRenderer(e) {
	            var record = e.record;
	            var id=record.id;
	            var s = '<span  title="同意加入" onclick="agree(\'' + id + '\')">同意加入</span>'
	            		+ ' <span c title="拒绝加入" onclick="refuse(\'' + id + '\')">拒绝加入</span>';
	            return s;
	        }

	        function agree(instId){
                userDialog(instId,"1");
            }
            function refuse(instId){
                userDialog(instId,"0");
            }
            //审批操作
            function userDialog(instId,approvalType){
                _OpenWindow({
                    url:__rootPath+'/sys/core/sysInst/approval.do?instId='+instId+"&approvalType="+approvalType,
                    height:300,
                    width:600,
                    iconCls:'icon-user-dialog',
                    title:'处理申请加入本机构人员',
                    ondestroy:function(action){
                        if(action!='ok')return;
                        var iframe = this.getIFrameEl();
                        var noteObject = iframe.contentWindow.getValue();
                        if(!noteObject || !noteObject.instId)return;
                        sumbiJson(noteObject);
                    }
                });
            }

        	//同意或者拒绝提交
        	function sumbiJson(noteObject){
	        	var osInstAccs = {
					id:noteObject.instId,
					isAgree:noteObject.approvalType,
                    note:noteObject.note
				};
				var config={
					url:__rootPath+'/sys/core/sysInst/agreeOrRefuse.do',
					method:'POST',
					postJson:true,
					data:osInstAccs,
					success:function(result){
						datagrid1.load();
					}
				}
				_SubmitJson(config);
			}
        </script>
    </body>
</html>