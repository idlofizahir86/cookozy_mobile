import 'package:cookozy_mobile/model/user_model.dart';
import 'package:cookozy_mobile/ui/pages/main_page.dart';
import 'package:cookozy_mobile/ui/pages/maintenance_page.dart';

import '../../service/user_service.dart';
import '../widgets/recipe_list.dart';
import 'package:flutter/material.dart';

import '../widgets/banner_carousel.dart';
import '../widgets/day_widget.dart';
import '../../shared/theme.dart';
import 'maintenance_notif_page.dart';

class DashboardPage extends StatelessWidget {
  final String userId;
  const DashboardPage({super.key, required this.userId});

  Future<void> _refreshData(BuildContext context) async {
    // Tempatkan logika untuk memuat ulang data di sini
    // Misalnya, panggil fungsi atau metode untuk memuat ulang data

    // Contoh:
    await Future.delayed(const Duration(seconds: 2)); // Simulasi penundaan

    // Navigasi kembali ke halaman DashboardPage atau route '/main'
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          userId: userId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: RefreshIndicator(
          onRefresh: () async {
            await _refreshData(context); // Panggil fungsi _refreshData
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: headerDasboard(context, userId),
                ),
                const SizedBox(height: 10),
                const BannerCarousel(),

                // SARAPAN
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Menu Sarapan",
                        style: semiBoldTextStyle.copyWith(
                            fontSize: 20, color: kBlackColor),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/menu-sarapan",
                          );
                        },
                        child: Text(
                          "Lihat Semua",
                          style: semiBoldTextStyle.copyWith(
                            fontSize: 14,
                            color: kSilverColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const RecipeList(recipeType: "Sarapan"),

                // MAKAN SIANG
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Menu Makan Siang",
                        style: semiBoldTextStyle.copyWith(
                            fontSize: 20, color: kBlackColor),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/menu-siang",
                          );
                        },
                        child: Text(
                          "Lihat Semua",
                          style: semiBoldTextStyle.copyWith(
                            fontSize: 14,
                            color: kSilverColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const RecipeList(recipeType: "Makan Siang"),

                // MAKAN MALAM
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Menu Makan Malam",
                        style: semiBoldTextStyle.copyWith(
                            fontSize: 20, color: kBlackColor),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/menu-malam",
                          );
                        },
                        child: Text(
                          "Lihat Semua",
                          style: semiBoldTextStyle.copyWith(
                            fontSize: 14,
                            color: kSilverColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const RecipeList(recipeType: "Makan Malam"),

                const SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget headerDasboard(BuildContext context, String userId) {
  return FutureBuilder<UserModel?>(
    future: getUserData(userId), // Panggil fungsi getUserData
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(); // Menampilkan indikator loading jika data sedang dimuat
      } else if (snapshot.hasError) {
        return Text(
            'Error: ${snapshot.error}'); // Menampilkan pesan kesalahan jika terjadi kesalahan
      } else {
        final userData = snapshot.data!; // Mendapatkan UserModel dari snapshot

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 165,
                  child: userData.nama == ''
                      ? Column(
                          children: [
                            DayWidget(isLogin: false),
                          ],
                        )
                      : Column(
                          children: [
                            DayWidget(isLogin: true),
                            Text(
                              userData
                                  .nama, // Menggunakan data nama pengguna dari UserModel
                              style: semiBoldTextStyle.copyWith(
                                fontSize: 24,
                                color: kBlackColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSilver3Color,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/icons/icon_search.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaintenanceNotifPage()),
                      );
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSilver3Color,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/icons/icon_notif.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    },
  );
}

Future<UserModel?> getUserData(String userId) async {
  return await UserService().getUserData(userId);
}
