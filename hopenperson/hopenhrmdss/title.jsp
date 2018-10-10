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
String ip		=	request.getServerName();//获得本机IP地址
String file		=	request.getRequestURI();//获得本文件的名字
file			=	CS.ReplaceString(file,"/","");

String localhostpath	=	request.getRealPath(file);//获得本文件的绝对路径，包括文件名
localhostpath			=	CS.ReplaceString(localhostpath,file,"");//获得本文件的绝对路径，不包括文件名,也就是
String PhotoPath		=	localhostpath+"photo";//获得本文件的绝对路径
PhotoPath				=	CS.ReplaceString(PhotoPath,File.separator,File.separator+File.separator);//生成photo文件的路径(将一个"\"变为两个"\\")

JCPATH.PATH=PhotoPath;

String id=(String)session.getValue("id");//员工id
if (id==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,您可能还没有<a href=\"login.jsp\">登录</a>。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
String name=odb.executeQuery_String("select A0101 from A01 where id="+id);
%>

<table width="100%" border="0" class="font">
  <tr> 
    <td width="60%" rowspan="2"><h1 align="center">个人信息维护系统</h1></td>
    <td width="40%" height="22"><a href="javascript:window.external.AddFavorite('http://<%= ip%>:8080/login.jsp', '人力资源更新系统')">点击加入收藏夹</a>
</td>
  </tr>
  <tr> 
    <td><div align="left"><%= name%>您好 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="modifypassword.jsp" target="_top">修改我的登录密码</a></div></td>
	
  </tr>
</table>
</body>
</html>
