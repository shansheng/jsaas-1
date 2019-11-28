<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>生成手机表单</title>
	<%@include file="/commons/edit.jsp" %>
	<script type="text/javascript" src="${ctxPath}/scripts/flow/form/bpmFormView.js"></script>
	<%--<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/ueditor-fd-config-mobile.js"></script>--%>
	<%--<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/ueditor-fd.all.js"> </script>--%>
	<%--<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/ueditor/lang/zh-cn/zh-cn.js"></script>--%>

	<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/mini/jquery.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${ctxPath}/scripts/layoutit/js/jquery-ui.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/FullCalender/jquery-ui.min.css" />

	<link rel="stylesheet" type="text/css" href="${ctxPath}/mobile/css/codemirror.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/mobile/icon/iconfont.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/mobile/css/mobileEdit.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPath}/mobile/css/app.css"/>

	<%--<script src="${ctxPath}/mobile/js/jquery.js"></script>--%>
	<script src="${ctxPath}/mobile/js/mobileEdit.js"></script>

	<script src="${ctxPath}/mobile/js/codemirror.js"></script>

	<script src="${ctxPath}/mobile/js/javascript.js"></script>
	<script src="${ctxPath}/mobile/js/xml.js"></script>
	<style>
		.divActive{
			border: 1px dashed #29a5bf !important;
		}
		.form-block{
			border: 2px dashed #29a5bf;
			padding: 4px;
		}
	</style>
</head>
<body  >
<div class="bodyContainer">
	<div class="headers" id="headers">
		<ul>
			<li id="preview" class="active"><i class="iconfont icon-brush"></i>预览</li>
			<!--<li><i class="iconfont icon-playon"></i>预览</li>-->
			<li id="codeView"><i class="iconfont icon-daima"></i>代码</li>
		</ul>
	</div>
	<ul id="editUl" >
		<li class="contentBox">
			<div class="editLeft">
				<%--<ul id="tree">--%>
				<%--<li class="first_li">--%>
				<%--<p>基础组件<em></em><i class="iconfont icon-packup"></i></p>--%>
				<%--<ul class="two_ul">--%>
				<%--<li><p>基础组件<em></em><i class="iconfont icon-packup"></i></p></li>--%>
				<%--<li><p>基础组件<em></em><i class="iconfont icon-packup"></i></p>--%>
				<%--<ul class="three_ul">--%>
				<%--<li><p>基础组件<em></em><i class="iconfont icon-packup"></i></p></li>--%>
				<%--</ul>--%>
				<%--</li>--%>

				<%--</ul>--%>
				<%--</li>--%>
				<%--</ul>--%>
			</div>
			<div class="editCenter">
				<div class="centerHeader">
					<!--<span class="btnPre">保存</span>-->
				</div>
				<div class="mobiles">
					<div class="mobileBox" id="mobileBox">
						<span>
							<div class="mobileCenter">
								<div class="modileContents">

								</div>
							</div>
						</span>
					</div>
				</div>
			</div>
			<div class="editRight">
				<ul>
					<li>
						<span class="firstName">名称：</span>
						<span class="inportBox">
							<input type="text" name="name" id="name" value="${bpmMobileForm.name }" />
						</span>
					</li>
					<li>
						<span class="firstName">别名：</span>
						<span class="inportBox">
									<input type="text" name="alias" id="alias" value="${bpmMobileForm.alias}" />
								</span>
					</li>
					<li>
						<span class="firstName">分类选择：</span>
						<span class="inportBox">
									<input id="treeId" name="treeId" class="mini-treeselect"
										   url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_PHONE_FORM"
										   multiSelect="false" textField="name" valueField="treeId" parentField="parentId" required="true"
										   value="${bpmMobileForm.treeId}"
										   text="${treeName}"
										   showFolderCheckBox="false" expandOnLoad="true" showClose="true" oncloseclick="_ClearButtonEdit"
										   popupWidth="300"  style="width:100%;"/>
								</span>
					</li>
					<li onclick="onGenerate()">
						<span class="firstName"></span>
						<span class="inportBox"><div class="anewBtn">重载结构</div></span>

					</li>
					<li onclick="onGenerate('all')">
						<span class="firstName"></span>
						<span class="inportBox"><div class="anewBtn">重载结构与脚本</div></span>

					</li>
					<li onclick="onSave()">
						<span class="firstName"></span>
						<span class="inportBox"><div class="anewBtn">保存</div></span>

					</li>
					<li onclick="onCancel()">
						<span class="firstName"></span>
						<span class="inportBox"><div class="anewBtn">取消</div></span>

					</li>
				</ul>
			</div>
		</li>
		<li class="contentBox paddings" style="">
			<div>
				<div class="centerHeader">
					<%--<span class="btnPre">保存</span>--%>
				</div>
				<div id="sss">


					<div class="codeTempHtml">
						<div class="codeHeaderTop">HTML</div>
						<div class="codeBox">
							<!--Html-->
							<textarea id="codeHtml" ></textarea>
						</div>
					</div>
					<div class="codeTempJs">
						<div class="codeHeaderTop">JS</div>
						<div class="codeBox">
							<!--js-->
							<textarea id="codeJs" ></textarea>
						</div>
					</div>
				</div>
			</div>
		</li>
	</ul>

</div>

<%--<div class="mini-fit">--%>
<%--<div class="mobileBox">--%>
<%--<div id="newHtml">--%>

<%--</div>--%>
<%--<div class="mobileBottom">--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>

<script type="text/javascript">
    var pk="${bpmMobileForm.id}";

    var editorHtml = CodeMirror.fromTextArea($("#codeHtml")[0], {
        lineNumbers: true,//是否显示行号
        mode:"text/html",　//默认脚本编码
        /*theme:"3024-night",*/
        lineWrapping:true, //是否强制换行
    });
    var editorJs = CodeMirror.fromTextArea($("#codeJs")[0], { //script_once_code为你的textarea的ID号
        lineNumbers: true,//是否显示行号
        mode:"text/javascript",　//默认脚本编码
        /* theme:"3024-night",*/
        lineWrapping:true, //是否强制换行
    });

    $(function(){
        $("#formHtml").height($("body").height()-180);

        if(pk){
            var url=__rootPath +"/bpm/form/bpmMobileForm/getById.do?id="+pk;
            $.get(url,function(data){
                var formHtml=data.formHtml;
                setConstHtmlAndJs(formHtml);
            })
        }

    })

    function setConstHtmlAndJs(formHtml){
        var reg=/<script.*>([\s\S]*?)<\/script>/gi;
        var scriptHtml=formHtml.match(reg)[0];
        var constHtml=formHtml.replace(reg,"");

        $(".modileContents").html(constHtml);
        //加上可以排序
        allSort();
        // editorHtml.setValue(constHtml);
        editorJs.setValue(scriptHtml);
    }

    function setConstHtml(formHtml){
        var reg=/<script.*>([\s\S]*?)<\/script>/gi;
        var constHtml=formHtml.replace(reg,"");

        $(".modileContents").html(constHtml);
        //加上可以排序
        allSort();
    }

    function onSave(){
        var html=editorJs.getValue()+$(".modileContents").html();
        var treeId=mini.get("treeId").getValue();
        var name=$("#name").val();
        var alias=$("#alias").val();
        if(!name){
            mini.alert("名称不能为空");
            return;
        }
        if(!alias){
            mini.alert("别名不能为空");
            return;
        }
        if(!treeId){
            mini.alert("分类不能为空");
            return;
        }

        var formData={
            id:pk,
            name:name,
            alias:alias,
            treeId:treeId,
            formHtml:html
        }
        var config={
            url:__rootPath+"/bpm/core/bpmMobileForm/save.do",
            method:'POST',
            data:formData,
            success:function(result){
                //如果存在自定义的函数，则回调
                if(isExitsFunction('successCallback')){
                    successCallback.call(this,result);
                    return;
                }

                CloseWindow('ok');
            }
        }

        _SubmitJson(config);
    }

    function allSort(){
        //$( ".rowcol-title,row2col-title").attr("contenteditable",true);


        $( ".div-form-main" ).sortable({
            items: ".form-rowcol,.form"
        });

        $( ".div-form-main" ).sortable({
            items: ".form-rowcol,.form"
        });

        //多子表
        $( ".div-form-sub" ).each(function(){
            $(this).sortable({
                items: ".form-rowcol,.form"
            });
        });

        $(".form-rowcol,.form").mouseover(function(){
            $(this).css("cursor","pointer");
        }).mousedown(function(e){

        });
    }

    function onGenerate(genAll){
        var boDefId="${bpmMobileForm.boDefId}";
        var url=__rootPath + "/bpm/form/bpmMobileForm/genTemplate.do?boDefId=" + boDefId;
        _OpenWindow({
            url: url,
            title: "重新生成HTML", width: "600", height: "400",
            ondestroy: function(action) {
                if(action!="ok") return;
                var iframe = this.getIFrameEl().contentWindow;
                var templates=iframe.getTemplate();

                var urlGen=__rootPath + "/bpm/form/bpmMobileForm/generateHtml.do?boDefId=" + boDefId +"&templates=" + templates ;
                urlGen=encodeURI(urlGen);
                $.post(urlGen,function(data){
                    if(genAll=='all'){
                        setConstHtmlAndJs(data);
                    }else{
                        setConstHtml(data);
                    }
                })
            }
        });
    }

    $(function(){
        $(".modileContents").on("click",".form-rowcol,.form",function(){
            var thisClass = $(this).attr("class");
            var thisHtml = $(this);
            var thisIndex = $(this).index();
            if($(this).parent().hasClass("form-block")) return;
            if(thisClass.indexOf("divActive") < 0 ){
                $(this).addClass("divActive");
            }else{
                $(this).removeClass("divActive");
            }
        })
        document.oncontextmenu = function(){return false};
        $(".modileContents").on("mouseup",".divActive",function(e){
            if(e.button === 2){
                $(this).parent().children(".divActive").wrapAll("<div class='form-block'></div>");
                $(this).parent().children().removeClass("divActive");
            }
        })

        $(".modileContents").on("mouseup",".form-block",function(e){
            if(e.button === 2){
                $(this).children().unwrap();
            }
        })

        $("#preview").on("click",function(){
            if(!$(this).hasClass("active")) return;
            $(".modileContents").html(editorHtml.getValue());
            allSort();
        })

        $("#codeView").on("click",function(){
            if(!$(this).hasClass("active")) return;
            editorHtml.setValue($(".modileContents").html());
        })

    })
</script>


<rx:formScript formId="form1"
			   baseUrl="bpm/core/bpmMobileForm"
			   entityName="com.redxun.bpm.form.entity.BpmMobileForm" />
</body>
</html>