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
String user=(String)session.getValue("administrator");//Ա��id
if (user==null)
{
	session.putValue("errormessage","δ�ܶ�ȡ����¼����Ա����Ϣ��");
	%>
	<jsp:forward page="..\errormessage.jsp" />
	<%
}

String selecttable=request.getParameter("selecttable");//���ѡ��ı���
%>
<form method="post" name="form1" id="form1" action=<% if (selecttable!=null) out.print("fieldsave.jsp?tablename="+selecttable);%>>
  <table width="556" border="0" class="font">
  <tr>
    <td width="550"><div align="center">ѡ����Ӧ�ı� 
          <select name="selecttable" onChange="doPostBack('selecttable','')">
            <option value="selecttable">ѡ���</option>
			<%
			ResultSet rs=null;
			String sql="select table_hz,table_name,repeatable from BasInfTMenu where flag='1' and (memo='10' or memo='11' or memo='14' or memo='15')";
			try
			{
				rs=odb.executeQuery(sql);
				while (rs.next())
				{
					String tablename=rs.getString("table_hz");//��ʾ����
					String truetable=rs.getString("table_name");//ʵ�ʱ���
					%>
					<option value=<%=truetable%> <% if (truetable.equals(selecttable)) out.print("selected");%>><%= tablename%></option>
					<%
				}
			}
			catch (SQLException e)
			{
				session.putValue("errormessage","��ȡ�����б�ʧ�ܡ�");
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
            <td width="200">�ֶ���</td>
			<td width="200">ʵ���ֶ���</td>
            <td width="200">�Ƿ������޸�</td>
		</tr>
	<tr>
	<%
	ResultSet rsmodify=null;
	String strsql="select field_hz,field_name,modify,field_type from BasInfTFMenu where table_name='"+selecttable+"'";
	rsmodify=odbfield.executeQuery(strsql);
	int checkn=0;
	while(rsmodify.next())
	{
		String field_hz		=	rsmodify.getString("field_hz");//�ֶ���
		String field_name	=	rsmodify.getString("field_name");//ʵ���ֶ���
		String modify		=	rsmodify.getString("modify");//�Ƿ������޸�
		String field_type	=	rsmodify.getString("field_type");//�����ֶ�����
		boolean	bField		=	true;//�Ƿ���ʾ��ѡ��ť

		if (modify==null)
			modify="";
		if (field_hz.equals("id_identity"))
		{
			field_hz	=	"���";//���ֶβ����޸�
			bField		=	false;
		}
		if (field_hz.equals("id"))//���ֶβ����޸�
		{
			field_hz	=	"����";
			bField		=	false;
		}
		%>
		<tr>
		<td><%= field_hz%></td>
		<td><%= field_name%></td>
		<%
		checkn++;
		if (bField)//��ʾ��ѡ��ť
		{
			%>
			<td><input name=checkbox<%= checkn%> type=checkbox <%
																	if (modify.equals("1")) out.print(" checked ");
																	if (field_type.equals("datetime")) out.print(" disabled=true ");
																%>></td>
			<%
			out.println("<input name=hcheckbox"+checkn+" type=hidden value="+field_name+">");
		}
		else//��ʾ��ѡ��ť���������޸�
		{
			%>
				<td>
				<input name=checkbox<%= checkn%> type=checkbox disabled=true value=0>���ֶβ������û��޸�
				<input name=hcheckbox<%= checkn%> type=hidden value=<%= field_name%>>
				</td>
			<%
		}
		%>
		</tr>
		<%
	}
	session.putValue("checkn",String.valueOf(checkn));//���浥ѡ��ĸ���
	%>
  </tr>
  <tr>
  <%
  if (selecttable!=null)
  {
	%>
	<td>&nbsp;</td>
    <td><input name="submit" type="submit" value="ȷ��"></td>
    <td><input name="reset" type="reset" value="����"></td>
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
