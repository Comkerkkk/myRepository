<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$username=$_GET['username'];
$oldpwd=$_GET['oldpwd'];
$newpwd=$_GET['newpwd'];
$user_id=$_GET['user_id'];


$res1=mysqli_query($conn,"select * from user where id='$user_id' and userName='$username' and pwd='$oldpwd'");
if(mysqli_num_rows($res1)){
    $sql="update user set pwd='$newpwd'where id='$user_id'";
    $res=mysqli_query($conn,$sql);
    $res2=mysqli_query($conn,"select * from user where id='$user_id'");
	$result=array();
	$result['code']=1;
	$result['des']="success";
	$result['list']=array();
	while ($row=mysqli_fetch_assoc($res2)) {
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
