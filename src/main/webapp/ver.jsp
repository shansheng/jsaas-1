<%@page import="com.redxun.core.util.PropertiesUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>版本号</title>
</head>
<body>
jsaas 版本:
<%=PropertiesUtil.getProperty("jsaas.version") %>
</body>
</html>