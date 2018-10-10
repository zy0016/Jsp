<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%--该页面显示的员工数据，都是表中工号重复的--%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
<link href="font.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBdelete" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBlog" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="CC" scope="page" class="JavaBean.CreateChart.CreateChart"/>
<jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>

<body background="image/back0.jpg">
<%
String id		=	(String)session.getValue("id");//员工id
String account	=	(String)session.getValue("account");//员工帐户
String sql		=	"";
if (id==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,请重新<a href=login.jsp>登录</a>。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}

String pname		=	ODB.executeQuery_String("select A0101 from A01 where id="+id);//员工姓名
ResultSet rs		=	null;
String truetable	=	request.getParameter("truetable");//实际表名
String showtable	=	ODB.executeQuery_String("select table_hz from BasInfTMenu where table_name='"+truetable+"'");//获得显示表名

int canmodify		=	0;//可以修改的数据个数
canmodify			=	ODB.executeQuery_long("select * from BasInfTFMenu where table_name='"+truetable+"' and modify='1'");

String dnum			=	request.getParameter("num");
if (dnum==null)
	dnum="null";
else//删除数据
{
	sql="delete from "+truetable+" where id_identity="+dnum;
	int de=ODBdelete.executeUpdate(sql);
	if (de==1)//删除成功
		ODBlog.SaveUpdateLog(account,sql);//记录日志
}

String fname="";//员工照片名字
if (session.getValue("fname")!=null)
	fname=(String)session.getValue("fname");//取出存储过的照片名字

%>
<table width="800" height="206" border="0" class="font">
  <tr> 
    <td height="52">
	<%
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//处理照片
	if (fname.equals("0"))//照片还没有显示
	{
		String Path=JCPATH.PATH;
		fname=CC.CreatePhoto("select C0115 from A01 where id="+id,Path);
		session.putValue("fname",fname);//保存照片名字
	}
	%>
<input type="image" title=<%= pname%> src=photo\<%= fname%> alt="没有该员工的照片" width="124" height="163">
	
	</td>
    <td rowspan="2">
	<table width="100%" class="font">
	<tr>
	      <td align="center"><font size="4">这是您在<%= showtable%>里的信息</font></td>
	</tr>
		  <%
		  if (canmodify>0)
		  {
			  %><tr><td><a href=newinfo.jsp?truetable=<%= truetable%>>新建一条我的数据</a></td></tr><%
		  }
		  %>
	</table>
	<%//显示员工数据
	ResultSetMetaData rsmd;//声明接口对象
	sql			=	CS.createselect(truetable,"A01.id","=",id);
	rs			=	ODB.executeQuery(sql);
	rsmd		=	rs.getMetaData();
	int cols	=	rsmd.getColumnCount()+1;//获得查询结果的列数
	try
	{
		String Colname	=	"";
		int width		=	cols*150;

		%>
		<table width=<%= width%> border=0  class="font">
		<tr>
		
		<%
		for (int i=1;i<cols;i++)
		{
			Colname=rsmd.getColumnName(i);//获得实际列名
			%>
			<td align=middle><%= Colname%></td>
			
			<%
		}
		%>
		<td align=middle>操作</td>
		<td align=middle>操作</td>
		</tr>
		<%
		boolean b	=	true;
		String num	=	"";
		while(rs.next())
		{
			String color="";//设置颜色时使用
			if (b)
				color=" bgcolor=\"#66FFFF\" ";
			else
				color=" bgcolor=\"#00FF00\" ";
			b=!b;
			%>
			<tr <%= color%>>
          
			<%			
			for (int i=1;i<cols;i++)
			{
				String getvalue	=	rs.getString(i);//获得实际数据
				Colname			=	rsmd.getColumnName(i);//获得实际列名
				if (i==1)
					num=getvalue;//保存编号
				if (getvalue!=null)
				{
					int len		=	0;
					len			=	getvalue.length();
					getvalue	=	getvalue.replaceAll("00:00:00","");
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

			if (canmodify>0)
			{
				%>
				<td align=middle><a href=updatedisplay.jsp?tablename=<%= truetable%>&num=<%= num%>>修改</a></td>
				<td align=middle><a href=IniBaseInfoPeoplem.jsp?truetable=<%= truetable%>&num=<%= num%> onClick="if (confirm('您是否确认删除这条数据?')) return true;else return false;">删除</a></td>
				<%
			}
			else
			{
				%>
				<td align=middle>&nbsp;</td>
				<td align=middle>&nbsp;</td>
				<%
			}
			%>
			</tr>
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
		<jsp:forward page="errormessage.jsp" />
		<%
	}
	%>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
