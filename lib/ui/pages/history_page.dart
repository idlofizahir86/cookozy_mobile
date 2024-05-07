import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "HALAMAN \nHISTORY RESEP",
          style: boldTextStyle.copyWith(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
