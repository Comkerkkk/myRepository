<?php
session_start();
if(!$_SESSION['admin_userid']){
	echo "<script>location='/myshop/admin/login.php'</script>";
	exit;
}

?>