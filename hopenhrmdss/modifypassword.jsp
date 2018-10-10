<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.util.Date"%> 
<html>
<head>
<title>修改密码</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script language="JavaScript">
function verify()
{
	var message="";
	if ((form1.password.value=="") || (form1.comfirdpassword.value==""))
		message="请输入密码和确认密码";
	if (form1.password.value!=form1.comfirdpassword.value)
		message="密码和确认密码不相等";
	if (message!="")
	{
		alert(message);
		return false;
	}
	return true;
}
</script>
<body>
<jsp:useBean id="OO" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<div align="center">
  <%
String user=request.getParameter("username");
String oldpa=request.getParameter("oldpassword");
String p1=request.getParameter("password");
String modify="";
if (user!=null)
{
	if (OO.executeQuery_long("select * from S02 where S0201='"+user+"' and S0202='"+oldpa+"'")==0)
	{
		modify="0";
		%><font color="#FF0000">错误的旧密码</font><%
	}
	else
	{
		if (OO.executeUpdate("update S02 set S0202='"+p1+"' where S0201='"+user+"'")==1)
		{
			modify="1";
			%><font color="#FF0000">修改成功请重新<A HREF="login.jsp" target="_top">登录</A>以使新密码生效。</font><%
		}
		else
		{
			modify="0";
			%><font color="#FF0000">修改失败</font><%
		}
	}
}
%>
</div>
<div align="center">
  <form name="form1" method="post" action="">
  <table width="100%"  border="0">
  <caption align="top">
  修改您的密码
  </caption>
  <tr> 
        <td width="50%"><div align="right">用户名</div></td>
        <td width="50%"><input name="username" type="text" id="username" value="<%= (String)session.getValue("username") %>" readonly="true"></td>
  </tr>
    <tr> 
	<td><div align="right">旧密码</div></td>
    <td><input name="oldpassword" type="password" id="oldpassword" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>

  <tr> 
        <td><div align="right">新密码</div></td>
        <td><input name="password" type="password" id="password" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>
  <tr> 
        <td><div align="right">确认密码</div></td>
        <td><input name="comfirdpassword" type="password" id="comfirdpassword" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>
  <tr> 
        <td><div align="right"><input name="Submit" type="submit" onClick="return verify()" value="确定" <% if (modify.equals("1")) out.println("disabled=true");%>></div></td>
        <td><input type="reset" name="Submit2" value="重填"></td>
  </tr>
</table>

    </p>
</form>
  <p>&nbsp; </p>
</div>
</body>
</html>
