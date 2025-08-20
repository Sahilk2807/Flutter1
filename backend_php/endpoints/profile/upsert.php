<?php
try {
    $decodedToken = requireAuth();
    $uid = $decodedToken['uid'];
    $email = $decodedToken['email'];
    
    // Get JSON input
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid JSON input']);
        exit();
    }
    
    // Validate required fields
    $required = ['name', 'mobile', 'address', 'class'];
    foreach ($required as $field) {
        if (empty($input[$field])) {
            http_response_code(400);
            echo json_encode(['ok' => false, 'error' => "Field '$field' is required"]);
            exit();
        }
    }
    
    // Validate mobile number
    if (!preg_match('/^[6-9]\d{9}$/', $input['mobile'])) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid mobile number format']);
        exit();
    }
    
    $db = getDB();
    
    // Check if user exists
    $existingUser = $db->fetchOne(
        "SELECT firebase_uid FROM gpe_users WHERE firebase_uid = ?",
        [$uid]
    );
    
    if ($existingUser) {
        // Update existing user
        $db->execute(
            "UPDATE gpe_users SET name = ?, mobile = ?, address = ?, class = ?, updated_at = NOW() 
             WHERE firebase_uid = ?",
            [$input['name'], $input['mobile'], $input['address'], $input['class'], $uid]
        );
    } else {
        // Insert new user
        $db->execute(
            "INSERT INTO gpe_users (firebase_uid, email, name, mobile, address, class) 
             VALUES (?, ?, ?, ?, ?, ?)",
            [$uid, $email, $input['name'], $input['mobile'], $input['address'], $input['class']]
        );
    }
    
    // Fetch updated user data
    $user = $db->fetchOne(
        "SELECT firebase_uid, email, name, mobile, address, class, created_at, updated_at 
         FROM gpe_users WHERE firebase_uid = ?",
        [$uid]
    );
    
    echo json_encode([
        'ok' => true,
        'data' => $user
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}
?>

