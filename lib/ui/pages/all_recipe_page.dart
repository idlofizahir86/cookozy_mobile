import 'package:cookozy/shared/theme.dart';
import 'package:flutter/material.dart';

class AllRecipePage extends StatelessWidget {
  const AllRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "HALAMAN \nSEMUA RESEP",
          style: boldTextStyle.copyWith(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
