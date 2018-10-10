<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 

<html>
<head>
<title>人员结构分析</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
<jsp:useBean id="CC" scope="page" class="JavaBean.CreateChart.CreateChart"/>
<jsp:useBean id="JC" scope="page" class="JavaBean.JavaConst.JavaConst"/>
<jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
<body background="back0.jpg">

<%
String tablefield=request.getParameter("field");//获得进行哪一项分析
String table=CS.getleft_rightstr(tablefield,".",-1);//获得表名
String fieldname=CS.getleft_rightstr(tablefield,".",1);//获得字段名
String analyse="";
String dataitem="";
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
	String b1=request.getParameter("begin1");
	String e1=request.getParameter("end1");
	if ((b1.length()>0) && (e1.length()>0))
		dataitem=dataitem+b1+"-"+e1+JC.separator;

	String b2=request.getParameter("begin2");
	String e2=request.getParameter("end2");
	if ((b2.length()>0) && (e2.length()>0))
		dataitem=dataitem+b2+"-"+e2+JC.separator;
	
	String b3=request.getParameter("begin3");
	String e3=request.getParameter("end3");
	if ((b3.length()>0) && (e3.length()>0))
		dataitem=dataitem+b3+"-"+e3+JC.separator;
	
	String b4=request.getParameter("begin4");
	String e4=request.getParameter("end4");
	if ((b4.length()>0) && (e4.length()>0))
		dataitem=dataitem+b4+"-"+e4+JC.separator;
	
	String b5=request.getParameter("begin5");
	String e5=request.getParameter("end5");
	if ((b5.length()>0) && (e5.length()>0))
		dataitem=dataitem+b5+"-"+e5+JC.separator;

	String b6=request.getParameter("begin6");
	String e6=request.getParameter("end6");
	if ((b6.length()>0) && (e6.length()>0))
		dataitem=dataitem+b6+"-"+e6+JC.separator;

	String b7=request.getParameter("begin7");
	String e7=request.getParameter("end7");
	if ((b7.length()>0) && (e7.length()>0))
		dataitem=dataitem+b7+"-"+e7+JC.separator;

	String b8=request.getParameter("begin8");
	String e8=request.getParameter("end8");
	if ((b8.length()>0) && (e8.length()>0))
		dataitem=dataitem+b8+"-"+e8+JC.separator;

	String b9=request.getParameter("begin9");
	String e9=request.getParameter("end9");
	if ((b9.length()>0) && (e9.length()>0))
		dataitem=dataitem+b9+"-"+e9+JC.separator;

	String b10=request.getParameter("begin10");
	String e10=request.getParameter("end10");
	if ((b10.length()>0) && (e10.length()>0))
		dataitem=dataitem+b10+"-"+e10+JC.separator;

	dataitem=dataitem+"other";
	String fname=CC.CreateAnalyzePicture(JCPATH.PATH,analyse,tablefield,dataitem,year);
	%>
<%= analyse%>结果<br>
<input name="数据分析" type="image" title=<%= analyse%>结果 src=photo\<%= fname%> alt="图像生成失败" width="500" height="500" border="3">
<br>

</body>
</html>
