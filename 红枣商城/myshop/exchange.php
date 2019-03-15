<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$gift_id=$_GET['gift_id'];
$user_id=$_GET['user_id'];
$touch_id=$_GET['touch_id'];
$credit=$_GET['credit'];
    
$sql1="update gift set st=st-1 where id='$gift_id'";
$sql2="insert into exchange(user_id,gift_id,touch_id,credit) values('$user_id','$gift_id','$touch_id','$credit')";
$sql3="update user set credit=credit-'$credit' where id='$user_id'";
    
$res1=mysqli_query($conn,$sql1);
$res2=mysqli_query($conn,$sql2);
$res3=mysqli_query($conn,$sql3);
if($res1&$res2&$res3){
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
