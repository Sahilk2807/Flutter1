<?php
try {
    $decodedToken = requireAuth();
    $uid = $decodedToken['uid'];
    
    $db = getDB();
    $user = $db->fetchOne(
        "SELECT firebase_uid, email, name, mobile, address, class, created_at, updated_at 
         FROM gpe_users WHERE firebase_uid = ?",
        [$uid]
    );
    
    if ($user) {
        echo json_encode([
            'ok' => true,
            'data' => $user
        ]);
    } else {
        echo json_encode([
            'ok' => true,
            'data' => null
        ]);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}
?>

