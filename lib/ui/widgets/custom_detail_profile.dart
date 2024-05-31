import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomTextDisplayField extends StatelessWidget {
  final String title;
  final String? value;
  final bool obscureText;

  const CustomTextDisplayField({
    Key? key,
    required this.title,
    this.value,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: boldTextStyle.copyWith(
              fontSize: 14,
              color: kBlackColor,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: kSilver2Color,
                width: 2,
              ),
            ),
            child: Text(
              obscureText ? '●●●●●●●●' : value ?? '',
              style: semiBoldTextStyle.copyWith(
                fontSize: 14,
                color: kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
