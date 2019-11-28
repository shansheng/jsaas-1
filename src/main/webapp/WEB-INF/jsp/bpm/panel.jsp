<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>流程模块快速入口 </title>
<%@include file="/commons/get.jsp"%>
<link href="${ctxPath}/scripts/miniui/themes/bootstrap/skin.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.container{
		padding-top: 20px;
	}

	.container .mini-panel{
	     width:98% !important;
	     margin:0 auto 20px auto;
	}
	
	.menuItem > span{
		float: left;
		width:100%;
		margin: 14px 0 0;
		text-align: center;
		color: #666;
		font-size: 16px;
	}
	.menuItem > span.span-icon{
		margin-top: 24px;
	}
	.menuItem > span:before{
		font-size: 60px;
	}
	
	.menuItem > span>i{
		float: left;
		width: 100%;
		text-align: center;
	}
	
	.menuItem{
		float: left;
		width: 130px;
		height: 120px;
		margin: 5px;
		padding-top: 10px;
		text-align: center;
		cursor: pointer;
		border-radius: 10px;
		background: #fff;
		position:relative;
		border: 1px solid #ececec;
	    margin-right: 10px;
	}	
	
	.mini-panel-viewport{
		/*border-radius: 0 0 8px 8px ;*/
	}
	
	.mini-panel-header-inner{
		padding:0;
	}
	
	.mini-panel-header-inner .mini-panel-title{
		text-align: left;
		line-height: 50px;
		font-size: 20px;
		font-weight: 200;
		padding-left: 20px;
		width:100%;
		color:#3a82fa;
	/*	background: #29A5BF;*/
		background: #fff;
		border-bottom: 1px solid #ddd;
	}
	
	.menuItem a{
		font-size:14px;
	}
	
	.menuItem{
		box-shadow: none;
		transition: box-shadow .3s;
	}
	
	.menuItem:hover{
		box-shadow: 0 6px 18px 2px #e0e5e7;
		border-color: transparent;
	}	
	
	.mini-panel-border,
	.mini-panel-header{
		border: none;
	}
	
	.mini-panel-body{
		padding: 10px;
		border-top: none;
	}
	.iconfont.icon-flow-design-50{color: #ec551f;}
	.iconfont.icon-form-edit-50{color:#878ef2 ;}
	.iconfont.icon-mobile-50{color: #1ad2cb;}
	.iconfont.icon-user-org-50{color: #fe9639;}
	.iconfont.icon-solution-50{color: #3a82fa;}
	.iconfont.icon-grant-50{color: #ffba42;}
	.iconfont.icon-card_Dept{color:#2eaeff ;}
	.iconfont.icon-form-sol-50{color:#ec551f ;}
	.iconfont.icon-list-50{color:#878ef2 ;}
	.iconfont.icon-dialog-50{color:#fe9639 ;}
	.iconfont.icon-search-50{color:#2eaeff ;}
	.iconfont.icon-seq-no-50{color: #76d12c;}
	.iconfont.icon-book-50{color:#ffba42 ;}
	.iconfont.icon-database-50{color:#6399fc ;}
	.iconfont.icon-bpm-inst-50{color:#1ad2cb ;}
	.iconfont.icon-bpm-task-50{color: #3a82fa;}
	/*	#ec551f
        #878ef2
        #fe9639
        #2eaeff
        #76d12c
        #ffba42
        #6399fc
        #1ad2cb
        #3a82fa
        */
</style>
</head>
<body>
	 <div class="container">
        <div class="mini-clearfix">
			<div class="mini-panel" title="业务设计入口" height="auto">
		            <div class="menuItem link" url="${ctxPath}/bpm/core/bpmDef/list.do">
						<span class="iconfont icon-flow-design-50  span-icon"></span>
						<span>流程定义设计</span>
					</div>
					<div class="menuItem link" url="${ctxPath}/bpm/form/bpmFormView/list.do">
						<span class="iconfont icon-form-edit-50  span-icon"></span> 
						<span><a>流程表单设计</a></span>
					</div>
					<div class="menuItem link" url="${ctxPath}/bpm/form/bpmMobileForm/list.do">
						<span class="iconfont icon-mobile-50  span-icon"></span> 
						<span><a>手机表单设计</a></span>
					</div>
					<div class="menuItem link" url="${ctxPath}/sys/org/sysOrg/mgr.do">
						<span class="iconfont icon-user-org-50  span-icon"></span> 
						<span><a>组织架构设计</a></span>
					</div>
					<div class="menuItem link" url="${ctxPath}/bpm/core/bpmSolution/list.do">
						<span class="iconfont icon-solution-50 span-icon"></span> 
						<span><a>流程方案设计</a></span>
					</div>
					<div class="menuItem link" url="${ctxPath}/bpm/core/bpmAuthSetting/list.do">
						<span class="iconfont icon-grant-50  span-icon"></span> 
						<span><a>流程方案授权</a></span>
					</div>
					
					<div class="menuItem link" url="${ctxPath}/sys/bo/sysBoEnt/list.do">
						<span class="iconfont icon-card_Dept span-icon"></span>
						<span><a>业务实体管理</a></span>
					</div>
					 
        	</div>
       
        	 <div class="mini-panel " title="功能辅助入口" width="auto" height="auto">
        	 	<div class="menuItem link" url="${ctxPath}/sys/customform/sysCustomFormSetting/list.do">
					<span class="iconfont icon-form-sol-50 span-icon"></span> 
					<span><a>表单方案设计</a></span>
				</div>
               <div class="menuItem link" url="${ctxPath}/sys/core/sysBoList/list.do">
				<span class="iconfont icon-list-50  span-icon"></span> 
					<span><a>业务列表设计</a></span>
				</div>
				<div class="menuItem link" url="${ctxPath}/sys/core/sysBoList/dialogs.do">
					<span class="iconfont icon-dialog-50  span-icon"></span> 
					<span><a>对话框设计</a></span>
				</div>
				<div class="menuItem link" url="${ctxPath}/sys/db/sysSqlCustomQuery/list.do">
					<span class="iconfont icon-search-50  span-icon"></span> 
					<span><a>查询设计</a></span>
				</div>
				<div class="menuItem link" url="${ctxPath}/sys/core/sysSeqId/list.do">
					<span class="iconfont icon-seq-no-50 span-icon"></span> 
					<span><a>流水号设计</a></span>
				</div>
				<div class="menuItem link" url="${ctxPath}/sys/core/sysDic/mgr.do">
					<span class="iconfont icon-book-50 span-icon"></span> 
					<span><a>数据字典设计</a></span>
				</div>
				<div class="menuItem link" url="${ctxPath}/sys/core/sysDataSource/list.do">
					<span class="iconfont icon-database-50  span-icon"></span> 
					<span><a>数据源设计</a></span>
				</div>
				 <div class="menuItem link" url="${ctxPath}/bpm/core/bpmInst/list.do">
					<span class="iconfont icon-bpm-inst-50  span-icon"></span>
					<span><a>流程实例管理</a></span>
				</div>
				<div class="menuItem link" url="${ctxPath}/bpm/core/bpmTask/list.do">
					<span class="iconfont icon-bpm-task-50  span-icon"></span> 
					<span><a>待办管理</a></span>
				</div>
             </div>
	   </div>
	</div>
<script type="text/javascript">
			mini.parse();
			$(function(){
				$("div.menuItem").on('click',function(){
					var url=$(this).attr('url');
					var title=$(this).children('span:nth-child(2)').text();
					
					_OpenWindow({
						openType:'NewWin',
						title:title,
						url:url,
						height:500,
						width:800,
						max:true
					});
				});
			});
			
			
			
			$(".menuItem")
				.mouseenter(function(){
					$(this).stop(true,true).animate({top:-2},100)
				})
				.mouseleave(function(){
					$(this).stop(true,true).animate({top:0},100)
			});
</script>	
</body>
</html>
