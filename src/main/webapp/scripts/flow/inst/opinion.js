function drawNodeJump(e) {
    var record = e.record,
    field = e.field,
    value = e.value;
  	var ownerId=record.ownerId;
    if(field=='handlerId'){
    	if(ownerId && ownerId!=value){
    		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>&nbsp;代('+ '<a class="mini-user" iconCls="icon-user" userId="'+ownerId+'"></a>)';
    	}else if(value){
    		e.cellHtml='<a class="mini-user" iconCls="icon-user" userId="'+value+'"></a>';
    	}else{
    		e.cellHtml='<span style="color:red">无</span>';
    	}
    } 
    if(field=='remark'){
    	var attachHtml=getAttachMents(record.attachments);
    	e.cellHtml='<span style="line-height:15px;">'+attachHtml+'</span>';
    }
    if(field=='checkStatusText'){
    	e.cellHtml='<span style="line-height:15px;">'+value+'</span>';
    }
    if(field=='nodeName'){
    	e.cellHtml='<span style="line-height:15px;">'+value+'</span>';
    }
}

/**
 * 获取附件。
 * @param attachments
 * @returns
 */
function getAttachMents(attachments){
	if (!attachments || attachments.length==0) return "";
	var aryFile=[];
	for(var i=0;i<attachments.length;i++){
		var attach= attachments[i];
		var fileId=attach.fileId;
		var type=attach.type;
		var isDown=attach.isDown;
		var isPrint=attach.isPrint;
		var fileName=attach.fileName;
		
		if(("xls"==type ||"xlsx"==type) && !_enable_openOffice){
			aryFile.push("<br><img src='"+__rootPath+"/styles/icons/excel.png' /><a  href='#' onclick='_openDoc(\""+fileId+"\");'><span style='color:#4f50f2;' >"+fileName+"</span></a>");
		}else if(("doc"==type||"docx"==type) && !_enable_openOffice){
			aryFile.push("<br><img src='"+__rootPath+"/styles/icons/doc.png' /><a  href='#' onclick='_openDoc(\""+fileId+"\");'><span style='color:#4f50f2;' >"+fileName+"</span></a>");
		}else if(("ppt"==type||"pptx"==type) && !_enable_openOffice){
			aryFile.push("<br><img src='"+__rootPath+"/styles/icons/ppt.png' /><a  href='#' onclick='_openDoc(\""+fileId+"\");'><span style='color:#4f50f2;' >"+fileName+"</span></a>");
		}else if("pdf"==type || _enable_openOffice){
			var imgPath = __rootPath+"/styles/icons/pdf.png";
			if("xls"==type ||"xlsx"==type){
				imgPath=__rootPath+"/styles/icons/excel.png";
			}else if("doc"==type||"docx"==type){
				imgPath=__rootPath+"/styles/icons/doc.png";
			}else if("ppt"==type||"pptx"==type){
				imgPath=__rootPath+"/styles/icons/ppt.png";
			}
			aryFile.push("<br><img src='"+imgPath+"' /><a target='_blank' href='"+__rootPath+"/scripts/PDFShow/web/viewer.html?file="+__rootPath+"/sys/core/file/download/"+fileId+".do'><span style='color:#4f50f2;' >"+fileName+"</span></a>");
		}else if("png"==type||"jpg"==type||"gif"==type||"jpeg"==type||"bmp"==type){
			aryFile.push("<br><img src='"+__rootPath+"/styles/icons/picture.png' /><a target='_blank' href='"+__rootPath+"/sys/core/file/previewOffice.do?fileId="+fileId+"'><span style='color:#4f50f2;' >"+fileName+"</span></a>");
		}else if("txt"==type){
			aryFile.push("<br><img src='"+__rootPath+"/styles/icons/txt.png' /><a target='_blank' href='"+__rootPath+"/sys/core/file/previewOffice.do?fileId="+fileId+"'><span style='color:#4f50f2;' >"+fileName+"</span></a>");
		}
		else{
			aryFile.push("<br><a target='_blank' href='"+__rootPath+"/sys/core/file/download/"+fileId+".do'><span style='color:#4f50f2;' >"+fileName+"</span></a>");
		}
		
		if("true"==isDown){
			aryFile.push("<a target='_blank' href='"+__rootPath+"/sys/core/file/download/"+fileId+".do'><image style='margin-left:15px;cursor:pointer;border:0;' href='"+__rootPath+"/sys/core/file/previewOffice.do?fileId="+fileId+"'  src='"+__rootPath+"/styles/icons/download.png'  /></a>");
		}
	
	}
	return aryFile.join("");
}