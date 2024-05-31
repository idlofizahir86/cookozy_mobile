import 'dart:async';
import 'package:cookozy_mobile/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/theme.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      try {
        final userId = UserService().parseJwt(token)['user_id'];
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(userId: userId),
              ),
            );
          },
        );
      } catch (e) {
        // Jika terjadi kesalahan saat parsing token, anggap token tidak valid
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    } else {
      // Jika token null atau kosong, arahkan ke halaman /onboarding
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacementNamed(context, '/onboarding');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: Image.asset("assets/cookozy-logo.png"),
            ),
            const SizedBox(height: 6),
            Text(
              "by ABP Cookozy",
              style: regularTextStyle.copyWith(
                fontSize: 21,
                fontStyle: FontStyle.italic,
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
