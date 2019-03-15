<?php
	include '../lock.php';
	include '../../public/common/config.php';
	include '../../public/common/deal.php';
	$name=$_POST['name'];
	$credit=$_POST['credit'];
	$stock=$_POST['stock'];
	

	//上传图片
	if($_FILES['img']['type']!='image/jpeg'&&$_FILES['img']['type']!='image/jpg'&&$_FILES['img']['type']!='image/png'&&$_FILES['img']['type']!='image/gif'){
		exit('请上传图片类型文件');
	}
	$tempName=$_FILES['img']['tmp_name'];
	$imgName=$_FILES['img']['name'];
	$dst='../../images/'.$imgName;
	if(move_uploaded_file($tempName,$dst)){

		$img='/Applications/XAMPP/xamppfiles/htdocs/myshop/images/'.$imgName;
	}

	

    $sql="insert into gift(giftName,credit,st,image) values('{$name}','{$credit}','{$stock}','{$img}')";
	if(mysqli_query($con,$sql)){
		echo '<script>location="index.php"</script>';
	}
	else print(mysqli_error($con));
?>
