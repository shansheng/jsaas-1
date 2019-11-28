<%@page import="com.redxun.sys.core.util.OpenOfficeUtil"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%@include file="/commons/dynamic.jspf" %>
<%@ taglib prefix="rxTag" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="imgArea" uri="http://www.redxun.cn/imgAreaFun"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="rxc"  uri="http://www.redxun.cn/commonFun" %>
<script type="text/javascript">
var _enable_openOffice = <%=OpenOfficeUtil.isOpenOfficeEnabled()%>;
</script>
<link href="${ctxPath}/styles/customform.css?version=${static_res_version}" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/styles/icons.css?version=${static_res_version}" rel="stylesheet" type="text/css" />
<script src="${ctxPath}/scripts/mini/boot.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jquery.getscripts.js?version=${static_res_version}"	></script>
<script src="${ctxPath}/scripts/common/util.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/common/form.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/jquery/plugins/jquery-grid.js?version=${static_res_version}"	type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/plugins/qtips/jquery.qtip.min.css?version=${static_res_version}" />
<script src="${ctxPath}/scripts/jquery/plugins/qtips/jquery.qtip.min.js?version=${static_res_version}" type="text/javascript"></script>
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/textarea/jquery-textarea-autoHeight.js?version=${static_res_version}"></script>
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/fullscreen/jquery.fullscreen.js?version=${static_res_version}"></script>
<script type="text/javascript" charset="utf-8"	src="${ctxPath}/scripts/ueditor/form-design/ueditor-ext.js?version=${static_res_version}"></script>
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/scrollfix/scrollfix.min.js?version=${static_res_version}"></script>
<script src="${ctxPath}/scripts/common/baiduTemplate.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/customer/mini-custom.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/form/customFormUtil.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/form/CustomQuery.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/form/FormCalc.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/form/RelationGrid.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/form/DivCalc.js?version=${static_res_version}" type="text/javascript"></script>
<script src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}" type="text/javascript"></script>

<link href="${ctxPath}/styles/commons.css?version=${static_res_version}" rel="stylesheet" type="text/css" />
<link href="${ctxPath}/styles/formFile.css?version=${static_res_version}" rel="stylesheet" type="text/css" />