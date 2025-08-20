<?php
require_once 'env.php';

function verifyFirebaseToken($idToken) {
    // Simple JWT verification without external libraries
    // For production, consider using Firebase Admin SDK or a JWT library
    
    $parts = explode('.', $idToken);
    if (count($parts) !== 3) {
        throw new Exception('Invalid token format');
    }
    
    $header = json_decode(base64UrlDecode($parts[0]), true);
    $payload = json_decode(base64UrlDecode($parts[1]), true);
    
    if (!$header || !$payload) {
        throw new Exception('Invalid token structure');
    }
    
    // Basic validation
    if (!isset($payload['iss']) || !isset($payload['aud']) || !isset($payload['exp'])) {
        throw new Exception('Missing required claims');
    }
    
    // Check expiration
    if ($payload['exp'] < time()) {
        throw new Exception('Token expired');
    }
    
    // Check issuer
    $expectedIssuer = 'https://securetoken.google.com/' . FIREBASE_PROJECT_ID;
    if ($payload['iss'] !== $expectedIssuer) {
        throw new Exception('Invalid issuer');
    }
    
    // Check audience
    if ($payload['aud'] !== FIREBASE_PROJECT_ID) {
        throw new Exception('Invalid audience');
    }
    
    // For production, verify signature using Firebase public keys
    // This is a simplified version for demonstration
    
    return [
        'uid' => $payload['sub'] ?? $payload['user_id'],
        'email' => $payload['email'] ?? null,
        'email_verified' => $payload['email_verified'] ?? false,
        'name' => $payload['name'] ?? null,
        'picture' => $payload['picture'] ?? null,
        'claims' => $payload
    ];
}

function base64UrlDecode($data) {
    return base64_decode(str_pad(strtr($data, '-_', '+/'), strlen($data) % 4, '=', STR_PAD_RIGHT));
}

function sendFCMNotification($tokens, $title, $body, $data = []) {
    if (empty($tokens)) {
        return ['success' => false, 'error' => 'No tokens provided'];
    }
    
    $url = 'https://fcm.googleapis.com/fcm/send';
    
    $notification = [
        'title' => $title,
        'body' => $body,
        'sound' => 'default'
    ];
    
    $fields = [
        'registration_ids' => is_array($tokens) ? $tokens : [$tokens],
        'notification' => $notification,
        'data' => $data
    ];
    
    $headers = [
        'Authorization: key=' . FCM_SERVER_KEY,
        'Content-Type: application/json'
    ];
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
    
    $result = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode === 200) {
        return ['success' => true, 'response' => json_decode($result, true)];
    } else {
        return ['success' => false, 'error' => 'FCM request failed', 'response' => $result];
    }
}
?>

