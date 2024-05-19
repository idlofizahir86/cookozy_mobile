import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final double width;
  final Color color;
  final Color titleColor;
  final String icon;
  final Function() onTap;

  const CustomButtonWidget({
    super.key,
    required this.title,
    this.width = double.infinity,
    required this.color,
    required this.onTap,
    required this.titleColor,
    this.icon = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: boldTextStyle.copyWith(
                  fontSize: 16,
                  color: titleColor,
                ),
              ),
            ),
            icon == ""
                ? Container()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(
                        right: 4,
                      ),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            icon,
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
