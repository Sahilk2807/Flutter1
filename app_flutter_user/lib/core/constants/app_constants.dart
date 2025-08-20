class AppConstants {
  // App Info
  static const String appName = 'GP SIR EDUCATION MP BOARD';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://your-backend-domain.com/api';
  
  // Routes
  static const String splashRoute = '/';
  static const String authRoute = '/auth';
  static const String profileRoute = '/profile';
  static const String homeRoute = '/home';
  static const String coursesRoute = '/courses';
  static const String lecturesRoute = '/lectures';
  static const String aboutRoute = '/about';
  static const String contactRoute = '/contact';
  static const String privacyRoute = '/privacy';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userProfileKey = 'user_profile';
  static const String fcmTokenKey = 'fcm_token';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String coursesCollection = 'courses';
  static const String lecturesCollection = 'lectures';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxAddressLength = 200;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 12.0;
  static const double cardRadius = 16.0;
  static const double buttonRadius = 14.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Subjects
  static const List<String> subjects = [
    'All Subjects',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'English',
    'Hindi',
    'History',
    'Geography',
    'Economics',
    'Political Science',
  ];
  
  // Classes
  static const List<String> classes = [
    'Class 9',
    'Class 10',
    'Class 11',
    'Class 12',
  ];
  
  // Contact Info
  static const String supportEmail = 'support@gpsireducation.com';
  static const String supportPhone = '+91-9876543210';
  static const String websiteUrl = 'https://gpsireducation.com';
  
  // Social Media
  static const String facebookUrl = 'https://facebook.com/gpsireducation';
  static const String youtubeUrl = 'https://youtube.com/gpsireducation';
  static const String instagramUrl = 'https://instagram.com/gpsireducation';
}

