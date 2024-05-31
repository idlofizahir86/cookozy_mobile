import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class DayWidget extends StatelessWidget {
  final bool isLogin;
  const DayWidget({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String greeting = '';
    String iconAsset = '';

    if (now.hour >= 0 && now.hour < 11) {
      greeting = "Selamat Pagi";
      iconAsset = 'assets/icons/icon_sun.png';
    } else if (now.hour >= 11 && now.hour < 15) {
      greeting = "Selamat Siang";
      iconAsset = 'assets/icons/icon_sun.png';
    } else if (now.hour >= 15 && now.hour < 18) {
      greeting = "Selamat Sore";
      iconAsset = 'assets/icons/icon_sun.png';
    } else {
      greeting = "Selamat Malam";
      iconAsset = 'assets/icons/icon_sun.png';
    }

    return Container(
      child: isLogin
          ? Row(
              children: [
                Image.asset(
                  iconAsset,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  greeting,
                  style: mediumTextStyle.copyWith(
                    fontSize: 14,
                    color: kBlackColor,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  iconAsset,
                  width: 24,
                  height: 24,
                ),
                Text(
                  greeting,
                  style: mediumTextStyle.copyWith(
                    fontSize: 20,
                    color: kBlackColor,
                  ),
                ),
              ],
            ),
    );
  }
}
