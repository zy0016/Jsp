<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 

<html>
<head>
<title>人员结构分析</title>
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
			message="请不要输入单引号。";
			break;
		}
		else if (currentdata.indexOf(space)>=0)
		{
			message="请不要输入空格。";
			break;
		}
		if (i%2==1)
		{
			predata=document.form1.elements[i-1].value;
			if ((currentdata=="") && (predata!="")) 
			{
				message="请输入结尾的数据";
				break;			
			}
			else if ((currentdata!="") && (predata==""))
			{
				message="请输入开始的数据";
				i=i-1
				break;
			}
			if (isNaN(parseInt(predata,10)) && (predata!=""))
			{
				message="请输入零或正整数。";
				i=i-1
				break;
			}
			if (isNaN(parseInt(currentdata,10)) && (currentdata!=""))
			{
				message="请输入零或正整数。";
				break;
			}
			if ((currentdata!="") && (predata!=""))
			{
				if (currentdata==predata)
				{
					message="左边的数据不能等于右边的数据。";
					break;
				}
				if (currentdata.length==predata.length)
				{
					if (currentdata<predata)
					{
						message="左边的数据要小于右边的数据。";
						break;
					}
				}
				else if (predata.length>currentdata.length)
				{
					message="左边的数据要小于右边的数据。";
					break;
				}
			}
		}
	}
	if (allcount=="")
		message="请输入数据。";
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
String tablefield=request.getParameter("field");//获得进行哪一项分析
String table=CS.getleft_rightstr(tablefield,".",-1);//获得表名
String fieldname=CS.getleft_rightstr(tablefield,".",1);//获得字段名

String type="";
String analyse="";
type=ODB.executeQuery_String("select field_type from BasInfTFMenu where table_name='"+table+"' and field_name='"+fieldname+"'");
if (type.equals("varchar"))
{
	if (tablefield.equals("A01.A0107"))
		analyse="人员性别结构分析";
	else if (tablefield.equals("A04.A0405"))
		analyse="学历结构分析";
	else if (tablefield.equals("A04.A0440"))
		analyse="学位结构分析";
	else if (tablefield.equals("A13.C1345"))
		analyse="职称等级分析";

	//CC.CreateChart(tablefield);
	String fname=CC.CreateAnalyzePicture(JCPATH.PATH,analyse,tablefield);
	%>
	<!--<applet code="ChartApplet.class" name="chart" alt="Applet图像生成失败" width="500" height="500" id="chart" title="applet">
	  <param name="label" value=<%= analyse %>>
	  <param name="count" value=<jsp:getProperty name="CC" property="count" />>
	  <param name="showdata" value=<jsp:getProperty name="CC" property="showdata" />>
	  <param name="citem" value=<jsp:getProperty name="CC" property="citem" />>
	</applet>-->
	<%= analyse%><br>
	
<input type="image" title=<%= analyse%> src=photo\<%= fname%> alt="图像生成失败" width="500" height="500">
<br>
	<%
}
else
{
	String year="";
	if (tablefield.equals("A01.A0141"))//工作年限分析
	{
		analyse="工作年限分析";
		year="年";
	}
	else if (tablefield.equals("A01.A0148"))//本公司工作年限分析
	{
		analyse="本公司工作年限分析";
		year="年";
	}
	else if (tablefield.equals("A01.A0111"))//年龄结构分析
	{
		analyse="年龄结构分析";
		year="岁";
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
        <%= year%>&nbsp;到</td>
				<td width="94"><input name=end<%=i %> type="text" size="3" maxlength="2"><%= year%></td>
			</tr>
	<%
		}
	%>
	  <tr>
		<td><input name="analyse" type="submit" value="开始分析" onClick="return verify();"></td>
		<td><input name="reset" type="reset" value="重填"></td>
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
