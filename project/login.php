<?php 
require_once("config.php");
if(isset($_POST['submit'])){
	$userName = trim($_POST['userName']);
	$password = trim($_POST['password']);
	
    $sql = "select * from Users where userName = '".$userName."'";
	$rs = mysqli_query($conn,$sql);
	$numRows = mysqli_num_rows($rs);
	
	if($numRows  == 1){
		$row = mysqli_fetch_assoc($rs);
		if(password_verify($password,$row['password'])){
			echo "Password verified";
		}
		else{
			echo "Wrong Password";
		}
	}
	else{
		echo "No User found";
	}
}