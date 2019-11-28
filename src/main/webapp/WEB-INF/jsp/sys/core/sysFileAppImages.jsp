<%-- 
	//功能：展示应用的图片，以供选择
	//作者：csx
	//创建日期:2015-05-06
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/commons/edit.jsp"%>
<link href="${ctxPath}/styles/file-list.css" rel="stylesheet" type="text/css" />
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow-y:auto!important;
}

.Mauto{
	/*background:#29A5BF;*/
	padding-bottom:15px;
	padding-top:15px;
}
#filesView{
	overflow:hidden;
}
#filesView  li.file-block{
	float:left;
	width:180px;
	background:#fFF;
	margin-left:8px;
	margin-top:17px;
	border-radius:4px;
	text-align:center;
	border: solid 1px #ccc;
}
li.file-block a{
	width:100%;
	text-align:center;
	display:inline-block;
	height:150px;
	line-height:150px;
}
li.file-block a .imageBox{
	display:inline-block;
	width:130px;
}
li.file-block a .imageBox img.file-image{
	width:100%;
}

img.file-image{
	padding-top:5px;
}

#filesView  li.file-block .file-ext{
	width:100%;
	padding:0 6px;
	display: inline-block;
	overflow:hidden;
	white-space:nowrap;
	text-overflow:ellipsis;
	box-sizing: border-box;
}
#toptoolbar{
	right:8px;

}
.mini-pager-left,
.mini-pager{
	height: 30px;
}
.mini-pager-left a.mini-button{
	margin-right: 4px;
}
</style>
<title>应用图片</title>
</head>
<body>

	<ul id="contextMenu" class="mini-contextmenu">
		<li  onclick="onItemOpen">查看</li>
		<li  class=" btn-red" onclick="onItemRemove">删除</li>
	</ul>
	<div class="topToolBar">
			<div>
				<a class="mini-button"  onclick="CloseWindow('ok')">选择</a>
				<a class="mini-button" onclick="upload()">上传</a>
				<a class="mini-button" onclick="refresh()">刷新</a>
				<a class="mini-button btn-red" onclick="CloseWindow('cancel')">关闭</a>
			</div>
	</div>
<div class="mini-fit">
	<div  class="form-container">
		<div><span>按文件名搜索：</span><input class="mini-textbox" id="fileName" emptyText="请输入文件名" onenter="onSearch" value="${param['fileName']}">&nbsp<a class="mini-button" onclick="onSearch">搜索</a></div>
		<div id="filesDataView">
			<ul id="filesView" class="filesView">

				<c:if test="${fn:length(imageFiles)==0}">
					<div style="width:100%;text-align: center;padding:10px;margin:10px;">
						<span style="line-height: 40px;">暂时找不到图片文件！</span>
					</div>
				</c:if>
				<c:forEach var="file" items="${imageFiles}">
					<li class="file-block p_top"  fileid="${file.fileId}">
						<a class="file" href="javascript:void(0)" onclick="clickImgFile(this,${single})" hideFocus title="${file.fileName}"> 
								<c:choose>
									<c:when test="${file.from=='APPLICATION'}">
										<c:choose>
											<c:when test="${not empty file.thumbnail}">
												<img class="file-image" fileId="${file.fileId}" src="${ctxPath}/${file.thumbnail}" />
											</c:when>
											<c:otherwise>
												<img class="file-image" fileId="${file.fileId}" src="${ctxPath}/${file.path}" />
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${not empty file.thumbnail}">
												<span class="imageBox">
													<img class="file-image" fileId="${file.fileId}" src="${ctxPath}/sys/core/file/imageView.do?thumb=true&fileId=${file.fileId}" />
												</span>
											</c:when>
											<c:otherwise>
												<span class="imageBox">
													<img class="file-image" fileId="${file.fileId}" src="${ctxPath}/sys/core/file/imageView.do?fileId=${file.fileId}" />
												</span>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
						</a>
						<span class="file-ext"> ${fn:substring(file.fileName,0,15)} </span>
						<c:choose>
							<c:when test="${single==true}">
								<input type="radio" name="imgFile" value="${file.fileId}" fileName="${file.fileName}" filePath="${file.path}" alt="选择该文件"/>
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="imgFile" value="${file.fileId}" fileName="${file.fileName}" filePath="${file.path}" alt="选择该文件"/>
							</c:otherwise>
						</c:choose>
					</li>
				</c:forEach>
			</ul>
		</div>

	</div>
</div>
	<c:if test="${fn:length(imageFiles)!=0}">
		<div style="padding:5px;line-height: 36px;text-align: center;margin-top:5px;background: #fff;">
			<div style="width:100%;margin: auto;">
				<div class="mini-pager"
					 style="width:100% "
					 totalCount="${page.totalItems}"
					 pageIndex="${page.pageIndex}"
					 pageSize="${page.pageSize}"
					 onpagechanged="onPageChanged"
					 sizeList="[5,10,20,100]"
					 showPageSize="true"
					 showPageIndex="true"
				>
				</div>
			</div>
		</div>
	</c:if>
	<script type="text/javascript">
   	    mini.parse();
   	    
   	    var from='<c:out value="${from}" />';
   	    
   	    //当前选择图片
   	   	var curDiv=null;
   	   	$(function(){
            $(".file-block").bind("contextmenu", function (e) {
                curDiv=$(e.target);
                var menu = mini.get("contextMenu");
                menu.showAtPos(e.pageX, e.pageY);
                return false;
            });
		});

        /**
		 * 搜索
         */
   	   	function onSearch() {
   	   	    var fileName=mini.get('fileName').getValue();
			location.href="${ctxPath}/sys/core/sysFile/appImages.do?from=${param['from']}&single=${param['single']}&fileName="+encodeURI(fileName);
        }

        /**
		 * 页码更改
         * @param e
         */
        function onPageChanged(e){
            var fileName=mini.get('fileName').getValue();
            location.href="/sys/core/sysFile/appImages.do?from=${param['from']}&single=${param['single']}&fileName="+encodeURI(fileName)
				+ '&pageIndex='+ e.pageIndex  + '&pageSize=' + e.pageSize;
		}

	   function ShowImageUploadDialog(config){
		   _UploadDialogShowFile({
				from:'SELF',
				types:'Image',
				single:false,
				showMgr:false,
				callback:function(files){
					config.callback.call(this,files);
				}
			});
		   
		}
	   
	   function clickImgFile(link,single){
		   var rck=$(link).siblings("input[name='imgFile']");
		   rck.attr('checked',true);
		  if(single){
			  CloseWindow('ok');
		  }
	   }
	   	//上传
	   	function upload(){
	   		ShowImageUploadDialog({callback:function(){
	   			window.location.reload();
	   		}});
	   	}
	   	//更新
	   	function refresh(){
	   		window.location.reload();
	   	}
	   	//获得选择的图片
	   	function getImages(){
	   		var imgs=[];
	   		$("input[name='imgFile']:checked").each(function(){
	   		    var ic=$(this);
	   			var img={
	   		    	fileId:ic.val(),
	   		    	fileName:ic.attr('fileName'),
	   		    	filePath:ic.attr('filePath')
	   		    };
	   		 	imgs.push(img);
	   		  });
	   		return imgs;
	   		//return $("input[name='imgFile']:checked").val();	
	   	}
	   	
	   	//获得选择的单个图片
	   	function getImage(){
	   		var imgs=getImages();
	   		if(imgs.length==0) return null;
	   		else return imgs[0];
	   	}
	   	//删除图片
	   	function onItemRemove(e){

	   		var fileId=curDiv.children('img').attr('fileid');

	   		$.ajax({
                url: "${ctxPath}/sys/core/sysFile/delImageFile.do?fileId="+fileId,
                success: function (text) {
                	window.location.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
	   	}
	   	//打开图片
	   	function onItemOpen(e){
	   		var fileId=curDiv.attr("fileId");
	   		var wh=getWindowSize();
	   		mini.open({
		        allowResize: true, //允许尺寸调节
		        allowDrag: true, //允许拖拽位置
		        showCloseButton: true, //显示关闭按钮
		        showMaxButton: true, //显示最大化按钮
		        showModal: true,
		        //只允许上传图片，具体的图片格式配置在config/fileTypeConfig.xml
		        url: "${ctxPath}/sys/core/sysFile/imgPreview.do?fileId="+fileId,
		        title: "图片预览", width: wh.width, height: wh.height
		       
		    });
	   	}
	   	
	  

   </script>
</body>
</html>