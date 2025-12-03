<?php
header('Content-Type: application/json;charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Enable error logging
ini_set('display_errors', 1);
error_reporting(E_ALL);

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$raw = file_get_contents('php://input');
$input = json_decode($raw, true);

// Log incoming request
error_log("OTP Proxy Request: " . print_r($input, true));

if (!$input || !isset($input['action'])) {
    echo json_encode(['statusCode' => 'E0001', 'statusDetail' => 'Invalid request']);
    exit;
}

$action = $input['action'];
$baseApiUrl = 'https://api.applink.com.bd';

if ($action === 'request_otp') {
    $url = $baseApiUrl . '/otp/request';

    $data = [
        'applicationId' => $input['applicationId'],
        'password'      => $input['password'],
        'subscriberId'  => $input['subscriberId'],
    ];

    // Log exact data being sent
    error_log("Sending to AppLink: " . json_encode($data));

} elseif ($action === 'verify_otp') {
    $url = $baseApiUrl . '/otp/verify';

    $data = [
        'applicationId' => $input['applicationId'],
        'password'      => $input['password'],
        'referenceNo'   => $input['referenceNo'],
        'otp'           => $input['otp'],
    ];

    error_log("Verifying OTP: " . json_encode($data));

} else {
    echo json_encode(['statusCode' => 'E0002', 'statusDetail' => 'Invalid action']);
    exit;
}

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json;charset=utf-8']);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 15);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if ($response === false) {
    $err = curl_error($ch);
    curl_close($ch);
    error_log("cURL Error: " . $err);
    echo json_encode(['statusCode' => 'E0003', 'statusDetail' => 'cURL error: ' . $err]);
    exit;
}

curl_close($ch);

// Log AppLink response
error_log("AppLink Response (HTTP $httpCode): " . $response);

echo $response;
