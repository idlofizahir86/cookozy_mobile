import '../widgets/all_recipe_list.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/top_section_widget.dart';

class AllRecipePage extends StatelessWidget {
  const AllRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Stack(
          children: [
            const TopSectionWidget(
              title: "Semua Resep",
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // padding: const EdgeInsets.all(
                  //     16.0), // Tambahkan padding jika diperlukan
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/search");
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const CustomSearchBar(
                            enabled: false,
                          ),
                        ),
                      ),
                      AllRecipeList(),
                      SizedBox(
                        height: 70,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
