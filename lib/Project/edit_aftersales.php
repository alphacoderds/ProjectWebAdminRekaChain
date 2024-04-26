<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","root","","db_rekachain");
$no_aftersales = $_POST["no_aftersales"];
$nama = $_POST["nama"];
$noProduk = $_POST["noProduk"];
$targetMulai = $_POST["targetMulai"];
$dtlKeterangan = $_POST["dtlKeterangan"];
$item = $_POST["item"];
$keterangan = $_POST["keterangan"];
$saran = $_POST["saran"];
$data= mysqli_query($conn, "update tbl_aftersales set no_aftersales='$no_aftersales', nama='$nama', noProduk='$noProduk', targetMulai='$targetMulai', dtlKekurangan='$dtlKekurangan', item='$item', keterangan='$keterangan', saran='$saran'  where no_aftersales='$no_aftersales' ");
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
