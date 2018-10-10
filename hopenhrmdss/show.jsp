<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
<%
out.println("getContextPath():"+request.getContextPath()+"<br>");
out.println("getLocale():"+request.getLocale()+"<br>");
out.println("getLocales():"+request.getLocales()+"<br>");
out.println("getPathInfo():"+request.getPathInfo()+"<br>");
out.println("getRealPath():"+request.getRealPath("show.jsp")+"<br>");
out.println("getRequestURI():"+request.getRequestURI()+"<br>");
out.println("getServerName():"+request.getServerName()+"<br>");
out.println("getServletPath():"+request.getServletPath()+"<br>");
out.println("getServletPath():"+application.getRealPath(String path)+"<br>");
%>
</body>
</html>
