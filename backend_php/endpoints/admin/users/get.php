<?php
try {
    requireAdmin();
    
    if (!isset($uid) || empty($uid)) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'User ID is required']);
        exit();
    }
    
    $db = getDB();
    
    // Get user details
    $user = $db->fetchOne(
        "SELECT firebase_uid, email, name, mobile, address, class, created_at, updated_at 
         FROM gpe_users WHERE firebase_uid = ?",
        [$uid]
    );
    
    if (!$user) {
        http_response_code(404);
        echo json_encode(['ok' => false, 'error' => 'User not found']);
        exit();
    }
    
    // Get user enrollments (if any)
    $enrollments = $db->fetchAll(
        "SELECT e.*, c.title as course_title, c.subject, c.class as course_class
         FROM gpe_user_enrollments e
         LEFT JOIN gpe_courses c ON e.course_id = c.id
         WHERE e.firebase_uid = ?
         ORDER BY e.enrolled_at DESC",
        [$uid]
    );
    
    echo json_encode([
        'ok' => true,
        'data' => [
            'user' => $user,
            'enrollments' => $enrollments
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

