import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_textformfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

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
                    title: "Nama*",
                    obscureText: true,
                    hintText: "Masukkan nama anda",
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      } else if (value.length < 2) {
                        return 'Nama harus setidaknya 2 karakter';
                      }
                      return null;
                    },
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
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButtonWidget(
                      title: "Register",
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
                        "Sudah punya akun?",
                        style: regularTextStyle.copyWith(
                          fontSize: 12,
                          color: kSecondaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/logn');
                        },
                        child: Text(
                          " Login Sekarang",
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
