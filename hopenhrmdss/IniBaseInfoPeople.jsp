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
<%@ page errorPage="errorpage.jsp"%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<style type="text/css">
<!--
A {text-decoration: none}
.c1 {
	font-size: x-small;
	cursor: hand;
}
-->
</style>
</head>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODB1" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBcol" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<jsp:useBean id="ODBCS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<jsp:useBean id="CC" scope="page" class="JavaBean.CreateChart.CreateChart"/>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
<body background="back0.jpg" class="A">
<%
ResultSet rs=null;
String id=request.getParameter("id");//id��
String photo=request.getParameter("photo");
String fname="";//Ա����Ƭ����
if (session.getValue("fname")!=null)
	fname=(String)session.getValue("fname");//ȡ���洢������Ƭ����

if (id!=null)
	session.putValue("id",id);
else
	id=(String)session.getValue("id");
	
String name_num=ODB.executeQuery_String("select A0101,A0102 from A01 where id="+id);
String name=ODBCS.getleft_rightstr(name_num,"*",-1);//����
String nu=ODBCS.getleft_rightstr(name_num,"*",1);//����

rs=ODB.executeQuery("select * from BasInfTMenu where memo='11' or memo='10'");
int col=ODBcol.executeQuery_col("select * from BasInfTMenu where memo='11' or memo='10'");
int widths=col*100;
%>
<br><%= name%>,����:<%= nu%><br>
<table width="<%= widths%>" border=0>
<tr>
<%
while(rs.next())
{
	String tablename="",table="";
	tablename=rs.getString("table_hz");
	table=rs.getString("table_name");
	%>
	<td class="c1" bgcolor=#33FFFF onMouseOver=this.style.color='#ffffff' onMouseOut=this.style.color='#000000' >
	<div align=center>
	<a href=IniBaseInfoPeople.jsp?table=<%= table%>&photo=1 target=main><%= tablename%></a></div></td>
	<%
}
%>
</tr></table>
<br>
<%
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//������Ƭ
if (photo.equals("0"))
{
	String Path=JCPATH.PATH;
	fname=CC.CreatePhoto("select C0115 from A01 where id="+id,Path);
	session.putValue("fname",fname);//������Ƭ����
	//session.putValue("peoplephoto","c:\\Tomcat\\webapps\\Root\\test\\photo\\"+fname);
}
%>
<input type="image" title=<%= name%> src=photo\<%= fname%> alt="û�и�Ա������Ƭ" width="124" height="163">
<br>
<%
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
String table=request.getParameter("table");//����
if (table!=null)
	session.putValue("table",table);
else
	table="A01";

String repeatable=ODB.executeQuery_String("select repeatable from BasInfTMenu where table_name='"+table+"'");
String sql=ODBCS.createselect(table,"A01.id","=",id);

try
{
	ResultSetMetaData rsmd;//�����ӿڶ���
	rs=ODB1.executeQuery(sql);
	rsmd=rs.getMetaData();
	int cols=rsmd.getColumnCount()+1;//��ò�ѯ���������
	
	if (repeatable.equals("0"))//���Ų��ظ�
	{
		if (rs.next())
		{
			%>
			<table width=500 border=0>
			<%
			for (int i=1;i<cols;i++)
			{
				String Colname=rsmd.getColumnName(i);//���ʵ������
				String data=rs.getString(i);//�������
				if (Colname.equals("��Ƭ"))
					continue;
				if (data==null)
					data="&nbsp;";
				%>
				<tr>
				<td align=left><%= Colname%></td>
				<td align=left><%= data%></td>
				</tr>
				<%
			}
			%>
			</table><br>
			<%
		}
		else
		{
			%><div align="center">û�����ݡ�</div><%
		}
	}
	else//�����ظ�
	{
		String Colname="";
		int width=cols*150;

		%>
		<table width=<%= width%> border=0>
		<tr>
		<%

		for (int i=1;i<cols;i++)
		{
			Colname=rsmd.getColumnName(i);//���ʵ������
			%>
			<td align=middle><%= Colname%></td>
			<%
		}
		%>
		</tr>
		<%
		boolean b=true;
		while(rs.next())
		{
			String color="";//������ɫʱʹ��
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
				String getvalue=rs.getString(i);//���ʵ������
				Colname=rsmd.getColumnName(i);//���ʵ������
				if (Colname.equals("��Ƭ"))
				{
					%>
					<td>&nbsp;</td>
					<%
					continue;
				}
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
			</tr>
			<%
		}
		%>
		</table>
		<%
	}
	ODB.destroy();
	ODB1.destroy();
	ODBcol.destroy();
}
catch (Exception e)
{
	%><br><div align="center">SQL���Ƿ���</div><%
	ODB.destroy();
	ODB1.destroy();
	ODBcol.destroy();
}
%>

</body>
</html>
