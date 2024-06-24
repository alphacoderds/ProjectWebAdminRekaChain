<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost", "root", "", "db_rekachain");
$no = $_POST["no"];
$data= mysqli_query($conn, "DELETE from tbl_tambahStaff WHERE no=$no ");
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