<?php
// CORS headers to allow access from any origin
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: X-Requested-With, Content-Type, Accept");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    // Handle preflight request
    header("Access-Control-Max-Age: 86400"); // Cache for 1 day
    exit(0);
}

// Path to the image (relative path)
$imagePath = isset($_GET['path']) ? $_GET['path'] : '';

// Construct the full path to the image
$fullImagePath = realpath(__DIR__ . '/' . $imagePath);

// Check if file exists and the path is valid
if ($fullImagePath && file_exists($fullImagePath) && strpos($fullImagePath, realpath(__DIR__)) === 0) {
    $mimeType = mime_content_type($fullImagePath);
    header("Content-Type: $mimeType");
    readfile($fullImagePath);
    exit;
} else {
    http_response_code(404);
    echo json_encode(array('error' => 'Image not found'));
}
?>
