<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$id_project = $_POST["id_project"];
$noIndukProduk = $_POST["noIndukProduk"];
$noSeriAwal = $_POST["noSeriAwal"];
$targetMulai = $_POST["targetMulai"];
$namaProduk = $_POST["namaProduk"];
$jumlahLot = $_POST["jumlahLot"];
$kodeLot = $_POST["kodeLot"];
$noSeriAkhir = $_POST["noSeriAkhir"];
$targetSelesai = $_POST["targetSelesai"];
$alurProses = $_POST["alurProses"];
$kategori = $_POST["kategori"];
$keterangan = $_POST["keterangan"];
$data = mysqli_query($conn, "insert into tbl_project set id_project='$id_project', noIndukProduk='$noIndukProduk', noSeriAwal='$noSeriAwal', targetMulai='$targetMulai', namaProduk='$namaProduk', jumlahLot='$jumlahLot', kodeLot='$kodeLot', noSeriAkhir='$noSeriAkhir', targetSelesai='$targetSelesai', alurProses='$alurProses', kategori='$kategori', keterangan='$keterangan' ");
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
