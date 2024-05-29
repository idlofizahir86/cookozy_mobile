import 'dart:convert';
import 'package:cookozy_mobile/model/recipe_model.dart';
import 'package:http/http.dart' as http;

import '../model/recipe_detail_model.dart';

Future<List<RecipeModel>> fetchRecipes() async {
  final response =
      await http.get(Uri.parse('https://cookozy.web.app/api/recipes/'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((json) => RecipeModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}



Future<RecipeDetailModel> fetchRecipeDetail(String recipeId) async {
  final response = await http
      .get(Uri.parse('https://cookozy.web.app/api/recipes/$recipeId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data'];
    return RecipeDetailModel.fromJson(data);
  } else {
    throw Exception('Failed to load recipes');
  }
}
