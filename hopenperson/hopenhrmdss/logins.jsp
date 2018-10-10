<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="code" scope="page" class="JavaBean.cryptcode.cryptcode"/>
<% 
	String user		=	request.getParameter("username");
	String pass		=	request.getParameter("password");
	String field	=	request.getParameter("field");

	if (user==null)
		user="";
	if (pass==null)
		pass="";
	if (field==null)
		field="null";

	String account=field+"\\"+user;
	String message="";
	int		i=0;
	String id="";//员工的id

	if (user.equals(""))//用户名为空
		message="请输入您登录到域里的帐号。";
	else if (pass.equals(""))//密码为空
		message="请输入您在个人信息维护系统中设置过的登录密码。";
	else if (field.equals("null"))
		message="请您选择登录的域。";
	
	if (!message.equals(""))//有错误提示
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="errormessage.jsp" />
		<%
	}
	String query="select id from A01_account where account='"+account+"'";
	message="";

	i=odb.executeQuery_long(query);
	if (i==0)//非法用户名
	{
		message="抱歉，未能在域控制器中找到您的登录帐号，您不是合法用户。";
	}
	else if (i==1)//合法用户名
	{
		//pass=code.encrypt(pass);//加密密码
		query="select id from A01_account where account='"+account+"' and password='"+pass+"'";
		id=odb.executeQuery_String(query);
		if (id.equals(""))//错误的密码
			message="错误的密码。";
	}

	if (!message.equals(""))//有错误提示
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="errormessage.jsp" />
		<%
	}
	else//合法用户
	{
		session.putValue("id",id);
		session.putValue("account",account);
		%>	
		<jsp:forward page="default.html" />
		<%
	}
%> 