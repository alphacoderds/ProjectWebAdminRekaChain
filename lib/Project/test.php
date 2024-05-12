<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Koneksi ke database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Periksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$nip = $_POST["nip"];
$password = $_POST["password"];
// Eksekusi kueri untuk mengambil data tambahan staf
$result = $conn->query("SELECT * FROM `tbl_tambahstaff` WHERE tbl_tambahstaff.nip = '$nip' AND tbl_tambahstaff.password= SHA1('$password')");

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
