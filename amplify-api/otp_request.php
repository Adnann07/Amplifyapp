<?php
// otp_request.php
require_once 'config.php';

// Expect JSON: { "phone": "8801XXXXXXXXX" }
$input = json_decode(file_get_contents('php://input'), true);

if (!$input || empty($input['phone'])) {
    json_response(['error' => 'Missing phone'], 400);
}

$msisdn = preg_replace('/\D+/', '', $input['phone']);
$subscriberId = 'tel:' . $msisdn;

$payload = [
    'applicationId'   => APPLINK_APP_ID,
    'password'        => APPLINK_API_KEY,
    'subscriberId'    => $subscriberId,
    'applicationHash' => 'AMPLIFY_APP',
    'applicationMetaData' => [
        'client' => 'MOBILEAPP',
        'device' => 'Unknown',
        'os'     => 'flutter',
        'appCode'=> 'https://play.google.com/store/apps/details?id=your.amplify.app'
    ]
];

$result = applink_post('/otp/request', $payload);

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

if (isset($data['statusCode']) && $data['statusCode'] === 'S1000' && !empty($data['referenceNo'])) {
    json_response([
        'referenceNo' => $data['referenceNo'],
        'statusCode'  => $data['statusCode'],
        'statusDetail'=> $data['statusDetail'] ?? null,
    ]);
}

json_response([
    'error'       => 'OTP request failed at Applink',
    'apiResponse' => $data,
], 502);
