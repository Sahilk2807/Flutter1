import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  User? build() {
    // Listen to auth state changes
    _auth.authStateChanges().listen((user) {
      state = user;
    });
    
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Google sign in was cancelled');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  Future<void> signInWithEmailLink(String email) async {
    try {
      final actionCodeSettings = ActionCodeSettings(
        url: 'https://gpsireducation.com/auth/verify',
        handleCodeInApp: true,
        androidPackageName: 'com.gpsir.education',
        iOSBundleId: 'com.gpsir.education',
      );

      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'operation-not-allowed':
        return 'This sign-in method is not allowed.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  UserModel? build() {
    return null;
  }

  Future<void> loadProfile() async {
    try {
      final profile = await ApiService.getProfile();
      state = profile;
    } catch (e) {
      // Profile might not exist yet, which is fine
      state = null;
    }
  }

  Future<void> updateProfile({
    required String name,
    required String mobile,
    required String address,
    required String userClass,
  }) async {
    try {
      final updatedProfile = await ApiService.upsertProfile(
        name: name,
        mobile: mobile,
        address: address,
        userClass: userClass,
      );
      state = updatedProfile;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  void clearProfile() {
    state = null;
  }
}

// Providers
final authProvider = AuthNotifierProvider();
final userProfileProvider = UserProfileNotifierProvider();

