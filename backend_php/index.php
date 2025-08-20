<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'config/database.php';
require_once 'config/firebase.php';
require_once 'middleware/cors.php';
require_once 'middleware/auth.php';

// Get the request URI and method
$request_uri = $_SERVER['REQUEST_URI'];
$request_method = $_SERVER['REQUEST_METHOD'];

// Remove query string and decode URL
$path = parse_url($request_uri, PHP_URL_PATH);
$path = urldecode($path);

// Remove base path if running in subdirectory
$base_path = '/api';
if (strpos($path, $base_path) === 0) {
    $path = substr($path, strlen($base_path));
}

// Route the request
try {
    switch ($path) {
        // Auth endpoints
        case '/auth/verify':
            if ($request_method === 'POST') {
                require 'endpoints/auth/verify.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        // Profile endpoints
        case '/profile/me':
            if ($request_method === 'GET') {
                require 'endpoints/profile/get.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        case '/profile/upsert':
            if ($request_method === 'POST') {
                require 'endpoints/profile/upsert.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        // Contact endpoint
        case '/contact':
            if ($request_method === 'POST') {
                require 'endpoints/contact/submit.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        // Admin endpoints
        case '/admin/users':
            if ($request_method === 'GET') {
                require 'endpoints/admin/users/list.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        case (preg_match('/^\/admin\/users\/(.+)$/', $path, $matches) ? true : false):
            if ($request_method === 'GET') {
                $uid = $matches[1];
                require 'endpoints/admin/users/get.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        case '/admin/contacts':
            if ($request_method === 'GET') {
                require 'endpoints/admin/contacts/list.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        case (preg_match('/^\/admin\/contacts\/(\d+)$/', $path, $matches) ? true : false):
            if ($request_method === 'DELETE') {
                $contact_id = $matches[1];
                require 'endpoints/admin/contacts/delete.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        case '/admin/add':
            if ($request_method === 'POST') {
                require 'endpoints/admin/add.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        case '/admin/remove':
            if ($request_method === 'POST') {
                require 'endpoints/admin/remove.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        case '/admin/notify':
            if ($request_method === 'POST') {
                require 'endpoints/admin/notify.php';
            } else {
                http_response_code(405);
                echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
            }
            break;
            
        default:
            http_response_code(404);
            echo json_encode(['ok' => false, 'error' => 'Endpoint not found']);
            break;
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'ok' => false,
        'error' => 'Internal server error: ' . $e->getMessage()
    ]);
}
?>

