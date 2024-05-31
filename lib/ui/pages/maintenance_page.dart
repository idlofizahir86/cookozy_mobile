import 'package:cookozy_mobile/shared/theme.dart';
import 'package:cookozy_mobile/ui/pages/chat_us_page.dart';
import 'package:flutter/material.dart';
import '../widgets/top_section_widget.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 35),
                const TopSectionWidget(
                  title: "Under Maintenance",
                  back: true,
                ),
                SizedBox(height: 20),
                Center(
                    child: Container(
                  height: 315,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/maintenance.png',
                      ),
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                    top: 40,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    "SORRY GESS LUPA SETTING API NYA",
                    style: boldTextStyle.copyWith(
                      fontSize: 16,
                      color: kRedColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    "Untuk saat ini jika ingin mengubah data akun anda, silakan hubungki kami melalui fitur",
                    style: semiBoldTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatUsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "\"Chat Us\"",
                      style: semiBoldTextStyle.copyWith(
                        fontSize: 16,
                        color: kSecondaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: kSecondaryColor,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
