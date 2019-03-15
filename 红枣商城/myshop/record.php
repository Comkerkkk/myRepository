<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$user_id=$_GET['user_id'];

$sql="SELECT exchange.id,exchange.user_id,exchange.gift_id,exchange.touch_id,gift.giftName,gift.image,gift.credit,touch.addr,touch.tel,touch.name FROM exchange LEFT JOIN gift ON exchange.gift_id=gift.id LEFT JOIN touch ON exchange.touch_id=touch.id WHERE exchange.user_id='$user_id'";
$res=mysqli_query($conn,$sql);
if(mysqli_num_rows($res)){
	$result=array();
	$result['code']=1;
	$result['des']="success";
	$result['list']=array();
	while ($row=mysqli_fetch_assoc($res)) {
		$list=array();
		foreach ($row as $key => $value) {
			$list[$key]=$value;
		}
		array_push($result['list'], $list);
	}
	echo json_encode($result);

}else{
	$result=array();
	$result['code']=-1;
	$result['des']="error";
	echo json_encode($result);
}

?>
