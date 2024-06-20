<?php
// Mengaktifkan error reporting untuk debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Menangani permintaan OPTIONS (preflight)
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    exit(0);
}

// Set header agar response berupa JSON
header("Content-Type: application/json");
// Header untuk mengizinkan akses dari berbagai domain (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST");

// Koneksi ke database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

$nama = $_POST['nama'];
$jabatan = $_POST['jabatan'];
$unit_kerja = $_POST['unit_kerja'];
$departemen = $_POST['departemen'];
$divisi = $_POST['divisi'];
$no_telp = $_POST['no_telp'];
$nip = $_POST['nip'];
$password = $_POST['password'];
$status = $_POST['status'];

$sql =  "UPDATE `coba` SET `nama`='$nama',`jabatan`='$jabatan',`unit_kerja`='$unit_kerja',`departemen`='$departemen',`divisi`='$divisi',`no_telp`='$no_telp',`nip`='$nip',`password`=SHA1('$password'),`status`='$status' WHERE kode_staff = $id";

$result = mysqli_query($conn,$sql);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Mendapatkan data profil pengguna berdasarkan NIP yang diterima dari permintaan POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Mengambil nilai NIP dari permintaan POST dan mengonversinya ke integer
    $nip = intval($_POST["nip"]);

    // Persiapkan query SQL menggunakan prepared statement untuk mencegah SQL injection
    $sql = "SELECT * FROM tbl_tambahstaff WHERE nip = ?";

    // Persiapkan statement
    $stmt = $conn->prepare($sql);

    // Bind parameter ke statement
    $stmt->bind_param("s", $nip);

    // Eksekusi statement
    $stmt->execute();

    // Ambil hasil query sebagai array asosiatif
    $result = $stmt->get_result();

    // Inisialisasi array untuk menyimpan hasil
    $data = [];

    if ($result->num_rows > 0) {
        // Ambil hasil query sebagai array asosiatif
        while ($row = $result->fetch_assoc()) {
            // Tambahkan data ke array
            $data[] = $row;
        }

        // Mengembalikan hasil sebagai respon JSON
        echo json_encode($data);
    } else {
        // Jika data pengguna tidak ditemukan
        echo json_encode(["error" => "User not found"]);
    }
} else {
    // Jika metode permintaan bukan POST, kirimkan pesan error
    echo json_encode(["error" => "Invalid request method"]);
}

// Tutup koneksi ke database
$stmt->close();
$conn->close();
?>
