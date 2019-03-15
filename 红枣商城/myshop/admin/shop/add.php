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
			<p>价格：</p>
			<p><input type="text" name="price"></p>
			<p>库存：</p>
			<p><input type="text" name="stock"></p>
            <p>等级：</p>
            <p><input type="text" name="grade"></p>
            <p>原产地：</p>
            <p><input type="text" name="origin"></p>
            <p>描述：</p>
            <p><textarea rows="6" cols="60" name="des"></textarea></p>

			<p>图片：</p>
			<p><input type="file" name="img"></p>
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>
