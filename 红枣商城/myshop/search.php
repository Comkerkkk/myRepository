<?php
$conn=mysqli_connect("localhost","root","","myshop") or die("数据库连接失败！");

mysqli_set_charset($conn,"utf8") or die("数据库编码集设置失败！");
$name=$_GET['name'];
$sql="select * from shop where shopName like '%{$name}%'";
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
