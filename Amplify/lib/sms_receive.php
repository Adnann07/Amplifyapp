<?php
// sms_receive.php - Deploy to http://18.206.193.105/sms_receive.php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

$input = json_decode(file_get_contents('php://input'), true);

if ($input) {
    $log = date('Y-m-d H:i:s') . " - From: {$input['sourceAddress']} - Msg: {$input['message']}\n";
    file_put_contents('sms_log.txt', $log, FILE_APPEND | LOCK_EX);
    
    echo json_encode([
        "statusCode" => "S1000",
        "statusDetail" => "Success."
    ]);
} else {
    echo json_encode([
        "statusCode" => "E1000",
        "statusDetail" => "Invalid input"
    ]);
}
?>
