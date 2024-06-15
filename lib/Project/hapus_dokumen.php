<?php
header("Access-Control-Allow-Origin: *");
$conn=new mysqli("localhost","id22313015_rekachain","49Nc-YpTT-gxNAu","id22313015_db_rekachain");
$no = $_POST["no"];

// Ambil nama file dari database berdasarkan nomor yang diberikan
$result = mysqli_query($conn, "SELECT file FROM tbl_file WHERE no='$no'");
$row = mysqli_fetch_assoc($result);
$fileName = $row['file'];

// Hapus file dari direktori uploads
$filePath = "uploads/" . $fileName;
if (file_exists($filePath)) {
    if (unlink($filePath)) {
        // Jika file berhasil dihapus dari direktori, lanjutkan menghapus entri dari database
        $data = mysqli_query($conn, "DELETE FROM tbl_file WHERE no='$no'");
        if ($data) {
            echo json_encode(['pesan' => 'Sukses']);
        } else {
            echo json_encode(['pesan' => 'Gagal menghapus entri dari database']);
        }
    } else {
        echo json_encode(['pesan' => 'Gagal menghapus file dari direktori']);
    }
} else {
    echo json_encode(['pesan' => 'File tidak ditemukan di direktori uploads']);
}
?>
