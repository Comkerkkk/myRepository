<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$username=$_POST['username'];
	$password=$_POST['password'];
    $credit=$_POST['credit'];
	$id=$_POST['id'];
    $sql="update user set userName='{$username}',pwd='{$password}',credit='{$credit}' where id='{$id}'";
	if(mysqli_query($con,$sql)){
		echo '<script>location="index.php"</script>';
	}
?>
