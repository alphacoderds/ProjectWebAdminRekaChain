<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Koneksi ke database
$conn = new mysqli("localhost", "id22313015_rekachain", "49Nc-YpTT-gxNAu", "id22313015_db_rekachain");

// Periksa koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Eksekusi kueri untuk mengambil data tambahan staf
$result = $conn->query("SELECT * FROM tbl_tambahstaff");

// Persiapkan array untuk menyimpan data
$data = array();

// Periksa hasil kueri
if ($result->num_rows > 0) { 
    // Ambil setiap baris hasil dan tambahkan ke dalam array data
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    // Kembalikan data dalam format JSON
    echo json_encode($data);
} else {
    echo "0 results"; 
}

// Tutup koneksi
$conn->close();
?>
