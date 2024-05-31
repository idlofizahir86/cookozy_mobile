import 'package:cookozy_mobile/ui/pages/recipes/recipe_upload_page.dart';
import 'package:cookozy_mobile/ui/widgets/all_recipe_list.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../service/user_service.dart';
import '../../shared/theme.dart';
import '../widgets/top_section_widget.dart';

class HistoryPage extends StatelessWidget {
  final String userId;
  const HistoryPage({
    super.key,
    required this.userId,
  });

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
                            AllRecipeList(userId: userId),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeUploadPage(
                        userId: userId,
                      ),
                    ),
                  );
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

Future<UserModel?> getUserData(String userId) async {
  final userService = UserService(); // Membuat objek UserService
  return await userService.getUserData(
      userId); // Memanggil metode getUserData dari objek userService
}
