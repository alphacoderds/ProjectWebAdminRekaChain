<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$query=mysqli_query($conn,"select * from tbl_tambahproject");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>