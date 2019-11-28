<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>${title}</title>
<style>
html{
	height:100%;
	width:100%;
}

body{
	margin:0;
	height:100%;
}

.title{
	text-align:center;
	font-weight:bold;
}

html body img{
	width: auto!important;  
    height: auto!important;  
    max-width: 100%!important;  
    max-height: 100%!important;  
		
}
html body table{
	width: auto!important;
	max-width: 100%!important; 
	white-space:normal!important;
	word-break:break-all!important;
}
.table-view{
	border:1px solid #ececec;
	border-collapse:collapse;
	white-space:normal!important; 
	word-break:break-all!important;
}

.table-view td{
	border:1px solid #ececec;
	padding:5px 5px 5px 5px;
	word-break:break-all!important;
	white-space:normal!important; 
	
}

.content{
	padding:10px 10px 10px 10px; 
	
}


</style>
</head>
<body >
	<div class="content">${content}</div>
</body>
</html>