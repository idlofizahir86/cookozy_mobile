import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> _saveProfile() async {
    // Simpan profil menggunakan SharedPreferences atau API
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('displayName', nameController.text);
    await prefs.setString('email', emailController.text);
    // Tampilkan pesan sukses atau gagal
  }

  Future<void> _updatePassword() async {
    // Perbarui password menggunakan API atau metode lainnya
    if (newPasswordController.text == confirmPasswordController.text) {
      // Lakukan operasi perubahan password
      // Tampilkan pesan sukses atau gagal
    } else {
      // Tampilkan pesan kesalahan bahwa password tidak cocok
    }
  }

  Future<void> _deleteAccount() async {
    // Hapus akun menggunakan API atau metode lainnya
    // Tampilkan pesan sukses atau gagal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Information Section
              Text(
                'Profile Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Update your account's profile information and email address. When you change your email, you need to verify your email else the account will be blocked.",
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text('Save'),
                ),
              ),
              Divider(height: 32),

              // Update Password Section
              Text(
                'Update Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Ensure your account is using a long, random password to stay secure.',
              ),
              SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _updatePassword,
                  child: Text('Save'),
                ),
              ),
              Divider(height: 32),

              // Delete Account Section
              Text(
                'Delete Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Permanently delete your account. Once your account is deleted, all of its resources and data will be permanently deleted. Before deleting your account, please download any data or information that you wish to retain.',
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: _deleteAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Background color
                  ),
                  child: Text('Delete Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
