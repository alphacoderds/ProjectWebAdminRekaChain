<?php
header("Access-Control-Allow-Origin: *");
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$no = $_POST["no"];
$kode_staff = $_POST["kode_staff"];
$nama = $_POST["nama"];
$jabatan = $_POST["jabatan"];
$unit_kerja = $_POST["unit_kerja"];
$departemen = $_POST["departemen"];
$divisi = $_POST["divisi"];
$email = $_POST["email"];
$no_telp = $_POST["no_telp"];
$nip = $_POST["nip"];
$status = $_POST["status"];
$password = $_POST["password"];
$konfirmasi_password = $_POST["konfirmasi_password"];

if (!empty($password) && $password == $konfirmasi_password) {

    $update_query = "UPDATE `tbl_tambahstaff` SET `kode_staff`=$kode_staff, `nama`='$nama', `jabatan`='$jabatan', `unit_kerja`='$unit_kerja',`departemen`='$departemen',`divisi`='$divisi',`email`='$email',`no_telp` ='$no_telp', `nip`='$nip',`status`='$status',`password`=SHA1('$password'),`konfirmasi_password`=SHA1('$konfirmasi_password') WHERE no=$no";
} else {
    $update_query = "UPDATE tbl_tambahStaff SET 
        kode_staff='$kode_staff', 
        nama='$nama', 
        jabatan='$jabatan', 
        unit_kerja='$unit_kerja', 
        departemen='$departemen', 
        divisi='$divisi', 
        email='$email', 
        no_telp='$no_telp', 
        nip='$nip', 
        status='$status' 
        WHERE no=$no";
}

$data = mysqli_query($conn, $update_query);

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal',
        'error' => mysqli_error($conn)
    ]);
}

// Function to encrypt the password
function encrypt_password($password) {
    $encryption_key = base64_decode('your-encryption-key');
    $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length('aes-256-cbc'));
    $encrypted = openssl_encrypt($password, 'aes-256-cbc', $encryption_key, 0, $iv);
    return base64_encode($encrypted . '::' . $iv);
}

// Function to decrypt the password
function decrypt_password($encrypted_password) {
    $encryption_key = base64_decode('your-encryption-key');
    list($encrypted_data, $iv) = array_pad(explode('::', base64_decode($encrypted_password), 2), 2, null);
    return openssl_decrypt($encrypted_data, 'aes-256-cbc', $encryption_key, 0, $iv);
}


// Tampilkan password terdekripsi (untuk tujuan pemeriksaan saja)
if (isset($_POST['display_password']) && $_POST['display_password'] == 'true') {
    $query = "SELECT password FROM tbl_tambahStaff WHERE no='" . mysqli_real_escape_string($conn, $no) . "'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $decrypted_password = decrypt_password($row['password']);
        echo json_encode([
            'password' => $decrypted_password
        ]);
    } else {
        echo json_encode([
            'pesan' => 'Gagal'
        ]);
    }
}

$conn->close();
?>