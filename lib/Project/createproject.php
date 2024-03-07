<?php
$conn=new mysqli("localhost","root","","db_rekachain");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$no = $_POST["no"];
$kodeProject = $_POST["kodeProject"];
$namaProject = $_POST["namaProject"];
$data = $conn->prepare("INSERT INTO project (no, kodeProject, namaProject) VALUES (?, ?, ?)");
$data->bind_param("iss", $no, $kodeProject, $namaProject);
$result = $data->execute();
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}else{
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
$data->close();
$conn->close();
?>

<?php
$conn=new mysqli("localhost","root","","db_rekachain");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

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

$data = $conn->prepare("INSERT INTO tbl_tambahStaff (kode_staff, nama, jabatan, unit_kerja, departemen, divisi, email, no_telp, nip, status, password, konfirmasi_password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$data->bind_param("ssssssssssss", $kode_staff, $nama, $jabatan, $unit_kerja, $departemen, $divisi, $email, $no_telp, $nip, $status, $password, $konfirmasi_password);
$result = $data->execute();

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}else{
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
$stmt->close();
$conn->close();
?>