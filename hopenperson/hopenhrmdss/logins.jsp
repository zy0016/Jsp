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
	String id="";//Ա����id

	if (user.equals(""))//�û���Ϊ��
		message="����������¼��������ʺš�";
	else if (pass.equals(""))//����Ϊ��
		message="���������ڸ�����Ϣά��ϵͳ�����ù��ĵ�¼���롣";
	else if (field.equals("null"))
		message="����ѡ���¼����";
	
	if (!message.equals(""))//�д�����ʾ
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="errormessage.jsp" />
		<%
	}
	String query="select id from A01_account where account='"+account+"'";
	message="";

	i=odb.executeQuery_long(query);
	if (i==0)//�Ƿ��û���
	{
		message="��Ǹ��δ��������������ҵ����ĵ�¼�ʺţ������ǺϷ��û���";
	}
	else if (i==1)//�Ϸ��û���
	{
		//pass=code.encrypt(pass);//��������
		query="select id from A01_account where account='"+account+"' and password='"+pass+"'";
		id=odb.executeQuery_String(query);
		if (id.equals(""))//���������
			message="��������롣";
	}

	if (!message.equals(""))//�д�����ʾ
	{
		session.putValue("errormessage",message);
		%>
		<jsp:forward page="errormessage.jsp" />
		<%
	}
	else//�Ϸ��û�
	{
		session.putValue("id",id);
		session.putValue("account",account);
		%>	
		<jsp:forward page="default.html" />
		<%
	}
%> 