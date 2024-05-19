import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class TopSectionWidget extends StatelessWidget {
  final String title;
  final bool back;

  const TopSectionWidget({
    super.key,
    required this.title,
    this.back = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          back
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 20,
                      width: 24,
                      margin: const EdgeInsets.only(
                        left: 20,
                      ),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/icon_arrow_back.png"),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: boldTextStyle.copyWith(
                fontSize: 16,
                color: kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
