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

	if (user.equals(""))//�û���Ϊ��
		message="����������¼��������ʺš�";
	else if (pass.equals(""))//����Ϊ��
		message="���������ڸ�����Ϣά��ϵͳ�����ù��ĵ�¼���롣";
	
	if (!message.equals(""))//�д�����ʾ
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="..\errormessage.jsp" />
		<%
	}
	String query="select S0201 from S02 where S0201='"+user+"' and S0202='"+pass+"'";
	message="";

	i=odb.executeQuery_long(query);
	if (i==0)//�Ƿ��û���
	{
		message="��Ǹ��δ��������������ҵ����ĵ�¼�ʺţ������ǺϷ��û���";
	}
	else if (i==1)//�Ϸ��û���
	{
		session.putValue("administrator",user);
		%>	
		<jsp:forward page="default.html" />
		<%
	}

	if (!message.equals(""))//�д�����ʾ
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="..\errormessage.jsp" />
		<%
	}
%> 