# GP SIR EDUCATION - Complete Monorepo

A complete Flutter + PHP education platform with user app, admin panel, and backend APIs.

## Project Structure

```
gp-edu-monorepo/
├── app_flutter_user/        # Student-facing Flutter app
├── app_flutter_admin/       # Admin panel Flutter app  
├── backend_php/             # PHP APIs + MySQL
├── docs/                    # Deployment guides
└── README.md               # This file
```

## Quick Start

### 1. Backend Setup
```bash
cd backend_php
# Upload to InfinityFree or deploy to Render
# Import database schema from schema.sql
# Configure .env.php with your settings
```

### 2. User App
```bash
cd app_flutter_user
flutter pub get
flutter run
# For APK: flutter build apk
# For PWA: flutter build web
```

### 3. Admin App
```bash
cd app_flutter_admin
flutter pub get
flutter run
# For APK: flutter build apk
# For PWA: flutter build web
```

## Features

### User App
- Firebase Authentication (Email/Password, Google, Passwordless)
- Profile completion gate
- Protected routes
- Static pages (About, Contact, Privacy)
- Material 3 + Riverpod state management
- PWA support
- Push notifications

### Admin App
- Admin authentication
- User management
- Contact message management
- Admin management
- Push notification broadcasting
- Dashboard with analytics

### Backend
- Firebase token verification
- User profile management
- Contact form handling
- Admin role management
- FCM push notifications
- CORS enabled

## Documentation

See the `/docs` folder for detailed deployment guides:
- Firebase setup
- Mobile app building
- Backend deployment
- Database configuration

## Tech Stack

- **Frontend:** Flutter (Dart) with Material 3
- **State Management:** Riverpod
- **Routing:** go_router
- **Authentication:** Firebase Auth
- **Notifications:** Firebase Cloud Messaging
- **Backend:** PHP + MySQL
- **Deployment:** InfinityFree/Render compatible

## License

MIT License - see LICENSE file for details.

