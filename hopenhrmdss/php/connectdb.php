<?php 
/*
//����MYSQL���ݿ�
$server="zhaoyong";
$user="root";
$pass="";
$dbn="yanchangxu";
$db_cnd=mysql_connect($server,$user,$pass);//�������ݿ������,
if (mysql_error())
{
	echo "���ݿ�����ʧ�ܡ�<br>";
}
else
{
	$db_sel=mysql_select_db($dbn);//ѡ�����ݿ�
}*/
//����SQL SERVER2000���ݿ�
$sqlserver_link=mssql_connect("ao_database","hrmdss","hrmdss");
mssql_select_db("hrmdss");

?>