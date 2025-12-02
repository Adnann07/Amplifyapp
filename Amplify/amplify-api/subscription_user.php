<?php
// subscription_user.php
require_once 'config.php';

// Expect JSON: { "phone": "8801...", "action": 1 }  // 1 = subscribe, 0 = unsubscribe
$input = json_decode(file_get_contents('php://input'), true);

if (!$input || !isset($input['phone']) || !isset($input['action'])) {
    json_response(['error' => 'Missing phone or action'], 400);
}

$msisdn = preg_replace('/\D+/', '', $input['phone']);
$subscriberId = 'tel:' . $msisdn;

$action = (string) intval($input['action']); // "0" or "1"

$payload = [
    'applicationId' => APPLINK_APP_ID,
    'password'      => APPLINK_API_KEY,
    'subscriberId'  => $subscriberId,
    'action'        => $action,
];

$result = applink_post('/subscription/send', $payload);

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

json_response([
    'statusCode'         => $data['statusCode'] ?? null,
    'statusDetail'       => $data['statusDetail'] ?? null,
    'subscriptionStatus' => $data['subscriptionStatus'] ?? null,
    'raw'                => $data,
]);
