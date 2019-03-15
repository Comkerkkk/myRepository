<?php
session_start();
include '../public/common/config.php';
$username=$_POST['username'];
$password=$_POST['password'];
$sql="select * from user where userName='{$username}' and pwd='{$password}' and isadmin=1";
$rst=mysqli_query($con,$sql);
$row=mysqli_fetch_assoc($rst);
if($row){
	$_SESSION['admin_username']=$username;
	$_SESSION['admin_userid']=$row['id'];
	echo "<script>location='index.php'</script>";
}
else{
	echo "<script>alert('用户名或密码错误！')</script>";
	echo "<script>location='login.php'</script>";
}
?>
