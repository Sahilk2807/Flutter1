import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/screens/auth_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/profile/screens/profile_completion_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/courses/screens/courses_screen.dart';
import '../../features/courses/screens/lectures_screen.dart';
import '../../features/static_pages/screens/about_screen.dart';
import '../../features/static_pages/screens/contact_screen.dart';
import '../../features/static_pages/screens/privacy_screen.dart';
import '../../shared/providers/auth_provider.dart';
import '../constants/app_constants.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authProvider);
  final userProfile = ref.watch(userProfileProvider);
  
  return GoRouter(
    initialLocation: AppConstants.splashRoute,
    redirect: (context, state) {
      final isLoggedIn = authState != null;
      final hasProfile = userProfile?.isProfileComplete == true;
      final currentPath = state.uri.path;
      
      // Static pages are always accessible
      if (currentPath == AppConstants.aboutRoute ||
          currentPath == AppConstants.contactRoute ||
          currentPath == AppConstants.privacyRoute) {
        return null;
      }
      
      // If not logged in, redirect to auth (except splash)
      if (!isLoggedIn) {
        if (currentPath != AppConstants.splashRoute && 
            currentPath != AppConstants.authRoute) {
          return AppConstants.authRoute;
        }
        return null;
      }
      
      // If logged in but no profile, redirect to profile completion
      if (isLoggedIn && !hasProfile) {
        if (currentPath != AppConstants.profileRoute) {
          return AppConstants.profileRoute;
        }
        return null;
      }
      
      // If logged in with profile, redirect away from auth/profile screens
      if (isLoggedIn && hasProfile) {
        if (currentPath == AppConstants.authRoute || 
            currentPath == AppConstants.profileRoute ||
            currentPath == AppConstants.splashRoute) {
          return AppConstants.homeRoute;
        }
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppConstants.authRoute,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppConstants.profileRoute,
        builder: (context, state) => const ProfileCompletionScreen(),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppConstants.coursesRoute,
        builder: (context, state) => const CoursesScreen(),
      ),
      GoRoute(
        path: AppConstants.lecturesRoute,
        builder: (context, state) => const LecturesScreen(),
      ),
      GoRoute(
        path: AppConstants.aboutRoute,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: AppConstants.contactRoute,
        builder: (context, state) => const ContactScreen(),
      ),
      GoRoute(
        path: AppConstants.privacyRoute,
        builder: (context, state) => const PrivacyScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.homeRoute),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

