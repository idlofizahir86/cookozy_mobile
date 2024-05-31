import 'package:cookozy_mobile/ui/pages/chat_us_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_textformfield.dart';
import '../../service/user_service.dart';
import '../widgets/top_section_widget.dart';
import 'main_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    final userService = UserService();
    final token = await userService.login(
        email, password); // Mendapatkan token dari server
    // final parseJwt = userService.parseJwt(token.toString());

    if (token != null) {
      // Berhasil login, token disimpan ke SharedPreferences dan navigasi ke halaman berikutnya
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'token', token); // Token disimpan ke SharedPreferences
      final userId = userService.parseJwt(token)['user_id'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MainPage(userId: userId), // Kirim userId sebagai argument
        ),
      );
    } else {
      // Gagal login, tampilkan pesan kesalahan
      _showErrorDialog(context, 'Login failed: Please check your credentials.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 60),
              TopSectionWidget(
                title: "",
                back: true,
              ),
            ],
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "LOGIN",
                        style: boldTextStyle.copyWith(
                          color: kBlackColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        title: "Email*",
                        hintText: "Masukkan email anda",
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          } else if (!value.contains('@')) {
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        title: "Password*",
                        obscureText: true,
                        hintText: "Masukkan password sandi anda",
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (value.length < 8) {
                            return 'Password harus setidaknya 8 karakter';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatUsPage()),
                                );
                              },
                              child: Text(
                                "Lupa Password?",
                                style: regularTextStyle.copyWith(
                                  fontSize: 12,
                                  color: kRedColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButtonWidget(
                          title: "Login",
                          color: kPrimaryColor,
                          titleColor: kWhiteColor,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _login(context);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tidak punya akun?",
                            style: regularTextStyle.copyWith(
                              fontSize: 12,
                              color: kSecondaryColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              " Daftar Sekarang",
                              style: regularTextStyle.copyWith(
                                fontSize: 12,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
