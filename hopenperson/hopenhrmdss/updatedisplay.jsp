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
<title>�����ظ�ʱ��ʾ��Ҫ�޸ĵ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="font.css" rel="stylesheet" type="text/css">
<link href="buttonwidth.css" rel="stylesheet" type="text/css">
</head>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBmodify" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBselect" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>

<script language="JavaScript">
function verify(eventTarget)
{
	alert(eventTarget.value);
	return true;
}
</script>
<body background="image/back0.jpg">
<%
String id		=	(String)session.getValue("id");//Ա��id
String account	=	(String)session.getValue("account");//Ա���ʻ�

if (id==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼Ա������Ϣ,������<a href=login.jsp>��¼</a>��");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
String truetable	=	request.getParameter("tablename");//ʵ�ʱ���
String mnum			=	request.getParameter("num");//id_identity

String sql			=	CS.createselect(truetable,"A01.id","=",id);
sql					=	sql+" and id_identity="+mnum;

ResultSet rs		=	null;
ResultSet rsmodify	=	null;
ResultSet sqlRst	=	null;

ResultSetMetaData rsmd;//�����ӿڶ���
rs				=	ODB.executeQuery(sql);
rsmd			=	rs.getMetaData();
int cols		=	rsmd.getColumnCount()+1;//��ò�ѯ���������
int txtn		=	0;//�ı���ĸ���
int seln		=	0;//ѡ���ĸ���
int canmodify	=	0;//�����޸ĵ����ݸ���
Date now			=	new Date();
Date now1			=	new Date();
//out.println("��ʼִ��ʱ�䣺"+DateFormat.getTimeInstance().format(now)+"<br>");
try
{
	if (rs.next())
	{
		%>
<form method=post name=form1 action=updatemuch.jsp?truetable=<%= truetable%>&id_identity=<%= mnum%>>
		
		<table width=400 border=0 class="font">
		<%
		for (int i=1;i<cols;i++)
		{
			String Colname	=	rsmd.getColumnName(i);//���ʵ������
			String data		=	rs.getString(i);//�������
			
			String str		=	"select field_type,field_name,memo,code,modify,field_len from BasInfTFMenu where table_name='"+truetable+"' and field_hz='"+Colname+"'";
			rsmodify		=	ODBmodify.executeQuery(str);
			int field_len	=	10;
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
			if (data==null)
				data="&nbsp;";
			%>
			<tr>
			<td align=left width=200><%= Colname%></td>
			<td align=left width=200>
			<%
			if (modify.equals("1"))//�����޸�
			{
				canmodify++;
				if (memo.equals("0"))//����
				{
					txtn++;
					if (type.equals("datetime"))//��������
					{
						//data=CS.ReplaceString(data,"-"," ");
						out.println("<input name=txt"+txtn+" type=text value=\""+data+"\" onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
						out.println("<input name=htxt"+txtn+" type=hidden value=T"+field_name+">");
					}
					else
					{
						out.println("<input name=txt"+txtn+" maxlength=\""+field_len+"\" type=text value=\""+data+"\" onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
						out.println("<input name=htxt"+txtn+" type=hidden value="+field_name+">");
					}
				}
				else if (memo.equals("1"))//ѡ��
				{
					seln++;
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

					sqlRst=ODBselect.executeQuery(sqlsub);

					while(sqlRst.next())
					{
						String vals		=	sqlRst.getString("Name");
						String Idcode	=	sqlRst.getString("Idcode");
						String child	=	sqlRst.getString("child");

						int idlen		=	Idcode.length();
						String space	=	"";

						for (int j=2;j<=idlen;j++)
							space=space+"--";

						if (child.equals(Idcode))//�ýڵ����ӽڵ�
						{
							%>
							<option value=<%= Idcode%> <% if (vals.equals(data)) out.print("selected");%>><%= space%><%= vals%></option>
							<%
						}
						else//�ýڵ㻹���ӽڵ�
						{
							%>
							<option value=<%= Idcode%>><%= vals%></option>
							<%
						}
					}
					%>
					</select>
					<%
				}
				session.putValue("txtn",String.valueOf(txtn));//�����ı���ĸ���
				session.putValue("seln",String.valueOf(seln));//����ѡ���ĸ���
			}
			else//�������޸�
				out.println(data);
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
</body>
</html>
