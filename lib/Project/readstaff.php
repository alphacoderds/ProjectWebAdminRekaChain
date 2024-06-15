<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","id22313015_rekachain","49Nc-YpTT-gxNAu","id22313015_db_rekachain");
$query=mysqli_query($conn,"select * from tbl_tambahstaff");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>