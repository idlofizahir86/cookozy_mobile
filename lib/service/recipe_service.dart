import 'dart:convert';
import 'dart:io';
import 'package:cookozy_mobile/model/recipe_model.dart';
import 'package:http/http.dart' as http;

import '../model/recipe_detail_model.dart';

class RecipeService {
  final String baseUrl = "https://cookozy.web.app/api";

  Future<String?> uploadImage(File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload-image'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
        return jsonResponse['image_url'];
      } else {
        print('Upload failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Upload failed: $e');
      return null;
    }
  }

  Future<String?> postRecipe(
    String title,
    String description,
    String ingredients,
    String steps,
    String kategori,
    String kesulitan,
    String user_id,
    imageFile,
  ) async {
    try {
      // Upload image and get the URL
      final imageUrl = await uploadImage(imageFile);

      if (imageUrl == null) {
        print('Failed to upload image');
        return 'Failed to upload image';
      }

      // Proceed with posting the recipe with the uploaded image URL
      final response = await http.post(
        Uri.parse('$baseUrl/recipes'), // Make sure the URL is correct
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          {
            "title": title,
            "description": description,
            "ingredients": ingredients,
            "steps": steps,
            "level": kesulitan,
            "type": kategori,
            "user_id": user_id,
            "image_url": imageUrl,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse['message']; // Assuming the API returns a message
      } else {
        print('Post recipe failed: ${response.body}');
        return 'Post recipe failed: ${response.body}';
      }
    } catch (e) {
      print('Post recipe failed: $e');
      return 'Post recipe failed: $e';
    }
  }

  Future<List<RecipeModel>> fetchRecipes() async {
    final response = await http.get(Uri.parse('$baseUrl/recipes/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => RecipeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<RecipeDetailModel> fetchRecipeDetail(String recipeId) async {
    final response = await http.get(Uri.parse('$baseUrl/recipes/$recipeId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return RecipeDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
