<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI" %>
<!DOCTYPE html>
<html>
    <head>
        <title>组织列表管理</title>
        <%@include file="/commons/list.jsp"%>
    </head>
    <body>
    <div class="mini-layout" style="width: 100%;height: 100%">
        <div region="center" showHeader="fasle" showSplitIcon="false">
    	<div class="form-toolBox" >
            <ul >
                <li >
                    <a class="mini-button " onclick="userDialog()" >加入</a>
                </li>
            </ul>
            <span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
                <i class="icon-sc-lower"></i>
            </span>
	     </div>
        <div class="mini-fit rx-grid-fit">
            <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;border" allowResize="false"
                 url="${ctxPath}/sys/core/sysInst/listApplData.do"  idField="instId" multiSelect="true" showColumnsMenu="true"
                 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div name="action" cellCls="actionIcons" width="80"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
                    <div field="nameCn" width="80"  allowSort="true" sortField="NAME_CN_">机构中文名</div>
                    <div field="domain" width="80"  allowSort="true" sortField="DOMAIN_">域名</div>
                    <div field="status" width="20"  allowSort="true" renderer="onStatusRenderer" sortField="STATUS_">状态</div>
					<div field="moreInstStatus" width="60"  allowSort="true"  renderer="onStatusAppl"  sortField="MORE_INST_STATUS_">是否加入</div>
                    <div field="moreInstNote" width="100"  allowSort="true"  sortField="MORE_INST_NOTE_">备注</div>
                </div>
            </div>
        </div>
        </div>
    </div>
        <script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
        <redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysInst" 
           winHeight="450" winWidth="800" tenantId="${param['tenantId']}"
           entityTitle="组织" baseUrl="sys/core/sysInst"/>
        <script type="text/javascript">

            var datagrid1 = mini.get('datagrid1');
			//申请加入机构
			function userDialog(){
				_OpenWindow({
					url:__rootPath+'/sys/core/sysInst/selectDialog.do',
					height:600,
					width:1200,
					iconCls:'icon-user-dialog',
					title:'选择加入的机构',
					ondestroy:function(action){
						if(action!='ok')return;
						var iframe = this.getIFrameEl();
						var instList = iframe.contentWindow.getInst();
                        var note = iframe.contentWindow.getNoteValue();
						if(!instList || instList.length==0)return;
						var saveList = [];
						for(var i=0;i<instList.length;i++){
                            var sysInst={
                                domain:instList[i].domain,
                                instId:instList[i].instId,
                                moreInstNote:note
                            };
                            saveList.push(sysInst)
                        }
						saveSelectInst(saveList);
					}
				});
			}
			function saveSelectInst(sysInstList) {
                var config={
                    url:__rootPath+'/sys/core/sysInst/saveSelectInst.do',
                    method:'POST',
                    postJson:true,
                    data:sysInstList,
                    success:function(result){
                        datagrid1.load();
                    }
                }
                _SubmitJson(config);
            }

			//编辑
			function onActionRenderer(e) {
				var record = e.record;
				var pkId = record.pkId;
				var uid=record._uid;
				var s = ' <span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>';
				if(!record.present){
					if(record.moreInstStatus=='ENABLED'){
						s = s + ' <span  title="退出" onclick="quitOrCancel(\'' + uid + ',1\')">退出</span>';
					}else if(record.moreInstStatus=='APPLY'){
						s = s + ' <span  title="取消申请" onclick="quitOrCancel(\'' + uid + ',2\')">取消申请</span>';
					}else if(record.moreInstStatus=='DISABLED'){
                        /*s = s + ' <span  title="重新申请" onclick="reaAply(\'' + uid + '\')"></span>'*/
                        s = s + ' <span  title="取消申请" onclick="quitOrCancel(\'' + uid + ',2\')">取消申请</span>';
                    }
				}
				return s;
			}

			function reaAply(row_uid){
                var node = datagrid1.getRowByUID(row_uid);
                var domain =node.domain;
                var tenantId = node.tenantId;
            }


			function quitOrCancel(row_uid){
			    var row_uids = row_uid.split(",");
			    var masess = row_uids[1]==1?"退出所选机构":"取消所选机构的申请";
                mini.confirm('确定'+masess+'？',masess,function ok(action){
                    if (action == "ok") {
                        var node = datagrid1.getRowByUID(row_uids[0]);
                        var domain =node.domain;
                        var tenantId = node.tenantId;
                        var moreInstStatus = node.moreInstStatus;
                        var url = __rootPath+'/sys/core/sysInst/quitOrCancel.do?domain='+domain+"&tenantId="+tenantId+"&moreInstStatus="+moreInstStatus;
                        $.getJSON(url,function callbact(json){
                            datagrid1.load();
                            top._ShowTips({
                                msg:json.message
                            });
                        });
                    }
                });
            }

			function onStatusRenderer(e) {
				var record = e.record;
				var status = record.status;

				var arr = [ {'key' : 'ENABLED','value' : '启用','css' : 'green'},
					{'key' : 'DISABLED','value' : '禁用','css' : 'red'},
					{'key' : 'INIT','value' : '初始化','css' : 'blue'}];

				return $.formatItemValue(arr,status);
			}

			function onStatusAppl(e) {
				var record = e.record;
				var moreInstStatus = record.moreInstStatus;
				var arr = [
						{'key' : 'ENABLED','value' : '在用','css' : 'green'},
					    {'key' : 'DISABLED','value' : '申请不通过','css' : 'red'},
					    {'key' : 'APPLY','value' : '申请处理中','css' : 'blue'},
					    {'key' : 'DELETED','value' : '删除','css' : 'blue'},
				];

				return $.formatItemValue(arr,moreInstStatus);
			}



		</script>
    </body>
</html>