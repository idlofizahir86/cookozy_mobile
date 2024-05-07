import 'dart:math';

import 'package:flutter/material.dart';

import '../../service/recipe_service.dart';
import 'recipe_card.dart';

class RecipeList extends StatelessWidget {
  final String recipeType;

  const RecipeList({
    Key? key,
    required this.recipeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
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
          final List<Map<String, dynamic>> allRecipes = snapshot.data ?? [];
          final List<Map<String, dynamic>> filteredRecipes = [];

          // Filter resep berdasarkan jenis
          final List<Map<String, dynamic>> recipesByType = allRecipes
              .where((recipe) => recipe['type'] == recipeType)
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
                        imageUrl: recipe['image_url'] ?? '',
                        userName: recipe['user_name'] ?? '',
                        title: recipe['title'] ?? '',
                        description: recipe['description'] ?? '',
                        level: recipe['level'] ?? '',
                        type: recipe['type'] ?? '',
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
            final Map<String, dynamic> randomRecipe = recipesByType[index];
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
                      imageUrl: recipe['image_url'] ?? '',
                      userName: recipe['user_name'] ?? '',
                      title: recipe['title'] ?? '',
                      description: recipe['description'] ?? '',
                      level: recipe['level'] ?? '',
                      type: recipe['type'] ?? '',
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
