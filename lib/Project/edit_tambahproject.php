<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","id22313015_rekachain","49Nc-YpTT-gxNAu","id22313015_db_rekachain");
$no_tambahproject = $_POST["no_tambahproject"];
$kodeProject = $_POST["kodeProject"];
$namaProject = $_POST["namaProject"];
$idProject = $_POST["idProject"];
$data= mysqli_query($conn, "update tbl_tambahproject set no_tambahproject='$no_tambahproject', kodeProject='$kodeProject', namaProject='$namaProject', idProject='$idProject'  where no_tambahproject='$no_tambahproject' ");
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
