<?php
header("Access-Control-Allow-Origin: *");
$conn = new mysqli("localhost", "root", "", "db_rekachain");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id_project = $_POST["id_project"];
$kodeLot = $_POST["kodeLot"];

$file_tmp = $_FILES["file"]["tmp_name"];

// Debugging: Cek nilai dan tipe data $id_project
if (empty($id_project)) {
    echo json_encode([
        'pesan' => 'ID project tidak boleh kosong',
        'id_project' => $id_project
    ]);
    $conn->close();
    exit;
}

if (($handle = fopen($file_tmp, "r")) !== FALSE) {
    // Skip the header row
    fgetcsv($handle, 1000, ",");

    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        $kodeMaterial = $data[0];
        $deskripsi = $data[1];
        $specTech = $data[2];
        $qty = $data[3];
        $unit = $data[4];

        // Prepare and bind
        $stmt = $conn->prepare("INSERT INTO tbl_material (id_project, kodeLot, kodeMaterial, deskripsi, specTech, qty, unit) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssis", $id_project, $kodeLot, $kodeMaterial, $deskripsi, $specTech, $qty, $unit);

        if (!$stmt->execute()) {
            echo json_encode([
                'pesan' => 'Gagal menyimpan data',
                'error' => $stmt->error
            ]);
            $stmt->close();
            $conn->close();
            exit;
        }
        $stmt->close();
    }
    fclose($handle);
} else {
    echo json_encode([
        'pesan' => 'Gagal membuka file'
    ]);
    $conn->close();
    exit;
}

$conn->close();
echo json_encode([
    'pesan' => 'Sukses'
]);
?>
