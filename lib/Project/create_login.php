<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$username = $_POST["username"];
$password = $_POST["password"];
$data = mysqli_query($conn, "INSERT INTO tbl_login set username='$username', password='$password' ");
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
