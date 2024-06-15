<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Koneksi ke database
$conn = mysqli_connect('localhost', 'id22313015_rekachain', '49Nc-YpTT-gxNAu', 'id22313015_db_rekachain');

// Periksa apakah parameter id_lot telah diterima
if (isset($_GET['id_lot'])) {
    $id_lot = $_GET['id_lot'];

    // Query SQL untuk mengambil data dari tbl_lot dan tbl_kerusakan dengan inner join
    $sql = "SELECT 
                tbl_lot.noProduk,
                tbl_kerusakan.detail_kerusakan,
                tbl_kerusakan.item,
                tbl_kerusakan.keterangan,
                tbl_kerusakan.waktu
            FROM 
                tbl_lot
            INNER JOIN 
                tbl_kerusakan ON tbl_lot.id_project = tbl_kerusakan.id_project
            WHERE 
                tbl_lot.id_lot = ?";
    
    // Membuat prepared statement
    $stmt = $conn->prepare($sql);
    
    // Bind parameter
    $stmt->bind_param('s', $id_lot);
    
    // Eksekusi statement
    $stmt->execute();
    
    // Dapatkan hasil query
    $result = $stmt->get_result();
    
    // Periksa apakah ada hasil
    if ($result->num_rows > 0) {
        // Ambil semua baris hasil query
        $data = $result->fetch_all(MYSQLI_ASSOC);
        
        // Format data menjadi JSON
        $response = array('data' => array());
        
        foreach ($data as $row) {
            $response['data'][] = array(
                'noProduk' => $row['noProduk'],
                'detail_kerusakan' => $row['detail_kerusakan'],
                'item' => $row['item'],
                'keterangan' => $row['keterangan'],
                'waktu' => $row['waktu']
            );
        }
        
        // Encode data menjadi format JSON dan cetak
        echo json_encode($response);
    } else {
        // Jika tidak ada hasil, kirimkan pesan bahwa data tidak ditemukan
        echo json_encode(array('message' => 'Data tidak ditemukan.'));
    }
    
    // Tutup statement
    $stmt->close();
} else {
    // Jika parameter id_lot tidak diberikan, kirimkan pesan error
    echo json_encode(array('message' => 'Parameter id_lot tidak diberikan.'));
}

// Tutup koneksi database
$conn->close();
?>
