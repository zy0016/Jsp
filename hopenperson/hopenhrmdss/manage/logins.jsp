<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<% 
	String user=request.getParameter("username");
	String pass=request.getParameter("password");

	if (user==null)
		user="";
	if (pass==null)
		pass="";

	String message="";
	int		i=0;

	if (user.equals(""))//用户名为空
		message="请输入您登录到域里的帐号。";
	else if (pass.equals(""))//密码为空
		message="请输入您在个人信息维护系统中设置过的登录密码。";
	
	if (!message.equals(""))//有错误提示
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="..\errormessage.jsp" />
		<%
	}
	String query="select S0201 from S02 where S0201='"+user+"' and S0202='"+pass+"'";
	message="";

	i=odb.executeQuery_long(query);
	if (i==0)//非法用户名
	{
		message="抱歉，未能在域控制器中找到您的登录帐号，您不是合法用户。";
	}
	else if (i==1)//合法用户名
	{
		session.putValue("administrator",user);
		%>	
		<jsp:forward page="default.html" />
		<%
	}

	if (!message.equals(""))//有错误提示
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="..\errormessage.jsp" />
		<%
	}
%> 