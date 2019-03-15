<?php
    include 'lock.php';
?>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>right</title>
	<style type="text/css">
		*{
			font-family: 微软雅黑;
			text-decoration: none;
		}
		a{
			color:#55f;
		}
		h4{
			cursor: pointer;
			background:#888;
			text-align: center;
			border-radius: 5px;
			color:#55f;
		}
		h4:hover{
			color:#fff;
		}
		div{
			display: none;
		}
		p{
			padding-left: 15px;
		}
	</style>
	<script src="public/js/jquery.js"></script>
</head>
<body>
	<h4>用户管理</h4>
	<div>
		<p><a href="user/index.php" target="right">-查看用户</a></p>
		<p><a href="user/add.php" target="right">-添加用户</a></p>
	</div>
	<h4>商品管理</h4>
	<div>
		<p><a href="shop/index.php" target="right">-查看商品</a></p>
		<p><a href="shop/add.php" target="right">-添加商品</a></p>
	</div>
    <h4>礼品管理</h4>
    <div>
    <p><a href="gift/index.php" target="right">-查看礼品</a></p>
    <p><a href="gift/add.php" target="right">-添加礼品</a></p>
    </div>
    <h4>咨讯管理</h4>
    <div>
    <p><a href="news/index.php" target="right">-查看咨询</a></p>
    <p><a href="news/add.php" target="right">-添加咨询</a></p>
    </div>
	<h4>订单管理</h4>
	<div>
		<p><a href="indent/index.php" target="right">-查看订单</a></p>
        <p><a href="indent/record_index.php" target="right">-兑换记录</a></p>
	</div>
	<h4>系统管理</h4>
	<div>
		<p><a href="adminpass.php" target="_top">-修改口令</a></p>
		<p><a href="logout.php" target="_top">-退出系统</a></p>
	</div>
</body>
<script>
	$('h4').click(function(){
		$(this).next().toggle();
		$('div').not($(this).next()).hide();
	});
</script>
</html>
