<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%--��ҳ����ʾ��Ա�����ݣ����Ǳ��й����ظ���--%>
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
String id		=	(String)session.getValue("id");//Ա��id
String account	=	(String)session.getValue("account");//Ա���ʻ�
String sql		=	"";
if (id==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,������<a href=login.jsp>��¼</a>��");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}

String pname		=	ODB.executeQuery_String("select A0101 from A01 where id="+id);//Ա������
ResultSet rs		=	null;
String truetable	=	request.getParameter("truetable");//ʵ�ʱ���
String showtable	=	ODB.executeQuery_String("select table_hz from BasInfTMenu where table_name='"+truetable+"'");//�����ʾ����

int canmodify		=	0;//�����޸ĵ����ݸ���
canmodify			=	ODB.executeQuery_long("select * from BasInfTFMenu where table_name='"+truetable+"' and modify='1'");

String dnum			=	request.getParameter("num");
if (dnum==null)
	dnum="null";
else//ɾ������
{
	sql="delete from "+truetable+" where id_identity="+dnum;
	int de=ODBdelete.executeUpdate(sql);
	if (de==1)//ɾ���ɹ�
		ODBlog.SaveUpdateLog(account,sql);//��¼��־
}

String fname="";//Ա����Ƭ����
if (session.getValue("fname")!=null)
	fname=(String)session.getValue("fname");//ȡ���洢������Ƭ����

%>
<table width="800" height="206" border="0" class="font">
  <tr> 
    <td height="52">
	<%
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//������Ƭ
	if (fname.equals("0"))//��Ƭ��û����ʾ
	{
		String Path=JCPATH.PATH;
		fname=CC.CreatePhoto("select C0115 from A01 where id="+id,Path);
		session.putValue("fname",fname);//������Ƭ����
	}
	%>
<input type="image" title=<%= pname%> src=photo\<%= fname%> alt="û�и�Ա������Ƭ" width="124" height="163">
	
	</td>
    <td rowspan="2">
	<table width="100%" class="font">
	<tr>
	      <td align="center"><font size="4">��������<%= showtable%>�����Ϣ</font></td>
	</tr>
		  <%
		  if (canmodify>0)
		  {
			  %><tr><td><a href=newinfo.jsp?truetable=<%= truetable%>>�½�һ���ҵ�����</a></td></tr><%
		  }
		  %>
	</table>
	<%//��ʾԱ������
	ResultSetMetaData rsmd;//�����ӿڶ���
	sql			=	CS.createselect(truetable,"A01.id","=",id);
	rs			=	ODB.executeQuery(sql);
	rsmd		=	rs.getMetaData();
	int cols	=	rsmd.getColumnCount()+1;//��ò�ѯ���������
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
			Colname=rsmd.getColumnName(i);//���ʵ������
			%>
			<td align=middle><%= Colname%></td>
			
			<%
		}
		%>
		<td align=middle>����</td>
		<td align=middle>����</td>
		</tr>
		<%
		boolean b	=	true;
		String num	=	"";
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
				String getvalue	=	rs.getString(i);//���ʵ������
				Colname			=	rsmd.getColumnName(i);//���ʵ������
				if (i==1)
					num=getvalue;//������
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
				<td align=middle><a href=updatedisplay.jsp?tablename=<%= truetable%>&num=<%= num%>>�޸�</a></td>
				<td align=middle><a href=IniBaseInfoPeoplem.jsp?truetable=<%= truetable%>&num=<%= num%> onClick="if (confirm('���Ƿ�ȷ��ɾ����������?')) return true;else return false;">ɾ��</a></td>
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
