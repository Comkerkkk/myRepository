<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$shop_id=$_GET['shop_id'];
$user_id=$_GET['user_id'];
$sql="insert into cart(shopName,image,price,shop_id,stock,user_id) select shopName,image,price,id,stock,'$user_id' from shop where id='$shop_id'";
$res1=mysqli_query($conn,"select * from cart where user_id='$user_id' and shop_id='$shop_id'");
    if(!mysqli_num_rows($res1)){
        if($res=mysqli_query($conn,$sql)){
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
        $result=array();
        $result['code']=0;
        $result['des']="exit";
        echo json_encode($result);
    }


?>
