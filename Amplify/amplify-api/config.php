<?php
// config.php

// TODO: set this to the real Applink base URL, e.g. "https://applink.yourtelco.com"
define('APPLINK_BASE_URL', 'https://applink.example.com');

// TODO: set these from your Applink portal
define('APPLINK_APP_ID',  'APP_XXXXXX');
define('APPLINK_API_KEY', 'YOUR_API_KEY_HERE');

function json_response($data, $statusCode = 200) {
    http_response_code($statusCode);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data);
    exit;
}

function applink_post($path, $payload) {
    $url  = rtrim(APPLINK_BASE_URL, '/') . $path;
    $json = json_encode($payload);

    file_put_contents(
        'debug.log',
        "=== REQUEST $path ===\nTime: " . date('Y-m-d H:i:s') . "\nURL: $url\nPayload: $json\n",
        FILE_APPEND
    );

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => $json,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER     => [
            'Content-Type: application/json;charset=utf-8',
            'Content-Length: ' . strlen($json),
        ],
        CURLOPT_TIMEOUT        => 30,
        CURLOPT_SSL_VERIFYPEER => false, // enable in prod
    ]);

    $responseJson = curl_exec($ch);
    $httpCode     = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError    = curl_error($ch);
    curl_close($ch);

    file_put_contents(
        'debug.log',
        "HTTP Code: $httpCode\ncURL Error: $curlError\nRaw Response: $responseJson\n=== END $path ===\n\n",
        FILE_APPEND
    );

    return [
        'httpCode'  => $httpCode,
        'curlError' => $curlError,
        'raw'       => $responseJson,
        'data'      => json_decode($responseJson, true),
    ];
}
