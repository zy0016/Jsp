<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>�����ظ�ʱ�޸�����</title>
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
String account=(String)session.getValue("account");//Ա���ʺ�
if (account==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,������<a href=login.jsp>��¼</a>��");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}

String txtn			=	(String)session.getValue("txtn");
String seln			=	(String)session.getValue("seln");
String truetable	=	request.getParameter("truetable");//��ñ���
String id_identity	=	request.getParameter("id_identity");//������ݵı��

int txti	=	Integer.parseInt(txtn);
int seli	=	Integer.parseInt(seln);
String sql	=	"update "+truetable+" set ";

for (int i=1;i<=txti;i++)
{
	String field_name	=	request.getParameter("htxt"+String.valueOf(i));//���ʵ���ֶ���
	String field_value	=	request.getParameter("txt"+String.valueOf(i));//����û�����������
	String T	=	field_name.substring(0,1);
	
	if (T.equals("T"))//������������,��������Ƿ�Ϸ�
	{
		boolean just=true;
		just=er.JustDateTime(field_value);
		just=true;
		if (!just)//�Ƿ�����
		{
			session.putValue("errormessage","����������ڲ��Ϸ���");
			%>
			<jsp:forward page="errormessage.jsp" />
			<%
		}
		else//�Ϸ�����
		{
			sql=sql+" "+field_name.substring(1)+"='"+field_value+"',";
		}
	}
	else
	{
		field_value=new String(field_value.getBytes("ISO8859-1"));
		if (field_value.indexOf("'")>=0)
		{
			session.putValue("errormessage","�벻Ҫ���뵥���š�");
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
sql=sql.substring(0,sql.length()-1)+" where id_identity="+id_identity;//���µ�SQL���

if (ODBUP.executeUpdate(sql)!=-1)//���³ɹ�
{
	ODBlog.SaveUpdateLog(account,sql);
	%>
	<div align="center">���������Ѿ����³ɹ���<br>
	<a href=IniBaseInfoPeoplem.jsp?truetable=<%= truetable%> target=fraRightFrame>ȷ��</a></div>
	<%
}
else
{
	session.putValue("errormessage","���ݸ���ʧ�ܣ������������˷Ƿ������ݡ�");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
%>

</body>
</html>
