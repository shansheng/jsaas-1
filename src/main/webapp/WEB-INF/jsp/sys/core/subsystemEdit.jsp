<%-- 
    Document   : 子系统编辑页
    Created on : 2015-3-21, 0:11:48
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>子系统编辑</title>
<%@include file="/commons/edit.jsp"%>
  <script src="${ctxPath}/scripts/share/dialog.js" type="text/javascript"></script>
  <style type="text/css">
  	body .table-detail .mini-button .mini-button-icon{
		display:inline-block;
	}
	.table-detail .mini-button .mini-button-icon-only {
	    padding-left: 14px;
	}
	#icnClsBtn.mini-button .mini-button-icon-only .mini-button-icon{
		left: 0;
	}
  </style>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="${subsystem.sysId}"/>
	<div class="mini-fit">
		<div id="p1" class="form-container">
			<form id="form1" method="post">
				<input id="pkId" name="pkId" class="mini-hidden" value="${subsystem.sysId}" />
					<table  class="table-detail column-four" cellpadding="0" cellspacing="1">
						<caption>子系统基本信息</caption>
						<tr>
							<td>
								<span class="starBox">
									系统名称<span class="star">*</span>
								</span>
							</td>
							<td><input name="name"
									   value="${subsystem.name}"
									   class="mini-textbox" required="true" vtype="maxLength:80" emptyText="请输入系统名称" style="width:100%"/></td>

							<td>
								<span class="starBox">
									系统 Key<span class="star">*</span>
								</span>
							</td>
							<td>
								<input name="isDefault" type="hidden"   value="YES" />
								<input name="key" value="${subsystem.key}"
								   class="mini-textbox" required="true"
								   vtype="maxLength:64" emptyText="请输入系统Key" style="width:100%"/></td>
						</tr>


						<tr>
							<td>类型</td>
							<td >
								<div name="type" class="mini-radiobuttonlist"
									textField="text"
									valueField="id"
									style="width: 100%"
									value="${subsystem.type}"
									data="[{id:'inner',text:'内部子系统'},{id:'external',text:'外部子系统'}]" >
								</div>
							</td>
							<td>
								<span class="starBox">
									状　　态 <span class="star">*</span>
								</span>
							</td>
							<td>
								<div name="status" class="mini-radiobuttonlist" value="${subsystem.status}" required="true" repeatDirection="vertical"
								  repeatLayout="table" url="${ctxPath}/dics/commons/enable_status.txt" textField="text" valueField="id"
									 vtype="maxLength:20"></div>
							</td>
						</tr>
						<tr>
							<td>图标样式</td>
							<td>
								<input name="iconCls" id="iconCls" text="${subsystem.iconCls}"  value="${subsystem.iconCls}" class="mini-buttonedit" onbuttonclick="selectIcon" style="width:80%"/>
								<a class="mini-button MyBlock" id="icnClsBtn" iconCls="${subsystem.iconCls}"></a>
							</td>
							<td>序　　号</td>
							<td><input name="sn" value="${subsystem.sn}"
									   class="mini-spinner" minValue="0"
									   maxValue="1000"
									   style="width: 100%"
								/>
							</td>
						</tr>


						<tr>
							<td>AppId</td>
							<td >
								${subsystem.sysId}
							</td>
							<td>密钥</td>
							<td >
								<input name="secret" class="mini-textbox" value="${subsystem.secret}"  style="width:50%" >
								<a name="btnGen" class="mini-button"  onclick="genSecret()" >生成密钥</a>
							</td>
						</tr>

						<tr>
							<td>URL</td>
							<td colspan="3">
								<input name="homeUrl" class="mini-textbox" value="${subsystem.homeUrl}" style="width:100%" />
							</td>
						</tr>
						<tr>
							<td>描　　述</td>
							<td colspan="3">
								<textarea rows="3" cols="60"
										  class="mini-textarea"
										  vtype="maxLength:256"
										  name="descp" style="width:100%"
								>${subsystem.descp}</textarea>
							</td>
						</tr>
					</table>
			</form>
		</div>
	</div>
	<rx:formScript formId="form1" baseUrl="sys/core/subsystem" />
	<script type="text/javascript">
	
		function genSecret(){
			var url=__rootPath +"/sys/core/subsystem/genSecret.do";
			$.get(url,function(rtn){
				mini.getByName("secret").setValue(rtn);
			})
		}
		$(function(){
			
		});
		
		function selectIcon(e){
			 var btn=e.sender;
			 _IconSelectDlg(function(icon){
					//grid.updateRow(row,{iconCls:icon});
					btn.setText(icon);
					btn.setValue(icon);
					mini.get('icnClsBtn').setIconCls(icon);
				});
		}
	</script>
</body>
</html>