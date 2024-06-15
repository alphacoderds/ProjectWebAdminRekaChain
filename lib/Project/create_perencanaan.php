<?php
header("Access-Control-Allow-Origin: *");
$conn = new mysqli("localhost", "id22313015_rekachain", "49Nc-YpTT-gxNAu", "id22313015_db_rekachain");

// Data dari form pertama
$id = $_POST["id"];
$nama = $_POST["nama"];
$noIndukProduk = $_POST["noIndukProduk"];
$noSeriAwal = $_POST["noSeriAwal"];
$targetMulai = $_POST["targetMulai"];
$namaProduk = $_POST["namaProduk"];
$jumlahLot = $_POST["jumlahLot"];
$kodeLot = $_POST["kodeLot"];
$noSeriAkhir = $_POST["noSeriAkhir"];
$targetSelesai = $_POST["targetSelesai"];
$ap1 = $_POST["ap1"];
$kategori1 = $_POST["kategori1"];
$keterangan1 = $_POST["keterangan1"];
$ap2 = $_POST["ap2"];
$kategori2 = $_POST["kategori2"];
$keterangan2 = $_POST["keterangan2"];
$ap3 = $_POST["ap3"];
$kategori3 = $_POST["kategori3"];
$keterangan3 = $_POST["keterangan3"];
$ap4 = $_POST["ap4"];
$kategori4 = $_POST["kategori4"];
$keterangan4 = $_POST["keterangan4"];
$ap5 = $_POST["ap5"];
$kategori5 = $_POST["kategori5"];
$keterangan5 = $_POST["keterangan5"];
$ap6 = $_POST["ap6"];
$kategori6 = $_POST["kategori6"];
$keterangan6 = $_POST["keterangan6"];
$ap7 = $_POST["ap7"];
$kategori7 = $_POST["kategori7"];
$keterangan7 = $_POST["keterangan7"];
$ap8 = $_POST["ap8"];
$kategori8 = $_POST["kategori8"];
$keterangan8 = $_POST["keterangan8"];
$ap9 = $_POST["ap9"];
$kategori9 = $_POST["kategori9"];
$keterangan9 = $_POST["keterangan9"];
$ap10 = $_POST["ap10"];
$kategori10 = $_POST["kategori10"];
$keterangan10 = $_POST["keterangan10"];

// Data dari form kedua
$id_lot = $_POST["id_lot"];
$noProduk = $_POST["noProduk"];

$conn->begin_transaction();

$query1 = "INSERT INTO tbl_project (id, nama, noIndukProduk, noSeriAwal, targetMulai, namaProduk, jumlahLot, kodeLot, noSeriAkhir, targetSelesai, 
ap1, kategori1, keterangan1, 
ap2, kategori2, keterangan2, 
ap3, kategori3, keterangan3, 
ap4, kategori4, keterangan4, 
ap5, kategori5, keterangan5, 
ap6, kategori6, keterangan6, 
ap7, kategori7, keterangan7, 
ap8, kategori8, keterangan8, 
ap9, kategori9, keterangan9, 
ap10, kategori10, keterangan10) VALUES ('$id', '$nama', '$noIndukProduk', '$noSeriAwal', '$targetMulai', '$namaProduk', '$jumlahLot', '$kodeLot', '$noSeriAkhir', '$targetSelesai', 
'$ap1', '$kategori1', '$keterangan1', 
'$ap2', '$kategori2', '$keterangan2', 
'$ap3', '$kategori3', '$keterangan3', 
'$ap4', '$kategori4', '$keterangan4', 
'$ap5', '$kategori5', '$keterangan5', 
'$ap6', '$kategori6', '$keterangan6', 
'$ap7', '$kategori7', '$keterangan7', 
'$ap8', '$kategori8', '$keterangan8', 
'$ap9', '$kategori9', '$keterangan9', 
'$ap10', '$kategori10', '$keterangan10')";

$result1 = $conn->query($query1);

if (!$result1) {
    $conn->rollback();
    echo json_encode([
        'pesan' => 'Gagal menambahkan data project',
        'error' => $conn->error
    ]);
    exit;
}

for ($i = 0; $i < $jumlahLot; $i++) {
    $noProduk_iterasi = $noProduk + $i + 1;
    $tahun = substr($targetMulai, 6);
    $noProduk_combined = "${noIndukProduk}.${noProduk_iterasi}/${tahun}";

    $query2 = "INSERT INTO tbl_lot (kodeLot, id_lot, noProduk, noIndukProduk, nama, namaProduk, noSeriAwal, jumlahLot, noSeriAkhir, targetMulai, targetSelesai, 
    ap1, kategori1, keterangan1, 
    ap2, kategori2, keterangan2, 
    ap3, kategori3, keterangan3, 
    ap4, kategori4, keterangan4, 
    ap5, kategori5, keterangan5, 
    ap6, kategori6, keterangan6, 
    ap7, kategori7, keterangan7, 
    ap8, kategori8, keterangan8, 
    ap9, kategori9, keterangan9, 
    ap10, kategori10, keterangan10) VALUES ('$kodeLot', '$id_lot', '$noProduk_combined', '$noIndukProduk', '$nama', '$namaProduk', '$noSeriAwal', '$jumlahLot', '$noSeriAkhir', '$targetMulai', '$targetSelesai', 
    '$ap1', '$kategori1', '$keterangan1', 
    '$ap2', '$kategori2', '$keterangan2', 
    '$ap3', '$kategori3', '$keterangan3', 
    '$ap4', '$kategori4', '$keterangan4', 
    '$ap5', '$kategori5', '$keterangan5', 
    '$ap6', '$kategori6', '$keterangan6', 
    '$ap7', '$kategori7', '$keterangan7', 
    '$ap8', '$kategori8', '$keterangan8', 
    '$ap9', '$kategori9', '$keterangan9', 
    '$ap10', '$kategori10', '$keterangan10')";

    $result2 = $conn->query($query2);

    if (!$result2) {
        $conn->rollback();
        echo json_encode([
            'pesan' => 'Gagal menambahkan data lot',
            'query' => $query2,
            'error' => $conn->error
        ]);
        exit;
    }
}

$conn->commit();
echo json_encode([
    'pesan' => 'Sukses'
]);

$conn->close();
?>
