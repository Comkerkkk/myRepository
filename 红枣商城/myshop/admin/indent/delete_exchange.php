<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$id=$_GET['id'];
	$sql="delete from exchange where id='{$id}'";
	if(mysqli_query($con,$sql)){
		echo '<script>location="record_index.php"</script>';
}
?>
