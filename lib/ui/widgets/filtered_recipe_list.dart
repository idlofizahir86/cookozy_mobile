import 'package:cookozy_mobile/model/recipe_model.dart';
import 'package:flutter/material.dart';

import 'recipe_card.dart';

class FilteredRecipeList extends StatelessWidget {
  final List<RecipeModel> recipes;

  const FilteredRecipeList({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
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
            childAspectRatio: 2 / 3, // Sesuaikan rasio aspek sesuai kebutuhan
          ),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            var recipe = recipes[index];
            return RecipeCard(
              recipe: recipe,
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        );
      },
    );
  }
}
