<?php
// otp_verify.php
require_once 'config.php';

// Expect JSON: { "referenceNo": "...", "otp": "123456" }
$input = json_decode(file_get_contents('php://input'), true);

if (!$input || empty($input['referenceNo']) || empty($input['otp'])) {
    json_response(['error' => 'Missing referenceNo or otp'], 400);
}

$payload = [
    'applicationId' => APPLINK_APP_ID,
    'password'      => APPLINK_API_KEY,
    'referenceNo'   => $input['referenceNo'],
    'otp'           => $input['otp'],
];

$result = applink_post('/otp/verify', $payload);

if ($result['curlError']) {
    json_response(['error' => 'cURL error: ' . $result['curlError']], 500);
}
if ($result['httpCode'] !== 200 || !is_array($result['data'])) {
    json_response([
        'error'    => 'HTTP error or invalid JSON from Applink',
        'httpCode' => $result['httpCode'],
        'raw'      => $result['raw'],
    ], 502);
}

$data = $result['data'];

if (isset($data['statusCode']) && $data['statusCode'] === 'S1000') {
    json_response([
        'statusCode'         => $data['statusCode'],
        'statusDetail'       => $data['statusDetail'] ?? null,
        'subscriptionStatus' => $data['subscriptionStatus'] ?? null,
        'subscriberId'       => $data['subscriberId'] ?? null,
    ]);
}

json_response([
    'error'       => 'OTP verification failed at Applink',
    'apiResponse' => $data,
], 502);
