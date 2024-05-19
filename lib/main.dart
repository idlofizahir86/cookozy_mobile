import '../../cubit/search_cubit.dart';
import '../../ui/pages/main_page.dart';
import '../../ui/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/pages/onboarding_page.dart';
import '../../ui/pages/splash_page.dart';
import 'package:flutter/material.dart';

import 'cubit/page_cubit.dart';

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
        },
      ),
    );
  }
}
