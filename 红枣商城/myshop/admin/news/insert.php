<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$title=$_POST['title'];
	$time=$_POST['time'];
    $content=$_POST['content'];
	$sql="insert into news(title,time,content) values('{$title}','{$time}','{$content}')";
	if(mysqli_query($con,$sql)){
		echo '<script>location="index.php"</script>';
	}
?>
