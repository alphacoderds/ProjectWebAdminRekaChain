<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$servername = "localhost";
$username = "id22313015_rekachain";
$password = "49Nc-YpTT-gxNAu";
$dbname = "id22313015_db_rekachain";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(array("error" => "Connection failed: " . $conn->connect_error)));
}

// Get and sanitize input
$id_project = isset($_GET['id_project']) ? $conn->real_escape_string($_GET['id_project']) : '';

if (empty($id_project)) {
    die(json_encode(array("error" => "id_project is required")));
}

// Prepare and execute query
$sql = $conn->prepare("
    SELECT 
        lot.noProduk,
        lot.kodeLot, 
        lot.nama, 
        lot.saran, 
        kerusakan.detail_kerusakan, 
        kerusakan.item, 
        kerusakan.keterangan 
    FROM 
        tbl_lot AS lot
    INNER JOIN 
        tbl_kerusakan AS kerusakan 
    ON 
        lot.id_lot = kerusakan.id_project 
    WHERE 
        lot.id_lot = ?
");
$sql->bind_param("i", $id_project);
$sql->execute();
$result = $sql->get_result();

$data = $result->fetch_all(MYSQLI_ASSOC);

// Close connections
$sql->close();
$conn->close();

// Output JSON
echo json_encode($data);
?>
