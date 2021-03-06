<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>新建员工的一条数据</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>

<link href="font.css" rel="stylesheet" type="text/css">
<link href="buttonwidth.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBmodify" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBselect" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<body background="image/back0.jpg">
<%
String id=(String)session.getValue("id");//员工id

if (id==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,请重新<a href=login.jsp>登录</a>。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
String truetable	=	request.getParameter("truetable");//实际表名
String sql			=	CS.createselect(truetable,"A01.id","=",id);
String colnames0	=	"";//列名的组合用于添加数据(输入数据的字段组合)
String colnames1	=	"";//列名的组合用于添加数据(选择数据的字段组合)

ResultSet rs		=	null;
ResultSet rsmodify	=	null;
ResultSet sqlRst	=	null;
Date now			=	new Date();
Date now1			=	new Date();

ResultSetMetaData rsmd;//声明接口对象
rs				=	ODB.executeQuery(sql);
rsmd			=	rs.getMetaData();
int cols		=	rsmd.getColumnCount()+1;//获得查询结果的列数
int txtn		=	0;//文本框的个数
int seln		=	0;//选择框的个数
int canmodify	=	0;//可以修改的数据个数
//out.println("开始执行时间："+DateFormat.getTimeInstance().format(now)+"<br>");
try
{
	%>
<form method=post action=addinfo.jsp?truetable=<%= truetable%>>
	
	<table width=400 border=0 class="font">
	<%
	for (int i=1;i<cols;i++)
	{
		String Colname=rsmd.getColumnName(i);//获得实际列名

		String str		=	"select field_type,field_name,memo,code,modify,field_len from BasInfTFMenu where table_name='"+truetable+"' and field_hz='"+Colname+"'";
		rsmodify		=	ODBmodify.executeQuery(str);
		int field_len	=	0;
		String type = "",modify = "",code = "",memo = "",field_name = "";
		if (rsmodify.next())
		{
			type		=	rsmodify.getString("field_type");
			field_name	=	rsmodify.getString("field_name");
			memo		=	rsmodify.getString("memo");
			code		=	rsmodify.getString("code");
			modify		=	rsmodify.getString("modify");
			field_len	=	(int)rsmodify.getFloat("field_len");//
			if (modify==null)
				modify="";
		}
		%>
		<tr>
			<td align=left width=200><%= Colname%></td>
			<td align=left width=200>
			<%
			if (modify.equals("1"))//允许修改
			{
				canmodify++;
				if (memo.equals("0"))//输入
				{
					txtn++;
					colnames0=colnames0+field_name+",";
					if (type.equals("datetime"))//输入日期
					{
						//data=CS.ReplaceString(data,"-"," ");
						out.println("<input name=txt"+txtn+" type=text onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
						out.println("<input name=htxt"+txtn+" type=hidden value=T"+field_name+">");
					}
					else
					{
						out.println("<input name=txt"+txtn+" maxlength=\""+field_len+"\" type=text onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
						out.println("<input name=htxt"+txtn+" type=hidden value="+field_name+">");
					}
				}
				else if (memo.equals("1"))//选择
				{
					seln++;
					colnames1=colnames1+field_name+",";
					out.println("<input name=hsel"+seln+" type=hidden value="+field_name+">");
					%>
					<select name=sel<%= seln%>>
					<option value="" selected>请选择</option>
					<%
					String sqlsub="";
					if (code.indexOf("B02")>=0)
					{
						if (code.equals("B020"))
							sqlsub="select B0205,B0210 from B02 where B0215='0'";
						else if (code.equals("B021"))
							sqlsub="select B0205,B0210 from B02 where B0215='1'";
						else if (code.equals("B022"))
							sqlsub="select B0205,B0210 from B02 where B0215='2'";
					}
					else
						sqlsub="select Name,Idcode,child from dataList where code='"+code+"'";

					sqlRst=ODBselect.executeQuery(sqlsub);
					while(sqlRst.next())
					{
						String vals=sqlRst.getString("Name");;
						String Idcode=sqlRst.getString("Idcode");
						String child=sqlRst.getString("child");

						int idlen=Idcode.length();
						String space="";

						for (int j=2;j<=idlen;j++)
							space=space+"--";
						%>
						<option value=<%= Idcode%>><%= space%><%= vals%></option>
						<%
					}
					%>
					</select>
					<%
				}
			}
			else//不允许修改
			{
				out.println("&nbsp;");
			}
			%>
			</td>
		</tr>
		<%
	}
	session.putValue("txtn",String.valueOf(txtn));//保存文本框的个数
	session.putValue("seln",String.valueOf(seln));//保存选择框的个数
	session.putValue("colnames0",colnames0);//列名的组合用于添加数据(输入数据的字段组合)
	session.putValue("colnames1",colnames1);//列名的组合用于添加数据(选择数据的字段组合)
	%>
	<tr>
		<%
		if (canmodify>0)
		{
			%>
			<td><input name="Submit" type="submit" class="buttonwidth" value="确定"></td>
			<td><input name="Submit2" type="reset" class="buttonwidth" value="重新填写"></td>
			<%
		}
		else
		{
			%>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<%
		}
		%>
	</tr>
	</table>
</form>
	<%
}
catch (SQLException e)
{
	session.putValue("errormessage",e.getMessage());
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
//out.println("执行结束时间："+DateFormat.getTimeInstance().format(now1));
%>

</body>
</html>
