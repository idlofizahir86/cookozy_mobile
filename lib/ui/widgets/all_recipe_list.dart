import 'package:cookozy_mobile/model/recipe_model.dart';
import 'package:cookozy_mobile/shared/theme.dart';
import 'package:flutter/material.dart';
import '../../service/recipe_service.dart';
import 'recipe_card.dart';

class AllRecipeList extends StatelessWidget {
  final String type;
  final String userId;

  const AllRecipeList({
    super.key,
    this.type = "",
    this.userId = '',
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecipeModel>>(
      future: RecipeService().fetchRecipes(),
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
        } else if (userId == '') {
          final List<RecipeModel> allRecipes = snapshot.data ?? [];
          List<RecipeModel> recipesByType = allRecipes;
          if (type == "") {
            recipesByType =
                allRecipes.where((recipe) => recipe.verified == true).toList();
          } else {
            recipesByType = allRecipes
                .where(
                  (recipe) => recipe.verified == true && recipe.type == type,
                )
                .toList();
          }
          // Filter resep berdasarkan jenis yang terverifikasi

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
                    marginRight: 5,
                    marginLeft: 5,
                    recipe: recipe,
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              );
            },
          );
        } else {
          final List<RecipeModel> allRecipes = snapshot.data ?? [];
          List<RecipeModel> filteredRecipes = allRecipes;
          filteredRecipes = allRecipes
              .where(
                (recipe) => recipe.userId == userId,
              )
              .toList();

          return filteredRecipes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Agar kolom hanya sebesar yang diperlukan
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 201,
                        child: Image.asset(
                          "assets/cook_onboard.png",
                        ),
                      ),
                      SizedBox(
                        height: 79,
                        child: Image.asset(
                          "assets/cookozy-logo.png",
                        ),
                      ),
                      Text(
                        "Anda belum pernah membagikan resep",
                        style: boldTextStyle.copyWith(
                          fontSize: 20,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2; // Default untuk layar kecil

                    if (constraints.maxWidth >= 1200) {
                      crossAxisCount =
                          4; // Maksimal 4 kolom untuk layar sangat lebar
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
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, index) {
                        var recipe = filteredRecipes[index];
                        return RecipeCard(
                          marginRight: 5,
                          marginLeft: 5,
                          recipe: recipe,
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
