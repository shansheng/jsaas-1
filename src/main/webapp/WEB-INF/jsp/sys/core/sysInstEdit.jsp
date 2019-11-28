<%-- 
    Document   : 租用机构编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
    <head>
        <title>租用机构编辑</title>
        <%@include file="/commons/edit.jsp" %>   
    </head>
    <body>
    <div class="topToolBar">
		<div>
	        <a class="mini-button" plain="true" onclick="onOk">保存</a>
	        <c:if test="${sysInst.status=='APPROVED' || sysInst.status=='INIT'}">
		          <a style="" class="mini-button" iconCls="icon-unlock"  onclick="pass(${sysInst.instId})">开通</a>
		    </c:if>
		</div>
	</div>
    <div class="mini-fit">
        <div class="form-container">
                <form id="form1" method="post">
                    <input id="pkId" name="pkId" class="mini-hidden" value="${sysInst.instId}"/>
                    <table class="table-detail column-four" cellspacing="1" cellpadding="0">
                        <caption>机构基本信息</caption>
                         <tr>
                             <td>
                                 机构中文名<span class="star">*</span>
                            </td>
                             <td>
                                 <input name="nameCn" value="${sysInst.nameCn}" class="mini-textbox" required="true" vtype="maxLength:256" emptyText="请输入机构中文名" style="width:100%"/>
                             </td>
                             <td>
                                 机构英文名<span class="star">*</span>
                            </td>
                             <td>
                                 <input name="nameEn" value="${sysInst.nameEn}" class="mini-textbox" required="true" vtype="maxLength:256" emptyText="请输入机构英文名" style="width:100%"/>
                             </td>
                         </tr>
                         <tr>
                             <td>
                                 组织机构代码<span class="star">*</span>
                            </td>
                             <td>
                                 <input name="instNo" value="${sysInst.instNo}" class="mini-textbox" required="true" emptyText="请输入组织机构代码" vtype="maxLength:50" style="width:100%"/>
                             </td>
                            <td>
                                营业执照代码<span class="star">*</span>
                            </td>
                             <td>
                                 <input name="busLiceNo" value="${sysInst.busLiceNo}" class="mini-textbox" required="true" emptyText="请输入营业执照代码" vtype="maxLength:50" style="width:100%"/>
                             </td>
                         </tr>
                         <tr>
                            <td>上级机构</td>
                            <td colspan="3">
                                <input class="mini-buttonedit" name="parentId"  onbuttonclick="onSelParentInst"  value="${parentInst.instId}"
                                text="${parentInst.nameCn}" oncloseclick="onCloseClick(e)" >
                            </td>
                         </tr>
                         <tr>
                            <c:if test="${sysInst.instId==null}">
                            <td>
                                机构域名<span class="star">*</span>
                            </td>
                             <td>
                                 <input name="domain" value="${sysInst.domain}" class="mini-textbox" required="true" vtype="maxLength:100" style="width:100%"/>
                             </td>
                             </c:if>
                             <td>
                                机构法人<span class="star">*</span>
                             </td>
                             <c:if test="${sysInst.instId!=null}">
                             <td colspan="3">
                             </c:if>
                             <c:if test="${sysInst.instId==null}">
                             <td>
                             </c:if>
                                 <input name="legalMan" value="${sysInst.legalMan}" class="mini-textbox" required="true" vtype="maxLength:64" style="width:100%"/>
                             </td>
                         </tr>

                         <tr>
                             <td>机构简称(中文)</td>
                             <td>
                                 <input name="nameCnS" value="${sysInst.nameCnS}" class="mini-textbox" vtype="maxLength:80" style="width:100%"/>
                             </td>
                             <td>机构简称(英文)</td>
                             <td>
                                <input name="nameEnS" value="${sysInst.nameEnS}" class="mini-textbox" vtype="maxLength:80" style="width:100%"/>
                             </td>
                         </tr>
                         <tr>
                            <td>机构类型</td>
                            <td>
                                <c:choose>
                                    <c:when test="${sysInst.instType=='PLATFORM'}">
                                        平台机构
                                    </c:when>
                                    <c:otherwise>
                                        <input class="mini-combobox" name="instType"
                                               value="${sysInst.instType}"
                                               url="${ctxPath}/sys/core/sysInstType/getAllValids.do?excludePlatform=true"
                                               textField="typeName" valueField="typeCode" style="width: 80%"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                             <td>数  据  库</td>
                             <td >
                                <input name="dsName" value="${sysInst.dsName}" class="mini-textbox" vtype="maxLength:80" style="width:100%"/>
                             </td>
                         </tr>
                          <tr>
                             <td>组织机构图片</td>
                             <td colspan="3">
                                 <input id="regCodeFileId" name="regCodeFileId" value="${sysInst.regCodeFileId}" class="mini-hidden" />
                                 <img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=${sysInst.regCodeFileId}" class="upload-file"/>
                             </td>
                         </tr>
                          <tr>
                             <td>
                                营业执照图片
                             </td>
                             <td colspan="3">
                                 <input id="busLiceFileId" name="busLiceFileId" value="${sysInst.busLiceFileId}" class="mini-hidden" />
                                 <img src="${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=${sysInst.busLiceFileId}" class="upload-file"/>
                             </td>
                         </tr>
                         <tr>
                             <td>机构描述</td>
                             <td colspan="3">
                                 <textarea id="descp" name="descp" class="mini-textarea" vtype="maxLength:2147483647" style="width:100%">${sysInst.descp}</textarea>
                             </td>
                         </tr>
                     </table>

                   <table class="table-detail column-four" cellpadding="0" cellspacing="1">
                       <caption>联系信息</caption>
                       <tr>
                           <td>
                               联  系  人<span class="star">*</span>
                           </td>
                           <td>
                               <input name="contractor" value="${sysInst.contractor}" class="mini-textbox" vtype="maxLength:30"  required="true" style="width:100%"/>
                           </td>
                           <td>
                                <span class="starBox">
                                    邮　　箱<span class="star">*</span>
                                </span>
                           </td>
                           <td>
                               <input name="email" class="mini-textbox" vtype="email;rangeLength:5,255" value="${sysInst.email}"  required="true" style="width:100%"/>
                           </td>
                       </tr>
                       <tr>
                           <td>
                                <span class="starBox">
                                    电　　话<span class="star">*</span>
                                </span>
                            </td>
                           <td >
                               <input name="phone" value="${sysInst.phone}" class="mini-textbox" vtype="maxLength:30"  required="true" style="width:100%"/>
                           </td>
                           <td>传　　真</td>
                           <td>
                               <input name="fax" value="${sysInst.fax}" class="mini-textbox" vtype="maxLength:30" style="width:100%"/>
                           </td>
                       </tr>
                       <tr>
                           <td>地　　址</td>
                           <td colspan="3">
                               <input name="address" value="${sysInst.address}" class="mini-textbox" vtype="maxLength:128" style="width:100%"/>
                           </td>
                       </tr>
                   </table>

            </form>
            </div>
    </div>
       <rx:formScript formId="form1" baseUrl="sys/core/sysInst" entityName="com.redxun.sys.core.entity.SysInst"/>
       <script type="text/javascript">
       		addBody();
	       $(function(){
				/**-- 用于上传图片 **/
	    	   $(".upload-file").on('click',function(){
					var img=this;
					_UserImageDlg(true,
						function(imgs){
							if(imgs.length==0) return;
							$(img).attr('src','${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId='+imgs[0].fileId);
							$(img).siblings('input[type="hidden"]').val(imgs[0].fileId);
							var id=$(img).siblings('input[type="hidden"]').attr('id');
							mini.get(id).setValue(imgs[0].fileId);
						}
					);
				});	
			});
	       
	       function pass(pkId){
	    	   form.validate();
	           if (!form.isValid()) {
	               return;
	           }
	           
	           var formData=$("#form1").serializeArray();
	           var extJson=_GetExtJsons("form1");
	           for(var key in extJson){
	           	formData.push({name:key,value:extJson[key]});
	           }
	           if(tenantId!=''){
	   	        formData.push({
	   	        	name:'tenantId',
	   	        	value:tenantId
	   	        });
	           }
	       		_SubmitJson({
	       			url:'${ctxPath}/sys/core/sysInst/pass.do',
	       			data:formData,
	       			method:'POST',
	       			success:function(result){
	       				//如果存在自定义的函数，则回调
	            		if(isExitsFunction('successCallback')){
	            			successCallback.call(this,result);
	            			return;	
	            		}
	            		CloseWindow('ok');
	       			}
	       		});
       		}
	       
	       function onDataSourceEdit(e){
	    	   var btnEdit=e.sender;
	    	   _CommonDialogExt({dialogKey:"dataSourceDialog",title:"选择数据源",ondestroy:function(data){
	    		   var row=data.rows[0];
	    		   btnEdit.setText(row.NAME_);
	    		   btnEdit.setValue(row.ALIAS_);
	    	   }})
	       }
	       
		   //清除控件值
		   function onCloseClick(e){
			   var btn=e.sender;
			   btn.setText('');
			   btn.setValue('');
		   }
		   
		   function onSelParentInst(e){
		   	var btn=e.sender;
		   	_OpenWindow({
		   		title:'机构选择',
		   		height:450,
		   		width:800,
		   		url:__rootPath+'/sys/core/sysInst/dialog.do?single=true',
		   		ondestroy:function(action){
		   			if(action!='ok'){
		   				return;
		   			}
		   			
		   			var win=this.getIFrameEl().contentWindow;
					var data=win.getData();
					if(data.length==1){
						btn.setValue(data[0].instId);
						btn.setText(data[0].nameCn);
					}
		   		}
		   	});
		   }
		</script>
    </body>
</html>
