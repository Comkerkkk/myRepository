<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$title=$_POST['title'];
	$time=$_POST['time'];
    $content=$_POST['content'];
	$id=$_POST['id'];
    $sql="update news set title='{$title}',time='{$time}',content='{$content}' where id='{$id}'";
	if(mysqli_query($con,$sql)){
		echo '<script>location="index.php"</script>';
	}
?>
