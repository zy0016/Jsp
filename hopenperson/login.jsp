<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="jc" scope="application" class="JavaBean.JavaConst.JavaConst"/>

<html>
<head>
<title>登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="font.css" rel="stylesheet" type="text/css">
<link href="buttonwidth.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
function verify()
{
	var message="";
	if (form1.username.value=="")
	{
		message="请输入您登录到域中的用户名。";
		form1.username.focus();
	}
	else if(form1.password.value=="")
	{
		message="请输入您在个人信息维护系统中设置过的登录密码。";
		form1.password.focus();
	}
	else if(form1.username.value.indexOf("'")>=0)
	{
		message="请不要输入单引号。";
		form1.username.focus();
	}
	else if(form1.password.value.indexOf("'")>=0)
	{
		message="请不要输入单引号。";
		form1.password.focus();
	}
	else if (form1.field.value=="null")
	{
		message="请选择您登录的域。";
		form1.field.focus();
	}
	if (message!="")
	{
		alert(message);
		return false;
	}
	else
		return true;
}
</script>
<%
String passlen=ODB.executeQuery_String("select passmaxlength from account_set");
session.putValue("id","");
session.putValue("account","");
%>
<body background="image/back0.jpg">
<form action="logins.jsp" method="post" name="form1" id="form1">
  <table width="903" border="0" class="font">
    <tr> 
      <td colspan="2"><div align="center"><font size="5">欢迎登录个人信息维护系统</font></div></td>
    </tr>
    <tr> 
      <td width="379"> <div align="right">用户名</div></td>
      <td width="514"> <input name="username" type="text" id="username" onmousemove="JavaScript:this.focus()" onfocus="JavaScript:this.select()">
        您登录到域中的用户名</td>
    </tr>
    <tr> 
      <td><div align="right">密码</div></td>
      <td><input name="password" type="password" id="password" onfocus="JavaScript:this.select()" onmousemove="JavaScript:this.focus()" maxlength="<%=passlen%>">
        您在个人信息维护系统中设置过的登录密码</td>
    </tr>
    <tr> 
      <td> <div align="right">所在域</div></td>
      <td><select name="field" id="select">
          <option value="null" selected>选择您登录帐号的所属域</option>
          <%
		  String fName="";//域名组合
		  String separator="*",subfname="";
		  int i=0;
		  separator=jc.separator;
		  separator="*";
		  fName=ODB.executeQuery_String("select field from account_set");
		  while (true)
		  {
				i=fName.indexOf(separator);
				if (i==-1)
				{
					out.println("<option value="+fName+">"+fName+"</option>");
					break;
				}
				subfname=fName.substring(0,i);
				out.println("<option value="+subfname+">"+subfname+"</option>");
				fName=fName.substring(i+1);
		  }
		  %>
        </select> </td>
    </tr>
    <tr> 
      <td> <div align="right"> 
          <input name="Submit" type="submit" class="buttonwidth" onclick="return verify();" value="确定">
        </div></td>
      <td> <input name="Submit2" type="reset" class="buttonwidth" value="重新填写"></td>
    </tr>
  </table>
</form>
</body>
</html>
