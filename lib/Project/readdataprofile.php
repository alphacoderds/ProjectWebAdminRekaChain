<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: *");
header("Access-Cross-Origin Resource Sharing");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
 
// Membuat koneksi ke database
$conn = mysqli_connect("localhost", "root", "", "db_rekachain");

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$nip = $_GET['nip'];

// Menjalankan query untuk mendapatkan semua data dari tabel tbl_tambahstaff
$sql = $conn->query("SELECT * FROM tbl_tambahstaff WHERE nip = '$nip'");
$data = $sql->fetch_all(MYSQL_ASSOC);

echo json_encode($data);

// Menutup koneksi ke database
$conn->close();
?>
