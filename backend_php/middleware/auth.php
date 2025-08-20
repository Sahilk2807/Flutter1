<?php
require_once 'config/firebase.php';

function requireAuth() {
    $headers = getallheaders();
    $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? null;
    
    if (!$authHeader || !preg_match('/Bearer\s+(.*)$/i', $authHeader, $matches)) {
        http_response_code(401);
        echo json_encode(['ok' => false, 'error' => 'Authorization header missing']);
        exit();
    }
    
    $token = $matches[1];
    
    try {
        $decodedToken = verifyFirebaseToken($token);
        return $decodedToken;
    } catch (Exception $e) {
        http_response_code(401);
        echo json_encode(['ok' => false, 'error' => 'Invalid token: ' . $e->getMessage()]);
        exit();
    }
}

function requireAdmin() {
    $decodedToken = requireAuth();
    $uid = $decodedToken['uid'];
    
    $db = getDB();
    $admin = $db->fetchOne(
        "SELECT firebase_uid FROM gpe_admins WHERE firebase_uid = ?",
        [$uid]
    );
    
    if (!$admin) {
        http_response_code(403);
        echo json_encode(['ok' => false, 'error' => 'Admin access required']);
        exit();
    }
    
    return $decodedToken;
}

function getAuthUser() {
    $headers = getallheaders();
    $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? null;
    
    if (!$authHeader || !preg_match('/Bearer\s+(.*)$/i', $authHeader, $matches)) {
        return null;
    }
    
    $token = $matches[1];
    
    try {
        return verifyFirebaseToken($token);
    } catch (Exception $e) {
        return null;
    }
}
?>

