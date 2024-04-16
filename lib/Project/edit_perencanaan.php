<?php
header("Access-Control-Allow-Origin: *");

// Menghubungkan ke database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi Gagal: " . $conn->connect_error);
}

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
$noProduk = $_POST["noProduk"];

$conn->begin_transaction();

// Query untuk memperbarui data proyek
$query1 = "UPDATE tbl_project SET
nama = '$nama',
noIndukProduk = '$noIndukProduk',
noSeriAwal = '$noSeriAwal',
targetMulai = '$targetMulai',
namaProduk = '$namaProduk',
jumlahLot = '$jumlahLot',
kodeLot = '$kodeLot',
noSeriAkhir = '$noSeriAkhir',
targetSelesai = '$targetSelesai',
ap1 = '$ap1',
kategori1 = '$kategori1',
keterangan1 = '$keterangan1',
ap2 = '$ap2',
kategori2 = '$kategori2',
keterangan2 = '$keterangan2',
ap3 = '$ap3',
kategori3 = '$kategori3',
keterangan3 = '$keterangan3',
ap4 = '$ap4',
kategori4 = '$kategori4',
keterangan4 = '$keterangan4',
ap5 = '$ap5',
kategori5 = '$kategori5',
keterangan5 = '$keterangan5',
ap6 = '$ap6',
kategori6 = '$kategori6',
keterangan6 = '$keterangan6',
ap7 = '$ap7',
kategori7 = '$kategori7',
keterangan7 = '$keterangan7',
ap8 = '$ap8',
kategori8 = '$kategori8',
keterangan8 = '$keterangan8',
ap9 = '$ap9',
kategori9 = '$kategori9',
keterangan9 = '$keterangan9',
ap10 = '$ap10',
kategori10 = '$kategori10',
keterangan10 = '$keterangan10'
WHERE id = '$id'";

$result1 = $conn->query($query1);

// Memeriksa apakah query1 berhasil dieksekusi
if (!$result1) {
    $conn->rollback();
    echo json_encode([
        'pesan' => 'Gagal memperbarui data proyek'
    ]);
    exit;
}

// Loop untuk memperbarui data lot
for ($i = 0; $i < $jumlahLot; $i++) {
    // Menghitung noProduk untuk setiap iterasi
    $noProduk_iterasi = $noProduk + $i + 1;

    $tahun = substr($targetMulai, 6);

    $noProduk_combined = "${noIndukProduk}.${noProduk_iterasi}/${tahun}";

    // Query untuk memperbarui data lot
    $query2 = "UPDATE tbl_lot SET kodeLot = '$kodeLot', noProduk = '$noProduk_combined' WHERE id = '$id' AND kodeLot = '$kodeLot'";
    $result2 = $conn->query($query2);

    // Memeriksa apakah query2 berhasil dieksekusi
    if (!$result2) {
        $conn->rollback();
        echo json_encode([
            'pesan' => 'Gagal memperbarui data lot'
        ]);
        exit;
    }
}

// Commit transaksi jika berhasil
$conn->commit();
echo json_encode([
    'pesan' => 'Sukses'
]);

// Menutup koneksi
$conn->close();
?>
