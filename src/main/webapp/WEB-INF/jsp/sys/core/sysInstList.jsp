<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI" %>
<!DOCTYPE html>
<html>
    <head>
        <title>组织列表管理</title>
        <%@include file="/commons/list.jsp"%>
    </head>
    <body>
    	<div class="mini-toolbar" >
			<div class="searchBox">
				<form id="searchForm" class="search-form" >						
					<ul>
						<li>
							<span class="long text">中文名：</span><input class="mini-textbox" name="Q_nameCn__S_LK"/>
						</li>
						<li>
							<span class="text">机构域名：</span><input class="mini-textbox" name="Q_domain__S_LK"/>
						</li>

						<li class="liBtn">
							<a class="mini-button  " onclick="searchForm(this)" >搜索</a>
							<a class="mini-button  btn-red"  onclick="onClearList(this)">清空搜索</a>
							<span class="unfoldBtn" onclick="no_more(this,'moreBox')">
								<em>展开</em>
								<i class="unfoldIcon"></i>
							</span>
						</li>
					</ul>
					<div id="moreBox">
						<ul>
							<li>
								<span class="long text">英文名：</span><input class="mini-textbox" name="Q_nameEn__S_LK"/>
							</li>
							<li>
								<span class="text">机构编号：</span><input class="mini-textbox" name="Q_instNo__S_LK"/>
							</li>
							<li>
								<span class="text">状态：</span>
								<input
										name="Q_status__S_EQ"
										class="mini-combobox"
										data="[{id:'DISABLED',text:'禁用'},{id:'ENABLED',text:'启用'},{id:'INIT',text:'初始化'}]"
										value=""
										showNullItem="true"
										nullItemText=""
								/>
							</li>
						</ul>
					</div>
				</form>
			</div>
			<ul class="toolBtnBox">
				<li>
					<a class="mini-button"    onclick="add()">新增</a>
				</li>
				<li>
					<a class="mini-button"  onclick="edit()">编辑</a>
				</li>
				<li>
					<a class="mini-button"   onclick="detail()">明细</a>
				</li>
				<li>
					<a class="mini-button"   onclick="enable()">启用</a>
				</li>
				<li>
					<a class="mini-button"   onclick="disable()">禁用</a>
				</li>
				<li>
					<a class="mini-button btn-red"   onclick="remove()">删除</a>
				</li>
			</ul>
			<span class="searchSelectionBtn" onclick="no_search(this ,'searchForm')">
				<i class="icon-sc-lower"></i>
			</span>
	     </div>
        <div class="mini-fit rx-grid-fit">
            <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;border" allowResize="false"
                 url="${ctxPath}/sys/core/sysInst/listData.do"  idField="instId" multiSelect="true" showColumnsMenu="true"
                 sizeList="[5,10,20,50,100,200,500]" pageSize="20" allowAlternating="true" pagerButtons="#pagerButtons">
                <div property="columns">
                    <div type="checkcolumn" width="20" headerAlign="center" align="center"></div>
                    <div name="action" cellCls="actionIcons" width="100"  renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
                    <div field="nameCn" width="120" headerAlign="" allowSort="true" sortField="NAME_CN_">机构中文名</div>
                    <div field="instType" width="100" headerAlign="" allowSort="true" sortField="NAME_EN_">机构类型</div>
                    <div field="domain" width="100" headerAlign="" allowSort="true" sortField="DOMAIN_">域名</div>
                    <div field="instNo" width="100" headerAlign="" allowSort="true" sortField="INST_NO_">机构编号</div>
					<div field="createTime" width="100" headerAlign="" dateformat="yyyy-MM-dd HH:mm" allowSort="true" sortField="CREATE_TIME_">创建时间</div>
                    <div field="status" width="60" headerAlign="" allowSort="true" renderer="onStatusRenderer" sortField="STATUS_">状态</div>
                </div>
            </div>
        </div>
        <script src="${ctxPath}/scripts/common/list.js" type="text/javascript"></script>
        <redxun:gridScript gridId="datagrid1" entityName="com.redxun.sys.core.entity.SysInst" 
           winHeight="450" winWidth="800" tenantId="${param['tenantId']}"
           entityTitle="组织" baseUrl="sys/core/sysInst"/>
        <script type="text/javascript">
        	//编辑
	        function onActionRenderer(e) {
	            var record = e.record;
	            var pkId = record.pkId;
	            var uid=record._uid;
	            var s = ' <span  title="明细" onclick="detailRow(\'' + pkId + '\')">明细</span>'
						+ ' <span  title="删除" onclick="delRow(\'' + pkId + '\')">删除</span>'
						+ ' <span  title="修改域名" onclick="editDomain(\'' + pkId + '\')">修改域名</span>';
						if(record.status=='INIT'){
							s = s + ' <span  title="审批" onclick="editRow(\'' + pkId + '\')">审批</span>';
						}else{
							s = s + ' <span  title="编辑" onclick="editRow(\'' + pkId + '\')">编辑</span>';
						}
						s = s +'<span  title="组织机构管理" onclick="orgSetRow(\'' + uid + '\')">组织机构管理</span>';
	                    s = s + '<span  title="管理员设置" onclick="mgrRow(\'' + pkId + '\')">管理员设置</span>';

	            return s;
	        }

        	//修改域名
        	function editDomain(pkId){
        		var url = '${ctxPath}/sys/core/sysInst/domainEdit.do?pkId='+pkId;
        		 _OpenWindow({
            		 url: url,
                    title: "修改域名",
                    width: 550, height: 350,
                    ondestroy: function(action) {
                        if (action == 'ok') {
                            grid.reload();
                        }
                    }
            	});
        	}
        	
        	function mgrRow(pkId){
        		var url = '${ctxPath}/sys/core/sysInst/mgr.do?tenantId='+pkId;
        		 _OpenWindow({
            		 url: url,
                    title: "管理员设置",
                    width: 550, height: 350,
                    ondestroy: function(action) {
                        
                    }
            	});
        	}
        	
        	//启用
        	function enable(){
        		changeStatus('ENABLED');
        	}
        	//禁用
        	function disable(){
        		changeStatus('DISABLED');
        	}
        	
        	function changeStatus(status){
        		var ids=_GetGridIds('datagrid1');
        		if(ids.length==0) return;
        		_SubmitJson({
        			url:'${ctxPath}/sys/core/sysInst/enable.do',
        			data:{ids:ids.join(','),enable:status},
        			method:'POST',
        			success:function(result){
        				grid.load();
        			}
        		});
        	}
        	
        	//设置某租用账户下的组织机构
        	function orgSetRow(uid){
        		var row= grid.getRowByUID(uid);
        		top['index'].showTabPage({
						title:row.nameCn+'-组织架构',
						url:'/sys/org/sysOrg/mgr.do?tenantId='+row.instId + "&instType=" + row.instType,
						showType:'url',
						iconCls:'icon-org-set',
						menuId:'sys_'+row.instId
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
        	
        
        	
        </script>
    </body>
</html>