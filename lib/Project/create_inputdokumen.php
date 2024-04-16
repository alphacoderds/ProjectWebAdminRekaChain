<?php 
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$id_project = $_POST["id_project"];
$file = $_FILES["file"];
$kodeLot = $_POST["kodeLot"];
$tanggal = $_POST["tanggal"];
$data = mysqli_query($conn, "insert into tbl_file set no='$no', id_project='$id_project', file='$file', kodeLot='$kodeLot', tanggal='$tanggal' ");
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