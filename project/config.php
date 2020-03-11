<?php 
$conn = mysqli_connect("localhost","DESKTOP-TRH688L\Sun Yetong", "", "UserDetails");
 
if(!$conn){
	die("Connection error: " . mysqli_connect_error());	
}
?>