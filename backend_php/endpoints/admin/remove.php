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
    if (empty($input['firebase_uid'])) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Firebase UID is required']);
        exit();
    }
    
    $firebase_uid = $input['firebase_uid'];
    
    $db = getDB();
    
    // Check if admin exists
    $admin = $db->fetchOne(
        "SELECT firebase_uid FROM gpe_admins WHERE firebase_uid = ?",
        [$firebase_uid]
    );
    
    if (!$admin) {
        http_response_code(404);
        echo json_encode(['ok' => false, 'error' => 'Admin not found']);
        exit();
    }
    
    // Remove admin
    $deleted = $db->execute(
        "DELETE FROM gpe_admins WHERE firebase_uid = ?",
        [$firebase_uid]
    );
    
    if ($deleted > 0) {
        echo json_encode([
            'ok' => true,
            'data' => [
                'message' => 'Admin removed successfully',
                'firebase_uid' => $firebase_uid
            ]
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['ok' => false, 'error' => 'Failed to remove admin']);
    }
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}
?>

