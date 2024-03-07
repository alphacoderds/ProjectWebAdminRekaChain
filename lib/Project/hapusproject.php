<?php
$conn=new mysqli("localhost","root","","db_rekachain");
$kodeProject = $_POST["kodeProject"];
$data= mysqli_query($conn, "delete from project where kodeProject='$kodeProject' ");
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