<?php
$conn=new mysqli("localhost","root","","db_rekachain");
$no = $_POST["no"];
$kodeProject = $_POST["kodeProject"];
$namaProject = $_POST["namaProject"];
$data = mysqli_query($conn, "insert into tbl_project set no='$no', kodeProject='$kodeProject', namaProject='$namaProject' ");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}else{
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>

<?php
$conn=new mysqli("localhost","root","","db_rekachain");
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
$data = mysqli_query($conn, "insert into tbl_tambahstaff set no='$no', kode_staff='$kode_staff', nama='$nama', jabatan='$jabatan', unit_kerja='$unit_kerja', departemen='$departemen', divisi='$divisi', email='$email', no_telp='$no_telp', nip='$nip', status='$status', password='$password', konfirmasi_password='$konfirmasi_password' ");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}else{
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>

<?php 
$conn=new mysqli("localhost","root","","db_rekachain");
$no = $_POST["no"];
$namaProject = $_POST["namaProject"];
$file = $_POST["file"];
$noProduk = $_POST["noProduk"];
$tanggal = $_POST["tanggal"];
$data = mysqli_query($conn, "insert into tbl_file set no='$no', namaProject='$namaProject', file='$file', noProduk='$noProduk', tanggal='$tanggal' ");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
}else{
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>