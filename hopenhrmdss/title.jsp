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
			<FONT face="宋体">
				<TABLE id="Title_Tb" style="WIDTH: 100%; HEIGHT: 70px; BACKGROUND-COLOR: #99cccc" cellSpacing="0" cellPadding="0" bgColor="#99cc99" border="0">
					
    <TR> 
      <td width="40%" rowspan="2" align="center" vAlign="middle" style="FONT-WEIGHT: bold; FONT-SIZE: x-large; COLOR: darkcyan; FONT-FAMILY: 华文新魏"> 
        <div align="center">人力资源信息查询系统</div></td>
						
      <TD width="60%" align="right" vAlign="center" id="User_ID"><font size="2">
	  <jsp:useBean id="JJ" scope="page" class="JavaBean.JavaConst.JavaConst"/>
	  <jsp:useBean id="CS" scope="page" class="JavaBean.ClassNormal.ClassNormal"/>
	  <jsp:useBean id="JCPATH" scope="application" class="JavaBean.JavaConst.JavaConst"/>
	  <%
	  	String regard="";
		String ip=request.getServerName();//获得本机IP地址
		String file=request.getRequestURI();//获得本文件的名字
		file=CS.ReplaceString(file,"/","");
		String localhostpath=request.getRealPath(file);//获得本文件的绝对路径，包括文件名
		localhostpath=CS.ReplaceString(localhostpath,file,"");//获得本文件的绝对路径，不包括文件名,也就是
		String PhotoPath=localhostpath+"photo";//获得本文件的绝对路径
		PhotoPath=CS.ReplaceString(PhotoPath,File.separator,File.separator+File.separator);//生成photo文件的路径(将一个"\"变为两个"\\")
		/*int i=fold.indexOf("/");
		fold=fold.substring(0,i);//获得目录名字

		String file=application.getRealPath(fold)+"\\"+"const.ini";//获得ini文件路径
		file=CS.ReplaceString(file,File.separator,File.separator+File.separator);//生成ini文件的路径(将一个"\"变为两个"\\")

		BufferedReader fread=new BufferedReader(new FileReader(file));//读文件
		String hostname=fread.readLine();//获得本机名
		String Path=fread.readLine();//获得图象路径名
		fread.close();
		String ip=JJ.getHostIP(hostname);*/
		JCPATH.PATH=PhotoPath;
		
		//out.println(PhotoPath);
		if (Calendar.getInstance().get(Calendar.AM_PM)==Calendar.AM)
			regard="上午好";
		else
			regard="下午好";
	  %>
	  <a href="javascript:window.external.AddFavorite('http://<%= ip%>/login.jsp', '人力资源查询系统')">点击加入收藏夹</a>
	  <%= regard%>
	  当前登录的帐号：<%= (String)session.getValue("username") %></font></TD>
					</TR>
					<tr>
						
      <TD vAlign="bottom" colSpan="2" align="right">
	<font color="#ffffff"><a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=1" target="contents">人员信息查询 </a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font>
	
	<font color="#ffffff">&nbsp;<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=2" target="contents">综合信息查询</a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font>

	<font color="#ffffff">&nbsp;<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=3" target="contents">人员结构分析 </a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font>
	
	<font color="#ffffff">&nbsp;<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="LeftMenu.jsp?queryid=4" target="contents">考核信息查询 </a></font>&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font><font color="#ffffff">&nbsp;

	<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="login.jsp" target="_top">注销 </a></font><font color="#ffffff">&nbsp;
	<font size="1" color="#ffffff"><b style="COLOR: #666699">|</b></font><font color="#ffffff">&nbsp;
	
	<a style="FONT-SIZE: x-small; COLOR: #666699; TEXT-DECORATION: none" href="modifypassword.jsp" target="_top">修改密码 </a></font>&nbsp;&nbsp;
						</TD>
					</tr>
				</TABLE>
				</TD></TR></TABLE></FONT></form>
	</body>
</HTML>