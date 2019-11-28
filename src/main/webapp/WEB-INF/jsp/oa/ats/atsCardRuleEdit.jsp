
<%-- 
    Document   : [取卡规则]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[取卡规则]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsCardRule.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsCardRule.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[取卡规则]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsCardRule.code}"
							class="mini-textbox"    />
						</td>
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsCardRule.name}"
							class="mini-textbox"    />
						</td>
					</tr>
					<tr>
						<td>上班取卡提前(小时)：</td>
						<td>
							
								<input name="startNum" value="${atsCardRule.startNum}"
							class="mini-textbox"    />
						</td>
						<td>下班取卡延后(小时)：</td>
						<td>
							
								<input name="endNum" value="${atsCardRule.endNum}"
							class="mini-textbox"    />
						</td>
					</tr>
					<tr>
						<td>最短取卡间隔(分钟）：</td>
						<td>
							
								<input name="timeInterval" value="${atsCardRule.timeInterval}"
							class="mini-textbox"    />
						</td>
						<td>适用段次：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="segmentNum"
							data="[{id:'1',text:'一段'},{id:'2',text:'二段'},{id:'3',text:'三段'}]"
							value="${atsCardRule.segmentNum==null?1:atsCardRule.segmentNum}"
							onvaluechanged="onSegmentNumValue"
						/>
						</td>
					</tr>
					<tr>
						<td>是否默认：</td>
						<td colspan="3">
							<input value="${atsCardRule.isDefault}"
							class="mini-checkbox" onvaluechanged="onIsDefaultvaluechanged" />
							<input id="isDefault" name="isDefault" class="mini-hidden" value="${atsCardRule.isDefault}" />
						</td>
					</tr>
					<tr>
						<td>第一次上班取卡范围开始时数：</td>
						<td>
							
								<input name="segBefFirStartNum" value="${atsCardRule.segBefFirStartNum}"
							class="mini-textbox"    />
						</td>
						<td>第一次上班取卡范围结束时数：</td>
						<td>
							
								<input name="segBefFirEndNum" value="${atsCardRule.segBefFirEndNum}"
							class="mini-textbox"    />
						</td>
					</tr>
					<tr>
						<td>第一次上班取卡方式：</td>
						<td colspan="3">
							<input 
							class="mini-combobox" 
							name="segBefFirTakeCardType"
							data="[{id:'1',text:'该段最早卡'},{id:'2',text:'该段最晚卡'}]"
							value="${atsCardRule.segBefFirTakeCardType==null?1:atsCardRule.segBefFirTakeCardType}"
							
						/>
						</td>
					</tr>
					<tr class="two">
						<th>第二次上班取卡范围开始时数：</th>
						<td>
							
								<input name="segBefSecStartNum" value="${atsCardRule.segBefSecStartNum}"
							class="mini-textbox"    />
						</td>
						<td>第二次上班取卡范围结束时数：</td>
						<td>
							
								<input name="segBefSecEndNum" value="${atsCardRule.segBefSecEndNum}"
							class="mini-textbox"    />
						</td>
					</tr>
					<tr class="two">
						<th>第二次上班取卡方式：</th>
						<td colspan="3">
							<input 
							class="mini-combobox" 
							name="segBefSecTakeCardType"
							data="[{id:'1',text:'该段最早卡'},{id:'2',text:'该段最晚卡'}]"
							value="${atsCardRule.segBefSecTakeCardType==null?1:atsCardRule.segBefSecTakeCardType}"
							
						/>
						</td>
					</tr>
					
					<tr>
						<td>第一次下班取卡范围开始时数：</td>
						<td>
							
								<input name="segAftFirStartNum" value="${atsCardRule.segAftFirStartNum}"
							class="mini-textbox"    />
						</td>
						<td>第一次下班取卡范围结束时数：</td>
						<td>
							
								<input name="segAftFirEndNum" value="${atsCardRule.segAftFirEndNum}"
							class="mini-textbox"    />
						</td>
					</tr>
					<tr>
						<td>第一次下班取卡方式：</td>
						<td colspan="3">
							<input 
							class="mini-combobox" 
							name="segAftFirTakeCardType"
							data="[{id:'1',text:'该段最早卡'},{id:'2',text:'该段最晚卡'}]"
							value="${atsCardRule.segAftFirTakeCardType==null?2:atsCardRule.segAftFirTakeCardType}"
							
						/>
						</td>
					</tr>
					<tr class="two">
						<td>第二次下班取卡范围开始时数：</td>
						<td>
							
								<input name="segAftSecStartNum" value="${atsCardRule.segAftSecStartNum}"
							class="mini-textbox"    />
						</td>
						<td>第二次下班取卡范围结束时数：</td>
						<td>
							
								<input name="segAftSecEndNum" value="${atsCardRule.segAftSecEndNum}"
							class="mini-textbox"    />
						</td>
					</tr>
					<tr class="two">
						<td>第二次下班取卡方式：</td>
						<td colspan="3">
							<input 
							class="mini-combobox" 
							name="segAftSecTakeCardType"
							data="[{id:'1',text:'该段最早卡'},{id:'2',text:'该段最晚卡'}]"
							value="${atsCardRule.segAftSecTakeCardType==null?2:atsCardRule.segAftSecTakeCardType}"
							
						/>
						</td>
					</tr>
					<tr>
						<td>第一段间分配类型：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="segFirAssignType"
							data="[{id:'1',text:'手工分配'},{id:'2',text:'最近打卡点'}]"
							value="${atsCardRule.segFirAssignType==null?2:atsCardRule.segFirAssignType}"
							
						/>
						</td>
						<td>第一段间分配段次：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="segFirAssignSegment"
							data="[{id:'1',text:'第一段下班'},{id:'2',text:'第二段上班'}]"
							value="${atsCardRule.segFirAssignSegment==null?1:atsCardRule.segFirAssignSegment}"
							
						/>
						</td>
					</tr>
				
					<tr class="two">
						<th>第二段间分配类型：</th>
						<td>
							<input 
							class="mini-combobox" 
							name="segSecAssignType"
							data="[{id:'1',text:'手工分配'},{id:'2',text:'最近打卡点'}]"
							value="${atsCardRule.segSecAssignType==null?2:atsCardRule.segSecAssignType}"
							
						/>
						</td>
						<td>第二段间分配段次：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="segSecAssignSegment"
							data="[{id:'1',text:'第一段下班'},{id:'2',text:'第二段上班'}]"
							value="${atsCardRule.segSecAssignSegment==null?2:atsCardRule.segSecAssignSegment}"
						/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsCardRule"
		entityName="com.redxun.oa.ats.entity.AtsCardRule" />
	
	<script type="text/javascript">
	mini.parse();
	
	$(function(){
		//页面加载时确定周期类型
		changeType("${atsCardRule.segmentNum}");
	})
	
	//设置是否默认
	function onIsDefaultvaluechanged(e){
		var is = mini.get("isDefault");
		is.setValue(this.getChecked()==true?1:0);
	}
	
	//选择段次
	function changeType(value){
		var two = document.getElementsByClassName("two");
		disShowAry(two,value);
	}
	
	function disShowAry(ary,value){
		for(var i=0;i<ary.length;i++){
			var tr = ary[i];
			if(!value || value == ""){
				tr.style.display = "none";
			}
			if(value == 2){
				tr.style.display = "";
			}else{
				tr.style.display = "none";
			}
		}
	}
	
	
	//选择周期类型时,填入项发生改变
	function onSegmentNumValue(e) {
		changeType(e.value);
	}
	

	</script>
</body>
</html>