<?php
	include 'lock.php';
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
			<p><input type="text" name="username" value='admin' disabled></p>
			<p>密码：</p>
			<p><input type="password" name="password"></p>
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>