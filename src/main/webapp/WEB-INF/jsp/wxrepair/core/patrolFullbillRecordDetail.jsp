<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>[巡检单填写详情]</title>
    <%@include file="/commons/customForm.jsp" %>
    <%@include file="/commons/new.jsp" %>
    <style>.fieldsetContainer {
        border: 1px solid #ddd;
        padding: 10px 5px;
        margin-bottom:25px;
    }</style>
</head>
<body style="visibility:hidden;">

<img src="${ctxPath}/scripts/swiper/close.png" class="close-img boxs hide" onclick="hide()">
<div class="img-box boxs hide">
    <div class="swiper-container gallery-top">
        <div class="swiper-wrapper imgs">

        </div>
        <!-- Add Arrows -->
        <div class="swiper-button-next swiper-button-white"></div>
        <div class="swiper-button-prev swiper-button-white"></div>
    </div>
</div>
<div class="modals boxs hide" onclick="hide()">
</div>
<div class="mini-fit">
    <div class="form-container">
        <div align="center" style="margin: 20px 0 10px;"><span style="font-size: 30px">${recordDetail.record.questionnaireName}</span></div>
        <div align="center" style="margin: 10px;">
            <span style="font-size: 15px;margin-right:60px;">门店:${recordDetail.record.shopName}</span>
            <span style="font-size: 15px">填单人:${recordDetail.record.staffName}</span>
        </div>
        <div id="form-panel"  class="customform">
            <%--<div class="form-model" id="formModel1">

                <fieldset class="fieldsetContainer">
                    <legend class="title">
                        第1题
                    </legend>喜欢的女明星 <br/><textarea name="testanswer" class="mini-textarea rxc" plugins="mini-textarea" style="width:30%;;height:100%;line-height:25px;" label="回答" datatype="varchar" length="200" vtype="length:200" minlen="0" allowinput="false" required="false" emptytext="" mwidth="30" wunit="%" mheight="100" hunit="%" value="赵丽颖"></textarea>
                </fieldset>
                <p>
                    <br/>
                </p>

                <fieldset class="fieldsetContainer">
                    <legend class="title">
                        第2题
                    </legend>下面那首歌是周杰伦的<br/><input name="csxz" class="mini-radiobuttonlist rxc" plugins="mini-radiobuttonlist" style="width:undefinedundefined;height:undefinedundefined" datafield="data" label="测试选择" textname="csxz_name" length="20" from="self" defaultvalue="" url="" url_textfield="" url_valuefield="" dickey="" sql="" sql_textfield="" sql_valuefield="" repeatlayout="flow" repeatdirection="horizontal" repeatitems="5" required="false" textfield="name" valuefield="key" data="[{&quot;key&quot;:&quot;A&quot;,&quot;name&quot;:&quot;江南&quot;},{&quot;key&quot;:&quot;B&quot;,&quot;name&quot;:&quot;清明雨上&quot;},{&quot;key&quot;:&quot;C&quot;,&quot;name&quot;:&quot;七里香&quot;},{&quot;key&quot;:&quot;D&quot;,&quot;name&quot;:&quot;年少有为&quot;}]" value="C" readonly="readonly"/>
                </fieldset>
                <p>
                    <br/>
                </p>


                <fieldset class="fieldsetContainer">
                    <legend class="title">
                        第3题
                    </legend>请上传损坏部位图片<br/>
                    <div class="swiper-container gallery-thumbs">
                        <div class="swiper-wrapper imgs">
                            <div class="boxsd"><img src="http://localhost:8080/jsaas/upload/images/patrol-f3e2de9d-c4ed-4c58-8928-89e0aa828e32.jpg"></div>
                            <div class="boxsd"><img src="http://localhost:8080/jsaas/upload/images/patrol-f3e2de9d-c4ed-4c58-8928-89e0aa828e32.jpg"></div>
                            <div class="boxsd"><img src="http://localhost:8080/jsaas/upload/images/patrol-5ff45dcb-ffbe-4447-99c5-0722fff4191c.jpg"></div>
                        </div>
                    </div>
                </fieldset>
                <p>
                    <br/>
                </p>
                <fieldset class="fieldsetContainer">
                    <legend class="title">
                        第4题
                    </legend>是否完成工单提交<br/><input name="cspd" class="mini-radiobuttonlist rxc" plugins="mini-radiobuttonlist" style="width:undefinedundefined;height:undefinedundefined" datafield="data" label="测试判断" textname="cspd_name" length="20" from="self" defaultvalue="" url="" url_textfield="" url_valuefield="" dickey="" sql="" sql_textfield="" sql_valuefield="" repeatlayout="flow" repeatdirection="horizontal" repeatitems="5" required="false" textfield="name" valuefield="key" data="[{&quot;key&quot;:&quot;true&quot;,&quot;name&quot;:&quot;是&quot;},{&quot;key&quot;:&quot;false&quot;,&quot;name&quot;:&quot;否&quot;}]" value="true" readonly="readonly"/>
                </fieldset>
                <p>
                    <br/>
                </p>
                <p>
                    <br/>
                </p>


            </div>

            <hr>
            <hr>
            <hr>--%>
            <div class="form-model" id="td">

            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var galleryTop = null;


    //var obj = { "data": [{ "F_QUESTION_CONTENT": "喜欢的女明星", "F_ANSWER": "哦？1a", "F_SEQUENCE": 1, "RDID": "2610000000690053", "QID": "2610000000030225", "F_QUESTION_TYPE": "001", "F_QUESTION_TYPE_name": "简答" }, { "F_QUESTION_CONTENT": "下面那首歌是周杰伦的", "F_ANSWER": "A", "options": [{ "F_OPTION_CONTENT": "江南", "GROUP_ID_": "2", "ID_": "2610000000030228", "CREATE_TIME_": 1569548012000, "UPDATE_TIME_": 1570852079000, "REF_ID_": "2610000000030227", "CREATE_BY_": "1", "TENANT_ID_": "1", "F_OPTION_CODE": "A" }, { "F_OPTION_CONTENT": "清明雨上", "GROUP_ID_": "2", "ID_": "2610000000030229", "CREATE_TIME_": 1569548012000, "UPDATE_TIME_": 1570852079000, "REF_ID_": "2610000000030227", "CREATE_BY_": "1", "TENANT_ID_": "1", "F_OPTION_CODE": "B" }, { "F_OPTION_CONTENT": "七里香", "GROUP_ID_": "2", "ID_": "2610000000030230", "CREATE_TIME_": 1569548012000, "UPDATE_TIME_": 1570852079000, "REF_ID_": "2610000000030227", "CREATE_BY_": "1", "TENANT_ID_": "1", "F_OPTION_CODE": "C" }, { "F_OPTION_CONTENT": "年少有为", "GROUP_ID_": "2", "ID_": "2610000000030231", "CREATE_TIME_": 1569548012000, "UPDATE_TIME_": 1570852079000, "REF_ID_": "2610000000030227", "CREATE_BY_": "1", "TENANT_ID_": "1", "F_OPTION_CODE": "D" }], "F_SEQUENCE": 2, "RDID": "2610000000690054", "QID": "2610000000030227", "F_QUESTION_TYPE": "002", "F_QUESTION_TYPE_name": "选择" }, { "F_QUESTION_CONTENT": "请上传损坏部位图片", "F_ANSWER": "patrol-f3e2de9d-c4ed-4c58-8928-89e0aa828e32.jpg&patrol-f3e2de9d-c4ed-4c58-8928-89e0aa828e32.jpg&patrol-5ff45dcb-ffbe-4447-99c5-0722fff4191c.jpg", "F_SEQUENCE": 3, "RDID": "2610000000690055", "QID": "2610000000150010", "F_QUESTION_TYPE": "004", "F_QUESTION_TYPE_name": "上传" }, { "F_QUESTION_CONTENT": "是否完成工单提交", "F_ANSWER": "false", "F_SEQUENCE": 4, "RDID": "2610000000690057", "QID": "2610000000150011", "F_QUESTION_TYPE": "003", "F_QUESTION_TYPE_name": "判断" }] }
    var obj = ${recordDetail};
    var data = obj.data;
    //console.log(obj.record);
    var html = "";
    for (var i = 0; i < data.length; i++) {
        if (data[i].F_QUESTION_TYPE_name == "简答") {
            // 简答
            html += "<fieldset class='fieldsetContainer'><legend class='title'>第"+(i+1)+"题</legend>"+data[i].F_QUESTION_CONTENT+" <br/><textarea name='testanswer' class='mini-textarea rxc' plugins='mini-textarea' style='width:30%;;height:100%;line-height:25px;' label='回答' datatype='varchar' length='200' vtype='length:200' minlen='0' allowinput='false' required='false' emptytext='' mwidth='30' wunit='%' mheight='100' hunit='%' value="+data[i].F_ANSWER+"></textarea> </fieldset>"
        } else if (data[i].F_QUESTION_TYPE_name == "选择") {
            var temp = JSON.stringify(data[i].options);
            //console.log(temp);
            html+="<fieldset class='fieldsetContainer'><legend class='title'>第"+(i+1)+"题</legend>"+data[i].F_QUESTION_CONTENT+"<br/><input name='csxz' class='mini-radiobuttonlist rxc' plugins='mini-radiobuttonlist'  datafield='data' label='测试选择' textname='csxz_name' length='20' from='self' defaultvalue='' url='' url_textfield='' url_valuefield='' dickey='' sql='' sql_textfield='' sql_valuefield='' repeatlayout='flow' repeatdirection='horizontal' repeatitems='5' required='false' textfield='F_OPTION_CONTENT' valuefield='F_OPTION_CODE' data="+temp+" value="+data[i].F_ANSWER+" readonly='readonly'/> </fieldset>"

        } else if (data[i].F_QUESTION_TYPE_name == "判断") {
            // 判断
            html+="<fieldset class='fieldsetContainer'><legend class='title'>第"+(i+1)+"题</legend>"+data[i].F_QUESTION_CONTENT+"<br/><input name='cspd' class='mini-radiobuttonlist rxc' plugins='mini-radiobuttonlist'  datafield='data' label='测试判断' textname='cspd_name' length='20' from='self' defaultvalue='' url='' url_textfield='' url_valuefield='' dickey='' sql='' sql_textfield='' sql_valuefield='' repeatlayout='flow' repeatdirection='horizontal' repeatitems='5' required='false' textfield='name' valuefield='key' data='[{&quot;key&quot;:&quot;true&quot;,&quot;name&quot;:&quot;是&quot;},{&quot;key&quot;:&quot;false&quot;,&quot;name&quot;:&quot;否&quot;}]' value="+data[i].F_ANSWER+" readonly='readonly' /></fieldset>"

        } else {
            // 图片
            var arr = data[i].F_ANSWER.split("&")
            var myarr = new Object();
            myarr.arr = arr;
            var myarrstr = JSON.stringify(myarr);
            html+="<fieldset class='fieldsetContainer'><legend class='title'>第"+(i+1)+"题</legend>"+data[i].F_QUESTION_CONTENT+"<br/>"
            for (var g = 0; g < arr.length; g++) {
                html += "<div class='boxsd' onclick='review("+myarrstr+","+g+")'><img src=" + 'https://patrol.51cine.cn:9060/jsaas/upload/images/' + arr[g] + "></div>"
            }
            html+="</fieldset>"

        }
    }
    $("#td").html(html)



    // 浏览
    function review(arrstr,index) {
        var arr = arrstr.arr;
        var myhtml = "";
        for (var i = 0; i < arr.length; i++) {
            myhtml += "<div class='swiper-slide'><img src=" + 'https://patrol.51cine.cn:9060/jsaas/upload/images/' + arr[i] + "></div>"
        }
        $(".boxs").fadeIn(0);
        $(".imgs").html(myhtml);
        onLoad(index);
    }
    // 点击模态框和关闭按钮关闭
    function hide() {
        galleryTop.destroy();
        $(".boxs").fadeOut(0);
    }
    function onLoad(index) {
/*        console.log(index);
        if (galleryThumbs){
            galleryThumbs.destroy();
        }
        if (galleryTop){
            galleryTop.destroy();
        }*/
        galleryTop = new Swiper('.gallery-top', {
            initialSlide: index,
            spaceBetween: 10,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            }
        });
    }
</script>
</body>
</html>