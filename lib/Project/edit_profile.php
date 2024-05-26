<?php
header("Access-Control-Allow-Origin: *");
$conn=mysqli_connect('localhost','root','','db_rekachain');

$nama = $_POST['nama'];
$jabatan = $_POST['jabatan'];
$unit_kerja = $_POST['unit_kerja'];
$departemen = $_POST['departemen'];
$divisi = $_POST['divisi'];
$email = $_POST['email'];
$no_telp = $_POST['no_telp'];
$nip = $_POST['nip'];
$status = $_POST['status'];

$sql =  "UPDATE `tbl_tambahstaff` SET `nama`='$nama',`jabatan`='$jabatan',`unit_kerja`='$unit_kerja',`departemen`='$departemen',`divisi`='$divisi', `email`='$email',`no_telp`='$no_telp',`status`='$status' WHERE nip = $nip";

$result = mysqli_query($conn,$sql);

if ($result) {
    echo json_encode([
        "message" => "Success"
    ]);
}else{
   echo json_encode([
    "message" => "Gagal"
   ]);
}
?>