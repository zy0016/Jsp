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
<link href="font.css" rel="stylesheet" type="text/css">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
</head>

<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<body bgcolor="#e0e6a6">
<%
String regard	=	"";
String ip		=	request.getServerName();//��ñ���IP��ַ
String file		=	request.getRequestURI();//��ñ��ļ�������
file			=	CS.ReplaceString(file,"/","");

String localhostpath	=	request.getRealPath(file);//��ñ��ļ��ľ���·���������ļ���
localhostpath			=	CS.ReplaceString(localhostpath,file,"");//��ñ��ļ��ľ���·�����������ļ���,Ҳ����
String PhotoPath		=	localhostpath+"photo";//��ñ��ļ��ľ���·��
PhotoPath				=	CS.ReplaceString(PhotoPath,File.separator,File.separator+File.separator);//����photo�ļ���·��(��һ��"\"��Ϊ����"\\")

JCPATH.PATH=PhotoPath;

String id=(String)session.getValue("id");//Ա��id
if (id==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,�����ܻ�û��<a href=\"login.jsp\">��¼</a>��");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
String name=odb.executeQuery_String("select A0101 from A01 where id="+id);
%>

<table width="100%" border="0" class="font">
  <tr> 
    <td width="60%" rowspan="2"><h1 align="center">������Ϣά��ϵͳ</h1></td>
    <td width="40%" height="22"><a href="javascript:window.external.AddFavorite('http://<%= ip%>:8080/login.jsp', '������Դ����ϵͳ')">��������ղؼ�</a>
</td>
  </tr>
  <tr> 
    <td><div align="left"><%= name%>���� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="modifypassword.jsp" target="_top">�޸��ҵĵ�¼����</a></div></td>
	
  </tr>
</table>
</body>
</html>
