<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","id22313015_rekachain","49Nc-YpTT-gxNAu","id22313015_db_rekachain");
$no = $_POST["no"];
$data = mysqli_query($conn, "delete from tbl_file where no='$no' ");
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