import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../../service/user_service.dart';
import '../widgets/custom_detail_profile.dart';
import '../widgets/top_section_widget.dart';
import '/shared/theme.dart';

class LihatProfilePage extends StatelessWidget {
  final String userId;

  const LihatProfilePage({Key? key, required this.userId}) : super(key: key);

  Future<UserModel?> getUserData(String userId) async {
    final userService = UserService(); // Membuat objek UserService
    return await userService.getUserData(
        userId); // Memanggil metode getUserData dari objek userService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel?>(
        future: getUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('User data not found.'));
          } else {
            final user = snapshot.data!;
            return Scaffold(
              backgroundColor: kWhiteColor,
              body: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 35),
                      const TopSectionWidget(
                        title: "Detail Profile",
                        back: true,
                      ),
                      Container(
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    user.imageUrl,
                                  ),
                                ),
                              ),
                            ),

                            // Menambahkan CustomTextDisplayField untuk menampilkan informasi profil

                            CustomTextDisplayField(
                              title: "Nama",
                              value: user.nama,
                            ),
                            CustomTextDisplayField(
                              title: "Email",
                              value: user.email,
                            ),
                            CustomTextDisplayField(
                              title: "Role",
                              value: user.role,
                            ),

                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
