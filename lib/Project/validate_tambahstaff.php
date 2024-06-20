<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

// Koneksi ke database
$connect = new mysqli("localhost", "root", "", "db_rekachain");

// sPeriksa koneksi
if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

// Endpoint untuk validasi login
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nip = $_POST["nip"];
    $password = $_POST["password"];

    // Lakukan validasi login
    $queryResult = $connect->query("SELECT * FROM tbl_tambahstaff WHERE nip='".$nip."' AND password='".$password."'");
    $result = array();

    if ($queryResult->num_rows > 0) {
        while ($fetchData = $queryResult->fetch_assoc()) {
            $result[] = $fetchData;
        }

        // Ambil role dari pengguna yang berhasil login
        $role = $result[0]["role"];
        
        // Kirim kembali data ke Flutter berserta peran (role) pengguna
        echo json_encode(array("status" => "Sukses", "data" => $result, "role" => $role));
    } else {
        // Jika NIP atau password tidak sesuai
        echo json_encode(array("status" => "Gagal", "message" => "NIP atau password salah"));
    }
} else {
    // Metode request selain POST tidak diizinkan
    echo json_encode(array("status" => "Gagal", "message" => "Metode request tidak diizinkan"));
}

// Tutup koneksi ke database
$connect->close();
?>
