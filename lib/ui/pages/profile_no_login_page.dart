import 'package:cookozy_mobile/ui/pages/chat_us_page.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/setting_item_card.dart';

class ProfileNoLoginPage extends StatelessWidget {
  const ProfileNoLoginPage({
    super.key,
  });

  // Fungsi untuk membuka WhatsApp

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingItemCard(
                  title: "Chat Us",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatUsPage()),
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
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    "Untuk mengakses aplikasi secara penuh anda perlu login ke dalam aplikasi",
                    style: semiBoldTextStyle.copyWith(
                      fontSize: 16,
                      color: kBlackColor,
                    ),
                  ),
                ),
                CustomButtonWidget(
                  title: "LOGIN",
                  color: kSecondaryColor,
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  titleColor: kWhiteColor,
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                  title: "REGISTER",
                  color: kSecondaryColor,
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  titleColor: kWhiteColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
