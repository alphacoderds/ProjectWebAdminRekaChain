<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect("localhost", "root", "", "db_rekachain");

$id_lot = $_GET['id_lot'];

$sql = $conn->query("select * from tbl_lot where id_lot = '$id_lot'");
$data = $sql->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>