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
<title>查询选项</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script = language="JavaScript">
function additem()
{
	//alert(selectform.selectfiled.options[selectform.selectfiled.selectedIndex].text);
/*	if (selectform.selectfiled.selectedIndex==-1)
		return;
	selectform.showfiled.add("231",-1);*/
}
</script>
</head>

<body>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODB1" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<%
ResultSet sqlRst=null;
ResultSet rs=null;
String selecttable=(String)session.getValue("orderby_table");
int num=ODB1.executeQuery_col("select * from "+selecttable)-1;

for (int i=1;i<num;i++)
{
	rs=ODB.executeQuery("select * from BasInfTFMenu where table_name='"+selecttable+"'");
	//out.println("<form name=form"+Integer.toString(i)+">");
	out.println("<select name=orderby"+Integer.toString(i)+" id=orderby"+Integer.toString(i)+">");
	out.println("<option value=null selected>请选择第"+Integer.toString(i)+"个排序字段</option>");
	while(rs.next())
	{
		String vals=rs.getString("field_hz");
		String fieldname=rs.getString("field_name");
		if (vals.equals("id"))
			vals="姓名";
		else if (vals.equals("id_identity"))
			vals="编号";
		out.println("<option value="+fieldname+">"+vals+"</option>");
	}
	out.println("</select>");
	out.println("<input name=asc"+Integer.toString(i)+" type=radio value=asc checked>升序");
	out.println("<input name=asc"+Integer.toString(i)+" type=radio value=desc>降序<br>");
//	out.println("</form>");
}
%>

</body>
</html>
