<?php
// Mengaktifkan error reporting untuk debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Menangani permintaan OPTIONS (preflight)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    exit(0);
}
header("Access-Control-Allow-Origin:");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Cross-Origin Resource Sharing");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Content-Type: application/json");

// Membuat koneksi ke database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Memeriksa koneksi
if ($conn->connect_error) {
    die(json_encode(array('error' => 'Database connection failed')));
}

// Mendapatkan NIP dari permintaan GET dan melakukan sanitasi
$nip = $_POST["nip"];

if (empty($nip)) {
    die(json_encode(array('error' => 'NIP is required')));
}

// Menjalankan query untuk mendapatkan data profil pengguna berdasarkan NIP
$sql = "SELECT * FROM tbl_tambahstaff WHERE nip = '$nip'";
$result = $conn->query($sql);
// Persiapkan array untuk menyimpan data
$data = array();

// Periksa hasil kueri
if ($result->num_rows > 0) { 
    // Ambil setiap baris hasil dan tambahkan ke dalam array data
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    // Kembalikan data dalam format JSON
    echo json_encode($data[0]);
} else {
    http_response_code(404);
    echo json_encode(["message" => "user tidak ditemukan"]); 
}

// Tutup koneksi
$conn->close();
?>