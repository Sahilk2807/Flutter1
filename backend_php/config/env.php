<?php
// Database Configuration
define('DB_HOST', 'localhost');
define('DB_NAME', 'gp_sir_education');
define('DB_USER', 'your_db_user');
define('DB_PASS', 'your_db_password');

// Firebase Configuration
define('FIREBASE_PROJECT_ID', 'gp-sir-education');
define('FIREBASE_WEB_API_KEY', 'AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

// FCM Configuration
define('FCM_SERVER_KEY', 'your_fcm_server_key');

// App Configuration
define('APP_ENV', 'production'); // development, staging, production
define('APP_DEBUG', false);
define('APP_URL', 'https://your-domain.com');

// CORS Configuration
define('ALLOWED_ORIGINS', [
    'http://localhost:3000',
    'https://your-frontend-domain.com',
    'https://gp-sir-education.web.app'
]);

// Rate Limiting
define('RATE_LIMIT_REQUESTS', 100);
define('RATE_LIMIT_WINDOW', 3600); // 1 hour in seconds

// File Upload
define('MAX_FILE_SIZE', 10 * 1024 * 1024); // 10MB
define('UPLOAD_PATH', 'uploads/');

// Pagination
define('DEFAULT_PAGE_SIZE', 20);
define('MAX_PAGE_SIZE', 100);
?>

