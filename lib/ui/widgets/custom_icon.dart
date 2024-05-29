
import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomIcon extends StatelessWidget {
  final String iconUrl;
  final Function() onTap;

  const CustomIcon({
    super.key,
    required this.iconUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: kWhiteColor,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                iconUrl,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}