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
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="font.css" rel="stylesheet" type="text/css">
<link href="buttonwidth.css" rel="stylesheet" type="text/css">
<link href="listboxwidth.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODB1" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBmodify" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>

<jsp:useBean id="CC" scope="page" class="JavaBean.CreateChart.CreateChart"/>
<jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>

<body background="image/back0.jpg" class="font">
<%--��ҳ����ʾ��Ա�����ݣ����Ǳ��й��Ų��ظ���--%>
<%
String id=(String)session.getValue("id");//Ա��id
if (id==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,������<a href=login.jsp>��¼</a>��");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
String pname		=	ODB.executeQuery_String("select A0101 from A01 where id="+id);//Ա������
String truetable	=	request.getParameter("truetable");//ʵ�ʱ���
String showtable	=	ODB.executeQuery_String("select table_hz from BasInfTMenu where table_name='"+truetable+"'");//�����ʾ����
String fname		=	"";//Ա����Ƭ����
Date now			=	new Date();
Date now1			=	new Date();

if (session.getValue("fname")!=null)
	fname=(String)session.getValue("fname");//ȡ���洢������Ƭ����

//out.println("��ʼִ��ʱ�䣺"+DateFormat.getTimeInstance().format(now)+"<br>");
%>

<table width="800" height="206" border="0" class="font">
  <tr> 
    <td height="52" valign=top>
	<%
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//������Ƭ
	if (fname.equals("0"))//��Ƭ��û����ʾ
	{
		String Path	=	JCPATH.PATH;
		fname		=	CC.CreatePhoto("select C0115 from A01 where id="+id,Path);
		session.putValue("fname",fname);//������Ƭ����
	}
	%>
<input type="image" title=<%= pname%> src=photo\<%= fname%> alt="û�и�Ա������Ƭ" width="124" height="163">

    <td rowspan="2">
	<%//��ʾԱ������
	String sql			=	CS.createselect(truetable,"A01.id","=",id);
	ResultSet rs		=	null;
	ResultSet rsmodify	=	null;
	ResultSet sqlRst	=	null;

	ResultSetMetaData rsmd;//�����ӿڶ���
	rs				=	ODB1.executeQuery(sql);
	rsmd			=	rs.getMetaData();
	int cols		=	rsmd.getColumnCount()+1;//��ò�ѯ���������
	int txtn		=	0;//�ı���ĸ���
	int seln		=	0;//ѡ���ĸ���
	int canmodify	=	0;//�����޸ĵ����ݸ���
try
{
	if (rs.next())
	{
		%>
<form method=post action=updatesingle.jsp?tablename=<%= truetable%>&id=<%= id%>>
		
		<table width=500 border=0 class="font">
		<tr> 
		<td colspan="2"><div align="center"><font size="4">��������<%= showtable%>�����Ϣ</font></div></td>
	  </tr>
		<%
		for (int i=1;i<cols;i++)
		{
			String Colname	=	rsmd.getColumnName(i);//���ʵ������
			String data		=	rs.getString(i);//�������
			
			String str		=	"select field_type,field_name,memo,code,modify,field_len from BasInfTFMenu where table_name='"+truetable+"' and field_hz='"+Colname+"'";
			//String str		=	"select modify,memo,field_name,code,field_type,field_len from BasInfTFMenu where table_name='"+truetable+"' and field_hz='"+Colname+"'";
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
				field_len	=	(int)rsmodify.getFloat("field_len");

				/*modify		=	rsmodify.getString("modify");
				memo		=	rsmodify.getString("memo");
				field_name	=	rsmodify.getString("field_name");
				code		=	rsmodify.getString("code");
				type		=	rsmodify.getString("field_type");
				field_len	=	(int)rsmodify.getFloat("field_len");*/

				if (modify==null)
					modify="";
			}

			if (Colname.equals("��Ƭ"))
				continue;
			if (data==null)
				data="&nbsp;";
			%>
			<tr>
			<td align=left width=250><%= Colname%></td>
			<td align=left width=250>
			<%
			if (modify.equals("1"))//�����޸�
			{
				canmodify++;
				
				//memo		=	rsmodify.getString("memo");
				//ield_name	=	rsmodify.getString("field_name");

				if (memo.equals("0"))//����
				{
					txtn++;
					
					//type		=	rsmodify.getString("field_type");
					//field_len	=	(int)rsmodify.getFloat("field_len");

					if (type.equals("datetime"))//��������
					{
						//data=CS.ReplaceString(data,"-"," ");
						out.println("<input name=txt"+txtn+" type=text value=\""+data+"\" onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
						out.println("<input name=htxt"+txtn+" type=hidden value=T"+field_name+">");
					}
					else
					{
						if (field_len<=200)//��������
						{
							out.println("<input name=txt"+txtn+" type=text value=\""+data+"\" maxlength="+field_len+" onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
							out.println("<input name=htxt"+txtn+" type=hidden value="+field_name+">");
						}
						else//��������
						{
							out.println("<textarea name=txt"+txtn+" rows=10 class=listboxwidth>"+data+"</textarea>");
							out.println("<input name=htxt"+txtn+" type=hidden value="+field_name+">");
						}
					}
				}
				else if (memo.equals("1"))//ѡ��
				{
					seln++;

					//code		=	rsmodify.getString("code");

					out.println("<input name=hsel"+seln+" type=hidden value="+field_name+">");
					%>
					<select name=sel<%= seln%>>
					<option value="">��ѡ��</option>
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

					sqlRst=ODB.executeQuery(sqlsub);

					while(sqlRst.next())
					{
						String vals		=	sqlRst.getString("Name");
						String Idcode	=	sqlRst.getString("Idcode");
						String child	=	sqlRst.getString("child");

						int idlen		=	Idcode.length();
						String space	=	"";

						for (int j=2;j<=idlen;j++)
							space=space+"--";

						%>
						<option value=<%= Idcode%> <% if (vals.equals(data)) out.print("selected");%>><%= space%><%= vals%></option>
						<%
					}
					%>
					</select>
					<%
				}
				session.putValue("txtn",String.valueOf(txtn));//�����ı���ĸ���
				session.putValue("seln",String.valueOf(seln));//����ѡ���ĸ���
			}
			else//�������޸�
			{
				data=data.replaceAll("00:00:00","");
				out.println(data);
			}
			%>
			</td>
			</tr>
			<%
		}
		%>
		<tr>
			<%
			if (canmodify>0)
			{
				%>
				<td><input name="Submit" type="submit" class="buttonwidth" value="ȷ��"></td>
				<td><input name="Submit2" type="reset" class="buttonwidth" value="������д"></td>
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
		<br>
		<%
	}
	else
	{
		%><div align="center">û�����ݡ�</div><%
	}
}
catch (SQLException e)
{
	session.putValue("errormessage",e.getMessage());
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
//out.println("ִ�н���ʱ�䣺"+DateFormat.getTimeInstance().format(now1));
	%>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
