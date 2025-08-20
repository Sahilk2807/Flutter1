<?php
try {
    // Get JSON input
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid JSON input']);
        exit();
    }
    
    // Validate required fields
    $required = ['name', 'email', 'message'];
    foreach ($required as $field) {
        if (empty($input[$field])) {
            http_response_code(400);
            echo json_encode(['ok' => false, 'error' => "Field '$field' is required"]);
            exit();
        }
    }
    
    // Validate email
    if (!filter_var($input['email'], FILTER_VALIDATE_EMAIL)) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid email format']);
        exit();
    }
    
    // Validate message length
    if (strlen($input['message']) < 10) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Message must be at least 10 characters']);
        exit();
    }
    
    $db = getDB();
    
    // Insert contact message
    $db->execute(
        "INSERT INTO gpe_contact_messages (name, email, message) VALUES (?, ?, ?)",
        [$input['name'], $input['email'], $input['message']]
    );
    
    echo json_encode([
        'ok' => true,
        'data' => [
            'message' => 'Contact message submitted successfully'
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

