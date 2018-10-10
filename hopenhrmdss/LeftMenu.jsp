<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>WebForm1</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<style type="text/css">.navPoint { FONT-SIZE: 12px; CURSOR: hand; COLOR: #ffffff; FONT-FAMILY: Webdings; POSITION: absolute }
		</style>
		<script language="javascript">
		function switchMenu(){
			if (parent.F_DyMain.cols=="176,*"){
				menuSwitch.innerHTML ="<font class=navPoint>4</font>"
				parent.F_DyMain.cols="14,*"
			}
			else{
				menuSwitch.innerHTML="<font class=navPoint>3</font>"
				parent.F_DyMain.cols="176,*"
			}
		}
		
		</script>
	</HEAD>
	<body leftMargin="0" topMargin="0">
	<% 
	String name="1";
	if (session.getAttribute("queryid")!=null)
		session.setAttribute("queryid",request.getParameter("queryid"));
	else
		session.setAttribute("queryid","1");		
	 %>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Tb_Menu" style="WIDTH: 100%; HEIGHT: 100%" cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<td><IFRAME id="forumList" style="VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%" name="forumList" src="navigation.jsp" frameBorder="0">
						</IFRAME>
					</td>
					<td bgColor="#000000"><IMG height="1" src="" width="1">
					<td>
					<td bgColor="#ffffff"><IMG height="1" src="" width="1">
					<td>
					<TD id="menuSwitch" style="WIDTH: 14px" onclick="switchMenu()" bgColor="#e0e6a6" height="100%"><font class="navPoint">3</font></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>