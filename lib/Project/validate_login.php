<?php
// Set header agar response berupa JSON
header("Content-Type: application/json");

// Header untuk mengizinkan akses dari berbagai domain (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Cross-Origin Resource Sharing");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Origin: *");


// Cek metode request yang diterima
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Ambil data NIP yang dikirim melalui POST
    $nip = $_POST["nip"];

    // Koneksi ke database
    $conn = new mysqli("localhost", "root", "", "db_rekachain");

    // Periksa koneksi
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Query untuk mendapatkan role berdasarkan NIP
    $query = "SELECT role FROM tbl_tambahstaff WHERE nip = '$nip'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        // Jika data ditemukan, kirim role sebagai respons JSON
        $row = $result->fetch_assoc();
        $role = $row["role"];
        echo json_encode(array("status" => "Sukses", "role" => $role));
    } else {
        // Jika data tidak ditemukan, kirim pesan error
        echo json_encode(array("status" => "Gagal", "message" => "User tidak ditemukan"));
    }

    // Tutup koneksi ke database
    $conn->close();
} else {
    // Metode request selain POST tidak diizinkan
    echo json_encode(array("status" => "Gagal", "message" => "Metode request tidak diizinkan"));
}
?>