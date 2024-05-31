import 'dart:convert';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = "https://cookozy.web.app/api";

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept':
              'application/json', // Menentukan bahwa Anda ingin menerima respons dalam format JSON
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          return jsonResponse['token'];
        } catch (e) {
          // Penanganan ketika respons bukan JSON yang valid
          print('Login failed: Respons tidak valid');
          return null;
        }
      } else {
        print('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Login failed: $e');
      return null;
    }
  }

  Future<UserModel?> getUserData(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (userId == '') {
      return UserModel
          .empty(); // Atau null, tergantung bagaimana Anda ingin menangani kasus ini
    } else {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return UserModel.fromJson(data);
      } else {
        throw Exception('Failed to load user data');
      }
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
