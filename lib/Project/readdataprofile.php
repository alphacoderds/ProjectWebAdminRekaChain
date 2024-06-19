<?php
// CORS headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: X-Requested-With, Content-Type, Accept, Authorization");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    // Handle preflight request
    header("Access-Control-Max-Age: 86400"); // Cache for 1 day
    exit(0);
}

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Create connection to the database
$conn = new mysqli("localhost", "root", "", "db_rekachain");

// Check connection
if ($conn->connect_error) {
    die(json_encode(array('error' => 'Database connection failed')));
}

// Get NIP from POST request and sanitize it
$nip = isset($_POST["nip"]) ? $conn->real_escape_string($_POST["nip"]) : '';

if (empty($nip)) {
    die(json_encode(array('error' => 'NIP is required')));
}

// Query to get user profile data based on NIP
$sql = "SELECT * FROM tbl_tambahstaff WHERE nip = '$nip'";
$result = $conn->query($sql);

// Prepare array to store data
$data = array();

// Check query result
if ($result->num_rows > 0) { 
    // Fetch each row and add to the data array
    while($row = $result->fetch_assoc()) {
        // Modify the image path to use the serve_image.php script with relative path
        if (isset($row['image_path'])) {
            $relativeImagePath = 'upload/' . basename($row['image_path']);
            $row['image_url'] = 'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/serve_image.php?path=' . urlencode($relativeImagePath);
        }
        $data[] = $row;
    }
    // Return data in JSON format
    echo json_encode($data[0]);
} else {
    http_response_code(404);
    echo json_encode(["message" => "user tidak ditemukan"]); 
}

// Close connection
$conn->close();
?>
