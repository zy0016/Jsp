<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.util.Date"%> 
<%@ page import="java.text.*"%>
<%@ page import="java.sql.*"%> 
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="javax.servlet.*"%> 
<%@ page import="javax.servlet.http.*"%> 
<html>
<head>
<title>�����Excel��ȥ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<jsp:useBean id="JOO" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
<%
String sql=(String)session.getValue("output");
String f="\\";
String fname=CS.output_excel(sql,JCPATH.PATH);
fname="photo"+f+fname;
%>
</head>
<body>
<div align="center"><a href=<%= fname%>>�뵥������Ҽ�ѡ��Ŀ�����Ϊ...����������</a></div>
</body>
</html>
