<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>修改员工登录帐号</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../font.css" rel="stylesheet" type="text/css">
<link href="../buttonwidth.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="odblog" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="jc" scope="application" class="JavaBean.JavaConst.JavaConst"/>
<jsp:useBean id="cn" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<body background="../image/back0.jpg" class="font">
<%
String user=(String)session.getValue("administrator");//员工id
if (user==null)
{
	session.putValue("errormessage","未能读取到登录管理员的信息。");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}
String id=request.getParameter("id");
String account=request.getParameter("account");

String newaccount=request.getParameter("newaccount");

if (newaccount!=null)//更改
{
	String sql="update A01_account set account='"+newaccount+"' where id="+id;
	if (odb.executeUpdate(sql)==1)
	{
		odblog.SaveUpdateLog(user,sql);//记录日志
		%>
		<jsp:forward page="showyuangong.jsp" />
		<%
	}
	else
	{
		%><font color="#FF0000">修改失败</font><%
	}
}
%>

<form action="" method="post" name="form1">
<table width="718" border="0" class="font">
  <tr>
    <td colspan="2"><div align="center">
          <input name="newaccount" type="text" value=<%= account%>>
        </div></td>
  </tr>
  <tr>
    <td width="341"><div align="right">
          <input name="Submit" type="submit" class="buttonwidth" value="确定">
        </div></td>
    <td width="367"><input name="Submit2" type="reset" class="buttonwidth" value="取消"></td>
  </tr>
</table>


</form>

</body>
</html>
