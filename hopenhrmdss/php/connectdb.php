<?php 
/*
//连接MYSQL数据库
$server="zhaoyong";
$user="root";
$pass="";
$dbn="yanchangxu";
$db_cnd=mysql_connect($server,$user,$pass);//连接数据库服务器,
if (mysql_error())
{
	echo "数据库连接失败。<br>";
}
else
{
	$db_sel=mysql_select_db($dbn);//选择数据库
}*/
//连接SQL SERVER2000数据库
$sqlserver_link=mssql_connect("ao_database","hrmdss","hrmdss");
mssql_select_db("hrmdss");

?>