<?php
header("Access-Control-Allow-Origin: *");
$conn = mysqli_connect("localhost", "root", "", "db_rekachain");

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$kodeLot = $_GET['kodeLot'];

$sql = "SELECT tbl_lot.*, 
        staff1.nama as nama1,
        staff2.nama as nama2,
        staff3.nama as nama3,
        staff4.nama as nama4,
        staff5.nama as nama5,
        staff6.nama as nama6,
        staff7.nama as nama7,
        staff8.nama as nama8,
        staff9.nama as nama9,
        staff10.nama as nama10
    FROM tbl_lot 
    LEFT JOIN tbl_tambahstaff AS staff1 ON tbl_lot.nip1 = staff1.nip
    LEFT JOIN tbl_tambahstaff AS staff2 ON tbl_lot.nip2 = staff2.nip
    LEFT JOIN tbl_tambahstaff AS staff3 ON tbl_lot.nip3 = staff3.nip
    LEFT JOIN tbl_tambahstaff AS staff4 ON tbl_lot.nip4 = staff4.nip
    LEFT JOIN tbl_tambahstaff AS staff5 ON tbl_lot.nip5 = staff5.nip
    LEFT JOIN tbl_tambahstaff AS staff6 ON tbl_lot.nip6 = staff6.nip
    LEFT JOIN tbl_tambahstaff AS staff7 ON tbl_lot.nip7 = staff7.nip
    LEFT JOIN tbl_tambahstaff AS staff8 ON tbl_lot.nip8 = staff8.nip
    LEFT JOIN tbl_tambahstaff AS staff9 ON tbl_lot.nip9 = staff9.nip
    LEFT JOIN tbl_tambahstaff AS staff10 ON tbl_lot.nip10 = staff10.nip
    WHERE tbl_lot.kodeLot = '$kodeLot'";

$result = $conn->query($sql);

if ($result) {
    $data = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode($data);
} else {
    echo json_encode(array('error' => 'Gagal mengambil data: ' . mysqli_error($conn)));
}

mysqli_close($conn);
?>
