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
			<p>标题：</p>
			<p><input style="width=350px" type="text" name="title"></p>
			<p>时间：(年，月，日用“-”隔开)</p>
			<p><input type="text" name="time"></p>
            <p>内容：</p>
            <p><textarea name="content" cols="150" rows="25"></textarea></p>
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>
