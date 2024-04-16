<?php
$conn=new mysqli("localhost","root","","db_rekachain");
$kode_staff = $_POST["kode_staff"];
$data= mysqli_query($conn, "delete from tbl_tambahStaff where kode_staff='$kode_staff' ");
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