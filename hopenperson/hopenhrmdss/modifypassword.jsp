<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.util.Date"%> 
<html>
<head>
<title>�޸�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../font.css" rel="stylesheet" type="text/css">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
<link href="buttonwidth.css" rel="stylesheet" type="text/css">
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
<jsp:useBean id="OO" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<body class="font">
<%
String account	=	(String)session.getValue("account");//Ա���ʻ�
if (account==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,������<a href=login.jsp>��¼</a>��");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}
String passlen=OO.executeQuery_String("select passmaxlength from account_set");
%>

<div align="center">
  <%
String user=request.getParameter("username");
String oldpa=request.getParameter("oldpassword");
String p1=request.getParameter("password");
String modify="";//�Ƿ��޸����
if (user!=null)
{
	if (OO.executeQuery_long("select * from A01_account where account='"+user+"' and password='"+oldpa+"'")==0)
	{
		modify="0";
		%><font color="#FF0000">����ľ�����</font><%
	}
	else
	{
		String sql="update A01_account set password='"+p1+"' where account='"+user+"'";
		if (OO.executeUpdate(sql)==1)
		{
			OO.SaveUpdateLog(account,sql);
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
  <table width="100%"  border="0" class="font">
  <caption align="top">
  �޸���������
  </caption>
  <tr> 
        <td width="50%"><div align="right">�û���</div></td>
        <td width="50%"><input name="username" type="text" id="username" value="<%= (String)session.getValue("account") %>" readonly="true"></td>
  </tr>
    <tr> 
	<td><div align="right">������</div></td>
    <td><input name="oldpassword" type="password" id="oldpassword" onfocus="JavaScript:this.select()" onmousemove="JavaScript:this.focus()" maxlength="<%=passlen%>" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>

  <tr> 
        <td><div align="right">������</div></td>
        <td><input name="password" type="password" id="password" onfocus="JavaScript:this.select()" onmousemove="JavaScript:this.focus()" maxlength="<%=passlen%>" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>
  <tr> 
        <td><div align="right">ȷ������</div></td>
        <td><input name="comfirdpassword" type="password" id="comfirdpassword" onfocus="JavaScript:this.select()" onmousemove="JavaScript:this.focus()" maxlength="<%=passlen%>" <% if (modify.equals("1")) out.println("readonly=true");%>></td>
  </tr>
  <tr> 
        <td><div align="right"><input name="Submit" type="submit" class="buttonwidth" onClick="return verify()" value="ȷ��" <% if (modify.equals("1")) out.println("disabled=true");%>></div></td>
        <td><input name="Submit2" type="reset" class="buttonwidth" value="������д"></td>
  </tr>
</table>

    </p>
</form>
  <p>&nbsp; </p>
</div>
</body>
</html>
