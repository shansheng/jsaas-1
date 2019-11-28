<%-- 
    Document   : 文件编辑页
    Created on : 2015-11-21, 10:11:48
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>文件编辑</title>
<%@include file="/commons/edit.jsp"%>
<script src="${ctxPath}/scripts/jquery/plugins/jquery.getscripts.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jQuery.download.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/baiduTemplate.js" type="text/javascript"></script>
<script src="${ctxPath}/scripts/customer/mini-custom.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxPath}/page/airdrop/upload/js/fileUpload.js"></script>
	<link href="${ctxPath}/page/airdrop/upload/css/iconfont.css" rel="stylesheet" type="text/css" />
	<link href="${ctxPath}/page/airdrop/upload/css/fileUpload.css" rel="stylesheet" type="text/css">

	<style type="text/css">
.mini-panel-border,.mini-panel-toolbar{
    border: none;
}
.mini-panel-toolbar, .mini-panel-footer{
	background: #fff;
}
form,.mini-tabs-bodys,
.mini-tabs-space2,
.mini-tabs-space{
	background: transparent;
	border: none;
}
.shadowBox{
	margin:20px auto 0;
	width: 90%;
}

.table-detail{
	margin-bottom: 0;
}

h1 {
	text-align:center;
}

input {
	font-size:24px;
	margin:10px;
}
.clear {
	clear:both;
}
.speed_box {
	width:600px;
	height:20px;
	display:none;
	border:1px solid #0091f2;
	border-radius:10px;
	overflow:hidden;
}
#file_box {
	min-width:600px;
	min-height:300px;
	border:1px solid #0091f2;
	border-radius:10px;
	display:inline-block;
	background:#EEE;
	overflow:hidden;
	z-index:999999;
}
#speed {
	width:0;
	height:100%;
	background:#0091f2;
	color:white;
	text-align:center;
	line-height:20px;
	font-size:16px;
}
#file_size,#file_type {
	display:inline-block;
	padding:0px 16px;
	font-size:16px;
	color:#0091f2;
	font-weight:bold;
}
#file_type {
	margin-top:30px;
}
.opts_btn {
	position:relative;
	display:inline-block;
	padding:8px 16px;
	font-size:16px;
	color:white;
	text-decoration:none;
	background:#0091f2;
	border:2px solid #0091f2;
	border-radius:3px;
	cursor:pointer;
	overflow:hidden;
}
.oFile {
	position:absolute;
	width:100%;
	height:100%;
	z-index:10;
	top:0px;
	left:0px;
	opacity:0;
}
.send_btn {
	display:inline-block;
	display:none;
	float:right;
	margin-top:20px;
	padding:8px 16px;
	font-size:16px;
	color:white;
	background:#0091f2;
	border:1px solid transparent;
	border-radius:2px;
	cursor:pointer;
}
</style>


</head>
<body>
	<rx:toolbar toolbarId="toolbar1" hideRecordNav="true" />



	<div class="mini-fit rx-grid-fit">
		<form id="form1" method="post">
			<input name="annexIp" class="mini-hidden rxc" plugins="mini-hidden" label="上传ip"  value=""/>
			<input name="docLabel" class="mini-hidden rxc" plugins="mini-hidden" label="文件类型"  value=""/>
			<input name="addLable" class="mini-hidden rxc" plugins="mini-hidden" label="添加标签"  value=""/>
			<input name="createTime" class="mini-hidden rxc" plugins="mini-hidden" label="时间"  value="${videoUpload.createTime}"/>
			<input name="filePath" class="mini-hidden rxc" plugins="mini-hidden" label="path"  value=""/>

			<div id="tabs1" class="mini-tabs" style="width: 100%;" bodyStyle="border:0;">

				<div title="基本信息">
					<div class="shadowBox">
						<input id="pkId" name="id" class="mini-hidden" value="${videoUpload.id}" />
						<table class="table-detail column_2_m" cellspacing="1" cellpadding="0" style="height: 100%">
							<caption>文件基本信息</caption>
							<tr style="display: none;">
								<th>文件夹ID <span class="star">*</span>
								</th>
								<td><input name="refId" value="${fileId}" class="mini-textbox" vtype="maxLength:64" style="width: 90%" required="true" /></td>

								<th>用户ID</th>
								<td><input name="createUserId" value="${videoUpload.createUserId}" class="mini-textbox" vtype="maxLength:64" style="width: 90%" /></td>
							</tr>
							<tr>
								<th>文档名称
									<span class="star">*</span>
								</th>
								<td><input name="docFname" value="${videoUpload.docFname}" class="mini-textbox" vtype="maxLength:100" style="width: 90%" required="true" emptyText="请输入文档名称" /></td>
								<th>标签</th>
								<td>
									<div id="combobox2" name="combobox2" class="mini-combobox" style="width:250px;"  popupWidth="400" textField="text" valueField="id"
										 url="${ctxPath}/flie/tray/flieTrayBasic/backDownBox.do"  multiSelect="true"  allowInput="true" showClose="true" oncloseclick="onCloseClick" onblur="valueBlur">
										<div property="columns">
											<div header="标签名" field="text"></div>
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<th>创建人</th>
								<td><input name="author" value="${userName}" readonly="readonly" class="mini-textbox" vtype="maxLength:64" required="true" style="width: 90%" /></td>
								<th>附件名</th>
								<td><input name="annex" id="annex" readonly="readonly" value="${videoUpload.name}"  required="true" value="" class="mini-textbox rxc"  style="width: 90%" /></td>
							</tr>
						</table>
					</div>
				</div>
			</div>

		</form>

		<div id="fileUploadContent" class="fileUploadContent"></div>

	</div>





	<script type="text/javascript">
        var userId = "${userId}";
        var ip = "${ip}";
        var fileId = "${fileId}";
        var contextPath = "${contextPath}";


	mini.parse();

    $(function() {console.log($("body").css("line-height"));
        $("body").css("line-height","inherit");
    });


    $("#fileUploadContent").initUpload({
        "uploadUrl":"http://192.168.1.90/flie/tray/flieTrayBasic/fileUpload2.do",//上传文件信息地址
        "progressUrl":"#",//获取进度信息地址，可选，注意需要返回的data格式如下（{bytesRead: 102516060, contentLength: 102516060, items: 1, percent: 100, startTime: 1489223136317, useTime: 2767}）
        "selfUploadBtId":"selfUploadBt",//自定义文件上传按钮id
        "isHiddenUploadBt":false,//是否隐藏上传按钮
        "isHiddenCleanBt":false,//是否隐藏清除按钮
        "isAutoClean":false,//是否上传完成后自动清除
        "velocity":10,//模拟进度上传数据
        //"rememberUpload":true,//记住文件上传
        // "showFileItemProgress":false,
        //"showSummerProgress":false,//总进度条，默认限制
        //"scheduleStandard":true,//模拟进度的方式，设置为true是按总进度，用于控制上传时间，如果设置为false,按照文件数据的总量,默认为false
        //"size":350,//文件大小限制，单位kb,默认不限制
        // "maxFileNumber":3,//文件个数限制，为整数
        //"filelSavePath":"",//文件上传地址，后台设置的根目录
        //"beforeUpload":beforeUploadFun,//在上传前执行的函数
        "onUpload":onUploadFun,//在上传后执行的函数
        //autoCommit:true,//文件是否自动上传
        //"fileType":['png','jpg','docx','doc']，//文件类型限制，默认不限制，注意写的是文件后缀

    });

    function onUploadFun(opt,data){
        var inputAnnexValue = "";
        var jsonArray = data.data;
        for(var i = 0; i < jsonArray.length;i++)
		{
            inputAnnexValue = inputAnnexValue + jsonArray[i].movieName + ",";
		}
		inputAnnexValue = inputAnnexValue.substring(0,inputAnnexValue.length-1);

        $("input[name='filePath']").val(JSON.stringify(jsonArray));

        $("input[name='annex']").val(inputAnnexValue);

        console.log(JSON.stringify(jsonArray));

        mini.get("annex").setRequired(false);

    }
		
	
	
	//增加个人权限
	function addPerson(type) {
		var infUser = mini.get(type);
		_UserDlg(false, function(users) {//打开收信人选择页面,返回时获得选择的user的Id和name
			var uIds = [];
			var uNames = [];
			//将返回的选择分别存起来并显示
			for (var i = 0; i < users.length; i++) {
				var flag = true;
				users[i].userId = users[i].userId + "_user";
				var oldValues = infUser.getValue().split(',');
				var oldText = infUser.getText().split(',');
				for(var j=0;j<oldValues.length;j++){
					if(oldValues[j]==users[i].userId&&oldText[j]==users[i].fullname){
						flag = false;
						break;
					}
				}
				if(flag==true){
				uIds.push(users[i].userId);
				uNames.push(users[i].fullname);
				}
			}
			if (infUser.getValue() != '') {
				uIds.unshift(infUser.getValue().split(','));
			}
			if (infUser.getText() != '') {
				uNames.unshift(infUser.getText().split(','));
			}
			infUser.setValue(uIds.join(','));
			infUser.setText(uNames.join(','));
		});
	}
	//增加组权限
	function addGroup(type) {
		var infGroup = mini.get(type);
		_GroupDlg(false, function(groups) {
			var uIds = [];
			var uNames = [];
			for (var i = 0; i < groups.length; i++) {
				var flag = true;
				groups[i].groupId = groups[i].groupId + "_group";
				var oldValues = infGroup.getValue().split(',');
				var oldText = infGroup.getText().split(',');
				for(var j=0;j<oldValues.length;j++){
					if(oldValues[j]==groups[i].groupId&&oldText[j]==groups[i].name){
						flag = false;
						break;
					}
				}
				if(flag==true){
				uIds.push(groups[i].groupId);
				uNames.push(groups[i].name);
				}
			}
			if (infGroup.getValue() != '') {
				uIds.unshift(infGroup.getValue().split(','));
			}
			if (infGroup.getText() != '') {
				uNames.unshift(infGroup.getText().split(','));
			}
			infGroup.setValue(uIds.join(','));
			infGroup.setText(uNames.join(','));
		});
	}
	
	


</script>


<script>



function getYourIP(){
    var RTCPeerConnection = window.RTCPeerConnection || window.webkitRTCPeerConnection || window.mozRTCPeerConnection;
    if (RTCPeerConnection) (function () {
        var rtc = new RTCPeerConnection({iceServers:[]});
        if (1 || window.mozRTCPeerConnection) {   
        	try {
        		rtc.createDataChannel('', {reliable:false});
        	}
        	catch(err){
        		$("input[name='annexIp']").val("127.0.0.1");
        	}
        };
        
        rtc.onicecandidate = function (evt) {
            if (evt.candidate) grepSDP("a="+evt.candidate.candidate);
        };
        rtc.createOffer(function (offerDesc) {
            grepSDP(offerDesc.sdp);
            rtc.setLocalDescription(offerDesc);
        }, function (e) { console.warn("offer failed", e); });
        
        
        var addrs = Object.create(null);
        addrs["0.0.0.0"] = false;
        function updateDisplay(newAddr) {
            if (newAddr in addrs) return;
            else addrs[newAddr] = true;
            var displayAddrs = Object.keys(addrs).filter(function (k) { return addrs[k]; });
            for(var i = 0; i < displayAddrs.length; i++){
                if(displayAddrs[i].length > 16){
                    displayAddrs.splice(i, 1);
                    i--;
                }
            }
            $("input[name='annexIp']").val(displayAddrs[0]);
        }
        
        function grepSDP(sdp) {
            var hosts = [];
            sdp.split('\r\n').forEach(function (line, index, arr) { 
               if (~line.indexOf("a=candidate")) {    
                    var parts = line.split(' '),       
                        addr = parts[4],
                        type = parts[7];
                    if (type === 'host') updateDisplay(addr);
                } else if (~line.indexOf("c=")) {       
                    var parts = line.split(' '),
                        addr = parts[2];
                    updateDisplay(addr);
                }
            });
        }
    })();
    else{
    	 $("input[name='annexIp']").val("127.0.0.1");
    }
}


getYourIP();//获取ip

function onCloseClick(e) {
    var obj = e.sender;
    obj.setText("");
    obj.setValue("");
}

function valueBlur(e)
{
    var obj = e.sender;
    $("input[name='docLabel']").val(obj.getText());
    $("input[name='addLable']").val(obj.listbox.OO0o0.length);
}

</script>



	<rx:formScript formId="form1" baseUrl="flie/tray/address" entityName="com.airdrop.flie.tray.entity.Address" />
</body>
</html>