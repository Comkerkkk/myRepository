<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$name=$_GET['name'];
$tel=$_GET['tel'];
$addr=$_GET['addr'];
$user_id=$_GET['user_id'];

$sql="insert into touch(name,tel,addr,user_id) values('{$name}','{$tel}','{$addr}','{$user_id}')";

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
