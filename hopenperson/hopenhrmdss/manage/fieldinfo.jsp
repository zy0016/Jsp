<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>�޸������Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.unnamed1 {
	width: 300px;
}
-->
</style>
<link href="../font.css" rel="stylesheet" type="text/css">
<link href="../buttonwidth.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="jc" scope="application" class="JavaBean.JavaConst.JavaConst"/>

<body background="../image/back0.jpg">
<%
String user=(String)session.getValue("administrator");//Ա��id
if (user==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼����Ա����Ϣ��");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}

String fieldnames=request.getParameter("fieldnames");
if (fieldnames!=null)//���������Ϣ
{
	if (fieldnames.equals(""))
	{
		session.putValue("errormessage","������������");
		%>
		<jsp:forward page="..\errormessage.jsp" />
		<%
	}
	else
	{
		String sql="update account_set set field='"+fieldnames+"'";
		int i=odb.executeUpdate(sql);
		odb.SaveUpdateLog(user,sql);
	}
}

String fields=odb.executeQuery_String("select field from account_set");
String separator=jc.separator;

%>
<form method=post action="">

<table width="648" border="0" class="font">
  <tr> 
    <td colspan="2"> <div align="center">������ϸ�������֮�����á�<%= separator%>������
        <input name="fieldnames" type="text" class="unnamed1" id="fieldnames" value=<%= fields%>>
      </div></td>
  </tr>
  <tr> 
    <td width="355"> <div align="right">
        <input name="Submit" type="submit" class="buttonwidth" value="ȷ��">
      </div></td>
    <td width="283">
        <input name="Submit2" type="reset" class="buttonwidth" value="����">
      </td>
  </tr>
</table>
</form>
</body>
</html>
