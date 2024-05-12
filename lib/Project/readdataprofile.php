<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: *");
header("Access-Cross-Origin Resource Sharing");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
 
// Membuat koneksi ke database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Menjalankan query untuk mendapatkan semua data dari tabel tbl_tambahstaff
$query = "SELECT * FROM tbl_tambahstaff";
$result = $conn->query($query);

// Memeriksa apakah query berhasil dieksekusi
if ($result) {
    // Mengubah hasil query menjadi array asosiatif
    $data = $result->fetch_all(MYSQLI_ASSOC);
    
    // Mengkonversi data menjadi format JSON dan mencetaknya
    echo json_encode($data);
} else {
    // Jika query gagal dieksekusi, mencetak pesan error
    echo json_encode(["error" => "Failed to fetch data"]);
}

// Menutup koneksi ke database
$conn->close();
?>
