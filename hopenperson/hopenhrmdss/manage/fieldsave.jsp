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
<link href="../font.css" rel="stylesheet" type="text/css">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
</head>
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="odblog" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<%
String user=(String)session.getValue("administrator");//Ա��id
if (user==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼����Ա����Ϣ��");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}

String tablename	=	request.getParameter("tablename");//���ѡ��ı���
String checkn		=	(String)session.getValue("checkn");//��ѡ��ĸ���
int checki			=	Integer.parseInt(checkn);

for (int i=1;i<=checki;i++)
{
	String field_name	=	request.getParameter("hcheckbox"+String.valueOf(i));//���ʵ���ֶ���
	String field_value	=	request.getParameter("checkbox"+String.valueOf(i));//����Ƿ�����޸�

	if (field_value==null)
		field_value="0";
	else if (field_value.equals("on"))
		field_value="1";

	String sql="update BasInfTFMenu set modify='"+field_value+"' where table_name='"+tablename+"' and field_name='"+field_name+"'";
	int up=odb.executeUpdate(sql);
	odblog.SaveUpdateLog(user,sql);//��¼��־
}
%>
<body background="../image/back0.jpg" class="font">
<div align="center"><a href="allowmodify.jsp" target="fraRightFrame">�޸ĳɹ�</a> 
</div>
</body>
</html>
