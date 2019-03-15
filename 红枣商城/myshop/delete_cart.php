<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$shop_id=$_GET['shop_id'];
$user_id=$_GET['user_id'];

$sql="delete from cart where shop_id='$shop_id' and user_id='$user_id'";
$res=mysqli_query($conn,$sql);
if($res){
    $result=array();
    $result['code']=1;
    $result['des']="success";
    echo json_encode($result);
    
}else{
    $result=array();
    $result['code']=-1;
    $result['des']="error";
    echo json_encode($result);
}
?>
