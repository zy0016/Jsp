<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../font.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#e0e6a6">
<%
String user=(String)session.getValue("administrator");//员工id
if (user==null)
{
	session.putValue("errormessage","未能读取到登录管理员的信息。");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}
%>

<table width="100%" border="0" class="font">
  <tr> 
    <td width="68%" rowspan="2"><h1>人力资源管理系统</h1></td>
    <td width="32%" height="22"></td>
  </tr>
  <tr> 
    <td><%= user%>您好</td>
  </tr>
</table>
</body>
</html>
