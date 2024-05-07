import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchRecipes() async {
  final response =
      await http.get(Uri.parse('https://cookozy.web.app/api/recipes/'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load recipes');
  }
}
