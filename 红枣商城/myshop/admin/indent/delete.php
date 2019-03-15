<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$id=$_GET['id'];
	$sql="delete from indent where id='{$id}'";
	if(mysqli_query($con,$sql)){
		echo '<script>location="index.php"</script>';
}
?>
