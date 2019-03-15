<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$username=$_GET['username'];
$pwd=$_GET['pwd'];

$search_sql="select * from user where userName='$username'";
$search_res=mysqli_query($conn,$search_sql);
if(mysqli_num_rows($search_res)){
	$result=array();
	$result['code']=-2;
	$result['des']="existed";
	echo json_encode($result);
	exit();

}
$sql="insert into user(userName,pwd) values('{$username}','{$pwd}')";

if($res=mysqli_query($conn,$sql)){
	$result=array();
	$result['code']=1;
	$result['des']="success";
	echo json_encode($result);

}else{
	$result=array();
	$result['code']=-1;
	$result['des']="error";
	echo json_encode($result);
}

?>
