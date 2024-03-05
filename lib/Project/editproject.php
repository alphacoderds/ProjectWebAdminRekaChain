<?php
$conn=new mysqli("localhost","root","","crudflutter");
$id = $_POST["id"];
$nohp = $_POST["nohp"];
$nama = $_POST["nama"];
$alamat = $_POST["alamat"];
$data= mysqli_query($conn, "update siswa set nohp='$nohp', nama='$nama', alamat='$alamat' where id='$id' ");
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