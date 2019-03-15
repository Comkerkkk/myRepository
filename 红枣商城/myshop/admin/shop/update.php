<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$name=$_POST['name'];
	$price=$_POST['price'];
	$stock=$_POST['stock'];
    $des=$_POST['des'];
    $grade=$_POST['grade'];
    $origin=$_POST['origin'];
	$id=$_POST['id'];
	$imgsrc=$_POST['imgsrc'];

	
	$imgerror=$_FILES['img']['error'];
	if($imgerror==0){
		//上传图片
		if($_FILES['img']['type']!='image/jpeg'&&$_FILES['img']['type']!='image/jpg'&&$_FILES['img']['type']!='image/png'&&$_FILES['img']['type']!='image/gif'){
			exit('请上传图片类型文件');
		}
		$tempName=$_FILES['img']['tmp_name'];
		$imgName=$_FILES['img']['name'];
		$dst='../../images/'.$imgName;
		if(move_uploaded_file($tempName,$dst)){
			$oldfile="../../images/{$imgsrc}";
			unlink($oldfile);

			$img='/Applications/XAMPP/xamppfiles/htdocs/myshop/images/'.$imgName;
            $sql="update shop set shopName='{$name}',price='{$price}',stock='{$stock}',image='{$img}',des='{$des}',grade='{$grade}',origin='{$origin}' where id='{$id}'";
			if(mysqli_query($con,$sql)){
				echo '<script>location="index.php"</script>';
			}

		}
	}
	else{
			$sql="update shop set shopName='{$name}',price='{$price}',stock='{$stock}',des='{$des}',grade='{$grade}',origin='{$origin}' where id='{$id}'";
			if(mysqli_query($con,$sql)){
				echo '<script>location="index.php"</script>';
			}
		}
?>
