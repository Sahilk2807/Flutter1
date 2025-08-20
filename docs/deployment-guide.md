# GP SIR EDUCATION - Deployment Guide

This guide provides step-by-step instructions for deploying the complete GP SIR EDUCATION platform.

## Prerequisites

- Firebase project with Authentication and Cloud Messaging enabled
- MySQL database (local or cloud)
- Web hosting service (InfinityFree, Render, or similar)
- Flutter development environment
- PHP 7.4+ with MySQL support

## 1. Firebase Setup

### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project named "GP SIR EDUCATION"
3. Enable Authentication with Email/Password and Google providers
4. Enable Cloud Messaging for push notifications

### Configure Authentication
1. In Authentication > Sign-in method:
   - Enable Email/Password
   - Enable Google (add your domain)
   - Enable Email link (passwordless)
2. Add authorized domains for your web app

### Get Configuration Files
1. Add Android app and download `google-services.json`
2. Add iOS app and download `GoogleService-Info.plist`
3. Add Web app and copy configuration
4. Note down your project ID and Web API key

## 2. Database Setup

### Create MySQL Database
```sql
-- Create database
CREATE DATABASE gp_sir_education CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Import schema
mysql -u username -p gp_sir_education < backend_php/schema.sql
```

### Update Configuration
Edit `backend_php/config/env.php`:
```php
define('DB_HOST', 'your_db_host');
define('DB_NAME', 'gp_sir_education');
define('DB_USER', 'your_db_user');
define('DB_PASS', 'your_db_password');
define('FIREBASE_PROJECT_ID', 'your-project-id');
define('FCM_SERVER_KEY', 'your_fcm_server_key');
```

## 3. Backend Deployment

### Option A: InfinityFree
1. Create account at [InfinityFree](https://infinityfree.net/)
2. Upload `backend_php` folder contents to `htdocs/api/`
3. Create MySQL database in control panel
4. Update database credentials in `config/env.php`
5. Test API endpoints: `https://yoursite.infinityfreeapp.com/api/auth/verify`

### Option B: Render
1. Create account at [Render](https://render.com/)
2. Create new Web Service
3. Connect your GitHub repository
4. Set build command: `composer install` (if using Composer)
5. Set start command: `php -S 0.0.0.0:$PORT -t .`
6. Add environment variables from `env.php`

### Verify Backend
Test endpoints using curl or Postman:
```bash
curl -X POST https://your-api-domain.com/api/auth/verify \
  -H "Authorization: Bearer YOUR_FIREBASE_TOKEN"
```

## 4. Flutter User App Deployment

### Update Configuration
1. Replace Firebase configuration in `lib/core/config/firebase_options.dart`
2. Update API base URL in `lib/core/constants/app_constants.dart`
3. Add your domain to CORS allowed origins in backend

### Build for Android
```bash
cd app_flutter_user
flutter clean
flutter pub get
flutter build apk --release
```
APK location: `build/app/outputs/flutter-apk/app-release.apk`

### Build for Web (PWA)
```bash
flutter build web --release
```
Deploy `build/web` folder to your web hosting service.

### Build for iOS
```bash
flutter build ios --release
```
Use Xcode to archive and distribute to App Store.

## 5. Flutter Admin App Deployment

### Update Configuration
Same as user app - update Firebase config and API URLs.

### Build and Deploy
```bash
cd app_flutter_admin
flutter clean
flutter pub get
flutter build apk --release  # For Android
flutter build web --release  # For Web
```

## 6. Admin Setup

### Create First Admin
1. Register a user account in the user app
2. Get the Firebase UID from Firebase Console > Authentication
3. Update the database:
```sql
INSERT INTO gpe_admins (firebase_uid, note) VALUES ('your_firebase_uid', 'Super Admin');
```

### Test Admin Access
1. Login to admin app with the admin account
2. Verify access to dashboard and user management

## 7. Testing

### User App Testing
1. Register new account
2. Complete profile
3. Browse courses and lectures
4. Test contact form
5. Verify push notifications

### Admin App Testing
1. Login with admin account
2. View user list and details
3. Manage contact messages
4. Send test notifications
5. Add/remove admin users

## 8. Production Checklist

### Security
- [ ] Update all default passwords
- [ ] Enable HTTPS for all domains
- [ ] Configure proper CORS origins
- [ ] Set up rate limiting
- [ ] Enable Firebase security rules

### Performance
- [ ] Enable database indexing
- [ ] Configure CDN for static assets
- [ ] Optimize images and media
- [ ] Enable gzip compression
- [ ] Set up caching headers

### Monitoring
- [ ] Set up error logging
- [ ] Configure Firebase Analytics
- [ ] Monitor API performance
- [ ] Set up uptime monitoring
- [ ] Configure backup strategy

## 9. Maintenance

### Regular Tasks
- Monitor server resources and database performance
- Update Firebase SDK and Flutter dependencies
- Review and respond to contact messages
- Backup database regularly
- Monitor user feedback and app store reviews

### Updates
- Test all updates in staging environment
- Deploy backend updates first, then mobile apps
- Communicate maintenance windows to users
- Keep documentation updated

## 10. Troubleshooting

### Common Issues

**Firebase Authentication Errors**
- Verify project configuration
- Check authorized domains
- Ensure API keys are correct

**Database Connection Issues**
- Verify credentials and host
- Check firewall settings
- Ensure MySQL service is running

**CORS Errors**
- Add frontend domains to allowed origins
- Verify preflight request handling
- Check browser developer tools

**Push Notification Issues**
- Verify FCM server key
- Check token registration
- Test with Firebase Console

### Support
For technical support, contact: support@gpsireducation.com

## Appendix

### Useful Commands
```bash
# Flutter
flutter doctor
flutter clean && flutter pub get
flutter build apk --split-per-abi

# Database
mysqldump -u user -p gp_sir_education > backup.sql
mysql -u user -p gp_sir_education < backup.sql

# PHP
php -v
php -m | grep pdo_mysql
```

### Environment Variables
```
DB_HOST=localhost
DB_NAME=gp_sir_education
DB_USER=your_user
DB_PASS=your_password
FIREBASE_PROJECT_ID=your-project-id
FCM_SERVER_KEY=your_fcm_key
```

