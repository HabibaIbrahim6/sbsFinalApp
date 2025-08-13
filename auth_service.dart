import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;
  String? _userEmail;
  String? _token;

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get token => _token;

  // عنوان API الأساسي
  static const String _baseUrl = 'https://your-api-domain.com/api';

  // تسجيل الدخول
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _isLoggedIn = true;
        _userName = data['user']['name'];
        _userEmail = data['user']['email'];
        _token = data['token'];
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // إنشاء حساب
  Future<bool> signup(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        _isLoggedIn = true;
        _userName = data['user']['name'];
        _userEmail = data['user']['email'];
        _token = data['token'];
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    try {
      if (_token != null) {
        await http.post(
          Uri.parse('$_baseUrl/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token',
          },
        );
      }

      _isLoggedIn = false;
      _userName = null;
      _userEmail = null;
      _token = null;
      notifyListeners();
    } catch (e) {
      print('Logout error: $e');
    }
  }

  // التحقق من حالة المصادقة
  Future<bool> checkAuth() async {
    if (_token == null) return false;

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _isLoggedIn = true;
        _userName = data['name'];
        _userEmail = data['email'];
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Auth check error: $e');
      return false;
    }
  }
}