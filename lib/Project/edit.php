<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$no = $_POST["no"];
$kodeProject = $_POST["kodeProject"];
$namaProject = $_POST["namaProject"];
$idProject = $_POST["idProject"];
$data= mysqli_query($conn, "update tbl_tambahproject set kodeProject='$kodeProject', namaProject='$namaProject', idProject='$idProject'  where no='$no' ");
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
$data= mysqli_query($conn, "update tbl_tambahStaff set kode_staff='$kode_staff', nama='$nama', jabatan='$jabatan', unit_kerja='$unit_kerja', departemen='$departemen', divisi='$divisi', email='$email', no_telp='$no_telp', nip='$nip', status='$status', password='$password', konfirmasi_password='$konfirmasi_password' where no='$no'");
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
$data = mysqli_query($conn, "update tbl_project set id_project='$id_project', noIndukProduk='$noIndukProduk', noSeriAwal='$noSeriAwal', targetMulai='$targetMulai', namaProduk='$namaProduk', jumlahLot='$jumlahLot', kodeLot='$kodeLot', noSeriAkhir='$noSeriAkhir', targetSelesai='$targetSelesai', alurProses = '$alurProses', kategori = '$kategori', keterangan = '$keterangan' where id_project='$id_project' ");
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
