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
String account=(String)session.getValue("account");//员工帐号
if (account==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,请重新<a href=login.jsp>登录</a>。");
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
		String tablename	=	rs.getString("table_hz");//显示表名
		String truetable	=	rs.getString("table_name");//实际表名
		String rep			=	rs.getString("repeatable");//工号是否重负
		session.putValue("fname","0");
		out.println("<tr><td>");
		if (rep.equals("0"))//工号不重复
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
	session.putValue("errormessage","读取数据列表失败。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
} 
%>
</body>
</html>
