<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="jc" scope="application" class="JavaBean.JavaConst.JavaConst"/>

<html>
<head>
<title>��¼</title>
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
		message="����������¼�����е��û�����";
		form1.username.focus();
	}
	else if(form1.password.value=="")
	{
		message="���������ڸ�����Ϣά��ϵͳ�����ù��ĵ�¼���롣";
		form1.password.focus();
	}
	else if(form1.username.value.indexOf("'")>=0)
	{
		message="�벻Ҫ���뵥���š�";
		form1.username.focus();
	}
	else if(form1.password.value.indexOf("'")>=0)
	{
		message="�벻Ҫ���뵥���š�";
		form1.password.focus();
	}
	else if (form1.field.value=="null")
	{
		message="��ѡ������¼����";
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
      <td colspan="2"><div align="center"><font size="5">��ӭ��¼������Ϣά��ϵͳ</font></div></td>
    </tr>
    <tr> 
      <td width="379"> <div align="right">�û���</div></td>
      <td width="514"> <input name="username" type="text" id="username" onmousemove="JavaScript:this.focus()" onfocus="JavaScript:this.select()">
        ����¼�����е��û���</td>
    </tr>
    <tr> 
      <td><div align="right">����</div></td>
      <td><input name="password" type="password" id="password" onfocus="JavaScript:this.select()" onmousemove="JavaScript:this.focus()" maxlength="<%=passlen%>">
        ���ڸ�����Ϣά��ϵͳ�����ù��ĵ�¼����</td>
    </tr>
    <tr> 
      <td> <div align="right">������</div></td>
      <td><select name="field" id="select">
          <option value="null" selected>ѡ������¼�ʺŵ�������</option>
          <%
		  String fName="";//�������
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
          <input name="Submit" type="submit" class="buttonwidth" onclick="return verify();" value="ȷ��">
        </div></td>
      <td> <input name="Submit2" type="reset" class="buttonwidth" value="������д"></td>
    </tr>
  </table>
</form>
</body>
</html>
