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

<%--<rx:toolbar toolbarId="toolbar1" hideRecordNav="true" />保存按钮--%>



<div class="mini-fit rx-grid-fit">


	<div id="fileUploadContent" class="fileUploadContent"></div>
	<div region="south" showSplit="false" showHeader="false" height="50" showSplitIcon="false"  style="width:100%">
		<div class="mini-toolbar" style="text-align:center;border:none" bodyStyle="border:0">
			<a class="mini-button" style="padding: 12px 12px; border-color:red;" iconCls="icon-ok" onclick="onOk()">确定</a>
		</div>
	</div>
</div>






<script type="text/javascript">
    var userId = "${userId}";
    var ip = "${ip}";
    var fileId = "${fileId}";
    var contextPath = "${contextPath}";
    var clientIp;
    var saveData="";
    var uploadFlag = false;


    //客户端ip
    $("input[name='serverIp']").val(ip);

    mini.parse();

    $(function() {console.log($("body").css("line-height"));
        $("body").css("line-height","inherit");
    });


    $("#fileUploadContent").initUpload({
        "uploadUrl":"http://120.78.80.17:9080/file/upload.do",//上传文件信息地址
        //"uploadUrl":"http://localhost:8080/file/upload.do",//上传文件信息地址
        "progressUrl":"#",//获取进度信息地址，可选，注意需要返回的data格式如下（{bytesRead: 102516060, contentLength: 102516060, items: 1, percent: 100, startTime: 1489223136317, useTime: 2767}）
        "selfUploadBtId":"selfUploadBt",//自定义文件上传按钮id
        "isHiddenUploadBt":true,//是否隐藏上传按钮
        "isHiddenCleanBt":false,//是否隐藏清除按钮
        "isAutoClean":false,//是否上传完成后自动清除
        "velocity":440,//模拟进度上传数据
        //"rememberUpload":true,//记住文件上传
        // "showFileItemProgress":false,
        //"showSummerProgress":false,//总进度条，默认限制
        //"scheduleStandard":true,//模拟进度的方式，设置为true是按总进度，用于控制上传时间，如果设置为false,按照文件数据的总量,默认为false
        "size":204800,//文件大小限制，单位kb,默认不限制
        "maxFileNumber":100,//文件个数限制，为整数
        //"filelSavePath":"",//文件上传地址，后台设置的根目录
        "beforeUpload":beforeUploadFun,//在上传前执行的函数
        "onUpload":onUploadFun,//在上传后执行的函数
        "autoCommit":true,//文件是否自动上传
        "fileType":['png','jpg','docx','doc','zip','pdf','exe','jpeg','txt','pptx','rar'],//文件类型限制，默认不限制，注意写的是文件后缀

    });
    function beforeUploadFun() {
        uploadFlag = true;
    }

    //上传完成事件
    function onUploadFun(opt,data){
        var jsonArray = data.data;
        saveData = JSON.stringify(jsonArray);
        //设置只读
        //mini.get("annex").setRequired(false);

    }

    function onOk() {
        if(saveData=="") {
            if(uploadFlag==true) {
                alert("请等待上传任务完成");
            }
            else{
                alert("请选择上传文件");
                CloseWindow('ok');
            }
        }
        else {
            $.ajax({
                type:"POST",
                url:"${ctxPath}/flie/tray/flieTrayBasic/saveAddress.do",
                dataType:"json",
                contentType:"application/json",
                data:saveData,
                success:function(data){
                    if(data.success==true) {
                        CloseWindow('ok');
                    }
                    else {
                        alert("上传错误,错误原因:"+data.message);
                    }
                }
            });
        }

        //ajax进行保存文件的操作
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
// NOTE: window.RTCPeerConnection is "not a constructor" in FF22/23
        var RTCPeerConnection = /*window.RTCPeerConnection ||*/ window.webkitRTCPeerConnection || window.mozRTCPeerConnection;

        if (RTCPeerConnection) (function () {
            var rtc = new RTCPeerConnection({iceServers:[]});
            if (1 || window.mozRTCPeerConnection) {      // FF [and now Chrome!] needs a channel/stream to proceed
                rtc.createDataChannel('', {reliable:false});
            };

            rtc.onicecandidate = function (evt) {
                // convert the candidate to SDP so we can run it through our general parser
                // see https://twitter.com/lancestout/status/525796175425720320 for details
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
                $("input[name='annexIp']").val(displayAddrs[0]);
                clientIp = displayAddrs[0];

            }

            function grepSDP(sdp) {
                var hosts = [];
                sdp.split('\r\n').forEach(function (line) { // c.f. http://tools.ietf.org/html/rfc4566#page-39
                    if (~line.indexOf("a=candidate")) {     // http://tools.ietf.org/html/rfc4566#section-5.13
                        var parts = line.split(' '),        // http://tools.ietf.org/html/rfc5245#section-15.1
                            addr = parts[4],
                            type = parts[7];
                        if (type === 'host') updateDisplay(addr);
                    } else if (~line.indexOf("c=")) {       // http://tools.ietf.org/html/rfc4566#section-5.7
                        var parts = line.split(' '),
                            addr = parts[2];
                        updateDisplay(addr);
                    }
                });
            }
        })(); else {
            $("input[name='annexIp']").val("127.0.0.1");
            clientIp = "127.0.0.1"; }
    }



    getYourIP();

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



</body>
</html>