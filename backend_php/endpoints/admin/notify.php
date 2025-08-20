<?php
try {
    requireAdmin();
    
    // Get JSON input
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid JSON input']);
        exit();
    }
    
    // Validate required fields
    if (empty($input['title']) || empty($input['body'])) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Title and body are required']);
        exit();
    }
    
    $title = $input['title'];
    $body = $input['body'];
    $data = $input['data'] ?? [];
    $target = $input['target'] ?? 'all'; // all, class, specific_users
    
    $db = getDB();
    
    // Get FCM tokens based on target
    $tokens = [];
    
    if ($target === 'all') {
        // Send to all users
        $tokenResults = $db->fetchAll(
            "SELECT DISTINCT token FROM gpe_fcm_tokens WHERE token IS NOT NULL"
        );
        $tokens = array_column($tokenResults, 'token');
    } elseif ($target === 'class' && !empty($input['class'])) {
        // Send to specific class
        $tokenResults = $db->fetchAll(
            "SELECT DISTINCT t.token 
             FROM gpe_fcm_tokens t
             JOIN gpe_users u ON t.firebase_uid = u.firebase_uid
             WHERE u.class = ? AND t.token IS NOT NULL",
            [$input['class']]
        );
        $tokens = array_column($tokenResults, 'token');
    } elseif ($target === 'specific_users' && !empty($input['user_ids'])) {
        // Send to specific users
        $placeholders = str_repeat('?,', count($input['user_ids']) - 1) . '?';
        $tokenResults = $db->fetchAll(
            "SELECT DISTINCT token 
             FROM gpe_fcm_tokens 
             WHERE firebase_uid IN ($placeholders) AND token IS NOT NULL",
            $input['user_ids']
        );
        $tokens = array_column($tokenResults, 'token');
    }
    
    if (empty($tokens)) {
        echo json_encode([
            'ok' => true,
            'data' => [
                'message' => 'No tokens found for the specified target',
                'sent_count' => 0
            ]
        ]);
        exit();
    }
    
    // Send FCM notification
    $result = sendFCMNotification($tokens, $title, $body, $data);
    
    if ($result['success']) {
        $response = $result['response'];
        echo json_encode([
            'ok' => true,
            'data' => [
                'message' => 'Notification sent successfully',
                'sent_count' => $response['success'] ?? 0,
                'failed_count' => $response['failure'] ?? 0,
                'total_tokens' => count($tokens)
            ]
        ]);
    } else {
        http_response_code(500);
        echo json_encode([
            'ok' => false,
            'error' => 'Failed to send notification: ' . $result['error']
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

