<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$kodeLot = $_GET['kodeLot'];

$sql = $conn->query("select * from tbl_lot where kodeLot = '$kodeLot'");
$data = $sql->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>