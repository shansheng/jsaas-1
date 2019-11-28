<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>${proItemName}</title>
<style>
/*icon图标引用*/
@font-face {font-family: "iconfont";
  src: url('iconfont.eot?t=1527051188652'); /* IE9*/
  src: url('iconfont.eot?t=1527051188652#iefix') format('embedded-opentype'), /* IE6-IE8 */
  url('data:application/x-font-woff;charset=utf-8;base64,d09GRgABAAAAAAVAAAsAAAAAB8wAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAABHU1VCAAABCAAAADMAAABCsP6z7U9TLzIAAAE8AAAARAAAAFZW7kf5Y21hcAAAAYAAAABkAAABnM7EabpnbHlmAAAB5AAAAVMAAAF85S39BmhlYWQAAAM4AAAALwAAADYRdW1laGhlYQAAA2gAAAAcAAAAJAfeA4VobXR4AAADhAAAABAAAAAQD+kAAGxvY2EAAAOUAAAACgAAAAoBNACabWF4cAAAA6AAAAAfAAAAIAETAF1uYW1lAAADwAAAAUUAAAJtPlT+fXBvc3QAAAUIAAAAOAAAAFLRf8CMeJxjYGRgYOBikGPQYWB0cfMJYeBgYGGAAJAMY05meiJQDMoDyrGAaQ4gZoOIAgCKIwNPAHicY2Bk/sU4gYGVgYOpk+kMAwNDP4RmfM1gxMjBwMDEwMrMgBUEpLmmMDgwVDzjZW7438AQw9zA0AAUZgTJAQAk+Qx7eJzFkNENgCAMRO8ADTGyiZ/GgfxiBCbuGthWfpiAI4+2l4aSAtgAROVSEsAKwvSqS/cjDvcTHq2znqCxCaX0PmUmekf2LNjL3LFMXDd61un3PSrbdxvoF2Vge5Xyg/gBFlsPq3icZcy9TsJgFMbx93lrW4pQ2relX3y2CNVgSay1DkZYHNQ4mLjo6ASLBicWBxxMHBwYmY2Jt+DABXgJrkYvwCsottHNk5OTnOH/Izwhyw9uwVlEI+tkixyQU0IgdOHJtAbXj3q0i7LLl01d5vyW74otr8ftw/QE3QjjqGMKolCCjDq23TD2e9THTtSnewiNGmBXnDPWrjJuhrzl1++TY/qEcqNVLfWD5GhzoIdNLTcpMGYz9pgTeD5H6UpJxpVpSLyUF5JnvuSUF40N2kDB9p2Ti2Kzwi4fouta25SA6RRapSm/DFRHTffWMTRmi0oxZznF1pqOydeqpRVqnU+SDrLDvdE7ohDSRieKw9SIQ0MXIXh4T25UL2AYYsgCT02/3gwzNfCUZI6R4gVqMlb+nOUrB+4wc6Q07US70i8HQ6ffyTiLMErmWYSZgvP/NCE/MYI/6gB4nGNgZGBgAOL8K//b4vltvjJwszCAwHVtkS0I+v8OFgZmDyCXg4EJJAoANaYKHQB4nGNgZGBgbvjfwBDDwgACQJKRARWwAABHCgJtBAAAAAPpAAAEAAAABAAAAAAAAAAAdgCaAL4AAHicY2BkYGBgYQhkYGUAASYg5gJCBob/YD4DABESAXEAeJxlj01OwzAQhV/6B6QSqqhgh+QFYgEo/RGrblhUavdddN+mTpsqiSPHrdQDcB6OwAk4AtyAO/BIJ5s2lsffvHljTwDc4Acejt8t95E9XDI7cg0XuBeuU38QbpBfhJto41W4Rf1N2MczpsJtdGF5g9e4YvaEd2EPHXwI13CNT+E69S/hBvlbuIk7/Aq30PHqwj7mXle4jUcv9sdWL5xeqeVBxaHJIpM5v4KZXu+Sha3S6pxrW8QmU4OgX0lTnWlb3VPs10PnIhVZk6oJqzpJjMqt2erQBRvn8lGvF4kehCblWGP+tsYCjnEFhSUOjDFCGGSIyujoO1Vm9K+xQ8Jee1Y9zed0WxTU/3OFAQL0z1xTurLSeTpPgT1fG1J1dCtuy56UNJFezUkSskJe1rZUQuoBNmVXjhF6XNGJPyhnSP8ACVpuyAAAAHicY2BigAAuBuyAhZGJkZmRhZGVgbFCMDM5Py8+sagovzw+Kb+kJD9XAEmkKDM9o4SBAQAqhQ6U') format('woff'),
  url('iconfont.ttf?t=1527051188652') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/
  url('iconfont.svg?t=1527051188652#iconfont') format('svg'); /* iOS 4.1- */
}
.iconfont {
  font-family:"iconfont" !important;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.up:before {
	content: "\e601";
	font-size:16px;
	font-weight:bolder; 
	}
.down:before {
	content: "\e60d";
	font-size:16px;
	font-weight:bolder; 
};
*{
	color:#666;
}
input{
	margin:0;
	padding:0;
}
h1,h2,h3,h4,h5,h6{
	font-weight:normal;
	font-size:16px;
}
h1{
	padding:0;
	margin:0;
}

ul{
	margin:0;
	padding:0;
}
#nav ul li{
	
	white-space:nowrap;
	overflow: hidden;
	text-overflow:ellipsis;

}

html{
	height:100%;
	overflow:hidden;
}

body{
	margin:0;
	height:100%;
}

#header {
	position: relative;
	height:60px;
    background-color:#333;
    text-align:center;
    overflow:hidden;
}
#header h1{
	color: #fff;
	font-size:20px;
	text-align: center;
	white-space:nowrap;
	line-height:60px;
}


#center {
	position: relative;
    width:100%;
	height:100%; 
	float: left;
}

#section {	
    background: #fff;
    -webkit-overflow-scrolling:touch; 
    overflow: scroll; 
}


#footer {
    background-color:black;
    color:white;
    clear:both;
    text-align:center;
	bottom:0px; 
	height:5%;
}
*{
	font-family: "微软雅黑";
}
	


#nav {
	position: relative;
    background:#F9F9F9;
    float:left;
    height:100%;
    overflow:auto;
    
}

#nav>ul{
	line-height:32px;
	list-style-type:none;
}

#nav li ul{
	padding: 0 0 0 26px;	
	line-height:30px;
	list-style-type:none;
}
.artIndex{
	cursor:pointer;
	padding: 0 8px 0 4px;
	outline: none;
	-webkit-tap-highlight-color: rgba(0,0,0,0);
　　	-webkit-tap-highlight-color: transparent;
}

.artIndex:hover{
	color:#B22222;
}
.redFont{
	color:#B22222;
}

#header #btn-a{
	position: absolute;
	left:10px;
	top:10px;
	width:40px;
	height:40px;
	text-align: center;
	line-height: 40px;
	cursor:pointer;
	outline: none;
	-webkit-tap-highlight-color: rgba(0,0,0,0);
　　	-webkit-tap-highlight-color: transparent;
}
#header #btn-a .btn-menu{
	width:30px;
	height:3px;
	background:#fff;
	margin:5px auto;
}
#total{
	position: relative;
	overflow: hidden;
	height: 100%;
}
#total #left{
	height:100%;
	background:#F9F9F9;
	float: left;
	
}
#total #atuo{
	position: absolute;
	width: 100%;
	height: 100%;
	top:0;
}

#total #left #left-top{
	width:100%;
	background:#fff;
	height:70px;
	line-height:70px;
	padding-left:15px;
}
#total #left input{
	height:70px;
	border:0px;
	width:85%;
	padding-left:15px;
	padding-right:15px;
	outline: none;
	font-size:16px;
}

@media only screen and (min-width: 100px) and (max-width: 790px) {
	#header #btn-a{
		top:10px;
	}
	#header{
		padding:0px;
	}
	#header h1{
		font-size:16px;
	}
	#total #left input{
		height:60px;
		-webkit-tap-highlight-color:rgba(0,0,0,0);
	}
	#total #left #left-top{
		height:60px;
		line-height:60px;
	}
	#section { 
    	overflow-y:scroll;
	}
}

</style>
<#macro menuTree menus num> 
  <#if menus?? && menus?size gt 0> 
  <ul>
   <#list menus as menu> 
  	<li><a class="artIndex iconfont <#if menu.children?? && menu.children?size gt 0>up</#if>" id="${menu.id}" 
  	<#if (util.isNotEmpty(menu.content)) >
  	 onclick="changeIframe('${menu.id}')"
  	</#if>
  	 >${num}${menu_index+1} ${menu.title}</a>
  	<#if menu.children?? && menu.children?size gt 0> 
    <@menuTree menus = menu.children num=num+((menu_index+1))+'.'/> 
   </#if> 
  	</li>
   </#list> 
   </ul>
  </#if> 
 </#macro>
</head>
<body >
<div style="position:fixed;height:100%;width:100%;bottom: 0px;top:0px;">

<div id="center">
	<div id="total">
		<div id="left">
			<div id="left-top">在线预览文档</div>
			<div id="nav">
			  <@menuTree menus = dto  num=''/>
			</div>
		</div>
		<div id="atuo">
			<div id="header">
				<h1>${proItemName}</h1>
				<div id="btn-a" onclick=btn()>
					<div class="btn-menu" style="margin-top:10px;"></div>
					<div class="btn-menu"></div>
					<div class="btn-menu"></div>
				</div>
			</div>
			<div id="section">
			  <iframe id="contentFrame" frameborder="0" scrolling="1"   style="width: 100%;height:100%;" src="home.html"></iframe>
			</div>
		</div>
	</div>
	
</div>



</div>
<script type="text/javascript">
    function changeIframe(id) {
			var EL = document.getElementById(id);
			var iframeEL = document.getElementById("contentFrame");
			iframeEL.setAttribute("src", "./html/" + id + ".html");
			if (EL.nextElementSibling) {
				if (EL.nextElementSibling.hidden) {
					EL.nextElementSibling.hidden = false;
					EL.classList.add("up");
					EL.classList.remove("down");
				} else {
					EL.nextElementSibling.hidden = true;
					EL.classList.add("down");
					EL.classList.remove("up");
				}
			}
			var redEL = document.getElementsByClassName("redFont");
			if (redEL[0]) {
				redEL[0].classList.remove("redFont");
			}
			EL.classList.add("redFont");
			
			if(window.innerWidth <= 790){
				atuo.style.cssText += ";transition:left 0.3s;-webkit-transition:left 0.3s;-moz-transition:left 0.3s;-o-transition:left 0.3s;"
				atuo.style.left = 0 + "px";
			}
		}
		
	var atuo = document.getElementById("atuo");
	var nav = document.getElementById("nav");
	var w = window.innerWidth;
	var navWidth =nav.offsetWidth;
	
	function btn(){
		if(w <=790){
			if(atuo.offsetLeft != 0 ){
				atuo.style.cssText += ";transition:left 0.5s;-webkit-transition:left 0.5s;-moz-transition:left 0.5s;-o-transition:left 0.5s;"
				atuo.style.left = 0 + "px";
				nav.style.width = w*0.6 +"px";
			}else{
				atuo.style.cssText += ";transition:left 0.5s;-webkit-transition:left 0.5s;-moz-transition:left 0.5s;-o-transition:left 0.5s;"
				atuo.style.left = w*0.6 + "px";
				nav.style.width = w*0.6 +"px";
			}
		}else{
			if(atuo.offsetLeft != 0 ){
				atuo.style.cssText += ";transition:all 0.5s;-webkit-transition:all 0.5s;-moz-transition:all 0.5s;-o-transition:all 0.5s;"
				atuo.style.left = 0 + "px";
				atuo.style.width = 100 +"%";
			}else{
				atuo.style.cssText += ";transition:all 0.5s;-webkit-transition:all 0.5s;-moz-transition:all 0.5s;-o-transition:all 0.5s;"
				atuo.style.left = navWidth + "px";
				atuo.style.width = w - navWidth + "px";
				
			}
		}
	}
	section.style.height = window.innerHeight - 60 +"px"
	if(window.innerWidth <= 790){
		nav.style.width = w*0.6 +"px";
		atuo.style.left = w*0.6 + "px";
		
	}else{
		atuo.style.left = navWidth + "px";
		
		atuo.style.width = w - navWidth + "px";	
	}
	
	
	


</script>
</body>
</html>