<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page info="database handler"%> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*"%> 
<%@ page import="javax.servlet.*"%> 
<%@ page import="javax.servlet.http.*"%> 
<%@ page errorPage="errorpage.jsp"%>
<HTML>
	<HEAD>
		<title>WebForm1</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<style TYPE="text/css"><!--
			A:link {text-decoration: none} A:visited {text-decoration:none}
			.c1 {	font-size: x-small;}
--></style>
<STYLE type=text/css>TABLE {
	FONT-SIZE: 9pt; COLOR: black; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"
}
.pt9 {
	FONT-SIZE: 9pt; COLOR: black; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"
}
.pt10 {
	FONT-WEIGHT: 700; FONT-SIZE: 10pt; LINE-HEIGHT: 18pt; FONT-FAMILY: "����"
}
.TempOutline {
	FONT-SIZE: 9pt; MARGIN-LEFT: 15pt; COLOR: #666666; TEXT-INDENT: -28pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.TempOutline1 {
	FONT-SIZE: 9pt; MARGIN-LEFT: 24pt; COLOR: #666666; TEXT-INDENT: -36pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.Outline {
	FONT-SIZE: 9pt; MARGIN-LEFT: 15pt; TEXT-INDENT: -28pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.Outline1 {
	FONT-SIZE: 9pt; MARGIN-LEFT: 24pt; TEXT-INDENT: -36pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.Outline11 {
	FONT-SIZE: 9pt; MARGIN-LEFT: 38pt; TEXT-INDENT: -50pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.passage0 {
	FONT-SIZE: 9pt; MARGIN-LEFT: 15pt; TEXT-INDENT: -28pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.passage1 {
	FONT-SIZE: 9pt; MARGIN-LEFT: 24pt; TEXT-INDENT: -36pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.passage11 {
	FONT-SIZE: 9pt; MARGIN-LEFT: 38pt; TEXT-INDENT: -50pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
.passage111 {
	FONT-SIZE: 9pt; MARGIN-LEFT: 51pt; TEXT-INDENT: -64pt; LINE-HEIGHT: 15pt; FONT-FAMILY: "����"; TEXT-DECORATION: none
}
</STYLE>
<SCRIPT language=JavaScript>
//�������ڿ����ı�����		
		function clickHandler()
		{
			var targetId;
			var srcElement = window.event.srcElement;
			var targetElement;
			 
			if (srcElement.className.substr(0,7) == "Outline")
			{
				targetId = srcElement.id.substr(0,12) + "details";
				targetElement = document.all(targetId);
				if (targetElement.style.display == "none") {
					targetElement.style.display = "";
				}
				else {
					targetElement.style.display = "none";
				}
				
				targetId = srcElement.id.substr(0,12) + "Image";
				targetElement = document.all(targetId);
				
				if (targetElement.src.indexOf("plus") >= 0) 
				{
					targetElement.src = "Image/minus.gif";
				}
				else 
				{
					targetElement.src = "Image/plus.gif";
				}

			}
		}
		  
		document.onclick = clickHandler;
</SCRIPT>
	</HEAD>
<%
java.sql.ResultSet sqlRst=null;
java.sql.ResultSet rs=null;
%>
<jsp:useBean id="ODB" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
<jsp:useBean id="ODB1" scope="page" class="JavaBean.OperateDataBase.OperateDataBase"/>
	<body bgColor="bisque" leftMargin="0" topMargin="0" MS_POSITIONING="GridLayout" marginwidth="0" marginheight="0" class="c1">
		<form id="Form1" method="post" target="_top">
			<FONT face="����">
				<% 
				String type="";
				int j=0;
				type=(String)session.getAttribute("queryid");
				if (type!=null)
				{
					int	i=Integer.parseInt(type);
					switch(i)
					{
					case 1:
							%>
							<!--<span onmouseover=this.innerText="���˰ɣ�" onmouseout=this.innerText="������������">������������</span><br>-->
							<%
							//out.println(request.getMethod());
							//out.println(request.getRequestURI());
							//out.println(request.getRemoteAddr());
							String sql="";
							sql="select * from B02 where B0215='1'";
							sqlRst=ODB.executeQuery(sql);
							
							String ch="";
							while (sqlRst.next())
							{
								String depart=sqlRst.getString("B0205");//��������
								String departcode=sqlRst.getString("B0210");//���Ŵ���
								if (j<10)
									ch="0"+Integer.toString(j);
								else
									ch=Integer.toString(j);
								j=j+1;
								out.println("<DIV class=Outline id=Out0100-00"+ch+"  onmouseover=\"this.style.color='red';this.style.cursor='hand'\"onmouseout=\"this.style.color='black'\"><IMG class=Outline id=Out0100-00"+ch+"Image style=\"CURSOR: hand\" src=\"image/plus.gif\" width=\"12\" height=\"12\">"+depart+"</DIV>");
								out.println("<DIV id=Out0100-00"+ch+"details style=\"DISPLAY: none\">");
								%>
								
								<%
								String str="select * from A01 where C0105='"+departcode+"'";
								rs=ODB1.executeQuery(str);
								while(rs.next())
								{
									String id=rs.getString("id");
									String name=rs.getString("A0101");
									out.println("<a href=IniBaseInfoPeople.jsp?id="+id+"&photo="+0+" target=main>&nbsp;&nbsp;&nbsp;&nbsp;"+name+"</a><br>");
									%>
									<!--<a href=IniBaseInfoPeople.jsp?id=<%= id%>&photo="0" target=main>&nbsp;&nbsp;&nbsp;&nbsp;<%= name%></a><br>
									-->
									<%
								}
								%>
								</DIV>
								<%
							}
 					break;
					case 2:
							%>
							<a href=hrmdssfind.jsp?queryid=2 target=main>�ۺ���Ϣ��ѯ</a>
							<%
					break;
					case 3:
							%>
							<a href=AnalyseChart.jsp?field=A01.A0107 target=main>��Ա�Ա�ṹ����</a><br>
							<a href=AnalyseChart.jsp?field=A04.A0405 target=main>ѧ���ṹ����</a><br>
							<a href=AnalyseChart.jsp?field=A04.A0440 target=main>ѧλ�ṹ����</a><br>
							<a href=AnalyseChart.jsp?field=A13.C1345 target=main>ְ�Ƶȼ�����</a><br>

							<a href=AnalyseChart.jsp?field=A01.A0141 target=main>�������޷���</a><br>
							<a href=AnalyseChart.jsp?field=A01.A0148 target=main>����˾�������޷���</a><br>
							<a href=AnalyseChart.jsp?field=A01.A0111 target=main>����ṹ����</a><br>
							<%
					break;
					case 4:	%>������Ϣ����<%
					break;
					case 5:
					break;					
					}
				}
				 %>
			</FONT>
		</form>
		<Script Language="JavaScript">
			//document.write(" �� �� �� �� �� ��" ��document.lastModified); 
			
		</script>
	</body>
</HTML>