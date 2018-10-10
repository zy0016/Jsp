<%@ page contentType="text/html;charset=gb2312"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	
<HEAD>
		
<title>Detail</title>
		
<meta name="vs_defaultClientScript" content="JavaScript">
		
<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		
<style type="text/css">
 .input1 {border-left: 1px solid rgb(240,243,253); border-right: 1px solid rgb(240,243,253); border-top: 1px solid rgb(240,243,253); border-bottom:1px solid rgb(0.0,255); font-family: "Courier", "Arial"; font-size: 9pt; background:#F0F3FD; font-weight: normal} 
.b1 {
	text-decoration: underline;
	border: solid;
}
</style>
 
	
</HEAD>
	
	<body MS_POSITIONING="GridLayout">
	<%
	response.setHeader("Refresh","60");
	%>
	<script language="JavaScript">
	text = "北京凯思昊鹏软件工程技术有限公司";  //显示的文字
	color1 = "blue";  //文字的颜色
	color2 = "red";  //转换的颜色
	fontsize = "8";   //字体大小
	speed = 200;  //转换速度 (1000 = 1 秒)
	
	i = 0;
	if (navigator.appName == "Netscape") 
		{
			document.write("<layer id=a visibility=show></layer><br><br><br>");
		}
	else 
		{
			document.write("<div id=a></div>");
		}
	function changeCharColor()  
	{
		if (navigator.appName == "Netscape") 
		{
			document.a.document.write("<center><font face=arial size =" + fontsize + "><font color=" + color1 + ">");
			for (var j = 0; j < text.length; j++) 
			{
				if(j == i) 
				{
				document.a.document.write("<font face=arial color=" + color2 + ">" + text.charAt(i) + "</font>");
				}
				else 
				{
				document.a.document.write(text.charAt(j));
				 }
			}
		document.a.document.write('</font></font></center>');
		document.a.document.close();
		}
		if (navigator.appName == "Microsoft Internet Explorer") 
		{
			str = "<center><font face=arial size=" + fontsize + "><font color=" + color1 + ">";
			for (var j = 0; j < text.length; j++) 
			{
				if( j == i) 
				{
					str += "<font face=arial color=" + color2 + ">" + text.charAt(i) + "</font>";
				}
				else 
				{
					str += text.charAt(j);
				}
			}
			str += "</font></font></center>";
			a.innerHTML = str;
		}
		(i == text.length) ? i=0 : i++;
	}
	setInterval("changeCharColor()", speed);
</script>
	<SCRIPT language=javascript>
		/*Phrase="索易网络杂志"	
		Balises=""
		Taille=80;
		Midx=250;
		Decal=0.5;
		Nb=Phrase.length;
		y=-10000;
		for (x=0;x<Nb;x++){
		  Balises=Balises + '<DIV Id=L' + x + ' STYLE="width:5;font-family: Courier New;font-weight:bold;position:absolute;top:3100;left:200;z-index:8">' + Phrase.charAt(x) + '</DIV>'
		}
		document.write (Balises);
		Time=window.setInterval("Alors()",10);
		Alpha=5;
		I_Alpha=0.05;
		function Alors(){
			Alpha=Alpha-I_Alpha;
			for (x=0;x<Nb;x++){
				Alpha1=Alpha+Decal*x;
				Cosine=Math.cos(Alpha1);
				Ob=document.all("L"+x);
				Ob.style.posLeft=Midx+170*Math.sin(Alpha1)+50;
				Ob.style.zIndex=20*Cosine;
				Ob.style.fontSize=Taille+25*Cosine;
				Ob.style.color="rgb("+ (127+Cosine*80+50) + ","+ (127+Cosine*80+50) + ",0)";
			}
		}*/
		</SCRIPT>
		<form id="Detail" method="post" runat="server">
  <FONT face="宋体"> 
  <TABLE width="100%" height="93" border="5" cellPadding="1" cellSpacing="1" bordercolor="#00FF00" id="Table1" style="WIDTH: 758px; HEIGHT: 97px">
    <TR> 
      <TD width="988" align="middle" style="HEIGHT: 35px">北京凯思昊鹏软件工程技术有限公司</TD>
    </TR>
    <TR> 
      <TD><%= new java.util.Date() %></TD>
    </TR>
  </TABLE>
  <script language="JavaScript1.2">
function flashit(){ 
if (!document.all) 
return 
if (Table1.style.borderColor=="yellow") 
Table1.style.borderColor="lime" 
else 
Table1.style.borderColor="yellow" 
} 
setInterval("flashit()", 500)
</script>
  <input type="text" name="textfield" class="input1">
  <br>
  <input type="text" name="text1" style="BORDER-BOTTOM:rgb(0,0,0);
			BORDER-LEFT:rgb(240,243,253);BORDER-RIGHT:rgb(240,243,253);
			BORDER-TOP:rgb(240,243,253);border:1px dashed rgb(0,0,0);
			font-size:9pt" size="12">
  <input NAME="view" TYPE="button" class="b1" OnClick="window.location=&quot;view-source:&quot;+window.location.href" VALUE="查看源代码">
  <input TYPE="button" VALUE="改变背景色" onClick="bgcolor()">
  　　 
  <script>function bgcolor(){if (document.bgColor=='#00ffff') 　　　
　　 {document.bgColor='#ffffff';} else{document.bgColor='#00ffff';} 
　　 }</script>
  <input TYPE="button" VALUE="返回上一步" ONCLICK="history.back(0)">
  <input type="button" name="Button" value="Button" onClick="location.href=('http://localhost:8080/test/login.jsp')">
  </FONT> 
</form>
	</body>
</HTML>
