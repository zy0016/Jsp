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
<title>测试分页</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<jsp:useBean id="ODBcount" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<%
int intPageSize=10;	//一页显示的记录数
int intRowCount=0;	//记录总数
int intPageCount=0;	//总页数
int intPage=0;		//待显示页码

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
开始执行时间：<%= DateFormat.getTimeInstance().format(now)%><br>
<%
			String strPage="",temp="";
			strPage = request.getParameter("page");//取得待显示页码
			temp = request.getParameter("selectpage");//获得列表框中的页号

			if ((strPage==null) || (strPage.equals("null")) || (strPage.equals("")))//表明在QueryString中没有page这一个参数，此时显示第一页数据
			{
				if ((temp!=null) && (!temp.equals("null")))
					intPage=Integer.parseInt(temp);
				else
					intPage = 1;
			}
			else
			{
				try//将字符串转换成整型
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
			intPageCount = (intRowCount+intPageSize-1) / intPageSize;//记算总页数
			%>
			共找到<%=intRowCount %>条数据&nbsp;&nbsp;
			<%
			if (intPage==1)
				%>
				首页&nbsp;上一页&nbsp;
				<%
			else
			{
				%>
				<a href=page.jsp?page="1">首页</a>
				<a href=page.jsp?page=<%=intPage-1%>>上一页</a>
				<%
			}
			
			if (intPage==intPageCount)
				%>
				&nbsp;下一页&nbsp;尾页
				<%
			else
			{
				%>
				<a href=page.jsp?page=<%=intPage+1%>>下一页</a>
				<a href=page.jsp?page=<%=intPageCount%>>尾页</a>
				<%
			}
			%>
			&nbsp;跳转到&nbsp;<select name="selectpage" onChange="doPostBack('selectpage','')">
			<%
			for (int i=1;i<=intPageCount;i++)
			{
				%>
				<option value=<%=i%> <%if (intPage==i) out.println("selected");%>>第<%=i%>页</option>
				<%
			}
			%>
			</select>
			第<%=intPage%>页/共<%=intPageCount%>页&nbsp;&nbsp;每页显示<%=intPageSize%>条数据
			<%
			try
			{
				sqlRst=ODB.executeQuery(sql);
				String Colname="";//列名
				ResultSetMetaData rsmd;//声明接口对象
				rsmd=sqlRst.getMetaData();
				int cols;//获得查询结果的列数
				cols=rsmd.getColumnCount()+1;//获得查询结果的列数
				%>
				<TABLE border=1 width=<% out.print(cols*100);%> style="FONT-SIZE: x-small">
				<tr>
				<%
				for (int i=1;i<cols;i++)//生成列名
				{	
					Colname=rsmd.getColumnName(i);//获得实际列名
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
					if (intPage==1)//首页
					{
						if (datacount>intPageSize)
							break;
					}
					if (intPage==intPageCount)//尾页
					{
						if (datacount <= ((intPage-1) * intPageSize))
							continue;
					}
					if ((1<intPage) && (intPage<intPageCount))
					{
						if (!((intPage-1)*intPageSize+1<=datacount && datacount<=intPageSize*intPage))
							continue;
					}

					String color="";//设置颜色时使用
					if (b)
						color=" bgcolor=\"#66FFFF\" ";
					else
						color=" bgcolor=\"#00FF00\" ";
					b=!b;
								
					%><tr <%= color%>><%
					for (int i=1;i<cols;i++)
					{
						String getvalue=sqlRst.getString(i);//获得实际数据
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
				查询结束时间：<%= DateFormat.getTimeInstance().format(now1)%>
				<%
				ODB.destroy();
			}
			catch (Exception e)
			{
				%>
				<div align="center">你输入的数据非法！</div>
				<%
				ODB.destroy();
			}
%>
</form>
</body>
</html>
