import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "HALAMAN \nROFILE",
          style: boldTextStyle.copyWith(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
