<?php
try {
    requireAdmin();
    
    if (!isset($contact_id) || empty($contact_id)) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Contact ID is required']);
        exit();
    }
    
    $db = getDB();
    
    // Check if contact exists
    $contact = $db->fetchOne(
        "SELECT id FROM gpe_contact_messages WHERE id = ?",
        [$contact_id]
    );
    
    if (!$contact) {
        http_response_code(404);
        echo json_encode(['ok' => false, 'error' => 'Contact message not found']);
        exit();
    }
    
    // Delete contact message
    $deleted = $db->execute(
        "DELETE FROM gpe_contact_messages WHERE id = ?",
        [$contact_id]
    );
    
    if ($deleted > 0) {
        echo json_encode([
            'ok' => true,
            'data' => [
                'message' => 'Contact message deleted successfully'
            ]
        ]);
    } else {
        http_response_code(500);
        echo json_encode(['ok' => false, 'error' => 'Failed to delete contact message']);
    }
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}
?>

