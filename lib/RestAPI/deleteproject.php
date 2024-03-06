<?php
$conn=new mysqli("localhost","root","","crudflutter");
$nohp = $_POST["nohp"];
$data= mysqli_query($conn, "delete from siswa where nohp='$nohp' ");
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