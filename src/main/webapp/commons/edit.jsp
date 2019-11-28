<%@page import="com.redxun.sys.core.util.OpenOfficeUtil"%>
<%@include file="/commons/dynamic.jspf" %>
<%@taglib prefix="rx" uri="http://www.redxun.cn/formFun" %>
<%@taglib  prefix="f" uri="http://www.redxun.cn/func" %>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI"%>

<%@taglib  prefix="cf" uri="http://www.redxun.cn/commonFun" %>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<script type="text/javascript">
var _enable_openOffice = <%=OpenOfficeUtil.isOpenOfficeEnabled()%>;
</script>
<script src="${ctxPath}/scripts/mini/boot.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share.js?version=${static_res_version}" type="text/javascript"></script>
<link href="${ctxPath}/styles/form.css?version=${static_res_version}" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip-blue.css" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/styles/commons.css?version=${static_res_version}" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/styles/formFile.css?version=${static_res_version}" rel="stylesheet" type="text/css" />
<script src="${ctxPath}/scripts/common/form.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/util.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/list.js?static_res_version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jQuery.download.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jquery.getscripts.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jquery.form.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/baiduTemplate.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/customer/mini-custom.js?version=${static_res_version}" type="text/javascript"></script>

<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/powertips/jquery.powertip.min.js"></script>
<script type="text/javascript">
//left sperator <!
baidu.template.LEFT_DELIMITER='<#';
//right sperator <!  
baidu.template.RIGHT_DELIMITER='#>';
</script>
