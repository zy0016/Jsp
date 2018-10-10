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
<title>综合查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
  //window.showModalDialog("findoption.jsp");
}
//-->
</script>
</head>

<script language="JavaScript" type="text/JavaScript">
function verty_table()
{
	if (form1.selecttable.selectedIndex==0)
	{
		alert("您希望查询哪一个表的数据。");
		form1.selecttable.focus();
		return false;
	}
	else
		return true;
}
function verity_text()//文字输入
{
	if (form1.selecttable.selectedIndex==0)
	{
		alert("您希望查询哪一个表的数据。");
		form1.selecttable.focus();
		return false;
	}
	else if (form1.listfield.selectedIndex==0)
	{
		alert("选择查询字段");
		form1.listfield.focus();
		return false;
	}
	else if (form1.textfield.value=="")
	{
		alert("输入数据");
		form1.textfield.focus();
		return false;
	}
	else if (form1.textfield.value.indexOf("'")>=0)
	{
		alert("请不要输入单引号。");
		form1.textfield.focus();
		return false;
	}
	document.cookie="beginfind=true";
	return true;
}
function verity_list()//选择数据
{
	if (form1.selecttable.selectedIndex==0)
	{
		alert("您希望查询哪一个表的数据。");
		form1.selecttable.focus();
		return false;
	}
	else if (form1.listfield.selectedIndex==0)
	{
		alert("选择查询字段");
		form1.listfield.focus();
		return false;
	}
	else if (form1.fieldvalue.selectedIndex=="")
	{
		alert("选择数据");
		form1.fieldvalue.focus();
		return false;
	}
	document.cookie="beginfind=true";
	return true;
}
</script>

<body background="back0.jpg" STYLE="table-layout:fixed"><!-- onselectstart="return false"-->
<% 
String uname=(String)session.getValue("username");
if ((uname==null) || (uname.equals("")))//让用户登录
{
%>
	<jsp:forward page="login.jsp" />
<%
}
String selecttable=request.getParameter("selecttable");//获得选择的表名
//if (selecttable!=null)//存储选择的表名
//	session.putValue("selecttable",selecttable);

String selectfield=request.getParameter("listfield");//获得选择的字段名

String selectterm=request.getParameter("term");//获得选择的条件
if (selectterm==null)
	selectterm="";

String selectvalue=request.getParameter("fieldvalue");//获得选择的数据
String enter=request.getParameter("textfield");//获得输入的数据
String entertxt="";
if (enter!=null)//存储输入的数据
{
	entertxt=new String(enter.getBytes("ISO8859-1"));
	session.putValue("entertxt",entertxt);
}
String sortfield=request.getParameter("sortf");//获得选择的排序的字段
String sortasc_desc=request.getParameter("sort");//获得升序降序

int intPageSize=10;	//一页显示的记录数
int intRowCount;	//记录总数
int intPageCount;	//总页数
int intPage;		//待显示页码

ResultSet sqlRst=null;
ResultSet rs=null;
ResultSet rssort=null;
 %>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBS" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODBcount" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>

<script language="JavaScript">
<!--
	function doPostBack(eventTarget, eventArgument) {
		var theform = document.form1;
		//theform.__EVENTTARGET.value = eventTarget;
		//theform.__EVENTARGUMENT.value = eventArgument;
		theform.submit();
	}
// -->
</script>
<table width="800" height="113" border="0">
  <tr>
    <td width="800" height="109">
      <form name="form1" method="post" action="">
        <p>哪方面的数据： 
			<%//String seltable=(String)session.getValue("selecttable");//获得表名%>
          <select name="selecttable" onChange="doPostBack('selecttable','')">
            <option value="null" >请选择表</option>
            <% //添加表名
			String result="";
			String values="";
			try 
			{ 
				String query="select * from BasInfTMenu where flag=1 and table_name<>'C50'"; 
				sqlRst=ODB.executeQuery(query);
				while(sqlRst.next())
				{
					result=sqlRst.getString("table_hz");
					values=sqlRst.getString("table_name");
					%>
					<option value=<%= values%> <% if (values.equals(selecttable)) out.print("selected");%>> <%= result%> </option>
					<%
				}
			}
			catch (Exception e)
			{
				%>
				<div align="center">添加查询用表失败！</div>
				<%
			} 
			%>
          </select>
          <input name="select_Submit" type="submit" class="ok1" style="width:150;height:22;color:#000000;background-color:#DDDDFF;background-repeat:repeat;background-attachment:scroll;font-size:9pt;border:1px dashed rgb(255,255,255);background-position:0%" onClick="return verty_table()" onMouseOver=this.style.color='#ff00ff' onMouseOut=this.style.color='#000000' value="查询" >
       
        </p>
		<p>具体方面： 
          <select name="listfield" id="listfield" onChange="doPostBack('listfield','')">
            <option value="null" >请选择</option>
            <% //添加该查询表的字段
			String res="";
			String val="";
			try 
			{ 
				String query="select * from BasInfTFMenu where table_name='"+selecttable+"'";//tablename
				sqlRst=ODB.executeQuery(query);
				while(sqlRst.next())
				{
					res=sqlRst.getString("field_hz");
					val=sqlRst.getString("field_name");
					String result_val=selecttable+"."+val;//tablename

					if (val.equals("id"))
					{
						%>
						<option value=A01.A0101 <% if (selectfield.equals("A01.A0101")) out.print("selected");%>>姓名</option>
						<%
						
					}
					else if (val.equals("id_identity"))
					{
						%>
						<option value=<% out.print(selecttable+"."+val);%> <% if (result_val.equals(selectfield)) out.print("selected");%>>编号</option>
						<%
					}
					else
					{
						%>
						<option value=<% out.print(selecttable+"."+val);%> <% if (result_val.equals(selectfield)) out.print("selected");%>><%= res%></option>
						<%
					}
				}
			}
			catch (Exception e)
			{
				%>
				<div align="center">字段显示失败</div>
				<%
			} 
			%>
          </select>
          <select name="term" id="term">
            <option value="=" <% if (selectterm.equals("=")) out.print("selected");%>>等于</option>
            <option value="&gt;" <% if (selectterm.equals(">")) out.print("selected");%>>大于</option>
            <option value="&lt;" <% if (selectterm.equals("<")) out.print("selected");%>>小于</option>
            <option value="&gt;=" <% if (selectterm.equals(">=")) out.print("selected");%>>大于等于</option>
            <option value="&lt;=" <% if (selectterm.equals("<=")) out.print("selected");%>>小于等于</option>
            <option value="&lt;&gt;" <% if (selectterm.equals("<>")) out.print("selected");%>>不等于</option>
            <option value="like" <% if (selectterm.equals("like")) out.print("selected");%>>包含</option>
            <option value="not like" <% if (selectterm.equals("not like")) out.print("selected");%>>不包含</option>
          </select>
          <% //根据选择的字段，添加相关的数据
			String sql="";
			if (selectfield!=null)// && (!selectfield.equals("")))
			{
				if (selecttable.compareTo("A01")!=0)//不是A01表
				{
					if (selectfield.compareTo("A01.A0101")==0)
						sql="select * from BasInfTFMenu where table_name='"+selecttable+"' and field_name='id'";	
					else
						sql="select * from BasInfTFMenu where table_name='"+selecttable+"' and field_name='"+CS.getleft_rightstr(selectfield,".",1)+"'";
				}
				else
					sql="select * from BasInfTFMenu where table_name='"+selecttable+"' and field_name='"+CS.getleft_rightstr(selectfield,".",1)+"'";

				sqlRst=ODB.executeQuery(sql);
				session.putValue("value_type","");
				if (sqlRst.next())
				{
					String memo=sqlRst.getString("memo");
					String code=sqlRst.getString("code");
					if (memo.equals("0"))//输入
					{
						%>
						<input name=textfield type=text size=20 value=<% if (entertxt!=null) out.print(entertxt);%>>
						<%
						session.putValue("value_type","0");//设置标志
					}
					else if (memo.equals("1"))//选择
					{
						%>
						<select name=fieldvalue id=fieldvalue>
						<option value=null>请选择</option>
						<%
						if (code.indexOf("B02")>=0)
						{
							if (code.equals("B020"))
								sql="select B0205,B0210 from B02 where B0215='0'";
							else if (code.equals("B021"))
								sql="select B0205,B0210 from B02 where B0215='1'";
							else if (code.equals("B022"))
								sql="select B0205,B0210 from B02 where B0215='2'";
						}
						else
							sql="select Name,Idcode from dataList where code='"+code+"'";

						sqlRst=ODB.executeQuery(sql);
						while(sqlRst.next())
						{
							String vals=sqlRst.getString(1);
							String Idcode=sqlRst.getString(2);
							%>
							<option value=<%= Idcode%> <% if (Idcode.equals(selectvalue)) out.print("selected");%>><%= vals%></option>
							<%
						}
						%>
						</select>
						<%
						session.putValue("value_type","1");//设置标志
					}
				}
			}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				rssort=ODBS.executeQuery("select * from BasInfTFMenu where table_name='"+selecttable+"'");
				%>
				<select name="sortf">
				<option value=null>请选择排序字段</option>
				<%
				while(rssort.next())
				{
					String ressort=rssort.getString("field_hz");
					String valsort=rssort.getString("field_name");
					String result_valsort=selecttable+"."+valsort;

					if (valsort.equals("id"))
					{
						%>
						<option value=A01.A0101 <% if (sortfield.equals("A01.A0101")) out.print("selected");%>>姓名</option>
						<%
					}
					else if (valsort.equals("id_identity"))
					{
						%>
						<option value=<%out.print(selecttable+"."+valsort);%> <%if (result_valsort.equals("id_identity")) out.print("selected");%>>编号</option>
						<%
					}
					else
					{
						%>
						<option value=<%out.print(selecttable+"."+valsort);%> <%if (result_valsort.equals(sortfield)) out.print("selected");%>><%= ressort%></option>
						<%
					}
				}
				%>
				</select>
				<select name="sort">
				<%if (sortasc_desc==null)
					{%>
					<option value="asc" selected>升序</option>
					<option value="desc">降序</option>
					<%}
				else 
					{%>
					<option value="asc" <%if (sortasc_desc.equals("asc")) out.print("selected");%>>升序</option>
					<option value="desc" <%if (sortasc_desc.equals("desc")) out.print("selected");%>>降序</option>
					<%}%>
				</select><br>
				<%
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 %>
</p>
      </form>
    </td>
  </tr>
</table>
<!--
<input name="option" type="button" onClick="MM_openBrWindow('findoption.jsp','findoption','scrollbars=yes,resizable=yes,width=600,height=600')" value="查询选项">
-->
<% 
String value_type=(String)session.getValue("value_type");
String value="";
boolean startfind=true;
//String outputsql=(String)session.getValue("output");

if ((value_type!=null) && (!value_type.equals("")))
{
	if (value_type.equals("1"))//选择
		value=request.getParameter("fieldvalue");
	else if (value_type.equals("0"))//输入
		value=entertxt;

	if (startfind)
	{
		if ((selecttable!=null) && (selectfield!=null) && (value!=null) && (value!="null") && (value!=""))
		{
			String field="*";
			Date now = new Date();
			sql=CS.createselect(selecttable,selectfield,selectterm,value);
			//session.putValue("output",sql);
			%>
			<TABLE>
			<TR>
				<TD>
				<FORM name=form_out METHOD=POST ACTION=output.jsp target=_blank>
					<INPUT TYPE=submit name=output value=输出到Excel中去>
				</form>
				</TD>
				<TD>
				<FORM name="page" METHOD="POST" ACTION=page.jsp target=_blank>
					<INPUT TYPE=submit name=page value=分页显示>
				</form>
				</TD>
			</TR>
			</TABLE>
			
			
			开始执行时间：<%= DateFormat.getTimeInstance().format(now)%><br>	
<%
			String strPage="";
			strPage = request.getParameter("page");//取得待显示页码
			if(strPage==null)//表明在QueryString中没有page这一个参数，此时显示第一页数据
				intPage = 1;
			else
			{//将字符串转换成整型
				intPage = Integer.parseInt(strPage);
				if(intPage<1) 
					intPage = 1;
			}

			intRowCount=ODBcount.executeQuery_long(sql);
			intPageCount = (intRowCount+intPageSize-1) / intPageSize;//记算总页数

			out.println("共找到"+intRowCount+"条数据&nbsp;&nbsp;"+"共"+intPageCount+"页&nbsp;&nbsp;当前页:"+intPage+"&nbsp;&nbsp;");
			if (intPage==1)
				out.println("首页&nbsp;上一页&nbsp;");
			else
			{
				%>
				<a href=hrmdssfind.jsp?page="1">首页</a>
				<a href=hrmdssfind.jsp?page=<%=intPage-1%>>上一页</a>
				<%
			}
			
			if (intPage==intPageCount)
				out.println("尾页&nbsp;下一页");
			else
			{
				%>
				<a href=hrmdssfind.jsp?page=<%=intPage+1%>>下一页</a>
				<a href=hrmdssfind.jsp?page=<%=intPageCount%>&selecttable=<%=selecttable%>&listfield=<%=selectfield%>&term=<%=selectterm%>&fieldvalue=<%=selectvalue%>&textfield=<%=enter%>>尾页</a>
				<!--<a href=hrmdssfind.jsp?page=<%=intPageCount%>>尾页</a>-->
				<%
			}
%>
<br>
<%
			if (!sortfield.equals("null"))
			{
				sql=sql+" order by "+sortfield+" "+sortasc_desc;
			}
			session.putValue("output",sql);
			try
			{
				sqlRst=ODB.executeQuery(sql);
				int count=0;//计数器
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
				while (sqlRst.next())
				{
///////////////////////////////////////////////////////////////////////////////////
					/*if (intPage==1)
					{
						if (datacount>10)
							break;
					}
					if (intPage==intPageCount)
					{
						if (datacount < (intPage * intPageSize))
							continue;
					}
					datacount++;*/
///////////////////////////////////////////////////////////////////////////////////
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
					count++;
				}
				%></table><%
				Date now1 =new Date();
				%>
				<!--共找到：<%= Integer.toString(count)%>条数据。<br>-->
				查询结束时间：<%= DateFormat.getTimeInstance().format(now1)%>
				<%
				ODB.destroy();
				ODBS.destroy();
				ODBcount.destroy();
			}
			catch (Exception e)
			{
				%>
				<div align="center">你输入的数据非法！</div>
				<%
				ODB.destroy();
				ODBS.destroy();	
				ODBcount.destroy();
			} 
		}
	}
}
%>
<P>
</body>
</html>