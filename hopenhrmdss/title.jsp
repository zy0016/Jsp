<%@ page contentType="text/html;charset=gb2312"%>
<%@ page language="java" %>
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.util.Date"%> 
<%@ page import="java.net.InetAddress"%> 
<%@ page import="java.net.UnknownHostException"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Title</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#e0e6a6" leftMargin="0" topMargin="0" MS_POSITIONING="GridLayout">
		<form id="Title" method="post" runat="server">
			<FONT face="����">
				<TABLE id="Title_Tb" style="WIDTH: 100%; HEIGHT: 70px; BACKGROUND-COLOR: #99cccc" cellSpacing="0" cellPadding="0" bgColor="#99cc99" border="0">
					
    <TR> 
      <td width="40%" rowspan="2" align="center" vAlign="middle" style="FONT-WEIGHT: bold; FONT-SIZE: x-large; COLOR: darkcyan; FONT-FAMILY: ������κ"> 
        <div align="center">������Դ��Ϣ��ѯϵͳ</div></td>
						
      <TD width="60%" align="right" vAlign="center" id="User_ID"><font size="2">
	  <jsp:useBean id="JJ" scope="page" class="JavaBean.JavaConst.JavaConst"/>
	  <jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
	  <jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
	  <%
	  	String regard="";
		String ip=request.getServerName();//��ñ���IP��ַ
		String file=request.getRequestURI();//��ñ��ļ�������
		file=CS.ReplaceString(file,"/","");
		String localhostpath=request.getRealPath(file);//��ñ��ļ��ľ���·���������ļ���
		localhostpath=CS.ReplaceString(localhostpath,file,"");//��ñ��ļ��ľ���·�����������ļ���,Ҳ����
		String PhotoPath=localhostpath+"photo";//��ñ��ļ��ľ���·��
		PhotoPath=CS.ReplaceString(PhotoPath,File.separator,File.separator+File.separator);//����photo�ļ���·��(��һ��"\"��Ϊ����"\\")
		/*int i=fold.indexOf("/");
		fold=fold.substring(0,i);//���Ŀ¼����

		String file=application.getRealPath(fold)+"\\"+"const.ini";//���ini�ļ�·��
		file=CS.ReplaceString(file,File.separator,File.separator+File.separator);//����ini�ļ���·��(��һ��"\"��Ϊ����"\\")

		BufferedReader fread=new BufferedReader(new FileReader(file));//���ļ�
		String hostname=fread.readLine();//��ñ�����
		String Path=fread.readLine();//���ͼ��·����
		fread.close();
		String ip=JJ.getHostIP(hostname);*/
		JCPATH.PATH=PhotoPath;
		
		//out.println(PhotoPath);
		if (Calendar.getInstance().get(Calendar.AM_PM)==Calendar.AM)
			regard="�����";
		else
			regard="�����";
	  %>
	  <a href="javascript:window.external.AddFavorite('http://<%= ip%>/login.jsp', '������Դ��ѯϵͳ')">��������ղؼ�</a>
	  <%= regard%>
	  ��ǰ��¼���ʺţ�<%= (String)session.getValue("username") %></font></TD>
					</TR>
					<tr>
						
      <TD vAlign="bottom" colSpan="2" align="right">
	<font color="#ffffff"><a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=1" target="contents">��Ա��Ϣ��ѯ </a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font>
	
	<font color="#ffffff">&nbsp;<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=2" target="contents">�ۺ���Ϣ��ѯ</a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font>

	<font color="#ffffff">&nbsp;<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=3" target="contents">��Ա�ṹ���� </a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font>
	
	<font color="#ffffff">&nbsp;<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=4" target="contents">������Ϣ��ѯ </a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font><font color="#ffffff">&nbsp;

	<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="login.jsp" target="_top">ע�� </a></font><font color="#ffffff">&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font><font color="#ffffff">&nbsp;
	
	<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="modifypassword.jsp" target="_top">�޸����� </a></font>&nbsp;&nbsp;
						</TD>
					</tr>
				</TABLE>
				</TD></TR></TABLE></FONT></form>
	</body>
</HTML>