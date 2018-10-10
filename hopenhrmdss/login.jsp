<%@ page contentType="text/html;charset=gb2312"%>

<html>
<head>
<title>人力资源查询系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="hrmdss.css" rel="stylesheet" type="text/css">
<style>
.cMenu{position: absolute;visibility:hidden;color:#000000;
width:150px;border:1px solid #000000;background-color:#999999;
font-family:"Verdana, Arial, Helvetica, sans-serif";
font-size:14px;font-weight:normal;line-height:20px;
cursor:default;} 
.menuitems{padding-left:5px;padding-right:5px;}
</style>

<SCRIPT LANGUAGE="JavaScript">
function showmenuie5(){
var rightedge=document.body.clientWidth-event.clientX
var bottomedge=document.body.clientHeight-event.clientY
if (rightedge<ie5menu.offsetWidth)
ie5menu.style.left=document.body.scrollLeft+event.clientX-ie5menu.offsetWidth
else
ie5menu.style.left=document.body.scrollLeft+event.clientX
if (bottomedge<ie5menu.offsetHeight)
ie5menu.style.top=document.body.scrollTop+event.clientY-ie5menu.offsetHeight
else
ie5menu.style.top=document.body.scrollTop+event.clientY
ie5menu.style.visibility="visible"
return false
}
function hidemenuie5(){
ie5menu.style.visibility="hidden"
}
function highlightie5(){
if (event.srcElement.className=="menuitems"){
event.srcElement.style.backgroundColor="highlight"
event.srcElement.style.color="white"
}
}
function lowlightie5(){
if (event.srcElement.className=="menuitems"){
event.srcElement.style.backgroundColor=""
event.srcElement.style.color="black"
}
} 
function jumptoie5(){
if (event.srcElement.className=="menuitems"){
if (event.srcElement.url != ''){
if (event.srcElement.getAttribute("target")!=null)
window.open(event.srcElement.url,event.srcElement.getAttribute("target"))
else
window.location=event.srcElement.url
}
}
}
</SCRIPT>

</head>


<script language="JavaScript" type="text/JavaScript">
function verity()
{
	if (login.username.value=="")
	//if (login.username.length==0)
	{
		alert("请输入用户名。");
		login.username.focus();
		return false;
		}
	else if(login.password.value=="")
	{
		alert("请输入密码。");
		login.password.focus();
		return false;
	}
	else if(login.username.value.indexOf("'")>=0)
	{
		alert("请不要输入单引号。");
		login.username.focus();
		return false;
	}
	else if(login.password.value.indexOf("'")>=0)
	{
		alert("请不要输入单引号。");
		login.password.focus();
		return false;
	}
	else
		return true;
}
</script>

<body>
<RightClick>
<!--[if IE]>
<div id="ie5menu" class="cMenu" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="#top">右键菜单很棒吧？</div>
<div class="menuitems" url="http://www.dreamweaver.com/" target="_blank">索易</div>
<div class="menuitems" url="http://www.thepoints.com" target="_blank">
点金网</div>
<HR>
<div class="menuitems" url="mailto:pauls@soim.com?subject=mweb">
阿泡设计</div></div>
<![endif]-->
<script language="JavaScript">

if (document.all&&window.print){
ie5menu.className="cMenu"
document.oncontextmenu=showmenuie5
document.body.onclick=hidemenuie5
}

</script>
</RightClick>

<form action="logins.jsp" method="post" name="login" id="login">
  <table width="981" height="89" border="0">
    <tr> 
      <td width="486" height="30"> 
        <div align="right">用户名：</div></td>
      <td width="487"><input name="username" type="text" id="username" size="20" align="left"></td>
    </tr>
    <tr> 
      <td height="28"> <div align="center"> 
          <p> 　　　　　　　　　　　　　　　　　　　　　　　　　　 密码：</p>
        </div></td>
      <td height="28"><input name="password" type="password" id="password2" size="20" align="left">
      </td>
    </tr>
    <tr> 
      <td height="17">　　　　　　　　　　　　　　　　　　　　　　　　 　
<input name="Submit" type="submit" class="username" onClick="return verity()" value="确定" align="right"></td>
      <td height="17"><input type="reset" name="Submit2" value="重新填写"></td>
    </tr>
  </table>
</form>
</body>
</html>