<?php
$conn=new mysqli("localhost","root","","db_rekachain");
$no = $_POST["no"];
$kodeProject = $_POST["kodeProject"];
$namaProject = $_POST["namaProject"];
$data= mysqli_query($conn, "update project set no='$no', kodeProject='$kodeProject', namaProject='$namaProject' ");
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