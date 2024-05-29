import '../../widgets/all_recipe_list.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/top_section_widget.dart';

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
              margin: const EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0), // Tambahkan padding jika diperlukan
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/search");
                        },
                        child: const CustomSearchBar(
                          enabled: false,
                        ),
                      ),
                      const AllRecipeList(),
                      const SizedBox(
                        height: 80,
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
