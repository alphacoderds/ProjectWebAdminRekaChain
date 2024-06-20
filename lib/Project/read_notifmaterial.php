<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$kodeLot = $_GET['kodeLot'];

$sql = $conn->query("SELECT tbl_material.*, tbl_tambahstaff.nama 
FROM tbl_material 
JOIN tbl_tambahstaff ON tbl_material.nip = tbl_tambahstaff.nip 
WHERE tbl_material.kodeLot = '$kodeLot'");
$data = $sql->fetch_all(MYSQLI_ASSOC);

echo json_encode($data);
?>