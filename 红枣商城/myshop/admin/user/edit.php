<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$id=$_GET['id'];
	$sql="select * from user where id={$id}";
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
			<p>用户名：</p>
			<p><input type="text" name="username" value='<?php echo $row['userName']; ?>'></p>
			<p>密码：</p>
            <p><input type="password" name="password" value='<?php echo $row['pwd']; ?>'></p>
            <p>积分：</p>
            <p><input type="text" name="credit" value='<?php echo $row['credit']; ?>'></p>
			<input type="hidden" name="id" value="<?php echo $row['id']; ?>">
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>
