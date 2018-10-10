<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%@ page import="javax.servlet.*"%> 
<%@ page import="javax.servlet.http.*"%> 

<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<% 
try 
{ 
	java.sql.ResultSet sqlRst;
	String user=request.getParameter("username");
	String pass=request.getParameter("password");
	String password="";
	int		i=0;
	session.putValue("username",user);
	//加载驱动程序 
	/*Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); 
	String url="jdbc:odbc:hrmdss"; 
	Connection con=DriverManager.getConnection(url,"",""); 
	Statement stmt = con.createStatement(); 
	String query="select * from S02 where s0201='"+user+"'";
	sqlRst=stmt.executeQuery(query);*/
	
	String query="select * from S02 where s0201='"+user+"' and S0202='"+pass+"'";
	//Connection con=ODB.getConn();
	
	i=ODB.executeQuery_long(query);
	ODB.destroy();
	if (i==1)
	{
		%>			
			<jsp:forward page="default.jsp">
			</jsp:forward>
		<%
	}
	else//密码错误
	{
		%>	
		<jsp:forward page="loginout.jsp" />
		<%
	}
}
	catch (Exception e)
	{
		%><div align="center">登录失败！</div><%
	} 
//输出确认信息 
%> 