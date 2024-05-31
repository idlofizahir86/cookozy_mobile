import 'package:cookozy_mobile/model/recipe_model.dart';
import 'package:flutter/material.dart';
import '../../../model/recipe_detail_model.dart';
import '../../../service/recipe_service.dart';
import '../../../shared/theme.dart';
import '../../widgets/custom_icon.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();
    fetchDetailRecipe(widget.recipe.id);
  }

  Future<RecipeDetailModel> fetchDetailRecipe(String recipeId) async {
    return await RecipeService().fetchRecipeDetail(recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<RecipeDetailModel>(
          future: RecipeService().fetchRecipeDetail(widget.recipe.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Column(
                  children: [
                    Text('wid'),
                    Text('Failed to load recipe detail.'),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              final recipeDetail = snapshot.data!;
              return Stack(
                children: [
                  backgroundImage(recipeDetail.imageUrl, recipeDetail.verified),
                  ListView(
                    children: [
                      const SizedBox(height: 350),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 23,
                          right: 23,
                        ),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipeDetail.title,
                              style: boldTextStyle.copyWith(
                                fontSize: 16,
                                color: kBlackColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                detailContainer(widget.recipe.type),
                                detailContainer(widget.recipe.level),
                              ],
                            ),
                            const SizedBox(height: 25),
                            userInfo(recipeDetail.userImage,
                                recipeDetail.userName, recipeDetail.timeStamp),
                            const SizedBox(height: 10),
                            Text(
                              recipeDetail.description,
                              textAlign: TextAlign.justify,
                              style: regularTextStyle.copyWith(
                                fontSize: 14,
                                color: kBlackColor,
                              ),
                            ),
                            const SizedBox(height: 30),
                            IngredientsWidget(
                                ingredients: recipeDetail.ingredients),
                            const SizedBox(height: 30),
                            StepsWidget(steps: recipeDetail.steps),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 35,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIcon(
                          iconUrl: "assets/icons/icon_arrow_back.png",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget backgroundImage(String imageUrl, bool verified) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 450,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
        if (verified)
          Container(
            padding: const EdgeInsets.only(
              top: 35,
              right: 20,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 76, 175, 79),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  "Verified",
                  style: semiBoldTextStyle.copyWith(
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.only(
              top: 35,
              right: 20,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 171, 73, 73),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  "Not Verified",
                  style: semiBoldTextStyle.copyWith(
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget detailContainer(String text) {
    return Container(
      height: 38,
      width: 160,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: regularTextStyle.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }

  Widget userInfo(String imageUrl, String userName, String timeStamp) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: boldTextStyle.copyWith(
                fontSize: 16,
                color: kBlackColor,
              ),
            ),
            Text(
              "Posted on $timeStamp",
              style: boldTextStyle.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: kBlackColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IngredientsWidget extends StatelessWidget {
  final String ingredients;

  const IngredientsWidget({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bahan-bahan:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          ingredients,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class StepsWidget extends StatelessWidget {
  final String steps;

  const StepsWidget({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    List<String> stepList = steps.split("\r\n");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Langkah-langkah:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stepList
              .asMap()
              .entries
              .map(
                (entry) => ListTile(
                  leading: CircleAvatar(
                    child: Text((entry.key + 1).toString()),
                  ),
                  title: Text(
                    entry.value,
                    textAlign: TextAlign.justify,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
