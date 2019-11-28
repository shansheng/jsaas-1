<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/commons/edit.jsp"%>
<script type="text/javascript" src="${ctx}/js/platform/util/customUtil.js"></script>

<script type="text/javascript">
	$(function(){
		//初始化
		setVote(1);
		
		var frm = $('#transForm').form();
		$(".fa-save").click(function() {
			if(!frm.valid() || !$("#receiverId").val()) {
				$.topCall.error("请选择人员和填写通知内容"); 
				return;
			}
			$.topCall.confirm("提示信息", '你确定要流转当前任务吗？', function(r){
				if(r){
					frm.ajaxForm({success:showResponse});
					if (frm.valid()) {
						$('#transForm').submit(); 
					}
				}
			});
		});
		
	});
	function showResponse(responseText) {
		var data = JSON.parse(responseText);
		var script = "var tempFunction = function(data){ "+window.parent.curent_btn_after_script_+"};"
		var afterScriptPassed =  eval(script+"tempFunction(data);");				
		var resultMessage=new com.hotent.form.ResultMessage(responseText);
		if(resultMessage.isSuccess()){
			$.topCall.success(resultMessage.getMessage(),function(){
			    try{
			       window.parent.opener.refreshTargetGrid("grid");
			       if(afterScriptPassed!==false){
			    	   window.parent.close();
			       }
			    }
			    catch(err){
				  window.close();
			    }
			});
		}else{
			$.topCall.error(resultMessage.getMessage(),resultMessage.getCause()); 
		}
	}
	
	function toHidden(hidden){
		$(".hight").each(function(i){
			hidden?$(this).hide():$(this).show();
		});
	}
	
	
		
	/**
	* 1.全票通过
	*  2.一票否决
	*  3.一票通过
	*  4.自定义
	*/
	function setVote(type){
		var hide=(type!=4);
		toHidden(hide);
		
		setDecideType(type);
		//
		setVoteType(type);
		//设置票数
		setAmount(type);
	    
	}
	
	//设定决策类型
	function setDecideType(type){
		
		switch(type){
			case 1:
			case 3:
				setRadioChecked("decideType","agree");
				break;
			case 2:
				setRadioChecked("decideType","refuse");
				break;
		}
	}
	
	//投票类型
	function setVoteType(type){
		// percent amount
		switch(type){
			case 1:
				setRadioChecked("voteType","percent");
				break;
			case 2:
			case 3:
				setRadioChecked("voteType","amount");
				break;
		}
	}
	
	function setAmount(type){
		// percent amount
		//voteAmount
		var obj=$("#voteAmount");
		var objLabel=$("#voteAmountUnit");
		switch(type){
			case 1:
				obj.val(100);
				objLabel.show();
				break;
			case 2:
			case 3:
				obj.val(1);
				objLabel.hide();
				break;
		}
	}
	
	
	
	function setRadioChecked(name,ckValue){
		var id=name +"_" + ckValue;
		document.getElementById(id).checked =true;
	}
	
	
	
	function voteTypeChange(e){
		if($(e).val()=="amount"){
			$("#voteAmountUnit").hide();
		}
		else{
			$("#voteAmountUnit").show();
		}
	}
	
	function selectUsers(){
		var initData=[];
		var ids=$("#receiverId").val();
		var names=$("#receiver").val();
		if(names!=""){
			var arrName=names.split(',');
			var arrId=ids.split(',');
			$.each(arrName,function(index,item){
				initData.push({name:item,id:arrId[index]})
			})
		}
		
		var callBack =function(data,dialog){
			if(data==null||data.length<=0){
				dialog.dialog('close');
				return false;
			}
			var arrId=[];
			var arrText=[];
			$.each(data,function(index,item){
				arrId.push(item.id);
				arrText.push(item.name);
			})
			$("#receiverId").val(arrId.toString());
			$("#receiver").val(arrText.toString());
			dialog.dialog('close');
	    };
		CustomDialog.openCustomDialog("userSelector",callBack,{
			initData:initData,
			selectNum:-1
		});
		 
	}
</script>

</head>
<body >
	<div>
		<div class="toolbar-panel">
			<div class="buttons" >
				<a  href="#" class="btn btn-primary fa fa-save">确定</a>
				<a href="#" onClick="javascript:window.selfDialog.dialog('close');" class="btn btn-default fa fa-close">取消</a>
			</div>
		</div> 
		<form id="transForm" action="saveTrans" method="post">
		<table cellspacing="0" class="table-form">
			<tr> 
				<th width="23%">
					<abbr ht-tip title="例如:需要所选流传人员半数以上同意,或者一票否决等规则">任务通过规则：</abbr>
		 		</th>
				<td colspan="3">						
					<label class="radio-inline">
						<input type="radio" name="type" checked="checked" onClick="setVote(1)"/>全票通过
					</label>
					<label class="radio-inline">
						<input type="radio" name="type" id="type2" onClick="setVote(2)"/>一票否决
					</label>
					<label class="radio-inline">
						<input type="radio" name="type"  value="agree"  onclick="setVote(3)"/>一票同意
					</label>
					<label class="radio-inline">
						<input type="radio" name="type"  value="custom"  onclick="setVote(4)"/>自定义
					</label>
				
				</td>
			</tr>
			<tr class="hight" hidden="true">
				<th>
					<abbr class="pull-right" ht-tip 
						  title="例如: 计票策略为 同意票，投票类型<br/>
						  		为绝对票数，票数为3.<br/>
								则当流转的任务有三个人同意时，流转<br/>
								的任务通过，并结束。">计票策略：</abbr>
				</th>
				<td colspan="3">
					<label class="radio-inline">
						<input type="radio" name="decideType" id="decideType_agree" value="agree" validate="{required:true}" checked="checked"/>同意票
					</label>
					<label class="radio-inline">
						<input type="radio" name="decideType" id="decideType_refuse"  value="refuse" validate="{required:true}"/>否决票
					</label>
				</td>
			</tr>
			<tr class="hight" hidden="true"> 
				<th><span class="pull-right">投票类型：</span></th>
				<td>
					<label class="radio-inline">
						<input type="radio" value="amount" id="voteType_amount"  onClick="voteTypeChange(this)" name="voteType" validate="{required:true}"/>绝对票数
					</label>
					<label class="radio-inline">
						<input type="radio"  value="percent" id="voteType_percent"   onclick="voteTypeChange(this)" name="voteType" checked="checked" validate="{required:true}"/>百分比
					</label>
				</td>
				<th ><span class="pull-right">票数：</span></th>
				<td>
					<input type="text" name="voteAmount" id="voteAmount" value="1" size="5" validate="{required:true,number:true}">
					<span id="voteAmountUnit">%</span>
				</td>
			</tr>
 			<tr> 
				<th>流转类型：</th>
				<td>
					<label class="radio-inline">
						<input type="radio" name="signType" value="parallel" validate="{required:true}" checked="checked" />并行
					</label>
					<label class="radio-inline">
						<input type="radio" name="signType" value="seq" validate="{required:true}" />串行
					</label>
				</td>
				<th>完成后的动作： </th>
				<td>
					<label class="radio-inline">
						<input type="radio" name="action" value="submit" validate="{required:true}" checked="checked"/>提交
					</label>
					<label class="radio-inline">
						<input type="radio" name="action" value="back" validate="{required:true}"/>返回
					</label>
				</td>
			</tr>
			<tr>
				<th>通知方式：</th>
				<td colspan="3">	
					<c:forEach items="${handlerList}" var="model">
						<label class="checkbox-inline">
							<input type="checkbox" name="notifyType"  value="${model.type}" <c:if test="${ model.isDefault}">checked='checked'</c:if> />${model.title}
						</label>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>流转人员：</th>
				<td colspan="3" >
					<textarea  id="receiver" rows="2" cols="50" style="width: 270px; height:27px;margin:5px" readonly validate="{required:true}" ><%-- <c:forEach items="${commuReceivers}" var="recever">${recever.receiver},</c:forEach> --%></textarea>
					<input type="hidden" id="receiverId" name="receiverIds" value=""><%-- <c:forEach items="${commuReceivers}" var="recever">${recever.receiverId},</c:forEach> --%>
					<a onClick="selectUsers()" class="btn btn-sm fa-add">选择人员</a>
				</td>
			</tr>
			<tr> 
				<th><span>通知内容：</span></th>
				<td colspan="3" >
					<textarea class="inputText" name="opinion" rows="4"   cols="50" style="width: 300px;" validate="{required:true}"></textarea>
				</td>
			</tr>
			</table>
			<input type="hidden" name="taskId" value="${taskId}">
		</form> 
		</div>
	</div>
</body>
</html>