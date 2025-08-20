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
    $note = $input['note'] ?? '';
    
    $db = getDB();
    
    // Check if user exists
    $user = $db->fetchOne(
        "SELECT firebase_uid FROM gpe_users WHERE firebase_uid = ?",
        [$firebase_uid]
    );
    
    if (!$user) {
        http_response_code(404);
        echo json_encode(['ok' => false, 'error' => 'User not found']);
        exit();
    }
    
    // Check if already admin
    $existingAdmin = $db->fetchOne(
        "SELECT firebase_uid FROM gpe_admins WHERE firebase_uid = ?",
        [$firebase_uid]
    );
    
    if ($existingAdmin) {
        http_response_code(409);
        echo json_encode(['ok' => false, 'error' => 'User is already an admin']);
        exit();
    }
    
    // Add admin
    $db->execute(
        "INSERT INTO gpe_admins (firebase_uid, note) VALUES (?, ?)",
        [$firebase_uid, $note]
    );
    
    echo json_encode([
        'ok' => true,
        'data' => [
            'message' => 'Admin added successfully',
            'firebase_uid' => $firebase_uid
        ]
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}
?>

