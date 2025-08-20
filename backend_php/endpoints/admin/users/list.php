<?php
try {
    requireAdmin();
    
    $db = getDB();
    
    // Get pagination parameters
    $page = max(1, intval($_GET['page'] ?? 1));
    $limit = min(MAX_PAGE_SIZE, max(1, intval($_GET['limit'] ?? DEFAULT_PAGE_SIZE)));
    $offset = ($page - 1) * $limit;
    
    // Get search parameter
    $search = $_GET['search'] ?? '';
    
    // Build query
    $whereClause = '';
    $params = [];
    
    if (!empty($search)) {
        $whereClause = "WHERE name LIKE ? OR email LIKE ? OR mobile LIKE ?";
        $searchTerm = "%$search%";
        $params = [$searchTerm, $searchTerm, $searchTerm];
    }
    
    // Get total count
    $totalQuery = "SELECT COUNT(*) as total FROM gpe_users $whereClause";
    $totalResult = $db->fetchOne($totalQuery, $params);
    $total = $totalResult['total'];
    
    // Get users
    $usersQuery = "SELECT firebase_uid, email, name, mobile, address, class, created_at, updated_at 
                   FROM gpe_users $whereClause 
                   ORDER BY created_at DESC 
                   LIMIT $limit OFFSET $offset";
    $users = $db->fetchAll($usersQuery, $params);
    
    echo json_encode([
        'ok' => true,
        'data' => [
            'users' => $users,
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

