import 'dart:io';

import 'package:cookozy_mobile/ui/pages/akun_page.dart';
import 'package:cookozy_mobile/ui/pages/chat_us_page.dart';
import 'package:cookozy_mobile/ui/pages/lihat_profile_page.dart';
import 'package:cookozy_mobile/ui/pages/maintenance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/page_cubit.dart';
import '../../model/user_model.dart';
import '../../service/user_service.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/setting_item_card.dart';

whatsapp() async {
  String contact = "6285173044086";
  String text = "Nama:%0AEmail:%0APesan/Masalah:";
  String androidUrl = "whatsapp://send?phone=$contact&text=$text";
  String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

  String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

  try {
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(iosUrl))) {
        await launchUrl(Uri.parse(iosUrl));
      }
    } else {
      if (await canLaunchUrl(Uri.parse(androidUrl))) {
        await launchUrl(Uri.parse(androidUrl));
      }
    }
  } catch (e) {
    print('object');
    await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
  }
}

class ProfilePage extends StatelessWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  // Fungsi untuk membuka WhatsApp

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: getUserData(userId), // Panggil fungsi getUserData
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // Menampilkan indikator loading jika data sedang dimuat
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Menampilkan pesan kesalahan jika terjadi kesalahan
          } else {
            final userData =
                snapshot.data!; // Mendapatkan UserModel dari snapshotSafeArea(
            return SafeArea(
              child: Scaffold(
                backgroundColor: kWhiteColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(userData.imageUrl),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData.nama,
                                  style: boldTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LihatProfilePage(
                                            userId: userData.id),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Lihat Profil",
                                    style: regularTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SettingItemCard(
                        title: "Pengaturan Akun",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MaintenancePage()),
                          );
                        },
                      ),
                      SettingItemCard(
                        title: "Chat Us",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatUsPage()),
                          );
                        },
                      ),
                      SettingItemCard(
                        title: "About Us",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/about",
                          );
                        },
                      ),
                      CustomButtonWidget(
                        title: "Keluar",
                        color: kPrimaryColor,
                        onTap: () => logout(context),
                        titleColor: kWhiteColor,
                        icon: "assets/icons/icon_logout.png",
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  // Hapus token dari SharedPreferences
  await prefs.remove('token');

  // Hapus searchHistory dari SharedPreferences
  await prefs.remove('searchHistory');

  // Reset current index di PageCubit
  context.read<PageCubit>().resetPage();

  Navigator.pushNamedAndRemoveUntil(
      context, '/onboarding', (route) => false); // Navigasi ke halaman login
}

Future<UserModel?> getUserData(String userId) async {
  final userService = UserService(); // Membuat objek UserService
  return await userService.getUserData(
      userId); // Memanggil metode getUserData dari objek userService
}
