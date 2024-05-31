import 'package:cookozy_mobile/ui/pages/main_page.dart';

import '../widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAccentColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
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
                ],
              ),
            ),
            const SizedBox(height: 84),
            Text(
              "Bagikan dan temukan resep\nsehat sesuai budget kamu\ndi sini",
              style: regularTextStyle.copyWith(
                fontSize: 21,
                fontStyle: FontStyle.italic,
                color: kSecondaryColor,
              ),
            ),
            const SizedBox(height: 84),
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(
                      userId: '',
                    ),
                  ),
                );
              },
              child: Text(
                "Lewati",
                style: boldTextStyle.copyWith(
                  color: kSecondaryColor,
                  fontSize: 21,
                  decoration: TextDecoration.underline,
                  decorationColor: kSecondaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ));
  }
}
