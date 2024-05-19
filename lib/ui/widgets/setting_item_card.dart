import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class SettingItemCard extends StatelessWidget {
  final String title;
  final Function() onTap;

  const SettingItemCard({super.key, required this.title, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68,
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 15,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 23,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1.0,
            color: kSilverColor,
          ),
        ),
        child: Text(
          title,
          style: boldTextStyle.copyWith(
            fontSize: 16,
            color: kBlackColor,
          ),
        ),
      ),
    );
  }
}
