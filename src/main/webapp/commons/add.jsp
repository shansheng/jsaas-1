<%@page import="com.redxun.sys.core.util.OpenOfficeUtil"%>
<%@include file="/commons/dynamic.jspf" %>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib  prefix="f" uri="http://www.redxun.cn/func" %>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<%@taglib  prefix="cf" uri="http://www.redxun.cn/commonFun" %>
<script type="text/javascript">
    var _enable_openOffice = <%=OpenOfficeUtil.isOpenOfficeEnabled()%>;
</script>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<link href="${ctxPath}/styles/css/swiper.min.css?static_res_version=${static_res_version}" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/styles/css/indexx.css?static_res_version=${static_res_version}" rel="stylesheet" type="text/css" />
<script src="${ctxPath}/scripts/swiper/swiper.min.js?static_res_version=${static_res_version}" type="text/javascript"></script>
<link href="${ctxPath}/styles/list.css?static_res_version=${static_res_version}" rel="stylesheet" type="text/css" />
<script src="${ctxPath}/scripts/share.js?static_res_version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/mini/boot.js?static_res_version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jQuery.download.js?static_res_version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/util.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/list.js?static_res_version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/form.js?static_res_version=${static_res_version}" type="text/javascript"></script>
<link href="${ctxPath}/styles/commons.css?static_res_version=${static_res_version}" rel="stylesheet" type="text/css" />
<script src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jquery.getscripts.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/baiduTemplate.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/customer/mini-custom.js?version=${static_res_version}" type="text/javascript"></script>