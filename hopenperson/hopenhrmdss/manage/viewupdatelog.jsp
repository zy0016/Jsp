<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>查看数据更新日志</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../font.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">
function verty_field()
{
	if (form1.selectfind.selectedIndex==0)
	{
		alert("您希望查询哪一个字段的数据。");
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
String user=(String)session.getValue("administrator");//员工id
if (user==null)
{
	session.putValue("errormessage","未能读取到登录管理员的信息。");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}

String selectfind	=	request.getParameter("selectfind");//获得选择的数据
String selectterm	=	request.getParameter("selectterm");//获得选择的条件
String finddata		=	request.getParameter("data");//获得输入的查询数据
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
		查询<select name="selectfind" id="selectfind">
          <option value="" selected>请选择查询条件</option>
		  <%
			ResultSetMetaData rsmd;//声明接口对象
			ResultSet rs	=	null;
			String sqlstr	=	"select * from "+tablename+" where id=0";
			rs				=	odb.executeQuery(sqlstr);
			rsmd			=	rs.getMetaData();
			int cols		=	rsmd.getColumnCount();//获得查询结果的列数
			int width		=	cols*150;
			String Colname	=	"";

			for (int i=1;i<=cols;i++)
			{
				Colname	=	rsmd.getColumnName(i);//获得实际列名
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
			<option value="=" <% if (selectterm.equals("=")) out.print("selected");%>>等于</option>
			<option value="&lt;&gt;" <% if (selectterm.equals("<>")) out.print("selected");%>>不等于</option>
			<option value="&gt;" <% if (selectterm.equals(">")) out.print("selected");%>>大于</option>
			<option value="&gt;=" <% if (selectterm.equals(">=")) out.print("selected");%>>大于等于</option>
			<option value="&lt;" <% if (selectterm.equals("<")) out.print("selected");%>>小于</option>
			<option value="&lt;=" <% if (selectterm.equals("<=")) out.print("selected");%>>小于等于</option>
			<option value="like"  <% if (selectterm.equals("like")) out.print("selected");%>>包含</option>
			<option value="not like"  <% if (selectterm.equals("not like")) out.print("selected");%>>不包含</option>
        </select>
        <input name="data" type="text" id="data" value="<%= finddata%>">
        <input type="submit" name="Submit" value="开始查询" onclick="return verty_field();">
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
//////////////////////////////////分页显示/////////////////////////////////////////////////////////
			int intPageSize=30;	//一页显示的记录数
			int intRowCount=0;	//记录总数
			int intPageCount=0;	//总页数
			int intPage=0;		//待显示页码

			String strPage="",temp="";
			strPage	= request.getParameter("page");//取得待显示页码
			temp	= request.getParameter("selectpage");//获得列表框中的页号

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
			{
				%>首页&nbsp;上一页&nbsp;<%
			}
			else
			{
				%>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page="1">首页</a>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page=<%=intPage-1%>>上一页</a>
				<%
			}
			
			if (intPage==intPageCount)
			{
				%>&nbsp;下一页&nbsp;尾页	<%
			}
			else
			{
				%>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page=<%=intPage+1%>>下一页</a>
				<a href=viewupdatelog.jsp?tablename=<%= tablename%>&page=<%=intPageCount%>>尾页</a>
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
/////////////////////////////////////////////////////////////////////////////////////////

		%>
		<table width=<%= width%> border=1 class="font">
			<tr>
				<%
				ResultSetMetaData rsmdf;//声明接口对象
				ResultSet rslog	=	null;
				rslog			=	odblog.executeQuery(sql);
				rsmdf			=	rslog.getMetaData();
				
				for (int i=1;i<=cols;i++)
				{
					Colname	=	rsmdf.getColumnName(i);//获得实际列名
					if (Colname.equals("id"))
						Colname="编号";
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
////////////////////////////////////////////////////////////////////////////////////////
				String color="";//设置颜色时使用
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
					String getvalue=rslog.getString(i);//获得实际数据

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
	session.putValue("errormessage",sql);//"数据更新失败，您可能输入了非法的数据。"
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
} 
%>
</body>
</html>
