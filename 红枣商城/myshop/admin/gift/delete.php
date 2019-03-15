<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$id=$_GET['id'];
	$img=$_GET['img'];
	$file="../../images/$img";
	$sql="delete from gift where id={$id}";
	if(mysqli_query($con,$sql)){
		unlink($file);
		echo '<script>location="index.php"</script>';
}
?>
