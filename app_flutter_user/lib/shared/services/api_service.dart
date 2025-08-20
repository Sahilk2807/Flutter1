import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../core/constants/app_constants.dart';

class ApiService {
  static const String _baseUrl = AppConstants.baseUrl;
  
  static Future<Map<String, String>> _getHeaders() async {
    final user = FirebaseAuth.instance.currentUser;
    String? token;
    
    if (user != null) {
      token = await user.getIdToken();
    }
    
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Auth endpoints
  static Future<Map<String, dynamic>> verifyToken() async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/verify'),
        headers: headers,
      );
      
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to verify token: $e');
    }
  }

  // Profile endpoints
  static Future<UserModel?> getProfile() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/profile/me'),
        headers: headers,
      );
      
      final result = _handleResponse(response);
      
      if (result['ok'] == true && result['data'] != null) {
        return UserModel.fromJson(result['data']);
      }
      
      return null;
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  static Future<UserModel> upsertProfile({
    required String name,
    required String mobile,
    required String address,
    required String userClass,
  }) async {
    try {
      final headers = await _getHeaders();
      final body = jsonEncode({
        'name': name,
        'mobile': mobile,
        'address': address,
        'class': userClass,
      });
      
      final response = await http.post(
        Uri.parse('$_baseUrl/profile/upsert'),
        headers: headers,
        body: body,
      );
      
      final result = _handleResponse(response);
      
      if (result['ok'] == true && result['data'] != null) {
        return UserModel.fromJson(result['data']);
      }
      
      throw Exception('Failed to update profile');
    } catch (e) {
      throw Exception('Failed to upsert profile: $e');
    }
  }

  // Contact endpoint
  static Future<void> submitContact({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final headers = await _getHeaders();
      final body = jsonEncode({
        'name': name,
        'email': email,
        'message': message,
      });
      
      final response = await http.post(
        Uri.parse('$_baseUrl/contact'),
        headers: headers,
        body: body,
      );
      
      final result = _handleResponse(response);
      
      if (result['ok'] != true) {
        throw Exception(result['error'] ?? 'Failed to submit contact');
      }
    } catch (e) {
      throw Exception('Failed to submit contact: $e');
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['error'] ?? 'HTTP ${response.statusCode}');
    }
  }
}

