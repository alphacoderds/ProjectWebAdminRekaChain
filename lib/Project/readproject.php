<?php
$conn=new mysqli("localhost","root","","db_rekachain");
$query=mysqli_query($conn,"select * from project");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>

<?php
$conn=new mysqli("localhost","root","","db_rekachain");
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
$query=mysqli_query($conn,"select * from tbl_tambahstaff");
$data=mysqli_fetch_all($query,MYSQLI_ASSOC);
echo json_encode($data);
?>