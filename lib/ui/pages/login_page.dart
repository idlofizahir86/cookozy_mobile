import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_textformfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key,});

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  // Tambahkan GlobalKey untuk form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Gunakan GlobalKey pada Form
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
                            Navigator.pushNamed(context, '/');
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
                          // Tambahkan logika login di sini jika validasi sukses
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
    );
  }
}
