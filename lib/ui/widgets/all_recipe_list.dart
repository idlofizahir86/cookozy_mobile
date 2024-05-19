import 'package:flutter/material.dart';
import '../../service/recipe_service.dart';
import 'recipe_card.dart';

class AllRecipeList extends StatelessWidget {
  const AllRecipeList({
    super.key,
  });

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

          // Filter resep berdasarkan jenis yang terverifikasi
          final List<Map<String, dynamic>> recipesByType =
              allRecipes.where((recipe) => recipe['verified'] == true).toList();

          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2; // Default untuk layar kecil

              if (constraints.maxWidth >= 1200) {
                crossAxisCount = 4; // Maksimal 4 kolom untuk layar sangat lebar
              } else if (constraints.maxWidth >= 900) {
                crossAxisCount = 3; // 3 kolom untuk layar lebar
              } else if (constraints.maxWidth >= 600) {
                crossAxisCount = 2; // 2 kolom untuk layar sedang
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio:
                      2 / 3, // Sesuaikan rasio aspek sesuai kebutuhan
                ),
                itemCount: recipesByType.length,
                itemBuilder: (context, index) {
                  var recipe = recipesByType[index];
                  return RecipeCard(
                    imageUrl: recipe['image_url'] ?? '',
                    userName: recipe['user_name'] ?? '',
                    title: recipe['title'] ?? '',
                    description: recipe['description'] ?? '',
                    level: recipe['level'] ?? '',
                    type: recipe['type'] ?? '',
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              );
            },
          );
        }
      },
    );
  }
}
