<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$conn = new mysqli("localhost", "id22313015_rekachain", "49Nc-YpTT-gxNAu", "id22313015_db_rekachain");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $no = $_POST["no"];
    $kode_staff = $_POST["kode_staff"];
    $nama = $_POST["nama"];
    $jabatan = $_POST["jabatan"];
    $unit_kerja = $_POST["unit_kerja"];
    $departemen = $_POST["departemen"];
    $divisi = $_POST["divisi"];
    $email = $_POST["email"];
    $no_telp = $_POST["no_telp"];
    $nip = $_POST["nip"];
    $status = $_POST["status"];
    $password = $_POST["password"];
    $konfirmasi_password = $_POST["konfirmasi_password"];
    $role = $_POST["role"];

    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $sql = "INSERT INTO tbl_tambahstaff (no, kode_staff, nama, jabatan, unit_kerja, departemen, divisi, email, no_telp, nip, status, password, konfirmasi_password) 
            VALUES ('$no', '$kode_staff', '$nama', '$jabatan', '$unit_kerja', '$departemen', '$divisi', '$email', '$no_telp', '$nip', '$status', '$password', '$konfirmasi_password')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(array("status" => "Sukses", "message" => "Data berhasil ditambahkan"));
    } else {
        echo json_encode(array("status" => "Gagal", "message" => "Error: " . $sql . "<br>" . $conn->error));
    }
} else {
    echo json_encode(array("status" => "Gagal", "message" => "Metode request tidak diizinkan"));
}

$conn->close();
?>
