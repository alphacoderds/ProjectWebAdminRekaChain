<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$conn = mysqli_connect('localhost', 'root', '', 'db_rekachain');

if (!$conn) {
    die(json_encode(["message" => "Failed to connect to database: " . mysqli_connect_error()]));
}

if (isset($_POST['nama'], $_POST['jabatan'], $_POST['unit_kerja'], $_POST['departemen'], $_POST['divisi'], $_POST['email'], $_POST['no_telp'], $_POST['nip'], $_POST['status'])) {
    $nama = $_POST['nama'];
    $jabatan = $_POST['jabatan'];
    $unit_kerja = $_POST['unit_kerja'];
    $departemen = $_POST['departemen'];
    $divisi = $_POST['divisi'];
    $email = $_POST['email'];
    $no_telp = $_POST['no_telp'];
    $nip = $_POST['nip'];
    $status = $_POST['status'];

    $base_url = "";

    if (isset($_FILES['profile']) && $_FILES['profile']['error'] === UPLOAD_ERR_OK) {
        $uploadDir = '../Project/upload/';
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        $extension = pathinfo($_FILES['profile']['name'], PATHINFO_EXTENSION);
        $new_filename = uniqid() . '_' . time() . '.' . $extension;
        $uploadfile = $uploadDir . $new_filename;

        if (move_uploaded_file($_FILES['profile']['tmp_name'], $uploadfile)) {
            $base_url = "https://rekachain.000webhostapp.com/Project/upload/$new_filename";
        }
    }

    $query = "UPDATE tbl_tambahstaff SET 
                nama='$nama',
                jabatan='$jabatan',
                unit_kerja='$unit_kerja',
                departemen='$departemen',
                divisi='$divisi',
                email='$email',
                no_telp='$no_telp',
                status='$status'";

    if ($base_url) {
        $query .= ", profile='$base_url'";
    }

    $query .= " WHERE nip = '$nip'";

    $result = mysqli_query($conn, $query);

    if ($result) {
        echo json_encode(["message" => "Success", "profile" => $base_url]);
    } else {
        echo json_encode(["message" => "Failed", "error" => mysqli_error($conn)]);
    }
} else {
    echo json_encode(["message" => "Incomplete data received"]);
}

mysqli_close($conn);
?>