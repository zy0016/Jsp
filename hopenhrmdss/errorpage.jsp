<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page isErrorPage="true"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
����ҳ��<br>
<%
if (exception!=null)
{
%>
	�쳣��<%= exception%>
<%
}
 %>
</body>
</html>
