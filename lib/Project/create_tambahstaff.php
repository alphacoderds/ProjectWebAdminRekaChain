<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$no_tambahproject = $_POST["no_tambahproject"];
$kodeProject = $_POST["kodeProject"];
$namaProject = $_POST["namaProject"];
$idProject = $_POST["idProject"];
$data = mysqli_query($conn, "INSERT INTO tbl_tambahproject set no_tambahproject='$no_tambahproject', kodeProject='$kodeProject', namaProject='$namaProject', idProject='$idProject' ");
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
header("Access-Control-Allow-Origin: *");
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
$hashedPassword = sha1($password);
$hashedConfirmPassword = sha1($konfirmasi_password);
$data = mysqli_query($conn, "INSERT into tbl_tambahstaff set no='$no', kode_staff='$kode_staff', nama='$nama', jabatan='$jabatan', unit_kerja='$unit_kerja', departemen='$departemen', divisi='$divisi', email='$email', no_telp='$no_telp', nip='$nip', status='$status', password='$password', konfirmasi_password='$konfirmasi_password' ");
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
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$id_project = $_POST["id_project"];
$noIndukProduk = $_POST["noIndukProduk"];
$noSeriAwal = $_POST["noSeriAwal"];
$targetMulai = $_POST["targetMulai"];
$namaProduk = $_POST["namaProduk"];
$jumlahLot = $_POST["jumlahLot"];
$kodeLot = $_POST["kodeLot"];
$noSeriAkhir = $_POST["noSeriAkhir"];
$targetSelesai = $_POST["targetSelesai"];
$alurProses = $_POST["alurProses"];
$kategori = $_POST["kategori"];
$keterangan = $_POST["keterangan"];
$data = mysqli_query($conn, "insert into tbl_project set id_project='$id_project', noIndukProduk='$noIndukProduk', noSeriAwal='$noSeriAwal', targetMulai='$targetMulai', namaProduk='$namaProduk', jumlahLot='$jumlahLot', kodeLot='$kodeLot', noSeriAkhir='$noSeriAkhir', targetSelesai='$targetSelesai', alurProses='$alurProses', kategori='$kategori', keterangan='$keterangan' ");
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

<<<<<<< HEAD:lib/Project/create_tambahstaff.php
<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$username = $_POST["username"];
$password = $_POST["password"];
$data = mysqli_query($conn, "INSERT INTO tbl_login set username='$username', password='$password' ");
=======
<?php 
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$id_project = $_POST["id_project"];
$file = $_FILES["file"];
$kodeLot = $_POST["kodeLot"];
$tanggal = $_POST["tanggal"];
$data = mysqli_query($conn, "insert into tbl_file set no='$no', id_project='$id_project', file='$file', kodeLot='$kodeLot', tanggal='$tanggal' ");
>>>>>>> fb7c7b17eb8cafd737d2c4090d5a7bc445479176:lib/Project/create.php
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
