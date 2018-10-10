
<html>
<head>
<title>登录失败</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Refresh" content="4;url=login.jsp">
</head>

<body>
<% 
String name=(String)session.getValue("username");
 %>
您输入的用户名：<%= name%> 可能不存在，或是您输入的密码错误。<br>
<p align="center" class="unnamed1"><a href="login.jsp">登录失败</a> </p>
</body>
</html>
