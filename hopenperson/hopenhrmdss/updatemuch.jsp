<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>工号重复时修改数据</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
<link href="font.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="er" scope="page" class="JavaBean.ErrorManage.ErrorManage"/>
<jsp:useBean id="ODBUP" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBlog" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<body background="image/back0.jpg" class="font">
<%
String account=(String)session.getValue("account");//员工帐号
if (account==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,请重新<a href=login.jsp>登录</a>。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}

String txtn			=	(String)session.getValue("txtn");
String seln			=	(String)session.getValue("seln");
String truetable	=	request.getParameter("truetable");//获得表名
String id_identity	=	request.getParameter("id_identity");//获得数据的编号

int txti	=	Integer.parseInt(txtn);
int seli	=	Integer.parseInt(seln);
String sql	=	"update "+truetable+" set ";

for (int i=1;i<=txti;i++)
{
	String field_name	=	request.getParameter("htxt"+String.valueOf(i));//获得实际字段名
	String field_value	=	request.getParameter("txt"+String.valueOf(i));//获得用户的输入数据
	String T	=	field_name.substring(0,1);
	
	if (T.equals("T"))//是日期形数字,检测日期是否合法
	{
		boolean just=true;
		just=er.JustDateTime(field_value);
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
			sql=sql+" "+field_name.substring(1)+"='"+field_value+"',";
		}
	}
	else
	{
		field_value=new String(field_value.getBytes("ISO8859-1"));
		if (field_value.indexOf("'")>=0)
		{
			session.putValue("errormessage","请不要输入单引号。");
			%>
			<jsp:forward page="errormessage.jsp" />
			<%
		}
		sql=sql+" "+field_name+"='"+field_value+"',";
	}
}
for (int i=1;i<=seli;i++)
{
	String field_name	=	request.getParameter("hsel"+String.valueOf(i));
	String field_value	=	request.getParameter("sel"+String.valueOf(i));
	sql=sql+" "+field_name+"='"+field_value+"',";
}
sql=sql.substring(0,sql.length()-1)+" where id_identity="+id_identity;//更新的SQL语句

if (ODBUP.executeUpdate(sql)!=-1)//更新成功
{
	ODBlog.SaveUpdateLog(account,sql);
	%>
	<div align="center">您的数据已经更新成功。<br>
	<a href=IniBaseInfoPeoplem.jsp?truetable=<%= truetable%> target=fraRightFrame>确定</a></div>
	<%
}
else
{
	session.putValue("errormessage","数据更新失败，您可能输入了非法的数据。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
%>

</body>
</html>
