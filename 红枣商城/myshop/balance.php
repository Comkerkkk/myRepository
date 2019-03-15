<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$shop_id=$_GET['shop_id'];
$user_id=$_GET['user_id'];
$num=$_GET['num'];
$touch_id=$_GET['touch_id'];
$price=$_GET['price'];
$cart_id=$_GET['cart_id'];
    
$sql1="delete from cart where shop_id='$shop_id' and user_id='$user_id'";
$sql2="update shop set stock=stock-'$num' where id='$shop_id'";
$sql3="insert into indent(user_id,shop_id,touch_id,price,num) values('$user_id','$shop_id','$touch_id','$price','$num')";
$sql4="update user set money=money-'$price' where id='$user_id'";
if($cart_id){
    $res1=mysqli_query($conn,$sql1);
    $res2=mysqli_query($conn,$sql2);
    $res3=mysqli_query($conn,$sql3);
    $res4=mysqli_query($conn,$sql4);
    if($res1&$res2&$res3&$res4){
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
}else{
    $res2=mysqli_query($conn,$sql2);
    $res3=mysqli_query($conn,$sql3);
    $res4=mysqli_query($conn,$sql4);
    if($res2&$res3&$res4){
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
}
?>
