<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 

<html>
<head>
<title>��Ա�ṹ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script language="JavaScript">
function verify()
{
	var message="",currentdata="",space=" ",allcount="",predata="";
	for (var i=0;i<=19;i++)
	{
		currentdata=document.form1.elements[i].value;
		allcount=allcount+currentdata;
		if (currentdata.indexOf("'")>=0)
		{
			message="�벻Ҫ���뵥���š�";
			break;
		}
		else if (currentdata.indexOf(space)>=0)
		{
			message="�벻Ҫ����ո�";
			break;
		}
		if (i%2==1)
		{
			predata=document.form1.elements[i-1].value;
			if ((currentdata=="") && (predata!="")) 
			{
				message="�������β������";
				break;			
			}
			else if ((currentdata!="") && (predata==""))
			{
				message="�����뿪ʼ������";
				i=i-1
				break;
			}
			if (isNaN(parseInt(predata,10)) && (predata!=""))
			{
				message="�����������������";
				i=i-1
				break;
			}
			if (isNaN(parseInt(currentdata,10)) && (currentdata!=""))
			{
				message="�����������������";
				break;
			}
			if ((currentdata!="") && (predata!=""))
			{
				if (currentdata==predata)
				{
					message="��ߵ����ݲ��ܵ����ұߵ����ݡ�";
					break;
				}
				if (currentdata.length==predata.length)
				{
					if (currentdata<predata)
					{
						message="��ߵ�����ҪС���ұߵ����ݡ�";
						break;
					}
				}
				else if (predata.length>currentdata.length)
				{
					message="��ߵ�����ҪС���ұߵ����ݡ�";
					break;
				}
			}
		}
	}
	if (allcount=="")
		message="���������ݡ�";
	if (message!="")
	{
		alert(message);
		document.form1.elements[i].focus();
		return false;
	}
	else
		return true;
}
</script>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<jsp:useBean id="CC" scope="page" class="JavaBean.CreateChart.CreateChart"/>
<jsp:useBean id="JC" scope="page" class="JavaBean.JavaConst.JavaConst"/>
<jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
<body background="back0.jpg">

<%
String tablefield=request.getParameter("field");//��ý�����һ�����
String table=CS.getleft_rightstr(tablefield,".",-1);//��ñ���
String fieldname=CS.getleft_rightstr(tablefield,".",1);//����ֶ���

String type="";
String analyse="";
type=ODB.executeQuery_String("select field_type from BasInfTFMenu where table_name='"+table+"' and field_name='"+fieldname+"'");
if (type.equals("varchar"))
{
	if (tablefield.equals("A01.A0107"))
		analyse="��Ա�Ա�ṹ����";
	else if (tablefield.equals("A04.A0405"))
		analyse="ѧ���ṹ����";
	else if (tablefield.equals("A04.A0440"))
		analyse="ѧλ�ṹ����";
	else if (tablefield.equals("A13.C1345"))
		analyse="ְ�Ƶȼ�����";

	//CC.CreateChart(tablefield);
	String fname=CC.CreateAnalyzePicture(JCPATH.PATH,analyse,tablefield);
	%>
	<!--<applet code="ChartApplet.class" name="chart" alt="Appletͼ������ʧ��" width="500" height="500" id="chart" title="applet">
	  <param name="label" value=<%= analyse %>>
	  <param name="count" value=<jsp:getProperty name="CC" property="count" />>
	  <param name="showdata" value=<jsp:getProperty name="CC" property="showdata" />>
	  <param name="citem" value=<jsp:getProperty name="CC" property="citem" />>
	</applet>-->
	<%= analyse%><br>
	
<input type="image" title=<%= analyse%> src=photo\<%= fname%> alt="ͼ������ʧ��" width="500" height="500">
<br>
	<%
}
else
{
	String year="";
	if (tablefield.equals("A01.A0141"))//�������޷���
	{
		analyse="�������޷���";
		year="��";
	}
	else if (tablefield.equals("A01.A0148"))//����˾�������޷���
	{
		analyse="����˾�������޷���";
		year="��";
	}
	else if (tablefield.equals("A01.A0111"))//����ṹ����
	{
		analyse="����ṹ����";
		year="��";
	}
	/*Enumeration enum=request.getParameterNames();
	while(enum.hasMoreElements())
	{
		String key=(String)enum.nextElement();
		String value=request.getParameter(key);
	}*/
	/*String analyze=request.getParameter("analyze");
	if (analyze.equals("1"))
	{
	}*/
	%>
	
<FORM name="form1" METHOD=POST action="AnalyseTime.jsp?field=<%= tablefield%>" target="_blank">
  <table width="200" border="0">
	<%
		for (int i=1;i<11;i++)	
		{
	%>
			<tr>
				<td width="96"><input name=begin<%=i %> type="text" size="3" maxlength="2">
        <%= year%>&nbsp;��</td>
				<td width="94"><input name=end<%=i %> type="text" size="3" maxlength="2"><%= year%></td>
			</tr>
	<%
		}
	%>
	  <tr>
		<td><input name="analyse" type="submit" value="��ʼ����" onClick="return verify();"></td>
		<td><input name="reset" type="reset" value="����"></td>
	  </tr>
	</table>
	</form>
	<%
}
%>

<!--<object id=object style="HEIGHT:500;WIDTH:500" classid="CLSID:369303C2-D7AC-11d0-89D5-00A0C90833E6">
  <param name="LINE1" value="SetLineColor(255,0,0)">
  <param name="LINE2" value="SetFillColor(0,255,0)">
  <param name="LINE3" value="SetLineStyle(1)">
  <param name="LINE4" value="Rect(100,100,300,300,0)">
</object>
-->

</body>
</html>
