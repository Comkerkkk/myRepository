<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$sql="select * from shop";
	$rst=mysqli_query($con,$sql);
?>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../public/css/index.css">
	<meta charset="utf-8">
	<title>index</title>
</head>
<body>
	<div class="main">
		<table width="90%" border="1px" cellspacing="0">
			<tr>
				<th>编号</th>
				<th>名称</th>
				<th>图片</th>
				<th>价格</th>
				<th>库存</th>
                <th>等级</th>
                <th>原产地</th>
                <th>商品描述</th>
				<th>修改</th>
				<th>删除</th>
			</tr>
			<?php
				while($row=mysqli_fetch_assoc($rst)){
                    $image=basename($row['image']);
					echo "<tr>";
					echo "<td>{$row['id']}</td>";
					echo "<td>{$row['shopName']}</td>";
                    echo "<td><img src='../../images/{$image}' width='100px'></td>";
					echo "<td>{$row['price']}</td>";
					echo "<td>{$row['stock']}</td>";
                    echo "<td>{$row['grade']}</td>";
                    echo "<td>{$row['origin']}</td>";
                    echo "<td>{$row['des']}</td>";
					echo "<td><a href='edit.php?id={$row['id']}'>修改</a></td>";
					echo "<td><a href='delete.php?id={$row['id']}&img={$image}'>删除</a></td>";
					echo "</tr>";
				}
			?>
		</table>
	</div>
</body>
</html>
