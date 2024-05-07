import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonText; // Tambahkan parameter untuk menerima teks tombol

  const CustomButtonWidget({Key? key, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          buttonText, // Gunakan nilai teks yang diterima dari parameter
          style: boldTextStyle.copyWith(
            fontSize: 16,
            color: kAccentColor,
          ),
        ),
      ),
    );
  }
}
