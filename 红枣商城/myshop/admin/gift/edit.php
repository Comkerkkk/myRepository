<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$id=$_GET['id'];
	$sqlShop="select * from gift where id={$id}";
	$rstShop=mysqli_query($con,$sqlShop);
	$rowShop=mysqli_fetch_assoc($rstShop);
    $image=basename($rowShop['image']);
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
		<form action="update.php" method="post" enctype='multipart/form-data'>
			<p>商品名：</p>
			<p><input type="text" name="name" value='<?php echo $rowShop['giftName'];?>'></p>
			<p>积分：</p>
			<p><input type="text" name="credit" value='<?php echo $rowShop['credit'];?>'></p>
			<p>库存：</p>
			<p><input type="text" name="stock" value='<?php echo $rowShop['st'];?>'></p>
			<p>图片：</p>
			<p><img src="../../images/<?php echo $image;?>" width='100px'></p>
			<input type="hidden" name="id" value="<?php echo $rowShop['id'];?>">
			<input type="hidden" name="imgsrc" value="<?php echo $image;?>">

			<p><input type="file" name="img"></p>
			<p><input type="submit" value="确定"></p>
		</form>
	</div>
</body>
</html>
