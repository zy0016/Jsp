<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%
String account=(String)session.getValue("account");//员工帐号
if (account==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,您可能还没有登录。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
%>
<html>
<head>
<title>用户是否已经登录的的判断</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
453
</body>
</html>
