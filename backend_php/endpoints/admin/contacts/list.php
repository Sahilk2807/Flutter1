<?php
try {
    requireAdmin();
    
    $db = getDB();
    
    // Get pagination parameters
    $page = max(1, intval($_GET['page'] ?? 1));
    $limit = min(MAX_PAGE_SIZE, max(1, intval($_GET['limit'] ?? DEFAULT_PAGE_SIZE)));
    $offset = ($page - 1) * $limit;
    
    // Get total count
    $totalResult = $db->fetchOne("SELECT COUNT(*) as total FROM gpe_contact_messages");
    $total = $totalResult['total'];
    
    // Get contact messages
    $contacts = $db->fetchAll(
        "SELECT id, name, email, message, created_at 
         FROM gpe_contact_messages 
         ORDER BY created_at DESC 
         LIMIT $limit OFFSET $offset"
    );
    
    echo json_encode([
        'ok' => true,
        'data' => [
            'contacts' => $contacts,
            'pagination' => [
                'page' => $page,
                'limit' => $limit,
                'total' => $total,
                'pages' => ceil($total / $limit)
            ]
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

