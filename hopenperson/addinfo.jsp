<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>�����½�������</title>
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
String id		=	(String)session.getValue("id");//Ա��id
String account	=	(String)session.getValue("account");//Ա���ʻ�
if (id==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,������<a href=login.jsp>��¼</a>��");
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
		colnames0=colnames0.substring(0,colnames0.length()-1);//��������������������(�������ݵ��ֶ����)
	else
		colnames0="";
else
	colnames0="";

if (colnames1!=null)
	if (!colnames1.equals(""))
		colnames1=colnames1.substring(0,colnames1.length()-1);//��������������������(ѡ�����ݵ��ֶ����)
	else
		colnames1="";
else
	colnames1="";

String truetable=request.getParameter("truetable");//��ñ���
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
	String field_name	=	request.getParameter("htxt"+String.valueOf(i));//���ʵ���ֶ���
	String field_value	=	request.getParameter("txt"+String.valueOf(i));//����û�����������
	field_value			=	new String(field_value.getBytes("ISO8859-1"));
	String T			=	field_name.substring(0,1);
	
	if (T.equals("T"))//������������,��������Ƿ�Ϸ�
	{
		boolean just=true;
		//just=er.JustDateTime(field_value);
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
			sql=sql+"'"+field_value+"',";
		}
	}
	else
	{
		if (field_value.indexOf("'")>=0)
		{
			session.putValue("errormessage","�벻Ҫ���뵥���š�");
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
sql = sql.substring(0,sql.length()-1)+" )";//���µ�SQL���
if (ODB.executeUpdate(sql)!=-1)//���³ɹ�
{
	ODBlog.SaveUpdateLog(account,sql);
	%><div align="center">���������Ѿ����³ɹ���<br>
	<a href=IniBaseInfoPeoplem.jsp?truetable=<%= truetable%> target=fraRightFrame>ȷ��</a></div>
	<%
}
else
{
	session.putValue("errormessage",sql);//"���ݸ���ʧ�ܣ������������˷Ƿ������ݡ�"
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
%>
</body>
</html>
