<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$id=$_GET['id'];
	$sql="select * from news where id={$id}";
	$rst=mysqli_query($con,$sql);
	$row=mysqli_fetch_assoc($rst);
?>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../public/css/index.css">
	<meta charset="utf-8">
	<title>修改信息</title>
</head>
<body>
	<div class="main">
		<form action="update.php" method="post">
			<p>标题：</p>
<p><input type="text" style="width:350px" name="title" value='<?php echo $row['title']; ?>'></p>
			<p>时间：</p>
            <p><input type="text" name="time" value='<?php echo $row['time']; ?>'></p>
            <p>内容：</p>
            <p><textarea rows="25" cols="150" name="content"><?php echo $row['content'];?></textarea></p>
			<input type="hidden" name="id" value="<?php echo $row['id']; ?>">
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>
