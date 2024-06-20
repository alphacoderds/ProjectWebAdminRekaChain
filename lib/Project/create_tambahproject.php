<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost", "root", "", "db_rekachain");
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
