import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Replace this with your computer's actual IPv4 address
static const String baseUrl = 'http://192.168.100.93:8000';

  // --- SIGN UP FUNCTION ---
  static Future<Map<String, dynamic>> signUp(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Account created successfully!'};
      } else {
        final errorData = jsonDecode(response.body);
        return {'success': false, 'message': errorData['detail'] ?? 'Sign up failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error. Check your connection.'};
    }
  }

  // --- LOG IN FUNCTION ---
  static Future<Map<String, dynamic>> logIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // --- NEW: SAVE TO LONG-TERM MEMORY ---
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', data['user']['id']);
        await prefs.setString('userName', data['user']['name']);

        return {'success': true, 'user': data['user']};
      } else {
        return {'success': false, 'message': 'Invalid email or password'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error. Check your connection.'};
    }
  }

  // --- NEW: FETCH REFLECTIONS FUNCTION ---
  static Future<List<dynamic>> getReflections() async {
    try {
      // 1. Get the user ID we saved during login
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null) return []; // If no one is logged in, return empty

      // 2. Ask FastAPI for this specific user's reflections
      final response = await http.get(Uri.parse('$baseUrl/reflections/$userId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      }
    } catch (e) {
      print("Error fetching reflections: $e");
    }
    return [];
  }
}