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
<%--该页面显示的员工数据，都是表中工号不重复的--%>
<%
String id=(String)session.getValue("id");//员工id
if (id==null)
{
	session.putValue("errormessage","未能读取到登录员工的信息,请重新<a href=login.jsp>登录</a>。");
	%>
	<jsp:forward page="errormessage.jsp" />
	<%
}
String pname		=	ODB.executeQuery_String("select A0101 from A01 where id="+id);//员工姓名
String truetable	=	request.getParameter("truetable");//实际表名
String showtable	=	ODB.executeQuery_String("select table_hz from BasInfTMenu where table_name='"+truetable+"'");//获得显示表名
String fname		=	"";//员工照片名字
Date now			=	new Date();
Date now1			=	new Date();

if (session.getValue("fname")!=null)
	fname=(String)session.getValue("fname");//取出存储过的照片名字

//out.println("开始执行时间："+DateFormat.getTimeInstance().format(now)+"<br>");
%>

<table width="800" height="206" border="0" class="font">
  <tr> 
    <td height="52" valign=top>
	<%
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//处理照片
	if (fname.equals("0"))//照片还没有显示
	{
		String Path	=	JCPATH.PATH;
		fname		=	CC.CreatePhoto("select C0115 from A01 where id="+id,Path);
		session.putValue("fname",fname);//保存照片名字
	}
	%>
<input type="image" title=<%= pname%> src=photo\<%= fname%> alt="没有该员工的照片" width="124" height="163">

    <td rowspan="2">
	<%//显示员工数据
	String sql			=	CS.createselect(truetable,"A01.id","=",id);
	ResultSet rs		=	null;
	ResultSet rsmodify	=	null;
	ResultSet sqlRst	=	null;

	ResultSetMetaData rsmd;//声明接口对象
	rs				=	ODB1.executeQuery(sql);
	rsmd			=	rs.getMetaData();
	int cols		=	rsmd.getColumnCount()+1;//获得查询结果的列数
	int txtn		=	0;//文本框的个数
	int seln		=	0;//选择框的个数
	int canmodify	=	0;//可以修改的数据个数
try
{
	if (rs.next())
	{
		%>
<form method=post action=updatesingle.jsp?tablename=<%= truetable%>&id=<%= id%>>
		
		<table width=500 border=0 class="font">
		<tr> 
		<td colspan="2"><div align="center"><font size="4">这是您在<%= showtable%>里的信息</font></div></td>
	  </tr>
		<%
		for (int i=1;i<cols;i++)
		{
			String Colname	=	rsmd.getColumnName(i);//获得实际列名
			String data		=	rs.getString(i);//获得数据
			
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

			if (Colname.equals("照片"))
				continue;
			if (data==null)
				data="&nbsp;";
			%>
			<tr>
			<td align=left width=250><%= Colname%></td>
			<td align=left width=250>
			<%
			if (modify.equals("1"))//允许修改
			{
				canmodify++;
				
				//memo		=	rsmodify.getString("memo");
				//ield_name	=	rsmodify.getString("field_name");

				if (memo.equals("0"))//输入
				{
					txtn++;
					
					//type		=	rsmodify.getString("field_type");
					//field_len	=	(int)rsmodify.getFloat("field_len");

					if (type.equals("datetime"))//输入日期
					{
						//data=CS.ReplaceString(data,"-"," ");
						out.println("<input name=txt"+txtn+" type=text value=\""+data+"\" onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
						out.println("<input name=htxt"+txtn+" type=hidden value=T"+field_name+">");
					}
					else
					{
						if (field_len<=200)//单行数据
						{
							out.println("<input name=txt"+txtn+" type=text value=\""+data+"\" maxlength="+field_len+" onmousemove='JavaScript:this.focus()' onfocus='JavaScript:this.select()'>");
							out.println("<input name=htxt"+txtn+" type=hidden value="+field_name+">");
						}
						else//多行数据
						{
							out.println("<textarea name=txt"+txtn+" rows=10 class=listboxwidth>"+data+"</textarea>");
							out.println("<input name=htxt"+txtn+" type=hidden value="+field_name+">");
						}
					}
				}
				else if (memo.equals("1"))//选择
				{
					seln++;

					//code		=	rsmodify.getString("code");

					out.println("<input name=hsel"+seln+" type=hidden value="+field_name+">");
					%>
					<select name=sel<%= seln%>>
					<option value="">请选择</option>
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
				session.putValue("txtn",String.valueOf(txtn));//保存文本框的个数
				session.putValue("seln",String.valueOf(seln));//保存选择框的个数
			}
			else//不允许修改
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
		<br>
		<%
	}
	else
	{
		%><div align="center">没有数据。</div><%
	}
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
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
