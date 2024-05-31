import 'package:cookozy_mobile/shared/theme.dart';
import 'package:cookozy_mobile/ui/pages/chat_us_page.dart';
import 'package:flutter/material.dart';
import '../widgets/top_section_widget.dart';

class MaintenanceNotifPage extends StatelessWidget {
  const MaintenanceNotifPage({super.key});

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
                    "Untuk saat ini halaman ini masih dalam pengembangan",
                    style: semiBoldTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
