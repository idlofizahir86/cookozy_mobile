import 'package:cookozy_mobile/ui/pages/profile_no_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/page_cubit.dart';
import '../../shared/theme.dart';
import './dashboard_page.dart';
import 'no_login_page.dart';
import 'recipes/all_recipe_page.dart';
import './history_page.dart';
import './profile_page.dart';

import '../widgets/custom_bottom_navigation_item.dart';

class MainPage extends StatelessWidget {
  final String? userId;
  const MainPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return DashboardPage(
            userId: userId.toString(),
          );
        case 1:
          return const AllRecipePage();
        case 2:
          // Cek apakah userId tidak null
          if (userId != null && userId!.isNotEmpty) {
            return HistoryPage(userId: userId!);
          } else {
            return const NoLoginPage();
          }
        case 3:
        if (userId != null && userId!.isNotEmpty) {
            return ProfilePage(userId: userId!);
          } else {
            return const ProfileNoLoginPage();
          }
          
        default:
          return DashboardPage(userId: userId!);
      }
    }

    Widget customBottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: const [
              BoxShadow(
                color:
                    Color.fromRGBO(0, 0, 0, 10), // 25% hitam, // Warna shadow
                offset: Offset(0, 4), // Posisi shadow (X, Y)
                blurRadius: 20, // Radius blur
                spreadRadius: 0, // Jarak penyebaran shadow
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigationItem(
                index: 0,
                itemName: "dashboard",
              ),
              CustomBottomNavigationItem(
                index: 1,
                itemName: "all_recipe",
              ),
              CustomBottomNavigationItem(
                index: 2,
                itemName: "history",
              ),
              CustomBottomNavigationItem(
                index: 3,
                itemName: "profile",
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: Stack(children: [
            buildContent(currentIndex),
            customBottomNavigation(),
          ]),
        );
      },
    );
  }
}
