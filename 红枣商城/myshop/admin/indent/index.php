<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$sql="select indent.*,userName,shopName from indent,user,shop where user.id=user_id and indent.shop_id=shop.id";
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
				<th>用户</th>
				<th>联系方式</th>
                <th>商品</th>
                <th>数量</th>
                <th>总计/元</th>
				<th>删除</th>
			</tr>
			<?php
				while($row=mysqli_fetch_assoc($rst)){
					echo "<tr>";
					echo "<td>{$row['userName']}</td>";
                    echo "<td><a href='touch.php?touch_id={$row['touch_id']}'>联系方式</a></td>";
                    echo "<td>{$row['shopName']}</td>";
                    echo "<td>{$row['num']}</td>";
                    echo "<td>{$row['price']}</td>";
					echo "<td><a href='delete.php?id={$row['id']}'>删除</a></td>";
					echo "</tr>";
				}
			?>
		</table>
	</div>
</body>
</html>
