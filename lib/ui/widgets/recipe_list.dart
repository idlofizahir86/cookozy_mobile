import 'dart:math';

import 'package:cookozy_mobile/model/recipe_model.dart';
import 'package:flutter/material.dart';

import '../../service/recipe_service.dart';
import 'recipe_card.dart';

class RecipeList extends StatelessWidget {
  final String recipeType;

  const RecipeList({
    super.key,
    required this.recipeType,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecipeModel>>(
      future: fetchRecipes(),
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 241,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<RecipeModel> allRecipes = snapshot.data ?? [];
          final List<RecipeModel> filteredRecipes = [];

          // Filter resep berdasarkan jenis
          final List<RecipeModel> recipesByType = allRecipes
              .where((recipe) =>
                  recipe.type == recipeType && recipe.verified == true)
              .toList();

          // Jika jumlah resep berdasarkan jenis kurang dari 5, tampilkan semua resep yang tersedia
          if (recipesByType.length < 5) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Row(
                    children: recipesByType.map((recipe) {
                      return RecipeCard(
                        recipe: recipe,
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }

          // Ambil 5 indeks acak dari resep berdasarkan jenis
          final Set<int> randomIndexes = {};
          final random = Random();
          while (randomIndexes.length < 5) {
            final int randomIndex = random.nextInt(recipesByType.length);
            randomIndexes.add(randomIndex);
          }

          // Ambil resep sesuai dengan indeks yang telah dipilih
          for (var index in randomIndexes) {
            final RecipeModel randomRecipe = recipesByType[index];
            filteredRecipes.add(randomRecipe);
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 20),
                Row(
                  children: filteredRecipes.map((recipe) {
                    return RecipeCard(
                      recipe: recipe,
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
