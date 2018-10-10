<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../font.css" rel="stylesheet" type="text/css">
<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
</head>
<script language="JavaScript">
	function doPostBack(eventTarget, eventArgument) 
	{
		var theform = document.form1;
		theform.submit();
	}
</script>
<jsp:useBean id="odb" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="odbfield" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>

<body background="../image/back0.jpg">
<%
String user=(String)session.getValue("administrator");//员工id
if (user==null)
{
	session.putValue("errormessage","未能读取到登录管理员的信息。");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}

String selecttable=request.getParameter("selecttable");//获得选择的表名
%>
<form method="post" name="form1" id="form1" action=<% if (selecttable!=null) out.print("fieldsave.jsp?tablename="+selecttable);%>>
  <table width="556" border="0" class="font">
  <tr>
    <td width="550"><div align="center">选择相应的表 
          <select name="selecttable" onChange="doPostBack('selecttable','')">
            <option value="selecttable">选择表</option>
			<%
			ResultSet rs=null;
			String sql="select table_hz,table_name,repeatable from BasInfTMenu where flag='1' and (memo='10' or memo='11' or memo='14' or memo='15')";
			try
			{
				rs=odb.executeQuery(sql);
				while (rs.next())
				{
					String tablename=rs.getString("table_hz");//显示表名
					String truetable=rs.getString("table_name");//实际表名
					%>
					<option value=<%=truetable%> <% if (truetable.equals(selecttable)) out.print("selected");%>><%= tablename%></option>
					<%
				}
			}
			catch (SQLException e)
			{
				session.putValue("errormessage","读取数据列表失败。");
				%>
				<jsp:forward page="errormessage.jsp" />
				<%
			} 
			%>
          </select>
        </div></td>
  </tr>
  <tr>
    <td>
	<table width="600" border="1" class="font">
		<tr>
            <td width="200">字段名</td>
			<td width="200">实际字段名</td>
            <td width="200">是否允许修改</td>
		</tr>
	<tr>
	<%
	ResultSet rsmodify=null;
	String strsql="select field_hz,field_name,modify,field_type from BasInfTFMenu where table_name='"+selecttable+"'";
	rsmodify=odbfield.executeQuery(strsql);
	int checkn=0;
	while(rsmodify.next())
	{
		String field_hz		=	rsmodify.getString("field_hz");//字段名
		String field_name	=	rsmodify.getString("field_name");//实际字段名
		String modify		=	rsmodify.getString("modify");//是否允许修改
		String field_type	=	rsmodify.getString("field_type");//考查字段类型
		boolean	bField		=	true;//是否显示多选按钮

		if (modify==null)
			modify="";
		if (field_hz.equals("id_identity"))
		{
			field_hz	=	"编号";//该字段不许修改
			bField		=	false;
		}
		if (field_hz.equals("id"))//该字段不许修改
		{
			field_hz	=	"姓名";
			bField		=	false;
		}
		%>
		<tr>
		<td><%= field_hz%></td>
		<td><%= field_name%></td>
		<%
		checkn++;
		if (bField)//显示多选按钮
		{
			%>
			<td><input name=checkbox<%= checkn%> type=checkbox <%
																	if (modify.equals("1")) out.print(" checked ");
																	if (field_type.equals("datetime")) out.print(" disabled=true ");
																%>></td>
			<%
			out.println("<input name=hcheckbox"+checkn+" type=hidden value="+field_name+">");
		}
		else//显示多选按钮但不允许修改
		{
			%>
				<td>
				<input name=checkbox<%= checkn%> type=checkbox disabled=true value=0>该字段不允许用户修改
				<input name=hcheckbox<%= checkn%> type=hidden value=<%= field_name%>>
				</td>
			<%
		}
		%>
		</tr>
		<%
	}
	session.putValue("checkn",String.valueOf(checkn));//保存单选框的个数
	%>
  </tr>
  <tr>
  <%
  if (selecttable!=null)
  {
	%>
	<td>&nbsp;</td>
    <td><input name="submit" type="submit" value="确定"></td>
    <td><input name="reset" type="reset" value="重填"></td>
	<%
  }	  
  %>
  </tr>
</table>
	</td>
  </tr>
</table>

</form>
</body>
</html>
