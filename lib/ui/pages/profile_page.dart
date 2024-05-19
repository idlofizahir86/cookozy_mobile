import 'package:cookozy_mobile/ui/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/theme.dart';
import '../widgets/setting_item_card.dart';

final Uri whatsappUrl = Uri.parse("https://wa.me/6285173044086");
Future<void> _launchWhatsApp() async {
  if (!await launchUrl(whatsappUrl)) {
    throw Exception('Could not launch $whatsappUrl');
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Fungsi untuk membuka WhatsApp

  @override
  Widget build(BuildContext context) {
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
                          image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/cookozy-if4506.appspot.com/o/Assets%2Favatar.webp?alt=media&token=8fab0c44-9448-4858-a5fc-cd9ce0775526",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nana Tobeng",
                          style: boldTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/search");
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
                onTap: () {},
              ),
              SettingItemCard(
                title: "Chat Us",
                onTap: (){}
                // _launchWhatsApp,
              ),
              SettingItemCard(
                title: "About Us",
                onTap: () {},
              ),
              CustomButtonWidget(
                title: "Keluar",
                color: kPrimaryColor,
                onTap: () {},
                titleColor: kWhiteColor,
                icon: "assets/icons/icon_logout.png",
              )
            ],
          ),
        ),
      ),
    );
  }
}
