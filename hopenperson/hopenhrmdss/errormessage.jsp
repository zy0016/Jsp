<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>出错提示</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="font.css" rel="stylesheet" type="text/css">
<link href="buttonwidth.css" rel="stylesheet" type="text/css">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
</head>
<% 
String errormessage=(String)session.getValue("errormessage");
%>
<body background="image/back0.jpg">
<br>
<table width="100%" border="0" class="font">
  <tr> 
    <td><div align="center"><%= errormessage%></div></td>
  </tr>
  <tr>
    <td><div align="center">
        <input name="Submit" type="submit" class="buttonwidth" onClick="window.history.back()" value="确定">
      </div></td>
  </tr>
</table>


</body>
</html>
