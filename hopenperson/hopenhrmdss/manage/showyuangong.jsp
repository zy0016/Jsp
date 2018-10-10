<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
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
%>
<form action="modifypeople.jsp" method="post" name="modify">

<%
ResultSetMetaData rsmd;//声明接口对象
String sql		=	"select A01_account.id as 编号,A01.A0101 as 姓名,A01_account.account as 帐号,A01_account.password as 密码  from A01_account,A01 where A01.id=A01_account.id";
ResultSet rs	=	null;
rs				=	odb.executeQuery(sql);
rsmd			=	rs.getMetaData();
int cols		=	rsmd.getColumnCount();//获得查询结果的列数
	try
	{
		String Colname	=	"";
		int width		=	cols*150;
		%>
		<table width=<%= width%> border=0 class="font">
		<tr>
		<%
		for (int i=1;i<=cols;i++)
		{
			Colname	=	rsmd.getColumnName(i);//获得实际列名
			%>
			<td align=middle><%= Colname%></td>
			<%
		}
		%>
		<td>操作	</td>

		</tr>
		<%
		boolean b=true;
		while(rs.next())
		{
			String color="";//设置颜色时使用
			String id="",account="";
			if (b)
				color=" bgcolor=\"#66FFFF\" ";
			else
				color=" bgcolor=\"#00FF00\" ";
			b=!b;
			%>
			<tr <%= color%>>
          
			<%			
			for (int i=1;i<=cols;i++)
			{
				String getvalue=rs.getString(i);//获得实际数据
				if (i==1)
					id=getvalue;//保存id
				if (i==3)
					account=getvalue;//保存帐号

				if (getvalue!=null)
				{
					int len=0;
					len=getvalue.length();
					if (len!=0)
					{
						%>
						<td align="middle"><%= getvalue%></td>
						<%
					}
					else
					{
						%>
						<td>&nbsp;</td>
						<%
					}					
				}
				else
				{
					%>
					<td>&nbsp;</td>
					<%
				}
			}
			%>
			
			<td><a href="modifypeople.jsp?id=<%= id%>&account=<%= account%>">修改帐号</a></td>
			<%
		}
		%>
		</table>
		<%
	}
	catch (SQLException e)
	{
		session.putValue("errormessage",e.getMessage());
		%>
		<jsp:forward page="..\errormessage.jsp" />
		<%
	}
%>
</form>
</body>
</html>
