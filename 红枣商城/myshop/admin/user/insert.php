<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$username=$_POST['username'];
	$password=$_POST['password'];
	$sql="insert into user(userName,pwd) values('{$username}','{$password}')";
	if(mysqli_query($con,$sql)){
		echo '<script>location="index.php"</script>';
	}
?>
