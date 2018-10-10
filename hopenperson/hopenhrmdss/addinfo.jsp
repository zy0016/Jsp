<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>保存新建的数据</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
<link href="font.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<jsp:useBean id="ODBlog" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<body background="image/back0.jpg" class=font>
<%
String id		=	(String)session.getValue("id");//员工id
String account	=	(String)session.getValue("account");//员工帐户
if (id==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,请重新<a href=login.jsp>登录</a>。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
String txtn			=	(String)session.getValue("txtn");
String seln			=	(String)session.getValue("seln");
String colnames0	=	(String)session.getValue("colnames0");
String colnames1	=	(String)session.getValue("colnames1");
if (colnames0!=null)
	if (!colnames0.equals(""))
		colnames0=colnames0.substring(0,colnames0.length()-1);//列名的组合用于添加数据(输入数据的字段组合)
	else
		colnames0="";
else
	colnames0="";

if (colnames1!=null)
	if (!colnames1.equals(""))
		colnames1=colnames1.substring(0,colnames1.length()-1);//列名的组合用于添加数据(选择数据的字段组合)
	else
		colnames1="";
else
	colnames1="";

String truetable=request.getParameter("truetable");//获得表名
String sql="";
int txti	=	Integer.parseInt(txtn);
int seli	=	Integer.parseInt(seln);

if (colnames1.equals(""))
	sql="insert into "+truetable+" (id,"+colnames0+") values("+id+",";
else if (colnames0.equals(""))
	sql="insert into "+truetable+" (id,"+colnames1+") values("+id+",";
else
	sql="insert into "+truetable+" (id,"+colnames0+","+colnames1+") values("+id+",";

for (int i=1;i<=txti;i++)
{
	String field_name	=	request.getParameter("htxt"+String.valueOf(i));//获得实际字段名
	String field_value	=	request.getParameter("txt"+String.valueOf(i));//获得用户的输入数据
	field_value			=	new String(field_value.getBytes("ISO8859-1"));
	String T			=	field_name.substring(0,1);
	
	if (T.equals("T"))//是日期形数字,检测日期是否合法
	{
		boolean just=true;
		//just=er.JustDateTime(field_value);
		just=true;
		if (!just)//非法日期
		{
			session.putValue("errormessage","您输入的日期不合法。");
			%>
			<jsp:forward page="errormessage.jsp" />
			<%
		}
		else//合法日期
		{
			sql=sql+"'"+field_value+"',";
		}
	}
	else
	{
		if (field_value.indexOf("'")>=0)
		{
			session.putValue("errormessage","请不要输入单引号。");
			%>
			<jsp:forward page="errormessage.jsp" />
			<%
		}
		sql=sql+"'"+field_value+"',";
	}
}
for (int i=1;i<=seli;i++)
{
	String field_name	=	request.getParameter("hsel"+String.valueOf(i));
	String field_value	=	request.getParameter("sel"+String.valueOf(i));
	sql = sql+"'"+field_value+"',";
}
sql = sql.substring(0,sql.length()-1)+" )";//更新的SQL语句
if (ODB.executeUpdate(sql)!=-1)//更新成功
{
	ODBlog.SaveUpdateLog(account,sql);
	%><div align="center">您的数据已经更新成功。<br>
	<a href=IniBaseInfoPeoplem.jsp?truetable=<%= truetable%> target=fraRightFrame>确定</a></div>
	<%
}
else
{
	session.putValue("errormessage",sql);//"数据更新失败，您可能输入了非法的数据。"
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
%>
</body>
</html>
