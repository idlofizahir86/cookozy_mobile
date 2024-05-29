import '../../ui/pages/login_page.dart';
import '../../ui/pages/recipes/makanmalam_recipe_page.dart';
import '../../ui/pages/recipes/makansiang_recipe_page.dart';
import '../../ui/pages/recipes/sarapan_recipe_page.dart';
import '../../ui/pages/register_page.dart';

import '../../cubit/search_cubit.dart';
import '../../ui/pages/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/pages/onboarding_page.dart';
import '../../ui/pages/splash_page.dart';
import 'package:flutter/material.dart';

import 'cubit/page_cubit.dart';
import 'ui/pages/recipes/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/onboarding': (context) => const OnBoardingPage(),
          '/main': (context) => const MainPage(),
          '/search': (context) => const SearchPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/menu-sarapan': (context) => const SarapanRecipePage(),
          '/menu-siang': (context) => const MakanSiangRecipePage(),
          '/menu-malam': (context) => const MakanMalamRecipePage(),
        },
      ),
    );
  }
}
