<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%
String account=(String)session.getValue("account");//Ա���ʺ�
if (account==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,�����ܻ�û�е�¼��");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
%>
<html>
<head>
<title>�û��Ƿ��Ѿ���¼�ĵ��ж�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
453
</body>
</html>
