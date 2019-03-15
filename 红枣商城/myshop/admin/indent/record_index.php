<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$sql="select exchange.*,userName,giftName from exchange,user,gift where user.id=user_id and exchange.gift_id=gift.id";
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
                <th>礼品</th>
                <th>总计</th>
				<th>删除</th>
			</tr>
			<?php
				while($row=mysqli_fetch_assoc($rst)){
					echo "<tr>";
					echo "<td>{$row['userName']}</td>";
                    echo "<td><a href='touch.php?touch_id={$row['touch_id']}'>联系方式</a></td>";
                    echo "<td>{$row['giftName']}</td>";
                    echo "<td>{$row['credit']}积分</td>";
					echo "<td><a href='delete_exchange.php?id={$row['id']}'>删除</a></td>";
					echo "</tr>";
				}
			?>
		</table>
	</div>
</body>
</html>
