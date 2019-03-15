<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$sql="select * from user where isadmin='0'";
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
				<th>用户名</th>
                <th>积分</th>
				<th>修改</th>
				<th>删除</th>
			</tr>
			<?php
				while($row=mysqli_fetch_assoc($rst)){
					echo "<tr>";
					echo "<td>{$row['id']}</td>";
					echo "<td>{$row['userName']}</td>";
                    echo "<td>{$row['credit']}</td>";
					echo "<td><a href='edit.php?id={$row['id']}'>修改</a></td>";
					echo "<td><a href='delete.php?id={$row['id']}'>删除</a></td>";
					echo "</tr>";
				}
			?>
		</table>
	</div>
</body>
</html>
