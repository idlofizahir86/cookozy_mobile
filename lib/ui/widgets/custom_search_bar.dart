import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomSearchBar extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final String hintText;

  const CustomSearchBar(
      {super.key,
      this.enabled = true,
      this.controller,
      this.onSubmitted,
      this.hintText = "Temukan resep luar biasa"});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      height: 50,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        onFieldSubmitted: onSubmitted,
        cursorColor: kBlackColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: regularTextStyle.copyWith(
            fontSize: 14,
            color: kSilverColor,
          ),
          prefixIcon: Image.asset("assets/icons/icon_search.png"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: kSilverColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
