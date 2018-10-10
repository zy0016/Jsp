<?php require("connectdb.php"); ?>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body>
<?php 
/*	$sql="select * from users";
	$result=mysql_query($sql);
	//$result=mysql_db_query($dbn,$sql);
	while($row=mysql_fetch_array($result))
	{
		echo $row["username"];
		echo " ";
		echo $row["password"];
		echo "<br>";
	}
	mysql_free_result($result);
	//$sql="delete from users where username='12'";
	//$insert=mysql_query($sql,$db_cnd);
	//mysql_close(db_cnd);
*/
$sql="select A0101 from A01";
$result=mssql_query($sql);
while ($row=mssql_fetch_array($result))
{
	echo "姓名:".$row["A0101"]."<br>";
}
mssql_free_result($result);
?>
</body>
</html>
