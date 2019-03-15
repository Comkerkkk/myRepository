<?php
	include 'lock.php';
	session_start();
	include '../public/common/config.php';
	$password=$_POST['password'];
	$sql="update user set pwd='{$password}' where userName='admin'";
	if(mysqli_query($con,$sql)){
		$_SESSION=array();
		session_destroy();
		setcookie('PHPSESSID','',time()-3600,'/');
		echo '<script>top.location="login.php"</script>';
	}
?>
