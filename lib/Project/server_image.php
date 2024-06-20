<?php
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: X-Requested-With, Content-Type, Accept");
header("Access-Control-Allow-Origin: *");

// Path to the image (relative path from 'upload' folder)
$imagePath = isset($_GET['path']) ? $_GET['path'] : '';

if ($imagePath) {
    // Decode URL-encoded path
    $imagePath = urldecode($imagePath);
    
    // Ensure the path is relative to the 'upload' directory
    $imagePath = basename($imagePath);

    // Construct the full path to the image
    $fullImagePath = realpath(__DIR__ . '/upload/' . $imagePath);

    // Log the path for debugging
    file_put_contents(__DIR__ . '/debug.log', "Requested Path: $imagePath\nFull Image Path: $fullImagePath\n", FILE_APPEND);

    // Check if file exists and the path is valid
    if ($fullImagePath && file_exists($fullImagePath) && strpos($fullImagePath, realpath(__DIR__ . '/upload')) === 0) {
        $mimeType = mime_content_type($fullImagePath);
        header("Content-Type: $mimeType");
        readfile($fullImagePath);
        exit;
    } else {
        http_response_code(404);
        echo json_encode(array('error' => 'Image not found'));
    }
} else {
    http_response_code(400);
    echo json_encode(array('error' => 'No image path provided'));
}
?>
