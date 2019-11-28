<%-- 
    Document   : 租用机构管理
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <title>租用机构明细</title>
  <%@include file="/commons/get.jsp"%>
        <style>
            .table-detail tr td:nth-child(odd){
                text-align: center;
            }
            body{
                border-top: 1px solid transparent;
                box-sizing: border-box;
            }
        </style>
    </head>
    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
<div style="height: 10px"></div>
<div class="mini-fit">
        <div id="form1" class="form-container">
             <div >
                    <table style="width:100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
                    	<caption>机构基本信息</caption>
                        <tr>
                            <td>机构中文名</td>
                            <td>    
                                ${sysInst.nameCn}
                            </td>
                            <td>机构英文名</td>
                            <td>    
                                ${sysInst.nameEn}
                            </td>
                        </tr>
                        <tr>
                            <td>组织机构编号</td>
                            <td>    
                                ${sysInst.instNo}
                            </td>
                            <td>营业执照编号</td>
                            <td>    
                               ${sysInst.busLiceNo}
                            </td>
                        </tr>
                        <tr>
                        	<td>
                        		机构域名
                        	</td>
                        	<td>
                        		${sysInst.domain}
                        	</td>
                        	 <td>机构法人</td>
                            <td>    
                               ${sysInst.legalMan}
                            </td>
                        </tr>
                        <tr>
                            <td>机构简称(中文)</td>
                            <td>    
                                ${sysInst.nameCnS}
                            </td>
                            <td>机构简称(英文)</td>
                            <td>${sysInst.nameEnS}</td>
                        </tr>
                        <tr>
                        	<td>组织机构附件</td>
                        	<td colspan="3">
                        		<img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&view=true&fileId=${sysInst.regCodeFileId}" class="view-img" id="${sysInst.regCodeFileId}"/>
                        	</td>
                        </tr>
                        <tr>
                        	<td>营业执照附件</td>
                        	<td colspan="3">
                        		<img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&view=true&fileId=${sysInst.busLiceFileId}" class="view-img" id="${sysInst.busLiceFileId}"/>
                        	</td>
                        </tr>
                        <tr>
                            <td>机构描述</td>
                            <td colspan="3">    
                               ${sysInst.descp}
                            </td>
                        </tr>
                    </table>
                 </div>

                <table class="table-detail column-four" cellpadding="0" cellspacing="1">
                    <caption>联系信息</caption>
                    <tr>
                        <td>联  系  人</td>
                        <td>
                            ${sysInst.contractor}
                        </td>
                        <td>邮　　箱</td>
                        <td >
                            ${sysInst.email}
                        </td>
                    </tr>
                    <tr>
                        <td>电　　话</td>
                        <td>
                            ${sysInst.phone}
                        </td>
                        <td>传　　真</td>
                        <td>
                           ${sysInst.fax}
                        </td>
                    </tr>
                    <tr>
                        <td>地　　址</td>
                        <td colspan="3">
                            ${sysInst.address}
                        </td>
                    </tr>
                </table>


				 <table class="table-detail column-four" cellpadding="0" cellspacing="1">
				 	<caption>更新信息</caption>
					<tr>
						<td>创  建  人</td>
						<td ><rxc:userLabel userId="${sysInst.createBy}"/>&nbsp;</td>
						<td>创建时间</td>
						<td><fmt:formatDate value="${sysInst.createTime}" pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<td>更  新  人</td>
						<td><rxc:userLabel userId="${sysInst.updateBy}"/></td>
						<td>更新时间</td>
						<td><fmt:formatDate value="${sysInst.updateTime}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</table>

        	</div>
</div>
        <rx:detailScript baseUrl="sys/core/sysInst" formId="form1" entityName="com.redxun.sys.core.entity.SysInst"/>
        <script type="text/javascript">
        	addBody();
        	$(function(){
        		//$(".view-img").css('cursor','pointer');
        		$(".view-img").on('click',function(){
        			var fileId=$(this).attr('id');
        			if(fileId=='')return;
        			_ImageViewDlg(fileId);
        		});
        	});
        </script>
    </body>
</html>
