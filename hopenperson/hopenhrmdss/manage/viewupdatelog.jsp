<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>�鿴���ݸ�����־</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../font.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
function verty_field()
{
	if (form1.selectfind.selectedIndex==0)
	{
		alert("��ϣ����ѯ��һ���ֶε����ݡ�");
		form1.selectfind.focus();
		return false;
	}
	else
		return true;
}
function doPostBack(eventTarget, eventArgument) 
{
	var theform = document.form2;
	theform.submit();
}
</script>

<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="odblog" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBcount" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<%
String user=(String)session.getValue("administrator");//Ա��id
if (user==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼����Ա����Ϣ��");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}

String selectfind	=	request.getParameter("selectfind");//���ѡ�������
String selectterm	=	request.getParameter("selectterm");//���ѡ�������
String finddata		=	request.getParameter("data");//�������Ĳ�ѯ����
String tablename	=	request.getParameter("tablename");
String sql			=	"select * from "+tablename;

if (selectfind==null)
	selectfind	=	"";
else
	selectfind	=	new String(selectfind.getBytes("ISO8859-1"));

if (selectterm==null)
	selectterm="";

if (finddata==null)
	finddata="";

if ((!selectfind.equals("")) && (!selectterm.equals("")) && (!finddata.equals("")))
{
	if ((selectterm.equals("like")) || (selectterm.equals("not like")))
		sql=sql+" where "+selectfind+" "+selectterm+" '%"+finddata+"%'";
	else
		sql=sql+" where "+selectfind+selectterm+"'"+finddata+"'";
}
%>
<body background="../image/back0.jpg" class="font">

<table width="100%" height="50" border="0" class="font">
  <tr>
      <td> 
	  <form name="form1" method="post" action="">
		��ѯ<select name="selectfind" id="selectfind">
          <option value="" selected>��ѡ���ѯ����</option>
		  <%
			ResultSetMetaData rsmd;//�����ӿڶ���
			ResultSet rs	=	null;
			String sqlstr	=	"select * from "+tablename+" where id=0";
			rs				=	odb.executeQuery(sqlstr);
			rsmd			=	rs.getMetaData();
			int cols		=	rsmd.getColumnCount();//��ò�ѯ���������
			int width		=	cols*150;
			String Colname	=	"";

			for (int i=1;i<=cols;i++)
			{
				Colname	=	rsmd.getColumnName(i);//���ʵ������
				if (!Colname.equals("id"))
				{
					%>
					<option value=<%=Colname%> <%if (selectfind.equals(Colname)) out.print("selected");%>><%= Colname%></option>
					<%
				}
			}
		  %>
        </select>
        <select name="selectterm" id="selectterm">
			<option value="=" <% if (selectterm.equals("=")) out.print("selected");%>>����</option>
			<option value="&lt;&gt;" <% if (selectterm.equals("<>")) out.print("selected");%>>������</option>
			<option value="&gt;" <% if (selectterm.equals(">")) out.print("selected");%>>����</option>
			<option value="&gt;=" <% if (selectterm.equals(">=")) out.print("selected");%>>���ڵ���</option>
			<option value="&lt;" <% if (selectterm.equals("<")) out.print("selected");%>>С��</option>
			<option value="&lt;=" <% if (selectterm.equals("<=")) out.print("selected");%>>С�ڵ���</option>
			<option value="like"  <% if (selectterm.equals("like")) out.print("selected");%>>����</option>
			<option value="not like"  <% if (selectterm.equals("not like")) out.print("selected");%>>������</option>
        </select>
        <input name="data" type="text" id="data" value="<%= finddata%>">
        <input type="submit" name="Submit" value="��ʼ��ѯ" onclick="return verty_field();">
		</form>
		</td>
  </tr>
  </table>
  <form name="form2" method="post" action="">
  <%
try
{
	boolean	begin=true;
	if (begin)
	{
//////////////////////////////////��ҳ��ʾ/////////////////////////////////////////////////////////
			int intPageSize=30;	//һҳ��ʾ�ļ�¼��
			int intRowCount=0;	//��¼����
			int intPageCount=0;	//��ҳ��
			int intPage=0;		//����ʾҳ��

			String strPage="",temp="";
			strPage	= request.getParameter("page");//ȡ�ô���ʾҳ��
			temp	= request.getParameter("selectpage");//����б���е�ҳ��

			if ((strPage==null) || (strPage.equals("null")) || (strPage.equals("")))//������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
			{
				if ((temp!=null) && (!temp.equals("null")))
					intPage=Integer.parseInt(temp);
				else
					intPage = 1;
			}
			else
			{
				try//���ַ���ת��������
				{
					intPage = Integer.parseInt(strPage);

					if ((temp!=null) && (!temp.equals("null")))
					{
						if (!temp.equals(strPage))
							intPage=Integer.parseInt(temp);
					}
				}
				catch (NumberFormatException e)
				{
					intPage=1;
					if ((temp!=null) && (!temp.equals("null")))
					{
						if (!temp.equals(strPage))
							intPage=Integer.parseInt(temp);
					}
				}
				if(intPage<1) 
					intPage = 1;
			}

			intRowCount=ODBcount.executeQuery_long(sql);
			intPageCount = (intRowCount+intPageSize-1) / intPageSize;//������ҳ��

			%>
			���ҵ�<%=intRowCount %>������&nbsp;&nbsp;
			<%
			if (intPage==1)
			{
				%>��ҳ&nbsp;��һҳ&nbsp;<%
			}
			else
			{
				%>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page="1">��ҳ</a>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page=<%=intPage-1%>>��һҳ</a>
				<%
			}
			
			if (intPage==intPageCount)
			{
				%>&nbsp;��һҳ&nbsp;βҳ	<%
			}
			else
			{
				%>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page=<%=intPage+1%>>��һҳ</a>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page=<%=intPageCount%>>βҳ</a>
				<%
			}
			%>
			&nbsp;��ת��&nbsp;<select name="selectpage" onChange="doPostBack('selectpage','')">
			<%
			for (int i=1;i<=intPageCount;i++)
			{
				%>
				<option value=<%=i%> <%if (intPage==i) out.println("selected");%>>��<%=i%>ҳ</option>
				<%
			}
			%>
			</select>
			��<%=intPage%>ҳ/��<%=intPageCount%>ҳ&nbsp;&nbsp;ÿҳ��ʾ<%=intPageSize%>������
<%
/////////////////////////////////////////////////////////////////////////////////////////

		%>
		<table width=<%= width%> border=1 class="font">
			<tr>
				<%
				ResultSetMetaData rsmdf;//�����ӿڶ���
				ResultSet rslog	=	null;
				rslog			=	odblog.executeQuery(sql);
				rsmdf			=	rslog.getMetaData();
				
				for (int i=1;i<=cols;i++)
				{
					Colname	=	rsmdf.getColumnName(i);//���ʵ������
					if (Colname.equals("id"))
						Colname="���";
					%>
					<td align=middle><%= Colname%></td>
					<%
				}
				%>
			</tr>
			<%
			int datacount=0;
			boolean b=true;
			while(rslog.next())
			{
////////////////////////////////////////////////////////////////////////////////////////
				datacount++;
				if (intPage==1)//��ҳ
				{
					if (datacount>intPageSize)
						break;
				}
				if (intPage==intPageCount)//βҳ
				{
					if (datacount <= ((intPage-1) * intPageSize))
						continue;
				}
				if ((1<intPage) && (intPage<intPageCount))
				{
					if (!((intPage-1)*intPageSize+1<=datacount && datacount<=intPageSize*intPage))
						continue;
				}
////////////////////////////////////////////////////////////////////////////////////////
				String color="";//������ɫʱʹ��
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
					String getvalue=rslog.getString(i);//���ʵ������

					if (getvalue!=null)
					{
						int len=0;
						len=getvalue.length();
						if (len!=0)
						{
							%><td align="middle"><%= getvalue%></td><%
						}
						else
						{
							%><td>&nbsp;</td><%
						}					
					}
					else
					{
						%><td>&nbsp;</td><%
					}
				}
				%>
				</tr>
				<%
			}
			%>
		</table> 
		</form>
		<%
	}
}
catch (Exception e)
{
	session.putValue("errormessage",sql);//"���ݸ���ʧ�ܣ������������˷Ƿ������ݡ�"
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
} 
%>
</body>
</html>
