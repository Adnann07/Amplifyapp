<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$input = json_decode(file_get_contents('php://input'), true);

if ($input && isset($input['action'])) {
    $action = $input['action'];
    
    if ($action === 'request_otp') {
        $url = 'https://api.applink.com.bd/otp/request';
        $data = [
            'applicationId' => $input['applicationId'],
            'password' => $input['password'],
            'subscriberId' => $input['subscriberId']
        ];
    } elseif ($action === 'verify_otp') {
        $url = 'https://api.applink.com.bd/otp/verify';
        $data = [
            'applicationId' => $input['applicationId'],
            'password' => $input['password'],
            'referenceNo' => $input['referenceNo'],
            'otp' => $input['otp']
        ];
    } else {
        echo json_encode(['error' => 'Invalid action']);
        exit;
    }
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json;charset=utf-8']);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
    $response = curl_exec($ch);
    curl_close($ch);
    
    echo $response;
} else {
    echo json_encode(['error' => 'Invalid request']);
}
?>
