<?php
function deal($filename,$width,$height){
	$arr=getimagesize($filename);
	switch ($arr['mime']) {
		case "image/png":
			$srcType='imagecreatefrompng';
			$outType='imagepng';
			break;
		case "image/gif":
			$srcType='imagecreatefromgif';
			$outType='imagegif';
			break;
		case "image/jpg":
		case "image/jpeg":
			$srcType='imagecreatefromjpeg';
			$outType='imagejpeg';
			break;
		
	}
	$src_img=$srcType($filename);
	$src_w=$arr[0];
	$src_h=$arr[1];
	$des_w=$width;
	$des_h=$height;
	$scale_w=$src_w/$des_w;
	$scale_h=$src_h/$des_h;
	if($src_w<=$des_w&&$src_h<=$des_h){
		$true_h=$src_h;
		$true_w=$src_w;
		$des_img=imagecreatetruecolor($true_w,$true_h);
	}
	elseif($scale_w>=$scale_h){
		$true_h=$src_h/$scale_w;
		$true_w=$src_w/$scale_w;
		$des_img=imagecreatetruecolor($true_w,$true_h);
	}
	else{
		$true_h=$src_h/$scale_h;
		$true_w=$src_w/$scale_h;
		$des_img=imagecreatetruecolor($true_w,$true_h);
	}
	imagecopyresized($des_img, $src_img, 0, 0, 0, 0, $true_w, $true_h, $src_w, $src_h);
	$temp=basename($filename);
	$newname='../../public/uploads/'.'deal_'.$temp;
	$outType($des_img,$newname);
}
?>