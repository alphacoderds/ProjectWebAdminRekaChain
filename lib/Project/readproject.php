<?php
header("Access-Control-Allow-Origin: *");
// $conn=new mysqli("localhost","root","","db_rekachain");
// $query=mysqli_query($conn,"select * from tbl_project");
// $data=mysqli_fetch_all($query,MYSQLI_ASSOC);
// echo json_encode($data);

$conn = new mysqli("localhost", "root", "", "db_rekachain");

if ($conn->connect_error) {
    die(json_encode(['pesan' => 'Gagal terhubung ke database: ' . $conn->connect_error]));
}

$query = mysqli_query($conn, "SELECT * FROM tbl_tambahproject");

if (!$query) {
    die(json_encode(['pesan' => 'Gagal mengambil data: ' . mysqli_error($conn)]));
}

$data = mysqli_fetch_all($query, MYSQLI_ASSOC);

echo json_encode($data);
?>