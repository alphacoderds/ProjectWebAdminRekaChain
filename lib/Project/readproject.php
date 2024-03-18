<?php
header("Access-Control-Allow-Origin: *");
// $conn=new mysqli("localhost","root","","db_rekachain");
// $query=mysqli_query($conn,"select * from tbl_project");
// $data=mysqli_fetch_all($query,MYSQLI_ASSOC);
// echo json_encode($data);

// Membuat koneksi ke database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Memeriksa koneksi
if ($conn->connect_error) {
    die(json_encode(['pesan' => 'Gagal terhubung ke database: ' . $conn->connect_error]));
}

// Melakukan query untuk mengambil data
$query = mysqli_query($conn, "SELECT * FROM tbl_project");

// Memeriksa apakah query berhasil dieksekusi
if (!$query) {
    die(json_encode(['pesan' => 'Gagal mengambil data: ' . mysqli_error($conn)]));
}

// Mengambil semua data dan mengonversinya ke format JSON
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);

// Mengembalikan data dalam format JSON
echo json_encode($data);

?>