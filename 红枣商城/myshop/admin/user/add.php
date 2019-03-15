<?php
	include '../lock.php';
?>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../public/css/index.css">
	<meta charset="utf-8">
	<title>添加用户</title>
</head>
<body>
	<div class="main">
		<form action="insert.php" method="post">
			<p>用户名：</p>
			<p><input type="text" name="username"></p>
			<p>密码：</p>
			<p><input type="password" name="password"></p>
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>