import '../../widgets/all_recipe_list.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/top_section_widget.dart';

class MakanSiangRecipePage extends StatelessWidget {
  const MakanSiangRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Stack(
          children: [
            const TopSectionWidget(
              title: "Menu Makan Siang",
              back: true,
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
                      const AllRecipeList(
                        type: "Makan Siang",
                      ),
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
