<?php
try {
    $decodedToken = requireAuth();
    
    echo json_encode([
        'ok' => true,
        'data' => [
            'uid' => $decodedToken['uid'],
            'email' => $decodedToken['email'],
            'email_verified' => $decodedToken['email_verified'],
            'name' => $decodedToken['name']
        ]
    ]);
} catch (Exception $e) {
    http_response_code(401);
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}
?>

