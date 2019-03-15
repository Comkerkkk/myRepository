<?php
	include '../lock.php';
?>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../public/css/index.css">
	<meta charset="utf-8">
	<title>添加商品</title>
</head>
<body>
	<div class="main">
		<form action="insert.php" method="post" enctype='multipart/form-data'>
			<p>商品名：</p>
			<p><input type="text" name="name"></p>
			<p>积分：</p>
			<p><input type="text" name="credit"></p>
			<p>库存：</p>
			<p><input type="text" name="stock"></p>

			<p>图片：</p>
			<p><input type="file" name="img"></p>
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>
