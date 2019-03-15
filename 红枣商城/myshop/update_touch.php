<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$id=$_GET['id'];

$addr=$_GET['addr'];
$tel=$_GET['tel'];
$name=$_GET['name'];
$sql="update touch set addr='$addr', tel='$tel',name='$name' where id='$id'";
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
