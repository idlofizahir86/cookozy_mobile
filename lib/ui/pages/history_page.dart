import 'package:cookozy_mobile/ui/widgets/all_recipe_list.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widgets/top_section_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopSectionWidget(
                  title: "Histori Resep",
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const AllRecipeList(),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 70,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  // Tambahkan logika untuk tombol di sini
                },
                backgroundColor: kSecondaryColor,
                child: Icon(
                  Icons.add,
                  color: kWhiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
