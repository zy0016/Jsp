<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.util.Date"%> 
<html>
<head>
<title>�޸�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script language="JavaScript">
function verify()
{
	var message="";
	if ((form1.password.value=="") || (form1.comfirdpassword.value==""))
		message="�����������ȷ������";
	if (form1.password.value!=form1.comfirdpassword.value)
		message="�����ȷ�����벻���";
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
		%><font color="#FF0000">����ľ�����</font><%
	}
	else
	{
		if (OO.executeUpdate("update S02 set S0202='"+p1+"' where S0201='"+user+"'")==1)
		{
			modify="1";
			%><font color="#FF0000">�޸ĳɹ�������<A HREF="login.jsp" target="_top">��¼</A>��ʹ��������Ч��</font><%
		}
		else
		{
			modify="0";
			%><font color="#FF0000">�޸�ʧ��</font><%
		}
	}
}
%>
</div>
<div align="center">
  <form name="form1" method="post" action="">
  <table width="100%"  border="0">
  <caption align="top">
  �޸���������
  </caption>
  <tr> 
        <td width="50%"><div align="right">�û���</div></td>
        <td width="50%"><input name="username" type="text" id="username" value="<%= (String)session.getValue("username") %>" readonly="true"></td>
  </tr>
    <tr> 
	<td><div align="right">������</div></td>
    <td><input name="oldpassword" type="password" id="oldpassword" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>

  <tr> 
        <td><div align="right">������</div></td>
        <td><input name="password" type="password" id="password" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>
  <tr> 
        <td><div align="right">ȷ������</div></td>
        <td><input name="comfirdpassword" type="password" id="comfirdpassword" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>
  <tr> 
        <td><div align="right"><input name="Submit" type="submit" onClick="return verify()" value="ȷ��" <% if (modify.equals("1")) out.println("disabled=true");%>></div></td>
        <td><input type="reset" name="Submit2" value="����"></td>
  </tr>
</table>

    </p>
</form>
  <p>&nbsp; </p>
</div>
</body>
</html>
