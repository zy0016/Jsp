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
<title>�ۺϲ�ѯ</title>
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
		alert("��ϣ����ѯ��һ��������ݡ�");
		form1.selecttable.focus();
		return false;
	}
	else
		return true;
}
function verity_text()//��������
{
	if (form1.selecttable.selectedIndex==0)
	{
		alert("��ϣ����ѯ��һ��������ݡ�");
		form1.selecttable.focus();
		return false;
	}
	else if (form1.listfield.selectedIndex==0)
	{
		alert("ѡ���ѯ�ֶ�");
		form1.listfield.focus();
		return false;
	}
	else if (form1.textfield.value=="")
	{
		alert("��������");
		form1.textfield.focus();
		return false;
	}
	else if (form1.textfield.value.indexOf("'")>=0)
	{
		alert("�벻Ҫ���뵥���š�");
		form1.textfield.focus();
		return false;
	}
	document.cookie="beginfind=true";
	return true;
}
function verity_list()//ѡ������
{
	if (form1.selecttable.selectedIndex==0)
	{
		alert("��ϣ����ѯ��һ��������ݡ�");
		form1.selecttable.focus();
		return false;
	}
	else if (form1.listfield.selectedIndex==0)
	{
		alert("ѡ���ѯ�ֶ�");
		form1.listfield.focus();
		return false;
	}
	else if (form1.fieldvalue.selectedIndex=="")
	{
		alert("ѡ������");
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
if ((uname==null) || (uname.equals("")))//���û���¼
{
%>
	<jsp:forward page="login.jsp" />
<%
}
String selecttable=request.getParameter("selecttable");//���ѡ��ı���
//if (selecttable!=null)//�洢ѡ��ı���
//	session.putValue("selecttable",selecttable);

String selectfield=request.getParameter("listfield");//���ѡ����ֶ���

String selectterm=request.getParameter("term");//���ѡ�������
if (selectterm==null)
	selectterm="";

String selectvalue=request.getParameter("fieldvalue");//���ѡ�������
String enter=request.getParameter("textfield");//������������
String entertxt="";
if (enter!=null)//�洢���������
{
	entertxt=new String(enter.getBytes("ISO8859-1"));
	session.putValue("entertxt",entertxt);
}
String sortfield=request.getParameter("sortf");//���ѡ���������ֶ�
String sortasc_desc=request.getParameter("sort");//���������

int intPageSize=10;	//һҳ��ʾ�ļ�¼��
int intRowCount;	//��¼����
int intPageCount;	//��ҳ��
int intPage;		//����ʾҳ��

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
        <p>�ķ�������ݣ� 
			<%//String seltable=(String)session.getValue("selecttable");//��ñ���%>
          <select name="selecttable" onChange="doPostBack('selecttable','')">
            <option value="null" >��ѡ���</option>
            <% //��ӱ���
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
				<div align="center">��Ӳ�ѯ�ñ�ʧ�ܣ�</div>
				<%
			} 
			%>
          </select>
          <input name="select_Submit" type="submit" class="ok1" style="width:150;height:22;color:#000000;background-color:#DDDDFF;background-repeat:repeat;background-attachment:scroll;font-size:9pt;border:1px dashed rgb(255,255,255);background-position:0%" onClick="return verty_table()" onMouseOver=this.style.color='#ff00ff' onMouseOut=this.style.color='#000000' value="��ѯ" >
       
        </p>
		<p>���巽�棺 
          <select name="listfield" id="listfield" onChange="doPostBack('listfield','')">
            <option value="null" >��ѡ��</option>
            <% //��Ӹò�ѯ����ֶ�
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
						<option value=A01.A0101 <% if (selectfield.equals("A01.A0101")) out.print("selected");%>>����</option>
						<%
						
					}
					else if (val.equals("id_identity"))
					{
						%>
						<option value=<% out.print(selecttable+"."+val);%> <% if (result_val.equals(selectfield)) out.print("selected");%>>���</option>
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
				<div align="center">�ֶ���ʾʧ��</div>
				<%
			} 
			%>
          </select>
          <select name="term" id="term">
            <option value="=" <% if (selectterm.equals("=")) out.print("selected");%>>����</option>
            <option value="&gt;" <% if (selectterm.equals(">")) out.print("selected");%>>����</option>
            <option value="&lt;" <% if (selectterm.equals("<")) out.print("selected");%>>С��</option>
            <option value="&gt;=" <% if (selectterm.equals(">=")) out.print("selected");%>>���ڵ���</option>
            <option value="&lt;=" <% if (selectterm.equals("<=")) out.print("selected");%>>С�ڵ���</option>
            <option value="&lt;&gt;" <% if (selectterm.equals("<>")) out.print("selected");%>>������</option>
            <option value="like" <% if (selectterm.equals("like")) out.print("selected");%>>����</option>
            <option value="not like" <% if (selectterm.equals("not like")) out.print("selected");%>>������</option>
          </select>
          <% //����ѡ����ֶΣ������ص�����
			String sql="";
			if (selectfield!=null)// && (!selectfield.equals("")))
			{
				if (selecttable.compareTo("A01")!=0)//����A01��
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
					if (memo.equals("0"))//����
					{
						%>
						<input name=textfield type=text size=20 value=<% if (entertxt!=null) out.print(entertxt);%>>
						<%
						session.putValue("value_type","0");//���ñ�־
					}
					else if (memo.equals("1"))//ѡ��
					{
						%>
						<select name=fieldvalue id=fieldvalue>
						<option value=null>��ѡ��</option>
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
						session.putValue("value_type","1");//���ñ�־
					}
				}
			}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				rssort=ODBS.executeQuery("select * from BasInfTFMenu where table_name='"+selecttable+"'");
				%>
				<select name="sortf">
				<option value=null>��ѡ�������ֶ�</option>
				<%
				while(rssort.next())
				{
					String ressort=rssort.getString("field_hz");
					String valsort=rssort.getString("field_name");
					String result_valsort=selecttable+"."+valsort;

					if (valsort.equals("id"))
					{
						%>
						<option value=A01.A0101 <% if (sortfield.equals("A01.A0101")) out.print("selected");%>>����</option>
						<%
					}
					else if (valsort.equals("id_identity"))
					{
						%>
						<option value=<%out.print(selecttable+"."+valsort);%> <%if (result_valsort.equals("id_identity")) out.print("selected");%>>���</option>
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
					<option value="asc" selected>����</option>
					<option value="desc">����</option>
					<%}
				else 
					{%>
					<option value="asc" <%if (sortasc_desc.equals("asc")) out.print("selected");%>>����</option>
					<option value="desc" <%if (sortasc_desc.equals("desc")) out.print("selected");%>>����</option>
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
<input name="option" type="button" onClick="MM_openBrWindow('findoption.jsp','findoption','scrollbars=yes,resizable=yes,width=600,height=600')" value="��ѯѡ��">
-->
<% 
String value_type=(String)session.getValue("value_type");
String value="";
boolean startfind=true;
//String outputsql=(String)session.getValue("output");

if ((value_type!=null) && (!value_type.equals("")))
{
	if (value_type.equals("1"))//ѡ��
		value=request.getParameter("fieldvalue");
	else if (value_type.equals("0"))//����
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
					<INPUT TYPE=submit name=output value=�����Excel��ȥ>
				</form>
				</TD>
				<TD>
				<FORM name="page" METHOD="POST" ACTION=page.jsp target=_blank>
					<INPUT TYPE=submit name=page value=��ҳ��ʾ>
				</form>
				</TD>
			</TR>
			</TABLE>
			
			
			��ʼִ��ʱ�䣺<%= DateFormat.getTimeInstance().format(now)%><br>	
<%
			String strPage="";
			strPage = request.getParameter("page");//ȡ�ô���ʾҳ��
			if(strPage==null)//������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
				intPage = 1;
			else
			{//���ַ���ת��������
				intPage = Integer.parseInt(strPage);
				if(intPage<1) 
					intPage = 1;
			}

			intRowCount=ODBcount.executeQuery_long(sql);
			intPageCount = (intRowCount+intPageSize-1) / intPageSize;//������ҳ��

			out.println("���ҵ�"+intRowCount+"������&nbsp;&nbsp;"+"��"+intPageCount+"ҳ&nbsp;&nbsp;��ǰҳ:"+intPage+"&nbsp;&nbsp;");
			if (intPage==1)
				out.println("��ҳ&nbsp;��һҳ&nbsp;");
			else
			{
				%>
				<a href=hrmdssfind.jsp?page="1">��ҳ</a>
				<a href=hrmdssfind.jsp?page=<%=intPage-1%>>��һҳ</a>
				<%
			}
			
			if (intPage==intPageCount)
				out.println("βҳ&nbsp;��һҳ");
			else
			{
				%>
				<a href=hrmdssfind.jsp?page=<%=intPage+1%>>��һҳ</a>
				<a href=hrmdssfind.jsp?page=<%=intPageCount%>&selecttable=<%=selecttable%>&listfield=<%=selectfield%>&term=<%=selectterm%>&fieldvalue=<%=selectvalue%>&textfield=<%=enter%>>βҳ</a>
				<!--<a href=hrmdssfind.jsp?page=<%=intPageCount%>>βҳ</a>-->
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
				int count=0;//������
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
					count++;
				}
				%></table><%
				Date now1 =new Date();
				%>
				<!--���ҵ���<%= Integer.toString(count)%>�����ݡ�<br>-->
				��ѯ����ʱ�䣺<%= DateFormat.getTimeInstance().format(now1)%>
				<%
				ODB.destroy();
				ODBS.destroy();
				ODBcount.destroy();
			}
			catch (Exception e)
			{
				%>
				<div align="center">����������ݷǷ���</div>
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