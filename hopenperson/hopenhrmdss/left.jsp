<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
<link href="font.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<body background="image/back0.jpg">
<table width=200 border=0>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

<%
String account=(String)session.getValue("account");//Ա���ʺ�
if (account==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,������<a href=login.jsp>��¼</a>��");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}

ResultSet rs=null;
String sql="select table_hz,table_name,repeatable from BasInfTMenu where flag='1' and (memo='10' or memo='11' or memo='14' or memo='15')";
try
{
	%>
	<table width=200 border=0 class="font">
	<%
	rs=odb.executeQuery(sql);
	while (rs.next())
	{
		String tablename	=	rs.getString("table_hz");//��ʾ����
		String truetable	=	rs.getString("table_name");//ʵ�ʱ���
		String rep			=	rs.getString("repeatable");//�����Ƿ��ظ�
		session.putValue("fname","0");
		out.println("<tr><td>");
		if (rep.equals("0"))//���Ų��ظ�
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;<a href=IniBaseInfoPeople.jsp?truetable="+truetable+" target=fraRightFrame>"+tablename+"</a>");
		else
			out.println("&nbsp;&nbsp;&nbsp;&nbsp;<a href=IniBaseInfoPeoplem.jsp?truetable="+truetable+" target=fraRightFrame>"+tablename+"</a>");
		out.println("</td></tr>");
	}
	%>
	</table>
	<%
}
catch (SQLException e)
{
	session.putValue("errormessage","��ȡ�����б�ʧ�ܡ�");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
} 
%>
</body>
</html>
