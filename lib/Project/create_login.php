<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header('Content-Type: application/json; charset=utf-8');
header("Cache-Control: no-cache, no-store, must-revalidate");

// Koneksi ke database
$connect = new mysqli("localhost", "root", "", "db_rekachain");

// Periksa koneksi
if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

// Endpoint untuk validasi login
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nip = $_POST["nip"];
    $password = $_POST["password"];

    // Lakukan validasi login
    $queryResult = $connect->query("SELECT * FROM tbl_tambahstaff WHERE nip='".$nip."' AND password='".$password."'");
    $result = array();

    if ($queryResult->num_rows > 0) {
        while ($fetchData = $queryResult->fetch_assoc()) {
            $result[] = $fetchData;
        }

        // Ambil role dari pengguna yang berhasil login
        $role = $result[0]["role"];
        
        // Kirim kembali data ke Flutter berserta peran (role) pengguna
        echo json_encode(array("status" => "Sukses", "data" => $result, "role" => $role));
    } else {
        // Jika NIP atau password tidak sesuai
        echo json_encode(array("status" => "Gagal", "message" => "NIP atau password salah"));
    }
} else {
    // Metode request selain POST tidak diizinkan
    echo json_encode(array("status" => "Gagal", "message" => "Metode request tidak diizinkan"));
}

// Tutup koneksi ke database
$connect->close();
?>

// $conn = new mysqli("localhost", "root", "", "db_rekachain");

// $json = array(
//     "response_status"=>"OK",
//     "response_message"=>'',
//     "data"=>array()
// );

// $nip = isset($_GET['nip']) ? $_GET['nip'] : '';
// $password = isset($_GET['password']) ? $_GET['password'] : '';

// $stmt = $conn->prepare("SELECT * FROM tbl_tambahstaff WHERE nip=? AND password=?");
// $stmt->bind_param("ss", $nip, $password);
// $stmt->execute();
// $result = $stmt->get_result();

// if($result->num_rows > 0){
//     while ($row = $result->fetch_assoc()){
//         $json['data'][] = $row;
//     }
// } else {
//     $json['response_status']="Error";
//     $json['response_message']="Username atau Password Salah";
// }

// header('Content-Type: application/json');
// print json_encode($json, JSON_PRETTY_PRINT);

// $stmt->close();
// $conn->close();
?>
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Headers: *");

// $conn = new mysqli("localhost", "root", "", "db_rekachain");

// $json = array(
//     "response_status"=>"OK",
//     "response_message"=>'',
//     "data"=>array()
// );

// $nip=isset($_GET['nip'])?$_GET['nip']:'';
// $password=isset($_GET['password'])?$_GET['password']:'';
// $sql=$conn->query("SELECT * FROM tbl_tambahstaff WHERE nip='".$nip."' and password='".$password."' ");
// $jml=$sql->num_rows;
// if($jml>0){
//     while ($rs=$sql->fetch_object()){
//         $arr_row=array();
//         $arr_row['no'] = $rs->no;
//         $arr_row['kode_staff'] = $rs->kode_staff; 
//         $arr_row['nama'] = $rs->$nama; 
//         $arr_row['jabatan'] = $rs->$jabatan; 
//         $arr_row['unit_kerja'] = $rs->$unit_kerja; 
//         $arr_row['departemen'] = $rs->$departemen;
//         $arr_row['divisi'] = $rs->$divisi;
//         $arr_row['email'] = $rs->$email;
//         $arr_row['no_telp'] = $rs->$no_telp;
//         $arr_row['nip'] = $rs->nip;
//         $arr_row['status'] = $rs->$status; 
//         $arr_row['password'] = $rs->password;
//         $arr_row['konfirmasi_password'] = $rs->$konfirmasi_password;
//         $arr_row['role'] = $rs->role;
//         $json['data'][] = $arr_row; 
//     }
// }else{
//     $json['response_status']="Error";
//     $json['response_message']="Username atau Password Salah";

//     header('Contect-Type: application/json');
//     print json_encode($json, JSON_PRETTY_PRINT);
// }
?>
// $nip = $data['nip'];
// $password = $data['password'];

// $connection = new mysqli("localhost", "root", "", "db_rekachain");
// if ($connection->connect_error) {
//     die("Connection failed: " . $connection->connect_error);
// }

// $query = "SELECT * FROM tbl_tambahstaff WHERE nip='$nip'";
// $result = $connection->query($query);

// if ($result->num_rows > 0) {
//     $nip = $result->fetch_assoc();
    
//     if (password_verify($password, $nip['password'])) {
//         $response = array("success" => true, "message" => "Login successful", "nip" => $nip);
//         echo json_encode($response);
//     } else {
//         $response = array("success" => false, "message" => "Invalid nip or password");
//         echo json_encode($response);
//     }
// } else {
//     $response = array("success" => false, "message" => "User not found");
//     echo json_encode($response);
// }


// $connection->close();