-- 19. 栏目定义

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000003411003','消息盒','msgBox','1','1',NULL,'portalScript.getPortalMsgBox("msgbox")','NO','1','','','','','','msgbox','');
			BEGIN
			DECLARE
			html2400000003411003 varchar2(4001);
			BEGIN
			html2400000003411003:= '<ol class="messageBoxs">
  <#list data.obj as d>
		<li>
          <a href="${ctxPath}${d.url}" target="_blank">
          			<div class="icons">
                    	  <span class="iconfont ${d.icon}" style="color:${d.color}"></span>
            		</div>
            		<div class="contentBox">
            				<h4>${d.count}</h4>
                      		<p>${d.title}</p>	
            		</div>
          </a>
  		</li>
  </#list>
</ol>

';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000003411003 WHERE INS_COLUMN_DEF.COL_ID_='2400000003411003';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000003411005','待办列表','BpmTaskList','/bpm/core/bpmTask/myList.do','1',NULL,'portalScript.getPortalBpmTask(colId)','NO','1','1','','1','','','','');
			BEGIN
			DECLARE
			html2400000003411005 varchar2(4001);
			BEGIN
			html2400000003411005:= '<div id="myTask" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1><em class="daiban"></em>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"  title="更多"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')"  title="刷新"/>
						</div>
					</dt>
					<#list data.obj as obj>
						<dd>
                    		    <span class="project_01">
								<em>■</em>
                                		<a href="${ctxPath}/bpm/core/bpmTask/toStart.do?fromMgr=true'||chr(38)||'taskId=${obj.id}" target="_blank">
                                        			${obj.description}
                                       	 </a>
							</span>
							<span class="project_02">
								<a href="###">【${obj.name}】</a>
							</span>
							<span class="project_03">
								<a href="###">${obj.createTime?string(''yyyy-MM-dd'')}</a>
							</span>
						</dd>
					</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000003411005 WHERE INS_COLUMN_DEF.COL_ID_='2400000003411005';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000004011000','公司公告','noticeNews','/oa/info/insNews/byColId.do','1',NULL,'portalScript.getPortalNews(colId)','YES','1','1','','1','','','newsNotice','');
			BEGIN
			DECLARE
			html2400000004011000 varchar2(4001);
			BEGIN
			html2400000004011000:= '<div id="noticeNews" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1><em class="xiaoxi"></em>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')" title="更多"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')" title="刷新"/>
						</div>
						<div class="clearfix"></div>
					</dt>
					<#list data.obj as obj>
							   <dd>
									<span class="project_01">
										     <em>■</em>
											  <a href="${ctxPath}/oa/info/insNews/get.do?pkId=${obj.newId}" target="_blank">
												${obj.subject}
											  </a>
									   </span>
									   <span class="project_02">
												<a href="###">${obj.author}</a>
									   </span>
									   <span class="project_03">
									<a href="###">${obj.createTime?string(''yyyy-MM-dd'')}</a>
							   </span>
							 </dd>
					</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000004011000 WHERE INS_COLUMN_DEF.COL_ID_='2400000004011000';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000004021000','我的消息','myMsg','1','1',NULL,'portalScript.getPortalMsg(colId)','NO','1','1','','1','','','','');
			BEGIN
			DECLARE
			html2400000004021000 varchar2(4001);
			BEGIN
			html2400000004021000:= '<div id="myMsg" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1><em class="xiaoxi"></em>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')" title="更多"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')" title="刷新"/>
						</div>
						<div class="clearfix"></div>
					</dt>
					<#list data.obj as obj>
            				       <dd>
                                   			<span class="project_01">
             					        		<b></b>
                                              		  <a href="${ctxPath}/oa/info/infInbox/recPortalGet.do?pkId=${obj.msgId}" target="_blank">
                                                      			${obj.content}
                                              		  </a>
                                               </span>
                                               <span class="project_02">
                                               			<a href="###">${obj.sender}</a>
                                               </span>
                                               <span class="project_03">
											<a href="###">${obj.createTime?string(''yyyy-MM-dd'')}</a>
									   </span>
               				       </dd>
						</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000004021000 WHERE INS_COLUMN_DEF.COL_ID_='2400000004021000';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000004021001','外部邮件','outMail','1','1',NULL,'portalScript.getPortalOutEmail(colId)','NO','1','1','','','','','','');
			BEGIN
			DECLARE
			html2400000004021001 varchar2(4001);
			BEGIN
			html2400000004021001:= '<div id="outMail" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')"/>
						</div>
						<div class="clearfix"></div>
					</dt>
						<#list data.obj as obj>
						<dd>
							<p><a href="${ctxPath}/oa/mail/outMail/get.do?isHome=YES'||chr(38)||'pkId=${obj.mailId}" target="_blank">${obj.subject}</a></p>
						</dd>
						</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000004021001 WHERE INS_COLUMN_DEF.COL_ID_='2400000004021001';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000008039006','导航信息','baseNavInfo','','',NULL,'portalScript.getPortalMsgBox("msgbox")','NO','1','','','','','','content','');
			BEGIN
			DECLARE
			html2400000008039006 varchar2(4001);
			BEGIN
			html2400000008039006:= '<ol class="olNav">
		<li>
  			<a href="http://www.aps360.cn">
              <div>
          		<h6>红迅公司</h6>
              	<p>www.aps360.cn</p>
                </div>	
          	</a>
  		</li>
  		<li>
  			<a href="http://rxhelp.mbldt.com">
              <div>
          		<h6>帮助文档</h6>
              	<p>help.redxun.cn</p>
              </div>	
          	</a>
  		</li>
  		<li>
  			<a href="###">
              <div>
          		<h6>陈经理</h6>
              	<p>18819248092</p>
              </div>	
          	</a>
  		</li>
 		 <li>
  			<a href="###">
              <div>
          		<h6>邮箱</h6>
              	<p>keitch@redxun.cn</p>
              </div>	
          	</a>
  		</li>
  		<li>
  			<a href="###">
              <div>
          		<h6>地址</h6>
              	<p>广州市海珠区庭园路163号</p>
              </div>	
          	</a>
  		</li>
</ol>
';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000008039006 WHERE INS_COLUMN_DEF.COL_ID_='2400000008039006';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000008759000','柱状报表','reportCol','','',NULL,'','NO','1','1','','1','','','','');
			BEGIN
			DECLARE
			html2400000008759000 varchar2(4001);
			BEGIN
			html2400000008759000:= '<div id="report" class="colId_${colId} modularBox" colId="${colId}" style="background: #fff;height:450px;width:100%;">
<div id="zzbb" style="width:560px;height:440px;" ></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById(''zzbb''));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: ''本月销量''
            },
            tooltip: {},
            legend: {
                data:[''销量'']
            },
            xAxis: {
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
            },
            yAxis: {},
            series: [{
                name: ''销量'',
                type: ''bar'',
                data: [5, 20, 36, 10, 10, 20]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000008759000 WHERE INS_COLUMN_DEF.COL_ID_='2400000008759000';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000011559002','折线报表图','zxbbt','','',NULL,'','NO','1','1','','1','','','','');
			BEGIN
			DECLARE
			html2400000011559002 varchar2(4001);
			BEGIN
			html2400000011559002:= '<div id="zxbbt" class="colId_${colId} " colId="${colId}" style="background: #fff;">
<div id="zxbbtChart" style="width:100%;height:100%;" ></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var zxChart = echarts.init(document.getElementById(''zxbbtChart''));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: ''本月销量''
            },
            tooltip: {},
            legend: {
                data:[''销量'']
            },
            xAxis: {
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
            },
            yAxis: {},
            series: [{
                name: ''销量'',
                type: ''line'',
                data: [5, 20, 36, 10, 10, 20]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        zxChart.setOption(option);
    </script>
</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000011559002 WHERE INS_COLUMN_DEF.COL_ID_='2400000011559002';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000011559004','曲线报表图','qxbbtCol','','',NULL,'','NO','1','1','','1','','','','');
			BEGIN
			DECLARE
			html2400000011559004 varchar2(4001);
			BEGIN
			html2400000011559004:= '<div id="qxbbt" class="colId_${colId}" colId="${colId}" style="background: #fff;">
	<div id="qxbbtChart" style="min-width:100%;max-width:100%;height:360px;" ></div>
	<script type="text/javascript">

		 var resizeMyFn = function(){
			   var MyDiv = document.getElementById("qxbbtChart");
			   var MyWidth = document.documentElement.clientWidth || document.body.clientWidth
			   MyDiv.style.width = MyWidth*0.48+"px";
		  }
		 resizeMyFn();
		 
		// 基于准备好的dom，初始化echarts实例
		var qxChart = echarts.init(document.getElementById(''qxbbtChart''));

		option = {
			xAxis: {
				type: ''category'',
				boundaryGap: false,
				data: [''Mon'', ''Tue'', ''Wed'', ''Thu'', ''Fri'', ''Sat'', ''Sun'']
			},
			yAxis: {
				type: ''value''
			},
			series: [{
				data: [820, 932, 901, 934, 1290, 1330, 1320],
				type: ''line'',
				areaStyle: {}
			}]
		};

		// 使用刚指定的配置项和数据显示图表。
		qxChart.setOption(option);
	   
		window.onresize = function () { 
			 resizeMyFn();
			 qxChart.resize();
		}
	</script>
</div>
';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000011559004 WHERE INS_COLUMN_DEF.COL_ID_='2400000011559004';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000011559013','流程方案申请','mySolList','','',NULL,'portalScript.getPortalMySolList(colId);','NO','1','1','','','','','','');
			BEGIN
			DECLARE
			html2400000011559013 varchar2(4001);
			BEGIN
			html2400000011559013:= '<div id="myDrafts" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')"/>
						</div>
						<div class="clearfix"></div>
					</dt>
						<#list data.obj as obj>
						<dd>
							<p><a href="${ctxPath}/bpm/core/bpmInst/start.do?solId=${obj.solId}" target="_blank">${obj.name}</a></p>
						</dd>
						</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000011559013 WHERE INS_COLUMN_DEF.COL_ID_='2400000011559013';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2400000011589005','漏斗报表图','ldbbt','','',NULL,'','NO','1','1','','','','','','');
			BEGIN
			DECLARE
			html2400000011589005 varchar2(4001);
			BEGIN
			html2400000011589005:= '<div id="ldbbt" class="colId_${colId}" colId="${colId}" style="background: #fff;">
<div id="ldbbtChart" style="width:100%;height:360px;" ></div>
<div class="script">
 <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var ldChart = echarts.init(document.getElementById(''ldbbtChart''));

        // 指定图表的配置项和数据
      option = {
    title : {
        text: ''漏斗图'',
        subtext: ''纯属虚构''
    },
    tooltip : {
        trigger: ''item'',
        formatter: "{a} <br/>{b} : {c}%"
    },
    legend: {
        data : [''展现'',''点击'',''访问'',''咨询'',''订单'']
    },
    calculable : true,
    series : [
        {
            name:''漏斗图'',
            type:''funnel'',
            width: ''40%'',
            data:[
                {value:60, name:''访问''},
                {value:40, name:''咨询''},
                {value:20, name:''订单''},
                {value:80, name:''点击''},
                {value:100, name:''展现''}
            ]
        },
        {
            name:''金字塔'',
            type:''funnel'',
            x : ''50%'',
            sort : ''ascending'',
            itemStyle: {
                normal: {
                    // color: 各异,
                    label: {
                        position: ''left''
                    }
                }
            },
            data:[
                {value:60, name:''访问''},
                {value:40, name:''咨询''},
                {value:20, name:''订单''},
                {value:80, name:''点击''},
                {value:100, name:''展现''}
            ]
        }
    ]
};
                    

        // 使用刚指定的配置项和数据显示图表。
        ldChart.setOption(option);
    </script>
</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2400000011589005 WHERE INS_COLUMN_DEF.COL_ID_='2400000011589005';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2430000000410492','已办事项','MyBpmTask','/oa/personal/bpmInst/myAttends.do','',NULL,'portalScript.getPortalMyBpmTask(colId)','','1','1',NULL,'1',NULL,'1','list','');
			BEGIN
			DECLARE
			html2430000000410492 varchar2(4001);
			BEGIN
			html2430000000410492:= '<div id="myTask" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<#list data.obj as obj>
						<dd>
							<span class="project_01">
                              <a href="###">${obj.subject}</a>
							</span>
							<span class="project_02">
								${obj.statusLabel}
							</span>
							<span class="project_03">
								<a href="###">${obj.createTime?string(''yyyy-MM-dd'')}</a>
							</span>
							<div class="clearfix"></div>
						</dd>
					</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2430000000410492 WHERE INS_COLUMN_DEF.COL_ID_='2430000000410492';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2430000000410493','抄送事项','MyChao','/bpm/core/bpmInstCc/list.do','',NULL,'portalScript.getPortalMyChao(colId)','','1','1',NULL,'1',NULL,'1','list','');
			BEGIN
			DECLARE
			html2430000000410493 varchar2(4001);
			BEGIN
			html2430000000410493:= '<div id="myTask" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<#list data.obj as obj>
						<dd>
							<span class="project_01">
								<a href="###">${obj.subject}</a>
							</span>
							<span class="project_02">
								${obj.nodeName}
							</span>
							<span class="project_03">
								<a href="###">${obj.createTime?string(''yyyy-MM-dd'')}</a>
							</span>
							<div class="clearfix"></div>
						</dd>
					</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2430000000410493 WHERE INS_COLUMN_DEF.COL_ID_='2430000000410493';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_, NEW_TYPE_, IS_MOBILE_)
			VALUES ('2520000000330029','Tab页栏目展现','test','','',NULL,'','','1','','','1',NULL,'1','tabcolumn','2630000000150003,2430000000410492,2430000000410493','','');
			BEGIN
			DECLARE
			html2520000000330029 varchar2(4001);
			BEGIN
			html2520000000330029:= '<div class="toolTabs">
				<div class="tabHeader">
					<div class="tabHeaderLeft" id="tabHeaderLeft">
						<ol class="tabRollBox" id="tabRollBox">
                          <#list data.obj as d>
							<li colid="${d.colId}" title="${d.name}" url="${d.dataUrl}">${d.name}<b>${d.count}</b></li>
                            </#list>
						</ol>
						
					</div>
					<div class="tabHeaderRight">
						<span class="oTabBtn tabBtnLeft">
                      			<i class="iconfont icon-you1"></i>
                      	</span>
						<span class="oTabBtn tabBtnRight">></span>
						<span class="more" onclick="showTabMore(this)">
                      			<i class="iconfont  icon-btn-mgr"></i>
                      	</span>
						<span class="refresh" onclick="refreshTab(this)">
                      			<i class="iconfont  icon-refresh"></i>
                      	</span>
					</div>
				</div>
				<div class="tabContent">
                  <#list data.obj as d>
					<div class="contentBox" >${d.templet}</div>
                    </#list>
				</div>
			</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2520000000330029 WHERE INS_COLUMN_DEF.COL_ID_='2520000000330029';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2520000000350005','新闻公告栏目','newsNotice','','',NULL,'portalScript.getPortalNews(colId)','','1','1','','1','','1','newsNotice','');
			BEGIN
			DECLARE
			html2520000000350005 varchar2(4001);
			BEGIN
			html2520000000350005:= '<div id="noticeList" class="colId_${colId}" colId="${colId}">
	<div class="widget-box border " >
		<div class="widget-body">
			<div class="widget-scroller" >
				<dl class="modularBox">
					<dt>
						<h1><em class="xiaoxi"></em>${data.title}</h1>
						<div class="icon">
							<input type="button" id="More" onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')" title="更多"/>
							<input type="button" id="Refresh" onclick="refresh(''${colId}'')" title="刷新"/>
						</div>
						<div class="clearfix"></div>
					</dt>
					<#list data.obj as obj>
            				       <dd>
                                   			<span class="project_01">
             					        		<b></b>
                                              		  <a href="${ctxPath}/oa/info/infInbox/recPortalGet.do?pkId=${obj.msgId}" target="_blank">
                                                      			${obj.subject}
                                              		  </a>
                                               </span>
                                               <span class="project_02">
                                               			<a href="###">${obj.author}</a>
                                               </span>
                                               <span class="project_03">
											<a href="###">${obj.createTime?string(''yyyy-MM-dd'')}</a>
									   </span>
               				       </dd>
						</#list>
				</dl>
			</div>
		</div>
	</div>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2520000000350005 WHERE INS_COLUMN_DEF.COL_ID_='2520000000350005';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_, NEW_TYPE_, IS_MOBILE_)
			VALUES ('2520000000390002','公司新闻','compNews','/oa/info/insNews/byColId.do','',NULL,'portalScript.getPortalNews(colId)','','1','','','','','1','newsNotice','','imgAndFont','');
			BEGIN
			DECLARE
			html2520000000390002 varchar2(4001);
			BEGIN
			html2520000000390002:= '<div id="companyNewsBox">
	<header>
      	<p>公司新闻</p>
      	<div>
        	<em>MORE</em>
     	 </div>
  	</header>
  	<div id="newContentBox">
      <#if  "${data.type}" =="imgAndFont" || "${data.type}" =="img">
		<#if data.obj?? && (data.obj?size > 0) >
    		<div class="conditionBox"  
                 <#if  "${data.type}" =="img">style="width:100%"</#if>
        	>
                    <div class="rollBanner" id="rollBanner" style="heigth:100%;display:inline-block;vertical-align: top;">
                     		 <ul class="rollBoxs_szw">
                                   <#list data.obj as obj>
                                        <li>
                                          <img title="${obj.subject}" src="${ctxPath}/sys/core/file/imageView.do?thumb=true'||chr(38)||'fileId=${obj.imgFileId}"/>
                                        </li>
                                   </#list>
                    		  </ul>
                                  <div class="rollBottom">
                                      <p id="rollText"></p>
                                      <ul class="circlBox"></ul>
                                  </div>
                                <div class="btns">
                                        <div class="leftBtn">
                                          <span></span>
                                        </div>
                                        <div class="rightBtn">
                                          <span></span>
                                        </div>
                                </div>
                	</div>
            </div>
        </#if>
		</#if>
       <#if "${data.type}" =="imgAndFont" || "${data.type}" =="wordsList">
             <div class="listBoxs"  
                  	<#if "${data.type}" =="wordsList">style="padding-left:10px;"</#if>
               >
              			<ul>
                          		<#list data.obj as obj>
               					<li>
                                  		<a href="${ctxPath}/oa/info/insNews/get.do?pkId=${obj.newId}" target="_blank" title="${obj.subject}">
											${obj.subject}
										</a>
                                  		<span  class="dates" title="${obj.createTime?string(''yyyy-MM-dd'')}">${obj.createTime?string(''yyyy-MM-dd'')}</span>
                          		</li>
                                  </#list>
               			</ul>
             </div>
          </#if>  
  	</div>
</div>

';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2520000000390002 WHERE INS_COLUMN_DEF.COL_ID_='2520000000390002';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_)
			VALUES ('2630000000150003','待办事项','BpmTask','/bpm/core/bpmTask/myList.do','',NULL,'portalScript.getPortalBpmTask(colId)','','1','','','','','','list','');
			BEGIN
			DECLARE
			html2630000000150003 varchar2(4001);
			BEGIN
			html2630000000150003:= '<div class="containerBox">
		<header>
  				<p>待办事项</p>
          		<div>
          				<em  onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')"  title="更多" >MORE</em>
          		</div>
  		</header>
  		<ul>
          <#list data.obj as obj>
  			<li>
              	<a onclick="checkAndHandTask(''${obj.id}'',false,true,''${colId}'')" target="_blank" title="${obj.description}">
                  		${obj.description}
                </a>
              	<em class="new">NEW</em>
              	<span class="dates" title="${obj.createTime?string(''yyyy-MM-dd'')}">
                  		${obj.createTime?string(''yyyy-MM-dd'')}
              	</span>
          	</li>
            </#list>
  		</ul>
</div>
';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2630000000150003 WHERE INS_COLUMN_DEF.COL_ID_='2630000000150003';
			END;
			END;
			/

			INSERT INTO INS_COLUMN_DEF (COL_ID_, NAME_, KEY_, DATA_URL_, IS_DEFAULT_, TEMPLET_, FUNCTION_, IS_NEWS_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_, IS_PUBLIC_, type_, TABGROUPS_, NEW_TYPE_, IS_MOBILE_)
			VALUES ('2630000000150004','常用流程','cylc','/oa/personal/bpmSolApply/myList.do','',NULL,'portalScript.getMyCommonInst(colId)','','1','1',NULL,'1',NULL,'','list','','','');
			BEGIN
			DECLARE
			html2630000000150004 varchar2(4001);
			BEGIN
			html2630000000150004:= '<div class="process">
	<header>
      	<p>常用流程</p>
      	<div>
        	<em onclick="showMore(''${colId}'',''${data.title}'',''${data.url}'')">MORE</em>
     	 </div>
  	</header>
    <ol>
      	<#list data.obj as obj>
     	 <li onclick="startRowBySolId(''${obj.solId}'')">
           		<span>	
                   <#if  "${obj.icon}"??>
                    	 <i class="iconfont ${obj.icon}" style="color:${obj.color}"></i>
                    </#if>
      			<#if  "${obj.icon}"== null >
                    	 <i class="iconfont icon-fangyuan-" style="color:#6399fc;"></i>
                    </#if>
           		<p>${obj.solName}</p>
                  </span>	
      	</li>
          </#list>
    </ol>
</div>';
			UPDATE INS_COLUMN_DEF  SET INS_COLUMN_DEF.TEMPLET_ = html2630000000150004 WHERE INS_COLUMN_DEF.COL_ID_='2630000000150004';
			END;
			END;
			/

-- 20 定义门户

			INSERT INTO INS_PORTAL_DEF (PORT_ID_,NAME_,KEY_,IS_DEFAULT_,USER_ID_,LAYOUT_HTML_,PRIORITY_,EDIT_HTML_,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)
			VALUES ('2400000007019000','个人','PERSONAL','NO','1',NULL,'0',NULL,'1','1','','','');
			BEGIN
			DECLARE
			html2400000007019000 varchar2(4001);
			BEGIN
			html2400000007019000:= '<div class="gridster"><ul><li class="gs-w" data-col="1" data-row="1" data-sizex="6" data-sizey="1"><div id="msgBox" class="colId_2400000003411003"></div></li></ul></div>';
			UPDATE INS_PORTAL_DEF  SET INS_PORTAL_DEF.LAYOUT_HTML_ = html2400000007019000 WHERE INS_PORTAL_DEF.PORT_ID_='2400000007019000';
			
			html2400000007019000:= '<ul style="min-width: 100%; max-width: 100%; position: relative; padding: 0px; height: 160px;"><div id="msgBox" colid="2400000003411003" data-col="1" data-row="1" data-sizex="6" data-sizey="1" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>消息盒</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000003411003'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div></ul>';
			UPDATE INS_PORTAL_DEF  SET INS_PORTAL_DEF.EDIT_HTML_ = html2400000007019000 WHERE INS_PORTAL_DEF.PORT_ID_='2400000007019000';
			END;
			END;
			/

			INSERT INTO INS_PORTAL_DEF (PORT_ID_,NAME_,KEY_,IS_DEFAULT_,USER_ID_,LAYOUT_HTML_,PRIORITY_,EDIT_HTML_,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)
			VALUES ('2400000007019002','机构Port门户','INSTPORT','NO','',NULL,'1',NULL,'1','1','','','');
			BEGIN
			DECLARE
			html2400000007019002 varchar2(4001);
			BEGIN
			html2400000007019002:= '<div class="gridster">
	<ul><li class="gs-w" data-col="1" data-row="1" data-sizex="6" data-sizey="1"><div id="msgBox" class="colId_2400000003411003"></div></li><li class="gs-w" data-col="1" data-row="2" data-sizex="2" data-sizey="3"><div id="BpmTask" class="colId_2400000003411004"></div></li><li class="gs-w" data-col="3" data-row="2" data-sizex="2" data-sizey="3"><div id="myMsg" class="colId_2400000004021000"></div></li><li class="gs-w" data-col="5" data-row="2" data-sizex="2" data-sizey="3"><div id="noticeNews" class="colId_2400000004011000"></div></li><li class="gs-w" data-col="1" data-row="5" data-sizex="3" data-sizey="2"><div id="outMail" class="colId_2400000004021001"></div></li><li class="gs-w" data-col="4" data-row="5" data-sizex="3" data-sizey="2"><div id="compNews" class="colId_2520000000390002"></div></li></ul>
</div>';
			UPDATE INS_PORTAL_DEF  SET INS_PORTAL_DEF.LAYOUT_HTML_ = html2400000007019002 WHERE INS_PORTAL_DEF.PORT_ID_='2400000007019002';
			
			html2400000007019002:= '
						<ul style="min-width: 100%; max-width: 100%; position: relative; padding: 0px; height: 910px;"><div id="msgBox" colid="2400000003411003" data-col="1" data-row="1" data-sizex="6" data-sizey="1" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>消息盒</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000003411003'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="BpmTask" colid="2400000003411004" data-col="1" data-row="2" data-sizex="2" data-sizey="3" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>待办事项</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000003411004'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="myMsg" colid="2400000004021000" data-col="3" data-row="2" data-sizex="2" data-sizey="3" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>我的消息</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000004021000'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="noticeNews" colid="2400000004011000" data-col="5" data-row="2" data-sizex="2" data-sizey="3" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>公司公告</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000004011000'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="outMail" colid="2400000004021001" data-col="1" data-row="5" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>外部邮件</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000004021001'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div><div id="compNews" colid="2520000000390002" data-col="4" data-row="5" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><dl class="modularBox"><dt><h1>公司新闻</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2520000000390002'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl><span class="gs-resize-handle gs-resize-handle-both"></span></div></ul>';
			UPDATE INS_PORTAL_DEF  SET INS_PORTAL_DEF.EDIT_HTML_ = html2400000007019002 WHERE INS_PORTAL_DEF.PORT_ID_='2400000007019002';
			END;
			END;
			/

			INSERT INTO INS_PORTAL_DEF (PORT_ID_,NAME_,KEY_,IS_DEFAULT_,USER_ID_,LAYOUT_HTML_,PRIORITY_,EDIT_HTML_,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)
			VALUES ('2400000007579001','全局门户','GLOBAL-PERSONAL','YES','',NULL,'4',NULL,'1','','','','');
			BEGIN
			DECLARE
			html2400000007579001 CLOB;
			BEGIN
			html2400000007579001:= '<div class="gridster">
	<ul><li class="gs-w" data-col="1" data-row="1" data-sizex="6" data-sizey="1"><div id="msgBox" class="colId_2400000003411003"></div></li><li class="gs-w" data-col="1" data-row="2" data-sizex="3" data-sizey="2"><div id="BpmTask" class="colId_2630000000150003"></div></li><li class="gs-w" data-col="4" data-row="2" data-sizex="3" data-sizey="2"><div id="cylc" class="colId_2630000000150004"></div></li><li class="gs-w" data-col="4" data-row="4" data-sizex="3" data-sizey="2"><div id="compNews" class="colId_2520000000390002"></div></li><li class="gs-w" data-col="1" data-row="4" data-sizex="3" data-sizey="2"><div id="test" class="colId_2520000000330029"></div></li><li class="gs-w" data-col="1" data-row="6" data-sizex="6" data-sizey="1"><div id="baseNavInfo" class="colId_2400000008039006"></div></li></ul>
</div>';
			UPDATE INS_PORTAL_DEF  SET INS_PORTAL_DEF.LAYOUT_HTML_ = html2400000007579001 WHERE INS_PORTAL_DEF.PORT_ID_='2400000007579001';
			
			html2400000007579001:= '
					<ul style="min-width: 100%; max-width: 100%; position: relative; padding: 0px; height: 790px;">

                    <li data-col="1" data-row="1" data-sizex="6" data-sizey="1" class="gs-w" style="display: block;"><div id="msgBox" colid="2400000003411003"><dl class="modularBox"><dt><h1>消息盒</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000003411003'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl></div><span class="gs-resize-handle gs-resize-handle-both"></span><span style="background-repeat: no-repeat; background-position: center center; background-image: url('||chr(38)||'quot;../../../styles/images/portal/addColumn-message.png'||chr(38)||'quot;); display: inline-block; width: 100%; height: 45%; position: absolute; top: 40%; background-size: auto 100%;"></span></li><li data-col="1" data-row="2" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><div id="BpmTask" colid="2630000000150003"><dl class="modularBox"><dt><h1>待办事项</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2630000000150003'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl></div><span class="gs-resize-handle gs-resize-handle-both"></span><span style="background-repeat: no-repeat; background-position: center center; background-image: url('||chr(38)||'quot;../../../styles/images/portal/addColumn-list.png'||chr(38)||'quot;); display: inline-block; width: 100%; height: 45%; position: absolute; top: 40%; background-size: auto 100%;"></span></li><li data-col="4" data-row="2" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><div id="cylc" colid="2630000000150004"><dl class="modularBox"><dt><h1>常用流程</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2630000000150004'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl></div><span class="gs-resize-handle gs-resize-handle-both"></span><span style="background-repeat: no-repeat; background-position: center center; background-image: url('||chr(38)||'quot;../../../styles/images/portal/addColumn-list.png'||chr(38)||'quot;); display: inline-block; width: 100%; height: 45%; position: absolute; top: 40%; background-size: auto 100%;"></span></li><li data-col="4" data-row="4" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><div id="compNews" colid="2520000000390002"><dl class="modularBox"><dt><h1>公司新闻</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2520000000390002'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl></div><span class="gs-resize-handle gs-resize-handle-both"></span><span style="background-repeat: no-repeat; background-position: center center; background-image: url('||chr(38)||'quot;../../../styles/images/portal/addColumn-news.png'||chr(38)||'quot;); display: inline-block; width: 100%; height: 45%; position: absolute; top: 40%; background-size: auto 100%;"></span></li><li data-col="1" data-row="4" data-sizex="3" data-sizey="2" class="gs-w" style="display: block;"><div id="test" colid="2520000000330029"><dl class="modularBox"><dt><h1>Tab页栏目展现</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2520000000330029'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl></div><span class="gs-resize-handle gs-resize-handle-both"></span><span style="background-repeat: no-repeat; background-position: center center; background-image: url('||chr(38)||'quot;../../../styles/images/portal/addColumn-tab.png'||chr(38)||'quot;); display: inline-block; width: 100%; height: 45%; position: absolute; top: 40%; background-size: auto 100%;"></span></li><li data-col="1" data-row="6" data-sizex="6" data-sizey="1" class="gs-w" style="display: block;"><div id="baseNavInfo" colid="2400000008039006"><dl class="modularBox"><dt><h1>导航信息</h1><div class="icon"><input type="button" id="More" onclick="openNewUrl(''/jsaas/oa/info/insColumnDef/edit.do?pkId=2400000008039006'',''栏目编辑'')"><em class="closeThis">×</em></div><div class="clearfix"></div></dt></dl></div><span class="gs-resize-handle gs-resize-handle-both"></span><span style="background-repeat: no-repeat; background-position: center center; background-image: url('||chr(38)||'quot;../../../styles/images/portal/addColumn-panel.png'||chr(38)||'quot;); display: inline-block; width: 100%; height: 45%; position: absolute; top: 40%; background-size: auto 100%;"></span></li></ul>
				';
			UPDATE INS_PORTAL_DEF  SET INS_PORTAL_DEF.EDIT_HTML_ = html2400000007579001 WHERE INS_PORTAL_DEF.PORT_ID_='2400000007579001';
			END;
			END;
			/
		
			
-- 21. 布局权限设置
INSERT INTO INS_PORTAL_PERMISSION (ID_, LAYOUT_ID_, TYPE_, OWNER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000690053', '2400000007579001', 'ALL', 'ALL', '1', '1', NULL, NULL, NULL);

INSERT INTO INS_PORTAL_PERMISSION (ID_, LAYOUT_ID_, TYPE_, OWNER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000690054', '2400000007019000', 'ALL', 'ALL', '1', '1', NULL, NULL, NULL);

INSERT INTO INS_PORTAL_PERMISSION (ID_, LAYOUT_ID_, TYPE_, OWNER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000690055', '2400000007579002', 'ALL', 'ALL', '1', '1', NULL, NULL, NULL);

-- 22. 消息盒子
	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000007699002','#ec551f','/bpm/core/bpmTask/myList.do',' icon-folder','我的待办','mysql','mysql','import com.redxun.saweb.context.ContextUtil;
String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from act_ru_task where assignee_="+userId ;
return sql;','sql',1,NULL,NULL,NULL,NULL);

	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000011559007','#ffba42','/oa/personal/bpmInst/myAttends.do',' icon-example','我的已办','','','import com.redxun.saweb.context.ContextUtil;
String userId = ContextUtil.getCurrentUserId();
String sql="select count(DISTINCT c.ACT_INST_ID_) from   bpm_node_jump c  where HANDLER_ID_=''"+userId+"'' and c.TENANT_ID_ like ''[TENANTID]''";
return sql;','sql',1,NULL,NULL,NULL,NULL);

	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000011589004','#878ef2','/bpm/core/bpmInst/myDrafts.do',' icon-copydown','我的流程草稿','','','import com.redxun.saweb.context.ContextUtil;
String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from bpm_inst b where status_ = ''DRAFTED'' and create_by_="+userId ;
return sql;','sql',1,NULL,NULL,NULL,NULL);

	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000011609029','#000000','/bpm/core/bpmTask/agents.do?agent=toMe',' icon-changjianyijian','我的代理','','','import com.redxun.saweb.context.ContextUtil;
String userId = ContextUtil.getCurrentUserId();
String sql="select count(*)from act_ru_task WHERE AGENT_USER_ID_=''"+userId +"''";
return sql;','sql',1,NULL,NULL,NULL,NULL);


	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000011609034','#6399fc','/oa/personal/bpmSolApply/myList.do',' icon-0802dbhtbgsq','发起审批','','','portalScript.getCountMySolList()','function',1,NULL,NULL,NULL,NULL);

	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000011679032','#76d12c','/oa/info/infInbox/receive.do',' icon-changjianyijian','我的消息','','','import com.redxun.saweb.context.ContextUtil;
String userId = ContextUtil.getCurrentUserId();
String sql="select count(m.MSG_ID_) from inf_inner_Msg m left join inf_inbox  box on m.MSG_ID_=box.MSG_ID_ where box.REC_TYPE_ = ''REC'' and box.IS_READ_ = ''no'' and box.REC_USER_ID_ ="+userId ;
return sql;','sql',1,NULL,NULL,NULL,NULL);

	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000011769008','','/oa/res/oaMeetAtt/listOameet.do',' icon-wodexiaoxi','我的会议','','','import com.redxun.saweb.context.ContextUtil;
String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from OA_MEET_ATT att where att.USER_ID_="+userId ;
return sql;','sql',1,NULL,NULL,NULL,NULL);

	 		INSERT INTO INS_MSG_DEF (MSG_ID_, COLOR_, URL_, ICON_, CONTENT_, DS_NAME_, DS_ALIAS_, SQL_FUNC_, TYPE_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
	 		values ('2400000011769009','','/sys/core/sysFile/myMgr.do',' icon-card_commodity','我的附件','','','import com.redxun.saweb.context.ContextUtil;
String userId = ContextUtil.getCurrentUserId();
String sql="select count(*) from sys_file where CREATE_BY_="+userId ;
return sql;','sql',1,NULL,NULL,NULL,NULL);


-- 23. 消息盒子管理

INSERT INTO INS_MSGBOX_DEF (BOX_ID_, COL_ID_, KEY_, NAME_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2400000007849001', '', 'msgbox', '消息盒', '1', NULL, NULL, NULL, NULL);
INSERT INTO INS_MSGBOX_DEF (BOX_ID_, COL_ID_, KEY_, NAME_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2400000008039007', '', 'baseInfo', '基础信息', '1', NULL, NULL, NULL, NULL);

-- 24. 关联表
INSERT INTO INS_MSGBOX_BOX_DEF (ID_, BOX_ID_, MSG_ID_, SN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2400000008039005', '2400000008039002', '2400000008039000', '1', '1', NULL, NULL, NULL, NULL);
INSERT INTO INS_MSGBOX_BOX_DEF (ID_, BOX_ID_, MSG_ID_, SN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000310012', '2400000007849001', '2400000011589004', '1', '1', '1', NULL, NULL, NULL);
INSERT INTO INS_MSGBOX_BOX_DEF (ID_, BOX_ID_, MSG_ID_, SN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000310013', '2400000007849001', '2400000011679032', '2', '1', '1', NULL, NULL, NULL);
INSERT INTO INS_MSGBOX_BOX_DEF (ID_, BOX_ID_, MSG_ID_, SN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000310014', '2400000007849001', '2400000011609034', '3', '1', '1', NULL, NULL, NULL);
INSERT INTO INS_MSGBOX_BOX_DEF (ID_, BOX_ID_, MSG_ID_, SN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000310015', '2400000007849001', '2400000011559007', '6', '1', '1', NULL, NULL, NULL);
INSERT INTO INS_MSGBOX_BOX_DEF (ID_, BOX_ID_, MSG_ID_, SN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000310016', '2400000007849001', '2400000011609029', '8', '1', '1', NULL, NULL, NULL);
INSERT INTO INS_MSGBOX_BOX_DEF (ID_, BOX_ID_, MSG_ID_, SN_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2520000000310017', '2400000007849001', '2400000007699002', '6', '1', '1', NULL, NULL, NULL);

			
-- 25. 流程产生单号
INSERT INTO SYS_SEQ_ID (SEQ_ID_, NAME_, ALIAS_, CUR_DATE_, RULE_, RULE_CONF_, INIT_VAL_, GEN_TYPE_, LEN_, CUR_VAL, STEP_, MEMO_, IS_DEFAULT_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) 
VALUES ('2400000001031001', '流程实例单号', 'BPM_INST_BILL_NO', to_date('2017-12-3 12:15:47','yyyy-mm-dd hh24:mi:ss'), '{yyyyMMdd}{NO}', '[{\"_id\":1,\"_uid\":1,\"_state\":\"added\",\"type\":\"{yyyyMMdd}\"},{\"_id\":2,\"_uid\":2,\"_state\":\"added\",\"type\":\"{NO}\"}]', 1, 'DAY', 5, 2, 1, '用于产生流程实例单号，由系统初始化，不允许删除', 'YES', '0', NULL, NULL, NULL, NULL);

-- 26. 考勤基础数据
INSERT INTO ATS_BASE_ITEM (ID,CODE,NAME,URL,IS_SYS,MEMO,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)values ('1', 'AST0001', '假期类型', '/oa/ats/atsHolidayType/list.do', '1', '', '1', 1, NULL, NULL, NULL);

INSERT INTO ATS_BASE_ITEM (ID,CODE,NAME,URL,IS_SYS,MEMO,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)values ('2', 'AST0002', '班次类型', '/oa/ats/atsShiftType/list.do', '1', '', '1', 1, NULL, NULL, NULL);

INSERT INTO ATS_BASE_ITEM (ID,CODE,NAME,URL,IS_SYS,MEMO,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)values ('3', 'AST0003', '日历模版', '/oa/ats/atsCalendarTempl/list.do', '1', '', '1', 1, NULL, NULL, NULL);

INSERT INTO ATS_BASE_ITEM (ID,CODE,NAME,URL,IS_SYS,MEMO,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)values ('4', 'AST0004', '法定假日', '/oa/ats/atsLegalHoliday/list.do', '1', '', '1', 1, NULL, NULL, NULL);

INSERT INTO ATS_BASE_ITEM (ID,CODE,NAME,URL,IS_SYS,MEMO,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)values ('5', 'AST0005', '工作日历', '/oa/ats/atsWorkCalendar/list.do', '1', '', '1', 1, NULL, NULL, NULL);

INSERT INTO ATS_BASE_ITEM (ID,CODE,NAME,URL,IS_SYS,MEMO,TENANT_ID_,CREATE_BY_,CREATE_TIME_,UPDATE_BY_,UPDATE_TIME_)values ('6', 'AST0006', '考勤周期', '/oa/ats/atsAttenceCycle/list.do', '1', '', '1', 1, NULL, NULL, NULL);

-- 27. 考勤模块班次类型初始化数据
INSERT INTO ATS_SHIFT_TYPE (ID, CODE, NAME, IS_SYS, STATUS, MEMO, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('1', '1', '工作日', '1', '1', '1', '1', '1', NULL, NULL, NULL);
INSERT INTO ATS_SHIFT_TYPE (ID, CODE, NAME, IS_SYS, STATUS, MEMO, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2', '2', '休息日', '1', '1', '1', '1', '1', NULL, NULL, NULL);
INSERT INTO ATS_SHIFT_TYPE (ID, CODE, NAME, IS_SYS, STATUS, MEMO, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('3', '3', '法定假日', '1', '1', '1', '1', '1', NULL, NULL, NULL);

-- 28.  自定义SQL分类
INSERT INTO sys_tree(TREE_ID_, NAME_, PATH_, DEPTH_, PARENT_ID_, KEY_, CODE_, DESCP_, CAT_KEY_, SN_, DATA_SHOW_TYPE_, CHILDS_, USER_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_) VALUES ('2610000000000020', '国家行政区', '0.2610000000000020.', 1, '', 'GJXZQ', '', '', 'CAT_CUSTOM_SQL', 1, 'FLAT', NULL, NULL, '1', '1', NULL, NULL, NULL);

-- 自定义SQL
			INSERT INTO sys_custom_query(ID_, NAME_, KEY_, TABLE_NAME_, IS_PAGE_, PAGE_SIZE_, WHERE_FIELD_, RESULT_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_DIY_, SQL_, SQL_BUILD_TYPE_, TREE_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
			VALUES ('2610000000000023','市级','CITY_LEVEL','','0','20','[{"columnType":"varchar","fieldName":"PARENT_CODE_","comment":"所属地区","valueSource":"param"}]','[{"fieldName":"AREA_CODE_","comment":"地区代码"},{"fieldName":"AREA_NAME_","comment":"地区名称"}]','','','0','String parentCode = (String)params.get("PARENT_CODE_");
String sql="select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=2  and na.parent_code_ =''"+parentCode+"''  ORDER BY na.id_ desc";
 return sql;','select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=2','sql','2610000000000020','1','1',to_date('2019-4-16','yyyy-mm-dd'),'1',to_date('2019-4-18','yyyy-mm-dd'));

			INSERT INTO sys_custom_query(ID_, NAME_, KEY_, TABLE_NAME_, IS_PAGE_, PAGE_SIZE_, WHERE_FIELD_, RESULT_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_DIY_, SQL_, SQL_BUILD_TYPE_, TREE_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
			VALUES ('2610000000000024','区级(县)','COUNTY_LEVEL','','0','20','[{"columnType":"varchar","fieldName":"PARENT_CODE_","comment":"所属地区","valueSource":"param"}]','[{"fieldName":"AREA_CODE_","comment":"地区代码"},{"fieldName":"AREA_NAME_","comment":"地区名称"}]','','','0','String parentCode = (String)params.get("PARENT_CODE_");
String sql="select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=3  and na.parent_code_ =''"+parentCode+"''  ORDER BY na.id_ desc";
 return sql;','select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=3','sql','2610000000000020','1','1',to_date('2019-4-16','yyyy-mm-dd'),'1',to_date('2019-4-18','yyyy-mm-dd'));

			INSERT INTO sys_custom_query(ID_, NAME_, KEY_, TABLE_NAME_, IS_PAGE_, PAGE_SIZE_, WHERE_FIELD_, RESULT_FIELD_, ORDER_FIELD_, DS_ALIAS_, TABLE_, SQL_DIY_, SQL_, SQL_BUILD_TYPE_, TREE_ID_, TENANT_ID_, CREATE_BY_, CREATE_TIME_, UPDATE_BY_, UPDATE_TIME_)
			VALUES ('2610000000000111','省级(自治区/直辖市)','PROVINCE_LEVEL','','0','20','','[{"fieldName":"AREA_CODE_","comment":"地区代码"},{"fieldName":"AREA_NAME_","comment":"地区名称"}]','','','0','String sql="select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=1";
 return sql;','select na.* from SYS_NATION_AREA na where na.AREA_LEVEL_=1','sql','2610000000000020','1','1',to_date('2019-4-16','yyyy-mm-dd'),'1',to_date('2019-4-18','yyyy-mm-dd'));

 commit;
