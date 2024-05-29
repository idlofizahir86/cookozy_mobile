import 'package:cookozy_mobile/model/recipe_model.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../pages/recipes/recipe_detail_page.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final double marginTop;
  final double marginRight;
  final double marginLeft;

  const RecipeCard(
      {super.key,
      required this.recipe,
      this.marginLeft = 0,
      this.marginTop = 16,
      this.marginRight = 16});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeDetailPage(
                    recipe: recipe,
                  )),
        );
      },
      child: Container(
        width: 164,
        height: 241,
        margin: EdgeInsets.only(
          top: marginTop,
          right: marginRight,
          left: marginLeft,
        ),
        decoration: BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 109,
              width: 164,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: NetworkImage(recipe.imageUrl), // Gunakan NetworkImage
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 5,
                          left: 5,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          recipe.type,
                          style: boldTextStyle.copyWith(
                            fontSize: 11,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 5,
                          right: 5,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          recipe.level,
                          style: boldTextStyle.copyWith(
                            fontSize: 11,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    recipe.title,
                    textAlign: TextAlign.left,
                    style: boldTextStyle.copyWith(
                      fontSize: 16,
                      color: kBlackColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Posted by ",
                        style: lightTextStyle.copyWith(
                          fontSize: 10,
                        ),
                      ),
                      Expanded(
                        // Added Expanded widget here
                        child: Text(
                          recipe.userName,
                          style: boldTextStyle.copyWith(
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipe.description,
                    maxLines: 4,
                    style: regularTextStyle.copyWith(
                      fontSize: 9,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
