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
<title>���Է�ҳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<jsp:useBean id="ODBcount" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<%
int intPageSize=10;	//һҳ��ʾ�ļ�¼��
int intRowCount=0;	//��¼����
int intPageCount=0;	//��ҳ��
int intPage=0;		//����ʾҳ��

ResultSet sqlRst=null;

String sql=(String)session.getValue("output");
String selectpage=request.getParameter("selectpage");
if ((selectpage==null) || (selectpage.equals("")))
	selectpage="null";

Date now = new Date();
%>
</head>
<body background="back0.jpg">
<script language="JavaScript">
<!--
	function doPostBack(eventTarget, eventArgument) {
		var theform = document.form1;
		theform.submit();
	}
// -->
</script>
<form name="form1" method="post" action="">
��ʼִ��ʱ�䣺<%= DateFormat.getTimeInstance().format(now)%><br>
<%
			String strPage="",temp="";
			strPage = request.getParameter("page");//ȡ�ô���ʾҳ��
			temp = request.getParameter("selectpage");//����б���е�ҳ��

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
				%>
				��ҳ&nbsp;��һҳ&nbsp;
				<%
			else
			{
				%>
				<a href=page.jsp?page="1">��ҳ</a>
				<a href=page.jsp?page=<%=intPage-1%>>��һҳ</a>
				<%
			}
			
			if (intPage==intPageCount)
				%>
				&nbsp;��һҳ&nbsp;βҳ
				<%
			else
			{
				%>
				<a href=page.jsp?page=<%=intPage+1%>>��һҳ</a>
				<a href=page.jsp?page=<%=intPageCount%>>βҳ</a>
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
			try
			{
				sqlRst=ODB.executeQuery(sql);
				String Colname="";//����
				ResultSetMetaData rsmd;//�����ӿڶ���
				rsmd=sqlRst.getMetaData();
				int cols;//��ò�ѯ���������
				cols=rsmd.getColumnCount()+1;//��ò�ѯ���������
				%>
				<TABLE border=1 width=<% out.print(cols*100);%> style="FONT-SIZE: x-small">
				<tr>
				<%
				for (int i=1;i<cols;i++)//��������
				{	
					Colname=rsmd.getColumnName(i);//���ʵ������
					%>
					<td align="middle"><%= Colname%></td>
					<%
				}
				%></tr><%
				
				//sqlRst.absolute((intPage-1) * intPageSize + 1);
				int datacount=0;

				boolean b=true;
				while (sqlRst.next())// && (datacount<intPageSize))
				{
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

					String color="";//������ɫʱʹ��
					if (b)
						color=" bgcolor=\"#66FFFF\" ";
					else
						color=" bgcolor=\"#00FF00\" ";
					b=!b;
								
					%><tr <%= color%>><%
					for (int i=1;i<cols;i++)
					{
						String getvalue=sqlRst.getString(i);//���ʵ������
						if (getvalue!=null)
						{
							int len=0;
							len=getvalue.length();
							getvalue=getvalue.replaceAll("00:00:00","");
							%>
							<td align="middle"><% if (len!=0) out.print(getvalue);else out.print("&nbsp;"); %></td>
							<%
						}
						else
						{
							%><td>&nbsp;</td><%
						}	
					}
					%></tr><%
				}
				%></table><%
				Date now1 =new Date();
				%>
				��ѯ����ʱ�䣺<%= DateFormat.getTimeInstance().format(now1)%>
				<%
				ODB.destroy();
			}
			catch (Exception e)
			{
				%>
				<div align="center">����������ݷǷ���</div>
				<%
				ODB.destroy();
			}
%>
</form>
</body>
</html>
