<?php
	include '../lock.php';
	include '../../public/common/config.php';
	$id=$_GET['touch_id'];
	$sql="select * from touch where id={$id}";
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
				<th>名字</th>
				<th>地址</th>
				<th>电话</th>
			</tr>
			<?php
				while($row=mysqli_fetch_assoc($rst)){
					echo "<tr>";
					echo "<td>{$row['name']}</td>";
					echo "<td>{$row['addr']}</td>";
					echo "<td>{$row['tel']}</td>";
					echo "</tr>";
				}
			?>
		</table>
	</div>
</body>
</html>
