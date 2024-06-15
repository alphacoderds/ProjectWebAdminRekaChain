<?php 
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","id22313015_rekachain","49Nc-YpTT-gxNAu","id22313015_db_rekachain");
$id_project = $_POST["id_project"];
$noProduk = $_POST["noProduk"];
$tanggal = $_POST["tanggal"];

$target_dir = "uploads/"; // Folder tempat menyimpan file yang diunggah
$target_file = $target_dir . basename($_FILES["file"]["name"]);
move_uploaded_file($_FILES["file"]["tmp_name"], $target_file);

$file_name = basename($_FILES["file"]["name"]);

$data = mysqli_query($conn, "INSERT INTO tbl_file (id_project, file, noProduk, tanggal) VALUES ('$id_project', '$file_name', '$noProduk', '$tanggal') ");

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>
