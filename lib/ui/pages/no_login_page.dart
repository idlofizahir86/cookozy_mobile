import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widgets/top_section_widget.dart';

class NoLoginPage extends StatelessWidget {
  const NoLoginPage({super.key});

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
                  title: "Anda Belum Login",
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 201,
                                child: Image.asset(
                                  "assets/cook_onboard.png",
                                ),
                              ),
                              SizedBox(
                                height: 79,
                                child: Image.asset(
                                  "assets/cookozy-logo.png",
                                ),
                              ),
                              Text(
                                "Anda belum melakukan login ke dalam aplikasi",
                                style: boldTextStyle.copyWith(
                                  fontSize: 20,
                                  color: kSecondaryColor,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Untuk mengakses halaman \"Histori Resep\" anda perlu login ke dalam aplikasi",
                                style: semiBoldTextStyle.copyWith(
                                  fontSize: 16,
                                  color: kBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
