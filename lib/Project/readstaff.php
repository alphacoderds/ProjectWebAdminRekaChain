<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost", "root", "", "db_rekachain");
$result = $conn->query("select * from tbl_tambahstaff");
$data = array();
$datafinal = array();

// Periksa hasil kueri
if ($result->num_rows > 0) { 
    // Ambil setiap baris hasil dan tambahkan ke dalam array data
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
        
    }
    // Kembalikan data dalam format JSON
    echo json_encode($data);
     
    
    
    
} else {
    http_response_code(404);
    echo json_encode(["message" => "error"]); 
}
?>